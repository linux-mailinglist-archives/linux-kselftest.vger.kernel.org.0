Return-Path: <linux-kselftest+bounces-46355-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C18CCC7E4F7
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Nov 2025 18:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 62CE034A553
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Nov 2025 17:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177CE2DCF43;
	Sun, 23 Nov 2025 17:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bPbxMoAX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011058.outbound.protection.outlook.com [52.101.52.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527ED2DCBF2;
	Sun, 23 Nov 2025 17:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763917941; cv=fail; b=o7VO2pOhaKoVVr3Fa2x6jn4w2VHGS5VOrQZNRea2+Q09d4KgOiTpoXCEfetAWET4GCx+jZNUOewLCO7k6CYkWQvk5CCZCfy+YwkJ5H2Y+KYbzW8xqslsR8fEEFyf8o12qMJiukaki7bFIt29dlci91u6LdyHGD9fGangFAqGkmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763917941; c=relaxed/simple;
	bh=KDwQCmXunXAK57wOAPlY8Zdnv6bCq+2jGDjNgaiUz+I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h51lt51Y5juNpQIWbcSHKIGWo1uQ4A68FIiofkzGCZeANSZ2skyCn/FdtK1q2JkNJjap4+mEbHwY3dTDxB0BBTFwmcdPj60DwKIXTRHiB7lAZBTnavPlEc1ucTUphU4TX7qOu2n1cm0jPPwFhE9jcMSVD5dJVDiYAyhrRmhLSbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bPbxMoAX; arc=fail smtp.client-ip=52.101.52.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dG3QZcd+FwsPQIFgW7FGRtd3FriQfXAnGTPjcZydKgpp/WmKsw5xieM3vwsOahCMFsFXxWdu/VlJEgIJfgI4cxTFIDE9YfRNWRNSzPWrA35nVO7mQo0p/9HejOc1IejbxJFMutxHpf/UkpX73Z6IHWVZ1aovfwq7amXyfNRtIId+8x2YVENEeJXVZWVXGBYowfLS6sgUmnAhUsesOPhe2TiyWTqq1jcQ8OL+cHXko1RMJxhHZHJQzvhg0MTcTpQVRSt7T9xpNv7P2okCfQ1uwOEvpXsUxLE/KZGdbUJ0yuMWAjAYImGwas8y2cRaXK03EUpqpNJznXdY19tqmkDAEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ijd0bHM1g9JbvS/k9b33eDUgJm0w6ibJpkdhtrL7VBc=;
 b=cc8NX14iTfNOJlIAY9rkTSeoTpTTbnj0mAnoP02u3DrIhK/vqANzOLTjSkbQtEOwJK4l11tJkpQrpt34+Sm9M36+76Nv05NlBKHKDOp5f7d1Au2AA6RgLLm7LP2EvjbHxBGG83R+K/aDQgF3EolNd6n5Hjmi7/q35zeEQRBqUssbpNY8YchxLp6i4M50WF6PNHJjx3317aBHILgdF1lBEo5mkaiaLIUtQxOtxB060wmiIpXt1MYKeyIObZMcSvxuAGorshPFbS7LxJWKnOocApPdYQEFUxoZmA6JO8m73Tj1fDFrB8CZlJQaEpBTafVsojX0pH+MCR4yUrCdjwzh4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ijd0bHM1g9JbvS/k9b33eDUgJm0w6ibJpkdhtrL7VBc=;
 b=bPbxMoAXVjeHAw1Z10U7v2hDauG1+Kpjmnvf/w6kyaNzksK1Am3UL1hTVQPvnKjCdMOPyj6GduBdffkA9yUE0MerIg2s3UJcgX0XOiMBT5aIjOo+dhLVvVw2+OpxVlGqahBSLHWbNdfEIUC92NZ83OjheYc2nxHf1wGQlyoj8P9hNKMivOyWe2/TCKbxfPJ7El1qMGmcNAQV6xmgUCMQhBSjEsyNK3QP+ROwO35T+wlRr/fwBztgyYYACIG5K0tf25PAXoYZpZqLoFJ+8yJLy5SmiVrikV9FL4huywixAhxyMB/HY8GwiRKTdUDDg/Nmaz5ETv35cbnvjBxn1+YH1w==
Received: from SJ0PR13CA0176.namprd13.prod.outlook.com (2603:10b6:a03:2c7::31)
 by BL3PR12MB6427.namprd12.prod.outlook.com (2603:10b6:208:3b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Sun, 23 Nov
 2025 17:12:15 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::ce) by SJ0PR13CA0176.outlook.office365.com
 (2603:10b6:a03:2c7::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.8 via Frontend Transport; Sun,
 23 Nov 2025 17:12:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Sun, 23 Nov 2025 17:12:15 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 23 Nov
 2025 09:12:02 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 23 Nov
 2025 09:12:01 -0800
Received: from fedora.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 23 Nov 2025 09:11:58 -0800
From: Carolina Jubran <cjubran@nvidia.com>
To: Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH net-next V2 6/6] selftests: drv-net: Fix tolerance calculation in devlink_rate_tc_bw.py
Date: Sun, 23 Nov 2025 19:10:15 +0200
Message-ID: <20251123171015.3188514-7-cjubran@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|BL3PR12MB6427:EE_
X-MS-Office365-Filtering-Correlation-Id: 0173f6aa-f31f-4aeb-9b1c-08de2ab37308
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eXFxSGhkUDgweUdDZUEwUXgxTi9ZeHhaMlR6ZVV3ZVJhU0xFenJ5aG8weW81?=
 =?utf-8?B?eXByYWVKanJzWmNBZTZKSm5IWUFtdXVpdWFLb0t3Zm5DeWNrUHY1N29zek9i?=
 =?utf-8?B?bWpHajgvWmVWVFdVR08wVnpCYklEZDdncDhKQms1SVYzUnFqSEM0RkxReUhp?=
 =?utf-8?B?eDJtR25hVTN2Z3BLejErd05zZW5SNEVrZmRhd2dqTlFQTE0wTk4wK1dMOWdY?=
 =?utf-8?B?V1Iza2p2a2EyWG84ZWs4UXR6NVFobWgvNkdKdjlUYjlYMU1PQkN4ZzhZMWlB?=
 =?utf-8?B?dU9rRmNiMWxUVUtrKys1bE1KRU9naGtrdG8rVituV3k1UFlQRE1oNjZhMGd4?=
 =?utf-8?B?U3dsZ1JIZGdTa2NFTVAwV3pwN3E4WDRRQ3hwMkgrdjF2clBYNzhlQmIxRGc4?=
 =?utf-8?B?YVNpZUF0MElPdEJNWGhadGhTam1OWk5lTnhaOXNVTnAyOVQrL3g0SWhLV2tG?=
 =?utf-8?B?MENmY3JFWmVlVlJObjcrNUYybWJOMzc0Rjc4YUdPcUVxSzhHbDNlRVpkSVox?=
 =?utf-8?B?VlVHNytjMVpESCtuUW5mOU9ONUNrY0N3dWlrWVc2Y0g2Y3E5Z2QzS29qcWZT?=
 =?utf-8?B?eG96RUJYQmFsdkVYQStjR1ZQdTlKbDZ3aU9UZ2VSQ3RHWXhmV2x0YzdYdldv?=
 =?utf-8?B?cHNkRElxb1VEWXFyVVoxaGp5VjNyRmxhWmQrckNRWXVPVkNPNDZaV01rd1Va?=
 =?utf-8?B?MzhyVlpRMXVrMjJEQWtBaGJ2ajhVWmNYL2RlWUViZk1XV3NxTlNsVHNnQ1hx?=
 =?utf-8?B?RmpaN1FXZVNsSFhGbjVqMTlQMC9QVkZoaldxUUtMY2dwbjJMKzBTTnF2cXdC?=
 =?utf-8?B?d3NxdmJrb0NBTW5QV1p3UWJmNXBNUnJUeXZ3NHpPazZqaGgwcUYrejZKNHhE?=
 =?utf-8?B?T0FYeUY2NFc3Y2JEQ3JnZ0t0QkpVblZ4bndER291ekI1ek9YRGNlWDRjOUhs?=
 =?utf-8?B?M3pvS041RjJtaytGSS9KS2xsbmRyUFAxMWVMMkdBby9nL0hTcjU3OXdQczlU?=
 =?utf-8?B?OVhrbnFvNXV3NWlPUnZ5V0lqZDBmUGhWVmphSDRuTXBrVFhHdWRHdUgzT0py?=
 =?utf-8?B?QlBvV0t0blBQdjh0cURySSthbUlJVTM5T2Iza294U1pSQXdiN2VBZHB2Wndx?=
 =?utf-8?B?elFYV1JKeVdrWGwwbzNwcDR4bTRyV3RQVFdodU5TZzlkVFlVUkY2bG9lMm0z?=
 =?utf-8?B?WTNrZEorWXBSbkFHNzkzL3NIdnFGYTc1dy9vb1dlOVVlREN1UXk0b1N4TGlL?=
 =?utf-8?B?WThOQVJzem9nUVcyZXYxRnZmY0dGbFFBZ2E2dFZncWtLK2hyRVhwbTV3K0Fj?=
 =?utf-8?B?ODVhWUlOVjFqY3NhOXcwZmx1N3FsSUs0TWZPMnJjeEE4UUxxbklXNWhvZjdj?=
 =?utf-8?B?Qkx0OWtLU2FvYUNUVG0rbmcyRnVQNzYxRkc5SWsreXh0Q1B5ZzMvSGZZRXB5?=
 =?utf-8?B?Q1kzK2V6SnZqOFZIaHdVKzM2YWo0ZVA0VjF1Tk13RkI4UGpBRURIY081NDBM?=
 =?utf-8?B?WGxrOFE0OUdoVm11dkVCLzd4aDBlaXFFZy8yd3Y5dFI4UE8zT3N2NXFYaFUr?=
 =?utf-8?B?OEJZS3RBek5xN3F4ZThzYlJGWWcwZG4zM2FNeHMyMHdmeEtoNTU2TVprUmJs?=
 =?utf-8?B?WFMrM20yNFREV2dzbEUya1JYc2VMSmdHTGZGSXdZTm9WK0xDWnNMR3RBbUUw?=
 =?utf-8?B?SGVBbFM4NklUaW1CZWpPZkdNWEpDMzNWT0tOSnJUNnp1OUNyV1ZEeUErL0Zw?=
 =?utf-8?B?ZkhISzNETFhWenA2TVdGY2M1TFBhSkJQc242M1FpTlREclpNb3ZsdUtNbVA3?=
 =?utf-8?B?S1RreWRQVTJhVld5WFJjNktRMWxhK1J4R1pxUms5YjBqNDdTbThENFNITGhl?=
 =?utf-8?B?T0hsL0JScEIwbTA5anpxVkptNE9zQWovNXg2ZnYzVDh0ay9MNy9MNjhoT0NO?=
 =?utf-8?B?L09UNTIrcjRKRG5ncTgxaTNzUzJBNWdhOWJTT1F2eEVCeVhyYkc5L2Y4TDBx?=
 =?utf-8?B?Si91RE5CMFM5YmNVeTdnOEVVa2R6V21CTUNSMFdjc3VzcFBOMHB5UkUrcXVI?=
 =?utf-8?B?NDgzblVGYTIrQnRkSS8vUTNyZnpZY2Y4Z1JMazhQL1RmUGNrSkxHMXE5U1lT?=
 =?utf-8?Q?tfMI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2025 17:12:15.0293
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0173f6aa-f31f-4aeb-9b1c-08de2ab37308
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6427

Currently, tolerance is computed against the TC’s expected percentage,
making TC3 (20%) validation overly strict and TC4 (80%) overly loose.

Update BandwidthValidator to take a dict of shares and compute bounds
relative to the overall total, so that all shares are validated
consistently.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Nimrod Oren <noren@nvidia.com>
---
 .../drivers/net/hw/devlink_rate_tc_bw.py      | 74 ++++++++-----------
 1 file changed, 30 insertions(+), 44 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/devlink_rate_tc_bw.py b/tools/testing/selftests/drivers/net/hw/devlink_rate_tc_bw.py
index db24bfc51da4..4e4faa9275bb 100755
--- a/tools/testing/selftests/drivers/net/hw/devlink_rate_tc_bw.py
+++ b/tools/testing/selftests/drivers/net/hw/devlink_rate_tc_bw.py
@@ -69,39 +69,35 @@ from lib.py import Iperf3Runner
 
 class BandwidthValidator:
     """
-    Validates bandwidth totals and per-TC shares against expected values
-    with a tolerance.
+    Validates total bandwidth and individual shares with tolerance
+    relative to the overall total.
     """
 
-    def __init__(self):
+    def __init__(self, shares):
         self.tolerance_percent = 12
-        self.expected_total_gbps = 1.0
-        self.total_min_expected = self.min_expected(self.expected_total_gbps)
-        self.total_max_expected = self.max_expected(self.expected_total_gbps)
-        self.tc_expected_percent = {
-            3: 20.0,
-            4: 80.0,
-        }
+        self.expected_total = sum(shares.values())
+        self.bounds = {}
+
+        for name, exp in shares.items():
+            self.bounds[name] = (self.min_expected(exp), self.max_expected(exp))
 
     def min_expected(self, value):
         """Calculates the minimum acceptable value based on tolerance."""
-        return value - (value * self.tolerance_percent / 100)
+        return value - (self.expected_total * self.tolerance_percent / 100)
 
     def max_expected(self, value):
         """Calculates the maximum acceptable value based on tolerance."""
-        return value + (value * self.tolerance_percent / 100)
-
-    def bound(self, expected, value):
-        """Returns True if value is within expected tolerance."""
-        return self.min_expected(expected) <= value <= self.max_expected(expected)
+        return value + (self.expected_total * self.tolerance_percent / 100)
 
-    def tc_bandwidth_bound(self, value, tc_ix):
+    def bound(self, values):
         """
-        Returns True if the given bandwidth value is within tolerance
-        for the TC's expected bandwidth.
+        Return True if all given values fall within tolerance.
         """
-        expected = self.tc_expected_percent[tc_ix]
-        return self.bound(expected, value)
+        for name, value in values.items():
+            low, high = self.bounds[name]
+            if not low <= value <= high:
+                return False
+        return True
 
 
 def setup_vf(cfg, set_tc_mapping=True):
@@ -353,38 +349,26 @@ def verify_total_bandwidth(bw_data, validator):
     """
     total = bw_data['total_bw']
 
-    if validator.bound(validator.expected_total_gbps, total):
+    if validator.bound({"total": total}):
         return
 
-    if total < validator.total_min_expected:
+    low, high = validator.bounds["total"]
+
+    if total < low:
         raise KsftSkipEx(
             f"Total bandwidth {total:.2f} Gbps < minimum "
-            f"{validator.total_min_expected:.2f} Gbps; "
-            f"parent tx_max ({validator.expected_total_gbps:.1f} G) "
+            f"{low:.2f} Gbps; "
+            f"parent tx_max ({validator.expected_total:.1f} G) "
             f"not reached, cannot validate share"
         )
 
     raise KsftFailEx(
         f"Total bandwidth {total:.2f} Gbps exceeds allowed ceiling "
-        f"{validator.total_max_expected:.2f} Gbps "
-        f"(VF tx_max set to {validator.expected_total_gbps:.1f} G)"
+        f"{high:.2f} Gbps "
+        f"(VF tx_max set to {validator.expected_total:.1f} G)"
     )
 
 
-def check_bandwidth_distribution(bw_data, validator):
-    """
-    Checks whether the measured TC3 and TC4 bandwidth percentages
-    fall within their expected tolerance ranges.
-
-    Returns:
-        bool: True if both TC3 and TC4 percentages are within bounds.
-    """
-    tc3_valid = validator.tc_bandwidth_bound(bw_data['tc3_percentage'], 3)
-    tc4_valid = validator.tc_bandwidth_bound(bw_data['tc4_percentage'], 4)
-
-    return tc3_valid and tc4_valid
-
-
 def run_bandwidth_distribution_test(cfg, set_tc_mapping):
     """
     Runs parallel bandwidth measurements for both TCs and collects results.
@@ -395,9 +379,10 @@ def run_bandwidth_distribution_test(cfg, set_tc_mapping):
     test_name = "with TC mapping" if set_tc_mapping else "without TC mapping"
     print_bandwidth_results(bw_data, test_name)
 
-    verify_total_bandwidth(bw_data, cfg.bw_validator)
+    verify_total_bandwidth(bw_data, cfg.traffic_bw_validator)
 
-    return check_bandwidth_distribution(bw_data, cfg.bw_validator)
+    return cfg.tc_bw_validator.bound({"tc3": bw_data['tc3_percentage'],
+                                     "tc4": bw_data['tc4_percentage']})
 
 
 def test_no_tc_mapping_bandwidth(cfg):
@@ -441,7 +426,8 @@ def main() -> None:
         if not cfg.pci:
             raise KsftSkipEx("Could not get PCI address of the interface")
 
-        cfg.bw_validator = BandwidthValidator()
+        cfg.traffic_bw_validator = BandwidthValidator({"total": 1})
+        cfg.tc_bw_validator = BandwidthValidator({"tc3": 20, "tc4": 80})
 
         cases = [test_no_tc_mapping_bandwidth, test_tc_mapping_bandwidth]
 
-- 
2.38.1


