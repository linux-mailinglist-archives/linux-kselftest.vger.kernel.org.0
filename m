Return-Path: <linux-kselftest+bounces-21920-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C589C6EE0
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 13:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB7A41F25FF4
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 12:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC761FF7D9;
	Wed, 13 Nov 2024 12:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VSfz12xB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D791C1FF615;
	Wed, 13 Nov 2024 12:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731500129; cv=fail; b=oobraOr06VnPfe2Wu0fCrO5MDDUNwwWJ4C2iooDUgqIZ/Qcjo8SShnoiTBv41jxxkgoG3wDW/8NqAXWC2n85z4grz1yf7LCQPf990O0jVg0DGOOTW1Dqt5aaKUEBqAp1PyrFS0FtQBDWf3Kox+gFJcCmNYNQ5/up/M0CQj/c5fw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731500129; c=relaxed/simple;
	bh=GMQOyB4g3L0t/mW31BxtWI3W1IHRbiwhsSG/DSpSoPw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C6/b7fQpuR5nbmwJnhHRK7Cmd8soWtw5tCS6uFuHlIua8bgCMuGhzcafRKqDKUbyOFyW9BOuMN45bKJqge+KkXK5DereqzFu/JL8SBhVmODtaMI7OvhSZSeS5Z5LoOCTEyrtTOyJxoQXgvTvQ/1KqlRuUBgpWLukld+7O5n/5YY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VSfz12xB; arc=fail smtp.client-ip=40.107.223.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZdhFOBbWiwtjzmZ/OCY6y07ZGI6QzuER19JtCJmsYRSmzH4tHiSFt8M/OhTDvz6vhd3/Lsyu40E1uueUl2/t3Biy08xI9LHkfsion+wb81lC2wDa4r6LTn6xh52Xahnk4jPd7eW2vW7Efe3gDh/ffV1sKKwYYzs1lQ0xNQPlzIxbVIu75ryA5e9i9JepMx3TwhgqAg1TfGrBFVucTu9kIZnnVPdsqRJd/MBj5FQl27XBNELcAsHXpy0o8/iaOK9w7APq5t20eCHezixqiN1/YinBuzo6xpQSyrGvp0Ag8Ow3th4ZHI7UAoGSDzqBkJUf1c/mmB0sBaXJpRPD68SHfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OzSFEI9Quo6HWo2lgf0UhkiWYIEjptL00USKT15/Lss=;
 b=Hj1jl8p+JEXgfGLJ5/AHOC49iOjR5w8XtcRllxyhxHt0VY1JyDezeZiub2RZuvhqyUIUnc1mBJjHaXHJGl5fV5mWIhvv5LxWBOHC5ha3oj1JWnCOP4Bzf3uC4nY3Be+LTte2tjlaHJ2k3FEBfcHphMeH/q5jWiYq7oRfAC3xyxL4Y9KhRPWBhwl+Dq/669Rcw7OxJTnbrSw5+QV5Dpg4cjYj/rpb3ezWs0f4xQnaWPzuq66AjWrmURUNW3uqtz6vq8eAW+K5sEKvhQazaknpjuWO4fIxLPFqZive+TrvtOm0b9X5IM1TQxazmiBrkdfOxuaZsDQ618tUCZ4XiV6jNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OzSFEI9Quo6HWo2lgf0UhkiWYIEjptL00USKT15/Lss=;
 b=VSfz12xBGdQSfaJx8InDu7bv/kJYLO7il7qxCkcmXmcXI7bl3tAQEHwCLQG80bwxxy0rRIgfgh8+Zbyb90vp1R/aSViy5hwcVIDMTiQHNHYvJwsa0kjUFWa8bZ3ZR6z46cV5sLiKj0+wdcAR82wKa0XAZRamqk/VkVScRht3FoU=
Received: from SJ0PR03CA0222.namprd03.prod.outlook.com (2603:10b6:a03:39f::17)
 by DS7PR12MB6093.namprd12.prod.outlook.com (2603:10b6:8:9e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 12:15:04 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a03:39f:cafe::5c) by SJ0PR03CA0222.outlook.office365.com
 (2603:10b6:a03:39f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28 via Frontend
 Transport; Wed, 13 Nov 2024 12:15:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 12:15:04 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 06:15:01 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 06:15:01 -0600
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 13 Nov 2024 06:15:00 -0600
From: <edward.cree@amd.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <linux-net-drivers@amd.com>, <horms@kernel.org>,
	<andrew+netdev@lunn.ch>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next 1/5] net: ethtool: only allow set_rxnfc with rss + ring_cookie if driver opts in
Date: Wed, 13 Nov 2024 12:13:09 +0000
Message-ID: <cc3da0844083b0e301a33092a6299e4042b65221.1731499022.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|DS7PR12MB6093:EE_
X-MS-Office365-Filtering-Correlation-Id: 72e13614-3949-44ca-4088-08dd03dcce26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dWLTAKk0tM1Ow6WExQNQx2J3DSEkSfZrZmSaejxzIPgFLJ+csCryKj5A6Xcr?=
 =?us-ascii?Q?d1dwAakIQvcNjhRMTIhtIiBR27ldhBglQP02X2LlaJLX13e+E7jKxeChrWLI?=
 =?us-ascii?Q?25kWcY/asvL2TDz1jrHsuj9K9BiDwLk4FJz/NB7UqdAHJNKWCs9T99PrPCta?=
 =?us-ascii?Q?QUDK+j/VNhBNsRmEM9o1dQ+V2Zd/gRTh3uXLxlvxEHdhKfZgSBmMBd8RtyoF?=
 =?us-ascii?Q?jyyHDjQt7XBXlB74XRnyaBVIWyXdO+VJkf8kQMZ1mb9rLap1ubdN4Rue73JV?=
 =?us-ascii?Q?zL2zmdK9OlaCHG1i6RSSeqgrsI5qQCodXjkvyiSQ5n92+G3WxDsNFXMnQpc9?=
 =?us-ascii?Q?tPiQBPP57ox1d1df8PW8CgRTZJZdN614PnTvVq+D54VRImcWZC6kiH06TcXQ?=
 =?us-ascii?Q?Y4bUTNdKvllv84SGsasCSn5Lh7w1zFwYSv5YtFLUCUOqLmOZMD5dcjpvEshk?=
 =?us-ascii?Q?tMXj7tw6A90ir0jIJBvgGfFdb6dQwAJMZJlkNvPPTt1YcD0WdPrViNWNxCtN?=
 =?us-ascii?Q?adKme5Grnmo/+oQEvFr0ANYXrniPGCuT07ROCwfOajs3JfIo+k5nQnLBomF6?=
 =?us-ascii?Q?pNGQaUAYGA6/50SxaItUhBYinlcmrFRCtezj5Lxp8Ib1cWuCL7ozaS64JtNs?=
 =?us-ascii?Q?bL77xMZDZd/qdqclCSRteFgPjbi7oCxdoGfZbZjDmoioyjBd/Mt6vJjQCKr3?=
 =?us-ascii?Q?w8Ko9odr/fM9FSgQv6Yjzctukf0RbllkOwoc4NUSO/usAHPXLlXbJFkFIjlD?=
 =?us-ascii?Q?P5y76/2SuzGDhdgTSts8EqN4rOHXIw2Xj1FRfnZrcZK+aRtLPAANs7XaPmxL?=
 =?us-ascii?Q?hRrkviI5mt0HEQ+LJFiKvbNOioA2FV2rbQu9w+y6jh6czprHnzb9OQr0G2Rr?=
 =?us-ascii?Q?TTDlkHCPPjoFce76M2XvEX/WGLUYBXJdcQkRpHU9ZqDI9Yk3Ay8F+tsnX47f?=
 =?us-ascii?Q?dq09ANYaXdeHnuihyXP8vfUgpkF7ANrDBRJa6zxcbH/RAxLoUw1XThuE2aBJ?=
 =?us-ascii?Q?JrT51WuX1k9ciQRLA9MabLdnCbVolNU1xwhQZsRZxLjIl3wtmRbf6O9baIWX?=
 =?us-ascii?Q?KnjhFy1e1CHG4v4iV9eQblO2tHEXQ/NtM7LEeAbjcOq9WriH8UEVELK+HFSv?=
 =?us-ascii?Q?bc9XGOxseviRxbS6AFLqzAniPcoDDjH4Kj9z8oon0xZQEIEbEu+YVy4sSwd/?=
 =?us-ascii?Q?z2+/Q7r31PUt5SaIr6T37B9BmDEcXb4xLC9ExTlvMnf+PrhU+QSxNsNzQSc4?=
 =?us-ascii?Q?68pMZ9rv+Ob52N0ZxUqqD94TkzYBsGXlLL7Am4ZEfMfmU5CNUFaEg3eatt66?=
 =?us-ascii?Q?Hu6vnRHCyTFO41t8S3jaCyd+wgmSCyPp87hHeEpXfjLbyEPDQULChnaJ4P26?=
 =?us-ascii?Q?liYArc4CQrEFhRztWGht8NuAd4uQD+dbMVaapil4cPffOdvFcg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 12:15:04.0749
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e13614-3949-44ca-4088-08dd03dcce26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6093

From: Edward Cree <ecree.xilinx@gmail.com>

Ethtool ntuple filters with FLOW_RSS were originally defined as adding
 the base queue ID (ring_cookie) to the value from the indirection table,
 so that the same table could distribute over more than one set of queues
 when used by different filters.
However, some drivers / hardware ignore the ring_cookie, and simply use
 the indirection table entries as queue IDs directly.  Thus, for drivers
 which have not opted in by setting ethtool_ops.cap_rss_rxnfc_adds to
 declare that they support the original (addition) semantics, reject in
 ethtool_set_rxnfc any filter which combines FLOW_RSS and a nonzero ring.
(For a ring_cookie of zero, both behaviours are equivalent.)
Set the cap bit in sfc, as it is known to support this feature.

Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/ef100_ethtool.c | 1 +
 drivers/net/ethernet/sfc/ethtool.c       | 1 +
 include/linux/ethtool.h                  | 4 ++++
 net/ethtool/ioctl.c                      | 5 +++++
 4 files changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/sfc/ef100_ethtool.c b/drivers/net/ethernet/sfc/ef100_ethtool.c
index 5c2551369812..6c3b74000d3b 100644
--- a/drivers/net/ethernet/sfc/ef100_ethtool.c
+++ b/drivers/net/ethernet/sfc/ef100_ethtool.c
@@ -59,6 +59,7 @@ const struct ethtool_ops ef100_ethtool_ops = {
 	.get_rxfh_indir_size	= efx_ethtool_get_rxfh_indir_size,
 	.get_rxfh_key_size	= efx_ethtool_get_rxfh_key_size,
 	.rxfh_per_ctx_key	= true,
+	.cap_rss_rxnfc_adds	= true,
 	.rxfh_priv_size		= sizeof(struct efx_rss_context_priv),
 	.get_rxfh		= efx_ethtool_get_rxfh,
 	.set_rxfh		= efx_ethtool_set_rxfh,
diff --git a/drivers/net/ethernet/sfc/ethtool.c b/drivers/net/ethernet/sfc/ethtool.c
index bb1930818beb..83d715544f7f 100644
--- a/drivers/net/ethernet/sfc/ethtool.c
+++ b/drivers/net/ethernet/sfc/ethtool.c
@@ -263,6 +263,7 @@ const struct ethtool_ops efx_ethtool_ops = {
 	.get_rxfh_indir_size	= efx_ethtool_get_rxfh_indir_size,
 	.get_rxfh_key_size	= efx_ethtool_get_rxfh_key_size,
 	.rxfh_per_ctx_key	= true,
+	.cap_rss_rxnfc_adds	= true,
 	.rxfh_priv_size		= sizeof(struct efx_rss_context_priv),
 	.get_rxfh		= efx_ethtool_get_rxfh,
 	.set_rxfh		= efx_ethtool_set_rxfh,
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 1199e308c8dd..299280c94d07 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -734,6 +734,9 @@ struct kernel_ethtool_ts_info {
  * @rxfh_per_ctx_key: device supports setting different RSS key for each
  *	additional context. Netlink API should report hfunc, key, and input_xfrm
  *	for every context, not just context 0.
+ * @cap_rss_rxnfc_adds: device supports nonzero ring_cookie in filters with
+ *	%FLOW_RSS flag; the queue ID from the filter is added to the value from
+ *	the indirection table to determine the delivery queue.
  * @rxfh_indir_space: max size of RSS indirection tables, if indirection table
  *	size as returned by @get_rxfh_indir_size may change during lifetime
  *	of the device. Leave as 0 if the table size is constant.
@@ -956,6 +959,7 @@ struct ethtool_ops {
 	u32     cap_rss_ctx_supported:1;
 	u32	cap_rss_sym_xor_supported:1;
 	u32	rxfh_per_ctx_key:1;
+	u32	cap_rss_rxnfc_adds:1;
 	u32	rxfh_indir_space;
 	u16	rxfh_key_space;
 	u16	rxfh_priv_size;
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 7da94e26ced6..d86399bcf223 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -992,6 +992,11 @@ static noinline_for_stack int ethtool_set_rxnfc(struct net_device *dev,
 	if (rc)
 		return rc;
 
+	/* Nonzero ring with RSS only makes sense if NIC adds them together */
+	if (info.flow_type & FLOW_RSS && !ops->cap_rss_rxnfc_adds &&
+	    ethtool_get_flow_spec_ring(info.fs.ring_cookie))
+		return -EINVAL;
+
 	if (ops->get_rxfh) {
 		struct ethtool_rxfh_param rxfh = {};
 

