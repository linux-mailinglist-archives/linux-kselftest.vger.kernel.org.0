Return-Path: <linux-kselftest+bounces-40891-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC42FB47460
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Sep 2025 18:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6DAA588992
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Sep 2025 16:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77432F90CC;
	Sat,  6 Sep 2025 16:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Gf+SuXJ0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011055.outbound.protection.outlook.com [52.101.70.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413B64A00;
	Sat,  6 Sep 2025 16:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757176165; cv=fail; b=TFCKBiB9TrFIKlbzqm74jYzWAVX0BzU3KV8ojdtC5GvIFJ/Huay3esCkFnuMMhxOHjpyTeCpWt5s2tEAqtI7JfDeFyycFTH3q+q3U57kj2hv4MMTTeVzODRjVH0UQb8d2pFxLg1sDP/xDHawi2DNHpwnkNZU948CNpmBg5+Ag/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757176165; c=relaxed/simple;
	bh=UujMd6l4BwAYvS6LBJ7a2v4xOWDCrQNV3P4B0Qty70o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rmR08r/T0C/XArxXh5Zpwu7NMvKzsmWDYhlRTAhZUCGWqAjC2ENv5fbu0XqiJahB8GYaA6XV+gTNW+fAMFDddiPkkUWLScFtR6WDaR7vK/Fx418pHyWz4Dg4owsGxORaVZJjfuxCSOuPLT/Qll9rt3UUonqYRoH5wOcuVQqAwPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Gf+SuXJ0; arc=fail smtp.client-ip=52.101.70.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q9VEaN9IT6MATdwqIWvlji8TTMvBpdKOLxWP8pV0ell8vXAsaO6jX2ImDJb6XAf8syLyO//BBw4WD3Wc+wv2vzgB+RvCsAubxwq5caI2iC6Jzkh6uFLDc8gjS5P2Gr6lKV5yHEW21bpxH/M9dtajfWlLiGtJC2LQnotQTIJ1+cVAf+wAoEw6o2MxV21lLki9lptgpNw1a1HACN3TOYGmeK5FA5XMAZnsSvYrkJtrPItU6VSltGpmXrWx48hm6shdov3MQANHb2I3okIAStH13GoajxTV5pvr41Xwybpl+UH916BeJ/jLu+3LKApcnJ2wjmbOMtATksV8aS4ULWbozA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zn4Vdkz7VnImIUxEKHORQoYdz9r/A0rEOiXX269vYVo=;
 b=TCR2FyF9hBX0832VgfCpGAtm51KwKGcdHJFygNHzhgpXXeM0r9ESVbGJXoEqvC+Vug1qbEvqbzfVgvNp4S8YvtMF1YwNWBNHYFZHcj7SuWOWmCswwVn72TqdtcvLLYgZ56Kpa1rlTY5YbdikjS5LG3jRxjkmNNAGM8niNeRQrpRl5mCOJqgyAAprHpTr88MGLJxjAxtzt/yft/kR7k9pf19o/ygYNVtv4tPMdZO0eRW+PzaTzouXSWXzV7ARQ0we4KwQ3TrHrCUSfTD4F9fJ3JYsCrPDfhq7M8uOgixg0MtvF+zYA57v1dZghq5uCXSl/hB9pzxekzYOMsQqrrMNjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zn4Vdkz7VnImIUxEKHORQoYdz9r/A0rEOiXX269vYVo=;
 b=Gf+SuXJ0ZfbV56KgX6Xfkk6p6CR19bFezZYJGnwBf3rAX+CWwNFkF5P8Wryt+lgjOcgYZ1EubJAWOQ4G33TfsNl+ctZFfUVYcFuC5nh/HTSRq2D1VFXiHe/sopMQQ9NzU/dZjIyajD8s2w/H7EopOUO7bej7lELiLmfz/ipwCVguwbEjT7zrcQwRMGJ2MXtEre4vtM1KE4KPcgMyy5iKDhXjVPMbExjFTGex123lBYU/SK5oqdGXHbE0fhaqXRq0D3YPmb3OHTaEJ1ibF06V7wvmLj/jcoNsvhdNHreFOcJ6N1GiIZiNv7gFKnib86I2ZHM3xPf2eQJnzTue8+3LTQ==
Received: from DB7PR03CA0084.eurprd03.prod.outlook.com (2603:10a6:10:72::25)
 by AS5PR07MB9723.eurprd07.prod.outlook.com (2603:10a6:20b:652::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Sat, 6 Sep
 2025 16:29:16 +0000
Received: from DU2PEPF00028D0C.eurprd03.prod.outlook.com
 (2603:10a6:10:72:cafe::e0) by DB7PR03CA0084.outlook.office365.com
 (2603:10a6:10:72::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Sat,
 6 Sep 2025 16:29:16 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.6.101) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DU2PEPF00028D0C.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.11
 via Frontend Transport; Sat, 6 Sep 2025 16:29:15 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 828761C0031;
	Sat,  6 Sep 2025 19:29:13 +0300 (EEST)
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
Subject: [PATCH v16 net-next 11/14] tcp: accecn: AccECN option send control
Date: Sat,  6 Sep 2025 18:28:47 +0200
Message-Id: <20250906162850.73598-12-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250906162850.73598-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250906162850.73598-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0C:EE_|AS5PR07MB9723:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ff56dce-09ce-4681-73ab-08dded628514
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d3pNdU50Ky8yaUhsa0NmYkdGdTZJaGFoOXJNZjZRL29OS0xqODZ1UlBLc0Zl?=
 =?utf-8?B?Nyt0M0N0bHljblNwNkNzQUdDNjVRTHM4ZGErc3l3OHZmVkxodklTalQ2dTJj?=
 =?utf-8?B?SG1CaitUN1BtRG5jNklqM2xIQVVITi9VUDBxclpkQnZ4NG9NN2tXS3B4Umd1?=
 =?utf-8?B?U3NMa0hMTzBydWRrZnRBRHU4aDRWQzFuYlBXMTdZUGZRTUNDR05vRURXY201?=
 =?utf-8?B?bU0xUnpxUHFwaTZyekJlVGRFQlg1dlBxbGdGS2N0V3R2dzdZejd6dDRGeG05?=
 =?utf-8?B?K2FrZ1c4TkZ2T2dTdkNzTm1rMkdBNFprRXN6WitpTmdCb0dFVUw5T1NFOVp2?=
 =?utf-8?B?dVNTYW44REtINHhKMjdYYk0wbTd0Q0QyWnhNbzNkcXE1VnU3NFJ5ZmtqbGEx?=
 =?utf-8?B?RWRBOFhDMjA0R0Q2ZE8zdzBZMlFvWGd5U0llV01vZVBRM2Vwem1xZHk4dk9a?=
 =?utf-8?B?bWhWZTAwRzZhMFdEdjRGVHh3K25rUVBJT3R5YnhyS2NwelhwWWdicGdPNDQ4?=
 =?utf-8?B?Um1NVmRPdTZBUkNCTk1mWGhVMnNTbkNxL3p6NzExTDJuQ1V0ZDV3bERZQWxG?=
 =?utf-8?B?YmtWYUJjRURRMVgxQWRtNEFuMEViTEFIUnVKNHZVTkU2L1JUT1hEbDRpS2NT?=
 =?utf-8?B?clRhMUpnejZjM2lvZ051V0VCQ3hzYkVmbDliQ2JMUi83Qm1NUnZ2MXRWWkVz?=
 =?utf-8?B?V2JzUDZBTE5penpMQ0d5QUs0QkozcUpXUTUrcmtFNjd3VnJGRTF6ZUd6UzVF?=
 =?utf-8?B?emRCbjVKbmtVbDcrZlYwbnA1ZkVJQUs1TTdGdXE5UjYzcXIwMll5ck5IcW5V?=
 =?utf-8?B?QXA1aUovTXFQVy9KLzhBTHdRMDdNQnFTby84enVLNFQ2VzNxQ0dscDV0SWM4?=
 =?utf-8?B?WVRUWlRERFY3dmtSVFEzczZsMjFaR0loeXZ6azNBc0FmWEdnYU9HdVl6ZXNT?=
 =?utf-8?B?U2EyZDNXeXNteW5zZHYwSzdEMFFHcWt0TjVSTnlhakYxRU5qS1RmbTc5NWhX?=
 =?utf-8?B?WkVaVXdDVHJ2dGRQbHdhTWl6SjZURjdqZFdJdTVzQ3I3RmZ4UVVGa08wZEQ0?=
 =?utf-8?B?QXNkb3lidDRCTzRDTkdtWnk3MUdJWHRlVi8vOGRzaG4vTmFwOGNzR1Z1cjNa?=
 =?utf-8?B?R0NYc0xYMXRBRUVKOEhVSzhIN1FTaG9qbEhFa2pDa2VqZUkrcUcrSXdGL0U5?=
 =?utf-8?B?VDE3M2p3UUtISWczYUdFU3JDTDNyVVF5RzVCUTVYQmt6c1RXaWxwbVV6NlhP?=
 =?utf-8?B?VStqaCtNN0Y1RDJGNU1ib3JDU1hZOUgrVUNCZjQxWkV5YitwQkoxRnRXQmtv?=
 =?utf-8?B?NjJNNWNpVU9kOGFjdGkrK0NGRUNxdTV3NHRCM1dnQUFoRWt1Ym1vTUNjN2lX?=
 =?utf-8?B?R0VERFhoejRZZ3JBbzRlYTdHOU80eXBPMi9NMjlLNG5SY0E4V3VSbUtOMS9s?=
 =?utf-8?B?VzF3QVkzcHJaYWs1OG9YbUtiWHpKbHpXb2h3UkdEQ01TbTFRWDF5VFdZMnlV?=
 =?utf-8?B?bmp1VC9VR3B5bXNmTkwvQzZna2xCSXJTN1BCc1I4VVEvVGR2Z3JkNFljZWVq?=
 =?utf-8?B?V201NzNZWWpaVWdSL1loQXBaQmpGN0E0VjdIV21sQTZBKzZXYVNRY3BPOWY4?=
 =?utf-8?B?WTQ0aGFwdG80T0ZUVXVScGoxa0t3ZjNDeUhHU2xFNENwVExDUkVKa0lpSWl1?=
 =?utf-8?B?WUsvWjhLTFVNZG1EMldpUUE0U0FOUHYrK3d6QUplQ0NJajNLUnpkaWRuR0Mv?=
 =?utf-8?B?KzJ3cjNZdU9JVWhMNkNNdTFkT0FpZ3Y2dUt6QVBYckcwWVdlT2JWTHFVa3Ja?=
 =?utf-8?B?T21rWEkrdER1N0srdExySktYZWxkMk9oQVNKSFA0b1JJdWp5Tk1EWHBEOC90?=
 =?utf-8?B?RDM3YXhGSmZHMStwWFphVnV2ek03OExYcVVnbHFsN3NNQXRIaXF5eUFkU2pl?=
 =?utf-8?B?cGo0TW1Kc0tOUHFNV1hXMVR6c1Q3QXlGVG1KeFNxbkt6aWNXQVZLMjJzR3JF?=
 =?utf-8?B?OXpmRVcrSmI1U2N2Vnh0K3dzRlRsTFE0TmRpNFRjYVJNeTlkbDVDQ1RLTDdV?=
 =?utf-8?B?cGdnNVFFS1BzRFJzcWxRbzRUQ0hkT1A3dWFwZz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2025 16:29:15.0573
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ff56dce-09ce-4681-73ab-08dded628514
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU2PEPF00028D0C.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR07MB9723

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Instead of sending the option in every ACK, limit sending to
those ACKs where the option is necessary:
- Handshake
- "Change-triggered ACK" + the ACK following it. The
  2nd ACK is necessary to unambiguously indicate which
  of the ECN byte counters in increasing. The first
  ACK has two counters increasing due to the ecnfield
  edge.
- ACKs with CE to allow CEP delta validations to take
  advantage of the option.
- Force option to be sent every at least once per 2^22
  bytes. The check is done using the bit edges of the
  byte counters (avoids need for extra variables).
- AccECN option beacon to send a few times per RTT even if
  nothing in the ECN state requires that. The default is 3
  times per RTT, and its period can be set via
  sysctl_tcp_ecn_option_beacon.

Below are the pahole outcomes before and after this patch,
in which the group size of tcp_sock_write_tx is increased
from 89 to 97 due to the new u64 accecn_opt_tstamp member:

[BEFORE THIS PATCH]
struct tcp_sock {
    [...]
    u64                        tcp_wstamp_ns;        /*  2488     8 */
    struct list_head           tsorted_sent_queue;   /*  2496    16 */

    [...]
    __cacheline_group_end__tcp_sock_write_tx[0];     /*  2521     0 */
    __cacheline_group_begin__tcp_sock_write_txrx[0]; /*  2521     0 */
    u8                         nonagle:4;            /*  2521: 0  1 */
    u8                         rate_app_limited:1;   /*  2521: 4  1 */
    /* XXX 3 bits hole, try to pack */

    /* Force alignment to the next boundary: */
    u8                         :0;
    u8                         received_ce_pending:4;/*  2522: 0  1 */
    u8                         unused2:4;            /*  2522: 4  1 */
    u8                         accecn_minlen:2;      /*  2523: 0  1 */
    u8                         est_ecnfield:2;       /*  2523: 2  1 */
    u8                         unused3:4;            /*  2523: 4  1 */

    [...]
    __cacheline_group_end__tcp_sock_write_txrx[0];   /*  2628     0 */

    [...]
    /* size: 3200, cachelines: 50, members: 171 */
}

[AFTER THIS PATCH]
struct tcp_sock {
    [...]
    u64                        tcp_wstamp_ns;        /*  2488     8 */
    u64                        accecn_opt_tstamp;    /*  2596     8 */
    struct list_head           tsorted_sent_queue;   /*  2504    16 */

    [...]
    __cacheline_group_end__tcp_sock_write_tx[0];     /*  2529     0 */
    __cacheline_group_begin__tcp_sock_write_txrx[0]; /*  2529     0 */
    u8                         nonagle:4;            /*  2529: 0  1 */
    u8                         rate_app_limited:1;   /*  2529: 4  1 */
    /* XXX 3 bits hole, try to pack */

    /* Force alignment to the next boundary: */
    u8                         :0;
    u8                         received_ce_pending:4;/*  2530: 0  1 */
    u8                         unused2:4;            /*  2530: 4  1 */
    u8                         accecn_minlen:2;      /*  2531: 0  1 */
    u8                         est_ecnfield:2;       /*  2531: 2  1 */
    u8                         accecn_opt_demand:2;  /*  2531: 4  1 */
    u8                         prev_ecnfield:2;      /*  2531: 6  1 */

    [...]
    __cacheline_group_end__tcp_sock_write_txrx[0];   /*  2636     0 */

    [...]
    /* size: 3200, cachelines: 50, members: 173 */
}

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Co-developed-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Reviewed-by: Eric Dumazet <edumazet@google.com>

---
v14
- Add missing const for struct tcp_sock of tcp_accecn_option_beacon_check()

v13
- Use GENMASK_U32() for bytes_mask of tcp_ecn_received_counters()
- Make tcp_accecn_option_beacon_check() consistent
- Use READ_ONCE() only once in tcp_established_options()

v10
- Add documentation of tcp_ecn_option_beacon in ip-sysctl.rst to this patch

v8:
- Add new helper function tcp_accecn_opt_demand_min()
- Remove white space only change
---
 Documentation/networking/ip-sysctl.rst        |  6 +++
 .../networking/net_cachelines/tcp_sock.rst    |  3 ++
 include/linux/tcp.h                           |  4 +-
 include/net/netns/ipv4.h                      |  1 +
 include/net/tcp.h                             |  3 ++
 include/net/tcp_ecn.h                         | 52 +++++++++++++++++++
 net/ipv4/sysctl_net_ipv4.c                    |  9 ++++
 net/ipv4/tcp.c                                |  5 +-
 net/ipv4/tcp_input.c                          |  4 +-
 net/ipv4/tcp_ipv4.c                           |  1 +
 net/ipv4/tcp_minisocks.c                      |  2 +
 net/ipv4/tcp_output.c                         | 26 +++++++---
 12 files changed, 107 insertions(+), 9 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 1c206501b973..a06cb99d66dc 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -487,6 +487,12 @@ tcp_ecn_option - INTEGER
 
 	Default: 2
 
+tcp_ecn_option_beacon - INTEGER
+	Control Accurate ECN (AccECN) option sending frequency per RTT and it
+	takes effect only when tcp_ecn_option is set to 2.
+
+	Default: 3 (AccECN will be send at least 3 times per RTT)
+
 tcp_ecn_fallback - BOOLEAN
 	If the kernel detects that ECN connection misbehaves, enable fall
 	back to non-ECN. Currently, this knob implements the fallback
diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index b941151f8c0a..d4dc01800945 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -109,6 +109,9 @@ u8:2                          syn_ect_snt             write_mostly        read_w
 u8:2                          syn_ect_rcv             read_mostly         read_write
 u8:2                          accecn_minlen           write_mostly        read_write
 u8:2                          est_ecnfield                                read_write
+u8:2                          accecn_opt_demand       read_mostly         read_write
+u8:2                          prev_ecnfield                               read_write
+u64                           accecn_opt_tstamp       read_write
 u8:4                          accecn_fail_mode
 u32                           lost                                        read_mostly         tcp_ack
 u32                           app_limited             read_write          read_mostly         tcp_rate_check_app_limited,tcp_rate_skb_sent(tx);tcp_rate_gen(rx)
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 73557656cb2d..f637b659b35a 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -275,6 +275,7 @@ struct tcp_sock {
 	u32	mdev_us;	/* medium deviation			*/
 	u32	rtt_seq;	/* sequence number to update rttvar	*/
 	u64	tcp_wstamp_ns;	/* departure time for next sent data packet */
+	u64	accecn_opt_tstamp;	/* Last AccECN option sent timestamp */
 	struct list_head tsorted_sent_queue; /* time-sorted sent but un-SACKed skbs */
 	struct sk_buff *highest_sack;   /* skb just after the highest
 					 * skb with SACKed bit set
@@ -296,7 +297,8 @@ struct tcp_sock {
 		unused2:4;
 	u8	accecn_minlen:2,/* Minimum length of AccECN option sent */
 		est_ecnfield:2,/* ECN field for AccECN delivered estimates */
-		unused3:4;
+		accecn_opt_demand:2,/* Demand AccECN option for n next ACKs */
+		prev_ecnfield:2; /* ECN bits from the previous segment */
 	__be32	pred_flags;
 	u64	tcp_clock_cache; /* cache last tcp_clock_ns() (see tcp_mstamp_refresh()) */
 	u64	tcp_mstamp;	/* most recent packet received/sent */
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index acbb7dd497e1..34eb3aecb3f2 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -149,6 +149,7 @@ struct netns_ipv4 {
 
 	u8 sysctl_tcp_ecn;
 	u8 sysctl_tcp_ecn_option;
+	u8 sysctl_tcp_ecn_option_beacon;
 	u8 sysctl_tcp_ecn_fallback;
 
 	u8 sysctl_ip_default_ttl;
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 02f2895d57a8..dbb28c33ddc1 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -100,6 +100,9 @@ void tcp_time_wait(struct sock *sk, int state, int timeo);
 /* Maximal number of window scale according to RFC1323 */
 #define TCP_MAX_WSCALE		14U
 
+/* Default sending frequency of accurate ECN option per RTT */
+#define TCP_ACCECN_OPTION_BEACON	3
+
 /* urg_data states */
 #define TCP_URG_VALID	0x0100
 #define TCP_URG_NOTYET	0x0200
diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index 08c7f4757e4e..133fb6b79500 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -176,6 +176,17 @@ static inline void tcp_accecn_third_ack(struct sock *sk,
 	}
 }
 
+/* Demand the minimum # to send AccECN optnio */
+static inline void tcp_accecn_opt_demand_min(struct sock *sk,
+					     u8 opt_demand_min)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+	u8 opt_demand;
+
+	opt_demand = max_t(u8, opt_demand_min, tp->accecn_opt_demand);
+	tp->accecn_opt_demand = opt_demand;
+}
+
 /* Maps IP ECN field ECT/CE code point to AccECN option field number, given
  * we are sending fields with Accurate ECN Order 1: ECT(1), CE, ECT(0).
  */
@@ -256,6 +267,7 @@ static inline void tcp_ecn_received_counters(struct sock *sk,
 	u8 ecnfield = TCP_SKB_CB(skb)->ip_dsfield & INET_ECN_MASK;
 	u8 is_ce = INET_ECN_is_ce(ecnfield);
 	struct tcp_sock *tp = tcp_sk(sk);
+	bool ecn_edge;
 
 	if (!INET_ECN_is_not_ect(ecnfield)) {
 		u32 pcount = is_ce * max_t(u16, 1, skb_shinfo(skb)->gso_segs);
@@ -274,9 +286,34 @@ static inline void tcp_ecn_received_counters(struct sock *sk,
 
 		if (len > 0) {
 			u8 minlen = tcp_ecnfield_to_accecn_optfield(ecnfield);
+			u32 oldbytes = tp->received_ecn_bytes[ecnfield - 1];
+			u32 bytes_mask = GENMASK_U32(31, 22);
+
 			tp->received_ecn_bytes[ecnfield - 1] += len;
 			tp->accecn_minlen = max_t(u8, tp->accecn_minlen,
 						  minlen);
+
+			/* Send AccECN option at least once per 2^22-byte
+			 * increase in any ECN byte counter.
+			 */
+			if ((tp->received_ecn_bytes[ecnfield - 1] ^ oldbytes) &
+			    bytes_mask) {
+				tcp_accecn_opt_demand_min(sk, 1);
+			}
+		}
+	}
+
+	ecn_edge = tp->prev_ecnfield != ecnfield;
+	if (ecn_edge || is_ce) {
+		tp->prev_ecnfield = ecnfield;
+		/* Demand Accurate ECN change-triggered ACKs. Two ACK are
+		 * demanded to indicate unambiguously the ecnfield value
+		 * in the latter ACK.
+		 */
+		if (tcp_ecn_mode_accecn(tp)) {
+			if (ecn_edge)
+				inet_csk(sk)->icsk_ack.pending |= ICSK_ACK_NOW;
+			tp->accecn_opt_demand = 2;
 		}
 	}
 }
@@ -349,6 +386,7 @@ static inline void tcp_accecn_init_counters(struct tcp_sock *tp)
 	__tcp_accecn_init_bytes_counters(tp->received_ecn_bytes);
 	__tcp_accecn_init_bytes_counters(tp->delivered_ecn_bytes);
 	tp->accecn_minlen = 0;
+	tp->accecn_opt_demand = 0;
 	tp->est_ecnfield = 0;
 }
 
@@ -431,6 +469,7 @@ static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct tcphdr *th,
 	default:
 		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		tp->syn_ect_rcv = ip_dsfield & INET_ECN_MASK;
+		tp->accecn_opt_demand = 2;
 		if (INET_ECN_is_ce(ip_dsfield) &&
 		    tcp_accecn_validate_syn_feedback(sk, ace,
 						     tp->syn_ect_snt)) {
@@ -451,6 +490,7 @@ static inline void tcp_ecn_rcv_syn(struct tcp_sock *tp, const struct tcphdr *th,
 		} else {
 			tp->syn_ect_rcv = TCP_SKB_CB(skb)->ip_dsfield &
 					  INET_ECN_MASK;
+			tp->prev_ecnfield = tp->syn_ect_rcv;
 			tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		}
 	}
@@ -542,4 +582,16 @@ tcp_ecn_make_synack(const struct request_sock *req, struct tcphdr *th)
 		th->ece = 1;
 }
 
+static inline bool tcp_accecn_option_beacon_check(const struct sock *sk)
+{
+	u32 ecn_beacon = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option_beacon);
+	const struct tcp_sock *tp = tcp_sk(sk);
+
+	if (!ecn_beacon)
+		return false;
+
+	return tcp_stamp_us_delta(tp->tcp_mstamp, tp->accecn_opt_tstamp) * ecn_beacon >=
+	       (tp->srtt_us >> 3);
+}
+
 #endif /* _LINUX_TCP_ECN_H */
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 1d7fd86ca7b9..169a393374b3 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -740,6 +740,15 @@ static struct ctl_table ipv4_net_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_TWO,
 	},
+	{
+		.procname	= "tcp_ecn_option_beacon",
+		.data		= &init_net.ipv4.sysctl_tcp_ecn_option_beacon,
+		.maxlen		= sizeof(u8),
+		.mode		= 0644,
+		.proc_handler	= proc_dou8vec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_THREE,
+	},
 	{
 		.procname	= "tcp_ecn_fallback",
 		.data		= &init_net.ipv4.sysctl_tcp_ecn_fallback,
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index abf598c2b199..3216d5e2657f 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3394,6 +3394,8 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tp->delivered_ce = 0;
 	tp->accecn_fail_mode = 0;
 	tcp_accecn_init_counters(tp);
+	tp->prev_ecnfield = 0;
+	tp->accecn_opt_tstamp = 0;
 	if (icsk->icsk_ca_initialized && icsk->icsk_ca_ops->release)
 		icsk->icsk_ca_ops->release(sk);
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
@@ -5118,11 +5120,12 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, lsndtime);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, mdev_us);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, tcp_wstamp_ns);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, accecn_opt_tstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, rtt_seq);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, tsorted_sent_queue);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, highest_sack);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, ecn_flags);
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_tx, 89);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_tx, 97);
 
 	/* TXRX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, pred_flags);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index e898a76c485e..87154fd86167 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6121,8 +6121,10 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
 	 * RFC 5961 4.2 : Send a challenge ack
 	 */
 	if (th->syn) {
-		if (tcp_ecn_mode_accecn(tp))
+		if (tcp_ecn_mode_accecn(tp)) {
 			accecn_reflector = true;
+			tcp_accecn_opt_demand_min(sk, 1);
+		}
 		if (sk->sk_state == TCP_SYN_RECV && sk->sk_socket && th->ack &&
 		    TCP_SKB_CB(skb)->seq + 1 == TCP_SKB_CB(skb)->end_seq &&
 		    TCP_SKB_CB(skb)->seq + 1 == tp->rcv_nxt &&
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index c9f2c7bee00a..8eabff34017d 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3579,6 +3579,7 @@ static int __net_init tcp_sk_init(struct net *net)
 {
 	net->ipv4.sysctl_tcp_ecn = TCP_ECN_IN_ECN_OUT_NOECN;
 	net->ipv4.sysctl_tcp_ecn_option = TCP_ACCECN_OPTION_FULL;
+	net->ipv4.sysctl_tcp_ecn_option_beacon = TCP_ACCECN_OPTION_BEACON;
 	net->ipv4.sysctl_tcp_ecn_fallback = 1;
 
 	net->ipv4.sysctl_tcp_base_mss = TCP_BASE_MSS;
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index f2f604a5a158..a5a814a655fd 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -472,6 +472,8 @@ static void tcp_ecn_openreq_child(struct sock *sk,
 		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		tp->syn_ect_snt = treq->syn_ect_snt;
 		tcp_accecn_third_ack(sk, skb, treq->syn_ect_snt);
+		tp->prev_ecnfield = treq->syn_ect_rcv;
+		tp->accecn_opt_demand = 1;
 		tcp_ecn_received_counters_payload(sk, skb);
 	} else {
 		tcp_ecn_mode_set(tp, inet_rsk(req)->ecn_ok ?
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 34e5c83bbace..f897c2594954 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -705,8 +705,12 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
 			*ptr++ = htonl(((e0b & 0xffffff) << 8) |
 				       TCPOPT_NOP);
 		}
-		if (tp)
+		if (tp) {
 			tp->accecn_minlen = 0;
+			tp->accecn_opt_tstamp = tp->tcp_mstamp;
+			if (tp->accecn_opt_demand)
+				tp->accecn_opt_demand--;
+		}
 	}
 
 	if (unlikely(OPTION_SACK_ADVERTISE & options)) {
@@ -1149,11 +1153,16 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 		opts->num_sack_blocks = 0;
 	}
 
-	if (tcp_ecn_mode_accecn(tp) &&
-	    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option)) {
-		opts->use_synack_ecn_bytes = 0;
-		size += tcp_options_fit_accecn(opts, tp->accecn_minlen,
-					       MAX_TCP_OPTION_SPACE - size);
+	if (tcp_ecn_mode_accecn(tp)) {
+		int ecn_opt = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option);
+
+		if (ecn_opt &&
+		    (ecn_opt >= TCP_ACCECN_OPTION_FULL || tp->accecn_opt_demand ||
+		     tcp_accecn_option_beacon_check(sk))) {
+			opts->use_synack_ecn_bytes = 0;
+			size += tcp_options_fit_accecn(opts, tp->accecn_minlen,
+						       MAX_TCP_OPTION_SPACE - size);
+		}
 	}
 
 	if (unlikely(BPF_SOCK_OPS_TEST_FLAG(tp,
@@ -2863,6 +2872,11 @@ static bool tcp_write_xmit(struct sock *sk, unsigned int mss_now, int nonagle,
 	sent_pkts = 0;
 
 	tcp_mstamp_refresh(tp);
+
+	/* AccECN option beacon depends on mstamp, it may change mss */
+	if (tcp_ecn_mode_accecn(tp) && tcp_accecn_option_beacon_check(sk))
+		mss_now = tcp_current_mss(sk);
+
 	if (!push_one) {
 		/* Do MTU probing. */
 		result = tcp_mtu_probe(sk);
-- 
2.34.1


