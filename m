Return-Path: <linux-kselftest+bounces-46091-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3A8C73603
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 11:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 525A235ED14
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 10:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C9E31ED88;
	Thu, 20 Nov 2025 10:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PMhOfywp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010000.outbound.protection.outlook.com [52.101.193.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9441E5205;
	Thu, 20 Nov 2025 10:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763632879; cv=fail; b=YJRWQpHiKoRBg1UUMJThbrjs3LB70QONR4YCZkO//HTVmVyGAfmWpOPdxmmC5SOKK7r5zwAKRzIlt1RLS8ilMjRBS3sB99nJ2E+aMsVCApxJwE3zQAlluw8Dt7QHkFXHmHu7OdUGlaY9XLs+KByGGG9Rt0VTE7ACNlb11Hu01f0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763632879; c=relaxed/simple;
	bh=KDwQCmXunXAK57wOAPlY8Zdnv6bCq+2jGDjNgaiUz+I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i9e5TQ+xcFC4P8jBusKs+H6z8GPv+I15mdFUcHvC+EyOSTTn6eBikNhsMmuCZe37/Y83zXSG+FequndIQBRGTG1Su5DzzRQuaiT2eEJZiQ52yk60vrCAWNOBEKkep0+igYd9oiJzVdI0twB4/tbfSIOBMefJaGJN6W9h9GPwEgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PMhOfywp; arc=fail smtp.client-ip=52.101.193.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z6WJ/e7MaYRDRdYO7pNQjP9qSiVluha2w8zm1v4Ynrsy2VXFuwK885OOFwsOnRppB+TYHOXYy95PgiteqVlhTtogcAamN6ClworyM4Vb1246dSRABbZgtHDlldx4hV/vB97i2J9zsFjFQPazTSeZE9GcN/wkRbFop2RIFZd/6CjobGUV6lrRTpZIIpVCN+oUJSreaYHt3HMx2ygHe6MdysoOeCzLcwH9N8HFGR53d1bFhmHUSLCB6BH/8WF3CInfypaLy+z2Om0T+DdxYK+YpyH8GdXYaN89zPs/1L/wRqSU4p5F94IUnRNKiu7DYXhTbu3ChoWD4rIZjBGKvq0lkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ijd0bHM1g9JbvS/k9b33eDUgJm0w6ibJpkdhtrL7VBc=;
 b=cuoBe9TPVc1g92pwjZdq13GA0l7XANvxavT+0I1iilFWAFI1cm0sVMeBerbfxHhpD9j8emjnRwNmz4ThHS8rvgEnUpnFcLtCOSccuCqmFL62DdxYvKrkYQxP1wbOeUoW5RrLcAOkWLMkgNCSB8qqICYERDrVg/hGrqRG55ZUA7yJI5YbyIoPRGk5AsFGUfo9nOgOG7nDhmFZD2b68rPm/AGapDR5Q4XvtXKsuyT78LoFq2efZ0P7R6kHMu0yw5jLyA8HZU8OUvMykIllMV/uqQRscbRfCuuAc1WgnVjqhLxBj5TYhyl31aRe0UmxCcHuyqFkwigImoNHVWfXqhVk/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ijd0bHM1g9JbvS/k9b33eDUgJm0w6ibJpkdhtrL7VBc=;
 b=PMhOfywpnPnJnijwfNkfFt/1xiagumBsGLtt+ClI3ibIE6YDOAAoV76uWeU8mBgf/+S4cEl+EcsZcHSJhjd8F1+Fu9pvH//tQpwNwK2OstCHvvCzI/h0Dbr3AUtgsYv5GQl9w/2zhHShJTTeKiiZ+q/lmogT+g9NP82zW6vE6YtX6MdWRb01ExpwPBWMXTYJBRFiUBmucM8cf8ikMmb0q0sUNHfjwOXeZUP59d6Jj4Ewgd64jmWQiBH7wkw/Xp6S5ix5PEkDCwvHRElhCAz9lKNkJSAOSbXLxMafS+Jk1gPwmLVIaf9b2EnrddGGyLFdYcRD2U0qYymT3vvEjC/sfw==
Received: from SJ0PR03CA0368.namprd03.prod.outlook.com (2603:10b6:a03:3a1::13)
 by DS5PPF1ADAD2878.namprd12.prod.outlook.com (2603:10b6:f:fc00::646) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 10:01:09 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::15) by SJ0PR03CA0368.outlook.office365.com
 (2603:10b6:a03:3a1::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 10:01:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 10:01:08 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 02:00:50 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 02:00:50 -0800
Received: from fedora.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 20 Nov 2025 02:00:46 -0800
From: Carolina Jubran <cjubran@nvidia.com>
To: Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH net-next 6/6] selftests: drv-net: Fix tolerance calculation in devlink_rate_tc_bw.py
Date: Thu, 20 Nov 2025 11:58:59 +0200
Message-ID: <20251120095859.2951339-7-cjubran@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|DS5PPF1ADAD2878:EE_
X-MS-Office365-Filtering-Correlation-Id: e5e75301-c606-4190-8c6b-08de281bba4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RGY5M1RML3B0SmJ1NEQxMFJub2JnYldqbzZIbHR5YnYwZzh4clQyeTFIdDdy?=
 =?utf-8?B?WmZQWVNFT1oxWnZYS0JycEhENVB2WmttaTl2TjZqLzlJdkRXTStvcHVNWXpj?=
 =?utf-8?B?VXYvcE9TWWViSmxIOHowQURORHFSbysxVFJzQnJVTmZaUGJ2UU5LMEZ5bjFw?=
 =?utf-8?B?YmJXM1QyWDJNUDVtTW1jd3RiTklSajhKMFZRWS9hVVJDdC9yejNXSFhCeVlQ?=
 =?utf-8?B?cmdwTS9JTEpTTEtwdG9ZSEh2SDU4b3VOZWZTZGlYbGZWVm9keHc1NEdsQkdl?=
 =?utf-8?B?ZFpNdXozWVZRU0doU3lLRW50aW90MnlMaGpLRzhIdFc1WHlMSzJTa09pMTYw?=
 =?utf-8?B?WVlhUnNCVVJ4MWFxcmduMzJvVnFZTVNZM3FiZkpYa1ZjOFdkbGEyZHpZOHgy?=
 =?utf-8?B?UmIxaTZBNlQ5K3RnYWxGRDhzVVg0QU1JQVlHNmtwSlhRV0FmaVJzQlpFdmRP?=
 =?utf-8?B?NnFYcTJVSWV2WnU2MjE1VG5uYm9wZllhTGkreW9nYVp1bGFmY0dUbmNLdXE5?=
 =?utf-8?B?NmIybFQ2TmphTXI5dmtlSUIyK3JiZG9ud2t2WWkxYUQ1M1J4K3pEVGFjOTg4?=
 =?utf-8?B?UTN0WUxQTFNic0FQZHlJSDhGQU8xczFRS1VpSHRIR1A2R3IrNWtnRmpzSjcw?=
 =?utf-8?B?YnEzQloyVi91U2xSdkNMWHVVaGs0OXI2d2FneVlVc3dXMGc4ZzhsTjNwaDYw?=
 =?utf-8?B?VDdqQXAzQlV1b2lIVHhRbXVENHZweDlsc3NvdUdseDg4Q2ZtT0wrczZmU00z?=
 =?utf-8?B?U1MrNTRMSUd6Wk5TNmI1cVcvUldxclJLNVZMZytqeEFtR3NSNWNRM1Q5czQ4?=
 =?utf-8?B?V0c0TUNKZlZKREd0L2dGays5SjFNSm5KUm00bDNXUklsVkt5MkhZbFN1Qm9P?=
 =?utf-8?B?cWNVVHhjNVl3MWVEbjhMbW5Tcm0rNFRUSUVuYlpMMVhZMzJZdTdYVHRzQkxj?=
 =?utf-8?B?SXRqZXdITXNQNHI2eUZKQ09USzFKbmpyNFZTWWFSU2VpOTNNRjNHQzJhenpl?=
 =?utf-8?B?T3VieTN5eVZDY1hyN1VXUkttK1g2QzJtUGl6MVExNlhuU25BNDZGbDNSR2ZS?=
 =?utf-8?B?UzJaNisrWCtGT29TeWJDVW9BcTQ4WWQwdm03WkxXZjdhQWl6UkVaanArSHNV?=
 =?utf-8?B?dWlBRFFvZE5zZjhnNmhZSFZEWVFFQUZEeW1uQm9OMzY5YWhPeGF6NVNuTkhK?=
 =?utf-8?B?N01wTy9FaHl3Y2JBSFIrcGlpL0FjTzA4YlRKcFBuemM3K1dSUFpPVlBpMC9n?=
 =?utf-8?B?UTZ5Y0lFREp5RzhoTGtQcWFJVDBRbFNycUVlSW8vTXNKVjlMNjBaWVZLT2p5?=
 =?utf-8?B?bDJFZzdBWllOcXgzakVQSkFYR0tYMmFYR2hmQlRHOEJBNXZ6ZkdQakljQkJL?=
 =?utf-8?B?RmhzZUsxMGlYR0lnTVFnd3BiV25PTUc0V0llcXczMUt2UDM5SGdXUkZkekNJ?=
 =?utf-8?B?a2RWOXMvd0xuSlZ6bjBiaHRuWFlLRmJHbDI5WjVUandIVjJ4cVdFeGw5elhC?=
 =?utf-8?B?Y3Vlc292RFdrdVlzeGEvaW14eWdVc3BDcHc5ZGJaQWtOd1JJUThldjZXZ2dT?=
 =?utf-8?B?RVA3MTU2K2hyUHo3WW1DemFzQXpUb00xWHVQOEtaV3BvQkdwbkRvMHg2Q1BU?=
 =?utf-8?B?Ui9VaXBMM2ZzK3pqaEJCbW5LWEo5Vm1hbldOTFdlcXZ1R1JmdWFsNWxwMGhN?=
 =?utf-8?B?c0R4bHZiM0Z1dmtVbk1jdkN6Yll2SXlSMmw4aEpVTjdrM0Y1Rk5CQUhTemI2?=
 =?utf-8?B?azk5bzRJUWR5V1dvNXJubGp5MzJ4YXhQVG5rTy8rSmhXNWpIVXBGQVd0d25D?=
 =?utf-8?B?eWRrYkxMVVMwMThoZUpISm8vanF1T21TSkNyU201cXcrUjNpd1RlbG80WWQ0?=
 =?utf-8?B?STd2UThGMkpSU21GV3EwN0JwUTNDU0xXZFdIUHdET0dxZTY3OHF4SXZHSXZV?=
 =?utf-8?B?cnQ3Uld6NlQxa2xidFQzUlFHMlBmWTdEVS9WbGQ3VmRTZU8wSEoyMFhyUmFL?=
 =?utf-8?B?VktPK2RrRzBQZExORGNiTWl1WkRTa0djeitBeTF4bWhIdVh2bmh3aitPVVhM?=
 =?utf-8?B?blVoQ3RVaWltVThCcTVDc25PZkR0dnl2SkdiaHpySm9WUmZkNWpGdW0wNHhq?=
 =?utf-8?Q?biHo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 10:01:08.6620
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5e75301-c606-4190-8c6b-08de281bba4a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF1ADAD2878

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


