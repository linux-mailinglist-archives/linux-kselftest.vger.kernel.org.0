Return-Path: <linux-kselftest+bounces-21918-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7559C6ED9
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 13:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B2B2282D2C
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 12:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D88D200CAE;
	Wed, 13 Nov 2024 12:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZByUSOHm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823BD1DF250;
	Wed, 13 Nov 2024 12:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731500111; cv=fail; b=KaXTrF879/AgJ2Yj+i0ziOVh+PFePIO1bFEASn5S3NVBT7OShcTbKGE/m0CbnWYBb7xTA9jfVetMF6pJkKSQxeFGFI9BPRPc9Og7YKTeX9sl7vx/kGgTKMshf1VYg7fPj6cOvNFcXT7Aktt0pG0FR2mtK9eghe3+7cYscUN5mfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731500111; c=relaxed/simple;
	bh=8r8X3nrCuFP8Bs7mNdqs+K2MxN/JzZOKLK2LqlVWIrY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LvRfXsTDxVWznL145DY2yh6Ghq1v+wdc4iMi5Xhjm4tKvpicysQxlmAHkFTG8H7bWnCtPdlBWzfqfj17CeD6fTp/enJoaPi76UiAl06MrAc0dA+wBqmwtudq01DBRhJGVuqWPK3ZatOkQYz0bOaBO/MLq3SNEx/L/CcRW9HoiGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZByUSOHm; arc=fail smtp.client-ip=40.107.243.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y+3suuIgOG7jdjUCb4aA1POnnhRG+yx5krcWrStws0vzVrYUzJH086QeOdHWclh+6tKdM0Z37rsjFxvuQzQBt8EV1KKLlw4N/V4bDhSndqdv34bwTq1g2HApSa/8THwwt5bVOQ866hW5h8u3BwOnGnKIyvAfAsEcxHsd1WfHVJ7TUgF8TrjLtmt9CNK5zIW5UJwIdrB6prY6u5SEAwLhR42lvaWRqqe1oMvW+B8AtW/3AMXo7E/EqQNmMZuftSp1K1jp+KXImb+MQrqWxmxp9odSJWadxrRniCc2o8rp4gzu5nfERsAvqIPEtJiOb0JlNTv0yzUjtq6cnm/FiFtzWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C5bGs9IifR70SQiam0gYQvSBFf7mfCNBW6Ux+kLEW0o=;
 b=bxoEfx7b3E/lTdhapW905L5GpvULIFm1k+QcAHV0twpgGRRQx6LJV4u2guoIBeK2Lx7q1pKyD3YL5yjAi8yNuagBeKaRAx9rcLJDCrFJRdVC4Mb6c2XQ44Wf9aB6J8gBVtVeOAiRMCWcE8yG8xuMZjfXAs8ZMti89nXZQUWSy7FlodU10AeLw80EOzLlZKkx2uWJnRbFE37eXpx5OauozMQ3pxVRADeD6S7mt62voxDUlo639KwPpEhvDG17CXRD7j7P6nOsmZiJlVOd1me4w3M6zaZblnSGQpBuDsqLDtcBvdiYbOQ9UNjlBxcfDtTUJZINZ6TezVXPJbC5/gi1Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5bGs9IifR70SQiam0gYQvSBFf7mfCNBW6Ux+kLEW0o=;
 b=ZByUSOHm8HKSZPcBuUiRp0+hmqKZQR8IyFkF+NwU6QalosNOOnXARKsyQPy6XvjiDj8uUmyS11h7RiFjU6m0nVy8Ny6GIODKhzA7igjwPJ+OW6S5E7DmKpcCLO6LLgYRsZAHaonS1uODlHNzFDxhUOxodheH0YEne7gqOrNMtLk=
Received: from SJ0PR03CA0238.namprd03.prod.outlook.com (2603:10b6:a03:39f::33)
 by MW6PR12MB8959.namprd12.prod.outlook.com (2603:10b6:303:23c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 12:15:06 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a03:39f:cafe::30) by SJ0PR03CA0238.outlook.office365.com
 (2603:10b6:a03:39f::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28 via Frontend
 Transport; Wed, 13 Nov 2024 12:15:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 12:15:06 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 06:15:04 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 06:15:04 -0600
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 13 Nov 2024 06:15:03 -0600
From: <edward.cree@amd.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <linux-net-drivers@amd.com>, <horms@kernel.org>,
	<andrew+netdev@lunn.ch>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next 3/5] selftest: include dst-ip in ethtool ntuple rules
Date: Wed, 13 Nov 2024 12:13:11 +0000
Message-ID: <8e5d23c8f21310c23c080cc7bcd31b76f8fd3096.1731499022.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1731499021.git.ecree.xilinx@gmail.com>
References: <cover.1731499021.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: edward.cree@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|MW6PR12MB8959:EE_
X-MS-Office365-Filtering-Correlation-Id: d5a1ef86-4431-4495-592d-08dd03dccf63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X63lvwI0QMeTpqOL4qKsvsUI5fUuIn7jffwRPXfW+r1wDjwN+uEmx3QVfWsh?=
 =?us-ascii?Q?IumPxqKI33DoMhzF2PmsijDrQ1iq+uLjrbevc2VM1bu67G1pusy0bR/oklwh?=
 =?us-ascii?Q?51sIwmkECc6mlsMRV73vm1q5NQnZZa9U3tJmZoifIs0an67A6NwkpUnhxtAC?=
 =?us-ascii?Q?JHoffT5wj82NHzm5GnY/UNjbXHK1Ut2eK5sg2KBMztJvLH/QpHs4uFIVOwUe?=
 =?us-ascii?Q?SSb5/ar33RHMAQ0/r7nSr1Po6nX2VKk2mWhzIe5vBgme/yHwHGXLxoI07qBZ?=
 =?us-ascii?Q?DaLYIfySqxDrXtUM9A4wvOXwymK430VtsHG/fOvByDHYFLj87NXd15q6gaoO?=
 =?us-ascii?Q?7MAoyPa09dg5ql3SxHXWUIV6kSe86vS1GVayIZojiEuly/EsArHZN4haaZx0?=
 =?us-ascii?Q?F+A6P87/a1C1DbKHu+WxSI075+lz15ktvTSpw5/xer+kTKsCo6qMbSMF7I+t?=
 =?us-ascii?Q?ggvV+nK49O9KMsT5c1FVOmyQlDft6u2fAqoVzby/Xwc0zpAk1vDUcR5jQWAW?=
 =?us-ascii?Q?qY33I8FkuKUuFTzo3LjGuofwmjM1btx/bWWfjlWpVpGUzTv4bSmt1n0mAl1I?=
 =?us-ascii?Q?0bQzFKfIOoBod4eaordXw2VNEIxBLgiJK2Mo64IG0/R7i3yiYnaCmU05LK+J?=
 =?us-ascii?Q?d8+DIFg3zMDSFkQRRHpl+uRIbAcVFqcs7Ez1j7hNg/DLqLUASk0JO45bDUMX?=
 =?us-ascii?Q?CFnKQxiHrXKxeL9n1vPtIhi2D9VYCeisp1C6qssXASmwb3j8MevQWQUptHIp?=
 =?us-ascii?Q?Xpb59O1blf52AQvysG26WgHRdB3Y/AYB4Rl6u6qpnbeK1KpbkSlojtNZKdDp?=
 =?us-ascii?Q?P08PxUHPVID/h8aALWCk9QKjsPmosHkMMJk3YkM+1j46mrodym/FWORY4E6h?=
 =?us-ascii?Q?AvIiC+q6x8/wTqAAZuJt+vpRB5ZhKo+iAgVnC0Fn+VeNrMopGKFjTOGAwt3p?=
 =?us-ascii?Q?+c+PXbe8q1i4vdiJ+Fma8/alS+PiaGdMK8FmVGf6Y/YrZSm/+tinm/eIweuO?=
 =?us-ascii?Q?80CwwUi287gdBxBvGh2zeWtczxw2QCY72xgnIzWC5ulCl/sTW5AWi6d5NnMs?=
 =?us-ascii?Q?W8UNQy3wy9/yEjZoGAcCh0a3fMBg3hfIBttu/nT1UwkQg6ZYJ9rv7KmgJ2iM?=
 =?us-ascii?Q?isZVL63abcqpw7feGgBIygl/cTURjvfGhBZsJkj1YilRiwQICi76B8V4hTal?=
 =?us-ascii?Q?8MkcV8ZWeWkduVGSeYPRxg0dAs0ZdqUPMaV8/OnWYpttsOAkmQl4B+Qc/BVj?=
 =?us-ascii?Q?6Y61LPj2AUSs2uAWi5YYfVoWNgQLhnHWFfAn6sWECYAvCRf/DmgpYnIMK0Nw?=
 =?us-ascii?Q?iqumCIkDnuCGYDNCzkERFYVMbH9KTqtn7cw5is60BS/GjNC1tEPgpQukXVrC?=
 =?us-ascii?Q?u0xh47s1o7cSla2WnSKrtIIhywSoa0s9A3/3VyYLnDE+OAwnFQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 12:15:06.1686
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5a1ef86-4431-4495-592d-08dd03dccf63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8959

From: Edward Cree <ecree.xilinx@gmail.com>

sfc hardware does not support filters with only ipproto + dst-port;
 adding dst-ip to the flow spec allows the rss_ctx test to be run on
 these devices.

Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
I'm not sure if this change will break the test for other drivers that
perhaps support the old filter but not the new one.  If so we might
need to add an option to cfg to control this choice.

 tools/testing/selftests/drivers/net/hw/rss_ctx.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/rss_ctx.py b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
index 29995586993c..fb61dae20fd8 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_ctx.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
@@ -215,7 +215,7 @@ def test_rss_queue_reconfigure(cfg, main_ctx=True):
         defer(ethtool, f"-X {cfg.ifname} default")
     else:
         other_key = 'noise'
-        flow = f"flow-type tcp{cfg.addr_ipver} dst-port {port} context {ctx_id}"
+        flow = f"flow-type tcp{cfg.addr_ipver} dst-ip {cfg.addr} dst-port {port} context {ctx_id}"
         ntuple = ethtool_create(cfg, "-N", flow)
         defer(ethtool, f"-N {cfg.ifname} delete {ntuple}")
 
@@ -429,7 +429,7 @@ def test_rss_context(cfg, ctx_cnt=1, create_with_cfg=None):
         ksft_eq(max(data['rss-indirection-table']), 2 + i * 2 + 1, "Unexpected context cfg: " + str(data))
 
         ports.append(rand_port())
-        flow = f"flow-type tcp{cfg.addr_ipver} dst-port {ports[i]} context {ctx_id}"
+        flow = f"flow-type tcp{cfg.addr_ipver} dst-ip {cfg.addr} dst-port {ports[i]} context {ctx_id}"
         ntuple = ethtool_create(cfg, "-N", flow)
         defer(ethtool, f"-N {cfg.ifname} delete {ntuple}")
 
@@ -516,7 +516,7 @@ def test_rss_context_out_of_order(cfg, ctx_cnt=4):
         ctx.append(defer(ethtool, f"-X {cfg.ifname} context {ctx_id} delete"))
 
         ports.append(rand_port())
-        flow = f"flow-type tcp{cfg.addr_ipver} dst-port {ports[i]} context {ctx_id}"
+        flow = f"flow-type tcp{cfg.addr_ipver} dst-ip {cfg.addr} dst-port {ports[i]} context {ctx_id}"
         ntuple_id = ethtool_create(cfg, "-N", flow)
         ntuple.append(defer(ethtool, f"-N {cfg.ifname} delete {ntuple_id}"))
 
@@ -569,7 +569,7 @@ def test_rss_context_overlap(cfg, other_ctx=0):
 
     port = rand_port()
     if other_ctx:
-        flow = f"flow-type tcp{cfg.addr_ipver} dst-port {port} context {other_ctx}"
+        flow = f"flow-type tcp{cfg.addr_ipver} dst-ip {cfg.addr} dst-port {port} context {other_ctx}"
         ntuple_id = ethtool_create(cfg, "-N", flow)
         ntuple = defer(ethtool, f"-N {cfg.ifname} delete {ntuple_id}")
 
@@ -587,7 +587,7 @@ def test_rss_context_overlap(cfg, other_ctx=0):
     # Now create a rule for context 1 and make sure traffic goes to a subset
     if other_ctx:
         ntuple.exec()
-    flow = f"flow-type tcp{cfg.addr_ipver} dst-port {port} context {ctx_id}"
+    flow = f"flow-type tcp{cfg.addr_ipver} dst-ip {cfg.addr} dst-port {port} context {ctx_id}"
     ntuple_id = ethtool_create(cfg, "-N", flow)
     defer(ethtool, f"-N {cfg.ifname} delete {ntuple_id}")
 
@@ -620,7 +620,7 @@ def test_delete_rss_context_busy(cfg):
 
     # utilize context from ntuple filter
     port = rand_port()
-    flow = f"flow-type tcp{cfg.addr_ipver} dst-port {port} context {ctx_id}"
+    flow = f"flow-type tcp{cfg.addr_ipver} dst-ip {cfg.addr} dst-port {port} context {ctx_id}"
     ntuple_id = ethtool_create(cfg, "-N", flow)
     defer(ethtool, f"-N {cfg.ifname} delete {ntuple_id}")
 

