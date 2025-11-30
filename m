Return-Path: <linux-kselftest+bounces-46745-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79831C94CF1
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 10:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1A721345C50
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 09:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C74927B35B;
	Sun, 30 Nov 2025 09:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WruGI782"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012004.outbound.protection.outlook.com [52.101.48.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532BC27B340;
	Sun, 30 Nov 2025 09:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764494486; cv=fail; b=cJfXUqruwmrckk7tqKGggGU5lXWeBYFUKHHBTg8qTDFdGv7xVCYSXoW1ibzg9hr2d7w6pzfJzxtK4GzJEBM4ZFA+ixdTERTeDbD9uBbFEz8CFC6kXbx9rKTjD6QPzykXEWTk4femE3BAbVKib5GdPBrDL/a9IzJ8ZCpXTd+vHtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764494486; c=relaxed/simple;
	bh=drT1rIru+T7/fNd1M/aw6ApSKOdseqZFQf53VY+hx5A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u07EbViPN0AVroVnfejdo1WeMAY6mL6xpCAQwERYU9GkuZKkKKuaoD5xSUC6+/F9vLBRGUhbc8Did8lnYqZqg42jcLbufAeydzJW+Hu9ehrD+16GDtliBDOORUT6vrJGMNnEEZXXd8TKzQhcNd7B090o6rnIlI+oRg8lQ633VaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WruGI782; arc=fail smtp.client-ip=52.101.48.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CyYrQWcASHTNAW3wDRG8HdN0KNYvhAMDGfUas0jTI25VBgPaBlAdowdaz0daOa2SrKvDUyhm7byy4WaougOrQDLJUTUTfV3ddy1b1UDqrUOFHrvPUYSzyTUdhlbGR5Hp+Yk1++Gw8Dap87rmQX6wNvxj3i6+oO0ScSL2PXJesRITamcI7f3l0PtMKJxylyiVarYWi37f+ZGkDGf+DezTxWXd6Rh2Y5iixzsBTJSyzGnxwRTnW0AmKLGZBJmbDZqLQrCdiKmvpYjwyIec7jMHvjtDbV71JFUaukkqwkh6S9/sAigNo+UUqPFJnHEPVu1/NvX6vLwxRCACfu+NF40wEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JyiH2ugyRvz3ppOeMd6a8x/Ve8BkCuHcABvqxjVvZXs=;
 b=qETEGx8SGPE610Brgzg9HpkU11yrUZGAii3B/GkiUlfjZemtpAY8EilN+ZGH8zzbNguwn034g73Qq8nY0HvqogrV0fWp/uHa3l+899yjErqE1o6OmGR+li2m6z4N6lQMGktkVG3VkTVHG260jCdIwSfkBkhox2R3zrj/cvYlgHX9YZQsc6ltV5wQY4FEZFwLnr9Xns5hcd+vy8ZMGs4vtuizNyy9K1+l9Z5xS5N3u1x363RRQgGwFBJPBxcrx/mtttkE5mcsQDcfspW0rNy5BXyZ5ZGFE9WsXl61Llhdt3SCKFXm9g5T05TzqsFNUhRosAwZhAFTvbdvCPXYFZMJvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyiH2ugyRvz3ppOeMd6a8x/Ve8BkCuHcABvqxjVvZXs=;
 b=WruGI782dvdqhKwE5BYfw4ShL/bMkYPkX2j6BEcXC5HsNKcxUAG45JgKCBr+HhPdR302idgm4wfbQAlRkU5QnDQfu2gsqLtJOOjY2hK3n6fV69JrGeQ3/l7hZxYLQmEMN6gEvswReGlsLbKLvtM99ZlFJRdb9Qw+PZUfpKZHQ93Cy75poA1MHnvkEY4OPCEMrOca808T8uZdtVPTMtPau+xRD1suVBYHb2gEAaMkPWo3xdJyaJICk28eigZRzk7Jl/41ka/5PAWfUk176rqohptG/VjgJfOLe3+ouWsmHfCnIpXDHEtr65K73C/Rm2rGbJf4HpX1jYTfogF+Mn8hCQ==
Received: from SJ0PR05CA0095.namprd05.prod.outlook.com (2603:10b6:a03:334::10)
 by IA1PR12MB6114.namprd12.prod.outlook.com (2603:10b6:208:3ea::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 09:21:21 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::15) by SJ0PR05CA0095.outlook.office365.com
 (2603:10b6:a03:334::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.8 via Frontend Transport; Sun,
 30 Nov 2025 09:21:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Sun, 30 Nov 2025 09:21:21 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 30 Nov
 2025 01:21:14 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 30 Nov 2025 01:21:13 -0800
Received: from fedora.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 30 Nov 2025 01:21:09 -0800
From: Carolina Jubran <cjubran@nvidia.com>
To: Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH net-next V3 3/6] selftests: drv-net: Use Iperf3Runner in devlink_rate_tc_bw.py
Date: Sun, 30 Nov 2025 11:19:35 +0200
Message-ID: <20251130091938.4109055-4-cjubran@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20251130091938.4109055-1-cjubran@nvidia.com>
References: <20251130091938.4109055-1-cjubran@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|IA1PR12MB6114:EE_
X-MS-Office365-Filtering-Correlation-Id: 9314dc6e-e109-4a5a-0564-08de2ff1d338
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RksxazBhMU5ZbjN5K2gwMEgxT2tYaExQK083ZlY5R1dYYWVDRHNzTWp6ZFdC?=
 =?utf-8?B?U3hYNVJCODZwQmhqMlZEV2tNamNvY2ZndldRU3dLM3pGb2I5WVdvWDhjVVI5?=
 =?utf-8?B?VVlaZEZrdWdFQk0vQ0puS0FQVnJkZjFxdmtRYkNiVkpvcXJvem4yaXhTRDh4?=
 =?utf-8?B?SjE3c0E2QUlJWDlrUUFaQkVwb0ZJektOWTZjOEZUQ2d3eEEvMnhiNHlhQnZQ?=
 =?utf-8?B?Qk1nQTY2Q1gwN0dtZTlzVi9qaThSUk1CWEVVTTBBWnU1RUpoRE1YVHNMWEtJ?=
 =?utf-8?B?WUNhNkN0RSt1bTVPdU5LYlB6L1E2YkFxN2UyZTl3Z0tBRk9xM1VtRFJ2ZEg5?=
 =?utf-8?B?cEFLNDcyd3JaTW4wTW1VY0s5U0s5TytFaXlFSytNQnRta2tzRFd3SG1uUHVo?=
 =?utf-8?B?cmx3dWh0aURYUzVxTFBuOUV2QVpvZDV4by9jV013aWhBTWd5TEtUMkdhVFMv?=
 =?utf-8?B?ZFRDNFJaTFBycEtWMWljQ2V6ZkpVV0ZiUHM0c2pkbnRBcUJJeXMrWHVMMXZK?=
 =?utf-8?B?Ym1iNHpzUGdDT0hvZnludEZ5WVF6clBjTGFtbnNNdEcyN1BubnlhejQ1RWNm?=
 =?utf-8?B?Q3JzZVFsSHFUNWpoS2tZSHVWMUZ3bE5tQXdGVklEM2s0Q0lKQXpYMHZnZEJ4?=
 =?utf-8?B?NldCOURsdEg2RTc3dlNqSTRkeWJ2L2REQm52TkJLRG9zUWd2UUVGZTluL3dw?=
 =?utf-8?B?SGUwY1drSm82dUxyTVdjU1FaSTJtckIwakdxRGplUzR2RFZQNjZ2SFc0U1Zm?=
 =?utf-8?B?ZkwvbEIrK1RBYTBRbXhwZWVrVDRDTXZ5YnFIQ0VadzFHWXN6T3lPQ0lzdHZh?=
 =?utf-8?B?YlUxSjd3UkxQN0hhbUo2MWE1S0ZCQkQ0Y3UwbHJCVE96ckNsL29IL0xGc1Q3?=
 =?utf-8?B?TFhXdWpBWXUwRVkxdnNOUGl2cHpzOEJWL1EyM2lPTElsTXJiK2E0enUvMWNt?=
 =?utf-8?B?Tm5nL1pweFRUM1pxeGFYdCsxb2NJTkVVaDZZdXdEZUdoZDl1VXFHdzJ2WElT?=
 =?utf-8?B?a3lmQm45TnJramp0ZWNwc1NodU1waDZYSUQwbXpPejEvWTVmZmNlK2VwbDJp?=
 =?utf-8?B?RlpvMDAzSkgzdDc4czc0ZXEvQ1UzMGhrZEFCTXB6cmNOR3J5SldsdkdDZXNP?=
 =?utf-8?B?Qkh1MysrZU84QXdPLytNTGJ5RjVvL3c5WE05TlVDWDJ6MmJVV1lYN0xIaFRE?=
 =?utf-8?B?V0hhVjk1Tmk4NFNSeFNnWGs1RXpvdDEvci9GQWZpRUVMUFkvZ3hSSlJtaG16?=
 =?utf-8?B?SW5jZlNQSE9LTXo0TjVtUmZIOVozckF6eTR2TW11ZERkdkxIKytETTlJbzMy?=
 =?utf-8?B?bWpkQko4WlNsTHQ5a1djUWh6UERwaWdGM3hFOTIwc2hkV1ZETDZrejloNUFD?=
 =?utf-8?B?WmVUQ3k4cml4b2thTm44QUdVTVRjUFFaUUt4d3NGNWVzbm4xWmJSeHZWeWhm?=
 =?utf-8?B?MUpvSmlBVS91cit3bFB3RUJZVVVabUk0ZkE4THFEc0hEZERJcWZIajhpNkZI?=
 =?utf-8?B?dy84ckphWWNxV0c2ZTVMNDNnNTU3cGRLRTE4L1dWNDNTYUZwOXN1S3dCMGVa?=
 =?utf-8?B?bm82UVlkcHQrRUZwVVlpRnJCM2hJOGcxMkJVejNGdWc3aXpMSE5FVWRNanlR?=
 =?utf-8?B?WERtMXc4a2dQWGQ1MlVLMDNhRlBwOGgzQ3RaWmxsNU04K1BRMjRqSjJLczYx?=
 =?utf-8?B?YW5sOW1JMWpwc1c0TVlHeWxhbURnT0NrL3htN2duZVdsQklMODN1WGpQTmNn?=
 =?utf-8?B?Kzl3czl0dWhQVW9PVWE1WS9OS2VyTTdRYTJRU0ovbWxsd2VxVVN3alVTbkhC?=
 =?utf-8?B?Nk0xZ1ZCUGtPUWNjNmlQNFRuNy9pVW5pZEpNNFp6L09SSzF2MUdDM2NXYjZC?=
 =?utf-8?B?SXhDbG1BcmFRTjJrMngxbEVXblJBNVZ6Uy81T2VnMVNOWFN4L0RkYi91Ky8x?=
 =?utf-8?B?T0sxZGZEdXNzeDRROVkzcFNmTzBUQ0tqK2o3T1dTam42ZGpRa3Rvakg3cVB3?=
 =?utf-8?B?aW9HanFXSlBuWU8zQWI5cnJFNUlWVEpnYlJEa1Nib3BpN3dCaE9GbGNtUHM0?=
 =?utf-8?B?bTBXLy8rVDFhWlNXeUU3RkxqS0ppRDZSRW43S3dERlZselNsRWEzRE9tR0hR?=
 =?utf-8?Q?lVls=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 09:21:21.0303
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9314dc6e-e109-4a5a-0564-08de2ff1d338
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6114

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


