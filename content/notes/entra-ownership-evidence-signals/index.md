---
title: "Field Note: Service Principal Ownership Evidence Signals"
date: 2026-06-22
slug: "entra-ownership-evidence-signals"
description: "A practical note about evidence signals used to infer accountable owners for Entra service principals and managed identities."
warning: "Always verify current Microsoft documentation before treating these notes as implementation guidance."
---

## Where owner evidence can sit in Entra

**Service principal owners**

Good first signal, but weak operationally. SP owners are users or service principals, not durable ownership groups. A named user can leave, move teams, or lose context.
![Service Principal Owner](sp_owner.png)


**Cloud Application Administrator**

Useful admin context. This role can manage app registrations and enterprise apps, but it usually points to operators, not accountable workload owners.

![Cloud Application Administrator](2026-06-22_16-46.png)

**Service principal tags**

Useful hidden metadata. SP tags are not exposed well in Azure Portal, but are easy to pull from Microsoft Graph PowerShell.

```powershell
Get-MgServicePrincipal -ServicePrincipalId $spId -Property "id,displayName,tags" |
  Select DisplayName, Id, @{n="Tags";e={$_.Tags -join ", "}}
```

**Custom security attributes**

Stronger metadata than tags. Visibility and assignment can be controlled, but setup needs the right attribute roles and Graph permissions.

Required:
Entra role: Attribute Assignment Reader
Graph scope: CustomSecAttributeAssignment.Read.All

```powershell
Get-MgServicePrincipal `                                                  
  -ConsistencyLevel eventual `
  -CountVariable CountVar `   
  -Property "id,displayName,appId,servicePrincipalType,customSecurityAttributes" `
  -Filter "customSecurityAttributes/Ownership/test ne null" |
Select-Object Id, DisplayName, AppId, ServicePrincipalType, CustomSecurityAttributes
```
