Return-Path: <linux-kselftest+bounces-41051-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43435B4AA3E
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 12:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E3251C255D4
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 10:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CE43218C4;
	Tue,  9 Sep 2025 10:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MlLVg+FO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C58C3218C2;
	Tue,  9 Sep 2025 10:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757412951; cv=fail; b=t1+o2hJvqXlg/688R6tXh9TVRlxtYsTSUJb/7Q2vjXegW3L54cmdBYMqpDNT02i0sC49BW3hlRrZXRqz52sV/zwENsRlseDzCSmH1Og1W2EzzraI6TydebIGgcj08WioClSodiuCSY8DeBUQzwDEOtNSAj5lTt9TDwxCr24l3oc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757412951; c=relaxed/simple;
	bh=znMLyknhRzWL/FJI1kX5yO/JpNGV97ZzCc4235kOGKU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SI8wCfqubiccM4g9mGml4QGz3H62j2zF53l25XLNXzIWISUjg+G2ZMt1gb+nFrUFsXEAaEPmYXLrFMtHIYSCugppaeJOHZkSHy2GOMeR4Gu6C4It3E+5J3q8UpwFgdSQFj8OMrGj/pF4fcNWK78Rjadzxz9Q54wC5wO+WxTEsig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MlLVg+FO; arc=fail smtp.client-ip=40.107.92.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TOyIW9gSYdIV0R5ZglYV0PPW+u3eGSZhLe+Ce6FNVdX6RR7M2uoJTxsT/UF1L4EMxKuS+VuXZZcd+uABMe4Ds+qh2Y6p1ShJwcwOlmJyRO//qf0e7K4KzWKHW6z9gj4nfGhnfDV6xNiVkemiGGwKdv7hrOhHcCLxL8z9F+3AwvFvokGKR1Yl01Ep3e+CjDhL35aJqPng5+W+vGYijHcnxicMkKv/ytEpjW9Yi9OqSAA9O1aYuF7AkPK0v1m4PR/MfmAdsQOg1euRdPIlryz8wAj+RdwtsV17VyrXbp8d9vOpOzWHwNiChLXdkPsOG0Is899YlWBsfIXBH7NYl1O+ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgxqoufVurILyVMf3ImeeTEawaIQsBk+M+RumWgTXUg=;
 b=YtBbLVTmKx2Ij7DaCn/0eT+mHlfxwdgJXHB0oWgjHxPqz9g1Gm2oYlauy8wVqnkMIWCr1MRIb7AOCVKVzmBXX/Y7lNsjcWz9xIIi2vvfYMM7YP09JgyH9ANGLWfpEV86/eKwR5oETWGyGk2bUbHRrsEfxbLfmUxy3TpvEcCIC+99MjsNVmQHlffXgjJ9EQ50HIBcwFDXZt7ij2cyGYWGZE3JdrvRmt584hG5gmK8pUGwxovgPivUqv1KDTs6mzM9IcTOmJIh+z5+UCGD6hotPGu5Y4HiIwNySA6aHayv/0xMhho0/IkVCSi4+fLxL3oaEtK4S9nxPJJQyeni1jX86g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgxqoufVurILyVMf3ImeeTEawaIQsBk+M+RumWgTXUg=;
 b=MlLVg+FOgD2S9V4ljdTQmvas+nz9+VEy16wDQZTB+8Es+OGNzRP8MonSPyYzcqA3wgYHj/SyMDuuR36PsBBbA3CLeQFFQlxYWFpDKL1suiovS4/A9WSUSgbn3JLXpW8zahAl6gKE8ndqLk5UaJBHf0B3owb4kntig0+2F0gL5TkdapEjDbo+dUaGaPOr68l0/7hoLeZ2oB4lJQFvRzdd8Yehj+LoFvPqMIgCdmLe0ECD0Nu7ROPmS1ot1spkB5HlVN6RPjdU+6uoNyhvSrfQByESXsFbWYAmFNClfV4YcVnHJ+ROM1JYafMdIHw54qswCELZiIgvK0FDc6ehGO4wkg==
Received: from SJ0PR13CA0118.namprd13.prod.outlook.com (2603:10b6:a03:2c5::33)
 by PH0PR12MB8127.namprd12.prod.outlook.com (2603:10b6:510:292::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 10:15:44 +0000
Received: from SJ1PEPF00002325.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::e7) by SJ0PR13CA0118.outlook.office365.com
 (2603:10b6:a03:2c5::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.14 via Frontend Transport; Tue,
 9 Sep 2025 10:15:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002325.mail.protection.outlook.com (10.167.242.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Tue, 9 Sep 2025 10:15:42 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 9 Sep
 2025 03:15:15 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 9 Sep
 2025 03:15:05 -0700
Received: from fedora.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 9 Sep 2025 03:15:01 -0700
From: Carolina Jubran <cjubran@nvidia.com>
To: Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net 2/2] selftests: drv-net: Fix tolerance calculation in devlink_rate_tc_bw.py
Date: Tue, 9 Sep 2025 13:13:53 +0300
Message-ID: <20250909101353.3778751-3-cjubran@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250909101353.3778751-1-cjubran@nvidia.com>
References: <20250909101353.3778751-1-cjubran@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002325:EE_|PH0PR12MB8127:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cccbd7c-eff2-4167-54da-08ddef89d625
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFo5ZTJPSXJ1QkNsS3N2SERiOW96VTZNNkhuWG9XejdENzIvQURuQnRXUlIv?=
 =?utf-8?B?TTR6emtyZnJLWkx2MVUxNFhyKzZGSEl4S3NzclFUNi8wZkk0NUZjZ1FnVjJT?=
 =?utf-8?B?RFJReWZjS2x6S2JOSnB0d3JOSGo5S0JqNzBERzlmQ1pIWmp3Sk04T1c2Wjho?=
 =?utf-8?B?WTJVbHRwbHVjRDg4WUMxRmpwc0JNemFFdUFpcG16cnovT0grMlpjV0FFYUxP?=
 =?utf-8?B?S1BpaENpZUd5NWdGSWxDQnRnNURlcW5PcFhpVkN1VHprb25XbmNTKzg4ZUZ3?=
 =?utf-8?B?ZGNjcHFrMVVGVHhHc1FoejRBUGgzSzFISThaZmZDSnZxUGJDK1pIVjMwRGky?=
 =?utf-8?B?SEZzcTZDWVFNemtuZ2RDYUVDQmV2STBvUG1xazExUkNIcVphNkpoRENRbDdW?=
 =?utf-8?B?UlgrL1dLaVM0SFVUT3hyY0cvK1FSTzB6UjZtWm1lajRjNmJ3L0hkem03QWhm?=
 =?utf-8?B?NG00dUtMeE1CYjJHcmJLMFJzeDc1YVIxdjlVODEzZTRqa2hKSkVEaksyMTJZ?=
 =?utf-8?B?ZUdVZW1jZ1RnV2JjL3Q0RUJFU0lESitZV0pGUmFlMHBlV3hheHBQQUdkRTBv?=
 =?utf-8?B?bHNVclcrdnp0dVdMZSt4ZGpOdEp2SmFib3BGMVZCY2s0ZFNGS1dkWitkdC8w?=
 =?utf-8?B?UXJ2TUpJY1p1Z1JyZ0JZUjlnSElMZXFTeHJZSGVQOURoRVBKcUo5SVA4SVdp?=
 =?utf-8?B?MHhubWUxdmVEL2xKYkl0R1ZhUUFQempkdi9ZSmJGRjY4aHUrcitWaFFNaXJH?=
 =?utf-8?B?MXh4aWppZURic0J5K3V3UENqbjBLcHI4RHJJZ1VUbEs2dE1SdHBCeG5GaWhT?=
 =?utf-8?B?R2lObUlIUlh0eWszaFY2WmM0d3R4MlJBRllMdjd5SVVXcjI1cGdVQWJrc2hn?=
 =?utf-8?B?QlJwdnduWnlsRmpvZmN2MEs5eWdMNXNoS1FnSmMzdXQzM2kzQjY2KzIyWEw0?=
 =?utf-8?B?TE9rTmd2R1MvaytDdmpmWkhoNW9xMExncXVoM0hXYnJjc2hOQ00rTitpeThi?=
 =?utf-8?B?TXVuZ21WNzVnc2ZTWENGNVZyNU4xd2txMU1CdUQyMitpUmFhM2c1VzNOQzM2?=
 =?utf-8?B?VWtQQXArUytIUmwxZVBXdlVMclhUUDhnOTNDMkhkZ1JPazBiY0ZGQncxQmd5?=
 =?utf-8?B?QzRsUjVHSG4rUXNiS1h1QkFqOHhIakJ4ak9tY043SVBNQWtCSHZiMGUwY0sy?=
 =?utf-8?B?UzhBSkMxSEJEKy9XWXhyckM2cEVtMm5oZ0F1Vk5aZ1BDZXNlL01sLzB6YUFB?=
 =?utf-8?B?RXlzTFFpTWRlTjFTMFVwRy9SQm9sVUZQcktuMTJWeWFrT21SZGhQY0t4MGYz?=
 =?utf-8?B?MHpDYVZpdnRIWkFGN1YwL2pzaU9iMlVLSWRHbTJXckVNaThWNXdHZ1BBTzBu?=
 =?utf-8?B?VDlLMFRGY2R0bEtWRnBIQ3pPWnhaeURrNW5Zckg1bUE0Wk80R1dFUzNSTlk4?=
 =?utf-8?B?T01NcnFUKzFqQ2NXeDhTMkZDODN3Z0RRRlRsYmVhNngzYlViNlBzM3JYM0NG?=
 =?utf-8?B?eE9SK0QzSnJZMXBFWlowQU55MCtzNytpOE0vOVN6SUVFN0dsdEQrWnJkWDh6?=
 =?utf-8?B?eE5XclJkS1VLQnErMVd2ODNGaUNWZlhSSStwU3ZUSGVhZDRCTit6OU1HQjBl?=
 =?utf-8?B?STF2bEQvMzlCQnZxQUQwNkczWVpwWTN0a3gwYzdIOXFaMlAxbnhCZ1Y4RTZp?=
 =?utf-8?B?UlBHd3NMMDB4NjE1ME5BZ25wMXJra3ozK0Q5bjdsQVU2YlVvQnVoYmdZL3Yx?=
 =?utf-8?B?ZGVvb2k3ZTVUYTUyRUJZSi9NTERXc3FMb1JhTFBuU3BVZmxEV1hzcEx0UzRO?=
 =?utf-8?B?Vyt2cjRud1o4c2lrTjlrRHBwMGFJU3ZCSXZQVTNuNUVLbDZOcG13WEJmalUy?=
 =?utf-8?B?YUJnOWlrcit1TFR5YWFlRlFHeTZ5NER0SGIrbFFYcXFFejFKZlB1ZWl2L1V1?=
 =?utf-8?B?YXN5QVZEaXF2WEM4Qi9QVnFEQlVGNG03NHhBUDJNdEpmNlRhVm9xSGVXWUlh?=
 =?utf-8?B?TGFDL015aFZhcTBxd3FpWHVsdmc4WHZZMGFzOUZ2Wkc2WUdXb0FaeTlZaHpP?=
 =?utf-8?Q?0W5nuQ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 10:15:42.5503
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cccbd7c-eff2-4167-54da-08ddef89d625
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002325.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8127

Currently, tolerance is computed against the TC’s expected percentage,
making TC3 (20%) validation overly strict and TC4 (80%) overly loose.

Update BandwidthValidator to take a dict of shares and compute bounds
relative to the overall total, so that all shares are validated
consistently.

Fixes: 23ca32e4ead4 ("selftests: drv-net: Add test for devlink-rate traffic class bandwidth distribution")
Tested-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Nimrod Oren <noren@nvidia.com>
---
 .../drivers/net/hw/devlink_rate_tc_bw.py      | 74 ++++++++-----------
 1 file changed, 30 insertions(+), 44 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/devlink_rate_tc_bw.py b/tools/testing/selftests/drivers/net/hw/devlink_rate_tc_bw.py
index 4da91e3292bf..abc20bc4a34a 100755
--- a/tools/testing/selftests/drivers/net/hw/devlink_rate_tc_bw.py
+++ b/tools/testing/selftests/drivers/net/hw/devlink_rate_tc_bw.py
@@ -68,39 +68,35 @@ from lib.py import cmd, defer, ethtool, ip
 
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
@@ -364,38 +360,26 @@ def verify_total_bandwidth(bw_data, validator):
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
     Runs parallel iperf3 tests for both TCs and collects results.
@@ -406,9 +390,10 @@ def run_bandwidth_distribution_test(cfg, set_tc_mapping):
     test_name = "with TC mapping" if set_tc_mapping else "without TC mapping"
     print_bandwidth_results(bw_data, test_name)
 
-    verify_total_bandwidth(bw_data, cfg.bw_validator)
+    verify_total_bandwidth(bw_data, cfg.traffic_bw_validator)
 
-    return check_bandwidth_distribution(bw_data, cfg.bw_validator)
+    return cfg.tc_bw_validator.bound({"tc3": bw_data['tc3_percentage'],
+                                     "tc4": bw_data['tc4_percentage']})
 
 
 def test_no_tc_mapping_bandwidth(cfg):
@@ -453,7 +438,8 @@ def main() -> None:
             raise KsftSkipEx("Could not get PCI address of the interface")
         cfg.require_cmd("iperf3", local=True, remote=True)
 
-        cfg.bw_validator = BandwidthValidator()
+        cfg.traffic_bw_validator = BandwidthValidator({"total": 1})
+        cfg.tc_bw_validator = BandwidthValidator({"tc3": 20, "tc4": 80})
 
         cases = [test_no_tc_mapping_bandwidth, test_tc_mapping_bandwidth]
 
-- 
2.38.1


