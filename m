Return-Path: <linux-kselftest+bounces-43014-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A31BD56A1
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 19:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 419954C1CDB
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 17:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075CF2EBDF9;
	Mon, 13 Oct 2025 17:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="mQDZmdUg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011031.outbound.protection.outlook.com [40.107.130.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BE62C17B2;
	Mon, 13 Oct 2025 17:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760375040; cv=fail; b=oJoRn9YCrqcYKpSK8vsCS21aPHRI8VTzgpMqGqmDQex/pqLzQHLkCjCOkDANPtz4T/9aaI4E9zEPemTH2O2+p9HmBlpgHkY89xMVLgaAEz5YD84FA6RD1o1uIa0z2B2LW/f6bKyNR2QbKYruJr1ghvmm6zBdBSL1gCnxP4IMIPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760375040; c=relaxed/simple;
	bh=HyPSTrjLdRUESe2ZKeALswOpbKpbD3icf2L5lfxfaRs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dsDROrVw/gy8SWmrkwSi1wABINtJq3XhG9kxmA+0RGUZyH5UHqx21k34udNZ4JkIYVBTaq2pWnsiZ/x2v9LFdMiIATl3x4WsKomSYA9V2lHSiRLuDywuRAjRE910F8NvqJ91VLVDwMxavAMfTqIqXQ+Q7+vnzDP404DloaMZ2UI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=mQDZmdUg; arc=fail smtp.client-ip=40.107.130.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OBLHb5Kv0SHCd8PeqcdleDTb2ohjufaIWVVI6ycHLlcFHIe9W97PxNCatk+FKDAec81ixbxf112ItwxgZzMwMqg0Sf2TQMR1/Vfk1Ty9/War+C44sPKDkKS5vKy/25X5Ht0oZQ9z7fywbg8Lb3vMOrKzfuy2j3BcIsbBOnzsczazWBgIrKgZ2ThvM/nOFugqfVUWFLd3juUgmLDfoKShTccNkpftTCLPbN6cfBKwb/c8HhfoqjsSFny6M/WYLxOR5D6/m3yKKc2+OEgqWbFuE1kEXYIUxt95adiYuSHrPVvc3iWdK2VKnt/Ydh2m8KSMesVGFGbjrFyC0RdY+vGOcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzmrsYedXbtlFC14lNlddkSScaUDfuYExLFlMph8ZZ0=;
 b=yAfAtAbosaxfwx9LJRQ5t47euVg5zwJgCOZPnwcsSiYeGjI4VO7lG5fOgnZTiw4P2KeL2+XEYHwcK7UoftMcGVihrVvm5kcx5sfmANiItpuMW8j+vGEmLxtLnsKrQKELeESrPgavWPQm9OqlzksqcTocxeIRxj4yXANIwHcMmc2jS/hsNVoki5a+Nk8YDfKgTafYJ1xVQWZN0gJ15Vbbcz2HFuIH6AyQbhkN150n2kZ+e6r1ygrlZFd4t1k5MaP/abjy+4tJkjKIgHR3SyfXu+DFZiNSCNzYp/223f9yHoE6Q6T0OF8T7TJOiFlnfJi/sG/QOVTh7jg9Nm79QFULIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzmrsYedXbtlFC14lNlddkSScaUDfuYExLFlMph8ZZ0=;
 b=mQDZmdUgOmrZu+kGmm9JctFaLkEpjv8x0K7MCKaGgk13CGGF/ixli2eZze1N7ERLNzh7elO9m8HiZhHP7hB+ItV2Nb7X+infmIX9noY+pSftfrXosFIhilsQsivnboBVwluNQSYrWoF2rP+xjiirNXhWFd09ywVRhn8t723jZVnqKa2/Ez+ngdZbU7P3PVgtvh+9Xywo8AGX/G+8IUGAdtDt8Ye5EXMvWqplv2r8VR7jTJ0zVvdDUx1B1MQKLpRky1j9o5nZZBeE7KMIUrYnMeIGmVvYGHhe3S2dDtH+486J8MgH6BkqJ91yEZBykW65437+L1JR8yUScIjxX0hBTg==
Received: from AS9PR05CA0290.eurprd05.prod.outlook.com (2603:10a6:20b:492::35)
 by AS8PR07MB9281.eurprd07.prod.outlook.com (2603:10a6:20b:61f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 17:03:54 +0000
Received: from AMS0EPF0000019A.eurprd05.prod.outlook.com
 (2603:10a6:20b:492:cafe::9d) by AS9PR05CA0290.outlook.office365.com
 (2603:10a6:20b:492::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.12 via Frontend Transport; Mon,
 13 Oct 2025 17:03:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AMS0EPF0000019A.mail.protection.outlook.com (10.167.16.246) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Mon, 13 Oct 2025 17:03:54 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id EBAFF1C003B;
	Mon, 13 Oct 2025 20:03:52 +0300 (EEST)
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
Subject: [PATCH v4 net-next 07/13] tcp: move increment of num_retrans
Date: Mon, 13 Oct 2025 19:03:25 +0200
Message-Id: <20251013170331.63539-8-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019A:EE_|AS8PR07MB9281:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e4ae5633-54b1-4d47-ddbe-08de0a7a7dc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MrFF5HAX/A8IS8XHZDMBxufpu9yL8HyViIRVtsqeTKAUXDZThVKdBSZk8J/R?=
 =?us-ascii?Q?q/UADVvW0bBCTTMuYMNsvMgFPZspUM5Ps2ictWOQW4jPL2bYR/Llcw3VQiuB?=
 =?us-ascii?Q?YdPQQClPjwKXFPcOqKPjP+eoOhbCn8es2IOZGr9usMlzJLJVwaYpbHSS1JZj?=
 =?us-ascii?Q?f+9nOLa/eHVWGydpDalX71dbJBnYNk7RQtYDr3rjhZrGNJ/6EmeXqnYhKGof?=
 =?us-ascii?Q?/61HE5fodjmgygIxLCFSYo7iKWI4jvEBYkxZeFfRK+SWTwN48fAGiv0qaPID?=
 =?us-ascii?Q?dMyzcbj/8kiS8X0HIhKLQmypKHd8kTYdoW9yH5dBPsy4zPthw0m83lDwf8f5?=
 =?us-ascii?Q?zJK1CwYQyq66j432Hj1gYK60nB3Skmze/D1Ki338hWD8TbnEdGx+1ghKkTuZ?=
 =?us-ascii?Q?hLVKF2OCdN8ZxzHG6c2NV8S8/Tq/u9i6gr7zky8yqRybK+HZBkGf2aTaFbIY?=
 =?us-ascii?Q?BLM2Pc9rFz6l95LT+mpXy4GHUxloLv5ou7ta146QnvmXlXE08yHnUlsvwx3q?=
 =?us-ascii?Q?OjcuJ7Of17sjPmagIydTKDR9iSxs89PnUKBQOAd2eYuNO//G2Z7X/qYRGDWE?=
 =?us-ascii?Q?Fs2zX+MGzoYNl+sMYO8a630LH51rFUSuUCmwewyseMIwxl6t3vNGerxd1O9A?=
 =?us-ascii?Q?7J7WQ8E6FMMB67lWuGCZdmMBiFLXz4FVOR2O3pkO4RfHTWeQOtbJFaxJSKMw?=
 =?us-ascii?Q?FCYrtEOaanRyDIRWylCJYZ9hgITEeJPne+ajMZ2p6U3N99BWWuLzwMCXgDOi?=
 =?us-ascii?Q?yKvSdKM57jySQkTbz4yo24i+412QZ6PAP4CIQ45+rbICzGJxUWMeZa59JVRr?=
 =?us-ascii?Q?xyOeBqOaudfvBmzC7/txIgL4jE9ogq4RhUQgirKEQc/Sk4Yy+HbQtY+3/Lm6?=
 =?us-ascii?Q?/8vatoSWpUWF8aWTZ5gF8y/iPnJJPl6perWVb91KJjYUAfDU9XyNXHM0OZxU?=
 =?us-ascii?Q?gG/eLmcLwXVA32lOiTwxqb16KOv+SutDQkXsRNN3bCKUiNY0Xx1Jm3IsyO0B?=
 =?us-ascii?Q?UA6wSKq40Ji9qz3VXxVMMfyxQR4LA3L24vHX5rgNAowncPFWCoJk4nmy2ijL?=
 =?us-ascii?Q?cA8lrMLDz2Enucy2CNcKd5whYRUOp6z4Zvn+XvSzWyqdi0UYN9F1cpp7RV1w?=
 =?us-ascii?Q?MC4MxdUhMP+i5EhJgDNZ3/B/SCmqz5x8hUYcmbRhZjAkk0B5hKMn3Tmqw3sm?=
 =?us-ascii?Q?M6ifOIsAdeEHDuA6LaYRVMeCNq0B+CSIEoyuwo1KbyAMRcp043wLDKTcTIFS?=
 =?us-ascii?Q?qbaeZ3mtn6GOXGZgTiD0fBuzoY4ap1YtVEDGdZjDoSgOMFbc8Nz6QQQKOTcK?=
 =?us-ascii?Q?N69JlmfKlmNFFT7fx8NwWGoNG3bAiqvFSNZsBm7bzx2yDOSiPBxA/VANqVUN?=
 =?us-ascii?Q?Vohr5TgWqOYFnGjDXzfVNS2SCFcQte6i8DvNex7kLcc5+QiVjTVR1vJfP3vX?=
 =?us-ascii?Q?IDz6eTe8b8OjjckIyIbLvM9biCSjyzq1PLowQA9kMFVbAfipJit8QAJgNXoS?=
 =?us-ascii?Q?VxkMMp1WUEiALlj23ccCYDqAcgyiAUxNKF2w/Nq212TmmvNIJTtsHzGZYhTm?=
 =?us-ascii?Q?VxUjYkQKCe14QPAGwbEB/KfYLMRPmTwazZHfCeKL?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 17:03:54.4721
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ae5633-54b1-4d47-ddbe-08de0a7a7dc2
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS0EPF0000019A.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB9281

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Before this patch, num_retrans = 0 for the first SYN/ACK and the first
retransmitted SYN/ACK; however, an upcoming change will need to
differentiate between those two conditions. This patch moves the
increment of num_tranns before rtx_syn_ack() so we can distinguish
between these two cases when making SYN/ACK.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_output.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 6e6fea8f295b..ef008736e3a9 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -4593,6 +4593,7 @@ int tcp_rtx_synack(const struct sock *sk, struct request_sock *req)
 	/* Paired with WRITE_ONCE() in sock_setsockopt() */
 	if (READ_ONCE(sk->sk_txrehash) == SOCK_TXREHASH_ENABLED)
 		WRITE_ONCE(tcp_rsk(req)->txhash, net_tx_rndhash());
+	WRITE_ONCE(req->num_retrans, req->num_retrans + 1);
 	res = af_ops->send_synack(sk, NULL, &fl, req, NULL, TCP_SYNACK_NORMAL,
 				  NULL);
 	if (!res) {
@@ -4606,7 +4607,8 @@ int tcp_rtx_synack(const struct sock *sk, struct request_sock *req)
 			tcp_sk_rw(sk)->total_retrans++;
 		}
 		trace_tcp_retransmit_synack(sk, req);
-		WRITE_ONCE(req->num_retrans, req->num_retrans + 1);
+	} else {
+		WRITE_ONCE(req->num_retrans, req->num_retrans - 1);
 	}
 	return res;
 }
-- 
2.34.1


