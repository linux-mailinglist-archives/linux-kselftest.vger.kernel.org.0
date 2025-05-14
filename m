Return-Path: <linux-kselftest+bounces-32937-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B0DAB6D85
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 15:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08A6A1B67941
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 13:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8706127AC39;
	Wed, 14 May 2025 13:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="M0sVSZhR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011052.outbound.protection.outlook.com [52.101.65.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726CE27C175;
	Wed, 14 May 2025 13:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747231021; cv=fail; b=q1V2lsLpwLVnpyLNLubK3aiBDrrU1Cq59oAiJnAQEA3ewJsgqQKhYFARbBFLJgY2wCDetWM+vRxHJInufNtHldr1YrLvPCUZhPbyBKmsqN7+4rfrHL2MF7pvRMVA3hrHP4+YkkXLPTlwk9T8POaSA6/V4XVgS/iBe2Pn7VEfFwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747231021; c=relaxed/simple;
	bh=iFKd1UJp9PQqL0tER0fodJJRNiOr86sZy0ZnvNT38nM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o6GoVl6GdckcQ0AjNB1YscGZX0jV8pinQjyMkoN9lZLGbztPbz913Hw2ERi/pMkEgNIHwzIG+Qxn6BdWsbQS8R2yPDm+1i5mCkBE+JyXBXe7o9fewcp6CepnFTPRi+MiqkFeTeALWIEXpWBYCflrNkgoxrM30RUCaUZ29+oebYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=M0sVSZhR; arc=fail smtp.client-ip=52.101.65.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KrnH5Tzm0hvpJpcIFFBrzivs4s73lfY9m8zLuCQR44A6/DUp1Zq1EdQyIjlUa9NboDyLGNc+LEmjp7LoNyAi6coWlUX36LwV9nFuEL2QISUrmMuDUvWPLH2WYFZOxqJy/Hmm6uF7IZUJW4StTfZ5VTyFb5lgIQcXCddhO0KQoVGQ77HID1Vo5GgVqvmyTX7cO1rEen6AYlgTNnUMyYuJARh2i+YGsx8pMPkDbe3PnHXJID2HOeuhfD0/2gyerNSk8BGF3019rp+g3E1NByogpb9OeokHUDxHZfnTnd3eCYHUQivyacAGRC4o1PG7wA1icqJui/nP9hxLwTb+p2LMOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSVuX+M5utpsiNsGLb8bRjvC3kcK1sHHaC0wWy0l5vI=;
 b=r4xA7IpRFrZnCFDG/c4PsnQ2JRIhjssylxOdSfT/tQ0qPbn6Awxo1RM1nDcNmjjVVK+Eb+nh5U2RgeWtAEni+bavY2vfoLMZ1bArDDBYLrYleAg12Oi3Oj7BebNuFEegK0IjmFbvuyfP8Lx8MChi5wB1LZlwUJfUzJIdY2nYamFLThgXs6qnMM20dzSeh/U74zSgeQUVEAlyj2lqu5hrnBCArawn+sN345A1LI2ZPz8orPpAXrGKWTAorqXOPxGlZtPDe1Kf/dBYn7gdnUelNkIKW698XqdUVtbh/ROqvbjsZTBm/VOgfex0y7o66ov+ruRSWAFBISMC9qjt7hD9ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YSVuX+M5utpsiNsGLb8bRjvC3kcK1sHHaC0wWy0l5vI=;
 b=M0sVSZhRayPyEqN1iSk39bRX8kMzUIOnlLq/4X8rMojXA/HXbESlppzIzK75tIEwuzWvbBA00KWwbF5HOnLxw8/Ux40Pyn689nwbd3ApXDCWgQJYkWjoGZsNL3OdH6rDZjQurX1JzU3siR0KaIFp2cQs+QHraUAJkpe2rusOuHnQqNeq8V5M+ZgqUbfi7MDkInCunef3JKyswydCoQcSVAHSJtNQBqFT2yTJ/9GZ7Xuj1hkfFzrRA1L1q/L5nvgU+XNGfHBrfL5g3ZR7wjqXrfHAi5tLLrSsK7AU4lqMl6WMplzKXHOmEgPWi8glfxPBPQZHwJYmzOVKv0RXso2+dA==
Received: from CWLP265CA0437.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1d7::13)
 by DB9PR07MB7100.eurprd07.prod.outlook.com (2603:10a6:10:21a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Wed, 14 May
 2025 13:56:54 +0000
Received: from AM1PEPF000252DB.eurprd07.prod.outlook.com
 (2603:10a6:400:1d7:cafe::ca) by CWLP265CA0437.outlook.office365.com
 (2603:10a6:400:1d7::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.17 via Frontend Transport; Wed,
 14 May 2025 13:56:54 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.2.240) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AM1PEPF000252DB.mail.protection.outlook.com (10.167.16.53) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.18
 via Frontend Transport; Wed, 14 May 2025 13:56:53 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id C80AE2009B;
	Wed, 14 May 2025 16:56:51 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: linux-doc@vger.kernel.org,
	corbet@lwn.net,
	horms@kernel.org,
	dsahern@kernel.org,
	kuniyu@amazon.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	dave.taht@gmail.com,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
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
Subject: [PATCH v7 net-next 03/15] tcp: reorganize tcp_sock_write_txrx group for variables later
Date: Wed, 14 May 2025 15:56:30 +0200
Message-Id: <20250514135642.11203-4-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514135642.11203-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250514135642.11203-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DB:EE_|DB9PR07MB7100:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 431ef7b3-8cdf-4bb2-8178-08dd92ef2eae
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?Wm10JTyTdCkbo54nvEQPG6y721aDiOI/HFwwyr2d1FC3JDHVDauUGWi+qK8b?=
 =?us-ascii?Q?GXFNWiQev+PRsNTGKbEDs9K1YOqxcYQkYdS7WMB/cdLCOHTRml/N1ccg4+be?=
 =?us-ascii?Q?v5JJ9XnAFhxnj1KJDXmDGpATScnEVjCVeZ6rpuu1pwg83XhcfM0FvPwjcyn1?=
 =?us-ascii?Q?IDzE26ToV9iLd+dIrYlPyvm6eFygiC+rQ0f8ApqWsyG4cFLpocr6zuPS2kCs?=
 =?us-ascii?Q?C5whMTfG2r/czhmhOSmKYK4lhiGktzqOEYaLG8h5V45twCqEcxDTgwDHsU3I?=
 =?us-ascii?Q?ci8IaJFqrVojnREL/L755EBIw88LQkundxopV3ELftT/unO9oxyg9I6t8yYE?=
 =?us-ascii?Q?6MvBAnclxrrWRifRyI70Pl0D0chvnAOaeET3SdwhugBj1CZ9xPjomACK4ASY?=
 =?us-ascii?Q?Zoc6OBE/jRmGC6GlQ7DThajcOdgrK3AmHGQmrG3ERM2wG6tTrJjiJkETFLk6?=
 =?us-ascii?Q?iRLlw0d20rgXtgv3BsYZ+Ipyfq1G07DnhdN3tNGWJlDoQxfERZKJhLKIP644?=
 =?us-ascii?Q?0eeEQLV8vxm5QcPBAVe9y1boPgFdI7x6fmF7fAra9RmpAUkNqacvXWN60CHN?=
 =?us-ascii?Q?E+RTJred9kap2QEtAa1/GdfhAcYhUGaBSFetRi5z+C7YtKvgewFXn0n2Zuue?=
 =?us-ascii?Q?ODE2CZgsxZ6KabjZ13ZpQBdqHT2hd1LL8WX/BQjdUGiIIvBLTZwaIVYsYln+?=
 =?us-ascii?Q?LqMKWOso06cZIXmkg/BE02PqyuE9H0fSvN6sOUb/n9t0tihzjaqDYAn+rOvJ?=
 =?us-ascii?Q?wHHINKNNcrt3EzfSI6F9VM6Rm1WEmQWDM87+0k7fvgu5pnnanvIiwbzk80iN?=
 =?us-ascii?Q?ekqTFv1hYF/pWTqViRbeOWpIlgfJ37DWYePdL4iiMOne7+0nd94R6edCCn9j?=
 =?us-ascii?Q?ArUme59zajvICcVD4ItqfMgF/SnVhGvJUQIWCKis/LuA4sURx4I6rPh2eAW+?=
 =?us-ascii?Q?Pi5pZQg/1hx4vyadsF4Po1FflYSuRwfaarLOoDorsMPGyj6ZOLUw910fIK6D?=
 =?us-ascii?Q?8XRbUqKxz3DZmuwGaRoesTSX0mZcl0cXI7nvjLO2UZyX9tM7+uOUJd+lxsuK?=
 =?us-ascii?Q?Kvcwk2vMjEgIPqnBJLIbOSk8vxnewNBikthRUoT7P50sB77zwH/ieYIWT42D?=
 =?us-ascii?Q?IWJeZCrfJBQMRqQFn05/uhjmxX2GEtqvK/HpoN/1su3vU0Aznlmw699NP2Sf?=
 =?us-ascii?Q?mWNnWVg9nKxJMFYVCMBbR29nmA6TaxU/c1uEMKQ2ZN1VK+k+6GrWRucZpzhi?=
 =?us-ascii?Q?rlXfjm8a1zYMg3vrbqK2h59IPr+Jd1fIfe0rGRmJLwSPWWcXq/b5KKs3zDxP?=
 =?us-ascii?Q?dhXPMb/VUOv4hZeQU8exJWNj4Je1NpknfPletaG5DYTjsdRtfetJ3uZhkGHk?=
 =?us-ascii?Q?6RrjLoqypWErpqiu96St7Bq9TtOa9mj0rlG7lJM/nccS7Ez/+vL6/E0tFB56?=
 =?us-ascii?Q?o7ABwnOy+OGPhtxs4KScrP8icAIO40vz6FECqDN9C+bYwk7Y0eGQCzFuOhG1?=
 =?us-ascii?Q?3OlGhPNwpTBzsdWd0stZRndRr8b1ax8Ru7BknY8QwVTWGdXzlvAgKHGTBg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 13:56:53.2639
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 431ef7b3-8cdf-4bb2-8178-08dd92ef2eae
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AM1PEPF000252DB.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7100

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Use the first 3-byte hole at the beginning of the tcp_sock_write_txrx
group for 'noneagle'/'rate_app_limited' to fill in the existing hole
in later patches. Therefore, the group size of tcp_sock_write_txrx is
reduced from 92 + 4 to 91 + 4. In addition, the group size of
tcp_sock_write_rx is changed to 96 to fit in the pahole outcome.
Below are the trimmed pahole outcomes before and after this patch:

[BEFORE THIS PATCH]
struct tcp_sock {
    [...]
    __cacheline_group_begin__tcp_sock_write_txrx[0]; /*  2585     0 */
    /* XXX 3 bytes hole, try to pack */

    [...]
    struct tcp_options_received rx_opt;              /*  2652    24 */
    u8                         nonagle:4;            /*  2676: 0  1 */
    u8                         rate_app_limited:1;   /*  2676: 4  1 */
    /* XXX 3 bits hole, try to pack */

    __cacheline_group_end__tcp_sock_write_txrx[0];   /*  2677     0 */
    /* XXX 3 bytes hole, try to pack */

    __cacheline_group_begin__tcp_sock_write_rx[0] __attribute__((__aligned__(8))); /*  2680     0 */

    [...]
    __cacheline_group_end__tcp_sock_write_rx[0];     /*  2776     0 */

    [...]
    /* size: 3264, cachelines: 51, members: 163 */
}

[AFTER THIS PATCH]
struct tcp_sock {
    [...]
    __cacheline_group_begin__tcp_sock_write_txrx[0]; /*  2585     0 */
    u8                         nonagle:4;            /*  2585: 0  1 */
    u8                         rate_app_limited:1;   /*  2585: 4  1 */
    /* XXX 3 bits hole, try to pack */
    /* XXX 2 bytes hole, try to pack */

    [...]
    struct tcp_options_received rx_opt;              /*  2652    24 */

    __cacheline_group_end__tcp_sock_write_txrx[0];   /*  2676     0 */
    /* XXX 4 bytes hole, try to pack */

    __cacheline_group_begin__tcp_sock_write_rx[0] __attribute__((__aligned__(8))); /*  2680     0 */

    [...]
    __cacheline_group_end__tcp_sock_write_rx[0];     /*  2776     0 */

    [...]
    /* size: 3264, cachelines: 51, members: 163 */
}

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/linux/tcp.h | 4 ++--
 net/ipv4/tcp.c      | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index a8af71623ba7..0c82a8c942dc 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -286,6 +286,8 @@ struct tcp_sock {
  *	Header prediction flags
  *	0x5?10 << 16 + snd_wnd in net byte order
  */
+	u8	nonagle     : 4,/* Disable Nagle algorithm?             */
+		rate_app_limited:1;  /* rate_{delivered,interval_us} limited? */
 	__be32	pred_flags;
 	u64	tcp_clock_cache; /* cache last tcp_clock_ns() (see tcp_mstamp_refresh()) */
 	u64	tcp_mstamp;	/* most recent packet received/sent */
@@ -304,8 +306,6 @@ struct tcp_sock {
  *      Options received (usually on last packet, some only on SYN packets).
  */
 	struct tcp_options_received rx_opt;
-	u8	nonagle     : 4,/* Disable Nagle algorithm?             */
-		rate_app_limited:1;  /* rate_{delivered,interval_us} limited? */
 	__cacheline_group_end(tcp_sock_write_txrx);
 
 	/* RX read-write hotpath cache lines */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 0ae265d39184..bc9ab715fc2b 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -5130,7 +5130,7 @@ static void __init tcp_struct_check(void)
 	/* 32bit arches with 8byte alignment on u64 fields might need padding
 	 * before tcp_clock_cache.
 	 */
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 92 + 4);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 91 + 4);
 
 	/* RX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_received);
@@ -5147,7 +5147,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_acked);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcv_rtt_est);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcvq_space);
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_rx, 99);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_rx, 96);
 }
 
 void __init tcp_init(void)
-- 
2.34.1


