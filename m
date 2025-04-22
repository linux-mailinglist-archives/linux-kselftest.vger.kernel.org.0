Return-Path: <linux-kselftest+bounces-31323-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA3EA9715F
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 17:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE0654023EE
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 15:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F154293B68;
	Tue, 22 Apr 2025 15:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="UXFWk6py"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A50290083;
	Tue, 22 Apr 2025 15:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745336334; cv=fail; b=dwwZzsGjP2doQbQ2/kO7UXWeOQxnwkQbTxcevmnhHIuWEWJKxxTGsDVyHJnl2phxPpLJfrKuev1Rt2OoRGxq0jP3sDCgScxpMGTFtz2UKspLc3M0eKBBgpAuAa0g3wjXz31TdH2aNq9uH8Z4EaZIs+eKzSwxeDu4k4sXKtiTHgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745336334; c=relaxed/simple;
	bh=HIn8G1yBpVREn6OITPp7X55qHEbrtK9EhzO++ygwBcA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y70MEIQYeGleiVr0Bb5brDIPIv/r87TqmG36z03S6xD6XFsgS01c0o1p+DAwXGOinv+8g/1r88Sjqo9f7crri93qlUpln2D6CJ6IhmF+Rupon6AmJ973MSpwjFxUOFs3GNaXQPmXBFziIDEDCgWL6On4bcuuWiL3MYdZGS4UPdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=UXFWk6py; arc=fail smtp.client-ip=40.107.21.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ELauS1+uWO1HLyzX5UckOVIc++e1K7FgmZzm+dVTDWgTqc6qhFZs67rj8YsLzn6lOw7NxDz3Enb0n0oonsBatiSsBzKT3EvaQvXb6ItOeMoIHHtmZX0gkKxgmpiyYFBI5IM4E68Ym8P+kzaLwQ2kXXt9BFYoBRUj8ltEQyNmoBQWiTP2/4CRdmO7d26/45vy/iBy4c5B99cR2sz8rk6STz1wKhDDO5pGqTywks382U2rBUPu/koy7UGX5lDW2tL48UAgGGKPV18+BPxoOX03XZUlPatLicHMx99EU2jDkV2v8yNorypJGH64yIRSujJqULVmDaYO6f1s9ECu6vNNAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PhTu7w+WIf5a4gUEaAsq3xfJl9ayY+K2t1R0OM1MZsI=;
 b=Qf2eXn2nEeyRkvyWhzZpiUGffFmMaK/keZhEU+1Ii4Rqc59Jhmfqn72Ucs3jbqCdDvEasIDhXntbtiI2oK8MYdf4n1VmUAJqIkn0z/uwIwhGWHR1JbOANXl1YUuZdH2Axd7aP2LRl7M5YRGFenXozvZKESbNPYi13+KuE/Vk0DGKeBQKWPJCUQAxSwQ6x2oIf6VeTcXsiY89AOGj4KsOkE1RD54QavdG+I5eUAiVD6Mqzu/ElM6uuVKMEfkYpgV2uD+MQ5BqVT2aJcpVfxZHgV3xZx7BKb0k+M8qGLcsdnW6HZG9JkJOsWB0rzomUkZuHrPR05lTWURJEUG0Euu+yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.2.29) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhTu7w+WIf5a4gUEaAsq3xfJl9ayY+K2t1R0OM1MZsI=;
 b=UXFWk6pysMVS6saHQXFoUazQfZFmQCTRmDSpR0URUrEnl2lZPbxPIv4J6uIzAPVMGlMZNSAtx9uoE33dYRGcZsECAyi4onKmgCbNXwegh7hFv7lQM0xIt60RhWYzI0PyKMigHQzQT7eDEpCv8Eb3fNPXcUQhvib88STyASgtxqm2PlN6wKo0tus4CpiY3Eq3y0rUoEQFXpkhEuZu4FHbxEyKQIiChrbcN0f0upMOuiMOP404CzZMMNznIkTb36CwNk2NyeANqtdRQo9MtgZBH1/3IRUk/y7gPXbyHXgleT5RZ9IDW4CRq2zsqkcpK92jd1kSkwcFKc5irTzOG9HgNw==
Received: from AM0PR10CA0071.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::24)
 by VI1PR07MB9708.eurprd07.prod.outlook.com (2603:10a6:800:1df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 15:38:48 +0000
Received: from AMS0EPF00000199.eurprd05.prod.outlook.com
 (2603:10a6:208:15:cafe::7) by AM0PR10CA0071.outlook.office365.com
 (2603:10a6:208:15::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Tue,
 22 Apr 2025 15:38:48 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.2.29) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.29) by
 AMS0EPF00000199.mail.protection.outlook.com (10.167.16.245) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12
 via Frontend Transport; Tue, 22 Apr 2025 15:38:47 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 9CA0620A0C;
	Tue, 22 Apr 2025 18:38:45 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: horms@kernel.org,
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
Subject: [PATCH v5 net-next 15/15] tcp: try to avoid safer when ACKs are thinned
Date: Tue, 22 Apr 2025 17:36:02 +0200
Message-Id: <20250422153602.54787-16-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250422153602.54787-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250422153602.54787-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000199:EE_|VI1PR07MB9708:EE_
X-MS-Office365-Filtering-Correlation-Id: 135bd829-47e9-4b58-d1fa-08dd81b3c598
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?TVFkQlNlaCtBUitScDBLVXYrU3Q4OXJKWmZRMDcrSTVxbUN0TDF1SnJFbldt?=
 =?utf-8?B?UVl3ejAwRkZGNnRVemJ2NFY1N05MM3ZaN3g2VFZlUGY5aWJ3b29GV2ozTFVM?=
 =?utf-8?B?bHBOek9MdlJZY0VVUUZZYWVLMVptZnk2MXJBc1BTZ1ZwQWEvK1hueFRuSVY3?=
 =?utf-8?B?S2gweW9Cb21iU2R5VXFnYTRYV01JUGljWjZRbDFvU2tLUjVxNTkxVjVsQUxV?=
 =?utf-8?B?RHZSMk0wTTVhdFZra0FOQkdtb20xaE5rT2JOK3pHTkRITHFkWVJHR1hROVp1?=
 =?utf-8?B?NnN0dmh2TElOUGFEZGh2Mlo3bHJuNmREK1QwUW5NcFB2VFZmYmFVZTNqWnJT?=
 =?utf-8?B?T3dDdEpUOHd5WVpuZ0dWd0F4dFdndkdwMlAwVVd6Tm01QmE1WWFITE5HaVJX?=
 =?utf-8?B?MFkrUlBweWRCUlBLRHpvYXJ2Q3YyMHZKcm9tYmNHYmgvZWlDOVpoSW00elVL?=
 =?utf-8?B?M2EydFNmSGNwYUptYXpuRDllWWhYUjNhNkRDU2FSSUxUakdlekFxZW01QkxZ?=
 =?utf-8?B?Y1ZPNGREL1NSTlhkcVZ1S2ZLTnRvVHI2SkZxYlg0TjhhSTRsaHZnVnhrTlBa?=
 =?utf-8?B?Z1BYcHdKWjFFeS9LTG0ybU0rSjJGa0E3NjZOMzg4MlRTVDlpZTkrMGdMdnVP?=
 =?utf-8?B?WVRDVlVoNHpNZG5tUENoVmZJWVVwUnNBRzdwblBuMGJQL2dFVEZuWHpQY0FL?=
 =?utf-8?B?VlFhZEtWdHNSUnA3VGVFMDRhLzErOUNqNk5iNW1zRXNheUlmdVNGb0pWUG9h?=
 =?utf-8?B?OWMzTTMvQWhkcWZQUUd1YUtZUkxhakluZjFvSVJ0eWxIejZUSWFjWWZSVmU0?=
 =?utf-8?B?L1VxV0M0bG5zMjh3aEJtakxOYlM5d1FRcFVYYlQ5dDRkQlAyUENqYzFUcWF6?=
 =?utf-8?B?d08rL21RWjZlNGhXRkY3cUFYdktBTTRNcTBnKy9GTVFMS2lWM3JGNGUvOURR?=
 =?utf-8?B?VHNqc1FHSDBOcjFrNGprVklRYVZmQWZEYmVEOVVseVZ4WE90Z3BtU2IxbndL?=
 =?utf-8?B?YzRER3ZqU3p3K3ljRE1hWjRWWUxaN3JzekRXRFlqTWRqbG9hMDVQS080L1R0?=
 =?utf-8?B?SnZkOGdaV2pLdUIzdlFMRWxEVzJ1Q1FCZUZMeG94SzdXbmd2VDhteHZkTWRz?=
 =?utf-8?B?N2JiY1U1VWlyNUsrRSszODBTUzFCeFdaY3U3dXdWeXpxcW1jMVNaZytVYk1E?=
 =?utf-8?B?NnZmTllJR3pHeFlGalo2M2xQOFhmNzArRUh6ZUZWbjhvY1NIYjdYbkk4Vmpq?=
 =?utf-8?B?cDVIZE5ULy95WE9BV0Y2R0VBUkZxaXM1MDRhajNCOUIwTXdIazE2elZlZWQz?=
 =?utf-8?B?TUtHOXRIRjlmbTNPZ29aUWhnSGNrMXcwQndoejlubitoZ3ZMMFE5elBPNDZv?=
 =?utf-8?B?K0x6d2o2dFBzR0YyWFlUUE9KSnI4NUhacjNDVHFibzR5R1E3cW0zV0tvSTFB?=
 =?utf-8?B?eEMyUE1UcG1qNitSYjlvdVRtOG84ak5CZWpOeTkrOEZ0TktMYkNvQzZTSlRk?=
 =?utf-8?B?MmlrK28rTXIyQk5mdUc2bjBvZUhnNDJtdjQyT0o4QkRYWXZtckQvWjlUZXlF?=
 =?utf-8?B?N3JxY1IvWHhmWHhRYWRkS25ueEFkLzlSM1k0K2xiMVo5U3dIenlIOXd5Mk5F?=
 =?utf-8?B?OUNHQmtHZDF5SDdlWkxBak1iVVRrdjdVczhJS1RnaW9Rdi9lbTVjbVNPaWlQ?=
 =?utf-8?B?V3grYjY1SVVoZHlUL3F5MzNicC9keFlHaXk0S2cxVFFMeE84TUhCdUIyd0tN?=
 =?utf-8?B?R0tiYUQxWldBS05zUmE5cVBMdDd2cHlmWkRNWGpqQTYrZnpoMTFKek5yajcx?=
 =?utf-8?B?L0U2UFRWQWg0WHNFTEdoeEdYeVJ2NHYzMmNIbHhuL2dCZVlGblBzMWtpVzBL?=
 =?utf-8?B?bDdUQjY5SmxDclZaZmFmYUtBTlM1NmtOSU82R2VkVDhBSWc3V25IQ1JJcHVi?=
 =?utf-8?B?aHB6MXcxTlJ1S1J4bzkwU1l6dGVvSzhuK01NUUJlQVQ3MWF2dDVLVnFra2g4?=
 =?utf-8?B?K2pqN0xyVElrUTBTQ2poYkdudGFuQUhpZlMwY1haSldHcEp5TzdQWWpiN3hu?=
 =?utf-8?B?RUVsclNNYnNHbUpzUElLWmhQRXFsYy8zMW54Zz09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.29;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 15:38:47.0109
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 135bd829-47e9-4b58-d1fa-08dd81b3c598
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.29];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000199.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB9708

From: Ilpo Järvinen <ij@kernel.org>

Add newly acked pkts EWMA. When ACK thinning occurs, select
between safer and unsafe cep delta in AccECN processing based
on it. If the packets ACKed per ACK tends to be large, don't
conservatively assume ACE field overflow.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/linux/tcp.h  |  1 +
 net/ipv4/tcp.c       |  4 +++-
 net/ipv4/tcp_input.c | 20 +++++++++++++++++++-
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index b93bf1785008..99ca0b8435c8 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -315,6 +315,7 @@ struct tcp_sock {
 		est_ecnfield:2;/* ECN field for AccECN delivered estimates */
 	u32	app_limited;	/* limited until "delivered" reaches this val */
 	u64	accecn_opt_tstamp;	/* Last AccECN option sent timestamp */
+	u16	pkts_acked_ewma;/* Pkts acked EWMA for AccECN cep heuristic */
 	u32	rcv_wnd;	/* Current receiver window		*/
 /*
  *      Options received (usually on last packet, some only on SYN packets).
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 03c205eaabe5..7af22c4615e6 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3371,6 +3371,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tcp_accecn_init_counters(tp);
 	tp->prev_ecnfield = 0;
 	tp->accecn_opt_tstamp = 0;
+	tp->pkts_acked_ewma = 0;
 	if (icsk->icsk_ca_initialized && icsk->icsk_ca_ops->release)
 		icsk->icsk_ca_ops->release(sk);
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
@@ -5111,13 +5112,14 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ecn_bytes);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, app_limited);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, accecn_opt_tstamp);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, pkts_acked_ewma);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_wnd);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rx_opt);
 
 	/* 32bit arches with 8byte alignment on u64 fields might need padding
 	 * before tcp_clock_cache.
 	 */
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 130 + 6);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 132 + 8);
 
 	/* RX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_received);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index c6dac3c2d47a..5bdd82d3c201 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -689,6 +689,10 @@ static void tcp_count_delivered(struct tcp_sock *tp, u32 delivered,
 		tcp_count_delivered_ce(tp, delivered);
 }
 
+#define PKTS_ACKED_WEIGHT	6
+#define PKTS_ACKED_PREC		6
+#define ACK_COMP_THRESH		4
+
 /* Returns the ECN CE delta */
 static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 				u32 delivered_pkts, u32 delivered_bytes,
@@ -708,6 +712,19 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 	opt_deltas_valid = tcp_accecn_process_option(tp, skb,
 						     delivered_bytes, flag);
 
+	if (delivered_pkts) {
+		if (!tp->pkts_acked_ewma) {
+			tp->pkts_acked_ewma = delivered_pkts << PKTS_ACKED_PREC;
+		} else {
+			u32 ewma = tp->pkts_acked_ewma;
+
+			ewma = (((ewma << PKTS_ACKED_WEIGHT) - ewma) +
+				(delivered_pkts << PKTS_ACKED_PREC)) >>
+				PKTS_ACKED_WEIGHT;
+			tp->pkts_acked_ewma = min_t(u32, ewma, 0xFFFFU);
+		}
+	}
+
 	if (!(flag & FLAG_SLOWPATH)) {
 		/* AccECN counter might overflow on large ACKs */
 		if (delivered_pkts <= TCP_ACCECN_CEP_ACE_MASK)
@@ -756,7 +773,8 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 		if (d_ceb <
 		    safe_delta * tp->mss_cache >> TCP_ACCECN_SAFETY_SHIFT)
 			return delta;
-	}
+	} else if (tp->pkts_acked_ewma > (ACK_COMP_THRESH << PKTS_ACKED_PREC))
+		return delta;
 
 	return safe_delta;
 }
-- 
2.34.1


