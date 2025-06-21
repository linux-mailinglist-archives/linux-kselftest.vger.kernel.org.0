Return-Path: <linux-kselftest+bounces-35566-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E41C3AE2BD1
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 21:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A85517A7D4
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 19:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C21C270EAA;
	Sat, 21 Jun 2025 19:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="eKJYiNEt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011007.outbound.protection.outlook.com [40.107.130.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5715273D97;
	Sat, 21 Jun 2025 19:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750534700; cv=fail; b=UH1UzSeK4RsL/BKJrsBHpj6iEW32KQKkiB+6aZ5M8hQZ7GSjDipRY1D2QPHZuZDpx53skxtEnR6yh2+k6rqoG5uYDXINhCqJMvG77pxuilsOmZV7BY2rdKVenO7l7VU8XrxBNvR66vyvToaDTicOvSajrp5upmRigyZPd7R/ago=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750534700; c=relaxed/simple;
	bh=JkmZAvUq++61D1uaDoZK6iRlvjpWBQIT5GQXAwp4Sco=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DE9WgZpnhwZibHMzz/WvCNgh/aQJfphzK0voVi/WQnZevk/mAfGO6Y6hK6ZgSmVMOjmlpYNPmsLUalTagaF6YvGTMb3T7gsBXRnmwONvzJVQpmitMffQ1GKhcjxCptMtfKdgCX/cCX1uBN/mGRx7HCcF3edKwEhE29lMhAKDwEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=eKJYiNEt; arc=fail smtp.client-ip=40.107.130.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bqKLYN+JOcCjledWx9uAmwmtVSc1YvJ9DrpRwXM2WrDvTmijEnmfiLCvdMG6VIONf0Y5VEZoSmVIaHH9d+8yP5zzU/zP5PbYG3OmyusBCXCTfvwUzOVrqdsS0KyozyBa0XOQ6wpUhP31Je5JABM8dje03NLloaGzOtT7KKZn9z/w03HrIdC47KEeaJCy0r0cRedmhs12FZ/aYFkgaTgbnS2fTclRGPZ/4iWGUWrriow2I1L2SpE9FHsvjZ8kItBlNxjGwt4IeYScWZkyNnj/UDpESAWHM2Ujgp3B9eGASM2MZ4jdY1T8EJN/tDhI2eQTFTkFQV7M9TPsDBijZTFEig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gudIFBX2QHLEfDSGvQ5yDC71sv4vgvJlbGD1Q5xssVg=;
 b=bgMKlSObkGm97u2soaNrAyBz7dZ1816Et6/NewFbLZNKeqHL837v3iFh5y3k1DI/ugGCUqHanq14vslzWq8+pFhHS4+izjhXlQKwyxD2jpphvFiNsi43/XuO2G6XzGrYiIW1mtaCkgFh6aS+izOqVq7XPL5tmTh7NZT3argJOVe2SiVe8oWxzVAn7uIgo8l6yEW4+ltUdzzhGWg4WjndU7Grx2/H6/EwxqDzOx2qbLiH5yinED9itQbug0k7dvUqQCj2Z8l1QAXdngnENEMTTZ/UYMoYrolWK9A/6VweMFlzMEnSYEYPnotUTz77c/wHqQEuTpW3oi1XrGKEub7c7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gudIFBX2QHLEfDSGvQ5yDC71sv4vgvJlbGD1Q5xssVg=;
 b=eKJYiNEtEJ3NTquZr7ZuxpzYKxmc1TnmhBwQCzIQ8ftdbXGwRYZYziVa94hFmnfYg9cEhbyvtq+bx3QyxNckZg43BeGf+r5ovrZVbPAG/yb/nceUQ2Dptb/FcIzz+oQbTHa7vP7YrrzYJCfH/+eQ8Jcu1C6K2Sski9Hk83foXW7vu5WhV4i+QT3ij03gzzUkxPa78aFQ4d0qYH51cIaF/G+KubxNUIo9Frc/DA4pMxHK+Y2Fv/M2E+YuHTpRc8hl70sU7puggPitDnhsHJIds4o5tM9tZhJ+/7btoDtSXroCeipkt8OTQFV5rcyTAHvCPE4P3OBRa21Z6DpXRaXLew==
Received: from CWLP265CA0314.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:57::14)
 by FRWPR07MB10254.eurprd07.prod.outlook.com (2603:10a6:d10:19c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Sat, 21 Jun
 2025 19:38:11 +0000
Received: from AM3PEPF0000A78F.eurprd04.prod.outlook.com
 (2603:10a6:401:57:cafe::5d) by CWLP265CA0314.outlook.office365.com
 (2603:10a6:401:57::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.27 via Frontend Transport; Sat,
 21 Jun 2025 19:38:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM3PEPF0000A78F.mail.protection.outlook.com (10.167.16.118) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.21
 via Frontend Transport; Sat, 21 Jun 2025 19:38:11 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id DE09E1C0031;
	Sat, 21 Jun 2025 22:38:09 +0300 (EEST)
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
Subject: [PATCH v9 net-next 15/15] tcp: try to avoid safer when ACKs are thinned
Date: Sat, 21 Jun 2025 21:37:37 +0200
Message-Id: <20250621193737.16593-16-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250621193737.16593-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250621193737.16593-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A78F:EE_|FRWPR07MB10254:EE_
X-MS-Office365-Filtering-Correlation-Id: eaf3b447-0b3d-4a6b-61b1-08ddb0fb2845
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QzFETWFScFR4TGtzSCtBeWtKaWJJOXJkZmNaSHA4anMrT3J0U0dyenhHbzFa?=
 =?utf-8?B?dGx1Ni93NFU4azd0YTNMbDVJQlpsL0E2czNaZHAxWHpkNjljZkdTeWJRSitz?=
 =?utf-8?B?ZGJ5UmpyTVE3ZVJ6Vi9DYjhGYkNsR25kdThYSkk4aUk5SlJFSXZNeGdqUDBI?=
 =?utf-8?B?UGRMb0R2SlUzalh3SEhhMlpCRmNyN2NqVW1wZG4rNFVxeE1YRW02a3NMcUQ0?=
 =?utf-8?B?dFgzSk1kWXlsalR0bDhCZlNZdWFIOW8zRDdsYm9VYnliRFRpd1RLeFh5UFlF?=
 =?utf-8?B?RGpncDRBckEwbUx2TlBEVTU0VnlwMnhncmw4YzBZa3RwV3pDNmV0WlQvTnRU?=
 =?utf-8?B?RloweVRxVjAwRVJKWkxCZTd0eFJmUUNITlR3MmdQUGhLd0k2SWtiZkNYY08r?=
 =?utf-8?B?NzdRdm9XWFdwSm5TMnBpY3pRWnhsRHRabUdtQnpXMGlMb2tBNmZMeU9oQ1Jq?=
 =?utf-8?B?WDA3UkNnMm83akh3V09LOUpKemRsQUs1QlhONTlSd0drMzV6dzFvOUdLSkRX?=
 =?utf-8?B?a21XaFdmRTNWcWpmdlhqSTNOVkZrZS9xS3hUbC9wcVZ2aGFEZ0RNZzViNU9W?=
 =?utf-8?B?V3NvSVZoVUt0ZXo0SkxuQTIybWlDUmdxNm9IN2NqNUE4ejV1VnBRTUhVeXhL?=
 =?utf-8?B?ZUhnWExZYzl4VTl5RGR4akRmUEhjK3RoK1JxR2VQeUNidnpoVWJENll1bzNh?=
 =?utf-8?B?eGZveXI5RnJrbUdIRGdwRUs2REpySU0zaXVoa2RNSkw2aStuRTQ3amE5bEc4?=
 =?utf-8?B?L0tDNWFFTnN6WGhHUWZhakVjWll3bk5FSjdPL3VucldFckM2eEMwVFRKWWNy?=
 =?utf-8?B?aU5ncElWdkd3amo5MnRJdTNmS2JCZVFIYy80MnhOeWJEZUZMandGOXNOTktv?=
 =?utf-8?B?YnNsbFNxT2l6MXhPY2RzVkliUWU5aXhsSXNKRlV3MjlxeERQS2wySDBDZGZt?=
 =?utf-8?B?QXpienhCQjBsS2REWmtYWDZmcDlaeUcyUjR2THpybi9HK1hBaFZYZk14VjR5?=
 =?utf-8?B?RTV0VnZhVmxKTk1pb1ovL3NXbEFuekpNQXp0OEw4VmoxckVCd2JadlE0OUNu?=
 =?utf-8?B?UkZqZkFoWjVpWWZOakVTcmtGRHVGMWNhWmdsZ1FGTVRWZTk0QzhnY0YvNDg4?=
 =?utf-8?B?MVlibkhqaFIreENpMnFYdExvRkh3eWRpa2N0N0tVMHJGOU9oY2hUSlBNNTd2?=
 =?utf-8?B?YzAveWZFTzhNK3hmbjB3dnlGZlRDVjVLOFRZZjQ2NVBPeFZydzRyeFlRSmU2?=
 =?utf-8?B?Qlc4ajB0U0puZ1hHeDhzNndhWmdHVzQrRXJVWjMwZ1IrWitiWnhzcjNQazgr?=
 =?utf-8?B?akhjelhWSjZmSFZGaGlOZU9ZTUFXb2xKSnpvczJlaXJ4WURlQ015T3prUXN0?=
 =?utf-8?B?K3h1eHNIeGpLbE1Oak9Za25yOVZ5YkUxOE5PZnFYZCtjS3d6bTgwa3ZWc2Y3?=
 =?utf-8?B?M2twenE0OXRVRGJ2MTFvM1JRL2RzeWN4ZG5oNFBPNmZPZmRxMGNsWXJUemt5?=
 =?utf-8?B?WFVDY1FlUmxoVk0wZXVkT012aWRmdVo5Q1JaUlM0NmROdWh2SnIrOUdIcU9w?=
 =?utf-8?B?bkVCSkJBTDZxOUgxR0d0ZHpuTy9HK0RmRDJQSzRJMmhrYTVFb1JaL0QwSlp5?=
 =?utf-8?B?R2dhNjdHVFJBS3lzaFNlb1lNc3dQS2JTaVV1REFEUURhRTArdlJmYXVGL1ph?=
 =?utf-8?B?cjRuZDQyQTV2SkZ6OXhKaHdQZ0hzd3ZpbjFodlFVNVlLSDgzSnVJSmJGZE9I?=
 =?utf-8?B?RjErNGd3RkV6WEVkZFJFbVFJOU5GNFVaT091Vmt6NW5uSmJ5ZmI0SmZjMElM?=
 =?utf-8?B?WkU3LzhNQUVqc1lyTUI1RGs5SXNOdUQ0c0FPVkU4Y2RNaDI0aXdseWcwaTZv?=
 =?utf-8?B?QnlhaUFFVDFzTTJyY3ZnQWRqNlVpTHRRa3ZaUVF6YnprdmlrbUhDdkZIc3Fl?=
 =?utf-8?B?UmVGNjQ4eE8rZFJHRHpBc1ZEeWo0bkZ6SzlzdEtrSXVBR3FHNE5WQlJ4djFh?=
 =?utf-8?B?TFFjVmFDaUtzMkJKdjFmdVNUQnFEd2FmRWRUNkE0QTd2SVpwTlpiWWg0QXdO?=
 =?utf-8?B?NDdSMjRRZk1EOFpKak4rMExXR3hXcmREYzR0Zz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2025 19:38:11.4715
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eaf3b447-0b3d-4a6b-61b1-08ddb0fb2845
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A78F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR07MB10254

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
index 88c668f9c68b..f431ff1eb932 100644
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
index 8609fb138108..c3b9ecc3f2e2 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -345,6 +345,7 @@ struct tcp_sock {
 	u32	rate_interval_us;  /* saved rate sample: time elapsed */
 	u32	rcv_rtt_last_tsecr;
 	u32	delivered_ecn_bytes[3];
+	u16	pkts_acked_ewma;/* Pkts acked EWMA for AccECN cep heuristic */
 	u64	first_tx_mstamp;  /* start of window send phase */
 	u64	delivered_mstamp; /* time we reached "delivered" */
 	u64	bytes_acked;	/* RFC4898 tcpEStatsAppHCThruOctetsAcked
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index a9e30c72d71b..40fdfba1c04a 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3399,6 +3399,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tcp_accecn_init_counters(tp);
 	tp->prev_ecnfield = 0;
 	tp->accecn_opt_tstamp = 0;
+	tp->pkts_acked_ewma = 0;
 	if (icsk->icsk_ca_initialized && icsk->icsk_ca_ops->release)
 		icsk->icsk_ca_ops->release(sk);
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
@@ -5159,6 +5160,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rate_interval_us);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcv_rtt_last_tsecr);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, delivered_ecn_bytes);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, pkts_acked_ewma);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, first_tx_mstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, delivered_mstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_acked);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 97b5fe52d8fd..f15ebee4a641 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -714,6 +714,10 @@ static void tcp_count_delivered(struct tcp_sock *tp, u32 delivered,
 		tcp_count_delivered_ce(tp, delivered);
 }
 
+#define PKTS_ACKED_WEIGHT	6
+#define PKTS_ACKED_PREC		6
+#define ACK_COMP_THRESH		4
+
 /* Returns the ECN CE delta */
 static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 				u32 delivered_pkts, u32 delivered_bytes,
@@ -733,6 +737,19 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
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
@@ -781,7 +798,8 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
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


