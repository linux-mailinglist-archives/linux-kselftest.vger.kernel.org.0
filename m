Return-Path: <linux-kselftest+bounces-43017-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 312DCBD569E
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 19:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A39A55055D4
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 17:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571F0304BC5;
	Mon, 13 Oct 2025 17:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="VSMlStfZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011023.outbound.protection.outlook.com [40.107.130.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04354302145;
	Mon, 13 Oct 2025 17:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760375047; cv=fail; b=hmG2XQMyveoiDmWxhNFpE7xE4iYIm/YtF72cTu5aIL/yiMRjLDhE5wPb38s0pIxz+JMA+gKkAnPveY7h8JCy6tWdryH1LQUbWUHYhe9L8oNw04biUugkuRind5JpUshNnrzsB+KRTeKD0l7nFcowOGuzDUx+HrCkxMk38TRVaA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760375047; c=relaxed/simple;
	bh=UlyWEbv2LAmAxozFwOwlSdo78SI3QsHUO2Ly0nb/vJo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BHXbhRDdq5ApU1XJ0ZJIafrr8RPNGwd3CP4vKlschWWBpuQoCekE6tqq3J2Lq5tZVodqaF9Qiio1Eem0uVXSDoqFcX8vm043q0X9XB4ROxuV+5YcupUmWAK4I+T4gQer+LZ46BdbsZWoUtvVaxNSCJPVoBEEat9MVrTKngb2A6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=VSMlStfZ; arc=fail smtp.client-ip=40.107.130.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CaEVdHNDqqiIZsnLI7J/2KEV7OfzZi+QOI5PDFDkpLemBh1ob+7y+v9qXEMDAVhYIqYGyi+e0SkzUEEYuIwylYqeQWyWwAOR1vNGWV5aEX8NQ5mazb4QOCQPiODvRtm2w4JzQS/7ssbjEUPI5zwGA0KkM15kulI8C9UZAfZIgSwj9KyLNcsQtyUIirBflPdAcKijFREDH48SodcgXq+l2gyaYLwhxC/g7F2AXR8tPRRSYF/TleH0TFF3/tJwRUx2s4OowJNPMeOic0/sScyejmcCaHCUTgmv9fP+x9q9quxgKtCfBV7NNWUssbXALsYEKcYmBo/iFUsJ015RZ7N/Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UqB16pQfRYSIzISJMCmHpwdSVoowt8sOyg69Co0fKfM=;
 b=bCn797f1pVlFKlDxW6EsfdweHMBCqtZrjKJfIEjRydp4Jr/GRUgY6fuVpmLkGL5WxeXRhl3J+7Xpn7Tvl1Z3WPpLryKzhOcFERGXW5+Z6mqyEdeMV3CDzdjQAZ9IVD7evJiwatRbpM6cKL5/w5hAfhYM/afGCduFH/UUshofsD9AK2TFvqRvdz/09E9AV9Ho9OYqH5y9MOnp+INluN4rgdwz3i5WtFcg00HA4gWg+s3wVW3fZlLrCHq4UChllbhbhFaep3hohvy+KO+AC8egOvJqZu48AOglHobaZ+c0zSdyNb7jXz8besZloakSuepDHz8g1RRuwb5bexteBfQv7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqB16pQfRYSIzISJMCmHpwdSVoowt8sOyg69Co0fKfM=;
 b=VSMlStfZeogSNk9VKrk941J/UUTBchglMYSDuUMDsTUl0WH7KVfoPSlAqmHbxsoxvD8CK16YRCPlxyVyS8dvrGyq8UWrYqC4NyH+lXG3TbSJ2DIma21RJGmfCxuQKX9Bjvy8DZMcjCXyFe9iQK6dkLXBuYqG1WJG3EPETHMk+f6VtCE/JOspuddxd9OuYiIxwbUfnrjGJGUljqKXOZOIkGKJHPugLRZuyIFXZXd/rShd6yaWPAcQf6y3MSzANKyDItZZ9Bt/9D2tU7C6Izaf9qFHMwE449M56Kgh5rkHgmhsTEz7HoHSBViNB47a2RbobeVuboFogqV0xCRrrmFz8A==
Received: from AM8P190CA0001.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::6)
 by DBBPR07MB7386.eurprd07.prod.outlook.com (2603:10a6:10:1ef::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 17:04:00 +0000
Received: from AM1PEPF000252DC.eurprd07.prod.outlook.com
 (2603:10a6:20b:219:cafe::c0) by AM8P190CA0001.outlook.office365.com
 (2603:10a6:20b:219::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.12 via Frontend Transport; Mon,
 13 Oct 2025 17:03:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM1PEPF000252DC.mail.protection.outlook.com (10.167.16.54) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Mon, 13 Oct 2025 17:03:59 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 1BEAF1C003D;
	Mon, 13 Oct 2025 20:03:58 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: pabeni@redhat.com,
	edumazet@google.com,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	horms@kernel.org,
	dsahern@kernel.org,
	kuniyu@amazon.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	dave.taht@gmail.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	donald.hunter@gmail.com,
	ast@fiberby.net,
	liuhangbin@gmail.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	ij@kernel.org,
	ncardwell@google.com,
	koen.de_schepper@nokia-bell-labs.com,
	g.white@cablelabs.com,
	ingemar.s.johansson@ericsson.com,
	mirja.kuehlewind@ericsson.com,
	cheshire@apple.com,
	rs.ietf@gmx.at,
	Jason_Livingood@comcast.com,
	vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v4 net-next 10/13] tcp: accecn: fallback outgoing half link to non-AccECN
Date: Mon, 13 Oct 2025 19:03:28 +0200
Message-Id: <20251013170331.63539-11-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251013170331.63539-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251013170331.63539-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DC:EE_|DBBPR07MB7386:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f3a1b1fd-bb63-43e8-6891-08de0a7a80db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?60u7weYreghuF2S+ev7cv8AmcZrQUyOEBk5gLpPtvKLrS0sh9959rtC7cIRX?=
 =?us-ascii?Q?danPLnpLwlRNQMmJdzXoi6E9pClHFdQ6shkvjwzsoSGXsdlYp8Fsb+Z06yAU?=
 =?us-ascii?Q?+rqTQExtRtPEBHS2V5knfktWEeqk5iOkKMZoUUcpGq8oD3n6qU0gKBIy7Bym?=
 =?us-ascii?Q?zGMltHt1giB+pHPoGW/daevJPysOQ2VOUE/UwL+1XiRYI2vH2glQFTm499Tv?=
 =?us-ascii?Q?srJxdIa6qOkYirWpmydopcFyBZLI4vPBjUQ6d/io1c6MsVzIahT5952QERiE?=
 =?us-ascii?Q?L28AyW9I/jpyBAz2zj5OkNxP2m7Wh+PdA2f21y92XmyPNmcKKRwRnSg47r31?=
 =?us-ascii?Q?lnqCtCVRBgGoNOLI3BLTDOQKRtiv/Gz3R+GViXxPhz7tGtTpMuHUNerpv2fl?=
 =?us-ascii?Q?MsAVSNOAxuCVhpLNJlqe4eqofeoEQxrcrrf8TFAL5VMI+visy6t+VjVKJzPl?=
 =?us-ascii?Q?4fEGctQBwYLT9jim3HXwduOa4HQg6aWfybsj5oXiW8USc4M1tHG0P2HNzqa8?=
 =?us-ascii?Q?GMrzN1c+4c9wJhxDQRNE7rlOmWfDrXM+5awI7Rc4rFzxc8th5f3P34bBcc6L?=
 =?us-ascii?Q?UTP35tYZU1FvfMfGv82fns0PZRIYMXsPGLFDmCFDFL0bgOcChq8mXeCJgQKx?=
 =?us-ascii?Q?jpxF2SpkBEVa/8J31v49MwcTKBCXZiEAVZlcl5ln/aC7BDFFUJQVDUYy7CLG?=
 =?us-ascii?Q?9U+ekCcB7FiwiFKyr/ll1c1JUtxMPIXis+3mN3Dhdb5Elec0AfgXAAoWXWVI?=
 =?us-ascii?Q?zXOTMx1Hl6KbKNloA4352il2A/HPUrj51mVnRVqTYPDOg+0kVfKk8hEGDZkr?=
 =?us-ascii?Q?L+MtANpAreqUb785Wwksf8Aw3B3UV+s+4Qmrv1Ur6IoN0UJTs0a3WppFTQmZ?=
 =?us-ascii?Q?orDmnWzzCx49LYVYzlZlasOz4dlB8GmRMLu/kAyLrrtftQJk00TkfQ40RWvW?=
 =?us-ascii?Q?olyuTGqfiidaCVmPqgFK3vTSu6h2u/P0/eV63Rpq5H+Cz97LrNIjaG7NAGyQ?=
 =?us-ascii?Q?czfBP1XzyTeerMOGGyW0oZKR4Q2e2g5bwtD7Yuap87/wqIppeO753+iDmBJT?=
 =?us-ascii?Q?Xh+05CdXjiEYdbxE5/1FfI9fGFJvN50zEAdl7VyFJwPxRF+X1Wy+nlBynURT?=
 =?us-ascii?Q?Axo/i/xncCkRSlrjEEwXYI8GleFYhWtB1a5jEY4MnzpfaXlSBvOCQ/xO5y1z?=
 =?us-ascii?Q?YGNvIPkig/gE+hnXkmcSD28s75MoZXJ2TshiXmKOvHbbkaT1Rjkymw0C3SfA?=
 =?us-ascii?Q?fksgkTouh6pjd+Q+q1Q+eE6LchRW6qmBp4X+OGYLsc9fVewjcqwb++wh/XWB?=
 =?us-ascii?Q?DERG0QYv/YP1N1E2FnKHdZ3xrMQeSTOn7jJu70FocZPJdXE/QF22mdo2Z4+U?=
 =?us-ascii?Q?Cs7Q4UFgD4SidRLvtdhfwnR4P2oravDv7yGK2PLIcex0BjlYJAEntKR1GFjZ?=
 =?us-ascii?Q?VYpcmFkFBE3Hynv4a/pqo/fyhwj5dpa3CV5KavyTQhhnI2CxSG445TookkV9?=
 =?us-ascii?Q?y6//FsvpQED9Y+wO616hnSxbzT0WoqOkubOpREDXoirXF5EnQ6NIYgOzkjbY?=
 =?us-ascii?Q?CuDUl39bt4aWQ6We9EdeCkbA50sioozATW/gFuiV?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 17:03:59.6620
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3a1b1fd-bb63-43e8-6891-08de0a7a80db
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM1PEPF000252DC.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR07MB7386

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

According to Section 3.2.2.1 of AccECN spec (RFC9768), if the Server
is in AccECN mode and in SYN-RCVD state, and if it receives a value of
zero on a pure ACK with SYN=0 and no SACK blocks, for the rest of the
connection the Server MUST NOT set ECT on outgoing packets and MUST
NOT respond to AccECN feedback. Nonetheless, as a Data Receiver it
MUST NOT disable AccECN feedback.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

---
v3:
- Remove unnecessary brackets.
---
 include/net/tcp_ecn.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index 50551430b1fa..2dfd2fda085d 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -175,7 +175,9 @@ static inline void tcp_accecn_third_ack(struct sock *sk,
 	switch (ace) {
 	case 0x0:
 		/* Invalid value */
-		tcp_accecn_fail_mode_set(tp, TCP_ACCECN_ACE_FAIL_RECV);
+		if (!TCP_SKB_CB(skb)->sacked)
+			tcp_accecn_fail_mode_set(tp, TCP_ACCECN_ACE_FAIL_RECV |
+						     TCP_ACCECN_OPT_FAIL_RECV);
 		break;
 	case 0x7:
 	case 0x5:
-- 
2.34.1


