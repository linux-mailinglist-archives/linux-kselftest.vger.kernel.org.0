Return-Path: <linux-kselftest+bounces-46748-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C45A9C94D0C
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 10:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9DA124E0FA8
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 09:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCDE277CA4;
	Sun, 30 Nov 2025 09:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AJg4l335"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010061.outbound.protection.outlook.com [52.101.61.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780E12773EE;
	Sun, 30 Nov 2025 09:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764494503; cv=fail; b=PtRNTSJ+SK1c9aoWC+cEIkLzKCmVIHorrTQWDCtDvGCOu6eFCBMuJZTXFz8Uzzi9sCj+3QYn4r5GeGekgKI42u9qWfFdVXvxQJ/89O51JR+EHJHZr6BeWp2xaL/WOxXDhgpQ6irpIrMN3y/VIxg3H1eTwIbrEoU5Z8vXPGr0t8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764494503; c=relaxed/simple;
	bh=KDwQCmXunXAK57wOAPlY8Zdnv6bCq+2jGDjNgaiUz+I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BQZZvvjGNt1q2/G1m2GOKHGg+anLreceKTPQk7rEJuzaKtgdmoUMcFFiPSuLPn8nDkvpdVPKJFjVYqMeeKcim9i9l2mqW0vVlXeu/9J4p7wx/oLBLJRn8w+ljSoWzCfSTIeNTQJO4xQo0NWK2Q6yE+p5B8S6E5Nnm/borCNv1zw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AJg4l335; arc=fail smtp.client-ip=52.101.61.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJ44gs3ODa75hqA6OuMkN7btIUcWsRW+I6nQrPiJY/0nHfBwsUaDutNJuQLRCqSzTE173gl5EAYze07vGcU1fb2WtnD437MngrhPWeO20kCdIcXFmUE9+0Plwxm60IO1QSgLz+ZvBa5Xr8qd/fuUlV1yXVOGngiEj9zLBRp+LupmoBK0TcAKDyoD0Si3vzzlys0sDk6N98ORTef23jiJVGYFh5Mr/qDsdqaskWvUA9Jb0L+R9F2CLlA7RYX015Up22EZIk8px0VGMg7K94/a0RIFaGtNAV4x3NpBxjHw1u9JYh1umFd1ASaKttpfwynS2YGxLAvT4WxLIw9qK25Omw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ijd0bHM1g9JbvS/k9b33eDUgJm0w6ibJpkdhtrL7VBc=;
 b=av/y++6JOmIRSfNCvBLi4RT+Nt15MbaGdRKXSvRWJhUJZJwsG5dnt9jCynWO4D3+qmnKG5f2uW59OTtZlH+Y9RtpJVtScayVFbc/mXbZN2bK68WOM5c8O7gcfHFv4kxtV3NsiZFjVQsNpc6JsOBwbxuztdCPpTXA+1yOqOXGRF4aEA+JqqORZyrkMMmoreGqmxFrUl/e+rqqBSylP774tWGkNsoyKUl2BmQLvr28exppzqduG6MJ5yps9dVpzCBWhHSsOlYspeSff893iYcKlvE6NxMrd1gAvpwzoWXlmlJndqWxMpdrUYjhyzae86Si5CmPF5PJK3ODRF6t2FyZig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ijd0bHM1g9JbvS/k9b33eDUgJm0w6ibJpkdhtrL7VBc=;
 b=AJg4l33564/3BpFXUSmJ+0fCpYWjH8Ck2hFfT878jOZXGBqkW7Io/L+G75HxGi/NCHn4BXhw+OwqI8wwl1TJmNF1vW2OCOutc/On/KSmjfnbZPQAaYkxhSseRz5TAkeoPGDz33bR9OlJzrV5sM5O78GQONO7Ur0H/kVj9ny+npasNryXcgbltMGymG7K36eQdHWcKRjq/e7PmlsoRIpPtWUosT7z9Oc0Djqde1b3JBR+nmURuUw7mGqiDBZwbUpvo2rIPWcC3DurvPi9CMj9Txd1qnYDLDGvJU4kFgOW8EqoS7GIlE0cD6opEeAqbKojRdte6ZPkBZRQSyZRiXQLwg==
Received: from SJ0PR03CA0166.namprd03.prod.outlook.com (2603:10b6:a03:338::21)
 by MN2PR12MB4125.namprd12.prod.outlook.com (2603:10b6:208:1d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 09:21:37 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::9c) by SJ0PR03CA0166.outlook.office365.com
 (2603:10b6:a03:338::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.12 via Frontend Transport; Sun,
 30 Nov 2025 09:21:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Sun, 30 Nov 2025 09:21:37 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 30 Nov
 2025 01:21:27 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 30 Nov 2025 01:21:27 -0800
Received: from fedora.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 30 Nov 2025 01:21:23 -0800
From: Carolina Jubran <cjubran@nvidia.com>
To: Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH net-next V3 6/6] selftests: drv-net: Fix tolerance calculation in devlink_rate_tc_bw.py
Date: Sun, 30 Nov 2025 11:19:38 +0200
Message-ID: <20251130091938.4109055-7-cjubran@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|MN2PR12MB4125:EE_
X-MS-Office365-Filtering-Correlation-Id: de4d7ebb-aacd-4d0f-d90e-08de2ff1dcf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MHZtS0Q0SWlIbDE5RTBsblAyZzhyVkwvbkVOamNtVi94Y3V2K3BpZ0p3RGxo?=
 =?utf-8?B?aUV0WUhvS1ZEOE1nTWZ1bjQxZGlwVlB1MDllcDRHcU1iWVkwTW12RElxZnpT?=
 =?utf-8?B?bXRONDljRnVTYWpBbmYvQ0VDczJnVElibWx0UnRJYWhaVTQvVmR5aHd5ZVBN?=
 =?utf-8?B?SXRWTXA0R1BEOEI0RlpvU0xxN1JTMmNjblkydnBXTlNDQ2ljOXA4aHNZVnI2?=
 =?utf-8?B?dXAwQjhSVkl2MzNER3hDZC9Zd3dhVm5tTmdtZHJUTmF0SXJNeEVZWmk2VDd0?=
 =?utf-8?B?cDlQMkRZZW9GR2VRS3FsVFlGcHkwNFFJRnVCRUpsVUl3cjhWNGJoMWNpdEZ1?=
 =?utf-8?B?UWlrTEZmTDg0V1NvSFM3QXNuL1ZVRTkybTZCZjlCNzRKZXVWZFRTNXRESjZ1?=
 =?utf-8?B?TmQvK2EwYkNqbWxYS1B5ek1odkdKenk0OEVEZFNOWCtDcVBiaExSTlBhaUZB?=
 =?utf-8?B?U1M4K0dULytHZEZ2ZjJtMUZvdTRoTzV6U1lNVjR6S0F1SUdXVnRFTmxobGl1?=
 =?utf-8?B?NU9vSUF0bEpVRmF0T1E1TTY3VmtkSENVcmpFNnNCU1dTdmErSGNiRE1saFor?=
 =?utf-8?B?MWhSV1VkbERQa2ZKam91VWsrdjhqa2VJMlkrOFZOWHc3QmV1YnB2U29qbzVS?=
 =?utf-8?B?a282VTE0L0NxSGtZS3Jjc1g5aUIzTnRyNU1VTnJVa2dMYnVqbzErZ0ZZY25l?=
 =?utf-8?B?cUx6UnN3WTd5R2lWTDZ1QUt2cnlzcHdFdHN4eHdnc3lqbmVrUC91ejNnQ1c3?=
 =?utf-8?B?dFRIR0RtQVlCYkpaMzVjRUVvcmUzZVV5ZUhyT2p1NmdHNUtlODdLR1pOeWdQ?=
 =?utf-8?B?ZGZud3g1RUVzR29QMTVCZU5PNDkzKzluQUJ2WlJnVGlvVVdreitFUFdrUDFz?=
 =?utf-8?B?UFlpS1FlNkN5UDBuOENlNytBcXZLQm5mU3p3eWFHZHlZMTJRUjFrWGozUFVN?=
 =?utf-8?B?dU16cmlxTnZ6SXI1L3FMbFdVN2JXR2xrVE5LZStmY0JxNG1Qdkp6V3BRY0pa?=
 =?utf-8?B?d1V2MlZLSThiK01BRk5Id1NxTUowQkQySmh4TVN2Y2YwRHJ1SVBzTkdDYVM2?=
 =?utf-8?B?eEZocG1TV3YyTitNRHl4cU5idGlZZnFZVXI2MCszQjhFN09xU08zbkFWVjlr?=
 =?utf-8?B?YkhWcUtWekJ1bG9HRlRaZlVXRDZ6ckRtZm8vRzdTTmpJdDFEZUUrT2tHOTNF?=
 =?utf-8?B?aTJ4VzErcHpNOEZXWC9ZQmRtZnRPZHFVT1dJdW1BeUZIc1ZLWDErenpXSDV2?=
 =?utf-8?B?M3lHZTVPYWxZais2aDBsaGZCOWFTVTBIN2lvblpyUzlveGk3SjU5U1hNNFJm?=
 =?utf-8?B?dTRQWVUxZVpnMEpqamtxWldhRkpYOEZ5NDdRdmpheTF3bWJFWjA3bEV3cmtV?=
 =?utf-8?B?SVZCNkN2UmlxVU1vNHpxZGliUWF0ZlRNcDIrcGVBT1RNMGhWSUpMcklwa0gr?=
 =?utf-8?B?YityS29QaDdVUXE2VWRab1FiQ0dNYjlkSFdqdEIwbmJ4NEhCcDFyRjk2MzVm?=
 =?utf-8?B?VXhrM2NkU1NBTGdEdC9zMjdSUmUrTHVReldxbCtVZ2JDblFTaDlEZ29WTFBC?=
 =?utf-8?B?dXI2ZTFrUWgxbmwvcmo5L2VBS01wei9MYXB2MWpZNEpDMHhYcFRDOXBaVHh6?=
 =?utf-8?B?RWhaQ0luSnFOVFNhSzBTMkhYdFo5UE1MNXdSRXNtalB6QUFGSFJQcjVpQStV?=
 =?utf-8?B?NzQxZ3J1Rnk4WHNkK0QrYlYzZ0F4UGFkeHlLS1cwSjNUWmhkcDhsaFNXM0d2?=
 =?utf-8?B?Nm1FSTQ1bmgzaWdSVjg3VkNycnZEa25JVVUxRFJCVmpHY05WS2U2R1BXY0Vv?=
 =?utf-8?B?dTBuR3U0QW9uUEpIWE1WSzZ4aHBvZ0dNUC83WTRaaVZsTmNlMVpmSjhXTUZL?=
 =?utf-8?B?REVxVzdRdmRJOW01K25ZRm1NQ0IxcVVjZTk3YkYyckZ2LzYyR0MrOGc0Slgy?=
 =?utf-8?B?cDJBUmxHUVovb2Z3RHdDa283alRjSHJweFZjY09GVXk4WC9rV2ZyZjBQR1ZK?=
 =?utf-8?B?NnJrSUFra01HOUtpa3Ywa29BclpodWZhMGxCVGlVRzhuUlAyenNYZzZ1WDRS?=
 =?utf-8?B?NjlNSDRBdElKUUNHSHlwaXdaV2N0VXNJd3VvMW52aVpYcmVXZHFzUENsKzE0?=
 =?utf-8?Q?klNs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 09:21:37.3743
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de4d7ebb-aacd-4d0f-d90e-08de2ff1dcf9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4125

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


