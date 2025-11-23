Return-Path: <linux-kselftest+bounces-46352-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 706C9C7E4CF
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Nov 2025 18:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 61CF04E244D
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Nov 2025 17:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088202D9EF4;
	Sun, 23 Nov 2025 17:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QGM44Q7v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010008.outbound.protection.outlook.com [52.101.46.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2D02D9ECF;
	Sun, 23 Nov 2025 17:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763917925; cv=fail; b=tHyDaZ49pV0QkSswZNzp9NUp+KlwIKyV9x8kelVhlngG77bA11Ox8ntdCoewoje7gBB0Igun3jdw7kgF6ZndUwzGrfmQJqroFq7tfAog+jwLO4CaNj2IM9B+Tt9gQadvLL3L5/K4bpTSwZ09gHQ/wOiy6N1uXLvk2DUlVkphaKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763917925; c=relaxed/simple;
	bh=drT1rIru+T7/fNd1M/aw6ApSKOdseqZFQf53VY+hx5A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L+VGlyqgIYlKRF7xlCySomvGv4CVhUe4/SZqISck7fIFLVJwsz8tq5kPmURLmj4VHLy61viR6nl5Pbsb3XNh8+ghuxi5NKo+BgfnZXi3g1N/w0Q4zm42vvCiw2blbCBZE561yZU53pgvFLDB0KUgtXeB3LamvcUoDzb0Ji1++r8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QGM44Q7v; arc=fail smtp.client-ip=52.101.46.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eWViBA8td6oQ4A09qGo2zthmGJxrtobkOMfzM3x69RX9YeQhMcTAn6iAmjGKbVQHOrls5dnDaEbDbW+sEoPfiFyCaXnbSmA+dFFbedJrNpQGuG9O0+PVACIg3hKleOFHvb+AOugFgrBCKeSoIgb7u1mHTISLMDbElq/7JNMI12ByxvqGCOTV0r9jtv1iQG2QIt81yJM15dgGihquTffEe435seI8BZvDDuizUA5muQGnYH1gQVAyQPN4TTg5fyIwb+P0+EOuWWLTWZ95TUWD/x7f+83cTjHUikXQMpOEfE3PziepnqnQGISMorzho8yZIVIs20GwOb/+++DHmalh9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JyiH2ugyRvz3ppOeMd6a8x/Ve8BkCuHcABvqxjVvZXs=;
 b=bw9wltwN5LJcCBmybccW24MYUKn+PGcyBYAk6iOlJqTxYbS2a1vbMRZN6eXRXIX+JS0g0nY6qKNlse1kBNPiZn5NJpVbaDuMxexn0nbgIgBzcl6ODf3Wte9sxTJH7p/XbYNXWLTioz55GpHVfTtEf6xTkk4+0YGGWsO6xoJ8uRp41JFQVYXO7ZI1WPvjiIiosnlHqWPubLvWkUBjIssVuhr2Qp1fQf1E/W8FCeOgbM+sr7YJ2bHM+rMa3aQz4Che77zi/KLv/p2tcU8ruRoO2Ey5Ob8P61Zr9AjRyCpC7xTuoIcD6dMl6VfgAYojF/7MC56s27Ibzj52Xmep0BZwcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyiH2ugyRvz3ppOeMd6a8x/Ve8BkCuHcABvqxjVvZXs=;
 b=QGM44Q7vg/Hcru3CjqUGQ4UVYS0vXLA/nIBuNKe6phHj0AwOSXZ5soEzijcJxGjICxEstBr96Rk2HRGDUMZzUq165z+AsWyhNRNTBFUS2L0eYN29SgZ4/wI3wtGCdhX0ExffbrD90kOMlt5QtP4Zw5DH4/6l3ICTYF7PMCx4g7SQmrfpPDzFk3kHs0zl0DsNIHZrXzYKQjiCVNOjMqKtMWrdgdc3lfe3GFto3GVHTCOO20ZHwXCYifXa8Nm1++U1OydSWWba+ibjc0rq4IZ32Qgkugn7Nv1TN+ncOTImygnOdtPV+hVQOPmRFRT4PZ8cD/hFHXVuJxOP+bH/U7DY1w==
Received: from BYAPR08CA0069.namprd08.prod.outlook.com (2603:10b6:a03:117::46)
 by PH8PR12MB7182.namprd12.prod.outlook.com (2603:10b6:510:229::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Sun, 23 Nov
 2025 17:11:59 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:117:cafe::d6) by BYAPR08CA0069.outlook.office365.com
 (2603:10b6:a03:117::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Sun,
 23 Nov 2025 17:11:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Sun, 23 Nov 2025 17:11:59 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 23 Nov
 2025 09:11:48 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 23 Nov
 2025 09:11:48 -0800
Received: from fedora.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 23 Nov 2025 09:11:44 -0800
From: Carolina Jubran <cjubran@nvidia.com>
To: Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH net-next V2 3/6] selftests: drv-net: Use Iperf3Runner in devlink_rate_tc_bw.py
Date: Sun, 23 Nov 2025 19:10:12 +0200
Message-ID: <20251123171015.3188514-4-cjubran@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20251123171015.3188514-1-cjubran@nvidia.com>
References: <20251123171015.3188514-1-cjubran@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|PH8PR12MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f6c69e6-a07e-4d04-e65a-08de2ab369b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dVV1UWF6NGNWVFEyZkFpR3BwMmxncW1PaGZFY0ZzMkttZHUwb1htc3JGenI3?=
 =?utf-8?B?RFptUDBYdVdGa0hhTndiMkNzQmNienNONGE5WWNrQW96Yk0wQ3VTaVFFSjBy?=
 =?utf-8?B?SW1CWmZTRjNUd2ZCWGxHaUZoQWFDS3d3RHFENWN1WEdCNnJqdEdwdkRMdmJT?=
 =?utf-8?B?VXhUY05SNTdzQUxHcE1WTGZyM0t2bE1rY2xCbllsOFFNMGxESkNIekJYWDVi?=
 =?utf-8?B?MkNuVENqYm1SNFRIV1Y4UExYQmhQZDEyWFdNZHhMdVU0NzBUUlF6L2hrU1FQ?=
 =?utf-8?B?Y0gxNVJGOU00Zjh0ZENtRVQ4QnpqQVJZVHV6aDdNeWRVZEtWVGJTcTVLZHYv?=
 =?utf-8?B?UlhSMWl1S2NMVkFPaUcyQU5VMEhzQkFCRUpsQjBiMUlML09RWVdyaU1VYy9X?=
 =?utf-8?B?K1V2enRjQ0xGbXBHREoySExCNGx3UmU3TFlRQ3ZqRk1iWGg1d0dVUkVDWGRL?=
 =?utf-8?B?dXgyb1oxdVdVcnVKbVF3OEhyYU5TTGg2QnYzRnBZR0tRWVdNUjlTYlFpUjA0?=
 =?utf-8?B?eXVsRkdKdWhTLzRESGtoU1BVU3dIbHZ1amdNZTd6MEgzYlB2TEovU2RqYnhj?=
 =?utf-8?B?ZWV1enIzcDl3YzZkc1E5UVp4VEFuMDlaZ0d1OS90bFdiNXQyS0lvQlQvcUwy?=
 =?utf-8?B?ZkZybDEyUW83ZGxsYk85N0lna2NOYmNyVTRZZFBQNUdsTEozOUdkUS80R3ND?=
 =?utf-8?B?UzM4VkRQQWQ0bitsQ0F3YU9hZFJJSjhGU1lmQzJEbnRCZHdiUytaeDdwalZn?=
 =?utf-8?B?S1F0RHpvWnNFMTlQbHRHNnhWOHg1VCtka2x6R1lEZGRoYWhEejRaSHU4dXpD?=
 =?utf-8?B?OFJCai9ONWVqOUVGV0QwSDRNWnRDVFNycFdlNFFZWUsyTko3MUlIUGJ6eEFi?=
 =?utf-8?B?WG5sUVlVUC9JVFZIaHg5Mk9HMTV2Z1ZabU9WMGFYWXNLQ2ZHL0o4a21tVlJV?=
 =?utf-8?B?L085TkF5MitzWnNEYjk4MlFlcVRUM215bEs3dEhlMVl6N1lpMU4yMFRBZmJM?=
 =?utf-8?B?SHo0SjVXaGh3eU96WXhuaHdrZXhKU3FMaWFQQ1BYVFN4d25kaW12TmN6aUdP?=
 =?utf-8?B?RjZPVjJxdm1mN1FYVzZ5Uko1QXF6ZHQ2aVBJakIyek0wYWpxOEIzQlhhcXI0?=
 =?utf-8?B?RUtzdkFyRk9Bdlg4UmoreEt6OFp2cVlqVWR1UDUyNTFYVllUTC93UlZHSlFQ?=
 =?utf-8?B?SVhVc1RSaTIydjdsZ3Yza0ZlTEdBdUFiUGxUWTY3RzVoWThOUUpiS3JXQUtI?=
 =?utf-8?B?VEsyWktGZ2JKZm1UcklkRXV6UldTdDFPYm03UkNmbUx1MlExMlc0bVdVRUdI?=
 =?utf-8?B?ditMa3BJUWRpR043WkNvUjd4TVBJbGQ5SmYralgvQXBzbWd2Yk1jVUIrZ3Ev?=
 =?utf-8?B?YVBobDJMMExzRnBRT3dJY2hROFNkNndqMDhKWis5ZFFVaXhldFBUY1lpQXpN?=
 =?utf-8?B?M2RsNnVpNVFJcUxPT2xmbnJpcFlQUWd2YnVqZ28wSk1kWGtpTG1YeUVocmRR?=
 =?utf-8?B?OVNFN2VmK2x4aU1TRURSSi9wbmo0SUZZNUE0UDdzRUsvaTFWdjRub3pNQm5I?=
 =?utf-8?B?ZmRzTm04cVpkNzE5bHZ2ZE9JMkROZ0Y3aDVjMCtQd3I1dG02OVp0dGcreTc3?=
 =?utf-8?B?RjFuL1FGdFV3SXJqS2tGa2xVVlJPSU5zakdLYWI4S2ord2RWUmk0RXN5S2VS?=
 =?utf-8?B?ejlneFJVOHFTdHBQWGFZOEZMNW01dG56ck85UTA4ZTZrNDNNU3VWMzY0bXQ3?=
 =?utf-8?B?c0dFWXFhcjliZ1J4UUl1MjJDbk05a20wK3pZZm5Ia2ZKaXpST3JiNzBsRUlO?=
 =?utf-8?B?ZDN2Z3pWdVdZRGpjRTdtdHhjTFIvbmVIaTIvem5zU085U05wd1d4a2Y5d1FT?=
 =?utf-8?B?dVhueThJRC8rNXdUblhHSWtrZUdZb1lLWjNRM0diaitpaDdTV2JHRU51V29F?=
 =?utf-8?B?NFBjZ3lnS3B5Q1JDb0grT3JCUlFMcEJ2UDZ6Z1hJZ0hKRGVuaGJTWXQxejRV?=
 =?utf-8?B?Zkc0c0VkN3J6OUFWRzhNaE4vODlBM2tVL0JVVU9SbzA2OUJVZS9pRzJtaURq?=
 =?utf-8?B?Ri9zVElHd2ZTQk82djNtdzh5UVVTODliNXZWZXY1cTBnOXRWdUtyeVcwSHpI?=
 =?utf-8?Q?ujs0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2025 17:11:59.4009
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f6c69e6-a07e-4d04-e65a-08de2ab369b6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7182

Replace the inline iperf3 subprocess and JSON parsing with
Iperf3Runner.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Nimrod Oren <noren@nvidia.com>
---
 .../drivers/net/hw/devlink_rate_tc_bw.py      | 70 ++++++++-----------
 1 file changed, 29 insertions(+), 41 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/devlink_rate_tc_bw.py b/tools/testing/selftests/drivers/net/hw/devlink_rate_tc_bw.py
index ead6784d1910..16e5dda5bee1 100755
--- a/tools/testing/selftests/drivers/net/hw/devlink_rate_tc_bw.py
+++ b/tools/testing/selftests/drivers/net/hw/devlink_rate_tc_bw.py
@@ -64,6 +64,7 @@ from lib.py import KsftSkipEx, KsftFailEx, KsftXfailEx
 from lib.py import NetDrvEpEnv, DevlinkFamily
 from lib.py import NlError
 from lib.py import cmd, defer, ethtool, ip
+from lib.py import Iperf3Runner
 
 
 class BandwidthValidator:
@@ -139,8 +140,8 @@ def setup_vlans_on_vf(vf_ifc):
     Sets up two VLAN interfaces on the given VF, each mapped to a different TC.
     """
     vlan_configs = [
-        {"vlan_id": 101, "tc": 3, "ip": "198.51.100.2"},
-        {"vlan_id": 102, "tc": 4, "ip": "198.51.100.10"},
+        {"vlan_id": 101, "tc": 3, "ip": "198.51.100.1"},
+        {"vlan_id": 102, "tc": 4, "ip": "198.51.100.9"},
     ]
 
     for config in vlan_configs:
@@ -224,13 +225,13 @@ def setup_devlink_rate(cfg):
         raise KsftFailEx(f"rate_set failed on VF port {port_index}") from exc
 
 
-def setup_remote_server(cfg):
+def setup_remote_vlans(cfg):
     """
-    Sets up VLAN interfaces and starts iperf3 servers on the remote side.
+    Sets up VLAN interfaces on the remote side.
     """
     remote_dev = cfg.remote_ifname
     vlan_ids = [101, 102]
-    remote_ips = ["198.51.100.1", "198.51.100.9"]
+    remote_ips = ["198.51.100.2", "198.51.100.10"]
 
     for vlan_id, ip_addr in zip(vlan_ids, remote_ips):
         vlan_dev = f"{remote_dev}.{vlan_id}"
@@ -238,14 +239,13 @@ def setup_remote_server(cfg):
             f"type vlan id {vlan_id}", host=cfg.remote)
         cmd(f"ip addr add {ip_addr}/29 dev {vlan_dev}", host=cfg.remote)
         cmd(f"ip link set dev {vlan_dev} up", host=cfg.remote)
-        cmd(f"iperf3 -s -1 -B {ip_addr}",background=True, host=cfg.remote)
         defer(cmd, f"ip link del {vlan_dev}", host=cfg.remote)
 
 
 def setup_test_environment(cfg, set_tc_mapping=True):
     """
     Sets up the complete test environment including VF creation, VLANs,
-    bridge configuration, devlink rate setup, and the remote server.
+    bridge configuration and devlink rate setup.
     """
     vf_ifc = setup_vf(cfg, set_tc_mapping)
     ksft_pr(f"Created VF interface: {vf_ifc}")
@@ -256,51 +256,39 @@ def setup_test_environment(cfg, set_tc_mapping=True):
     setup_bridge(cfg)
 
     setup_devlink_rate(cfg)
-    setup_remote_server(cfg)
-    time.sleep(2)
+    setup_remote_vlans(cfg)
 
 
-def run_iperf_client(server_ip, local_ip, barrier, min_expected_gbps=0.1):
+def measure_bandwidth(cfg, server_ip, client_ip, barrier):
     """
-    Runs a single iperf3 client instance, binding to the given local IP.
-    Waits on a barrier to synchronize with other threads.
+    Synchronizes with peers and runs an iperf3-based bandwidth measurement
+    between the given endpoints. Returns average Gbps.
     """
+    runner = Iperf3Runner(cfg, server_ip=server_ip, client_ip=client_ip)
     try:
         barrier.wait(timeout=10)
     except Exception as exc:
         raise KsftFailEx("iperf3 barrier wait timed") from exc
 
-    iperf_cmd = ["iperf3", "-c", server_ip, "-B", local_ip, "-J"]
-    result = subprocess.run(iperf_cmd, capture_output=True, text=True,
-                            check=True)
-
     try:
-        output = json.loads(result.stdout)
-        bits_per_second = output["end"]["sum_received"]["bits_per_second"]
-        gbps = bits_per_second / 1e9
-        if gbps < min_expected_gbps:
-            ksft_pr(
-                f"iperf3 bandwidth too low: {gbps:.2f} Gbps "
-                f"(expected ≥ {min_expected_gbps} Gbps)"
-            )
-            return None
-        return gbps
-    except json.JSONDecodeError as exc:
-        ksft_pr(f"Failed to parse iperf3 JSON output: {exc}")
-        return None
+        bw_gbps = runner.measure_bandwidth(reverse=True)
+    except Exception as exc:
+        raise KsftFailEx("iperf3 bandwidth measurement failed") from exc
 
+    return bw_gbps
 
-def run_bandwidth_test():
+
+def run_bandwidth_test(cfg):
     """
-    Launches iperf3 client threads for each VLAN/TC pair and collects results.
+    Runs parallel bandwidth measurements for each VLAN/TC pair and collects results.
     """
-    def _run_iperf_client_thread(server_ip, local_ip, results, barrier, tc_ix):
-        results[tc_ix] = run_iperf_client(server_ip, local_ip, barrier)
+    def _run_measure_bandwidth_thread(local_ip, remote_ip, results, barrier, tc_ix):
+        results[tc_ix] = measure_bandwidth(cfg, local_ip, remote_ip, barrier)
 
     vf_vlan_data = [
         # (local_ip, remote_ip, TC)
-        ("198.51.100.2",  "198.51.100.1", 3),
-        ("198.51.100.10", "198.51.100.9", 4),
+        ("198.51.100.1",  "198.51.100.2", 3),
+        ("198.51.100.9", "198.51.100.10", 4),
     ]
 
     results = {}
@@ -309,8 +297,8 @@ def run_bandwidth_test():
 
     for local_ip, remote_ip, tc_ix in vf_vlan_data:
         thread = threading.Thread(
-            target=_run_iperf_client_thread,
-            args=(remote_ip, local_ip, results, start_barrier, tc_ix)
+            target=_run_measure_bandwidth_thread,
+            args=(local_ip, remote_ip, results, start_barrier, tc_ix)
         )
         thread.start()
         threads.append(thread)
@@ -320,10 +308,11 @@ def run_bandwidth_test():
 
     for tc_ix, tc_bw in results.items():
         if tc_bw is None:
-            raise KsftFailEx("iperf3 client failed; cannot evaluate bandwidth")
+            raise KsftFailEx("iperf3 failed; cannot evaluate bandwidth")
 
     return results
 
+
 def calculate_bandwidth_percentages(results):
     """
     Calculates the percentage of total bandwidth received by TC3 and TC4.
@@ -398,10 +387,10 @@ def check_bandwidth_distribution(bw_data, validator):
 
 def run_bandwidth_distribution_test(cfg, set_tc_mapping):
     """
-    Runs parallel iperf3 tests for both TCs and collects results.
+    Runs parallel bandwidth measurements for both TCs and collects results.
     """
     setup_test_environment(cfg, set_tc_mapping)
-    bandwidths = run_bandwidth_test()
+    bandwidths = run_bandwidth_test(cfg)
     bw_data = calculate_bandwidth_percentages(bandwidths)
     test_name = "with TC mapping" if set_tc_mapping else "without TC mapping"
     print_bandwidth_results(bw_data, test_name)
@@ -451,7 +440,6 @@ def main() -> None:
         )
         if not cfg.pci:
             raise KsftSkipEx("Could not get PCI address of the interface")
-        cfg.require_cmd("iperf3", local=True, remote=True)
 
         cfg.bw_validator = BandwidthValidator()
 
-- 
2.38.1


