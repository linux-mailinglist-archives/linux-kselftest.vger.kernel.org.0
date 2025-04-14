Return-Path: <linux-kselftest+bounces-30694-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAD9A8816E
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 15:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A1043B82B6
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 13:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFBD2D4B71;
	Mon, 14 Apr 2025 13:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="LXhDsDPq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010068.outbound.protection.outlook.com [52.101.69.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5332D1F7E;
	Mon, 14 Apr 2025 13:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744636452; cv=fail; b=do3MsAXgW+CyADwGLglxUrzYYdnFOagR9HVDyy6j71XXEnM6mLvuPuWIfq/GjzKZpRtGOzMEegOszhNLp+gG5Mx41isxf1FJOTOCTgfM/vnkoqMeuByDAVzfU7n8nbrK8qC+ET+ST8SVyBfmUYkbzo+Y56UWhh3V3zinF3Gr4dg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744636452; c=relaxed/simple;
	bh=bz0uIeWpSGSuIQvh66yhCx2wBEBZLK1Uhj3GCh55+fI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aKTEKCWRUT7d5NAuo5YMZqeuVG+7Bpj33ah0wkFW/PUgC/mFOeJKpcMQ5NRpeo1MkcJXzzFevxnHjTpoMeqL7Ymyzt3A+7Z6XSQRYbtcUIvaaxbvhc6WLj9PKL6KY5Q3i6Z/5YWDpneSlNJNL6yNM6ofK5dxYmdOD3zx1qeCibM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=LXhDsDPq; arc=fail smtp.client-ip=52.101.69.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KAmQ42KtZbjnCbZ6vNoX62JDVGYuS3xOUd76+MZ3fh0rFufm5DkGvO3W2F1qpGKK658AcOT1ypXg5aWcnccLVCayPzOiBQa92mmLsbtH9B/HKAIpFGuHPZ4mE0zqf/cX7zZXB7cKhbsDtNpg+R4Fh0fTXipCEbEtAKWltX6iWP0wsa82kIXfmBggV3UGTEmy/xqSbkCNMbR1HYwHwOx2mpBrgIg5vTcPew3exswn0dxYPBr2oDRrCbV50n28/woCmoG/tiHmUNxM19j/QyU3p15ZSQFsMcnOYn3w90J8BiG9xKBQyfGC442pbAOMTKtbl/OiwBBXACF9RCRxkrgJLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xY4cSgz9DD+izQ5CHXWWIiWN/HVvG4kiITK+k1h7IUY=;
 b=zNEJ2FbHtLQ/4ca7cR1Xgzwies7MPlgccC5xblL0aoUpqqttJEeqMkz9tfLqQ77z0MpfVFJaOL6R86Q35ZT3mSiAfcvaoWLvGMBZVWLdantew0Hn2qljnTpitboL4PSNjAcqiDD7Lv1fOf022abt9gE74h/9CFGdRvgE1qQBF10CAd2ddOqTExNhR1J8Z11Aoin3g+d4uozHdXp/Lg6SIiB7/III4vwr5qmtD4iA/7v2Y8bkcTh14KVypG0D1qmGdNlCdtMYsa9wHWbaPj5OPCdZMAoQEe+a4OUNh+RkEwgNsL9Nfw+/OT7KF88K4LzDz0+kZAZXPE3CZcWU4BcnbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xY4cSgz9DD+izQ5CHXWWIiWN/HVvG4kiITK+k1h7IUY=;
 b=LXhDsDPqLqCT+ctADTDDJ8kN/vSUhIa99M4JK8sTM89jIcckDmlWVQubgOIUO7z0ANXyvyTCZJQHrS+j2QScg7UE0g6zQGNyMs3Akhz3tE1Kl1TUPACfMzbtS5qICKO5gbgGbvc1js3o8cB6IvF0A28764aeu8G/yYhDltsjro8GWSNiFbjcRRh9oJVXyCNYAvz0+qArxe4XISbG5Uu75Fj3NLAPEEzAw0slmsG7t3cga36gXrfHQnIC94SM9A37LX8RM0aE5UrkwMg3GqAr5HUIKNd8srAFmpnwzmkxtdmY/ZGYIAECkUAkVxl6069SMzgkQwIr9P+410LiVdedvg==
Received: from PR1P264CA0194.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:34d::10)
 by PA4PR07MB8885.eurprd07.prod.outlook.com (2603:10a6:102:266::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Mon, 14 Apr
 2025 13:14:05 +0000
Received: from AM4PEPF00025F95.EURPRD83.prod.outlook.com
 (2603:10a6:102:34d:cafe::14) by PR1P264CA0194.outlook.office365.com
 (2603:10a6:102:34d::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Mon,
 14 Apr 2025 13:14:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM4PEPF00025F95.mail.protection.outlook.com (10.167.16.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.4 via Frontend Transport; Mon, 14 Apr 2025 13:14:05 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 53EDDQBH009623;
	Mon, 14 Apr 2025 13:14:03 GMT
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
Subject: [PATCH v3 net-next 06/15] tcp: accecn: AccECN needs to know delivered bytes
Date: Mon, 14 Apr 2025 15:13:06 +0200
Message-Id: <20250414131315.97456-7-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250414131315.97456-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250414131315.97456-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F95:EE_|PA4PR07MB8885:EE_
X-MS-Office365-Filtering-Correlation-Id: 46790267-8f15-48dd-7a71-08dd7b563b91
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|376014|36860700013|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?dU0vWHdqeHVyVCtNT254VkZJYTFscjBYVlhOeGFCdmtKc083UFdjOEY4NjFa?=
 =?utf-8?B?KzVpem9oczlCdWZOLyt0WjlCY0JKZ1loYWd4NVZTbmlYaUs0MHNEWWk1N1hu?=
 =?utf-8?B?b1JBZU82YmU2QmZySjJkT2Z3ZkJDYVpwQ0d3c2RVNzVkbWpGT1JabVhqNDJx?=
 =?utf-8?B?RjBxa2IveHRWZEdZQ1VkcW4xY1JjNEdaeUpYTVRWeUlYYVFjK3N6UjBjTEdC?=
 =?utf-8?B?UklwMzdwaldhOW0rZkdOYW1XZ1YyT0tteFhxVVp6WVFGd3c3dk1pVWhUVk1M?=
 =?utf-8?B?ZVkrMUs4UDloVk10dStOeDZhT05HNVp0MEVaTFpIQmdBTkJKZnBpRWVJT0xt?=
 =?utf-8?B?elJKNjZteFRLOE96ZjV1Wm1ZeldWcW9zVWlIMG5GblJLajFKaytnUXA5TE5Z?=
 =?utf-8?B?WGQ0NmExODZIa2xweFg4K2JUM1hnTDVNU1hlTVk1blA4ejlpdEVZN0cyVFJq?=
 =?utf-8?B?ZzNVQkNHZTFHRWxnc05nRjFINzlPcXdPVHNINU1nSXpOZ0lRblN6OEVwdmVG?=
 =?utf-8?B?bTJVZUVWT1hqdFZXbFBqZ3JEcGhicW8zcE1QQjgvcGo0VDJZNHFnM3ozWmZN?=
 =?utf-8?B?K21MUEtXYnJycEtNcmRKemN4Y2VYQTEyMG5nRlg3K1VhZS9VcklXM09aRDY0?=
 =?utf-8?B?VitDWUpSZGQ0T0dMcXBaNVgwRnlZeHM2RklzTXlQZkFyWXJjRjhJcHMzODhx?=
 =?utf-8?B?S3hDdS9KNUR4R0VBWEJOSW9POG5BNUNaQzNUYVlRaUlzTCtLbHAzQnRKYmFz?=
 =?utf-8?B?UEQ5RXV6SDFrU3JyMzN6WU0vUjZnSkdoMHl2cXhUbGxCdkVvL0R0VkVrKzZG?=
 =?utf-8?B?NTI1WWJBMTJDWGhxY01rQ3F1WkxNeDFCY3hneXdCM2ptQmxjbVY0ZXFRcklN?=
 =?utf-8?B?aDY3Q2hYTGlzZERSMnZUd3ZGZkxSMzFQUXp6bm5uUHFuTE8vTFdmNkxjNW5w?=
 =?utf-8?B?a092S3hxTFQ0RXVrRjdXaEI5YVZTd25LdmdHQXNrODcwT1FJRDNVcWNXWUx2?=
 =?utf-8?B?MnJ2YXA5b04rNm5HMDFyMXJPbGxtS1VMM2NZWWFzclpxVHZ5d0J2ZW1BbWtE?=
 =?utf-8?B?TGcxUHEyZklHRU9JOG82RnlGYlh6NEhyS3ZKc242VnpHL0RLYUdlSFpNUHZI?=
 =?utf-8?B?VzlkV2JhKzZGc1MzY2ZZMjdTdXh0cEFoWmZSUm9IVnZpUk9zYjJnZmlhMzlx?=
 =?utf-8?B?d0x3d2lhRHFLaDFrNGd2UGYrUTNpV0szT2krZ290NGhEZ2U1QjI1Q2RleHBW?=
 =?utf-8?B?M0R1eUlkam5OaXRUNHYyYWZ5RUt2M254NUZrTW5SOVlua1JxOFlDb0FCR0lj?=
 =?utf-8?B?clI5MWxVdEk1V3NrR1UwRmFhSUdlUWtzZGtERU9iRGdQajhla3gvdnJkNTN4?=
 =?utf-8?B?VjErTjVIeHAxa1lEWmdINWg3bTF3TUdSQkZacVUzOVVRbGV1NDIrUy9vckhm?=
 =?utf-8?B?c1NBUk5KNUhnSTRxUCthdXVyaUJLbzBBelc3cFhNcUVvVTNpeGRoZDFadVFE?=
 =?utf-8?B?bXQrZndiOFhtV29JMjVGWnFHeVIvK3d4Sld2elVCV3RxZkI0VmhpRUFyRENk?=
 =?utf-8?B?RHlUREZIcFZQVUlqZzZrUEFSOCt6VG9NbVNOYWtMWUJnR001Q0lzdk5vMjc2?=
 =?utf-8?B?NDdtaTAvdjFnbnlhWmp5TGNKZHZzbmFwQXVaZzJmTWVGajBNSGRxVzI5eSsx?=
 =?utf-8?B?UU9wZFJmSFkxQjV6eDdOb2RyOHJsUEl3MVgvUUhmeXlqeTkvWi9GTDFFTVJp?=
 =?utf-8?B?UnlxODJhUFV5VCtZT1ZYUUVvelNvL3lTbWZaZ3o3VSt6MzkvY29hWHJtcHVp?=
 =?utf-8?B?Vm80dm1zNS9QVm5LZXhZMEtQbDhVOWZSOVFxTHdUU0I3bmlodkZ3dGtBT1lz?=
 =?utf-8?B?MDBEYm0wM2JrTXdUQVRscUxoVW4xWVRPc1UrN0FaMVlVZGRwNFFmVzVNYTR6?=
 =?utf-8?B?cjBtTk5NSlNxT0JmRzJkTFluRHFIQ2R2eXdEUDF0L0hTdzgvejRNeXZnQVhj?=
 =?utf-8?B?MmlCamRRK2xKYWVrTmdiOUNkNktxbDVIS0VjV0diczBCNXhJK0JMWGZ2ZGtn?=
 =?utf-8?B?VVhNNG9KK2JKNTRNQWh1TGNGeXB6cHl6eUprZz09?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 13:14:05.2368
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46790267-8f15-48dd-7a71-08dd7b563b91
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00025F95.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB8885

From: Ilpo Järvinen <ij@kernel.org>

AccECN byte counter estimation requires delivered bytes
which can be calculated while processing SACK blocks and
cumulative ACK. The delivered bytes will be used to estimate
the byte counters between AccECN option (on ACKs w/o the
option).

Non-SACK calculation is quite annoying, inaccurate, and
likely bogus.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_input.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index c017e342f092..5bd7fc9bcf66 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -1170,6 +1170,7 @@ struct tcp_sacktag_state {
 	u64	last_sackt;
 	u32	reord;
 	u32	sack_delivered;
+	u32	delivered_bytes;
 	int	flag;
 	unsigned int mss_now;
 	struct rate_sample *rate;
@@ -1531,7 +1532,7 @@ static int tcp_match_skb_to_sack(struct sock *sk, struct sk_buff *skb,
 static u8 tcp_sacktag_one(struct sock *sk,
 			  struct tcp_sacktag_state *state, u8 sacked,
 			  u32 start_seq, u32 end_seq,
-			  int dup_sack, int pcount,
+			  int dup_sack, int pcount, u32 plen,
 			  u64 xmit_time)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
@@ -1591,6 +1592,7 @@ static u8 tcp_sacktag_one(struct sock *sk,
 		tp->sacked_out += pcount;
 		/* Out-of-order packets delivered */
 		state->sack_delivered += pcount;
+		state->delivered_bytes += plen;
 
 		/* Lost marker hint past SACKed? Tweak RFC3517 cnt */
 		if (tp->lost_skb_hint &&
@@ -1632,7 +1634,7 @@ static bool tcp_shifted_skb(struct sock *sk, struct sk_buff *prev,
 	 * tcp_highest_sack_seq() when skb is highest_sack.
 	 */
 	tcp_sacktag_one(sk, state, TCP_SKB_CB(skb)->sacked,
-			start_seq, end_seq, dup_sack, pcount,
+			start_seq, end_seq, dup_sack, pcount, skb->len,
 			tcp_skb_timestamp_us(skb));
 	tcp_rate_skb_delivered(sk, skb, state->rate);
 
@@ -1924,6 +1926,7 @@ static struct sk_buff *tcp_sacktag_walk(struct sk_buff *skb, struct sock *sk,
 						TCP_SKB_CB(skb)->end_seq,
 						dup_sack,
 						tcp_skb_pcount(skb),
+						skb->len,
 						tcp_skb_timestamp_us(skb));
 			tcp_rate_skb_delivered(sk, skb, state->rate);
 			if (TCP_SKB_CB(skb)->sacked & TCPCB_SACKED_ACKED)
@@ -3540,6 +3543,8 @@ static int tcp_clean_rtx_queue(struct sock *sk, const struct sk_buff *ack_skb,
 
 		if (sacked & TCPCB_SACKED_ACKED) {
 			tp->sacked_out -= acked_pcount;
+			/* snd_una delta covers these skbs */
+			sack->delivered_bytes -= skb->len;
 		} else if (tcp_is_sack(tp)) {
 			tcp_count_delivered(tp, acked_pcount, ece_ack);
 			if (!tcp_skb_spurious_retrans(tp, skb))
@@ -3643,6 +3648,10 @@ static int tcp_clean_rtx_queue(struct sock *sk, const struct sk_buff *ack_skb,
 			delta = prior_sacked - tp->sacked_out;
 			tp->lost_cnt_hint -= min(tp->lost_cnt_hint, delta);
 		}
+
+		sack->delivered_bytes = (skb ?
+					 TCP_SKB_CB(skb)->seq : tp->snd_una) -
+					 prior_snd_una;
 	} else if (skb && rtt_update && sack_rtt_us >= 0 &&
 		   sack_rtt_us > tcp_stamp_us_delta(tp->tcp_mstamp,
 						    tcp_skb_timestamp_us(skb))) {
@@ -4097,6 +4106,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	sack_state.first_sackt = 0;
 	sack_state.rate = &rs;
 	sack_state.sack_delivered = 0;
+	sack_state.delivered_bytes = 0;
 
 	/* We very likely will need to access rtx queue. */
 	prefetch(sk->tcp_rtx_queue.rb_node);
-- 
2.34.1


