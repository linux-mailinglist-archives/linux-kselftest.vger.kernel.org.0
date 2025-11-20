Return-Path: <linux-kselftest+bounces-46088-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D8629C735F1
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 11:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 98CBC340EEF
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 10:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53A5317706;
	Thu, 20 Nov 2025 10:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Naa1faif"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011038.outbound.protection.outlook.com [52.101.52.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D122D2398;
	Thu, 20 Nov 2025 10:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763632865; cv=fail; b=Jy+VTtt8LveK6isiQ343AYVBfokORoLwSR/2C+OLGoySN348SIZqzejXW10nps/8P1itzX7VVXP9oMivBXLnKxAz7SloKcODiNfJFyGQBv9iLpUUimg0vhkUPl3KRPzrPDpBUF6usZrV9HZduU0brXuu98mAcT0HjEzXRWu4eNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763632865; c=relaxed/simple;
	bh=drT1rIru+T7/fNd1M/aw6ApSKOdseqZFQf53VY+hx5A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QoOJUEWHUueocbdVjDwavGcb2dLcsrvCCjNDbz68mANLyrHDgqjt/DZ8lo4ReMQ005xdI3JUsB490g+Xlg4UjJVGjFTuoAj0wj9b11tjXVqmvK0beyXW1DR0P71TOCyYBMBffSNee5rBaI15+mLfnE2YYO1Gqh836LtuUKJ6Ov0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Naa1faif; arc=fail smtp.client-ip=52.101.52.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJTRLaavPwrCYK42j0FB0d7lUsJMcm5idXyr/d6rHAAqlqJyGG/Q/B42lIng4vg2aYvtI3nrqfD2B1GcDh4C+Y4v4DnA/Wp+RDcOs/YcvmKlhBkjyaou+9TxIL6UjSVJBtVbkMVUxs8Vq9hdb7Qs+Cjy35RGzWeD9fq2Py9/t+TM8/EM3sRI1dxQ2w4igFvATUsbBOlPyw1VC9AR2OxsCw5fPLq28Hstgb/w/beypOO91l7Vrf3BLt/Sc0+KKa42tt7Mz4fHFi6KAw0KuvRrnwvIs/LqROb+OM89bpHYtZ9EcGqOVLZiZ/WdEsTBb0H7WoAy7dp36XfPYYP2L570fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JyiH2ugyRvz3ppOeMd6a8x/Ve8BkCuHcABvqxjVvZXs=;
 b=GTx0letW2gUZ7RCoMNhBtjuGo4eW4kOAUCSgyloQh7sFnQpl8n8euZgjHtYa9lHVk6THCCT0ZhbSj5lFk38MOo1+4bm19z4pTy6uUJtyzKo2232Zj/yk9A6Hg3PixpGE2LvDt0/gr79LNCl4/oimV/F/BG0MT1ySH2rUsvI67KVcjYmlIQxoM+fZHmueX1DcNdKT3lSutvZtbnOYWlaU0sgdRTWQr67vYKpJaE0te3hUTx8dhewWhKyhOmESARkWThw5FofGLLFTy2JdpxbPkW+0WLXbDdRr6kYLYG128RBWXjHuNLcd3SQ0o5DYF7McDwagKGw5nCB2IZT7ngnUKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyiH2ugyRvz3ppOeMd6a8x/Ve8BkCuHcABvqxjVvZXs=;
 b=Naa1faifANI1ObIbz615fjp8w7DEAMJcy3ldA+aNJdHTup3UNGcS1oyj9lEnBcAsw/RBWYSBhQ3Sh8qx28N3La0kSDwoInlwy8/dYUgYymikEp0vKr273KWjSbqn2yjsn+YCpco8COeOTl3ynliZAnJ2A/TDU1P4EuUeAfEM7M6zujHaMbYYe4AaA6LOxQ00pXKH8QqOzXTpy1PDEjoGkPIEU7lJh8zIpUmiekLA3u1Kx9LomP4g/FAl5BW8iWVg4t2lz7asjWMN8XY2astUHzXgMpc1UsZXyBnsMw06+MMHjvB9bVvB2SXdVJN9JhLkgF00MkRbhJ6f94wMZGxx5Q==
Received: from BN9PR03CA0658.namprd03.prod.outlook.com (2603:10b6:408:13b::33)
 by SA5PPF8BD1FB094.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 10:00:56 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:408:13b:cafe::f6) by BN9PR03CA0658.outlook.office365.com
 (2603:10b6:408:13b::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 10:00:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 10:00:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 02:00:33 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 02:00:33 -0800
Received: from fedora.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 20 Nov 2025 02:00:29 -0800
From: Carolina Jubran <cjubran@nvidia.com>
To: Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH net-next 3/6] selftests: drv-net: Use Iperf3Runner in devlink_rate_tc_bw.py
Date: Thu, 20 Nov 2025 11:58:56 +0200
Message-ID: <20251120095859.2951339-4-cjubran@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20251120095859.2951339-1-cjubran@nvidia.com>
References: <20251120095859.2951339-1-cjubran@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|SA5PPF8BD1FB094:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a589592-bdab-4566-601a-08de281bb248
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TDZhNG9JSEQ1TjdsVnpIZFNsaWlIMmdmMUl0ZlB2dGxna0Z3YzkxRXIwSEs5?=
 =?utf-8?B?YUY3RWVaQWF1QWVzM0t4ZytEK2dwVldmZEMxOXI1MkgrWmV6YjdXbFlOQ2dz?=
 =?utf-8?B?c0draC9zUmR5bjgvMlZROVBhTFhPM0p2YjQrS2h2cmh2WnZuZHZQSmhwdW1J?=
 =?utf-8?B?UDBNTURjUHZLTklXMXU1QzNPdUtkWE0xTXJablZWcDhCempVa1c4dU80bUxk?=
 =?utf-8?B?NkVGdUZNS1AyV2crV1ZxM3lpTXNkOHh0UVBFSGczYnpHcDhDTkNENlJNQjJz?=
 =?utf-8?B?cDFCM1N5T1lBbUJRdlFRejAwNEdPWXR4Y3lrZUtuOUhJWXVhUlM5SkZMUGRv?=
 =?utf-8?B?N2FjL09RSzMrOEtBV1hYMTdadEJxbWgrTXEyYndVZFJORWJmb1NScmRoTGRT?=
 =?utf-8?B?amJMUy9VNVpWUW01V28vL1ZhZDAxZUtpbUhrL0xzaU9Ld2daQkpRcDRMdFF3?=
 =?utf-8?B?Z0IxaGNmODIySTVrVUQ5dTNSQnJ3ZzEvZjRTMlphMld2K3JlYXNsRk82Rlls?=
 =?utf-8?B?SmZvMktVQUhCSENKWTVUNXFEcnVlczliRGZxdFYwUjFaempiM3BzaEI2M1hS?=
 =?utf-8?B?cW5EdDhXMkF1SG96MUVYYy9nTnpSN3RTRVAxd3lFNGszZ3BxQUVYMzdWcUE2?=
 =?utf-8?B?aVBDSTV4OTFsN2dsUTNNb3ZRTG80RmtSLytuUTkwbCtaZFdtYkU1U3RzUHhY?=
 =?utf-8?B?eXcwbTdkSnBBY296Wng5NEFOc0JOWFc5L0liczBWeU9QVVNTNmtSd0RHQjdo?=
 =?utf-8?B?djRlbFlhamRYMy84TWY4NUFYNlJoRmhqWFhsMjlkNFVpK3UweTdndjl6a0s4?=
 =?utf-8?B?UzlQekVUZ0svSmlPN3QvWUZBT3JKV2NqbmozeDdVRUpZd2I5aEZ5YVVWYU0x?=
 =?utf-8?B?QXdDbTZwNHhnV21mSjMvRmZ4UFBHdEc0RWFtQ3ZVT3BTSUZaM1VVY3FMUWlh?=
 =?utf-8?B?U00vWWMyNGxpbXVRY1NyQWNaanVqbUljazBmWWFaTDNwL0FsVFMwWXdPUnRx?=
 =?utf-8?B?Y0pFaUt3R0J0a3U3ajNDTXhEc0tlMEVFQTV5bVRJVkkxOW5ubGM0cFFndWha?=
 =?utf-8?B?ZFhTOG55WU50bE43QmU2Uk5tL295QXVFZXVKWGduU3hvYmI0UjFZZjBpZlA0?=
 =?utf-8?B?d2ZUc0MzQ0pZZktheTlJTnQrS1c3RmdOK0FTdlYyOUNMaitTVGVjTU5CcVV0?=
 =?utf-8?B?ZFZBbjZKakEvQVkrejk5SmtSRlNVT3JISlc0OGQwNS9ISXd1SWFubGpQbUp3?=
 =?utf-8?B?d3AwQjZVV2cvZ3dZajBuSDE4QlJKUGtpR0xMRElMYXhzdlF0T2lJejAvNytP?=
 =?utf-8?B?Um1KK25WRk5yTkdIWE9LNjQ2akZWWHlVRXJ6QllaNUhVRC9rZGxFOXpmQzNj?=
 =?utf-8?B?NWtibUdrejVJZlMrR1ZQRU1XSVBFbG04UU5heTRRMUJWa2RWTGU1TDJxMnpr?=
 =?utf-8?B?S3VNN3hsd0JaV211bjVUWmVYcHdNTGp3N0crQkNySm5TV3o2bjFaNkJwa2pY?=
 =?utf-8?B?RXp3dkRpL28vc2huNTdZTGxCZFpWR000Szhwdmpzb0ZwUXc4MHQzMkdIMnRZ?=
 =?utf-8?B?U05ZVjNnRnk2Z21ZbG0xVTRaM3dQV3F1UUhPY1A4Qm1qQ2FVV1Uxc2J1MTJI?=
 =?utf-8?B?SnR5RTBWdDRkRmV6MkU1eGFSQ0dvdnN5VDVwVklQSGRJaHZDeWczRGF1Ynlq?=
 =?utf-8?B?WWVMSUk0Lzd5Z0F6Y2NoRXhzSTd0dk02Ynh3LzlvMlVCbjVka1lFTkJuUlpl?=
 =?utf-8?B?eTBQczh3L3FCVC9oRkVCVlQyd21TYVBmUkV3UjU5SjVoKzNCYzFJb0NTWENH?=
 =?utf-8?B?NUIweDlrQWRVekhMNkIzall6NzlHZE5kNk85ZjlEMnRUemhsNVJPeGMycFBF?=
 =?utf-8?B?Rm91ay81UnlBbGJkWEpxM0d1OUFlb05IV2RVTS9FdTBkRGg5ZGFCSEFwOWpK?=
 =?utf-8?B?R0w1djc0SXNhbTZIVzlFcTZ1NkZBc1h5N2hOWG5PNVJ3SFp4czB1QmdxaytN?=
 =?utf-8?B?YlFXd2w0Zm80UW52a3FFbTM3WkRGcE9JemFyTUI2Q2FOZG4wdXp5ZndURHQy?=
 =?utf-8?B?UGNLTks0QVVYOWdIanllQWdrOXhaWEs1U2tZOEMzS3VYclJLNDFuSjBpVmk4?=
 =?utf-8?Q?raX4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 10:00:55.1497
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a589592-bdab-4566-601a-08de281bb248
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF8BD1FB094

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


