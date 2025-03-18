Return-Path: <linux-kselftest+bounces-29301-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB63A663DA
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 01:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB1B74208EF
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 00:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2139183CCA;
	Tue, 18 Mar 2025 00:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Jd2enOf2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011016.outbound.protection.outlook.com [52.101.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA82F155753;
	Tue, 18 Mar 2025 00:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742257689; cv=fail; b=uMFPM7iehOESo6LHuVo221y7ipYBdi2jn4D8bz3QvX+bWYeZ+kDVItoQjYQHjO02npoPol75dGEDkPvJZwBhQgKAdX6AUlbtrFAjuShHx2AVsuQr1DvziPj4SetQ2NdhexDnI4ZlFSBVDmBohpeYwn0jpgOhEpTJBi2YivOmulA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742257689; c=relaxed/simple;
	bh=tKsZlajXLpAOIbyJ8qGKdzctObD1YPtdFcgDVM+hUHU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gZ/hGrfulgVrWfiDfDkJ8OAEacVHlzzI8Mi1s8LZbQGtWUKbIyYsK67p6bRuvizx5jUzacW+UdVZqeiFFdUbhjHvxp30QKSmgUaUUb94lTEJ21gS4hPLe+mEHiQOr/OZRAyfMxc+iVdtAdK67J0BWcdGCzmnVsmgo+gysvv7yS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Jd2enOf2; arc=fail smtp.client-ip=52.101.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZNIJSeDGbCq8sVWz5b1aqht6jIpmQHo6I1DS8G2gxgITgk4moai6OCoteEicujF2x6a/LUs7sSnUctaiZhQVDU2DA2wh5txLHL/moRUDhlT5rbWfZ5ugmV2w4H91nN9PEoXrxAMs4UOho1B8MrOV3dr+ViaOiGwBb9lf8va5h2mCfi9cc9GkgKxK8oZ1aUV82PfU2DyC4AHc3YeABVmvcDO167hFfvienZgXt/1eiuRdBdg1dkdDpNnKJAQ62pj5h+V5yRu1zHCi93SV96kcTo6rtHPBiRwHG6RUM99BUsI3UVSxuNNAe+eh883HRdtD4ofKcAWF08viTkaR8EtN/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LphzWS9GjpX6oHrIgVfxf1jJOgRAdXuN7feHQH5h6s4=;
 b=GTk5YGTM9uzBCAgrDVygV9qxnAD80UPqemVCsehFs9lBQ0WoukExW7GiYkmQtelInbPmW31H2+xWuQ+EivuE0KjysScKDn85NW1TzcZ76ru0r207F3qM/9KzNxom6b8biqB2ifT+D2MeVfv8Cb/sJH8nMTo9AiVAaciw3yenfaZv17oU8GLywY1SzmRHJuhFRUQWlem8ACMHd/EvzyErDnbvvIks782H5ibYddCWTJ7U8GAJ/Q1wJQBASrDS6GfavT6rM7z5HTVsaXr5hjXeJteXaEvxzeFUaC5nUL0Dze8gcZC1UPfBDc3qX0kW4rZ/so9MlgmXm7F8A2ldK34D2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LphzWS9GjpX6oHrIgVfxf1jJOgRAdXuN7feHQH5h6s4=;
 b=Jd2enOf2Ryf4CA8Nh+KSQ8MTy8b1I9oz1dF36Ug0CKEItIzf6JwTsGTcfNfsIwi+OG9UXzmOHEKerbtejWMDAbR9kHJ10ao8SY/YjwaKw+A9/Yj2jPYr3YVElPTHmXThQD0rm1WJP9FwnuDQ3c4TdJnFbNgbvX6I+uzPerDCIb+6yeG6WrIYlJsTA98mq4Lz50tofJJplFHOk3Whmk8krBRQ9LiueaMNCcAxOr+UfcMTgR/FJ4/mkJBq9aBjVdo55gLwoMig4rhBXsbIsCjAA9byoof9hFvIjhJDUXVbswT/JkAhUnsk0siBmn8guf4I08UW8MBV1u25ZIdaX5rctw==
Received: from DB7PR02CA0011.eurprd02.prod.outlook.com (2603:10a6:10:52::24)
 by AM0PR07MB6305.eurprd07.prod.outlook.com (2603:10a6:20b:15f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 00:28:04 +0000
Received: from DB1PEPF00039230.eurprd03.prod.outlook.com
 (2603:10a6:10:52:cafe::89) by DB7PR02CA0011.outlook.office365.com
 (2603:10a6:10:52::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Tue,
 18 Mar 2025 00:28:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DB1PEPF00039230.mail.protection.outlook.com (10.167.8.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 18 Mar 2025 00:28:04 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 52I0RNBu024935;
	Tue, 18 Mar 2025 00:28:11 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, dave.taht@gmail.com, pabeni@redhat.com,
        jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
        edumazet@google.com, horms@kernel.org, andrew+netdev@lunn.ch,
        donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
        shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
        ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
        g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
        mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
        Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v2 net-next 14/15] tcp: try to avoid safer when ACKs are thinned
Date: Tue, 18 Mar 2025 01:27:09 +0100
Message-Id: <20250318002710.29483-15-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318002710.29483-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250318002710.29483-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF00039230:EE_|AM0PR07MB6305:EE_
X-MS-Office365-Filtering-Correlation-Id: 428cefdd-286a-4600-1806-08dd65b3bf64
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?T1hQc3I4WnhQZVZDUkFMY2I0WXg3VjFHZURNbVFuR1owb1pNK0JNQk5YbnJJ?=
 =?utf-8?B?bWo2eU9nbjF3MmhvaEdMWjNyTFZ1MDdFM29BaHhTdnlzV2dxWi9mMFZIcDRl?=
 =?utf-8?B?THVSSTE2cU5JSllSY1VSbVN5VEtWZkJhM2MvMjJMZVJKRktWZ0craEY5NFZs?=
 =?utf-8?B?ZUtWZDllS3lJTlJRd3dFMjBjRFBVSkt0MFkrbFJyalpFWmE0QkxsaFpVTThI?=
 =?utf-8?B?cGtQZ2pMWFIrckpDb3RBWXpab3kzWlc1RWxsVXd5bW9WdWl2S0tmUW9lZFFk?=
 =?utf-8?B?WlRCc2tEZlUrMmRGNW5SVEk0TmtNVC93RktjNXRmV3RTLzl3R0ExeGYxdjlO?=
 =?utf-8?B?cDI4UXBXaVY3M2xadWRmcUNVS1NDS1NGelJRVG9OTitQRE5RZ3NvcndzMDNK?=
 =?utf-8?B?L0RxbEcwbzRBNVRwbkN4SXgvb3FsRW5VNytrcWozWDNRWWUyaGpieXRVYTho?=
 =?utf-8?B?V2JPc2J6VHJIY2t1RzJDSHQvSzhJNXBGUUJ1L0hSb0dEUGVEZWdzeWRPdTkx?=
 =?utf-8?B?bmRwa0YxZDNQTjljL09PS1hqeHZZeFV4UWxocHF4UTVhSG5nbDJPSnNCMGxk?=
 =?utf-8?B?ajdaaG1rQ1lENzZBMzVtanBTb3ZERnlBMXNjY2hvVjJBSG5jOGhxa1o4TFp4?=
 =?utf-8?B?aS9sbm4rcXJXQ25yTGZwRjA2cHh3TG8rbU1ZQitGTGlmYlJvQnFJbklrcHR4?=
 =?utf-8?B?WUZWY3FJY2ZzamlZN3o4bFdlVGZKVEtOTjVtRVg1NUE1TkxZbXk1TUxreE5H?=
 =?utf-8?B?aSsxMHRUazcwWjVmQUZwa0ovVnk1aW83ZUsycGtLNEZOVmlXUTF3aXZXUnJ5?=
 =?utf-8?B?VHBFdDllTytTeUVNNlN4eUdNa3pxN2VtSk1zUG16c29NQmtrazQ4QU1ZSXlx?=
 =?utf-8?B?U1lEZnBlRml3dzI4Nk1EOEljNFlYeEhhMGFoRWtXbHlLQkd1K2JueitFZ3Mv?=
 =?utf-8?B?ZkR1ZVdicnc5V1lZMjE1N1dRV2NLOG9uQ0ZIUm9NWnprZFVhV0p2UU1idmMz?=
 =?utf-8?B?ZXptTTNMMkh2OFZrb2ZFZkcxdHppY1NJb2ZrSmp5TDdnbmdlR2trZGhjTWZj?=
 =?utf-8?B?bkIxKzV6REhhTjAzWjBqK2lVajh5MHM4dEVHQjdKQ3NZWFFKbVJXRmQ5eWxX?=
 =?utf-8?B?am5oa1pPNG5QMlBrcis5OHNFRCtMdVRLNzVYdHdFOXo2MmFEdXpqMDR5NVRm?=
 =?utf-8?B?UUlJTGlVdmxuOWNmcVpORG9VdlZCQW1EY0Y5aWF0WlFTQ24rZWsrWUVNeGZZ?=
 =?utf-8?B?SkxyQWU1ZmZOZjBsMUFzdlMvUkwrcXltbjA5RXMwRy82WHk4YVQxUmlVTmo1?=
 =?utf-8?B?Y1M4TERaY3VxQ2k4Y1RqWlp5RzhBRzhOZ3lXeHBZMi9oVzFGRG53ZmV3RXBT?=
 =?utf-8?B?ak9wZ2VqK3pDMzR2Y0lBRFNwR25ySE5FQm9UQmM5YjdOemUzMmdmemNwcUEr?=
 =?utf-8?B?aDNFRjZRa1NGdDRtMk93RXFWeDY5c1NLRG12bUVzT0g1ZHo2RTREdXdHYnND?=
 =?utf-8?B?Rm9GblhVcTdtRFpBRDJ1cllURVJNTmdzTmR6ZkFveFlQZ2VsWDVkREFJUC8r?=
 =?utf-8?B?aFNGOUVqL3hFY285NUZEZ1kvTFBqbHE4TzVtZHZYaVdmUEpXYmdRNHphVDA0?=
 =?utf-8?B?TDNFSWY2UjM2OWNVVHNKdWxNaEFGbzVzWnJFTlNsbTlxaUw5VmM2Z1ZYQ2tw?=
 =?utf-8?B?d3pCb0YzQ29ZcS9CN2s5ZUVOOGIzTGl1YWRDV3UzdDUzUU1haVpwcUlON3Vp?=
 =?utf-8?B?YnlGUnU1RnFmcXU1NHdrYUM0VjA4ZGZkblBqSlc1d3NWV2pnckg5RlM3TXly?=
 =?utf-8?B?a2o5djgwK2ZOeUlmOHpaSWwrMlAyWFVUSFBmQnlzdjd0R2lqMWVNWGRaRmZI?=
 =?utf-8?B?cnJidlhYcHRLeVBDRHZIZWZUQTJKN2VjNGRCRlViMEMwUEZ6dGYweUxNbHE0?=
 =?utf-8?B?WkRoRUlkc3BCMmNFQTVzajZzUFd2MkVpUFoxdCtwU0lyYkpNeHNxcWFoMnRM?=
 =?utf-8?B?Q0o2bW1WUW9DUEptOW9sb1pDbkcwclBOa3pXK29RUmEySldTQVhLbDdBdHZV?=
 =?utf-8?Q?3Hqqix?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 00:28:04.0101
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 428cefdd-286a-4600-1806-08dd65b3bf64
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF00039230.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB6305

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
index ccb5918c8b41..06c0ff87ad4a 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -310,6 +310,7 @@ struct tcp_sock {
 		prev_ecnfield:2,/* ECN bits from the previous segment */
 		accecn_opt_demand:2,/* Demand AccECN option for n next ACKs */
 		est_ecnfield:2;/* ECN field for AccECN delivered estimates */
+	u16	pkts_acked_ewma;/* Pkts acked EWMA for AccECN cep heuristic */
 	u64	accecn_opt_tstamp;	/* Last AccECN option sent timestamp */
 	u32	app_limited;	/* limited until "delivered" reaches this val */
 	u32	rcv_wnd;	/* Current receiver window		*/
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index c4eadf6dd6fb..01532c2b6acd 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3369,6 +3369,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tcp_accecn_init_counters(tp);
 	tp->prev_ecnfield = 0;
 	tp->accecn_opt_tstamp = 0;
+	tp->pkts_acked_ewma = 0;
 	if (icsk->icsk_ca_initialized && icsk->icsk_ca_ops->release)
 		icsk->icsk_ca_ops->release(sk);
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
@@ -5080,6 +5081,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered_ecn_bytes);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ce);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ecn_bytes);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, pkts_acked_ewma);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, accecn_opt_tstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, app_limited);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_wnd);
@@ -5088,7 +5090,7 @@ static void __init tcp_struct_check(void)
 	/* 32bit arches with 8byte alignment on u64 fields might need padding
 	 * before tcp_clock_cache.
 	 */
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 130 + 6);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 132 + 4);
 
 	/* RX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_received);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 5c71135b43f7..cbcb3a2d4786 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -690,6 +690,10 @@ static void tcp_count_delivered(struct tcp_sock *tp, u32 delivered,
 		tcp_count_delivered_ce(tp, delivered);
 }
 
+#define PKTS_ACKED_WEIGHT	6
+#define PKTS_ACKED_PREC		6
+#define ACK_COMP_THRESH		4
+
 /* Returns the ECN CE delta */
 static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 				u32 delivered_pkts, u32 delivered_bytes,
@@ -709,6 +713,19 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
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
@@ -757,7 +774,8 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
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


