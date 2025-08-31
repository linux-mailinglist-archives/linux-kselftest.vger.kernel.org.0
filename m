Return-Path: <linux-kselftest+bounces-40376-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0069EB3D152
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Aug 2025 10:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AC30172810
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Aug 2025 08:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF202494ED;
	Sun, 31 Aug 2025 08:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NAhvD3JY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA55248880;
	Sun, 31 Aug 2025 08:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756627670; cv=fail; b=TNXeNdz8mCbt1jfxEhnQzOaSDAeMkswaNiSJ2NX6z61KMhxWdGF9WNJTHX5H/ilbrVSWEPauO+PRmojbu0cKBj4OxSCKUd9Iepr4Nbt+CPAYgljIAQfrJU8sOLt7mc18bksAjEjmM6pbozz4kUvtBW4oCRm+XKDZcDcL6dlUms4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756627670; c=relaxed/simple;
	bh=znMLyknhRzWL/FJI1kX5yO/JpNGV97ZzCc4235kOGKU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QPepqJcaXd7GsSClxEDBiw52RFaitcFRyRr/gISZiPScuQ5qmczoRPpSIrnIbnRH/QhoOXr6TyYh/osrS7SPuNBqOe//Mgm1qiI4UdYwOCk9Kv4/MV/zdtXb4RdY/PTUYLGSPglh2PNNN5FHxByqq7OF8yEJeG8v+k9QVq4AYRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NAhvD3JY; arc=fail smtp.client-ip=40.107.94.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=InMmAUJ2v50FAwQXSaVK+BeoQqioiqwIh+fVs5BiDQfTHsywR+6pvCMUrsRB4wJ6MqetagZPknE+45ufQV1xpm9DfvOVv1x6EpqwD2se8LZpCqDxURzptW49mJHHG5DUYd9QG5uBgvAWL5Zzi1FLzQupshBdxG/p6X5u6cbiz1gwu7SihHCLBN5eKRhRvCJM/1DxIROeotTIbav9IDpLLn41X4qwJEzfyJxJptXjWOQraevarvKTKQCiq9RlVk8Af4oBLEwpsJDCxQLeNsy/ahq9NhDOwm35zqSs6oZflt9H1Ozu2TDglGGdWGFiH55t1a/2dCI0Mb9CRIEHtADHCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgxqoufVurILyVMf3ImeeTEawaIQsBk+M+RumWgTXUg=;
 b=e51csQ4na5i5EGQJG/iAkuzY18gCkLHTVkDrnGqCx/u5XJf0RSR+2obVQYWlv6yTSHD35coTNthYMAIDsn9bWJsbFcLp0xvvlOWXsYpciBtdc1i08q+Q7jXaTVog4a65+NaPaYicmOKczxWcVE5LCvsnlVrA+DAc9rDio/vanK2iw8RndfvqL+Q8imDHxwZO/DNJnbCDi5aWrhm6Xt1AF+ZX0k0u9H9DvDsvLet6raYOpVpQjxbfq/dmyr8IgAyKGjBm7SeIqiHUvcmDfoadoahuWgWYfYtIII6P4JWGUFND1/Yz+binkumW3eO1uQXQ+ftZ8UJhU65C5JA0R8pUZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgxqoufVurILyVMf3ImeeTEawaIQsBk+M+RumWgTXUg=;
 b=NAhvD3JYrDtoiO9x0rNBVMlbiCURVK4wz3WH1MCKWYVFaHCFZjqdV2KC6C1+iFL6g/IX0PsmSI1fo4ri4IuwDynxaEWf5dgW1Hh7y3kHov9VW0ttzS3Wi/0DrWt5nvBy2npAjE28hWDJIp5JeaXkp3zMt4+6V3hkoHKOGrpUccWIS+GCnuTBy+mtnNBdchhnvummwbBdRWJXtOgAemUg8byeN/ahuWX8unVmXIHim04eLZUmjRoQBRnSN+7cfN9Rl3UcWAugO0FE4odursB0th5dN2xIbWGRYYbdjreAcunEmaJK52ceSdyG2r8lLEu7QYd7BstDJ3Xe41hRaWxCMQ==
Received: from DS7P222CA0020.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::16) by
 DM6PR12MB4090.namprd12.prod.outlook.com (2603:10b6:5:217::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.21; Sun, 31 Aug 2025 08:07:43 +0000
Received: from DS3PEPF000099D4.namprd04.prod.outlook.com
 (2603:10b6:8:2e:cafe::62) by DS7P222CA0020.outlook.office365.com
 (2603:10b6:8:2e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.25 via Frontend Transport; Sun,
 31 Aug 2025 08:07:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099D4.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Sun, 31 Aug 2025 08:07:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 31 Aug
 2025 01:07:23 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 31 Aug
 2025 01:07:16 -0700
Received: from fedora.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 31 Aug 2025 01:07:12 -0700
From: Carolina Jubran <cjubran@nvidia.com>
To: Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH 2/3] selftests: drv-net: Fix tolerance calculation in devlink_rate_tc_bw.py
Date: Sun, 31 Aug 2025 11:06:40 +0300
Message-ID: <20250831080641.1828455-3-cjubran@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250831080641.1828455-1-cjubran@nvidia.com>
References: <20250831080641.1828455-1-cjubran@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D4:EE_|DM6PR12MB4090:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f1ba594-ed04-4b2c-402f-08dde86576b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cit6VHlZZ0RTR1V2UFFIaHhHREZPS3ZxRWhkM3ZaUGtvNnc0TWN0amNxRXNq?=
 =?utf-8?B?TWJWbFBSRk42ekRsN3FGY1VjR2Y3NVJvaHptRzRvbG4zYUhRVnhpSWF6TStF?=
 =?utf-8?B?dGFad3BUelp6YTVkai9kSXBpK0ovdXVxRG9ETjFRaTY5WTlTRkZmWjRXeU1u?=
 =?utf-8?B?TGpyVkVxV2lzb3pxK0VraHBwcXd2WVdFM1hPbUxheTZXYitrcFdJb083NGNo?=
 =?utf-8?B?RUNIYlI2YmIvRS9jTFpUSEFtUHV1M1Q0ZVZMZ01meHhzUm0vQzI3dnNFR0NC?=
 =?utf-8?B?c2tKOW80WGxGQ05DejZBWlZnTHhFQ3FLSEV0TVM5c2NIOUVZZHFIeDNidmNS?=
 =?utf-8?B?SFR6ZjFzT09BVWRtN2pSMC83WXRRUm00R2lCY3VkNlpOeTR0cXU3UUpmNk12?=
 =?utf-8?B?Vnl1a1BOSnJ3WnQ1RmpnWmsvQXNnenZaYUNEYmFSWkRZWmNQU1NlUlIrak0x?=
 =?utf-8?B?VFJjSzhmb2JhTTR5Mk9YSEhDc2NLUkRQMk9aUVdRZHFUbGM4Z2lFK21sNHkr?=
 =?utf-8?B?azNYaUg3ODBqVTRSd3FHQ1NybUtXRkxObnRJZ0ZPb3BkSDZ1bHNmYmFocWhD?=
 =?utf-8?B?Mjd2Z3dRMnVaaUNiS1RPYzI1Z1RXeXRkMUJLMHZuZ3lrc29qQ2xDSEM4VWh4?=
 =?utf-8?B?Zk9QbXBXeEFMS2dmdnJZY3Y5V2tmL3hFV1RqU3M0RWVqWHJaVTIvZFh4elBM?=
 =?utf-8?B?TFNNOXVUeUJUbjNoYVhqRWh2MWpxbzNxSE5Rb0VjVURuMUF6Rm1ZT29hWDBN?=
 =?utf-8?B?WFdaTnU1Nk9qNDJqT25FN0VYU3g1WmJnTnl6cXNUSkdhV1lNZENVY2hmMm5v?=
 =?utf-8?B?THlCdWQydUh2RW1KSmtRc3pnZlJBOVpNZHBhbDZvdE8yMXlHR3BSTHVobWlH?=
 =?utf-8?B?QzdNUHcxcTE3cTFjdktWTFFZdDZJQTBlNGwwODJickpXb3N6THV3SHR4WHFU?=
 =?utf-8?B?V3ZwS1hzRjJhM0w4YTkrbUxPRDZTRnU5QUtXWkp5cUFERzJDbFlWYzJOQXRj?=
 =?utf-8?B?NFV4cDZBY2VBQ2xGOHNYTVM1L1h6Q0dzWDViaXJiVXdXbkV4cVFabVR0V2Ry?=
 =?utf-8?B?aDEyWmx4c004RVIvSG05NXpkWTZ2a3BBYmZWWktwZGFMZm02VXRHbXpMRWkx?=
 =?utf-8?B?clVOUnFZQUxGOUtNVXJxL0xvNnpMa1Zhd1NiMTJTRUxPWEVMdnBEU29HaW4z?=
 =?utf-8?B?WWlYbEx2WVhTQkthc2FhL3lybGU3TlJSZTBjaEIyUHpiZXlBbUNDVlYxbFRX?=
 =?utf-8?B?WDBmMDZQY1Q1Q2VjNTlDY2VTVHJQUFFZL3kwYTVCOGlNNC9VcUlwZVd0Z2pH?=
 =?utf-8?B?TVBUSWQrdlJHMVl0ekFSZEN6dmU3Q0NoQWh4QzBZem9MUHo0SXpma0JBV3lJ?=
 =?utf-8?B?aFh6YVBXL1JvTStUZ1pZbmU0QXdobHFRLzRUdXpJZHlWUHI3SnFFdGYyK09n?=
 =?utf-8?B?cUdlZXc3aUQ2b3hDQ2g5cGRxbzhIYlpUcEdGV3N2LytXRHRhZERCU1gwcjdK?=
 =?utf-8?B?cHlsdkRXNVYvZ0F2eVAyWkw4OXRrR3BzTHhVYWlUMVpCWWJoTWxxU09XdFRG?=
 =?utf-8?B?NHlVelJ0VkJENDRsZm8wNElVM1RYcnpuUkdLeExjTUlLTFFQL1Jwek0rckZh?=
 =?utf-8?B?NFlGYlZHQmlvb0JtdGRwMzhaRjd2WWg0Zm45SytLUzRhR3JQd1dCeU1SbTFF?=
 =?utf-8?B?VitkZnRpNFlyZVdnNDd2SnRnclI1aVJTdURQYy9iaEUrbUsvQ1VBM2IvcG5J?=
 =?utf-8?B?YUZIVUM4bUxLRndPN3JWSFZFQUFyNzFRcmJGOEg2Uk04dVBzd21yYzhoWDBa?=
 =?utf-8?B?cE5qZjZPMGUraU9FY001dTI2ZGVBeHAwb2ZxVXBBY2dIclRRcExkdXRkWnc3?=
 =?utf-8?B?Z25TWUt1UWxrRG94dVZZWmM3L3lNeHBvNFNsQTJnTldjYzNRaWJrVWxMT1hG?=
 =?utf-8?B?cWowYnhsRzFXYXpBanNRNVlLNUF4cDk3eG9PNGI5TG9wclNNYzRUUnIxeDVk?=
 =?utf-8?B?bVN1b3JPbWcvaTE0WVRBQ1A2eURmbFNEcmlaOEt0L3VKRjNIRG9kQmhlUHFm?=
 =?utf-8?Q?OuQxr7?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2025 08:07:42.5800
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f1ba594-ed04-4b2c-402f-08dde86576b2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4090

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


