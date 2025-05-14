Return-Path: <linux-kselftest+bounces-32949-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A31AB6DBD
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 16:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2062D16EDFE
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 13:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20889286D70;
	Wed, 14 May 2025 13:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="ae8ozgiw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010032.outbound.protection.outlook.com [52.101.69.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A44527CCDB;
	Wed, 14 May 2025 13:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747231050; cv=fail; b=oUnZB3H16dKGHjS9r+vn6oSbrFkP95AGMbHTbeUofpVMP2BPju/LXHkmP7s+subT2IS0q0WMcgl4nF+6ANclY5W7lK57daCGgmjYt2gtVBiU+2wRsN40Sf8jJGzxN0vk9uwtXx0/VfbuPHfO6NrjZB/mF08Bwa0xVsssS9oK//M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747231050; c=relaxed/simple;
	bh=Rpc4gI7FN20PeVrV/bFAaFUlv9cSGLN/wMwrNcsSIh4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qoW8AcMzqBGyZlvccZspGbfhlol+vlJX/Z5mH7+bo1QhZAFK3lvXz5zUYvRcv43r1VqaKPXVRAXFmD6zPfZJjBIOXzrMioYFte0S0nF7w/gB1AeHCUZzabeUeyyzpzNLGPKQI3E7VQ/PK7ZF3gmfubAYZXxWZIxW67l4HsLbGVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=ae8ozgiw; arc=fail smtp.client-ip=52.101.69.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fG1UACtFu9/xr7tqkoTUob+mtxAu6E2VfakqtGFHHdOBS/dP+timCvlgDve4FeIXxyE96XpyMzhl3TPZ76Ul3phKBeyTyZAM7ieyIQNlRbRxtnd91GGdZPfNdkP3rwBMb0I5MTY0Gyn+lBhPaR2jH8A50NT9jcGnCTEZLrAmuC4Pz492JJ2PLvTsUsO0YbMMFdlSEq4IMd2EqF4LxIlCDoFn/8iCwvl2PGc94PVgL2h3L4EUDCh1rrbHFCkT5cIujpkZNzKkFPhR088NuD8zXFzdazAoYePHmzO3423IpIZUvvEMZMCc5w6+lnQrl3jcPZscDCafcWFQdOAQg46x+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FeVAX8+J+Pzn97ZH7ktHpXkSmO6s4Os2BtLfBHe1RX0=;
 b=V7sK5n1y9yzrmImBEmQCJ0IzD1kj7284wyo1dSkQWXps3FiM24Yb7xtlMMZfwbYG0KYCXMUnPcYUG2RBIYgmKpczOXQG81o3dnfg8LYbY64PBv/hXM7l81PFdqTvOOBUmksK5AF1b02uJUR5Pyf3gpips+dYq7a818o2+LNlJhgQU3ELkj6kb7CpTrtvWAaE3VbGOJzvtlr8kCylRYPntB821guUpn78A0UDzAowAFGnEpDlg71W4tMBceqOGUX9bx2EDFrB0OVxym2XlGcUisfWa+DSoSBuSwVz66Pqh2GK6jLK9dtlPwnXKFLz0EP+okzu96CuKZ0nVtQ0tL9gEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FeVAX8+J+Pzn97ZH7ktHpXkSmO6s4Os2BtLfBHe1RX0=;
 b=ae8ozgiwTB3iGYm4q9AMCb2pJq6bRAZlX+UeFhoOneu7fw8w+Eh+FtOA0gbtHF6nw6ByeJAls+2+qCu0q7keVaSSyNJE3vyGSiuPQQfwTF0JUb/+uyF5kOc0iXsYrmpxuCVcBio0iJ+dEyNZLZqwdVm5pNUCX1ovwordt6uAltf19TIO3eDahFrmiV8wZjB8FoTg9x9KE0Zvcxvt1TP4//NTwC7roT8v4FCPzIW6LjtdGgFMF7SqWu/+cFUQx1XnlbQYGAtHkpOBADzVwYUECwuIiKGY8tM/tPNd4Tk3e/5x4u4XPmbc7Xrsks54eSnGcH0VCMSW9p4xdi/B6LqSfg==
Received: from AM9P195CA0024.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:21f::29)
 by VI1PR07MB9472.eurprd07.prod.outlook.com (2603:10a6:800:1c6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Wed, 14 May
 2025 13:57:20 +0000
Received: from AMS0EPF000001A5.eurprd05.prod.outlook.com
 (2603:10a6:20b:21f:cafe::25) by AM9P195CA0024.outlook.office365.com
 (2603:10a6:20b:21f::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.31 via Frontend Transport; Wed,
 14 May 2025 13:57:20 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.2.240) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AMS0EPF000001A5.mail.protection.outlook.com (10.167.16.232) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.18
 via Frontend Transport; Wed, 14 May 2025 13:57:19 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id B267D200C2;
	Wed, 14 May 2025 16:57:17 +0300 (EEST)
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
Subject: [PATCH v7 net-next 15/15] tcp: try to avoid safer when ACKs are thinned
Date: Wed, 14 May 2025 15:56:42 +0200
Message-Id: <20250514135642.11203-16-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514135642.11203-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250514135642.11203-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A5:EE_|VI1PR07MB9472:EE_
X-MS-Office365-Filtering-Correlation-Id: 48f4ec08-97ca-41d8-c8b0-08dd92ef3e29
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?ZUMvZ2ZXbURKTjRmVTNyRXRienQ2WWNGQVBMbTBrZHl0VXp1SkxXbUY4TjVz?=
 =?utf-8?B?RTV5eENMa214VW5VMGdLbjBIOXRScm5STjVmZDd5MU9xOG94OWw0WGNyUmQy?=
 =?utf-8?B?WXc0ZWhXaXZ3ZEFJcm8rcXB1cWNERnc0Z1VRM3NrUHZvVzVjTldvei9JWDRD?=
 =?utf-8?B?bjZqcDNSMSt0eW9XQTZYYUlWL0NwOXlueVRZemsxZDJSTGgxNUNmSWJrMFMz?=
 =?utf-8?B?bmpUUW1GWE83ZWpITnVlNXNiM1VPYXk4R3N5a0ZHM04xTnVDQ1FSZko2S3E5?=
 =?utf-8?B?azhYeUZSRkZFMVlzdUtFbldBOHVFVk5YOFdpdmFSK1BnRGxsQzZVUm92QWMw?=
 =?utf-8?B?ckFTS2RxMCt0dy93bUgybkZtRTlZbUpucldDbEIxeC9jSzg4YVFrSjZFM2k0?=
 =?utf-8?B?bGFDZ3ltbk9yMDlVckpSaW9yUFRJd3BMeUVmWHJxMGFKRkNubzVISmticEM2?=
 =?utf-8?B?bGZrZVBMSnFzU0tiV2ErMFJ6dGVBT0p0L2J1NUlnZk5uTlBqeUxyQnJQVWhp?=
 =?utf-8?B?ZFV6WW03ckNKUEhuR0lwbmZFWEs4SWJJejZtV2xtak9kd2UzajVGRzRMcVcx?=
 =?utf-8?B?bEkvZCtCdnVQcyszSGV1aEtRdnNFaEI3WlU5Vjl0Q09LUFAxMm5nMEZsWEo5?=
 =?utf-8?B?RDdXVFBwcDFySitYNDU4WDVXN250aTJLem1TUFFzTkhTdFFCQTFMcHF3eURV?=
 =?utf-8?B?eGdyYU0waFhWWjhXa2NuSXlQZExDVmQ1QnFGSnJ2TzR4WTlHR1Z4U0xMa3RQ?=
 =?utf-8?B?MElpRkxEcmUzb01VSklWQUxYOCs3QWhmSk5yZWwyTEhoT05FZmkzVnlvQjVj?=
 =?utf-8?B?eHAxTm5xNlo2YVFiY0lqemJaL1o2ekFYdTFrMm9xOStubFA4dTFmc09FYm0w?=
 =?utf-8?B?c1FGTXpIazJhc0tCVk9aSEhrL05tQ1YwQ0dQR0dmbEZuNWFsYXV1QkREc3JB?=
 =?utf-8?B?RE8rbnpXbW5MN0ZGNG5rR1F3dHRIY2JmTGhEOW5vZHpzeFlzeDdzZjU0cmpz?=
 =?utf-8?B?OHpoYW1ZWjZ6YUlRaFN6VDZGUkM0WThWM25Oa0dITkNIWGpNQkh4NnRMaTc1?=
 =?utf-8?B?VTNjTU56cVlUSVlWdk14YngrZG5yT1BpMVp3YUEyMXI4Tkx5UVMva0VqbklX?=
 =?utf-8?B?MnNCS00reVd6TEppeTM5Nk9mNnRRUlhocTNBK2psb1ZMVWNnV0VBRlprQStE?=
 =?utf-8?B?TnNRSmxtTlZhVllabkFXamRwQlZibVdueWlhSHg4ekQ2aC9kUzdOTExqRWY5?=
 =?utf-8?B?M3RUWnhwRThsLzhnVUtFM1JRU3BpdEh4OSt4TUhZbnRMdCtMdHBVaTRRdWxS?=
 =?utf-8?B?M1VRczFGS1ZuSUh6THRCK3N6WTFaUVJNM1RxZ3RvVFhPaDl1azNHeEwyWEZa?=
 =?utf-8?B?dnRlN2VBSjV6RFZpZHRPVFhjd3dNcXVxZ2pBZWM4ZjZhQjJCU21HZm43Vzhk?=
 =?utf-8?B?SHBzQkM2b0RMbzU2WDZvVmlYc1BTMDN3QjRpQnVnakY2Ym54Nnp4ZFphVzg1?=
 =?utf-8?B?a2ZmRDlTRXowaUxEVmExY0xuNlE2TzFtckxUNCtBOHpzaGU1R3ZMQjJkTEJD?=
 =?utf-8?B?OHZqcnF3VVZEL1VuK3RsOStxNHBkcFdKdmx4c0ZpSU1lVU8wVFczY2o3TnFT?=
 =?utf-8?B?QUNjRyt6V2ZMQW9HempKTzNUMG1KOU44T0ZZemU4SWZ4MGRVUjUxcVd6MlJB?=
 =?utf-8?B?M3N3R3RXNnVHb3M2MENvNFk2QVBuWGh4bS85WGFUYnhVbnZGa09NOVRta3dw?=
 =?utf-8?B?N0ZBenJVZHZQaEVkRjRtZUZMY0h2dEQvbGNYaW5wWTRqZmFaOGdHeVV4S0sx?=
 =?utf-8?B?MmF5ZDVmU2xyTUtYOFZEMU1EdnlnM1ZBejluUVI3c2VJS3BpS2pzL3l6WUxt?=
 =?utf-8?B?dVNQeUZyd2ZhM1JKRTZkanlUalBnUFBLUUNyUjFUQll0dzJHYlJ2ODB2L0R0?=
 =?utf-8?B?aWtHK0gvbjRYYWVpL1JkZnV6WjIvUHp6ZUluWnZPWldjaVkxTGczUGRkUnl1?=
 =?utf-8?B?VUNMd2M4WGk1RERUSSsrRmVaTktVa251YjNXNkpEV1puK3B4ZzMyTGJWMjVp?=
 =?utf-8?B?cXQ0QTdtZE9Hc2Q5VUc0Y2VOKzd5VjliQzEwQT09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 13:57:19.2184
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48f4ec08-97ca-41d8-c8b0-08dd92ef3e29
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB9472

From: Ilpo Järvinen <ij@kernel.org>

Add newly acked pkts EWMA. When ACK thinning occurs, select
between safer and unsafe cep delta in AccECN processing based
on it. If the packets ACKed per ACK tends to be large, don't
conservatively assume ACE field overflow.

This patch uses the existing 2-byte holes in the rx group for new
u16 variables withtout creating more holes. Below are the pahole
outcomes before and after this patch:

[BEFORE THIS PATCH]
struct tcp_sock {
    [...]
    u32                        delivered_ecn_bytes[3]; /*  2744    12 */
    /* XXX 4 bytes hole, try to pack */

    [...]
    __cacheline_group_end__tcp_sock_write_rx[0];       /*  2816     0 */

    [...]
    /* size: 3264, cachelines: 51, members: 177 */
}

[AFTER THIS PATCH]
struct tcp_sock {
    [...]
    u32                        delivered_ecn_bytes[3]; /*  2744    12 */
    u16                        pkts_acked_ewma;        /*  2756     2 */
    /* XXX 2 bytes hole, try to pack */

    [...]
    __cacheline_group_end__tcp_sock_write_rx[0];       /*  2816     0 */

    [...]
    /* size: 3264, cachelines: 51, members: 178 */
}

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 .../networking/net_cachelines/tcp_sock.rst    |  1 +
 include/linux/tcp.h                           |  1 +
 net/ipv4/tcp.c                                |  2 ++
 net/ipv4/tcp_input.c                          | 20 ++++++++++++++++++-
 4 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index af76d4f9b33a..2e6ef8290aff 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -105,6 +105,7 @@ u32                           received_ce             read_mostly         read_w
 u32[3]                        received_ecn_bytes      read_mostly         read_write
 u8:4                          received_ce_pending     read_mostly         read_write
 u32[3]                        delivered_ecn_bytes                         read_write
+u16                           pkts_acked_ewma                             read_write
 u8:2                          syn_ect_snt             write_mostly        read_write
 u8:2                          syn_ect_rcv             read_mostly         read_write
 u8:1                          wait_third_ack                              read_write
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index b5066eef8782..b22914a4f3cb 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -346,6 +346,7 @@ struct tcp_sock {
 	u32	rate_interval_us;  /* saved rate sample: time elapsed */
 	u32	rcv_rtt_last_tsecr;
 	u32	delivered_ecn_bytes[3];
+	u16	pkts_acked_ewma;/* Pkts acked EWMA for AccECN cep heuristic */
 	u64	first_tx_mstamp;  /* start of window send phase */
 	u64	delivered_mstamp; /* time we reached "delivered" */
 	u64	bytes_acked;	/* RFC4898 tcpEStatsAppHCThruOctetsAcked
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index e68b9706eeff..b1ee5b6618f0 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3403,6 +3403,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tcp_accecn_init_counters(tp);
 	tp->prev_ecnfield = 0;
 	tp->accecn_opt_tstamp = 0;
+	tp->pkts_acked_ewma = 0;
 	if (icsk->icsk_ca_initialized && icsk->icsk_ca_ops->release)
 		icsk->icsk_ca_ops->release(sk);
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
@@ -5164,6 +5165,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rate_interval_us);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcv_rtt_last_tsecr);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, delivered_ecn_bytes);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, pkts_acked_ewma);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, first_tx_mstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, delivered_mstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_acked);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index deced87f31f8..7535de493d43 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -704,6 +704,10 @@ static void tcp_count_delivered(struct tcp_sock *tp, u32 delivered,
 		tcp_count_delivered_ce(tp, delivered);
 }
 
+#define PKTS_ACKED_WEIGHT	6
+#define PKTS_ACKED_PREC		6
+#define ACK_COMP_THRESH		4
+
 /* Returns the ECN CE delta */
 static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 				u32 delivered_pkts, u32 delivered_bytes,
@@ -723,6 +727,19 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
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
@@ -771,7 +788,8 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
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


