Return-Path: <linux-kselftest+bounces-43016-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0789DBD578F
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 19:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4F41423AF7
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 17:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15307303A00;
	Mon, 13 Oct 2025 17:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Hy8sbLKs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010014.outbound.protection.outlook.com [52.101.84.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4382C08A2;
	Mon, 13 Oct 2025 17:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760375045; cv=fail; b=EStm7k6ZqqAd7+mJUxd2bYICFX2alic/JH7FWEAeRdBhjMpppDJrstDapFvJKlXGhb4STzgQEguWXP/WL9SpIaACY6tpy0mi1pT1ch1fSUo1/XyuuvSW8yz0DhZM9kz/VH7gnLjLqoL5VmSMyaf0MiCiskR5sWH38sXNwT9zFvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760375045; c=relaxed/simple;
	bh=AYoR4N6THw8t3r8yBCuTokkdJr226+c27dQ8aMmd7pw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n65S2oJZx5z2MeALosgIM0CBhmgb5BQhMuZUdftayIZ612kac9PcEu8gpm+oBwHYKcu7GnCusW5mC10+ifrUg7W9cVEj0hpv5ZwuixFIEtsoxNbFp3/7AVJyK8O7oHAC3bsi6CqUWlfk1PaExZaNdMh9zwjA1D3x+A7VcIT8JKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Hy8sbLKs; arc=fail smtp.client-ip=52.101.84.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F/AG29lN9SnamsI/oc2BxAGon127fwB0Qq8mtC8gNtgHZpqtgZpMjemzfntFcIZUwi2HmAKZND99lsluhOtiDVwyP7onr7AVREZcHESpfEwm5xV8szcguEiaXOUhoy69mXJYr7FF8vKcD1sUPCAzwc3/BqSjbVkceKeCoctJtocG597UTfXKJvgi6KF8gQfd6LCMEPo7DOjFaSZSLrovI5uVvvJ1e2nG5mHfPihgK+aOT8dMTbfdClLvC1xI/X5UROQRvler+AE7jXsCe7jbC9XtDDvOB+9T9FOYBYPDJrBoPpuFUstNBA+Ubl6T3Rmhbt7wuL6k1QvWHocjyHD8wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zs4n0ZaYS06ykjSoTviHfq2GxpUhjA9G9hIOioJYs7E=;
 b=gldWNa0BW8lCr+ff/jGpRiRaFwjKilAMUVR/6/sxFGbAqc7Y82eVzC+ox0GzN74sbUtBJVIly+KF9gvTq60agxHjowL/zLhNKsUMymHd5TRScW0f1Asmf+WVMf8t+fVfBTwHicnv9LxggKp5avJSOWi/WWUXr7zEbNOpoh5Hy7ZNObz8m2098FGExTeFJcmb3qwK31DxHP12xuZLOZraO1uvcC4qEBQpLs2W0DRS9kxrfLNWVBCXvQUmSr/DGdY063ganb5+vXu1JuKD1f1gjp0sDrJaVOaki9G8Emv9WaV0ZGKoxepk7z2l9iCfZLCmq7+NXtxWzBXr2xCz3oR+Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zs4n0ZaYS06ykjSoTviHfq2GxpUhjA9G9hIOioJYs7E=;
 b=Hy8sbLKsC7f4PfoEu0W31mvEYk200VUlatQVey8XYi8akuH3UpqSAMD7RdLdUDtfGw6EpMO3bq98rPQrUf86Sy2ZHZQVa5QbatgaqMPVrEQM9pc/TrQVBhokMJVqv9i/dOdcpgxf9uRuemVke8jrCAqdjmRA0FkCtOHzLgnvKXaL+XLYPYAzGyd1MfvedMJ9Wz5BXcJC3oHAEN0a/TM975DyeagLeYqOr+eThZ+KLo/DHjSb08jxRJlUOrSasMb/CJaRGzIBaQxUCWLa8+lSlmCB+PevgLGGW8lvtxPuIAH/VXC7r/wjqy6dVBawE0a4SxbxGqKgA0ljoZ1SbZi2yQ==
Received: from DUZPR01CA0245.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::25) by DBAPR07MB6918.eurprd07.prod.outlook.com
 (2603:10a6:10:19e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 17:03:59 +0000
Received: from DU2PEPF00028D0D.eurprd03.prod.outlook.com
 (2603:10a6:10:4b5:cafe::81) by DUZPR01CA0245.outlook.office365.com
 (2603:10a6:10:4b5::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Mon,
 13 Oct 2025 17:04:20 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.6.101) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DU2PEPF00028D0D.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Mon, 13 Oct 2025 17:03:57 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 59D981C0042;
	Mon, 13 Oct 2025 20:03:56 +0300 (EEST)
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
Subject: [PATCH v4 net-next 09/13] tcp: accecn: unset ECT if receive or send ACE=0 in AccECN negotiaion
Date: Mon, 13 Oct 2025 19:03:27 +0200
Message-Id: <20251013170331.63539-10-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0D:EE_|DBAPR07MB6918:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9764000d-b2fd-4fcf-952c-08de0a7a7fd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GBi7TM79lYYwKH9Og8Sy68C29euPGUWfaKbninDexYMck/sJU5YgSNUPpBnz?=
 =?us-ascii?Q?M49SVwDbMuWuct0jmvxdZYyUCo3oEVPQQOcttzPzCLgOZQRALpgk1ZVtwQ0H?=
 =?us-ascii?Q?BoG6BAwNoXEOgyXhFbFbL5ichmjn/ltRE+rd7TBE1Zav+IW1Qu4fcv3Y6onU?=
 =?us-ascii?Q?hX+bkME3qWNQ0mq4DVjXuXUWzOwQE4PJkpiLpHXJEkskjoAcHUIeNGyP35Qu?=
 =?us-ascii?Q?aiWyoDpeCTy7kUyHjecfHeyQ7RPBROEN+0DmQ67yIEf6z6PptPD+JqBmHHUP?=
 =?us-ascii?Q?sqQ21he3aehOPX9YYSqQs1jW8zVEYxZZ/PSFVykXpZn8AI7zsv+YtyyIU2NQ?=
 =?us-ascii?Q?Teu5R825G4Z/FljKlyA/enA1EQVFnbcUolfx5/0mIFLaEnZKvTyVGchvhGqn?=
 =?us-ascii?Q?lz94qrwjcQjjA8fwa9gK+TSGuUhP/eK6kay38TAWHxVSd/b6c+D3YRk0rAMe?=
 =?us-ascii?Q?MCkqqnXYEvtFrW7NmdXERW12XoHIYT124c0lcd2gj+2/2FUbjEouZPCfX2qi?=
 =?us-ascii?Q?a90/SqAJ4xvdUdgLP2FYoTeL1iQhW5exMHP3YGDnpc/8u/Itr+L3h5DM1M2I?=
 =?us-ascii?Q?fkND04vjJHxypwu3fZLbfVXTQeYkRqeUhS8n4N9KL7pbNL1ei+6Jnx3Ga28j?=
 =?us-ascii?Q?quqA2/IysONtq0uBmqPzVujhWjPcK8xMN+OeKTwSm8U21Zqms4DtAGAKCR3L?=
 =?us-ascii?Q?Gfpxf/JFA3pA8Bzk3vPzuOwE/LBzl9KIY5rHtgz3E7kScugNRDa3iR4rS5uW?=
 =?us-ascii?Q?5wHKOh9DNzbrNhARVFPe5ET3vCeRfyKFQOkD1+TgApN/wiu0giVK1Hbcxect?=
 =?us-ascii?Q?JycMA5v+cK9IqDXEC+lj1h7kxtwgG0RONK9/bjKbcvcAdpAVDaiuIBGZCMm/?=
 =?us-ascii?Q?Tatbg+DM6bfydbdq0EaZoXP16EDmYFCAhl5ykMFNrRE/Eiy+UrUOSAlTY8c0?=
 =?us-ascii?Q?g6fqspzrcCAUcvoEnhraTqSd6TBO8nTbjKKMuXolvOQy6LqcC7vyOsSSgKLe?=
 =?us-ascii?Q?UAdsdBdQ+NMzCaaK69XsT+z1BTUhEonPoRC9JhV/5shri6bVdzCquhCkoSUw?=
 =?us-ascii?Q?O0+yoV6DfrWRcdV/hwjEsxwgekGqKTZ0MQV5Al6KKRRQn3PYwMD++/+exRMh?=
 =?us-ascii?Q?wn5XSFDfzQWJmG4fqwaZUF+4twweC/Vc8TocJ9vnEpOPtwa0E2l2/ipSygL/?=
 =?us-ascii?Q?zBOTquPaxxS41J5ThCQVlwjV5FvCPGbbQkVdTUcqlvtAmEQ8Y8gF0coDf2nE?=
 =?us-ascii?Q?SrqOjz98BibFCfWptS0pcrta8ZhgJwwY1aaa6YY4sFwPiHG1JuRGagTrlsG8?=
 =?us-ascii?Q?Sl2xgvHfesmLR9X83dFSdlBeIMKzVu3TlMb53+zG5h+vdGzyM9kZMfoIuUKC?=
 =?us-ascii?Q?mOB1X4K2bEeFaBhyfZPhZrpGbtdf5I6vQ76mssyqGtOc9qo7+L70+uTGRA5y?=
 =?us-ascii?Q?6ALgte7ZwtKUtvvWd2ioDfOYXX1/N9HeuxVGCJoaFoonofHYCArGFWE9OFih?=
 =?us-ascii?Q?m6VJcSp/TWzNtCAl4HXpowOq5DCdoyxjnU8mvTKnnrHSJrTNyIMwjAd3KeMZ?=
 =?us-ascii?Q?ZIvmQiSBaCkkivjqMaYXnGKnnrCKeXs9zlOt4XOI?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 17:03:57.9232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9764000d-b2fd-4fcf-952c-08de0a7a7fd4
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU2PEPF00028D0D.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6918

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Based on specification:
  https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt

Based on Section 3.1.5 of AccECN spec (RFC9768), a TCP Server in
AccECN mode MUST NOT set ECT on any packet for the rest of the connection,
if it has received or sent at least one valid SYN or Acceptable SYN/ACK
with (AE,CWR,ECE) = (0,0,0) during the handshake.

In addition, a host in AccECN mode that is feeding back the IP-ECN
field on a SYN or SYN/ACK MUST feed back the IP-ECN field on the
latest valid SYN or acceptable SYN/ACK to arrive.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/net/tcp_ecn.h    |  4 +++-
 net/ipv4/tcp_input.c     |  2 ++
 net/ipv4/tcp_minisocks.c | 33 +++++++++++++++++++++++----------
 net/ipv4/tcp_output.c    |  8 +++++---
 4 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index 97a3a7f36aff..50551430b1fa 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -649,7 +649,8 @@ static inline void tcp_ecn_clear_syn(struct sock *sk, struct sk_buff *skb)
 }
 
 static inline void
-tcp_ecn_make_synack(const struct request_sock *req, struct tcphdr *th)
+tcp_ecn_make_synack(struct sock *sk, const struct request_sock *req,
+		    struct tcphdr *th)
 {
 	if (req->num_retrans < 1 || req->num_timeout < 1) {
 		if (tcp_rsk(req)->accecn_ok)
@@ -660,6 +661,7 @@ tcp_ecn_make_synack(const struct request_sock *req, struct tcphdr *th)
 		th->ae  = 0;
 		th->cwr = 0;
 		th->ece = 0;
+		tcp_accecn_fail_mode_set(tcp_sk(sk), TCP_ACCECN_ACE_FAIL_SEND);
 	}
 }
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 4a6abf536dbe..f1e73e264b19 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6207,6 +6207,8 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
 	if (th->syn) {
 		if (tcp_ecn_mode_accecn(tp)) {
 			accecn_reflector = true;
+			tp->syn_ect_rcv = TCP_SKB_CB(skb)->ip_dsfield &
+					  INET_ECN_MASK;
 			if (tp->rx_opt.accecn &&
 			    tp->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
 				u8 saw_opt = tcp_accecn_option_init(skb, tp->rx_opt.accecn);
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 1fade94813c6..ecead2b771fd 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -751,16 +751,29 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 		 */
 		if (!tcp_oow_rate_limited(sock_net(sk), skb,
 					  LINUX_MIB_TCPACKSKIPPEDSYNRECV,
-					  &tcp_rsk(req)->last_oow_ack_time) &&
-
-		    !tcp_rtx_synack(sk, req)) {
-			unsigned long expires = jiffies;
-
-			expires += reqsk_timeout(req, TCP_RTO_MAX);
-			if (!fastopen)
-				mod_timer_pending(&req->rsk_timer, expires);
-			else
-				req->rsk_timer.expires = expires;
+					  &tcp_rsk(req)->last_oow_ack_time)) {
+			if (tcp_rsk(req)->accecn_ok) {
+				u8 ect_rcv = TCP_SKB_CB(skb)->ip_dsfield &
+					     INET_ECN_MASK;
+
+				tcp_rsk(req)->syn_ect_rcv = ect_rcv;
+				if (tcp_accecn_ace(tcp_hdr(skb)) == 0x0) {
+					u8 fail_mode = TCP_ACCECN_ACE_FAIL_RECV;
+
+					tcp_accecn_fail_mode_set(tcp_sk(sk),
+								 fail_mode);
+				}
+			}
+			if (!tcp_rtx_synack(sk, req)) {
+				unsigned long expires = jiffies;
+
+				expires += reqsk_timeout(req, TCP_RTO_MAX);
+				if (!fastopen)
+					mod_timer_pending(&req->rsk_timer,
+							  expires);
+				else
+					req->rsk_timer.expires = expires;
+			}
 		}
 		return NULL;
 	}
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index f2e8a068f1d3..bd718e342638 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -334,11 +334,13 @@ static void tcp_ecn_send(struct sock *sk, struct sk_buff *skb,
 		return;
 
 	ecn_ect_1 = tp->ecn_flags & TCP_ECN_ECT_1;
-	if (ecn_ect_1 && !tcp_accecn_ace_fail_recv(tp))
+	if (ecn_ect_1 && !tcp_accecn_ace_fail_recv(tp) &&
+	    !tcp_accecn_ace_fail_send(tp))
 		__INET_ECN_xmit(sk, true);
 
 	if (tcp_ecn_mode_accecn(tp)) {
-		if (!ecn_ect_1 && !tcp_accecn_ace_fail_recv(tp))
+		if (!ecn_ect_1 && !tcp_accecn_ace_fail_recv(tp) &&
+		    !tcp_accecn_ace_fail_send(tp))
 			INET_ECN_xmit(sk);
 		tcp_accecn_set_ace(tp, skb, th);
 		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
@@ -3990,7 +3992,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 	memset(th, 0, sizeof(struct tcphdr));
 	th->syn = 1;
 	th->ack = 1;
-	tcp_ecn_make_synack(req, th);
+	tcp_ecn_make_synack((struct sock *)sk, req, th);
 	th->source = htons(ireq->ir_num);
 	th->dest = ireq->ir_rmt_port;
 	skb->mark = ireq->ir_mark;
-- 
2.34.1


