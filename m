Return-Path: <linux-kselftest+bounces-39078-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C63B27B78
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 10:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9002605B66
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 08:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919762D59E5;
	Fri, 15 Aug 2025 08:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="b6joWRqm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011020.outbound.protection.outlook.com [52.101.70.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8659E2D239B;
	Fri, 15 Aug 2025 08:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755247203; cv=fail; b=kiwZPF1IAIOWee/fzQBwVsW7OMmYj8ndCUSRavsHFQn5jtNMMJJHAjl6FAO4+/Oyxgs0YqGFcRllYdtFjI7haXsVaj/h2h1xzzg40i4Qou0ZJEIc8So03OzlFAGNCmMOaUnKBzmrXfoozLMFjcKA9Px+7+Cl/UPw6JR0ThKlTYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755247203; c=relaxed/simple;
	bh=hnKXj/TdFWqAks79+cHtAOp/h0nKqDPaHhXoOure2ME=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hfv2Lg4SL69bzN4B3o4CVv2IaAjJ73BrZYU5D9JT2k1J4g8naZQAt/rx/7ijdw6P4fmHt6rbl+AqdwOyxpIA4B8faVEb6iaRvGOwpK/gVIcwh5HjtGOAEd8KH8NCoRV6WWZ70JTKNcF3/iZ3+dtoCYztQV+ZFU0zxOkiT5uYQO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=b6joWRqm; arc=fail smtp.client-ip=52.101.70.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XJCkmw99GNLoCiwSPkOYJOsqV7t0d0cGzquRGTc99lbnZHu6iye0rxZ1mtt5boIYTS8hkAQt9GQQHkrwpMusDeJ8/ddGXotn3COV4zeCOdqNiGEfUekNW2jYditzjijpc4hR31bz8lsr1+R+5o7a5Yy119a63UnTTXbXkLOmPSDjFVRz//AKcWxarR7uojpkNTpRAAeiKD7EA2oynyjq08tafiYHtaUg++Rk+62aFqACxWYfmj/RFBRRVOX3VfZ8S6+OOhXVnXjtW8DiuT/0LUpbpy2ZzUynflkyTVMj1IR6oG4eV4EXmrJRXZsoAPDDsxkLF5EaHpHvmChaaYwJAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XeT6C7FICux3oLMG58JpzW/7pBuDZN/tm9z3I+qNcrk=;
 b=YqK5f0sdB/MuMn/Zw+6zDC8exRhfVZyhvac0LsMaCEPtnqr6/ovECuLIDlNAu9Ztc5Wrj17Uvqor4krRLHuq8UTs3zYSbLCE/revA03Vopx5A9WGJYdqGz5oFjmw8+IK2XZcVdmtKdCl31ebrbgLrKBuRjC3NO4qTx9jLZZB67cBDZcZ1+dspaBJE6p7RUX+dZxJkbivMpaSP1qGTdI5JHUZomZKm1F6et9H6UhkrwVkHi5eGjb7Ahjr5lfah7e608UHynyCTZhF4W6B1AAEHivtBLzsrFsxyj9v9Q3cDyU158CUAgNFhrleveIcfDeQ8s0Ylb0KH9GGLXG8IUQQ4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XeT6C7FICux3oLMG58JpzW/7pBuDZN/tm9z3I+qNcrk=;
 b=b6joWRqmc3/Qi2mqB1qZaZ+aeTGjvYG2SP2COTrcJAqRRPGtUozLvyCOkUGF5acsrx6reyC4+aVKS8nYYeqYV3WB/aYBjyxzqmDAzWm8Xsl6WoqB8MY9TC1ECq40HwrCdTUlUPlHlVdFg7xD5xzIOCuMEHtOqDdL66EwKFcOldGQ7BfTKppb6fvu1JmlSkMNMX7VBWQWo3/gCIwhHSOHoN1wVVMABiab5qoWI98iYqtaiPV7jwHpJyERxXWrs/WJhSBeRO2kZRdwGRiU9mMv93ozokZ+6U98NmHcWD2EQmY6ZCsXHOdmcUrgi6k4stB6mK1ATsbUkGyMQzY2ol1N+g==
Received: from CWLP265CA0494.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18b::13)
 by AM9PR07MB8002.eurprd07.prod.outlook.com (2603:10a6:20b:2fc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 08:39:58 +0000
Received: from AM1PEPF000252DD.eurprd07.prod.outlook.com
 (2603:10a6:400:18b:cafe::22) by CWLP265CA0494.outlook.office365.com
 (2603:10a6:400:18b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Fri,
 15 Aug 2025 08:39:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM1PEPF000252DD.mail.protection.outlook.com (10.167.16.55) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.11
 via Frontend Transport; Fri, 15 Aug 2025 08:39:44 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 0D38D1C0010;
	Fri, 15 Aug 2025 11:39:43 +0300 (EEST)
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
Subject: [PATCH v15 net-next 03/14] tcp: reorganize tcp_sock_write_txrx group for variables later
Date: Fri, 15 Aug 2025 10:39:19 +0200
Message-Id: <20250815083930.10547-4-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250815083930.10547-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250815083930.10547-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DD:EE_|AM9PR07MB8002:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 265ccb63-0778-4c29-2b15-08dddbd7491d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|1800799024|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F3KZfT9MWNRW+m/P0vB67h2t+ld9BpYh73L43GxZNX63IWJDFARYyxYNc/WH?=
 =?us-ascii?Q?Uy36qiVCZ69gRfeDJeimxTz6/awGt6xxzp5ptTaKowFVWej2n2TiCkIfhU7V?=
 =?us-ascii?Q?N+YHxC6u9Sj9WOYWwYI84W4WfvIe37Q6DicotFtcfGTuoWhuBHtOKoU+NLXR?=
 =?us-ascii?Q?JXdinByWLdoG1ddk+T8RI5iJsCJyoYRgiYeWGGDi57W/llF3PgRodfhs785/?=
 =?us-ascii?Q?dZMHrLOrqm3VGPzr/T6fbjew7gCTwDUJSxL45PhyXJ8ubgla084257niDrse?=
 =?us-ascii?Q?Fsa+qUZ2R9ARxR7xwFxei08lHpTbBCT1SXVhzOA+iqQwBtrrBlhUuzLIBaEr?=
 =?us-ascii?Q?dgKj86O6O7a1i9kEja2OsPDrVsdNaB16QUvuiNIHB1pjBkymrV5fsK7kRob1?=
 =?us-ascii?Q?bu0hrYt3YHrFyAhr/C9BwI2OFuoAQmwLOFUx6RgSzxVZ5Q+fXcaLLlM8mSAo?=
 =?us-ascii?Q?1duvZLbTNwfXn2sRNYDgm5QRsI/zjt3ynOpTf2z/S0Ytpmv/qVpC0RqFL5A+?=
 =?us-ascii?Q?O0V/VWAk9GYneq2BkH57oCzXuNbeX869iXltpk5sqOxiiFW8x0yoUjG3ml1B?=
 =?us-ascii?Q?Wy/ixbqOvUgtUkhLZcL3AtT/7sb4B/YiFPuZICzo9uYPJA4x/Zyo0C7mVujU?=
 =?us-ascii?Q?kDYXVfjwcu8LKvA9cAHGuP0fHupvmzwRUUi3Wa31QCGuN5PmdY2kzu4w7RtJ?=
 =?us-ascii?Q?JmduZyvhlY/r04R53bUSrGAveNglaAtLNmmxwy+DAD8NaqFAauVEL2bL/LHO?=
 =?us-ascii?Q?HJn3eQ0XkwXy970BlEJz0FYtj/SmSaY0ipyojJ6FacgXnmmwCOB1X5ERLJNs?=
 =?us-ascii?Q?ft9FehnmfKqq1h5w+P5EDTUF4A7ydEDF8BdnAaOIu1XAO1H5VDHeilCMr4b9?=
 =?us-ascii?Q?3f8pP7mtF88XIuxOVDGH1MCZ+DEyTKaVmJKCmOlwq4vgrCrLvuXrJUErp77W?=
 =?us-ascii?Q?uCG2Yb1rG3hptu66tZ63W++w2BSnlDVe73RJeBwgyi2slVko94TZGZcUz5L9?=
 =?us-ascii?Q?9m/mlv5j//oGfQUcsbWybDFtYtk40KE6YaKTRAk+gx8PHaIr5AQ+XhApJ4XR?=
 =?us-ascii?Q?i+hhAbE7E+LuhypbzpqE21B2EEBVH3bw/wxor6UJbqef3FpAiAEIblg8/XYr?=
 =?us-ascii?Q?6b2u5GQpMfwbju/n88DLmmYazF3EHSmwbcL7FYjUJ/auxge/KpnSPst7h3V7?=
 =?us-ascii?Q?M4xbh4hPokaSZOMEXO+DFGWJlhPfrbS/zJlF/v2OghxqgvxwipHw+0Ia/RDF?=
 =?us-ascii?Q?Ced3d1IJ5N9t4uQeXVmZNyYesz6hp7UEip7IxVWZKLogrsMbonm9EaZz3Am5?=
 =?us-ascii?Q?FE/VxtimN2jdgpvzV8PGGjaDPPWeHgIy0aq8DcfKfvJgCm3Q4OjZUrMf37HO?=
 =?us-ascii?Q?FMXysoE5u1XTBGRteLUSt0+WaY6W6MVNJ1pWXOE2Qdjf5ccMxGu3IB5twH/B?=
 =?us-ascii?Q?AwRk7Ugue7a9vpskdhlDCz4U2pIorbwAjFk6qETp8D0JhhTGX/VRCuTTulgd?=
 =?us-ascii?Q?+AcMgnGOuE8Zw9haew+u9PGqkNjEqL3TFdw6dw+HO7H2fNfN7a+JfbfaeQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(1800799024)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 08:39:44.6762
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 265ccb63-0778-4c29-2b15-08dddbd7491d
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DD.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB8002

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
    __cacheline_group_begin__tcp_sock_write_txrx[0]; /*  2521     0 */
    /* XXX 3 bytes hole, try to pack */

    [...]
    struct tcp_options_received rx_opt;              /*  2588    24 */
    u8                         nonagle:4;            /*  2612: 0  1 */
    u8                         rate_app_limited:1;   /*  2612: 4  1 */
    /* XXX 3 bits hole, try to pack */

    __cacheline_group_end__tcp_sock_write_txrx[0];   /*  2613     0 */
    /* XXX 3 bytes hole, try to pack */

    __cacheline_group_begin__tcp_sock_write_rx[0] __attribute__((__aligned__(8))); /*  2616     0 */

    [...]
    __cacheline_group_end__tcp_sock_write_rx[0];     /*  2712     0 */

    [...]
    /* size: 3200, cachelines: 50, members: 161 */
}

[AFTER THIS PATCH]
struct tcp_sock {
    [...]
    __cacheline_group_begin__tcp_sock_write_txrx[0]; /*  2521     0 */
    u8                         nonagle:4;            /*  2521: 0  1 */
    u8                         rate_app_limited:1;   /*  2521: 4  1 */
    /* XXX 3 bits hole, try to pack */
    /* XXX 2 bytes hole, try to pack */

    [...]
    struct tcp_options_received rx_opt;              /*  2588    24 */

    __cacheline_group_end__tcp_sock_write_txrx[0];   /*  2612     0 */
    /* XXX 4 bytes hole, try to pack */

    __cacheline_group_begin__tcp_sock_write_rx[0] __attribute__((__aligned__(8))); /*  2616     0 */

    [...]
    __cacheline_group_end__tcp_sock_write_rx[0];     /*  2712     0 */

    [...]
    /* size: 3200, cachelines: 50, members: 161 */
}

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/tcp.h | 4 ++--
 net/ipv4/tcp.c      | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 57e478bfaef2..d103cc0e7a35 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -285,6 +285,8 @@ struct tcp_sock {
  *	Header prediction flags
  *	0x5?10 << 16 + snd_wnd in net byte order
  */
+	u8	nonagle     : 4,/* Disable Nagle algorithm?             */
+		rate_app_limited:1;  /* rate_{delivered,interval_us} limited? */
 	__be32	pred_flags;
 	u64	tcp_clock_cache; /* cache last tcp_clock_ns() (see tcp_mstamp_refresh()) */
 	u64	tcp_mstamp;	/* most recent packet received/sent */
@@ -303,8 +305,6 @@ struct tcp_sock {
  *      Options received (usually on last packet, some only on SYN packets).
  */
 	struct tcp_options_received rx_opt;
-	u8	nonagle     : 4,/* Disable Nagle algorithm?             */
-		rate_app_limited:1;  /* rate_{delivered,interval_us} limited? */
 	__cacheline_group_end(tcp_sock_write_txrx);
 
 	/* RX read-write hotpath cache lines */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 71a956fbfc55..6fc127271983 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -5127,7 +5127,7 @@ static void __init tcp_struct_check(void)
 	/* 32bit arches with 8byte alignment on u64 fields might need padding
 	 * before tcp_clock_cache.
 	 */
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 92 + 4);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 91 + 4);
 
 	/* RX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_received);
@@ -5144,7 +5144,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_acked);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcv_rtt_est);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcvq_space);
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_rx, 99);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_rx, 96);
 }
 
 void __init tcp_init(void)
-- 
2.34.1


