Return-Path: <linux-kselftest+bounces-23520-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 126E49F6C2E
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 18:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FC4016E17A
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 17:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA111F8AF6;
	Wed, 18 Dec 2024 17:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NAwKDPS3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612C1198E63;
	Wed, 18 Dec 2024 17:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734542257; cv=fail; b=SrAbhGPDM8SAAByGwZWIIzZC2JNfArXB+kezAojFXfoNppQn7lmXcf4xO39jg6Pq4q6cAcWeM+bk4nDW60/k6FPtnXyxS/L6gg4o6VtaHJXjjqokO1YuwY58e1ZGOQJITnCQ1oL3xaT+gOEy8bDY/wVSxFrBJsc3ONoguq7WsX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734542257; c=relaxed/simple;
	bh=72Tj6F35N+teTQfR6KLHIPnuOkxI2m2/DPmwIz5o2e4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gZXXxMiuCfxq4xOdfKllYcjaKKNuVDinBfGTR8OcR/WbSQmtPPbpQ4q92qwdmNq0kIy2B1jJ48FX5vlV92f93j92t+79rrOv6OvDj0paiqPdQmuiy0z2f7godrwZ7s/yINc9cGaBMhN8Zm671ArC+Nyfl91DNUJqHbWfx1xJeHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NAwKDPS3; arc=fail smtp.client-ip=40.107.94.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J3BXf3iFYNMLhkhc8dRN7Tla5qxdvJxdEnPmzambp21tzzJe4qbnM0TtrCt44rXEw1CCPmZysDlMepRRcUI1WSawdIURFV7IzFcsmhIZWI/z9h2AtuSFWgH65r401r/TPPaFm6yLefygNBGuuYw9xoKp67E63t1aYRttSXl2WUX/BCbeQ4K5mpYsfcg8lWFhAiS+TUltumuIjmZ6kH/sMSwB0qChXZsiBW8XJDspx5hJga8VrUszi7F5loiUas8xbaGh5TziLRs6HnooWudIn/jioZs+sZlZUjOKbcboC4OC3K98UqF6+2pcSvqtzJ++RMg5zpjB+KpwSyC50TSpEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bkjvYXJjPuGyltjZxXeHun2wjq05wcX06Rjey/K9d3g=;
 b=jvbh5RXQEeXzj37BcF48BaujdT2JcqPImUWRzF87g3ZEuyzv/Nc5xET2iYAigGccF3/InE4J2lDplmgMHgH1StOU3kPOSTkKJA1jC59GZ6cpdAfMKV1QSyWxJbyQKMso1MXen4ujXNjljpaW+20Vul+/1kmvKSqBkMIloYZXg1tQeGv+UXC5wJXgBDHMQDtE/F/U3sgYIopLKfMdtt/ksq1epsM5IKt9MZ/nwlldEb6uoMsr95sjPN9DrAkvO3xoiPUqWKBrTgn9UCP6pkqQbBsBST8fHEvXsfWVjfXbDb4s4jvO9N/nA1pSBoqR7blP2in9iVa1gCNEBmij8Pvkig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bkjvYXJjPuGyltjZxXeHun2wjq05wcX06Rjey/K9d3g=;
 b=NAwKDPS3tLL27PAJV3EzJDsNPNmJ6X4LBzfCje7ITV3bMOT9mT9Qk+oGSPlLF2dhk+ON/FPgHn1XnvNOxZb17p0nHQ+bEgbHt0sWRDi6QdrQLuUtDZKGOpxEphNvLD/aUJLvdi1T14dyTU28XMkJECLZaA8rTssneE9duvrtcD3JDE22ZI6IbnJdemCVfAWqjQeQkEgY2QwJMnLhM5vZgSOxXJmTbJtUHVmZj2C2OfOQnurq/5l0EwqAsEQV7Y4dn+T78hwo5KE4qFPZFS58qDRmUuA4ijgLjjukaxNEACykAKD8I94VZYa1qBChu00jMi6gUgTmIBIYHMJ6xqKDhg==
Received: from SJ0PR05CA0168.namprd05.prod.outlook.com (2603:10b6:a03:339::23)
 by DM6PR12MB4299.namprd12.prod.outlook.com (2603:10b6:5:223::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.19; Wed, 18 Dec
 2024 17:17:32 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:a03:339:cafe::4b) by SJ0PR05CA0168.outlook.office365.com
 (2603:10b6:a03:339::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.20 via Frontend Transport; Wed,
 18 Dec 2024 17:17:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8293.6 via Frontend Transport; Wed, 18 Dec 2024 17:17:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 18 Dec
 2024 09:17:09 -0800
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 18 Dec
 2024 09:17:03 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Roopa Prabhu <roopa@nvidia.com>, "Nikolay
 Aleksandrov" <razor@blackwall.org>, <bridge@lists.linux.dev>, Ido Schimmel
	<idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, <mlxsw@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next 3/4] selftests: net: lib: Add a couple autodefer helpers
Date: Wed, 18 Dec 2024 18:15:58 +0100
Message-ID: <856d9e01725fdba21b7f6716358f645b19131af2.1734540770.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1734540770.git.petrm@nvidia.com>
References: <cover.1734540770.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|DM6PR12MB4299:EE_
X-MS-Office365-Filtering-Correlation-Id: ada83f6e-4b62-4a51-2954-08dd1f87d9f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zcLyptPMcDpZd39jxtuV1uerCzV50w4gn7LYS1zWatQKPDrYfTBpsLhVXzne?=
 =?us-ascii?Q?qz7xmOjFE0Ky7Mpcjwz4pg/RVpkdvh3yiFI5SFPnYbjBhvI/O8FcDBFProIU?=
 =?us-ascii?Q?MxkuyFOvAx0GB6C5yzMarM0imDFih4bWqqH/DZQM4HHUwa1coanFme+Bg28o?=
 =?us-ascii?Q?NI3F1cNtGpaExyroPzprFEJ8UnwKZrfDu+WXu6VCsrombZMix+ORLO1k7J3K?=
 =?us-ascii?Q?VSsvZGvtpmvJ7oMO0ks60R8SFCY6KbKvrNSUzTzMiqW6zNc9+jn+GWc17fNN?=
 =?us-ascii?Q?STaGL9Z5btMe0vo2wshBhfq7bgfyhjqHZ937e1rOobbNS/MWNFbK7ezeOxm9?=
 =?us-ascii?Q?XtktZojHqGiBBYkmvYt8haUsNIB6Po9jtaMMvjJ/nr71SCZq5qLYvOCLUoas?=
 =?us-ascii?Q?oQrKCHKUNkzfO/2SChj+kb87Vt5QgxkBRG0LTd+Ay1XNfj1E05LeDYGqaUx6?=
 =?us-ascii?Q?pOQtdo42eGKhZDn7eolYcRbIb/qkvz2J7A6NQo0W61Ogl7Dvib0tN+PwIVni?=
 =?us-ascii?Q?+9ud6AagTIOC1I9a7I1Fo3X3mVSDdplIa8j5eN53HCgYQO6HrAnQ1WcsGye2?=
 =?us-ascii?Q?cmot3BfKpzUQv+Pi7F5LL/4fwaIpjKLJlr9TSs/0dz78BRk1PIY+gUlnUHDW?=
 =?us-ascii?Q?2rZeq+UuMCIZT16qF9LlCdK2I43Lt6xvxlpZq6OM9VaESC9ppttFM2BZvaPq?=
 =?us-ascii?Q?3Y8zpqm+RPG4YKx2qxEZDSqKr5Nb+4cxyuE8mZpAnsksIYGzTi43GpnnP0Pc?=
 =?us-ascii?Q?h3eVOYYGMIKhOh6L1wTGgYmF3ZN8hUwgNE93NLc84SwV9UnVFEuRuhNnRUU7?=
 =?us-ascii?Q?mvkMvic+WZsbHQEHR7wV9EG4bYVTr6qpfUrvwDlrRxzHXF83jCZmqMY4ONLg?=
 =?us-ascii?Q?6hZPlN9xFJ8RFcoKF/QU+Ub09rPjVFIMVobDhpWdmu1dH5nI8lxVk9b01u9w?=
 =?us-ascii?Q?ikpTc5VaDcr+mA7mrRMjNv1lOALmY05GOp6ndDuAbsswSXkjcBXnoNJIalon?=
 =?us-ascii?Q?ke1iUiwhjFfMgkB3gaEKrkq4q5eJvVh4HCJQy9lNZ1EMHUWtfKN9LpDoE5lE?=
 =?us-ascii?Q?JBRF1mj2NQpDq2iv1zZP7ow1+NRJwR2VucIy1289GFcDTOzPEIJ1PtnZNRj6?=
 =?us-ascii?Q?jV2HyV4b0vERRltmnE57dJX2hmdLWqLbMwWZJcP9IuJL5MyvxNqH3NzEP4rU?=
 =?us-ascii?Q?8uZbbx+WS7TgRUe9VumXbezmtrW+rEgjwTR/FVX54B0ntsiN54dpZNvXkksN?=
 =?us-ascii?Q?SZY8C7T0N4Wp1La2IRVml7+6hiATPflWjnn6ySKhJ3Nx3nAWi2v7PO2JCjns?=
 =?us-ascii?Q?PQ9vB/7kcr8V8AhDpdrLCcQ9aLloEyEYkSMlgjcv/eehdGzpJXJeQlQdH807?=
 =?us-ascii?Q?HcTV/5javMdcoPkLk9R5EnrpQ0XevVLKoPb/qCP7CMrRYI/qn6Vd1C1EYvZ0?=
 =?us-ascii?Q?rvHZFI5akH/lBqNtYsbL7Z07T4VSPCGXlfLWvIpcdcuYB1gdV11UVJ+loPtq?=
 =?us-ascii?Q?8/EQC0NPBbZ1YYU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 17:17:29.2725
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ada83f6e-4b62-4a51-2954-08dd1f87d9f8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4299

Alongside the helper ip_link_set_up(), one to set the link down will be
useful as well. Add a helper to determine the link state as well,
ip_link_is_up(), and use it to short-circuit any changes if the state is
already the desired one.

Furthermore, add a helper bridge_vlan_add().

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
CC: Shuah Khan <shuah@kernel.org>
CC: linux-kselftest@vger.kernel.org

---
 tools/testing/selftests/net/lib.sh | 31 ++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index 2cd5c743b2d9..0bd9a038a1f0 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -477,12 +477,33 @@ ip_link_set_addr()
 	defer ip link set dev "$name" address "$old_addr"
 }
 
+ip_link_is_up()
+{
+	local name=$1; shift
+
+	local state=$(ip -j link show "$name" |
+		      jq -r '(.[].flags[] | select(. == "UP")) // "DOWN"')
+	[[ $state == "UP" ]]
+}
+
 ip_link_set_up()
 {
 	local name=$1; shift
 
-	ip link set dev "$name" up
-	defer ip link set dev "$name" down
+	if ! ip_link_is_up "$name"; then
+		ip link set dev "$name" up
+		defer ip link set dev "$name" down
+	fi
+}
+
+ip_link_set_down()
+{
+	local name=$1; shift
+
+	if ip_link_is_up "$name"; then
+		ip link set dev "$name" down
+		defer ip link set dev "$name" up
+	fi
 }
 
 ip_addr_add()
@@ -498,3 +519,9 @@ ip_route_add()
 	ip route add "$@"
 	defer ip route del "$@"
 }
+
+bridge_vlan_add()
+{
+	bridge vlan add "$@"
+	defer bridge vlan del "$@"
+}
-- 
2.47.0


