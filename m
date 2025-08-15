Return-Path: <linux-kselftest+bounces-39075-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D261FB27B74
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 10:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 191185E6954
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 08:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EC72D29C4;
	Fri, 15 Aug 2025 08:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="FDsSjJkw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012017.outbound.protection.outlook.com [52.101.66.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13EF2D12EA;
	Fri, 15 Aug 2025 08:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755247200; cv=fail; b=ML2PRvCN0sRqPncdhpmWyUBV3zDrUdTvRJVZ/MHpXLcWkudBjMUdFi3fExKYtLb5fv+EIr3JBfWsVlrdrnEB8L/+C+j8Y/bftZjIgXZApKlZkl3vK/U0KSHL/N7RuDTMws3Qh+zZ/Dy4FWMgDySyxmf0r0U4dtCuUfnSWp3h9fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755247200; c=relaxed/simple;
	bh=62301mOncGlMuUYT0U1Q38hrZNHW8sXQYl34pFk7k4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GGfCWCWMm+OAATTASoqRSO58G7m9thMnZVqy+UrmidAVKxcj65V7ui/n2rWE+7wtmtk87mWWhpRT5GLop553BRfg3ndW8NbaXV4RpTQBh+JT33d7VLruNEtfmw91g26eDuml2OVIF31Hz1Yv6sIDH9QX5s+4k65fFupiGTCRX0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=FDsSjJkw; arc=fail smtp.client-ip=52.101.66.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=unKgWuESsm/c7JPREWPdjB2EkvIcqko9AH60g3nrHAF7x1MDYk8bTbkcMqtZD4zTHC/hncjB10sD6AZun9IZJIHFBw5WSSUlzT+TT+QMVBoyjSafMTAXVjZ448MlMcdxpOAYqEiEMn6Bo0UpGFlWuvgqIsdZKcmVTDmjShTuL6WVMR424WQOpXN/sW3taJRVUYwCJOtyFGmCz974ew6HTvIgnwElg1be4kKLEuICT3YNsdFcUuSep1EkYx0zUeapmRDaB7nKswJsuezw+k+t42gVXqLWx55kmdzxAbZq1KF9YoOFQLsz8+rJBKWDT6KLeuUTvqMvDo6ue8ClLB3Zjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=icFMyR7NncECn0rdWOlAKockqTPXHBGT5Wbymt2KPPk=;
 b=lJiINC+Mk+YFHMgq/wg0j/AM8GI1spk3VjqXtcwrHLBneQn/CFIOTh41DPAWYard/UeYYGPx410mrThbrORAwL7pTNxQQvc2vs/ksyPLJz70DcAkj8d6tbvEqEWaVB/9iUWacHn9y/Ve4hS0Av7HhtSjEfvZyWdMFcZiJXmpUOyOwY3QotWaHvwllEFSrMSq+2mnAb3GqGFvXvpM7nHMIAtZGHT5wuBMrq+W8EAJiPRsmcO2wF6DbpRVysRJrzr8azubOwuDUzaOXmSoLLQXnrORlVb2ohkRLyHtNiFpEkG1DnGp8Fc17+uog7QMpdHFpV/gRunQ/faYwiR9s6BkWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icFMyR7NncECn0rdWOlAKockqTPXHBGT5Wbymt2KPPk=;
 b=FDsSjJkwlqqmvYCcr80P5MLdygcRlIHx5yFjPAP7tBGL1j5f3UoL/lJRimwfXP4l7EZEvbvQ7OgEbWchIh5/SzlfqhlQlLNrXpbJ916fGWYwViE/H9LZP14+OPW5gYnwN9MeQTyq8eegrzCHAEwfzx+cWSWTJ7PlE8UvNTG4XJhTw9RYMK6nZajl8CBUutbYNVwuphBMqW8UizKwPo8p9U+F2VOsHD7zxdxpOi4Bd86zdNAFhCCV8t0UH830wIGAR4PH2kdRu8wqUUjc4wFZhYp6YEMTB8el2/cfBXYQP1+FV6GxfYcgGrZdy0Zqkb3Jys8cGhWLz4ARl4sFfVv9mQ==
Received: from AM0PR06CA0123.eurprd06.prod.outlook.com (2603:10a6:208:ab::28)
 by VI1PR07MB6271.eurprd07.prod.outlook.com (2603:10a6:800:133::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 08:39:53 +0000
Received: from AM4PEPF00027A61.eurprd04.prod.outlook.com (2603:10a6:208:ab::4)
 by AM0PR06CA0123.outlook.office365.com (2603:10a6:208:ab::28) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18
 via Frontend Transport; Fri, 15 Aug 2025 08:39:53 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.6.101) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM4PEPF00027A61.mail.protection.outlook.com (10.167.16.70) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.11
 via Frontend Transport; Fri, 15 Aug 2025 08:39:51 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 37A321C002B;
	Fri, 15 Aug 2025 11:39:50 +0300 (EEST)
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
Subject: [PATCH v15 net-next 07/14] tcp: accecn: add AccECN rx byte counters
Date: Fri, 15 Aug 2025 10:39:23 +0200
Message-Id: <20250815083930.10547-8-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250815083930.10547-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250815083930.10547-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A61:EE_|VI1PR07MB6271:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b590a5a-2820-445b-172f-08dddbd74d57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1JBdGg4TjR3K2hTNk93Vm4zY0I1SUtrOU1XZUxVOG1aelFUNUVOaVV3VGU0?=
 =?utf-8?B?QnBaK0l1Y1BNYWhIcmJHOTVJMjJRY3hzSVdWNFBBbmtHeXVwV0RtdnllZXF4?=
 =?utf-8?B?NzNoWlU2K3ZjTzJ0Zzl5eUVRZFUwcC9td241ekZmazRiMFlxOStTanR5andV?=
 =?utf-8?B?YmtvMDdQSkpkdjh2MHdSalRXVkpMNzJGMnhOUlBldkFIRmpsZ21RbkZsTG9I?=
 =?utf-8?B?VDd1OEFub3lGTW52UnY2QlU5YjU2UDZ5MStXbGRmVTlVbURjdUhoY0ZKVStS?=
 =?utf-8?B?MjBYcHBqWWRheGdqMXhjMlNsK1VlUitJU251UnBnUXhPTDNFQ2F6MG9LcFgr?=
 =?utf-8?B?NlY0MFJZb3l0RWpWZ2lRbTRCVFhkRW9ydzIySEZ6OVdaMkplL2J1S25qVlRG?=
 =?utf-8?B?WU5JeWtuQkxOQldnR1U0aVFsT1JsdkE5R2c1MjhzNHpLTHBiSVE1RnQ5UzYz?=
 =?utf-8?B?R25lZXhXVGxhOTQzSjcxcERVeGxidE5IcU5ncENRdHVLQmpHZ0lZRnFGYUVJ?=
 =?utf-8?B?NUVIaVlYK0Rta3J0UzlzM3FZcnN2TFhKVmxKb25hc3pHeEdMVEZJTDI1a0ly?=
 =?utf-8?B?bmEzVGFFV2JZTk1pUitOYmlOcE1SalJkUkJ1RVV4MlVnZVNyRjJ4MVJtbGgz?=
 =?utf-8?B?T1JkQjVSVDBoNUwzSFNWSWJVSDFhRll6UTNJV3F0OUlhNzU2aDdzOXZKNkZx?=
 =?utf-8?B?ZU9Ncmp2a1pkM3l6dnYvSDlEb2lPbjZYQmlDSytTWWNvLzlSZDhrd2tqYk9T?=
 =?utf-8?B?a3YrK3YwdjdkUzlnUkpPQkhURGxXK1lEWkc2K1pVdnhiTitta01KYjI3OHdK?=
 =?utf-8?B?SlZNOVJrTG9tdzlkd3RPRGtDZnpKT3B1eDBLeTk0aXhobFRMVld4Z1haQ3FD?=
 =?utf-8?B?Z00rTTR1enZNczVUSXJyOEw0NE5SWThQV05hR2xscGN5MXgzSHZPMEtSOHY4?=
 =?utf-8?B?M3JTM0JTWUpsRFA3VmZpTTZZWC9vbUJoSGIxUk80Sit3aHFwQzc5b25KYUNB?=
 =?utf-8?B?UTZMa29na08wZlJzMEN3TG5CMTRBTVB4N2J1L2hQbnJ2RTh3M3M2U0xDWHpl?=
 =?utf-8?B?dkpIK3pXNlFzODRZd01XNEhRUUVMbTdvOGZsbFR2aTNySVFCTjAzN3ZITHVE?=
 =?utf-8?B?enkzaW5ZckpJbGp4TUg4ZEEvckl2Y25LeENRNWVQVGluanowTU1KcW5RT3Iv?=
 =?utf-8?B?UGtGUHM1Y0ZKQjJEamU0WDhoaVNaclJSb1k3TWdnWlJwMW45Qi85WFVZN01Y?=
 =?utf-8?B?VXRnSy81ZEU2Tm43bGpoNVR2VWhROHdtVGs5ZlBFTFVUc0I3RGRKaWFEQlJX?=
 =?utf-8?B?dVdrR3RDN0ZzdHdkcHJpL1dkSnR5SzZqVGtLZytwS3pNejVLc09OYm9Lcit5?=
 =?utf-8?B?L2dIQThSczhlSUhaUk5oUWlZU0h1WTVsdTlmR1lzWGhTVTVDblh2VXBrb2d1?=
 =?utf-8?B?bFdWUXoyKy9WZ0ZZTTdDVXhMWHhURVdGa29ra3VzaFlLYVptU29WNnVvNld0?=
 =?utf-8?B?eU42YWRtY2NFcStBaGVxT1JhVm01aXE4eUJzcHd5SlA2MVYydk5ZMnlBazRo?=
 =?utf-8?B?Z1ljelA5U0lDMk0vcE9WdGJMWk5iTTZWNGovUytBbnZXTDlXZkNvYUdzQzRL?=
 =?utf-8?B?SlUwb1h1bVp4NDNlbmRCU29qQ3NSdEdudHgxK2lId2k2RjdmVDdmRlhNTjNk?=
 =?utf-8?B?dmFVTnl5ay81ZGY2TTZDdkZIVHVKV01vZ0EyL1NFdjg1M0VDZ1NvYXFpR0xV?=
 =?utf-8?B?NmgvK0dlM01heS80UVA0MVJFNWxIZzhNcDRHZ3NTRC9OWEttQTVlOUt3ZDJJ?=
 =?utf-8?B?NmhuOW5qRjZZU2xhUmdqVm96clVYcm4xdzB4NmVLNVJSSU5haDBPWCt2d1lD?=
 =?utf-8?B?ZEFQN1pHVFpkanZOS2U5MFNxRzhUU0pML3B0dTA5YjhHQzZLZWdCdmpESEdP?=
 =?utf-8?B?aVFXbDNBbThpek1tRzBJYVlweVU2WmovMklGekJFVFpwLytDQXJMTHZhc1lB?=
 =?utf-8?B?eFZrR1YvVGl5ZzNpTTR6YlpaYVFJcHlxMmROUzJYZmZqSlJISzZvNTBnUnNm?=
 =?utf-8?B?UmlISjgyMDVnWCtXaWZhN1A4THduNVpQOStQZz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 08:39:51.7697
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b590a5a-2820-445b-172f-08dddbd74d57
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A61.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6271

From: Ilpo Järvinen <ij@kernel.org>

These three byte counters track IP ECN field payload byte sums for
all arriving (acceptable) packets for ECT0, ECT1, and CE. The
AccECN option (added by a later patch in the series) echoes these
counters back to sender side; therefore, it is placed within the
group of tcp_sock_write_txrx.

Below are the pahole outcomes before and after this patch, in which
the group size of tcp_sock_write_txrx is increased from 95 + 4 to
107 + 4 and an extra 4-byte hole is created but will be exploited
in later patches:

[BEFORE THIS PATCH]
struct tcp_sock {
    [...]
    u32                        delivered_ce;         /*  2576     4 */
    u32                        received_ce;          /*  2580     4 */
    u32                        app_limited;          /*  2584     4 */
    u32                        rcv_wnd;              /*  2588     4 */
    struct tcp_options_received rx_opt;              /*  2592    24 */
    __cacheline_group_end__tcp_sock_write_txrx[0];   /*  2616     0 */

    [...]
    /* size: 3200, cachelines: 50, members: 166 */
}

[AFTER THIS PATCH]
struct tcp_sock {
    [...]
    u32                        delivered_ce;         /*  2576     4 */
    u32                        received_ce;          /*  2580     4 */
    u32                        received_ecn_bytes[3];/*  2584    12 */
    u32                        app_limited;          /*  2596     4 */
    u32                        rcv_wnd;              /*  2600     4 */
    struct tcp_options_received rx_opt;              /*  2604    24 */
    __cacheline_group_end__tcp_sock_write_txrx[0];   /*  2628     0 */
    /* XXX 4 bytes hole, try to pack */

    [...]
    /* size: 3200, cachelines: 50, members: 167 */
}

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

---
v13:
- Move TCP_ACCECN_E1B_INIT_OFFSET, TCP_ACCECN_E0B_INIT_OFFSET, and
  TCP_ACCECN_CEB_INIT_OFFSET to latter patch

v8:
- Add new helper function tcp_ecn_received_counters_payload()
---
 .../networking/net_cachelines/tcp_sock.rst    |  1 +
 include/linux/tcp.h                           |  4 +++
 include/net/tcp_ecn.h                         | 29 ++++++++++++++++++-
 net/ipv4/tcp.c                                |  3 +-
 net/ipv4/tcp_input.c                          |  7 +++--
 net/ipv4/tcp_minisocks.c                      |  2 +-
 6 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index 4f71ece7c655..5a2b0af57364 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -102,6 +102,7 @@ u32                           prr_out                 read_mostly         read_m
 u32                           delivered               read_mostly         read_write          tcp_rate_skb_sent, tcp_newly_delivered(tx);tcp_ack, tcp_rate_gen, tcp_clean_rtx_queue (rx)
 u32                           delivered_ce            read_mostly         read_write          tcp_rate_skb_sent(tx);tcp_rate_gen(rx)
 u32                           received_ce             read_mostly         read_write
+u32[3]                        received_ecn_bytes      read_mostly         read_write
 u8:4                          received_ce_pending     read_mostly         read_write
 u8:2                          syn_ect_snt             write_mostly        read_write
 u8:2                          syn_ect_rcv             read_mostly         read_write
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index b8432bed546d..012d01347b3c 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -306,6 +306,10 @@ struct tcp_sock {
 	u32	delivered;	/* Total data packets delivered incl. rexmits */
 	u32	delivered_ce;	/* Like the above but only ECE marked packets */
 	u32	received_ce;	/* Like the above but for rcvd CE marked pkts */
+	u32	received_ecn_bytes[3]; /* received byte counters for three ECN
+					* types: INET_ECN_ECT_1, INET_ECN_ECT_0,
+					* and INET_ECN_CE
+					*/
 	u32	app_limited;	/* limited until "delivered" reaches this val */
 	u32	rcv_wnd;	/* Current receiver window		*/
 /*
diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index 1367d003abf2..97b2dd79c883 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -171,7 +171,7 @@ static inline void tcp_accecn_third_ack(struct sock *sk,
 
 /* Updates Accurate ECN received counters from the received IP ECN field */
 static inline void tcp_ecn_received_counters(struct sock *sk,
-					     const struct sk_buff *skb)
+					     const struct sk_buff *skb, u32 len)
 {
 	u8 ecnfield = TCP_SKB_CB(skb)->ip_dsfield & INET_ECN_MASK;
 	u8 is_ce = INET_ECN_is_ce(ecnfield);
@@ -191,9 +191,24 @@ static inline void tcp_ecn_received_counters(struct sock *sk,
 		tp->received_ce += pcount;
 		tp->received_ce_pending = min(tp->received_ce_pending + pcount,
 					      0xfU);
+
+		if (len > 0)
+			tp->received_ecn_bytes[ecnfield - 1] += len;
 	}
 }
 
+/* AccECN specification, 2.2: [...] A Data Receiver maintains four counters
+ * initialized at the start of	the half-connection. [...] These byte counters
+ * reflect only the TCP payload length, excluding TCP header and TCP options.
+ */
+static inline void tcp_ecn_received_counters_payload(struct sock *sk,
+						     const struct sk_buff *skb)
+{
+	const struct tcphdr *th = (const struct tcphdr *)skb->data;
+
+	tcp_ecn_received_counters(sk, skb, skb->len - th->doff * 4);
+}
+
 /* AccECN specification, 5.1: [...] a server can determine that it
  * negotiated AccECN as [...] if the ACK contains an ACE field with
  * the value 0b010 to 0b111 (decimal 2 to 7).
@@ -232,10 +247,22 @@ static inline bool tcp_accecn_syn_requested(const struct tcphdr *th)
 	return ace && ace != 0x3;
 }
 
+static inline void __tcp_accecn_init_bytes_counters(int *counter_array)
+{
+	BUILD_BUG_ON(INET_ECN_ECT_1 != 0x1);
+	BUILD_BUG_ON(INET_ECN_ECT_0 != 0x2);
+	BUILD_BUG_ON(INET_ECN_CE != 0x3);
+
+	counter_array[INET_ECN_ECT_1 - 1] = 0;
+	counter_array[INET_ECN_ECT_0 - 1] = 0;
+	counter_array[INET_ECN_CE - 1] = 0;
+}
+
 static inline void tcp_accecn_init_counters(struct tcp_sock *tp)
 {
 	tp->received_ce = 0;
 	tp->received_ce_pending = 0;
+	__tcp_accecn_init_bytes_counters(tp->received_ecn_bytes);
 }
 
 /* Used for make_synack to form the ACE flags */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index ed427a51853c..6255b2d4c6c5 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -5124,6 +5124,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered_ce);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ce);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ecn_bytes);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, app_limited);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_wnd);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rx_opt);
@@ -5131,7 +5132,7 @@ static void __init tcp_struct_check(void)
 	/* 32bit arches with 8byte alignment on u64 fields might need padding
 	 * before tcp_clock_cache.
 	 */
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 95 + 4);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 107 + 4);
 
 	/* RX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_received);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 41dc219730fe..c0d0289ce4d8 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6163,7 +6163,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 					flag |= __tcp_replace_ts_recent(tp,
 									delta);
 
-				tcp_ecn_received_counters(sk, skb);
+				tcp_ecn_received_counters(sk, skb, 0);
 
 				/* We know that such packets are checksummed
 				 * on entry.
@@ -6213,7 +6213,8 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 			/* Bulk data transfer: receiver */
 			tcp_cleanup_skb(skb);
 			__skb_pull(skb, tcp_header_len);
-			tcp_ecn_received_counters(sk, skb);
+			tcp_ecn_received_counters(sk, skb,
+						  len - tcp_header_len);
 			eaten = tcp_queue_rcv(sk, skb, &fragstolen);
 
 			tcp_event_data_recv(sk, skb);
@@ -6254,7 +6255,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 		return;
 
 step5:
-	tcp_ecn_received_counters(sk, skb);
+	tcp_ecn_received_counters_payload(sk, skb);
 
 	reason = tcp_ack(sk, skb, FLAG_SLOWPATH | FLAG_UPDATE_TS_RECENT);
 	if ((int)reason < 0) {
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 845b1c81b3b0..0a0ee33e38ad 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -473,7 +473,7 @@ static void tcp_ecn_openreq_child(struct sock *sk,
 		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		tp->syn_ect_snt = treq->syn_ect_snt;
 		tcp_accecn_third_ack(sk, skb, treq->syn_ect_snt);
-		tcp_ecn_received_counters(sk, skb);
+		tcp_ecn_received_counters_payload(sk, skb);
 	} else {
 		tcp_ecn_mode_set(tp, inet_rsk(req)->ecn_ok ?
 				     TCP_ECN_MODE_RFC3168 :
-- 
2.34.1


