Return-Path: <linux-kselftest+bounces-42521-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9590BA5AFE
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 10:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBE65189FD5E
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 08:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041492D661A;
	Sat, 27 Sep 2025 08:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="EyMZ79pH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011043.outbound.protection.outlook.com [40.107.130.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A3D28505C;
	Sat, 27 Sep 2025 08:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758962898; cv=fail; b=GbxqKuMwwyOPn748jzp5YdTSGVO6Kk3DOb1x7RreBHbHTe+iIgM+1y9zLTrPsOKiPb2zah6AO0eE3nFn4246rbUi/GJq/OM0Y0jysG7dDVtg0jhHlu/iTZ0OWDChGKhezLMkvfwvXiI1FwEkviiMK3H+coBrZFMHUefkkAQ4dyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758962898; c=relaxed/simple;
	bh=NNyP7JF4jDC8jLo+9Zghsrs/R5Zz1LR9LU8L3A8GG3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hjU+0ZUsxa1OQmtHbe3oa/Fbz1+aGyn9BlLYx9WrCJMq1F4abIMXFFAamMA19K+iJnHyV/0RBQOtlRrgKcQPLuUiD1KSEpDR6OmZCpviMEwK5isgB1CWWBIIa7HtFvsFHZGCaA/ccaskVW6fgiKHhYeHvDaWK9ApuWkzMbaGWIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=EyMZ79pH; arc=fail smtp.client-ip=40.107.130.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q6J7JEVAv2poQVm6jJZ4aqlRZfoOkg4B4Bl7IlAWDpoEKO45l9QBK2NTf158ccu3qSIFy9zdcOUGmpvC06b1GuUDC720UWNynqsAaAvYbdIwqaK/9EdFSq/7AcEf/BiN5+YRd9KdF47ANmoekc86ECP2bNJiwi+mlrMiwsJTMA5nOvkvSNddKnbkcKXUUScw3WemJe2j8wTYXfSOpzCZMWoq5tHUz3tZmghCgfcy1hSJAymSZAv8gOu874BT1goDJdTZZGLufV1KZliyMJjUOtmiL4wp74BFBlUvMbOxoCdBK7XwYNCi/bldO2ddyxbyVPf5+R399+B3d0S+YUU8QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3FbJpi4+uguHGa+sIUteEXFdqB733jfEf2mQI/kwlHo=;
 b=R/zet4gf/QVuCjpek1cE66Nn33TMaeMMI2PUmiU2ImOqg8ybfFpn7CpQxRaT1kfpf9k8GrZssMwfy3LwLDy+deKUj3K+MvbNmICZfk+cAzMtLSlH3zmUAFrHo9rV5bTX9QiQkrZsntdjqM49sf/ExdHt8ubhDg0yXxHq1bG7ONF8/2BekWVp+W4NeDRjfoqzpNRYZIiMyn+acKTyh6n7aKVmCa7zA3UXGKpi28k7yUH9soxMelreyIOSe2BVAvct4AM+bGZT94Oekv9hZCtWGk7FI9GA82RK9uDYgOQnyGwfDZuuamb2WrIgzvBc6FJhYBDBCGmeDYEdOsfL/xFS/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FbJpi4+uguHGa+sIUteEXFdqB733jfEf2mQI/kwlHo=;
 b=EyMZ79pHlk4RLJIuupBshbtFGvNCwxwJ0r9CJ+U0jvHXkDyhJeVJx9u219iaD4S/praQ3z25dqBfjS9KOcNza4k3N+/m5uPHbMIkCyeoX5REYjMBl7AlT+0Aemna0060AehxdT6k9IEg4YbMrc+px+k/Ha8XoG5bjVHiLcDov/6IjmZTRCReqC8Zcz5CzABJCufBFBPka81dwGFzho0KII/lrHm+hUsglhsBkDkdDDR21JMFsKelhxwWYvSGPZoaXIVuEnScT3w6YUEvkliOtNHclEVEIr06T9FrbERHBnzobEvKsYV+hela9u6ebDxmEYN5X+NqHCDEtm1MFqujZg==
Received: from DB8PR03CA0008.eurprd03.prod.outlook.com (2603:10a6:10:be::21)
 by AMDPR07MB11191.eurprd07.prod.outlook.com (2603:10a6:20b:71d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Sat, 27 Sep
 2025 08:48:11 +0000
Received: from DB5PEPF00014B9F.eurprd02.prod.outlook.com
 (2603:10a6:10:be:cafe::4e) by DB8PR03CA0008.outlook.office365.com
 (2603:10a6:10:be::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.14 via Frontend Transport; Sat,
 27 Sep 2025 08:48:10 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.2.240) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DB5PEPF00014B9F.mail.protection.outlook.com (10.167.8.169) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.9
 via Frontend Transport; Sat, 27 Sep 2025 08:48:08 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 6D34E20107;
	Sat, 27 Sep 2025 11:48:07 +0300 (EEST)
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
Subject: [PATCH v3 net-next 01/12] tcp: try to avoid safer when ACKs are thinned
Date: Sat, 27 Sep 2025 10:47:52 +0200
Message-Id: <20250927084803.17784-2-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250927084803.17784-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250927084803.17784-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9F:EE_|AMDPR07MB11191:EE_
X-MS-Office365-Filtering-Correlation-Id: bf4f1d78-d1db-4587-2986-08ddfda2956a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDQ0WG40Qi9JanI2UFZTdTlNNVpZZ0JpUlFvMkJ0L243dzJrTy9BM2UvMEJH?=
 =?utf-8?B?Q3VrcU80VXlJQnVlb05HUk53dEg2T2phVVZ4RW1mbkJhVS9rMUswVjBRV3F1?=
 =?utf-8?B?aDlLVkg3a0M5NmppMHh4NDkvbmk3OVNHSGZKdUVEdFJ1ajlQWkQxb2VndVVT?=
 =?utf-8?B?YTJNZytlWXVOeEtlV3ZKT2hhSlZSWWMvdkxKWlQ4ODJ5SUhOVmd6VWV2Wkpq?=
 =?utf-8?B?SkdNdTZQTm9weVJEOXg2cDdnb0pxYzNEMkZCbGRrTjZibmk1bXNad3NvS0cv?=
 =?utf-8?B?TVV1aWJjOXRZKzdhSWtKZjRKYmFjNjlvNWpQb01HMGJ5OFJ5R3lkM3pVZ09h?=
 =?utf-8?B?NmU1Q09BeEhBY0dhMCtCK2Rzd3RlUlhKOVBDOWdQT2N1MFRJK1dMUW8yd2tQ?=
 =?utf-8?B?MW1MOGN0U2pxeng1QmFWdXNJWXJIeGZBanVPdmk2RHlHc0o2ak9JZXBDdHlO?=
 =?utf-8?B?S1h6RElpc0V4QW0yMUg0cnozYUhVb3N2RVZ6T1plWE9tcWRGT1BZWVVHVHVP?=
 =?utf-8?B?ZXl4amd3Zm5hT3lteGIvRStJczlRZDZHVzZibm56MXFPNm1lWjg5ejNEYU1Z?=
 =?utf-8?B?L3oxNXM2bGZ3RVEwRHFEOTZxSGdKMzREZGlyeEJmalI3QzhhazNiM2lSZEpW?=
 =?utf-8?B?Z1ZlZVNXaDc2cU93MEp6a3lGaUxEbDA3UWFNVVRZNUlEdkR0NTdhcmFtcEdS?=
 =?utf-8?B?UCt0MGh2TWRYOGZJa2VoWmExa0ZsUW5pbUZvT2d0SEdGV05ROFZXQ0prM2o2?=
 =?utf-8?B?ZHRkM0Fpc2hLbnN2b0k0ZmJrZFovNUY3UmJCQTlKVEc0NW4vWjFRajZ3dmNk?=
 =?utf-8?B?c3l0MkpQTmFxcTBudm9IL01SN3FXckJQNjlEVTA1SkFmK0kweXZjeGlqdzlj?=
 =?utf-8?B?azBJSUI1Y3FTZWJqRmxSUDNaK1RreHRFY1YwMzcvYTBUT0VFQ3dEbHUzTFBk?=
 =?utf-8?B?QTVBVnBHMkwvOVNTOHRzd3hMY3dCajIyUVFQSFF2cHNERktkeGU5aU9wWVJL?=
 =?utf-8?B?YVVtVS9jd0xDRlc1b3k0L1VmL3BBK2dQaGFSM3FoZ0cyOWEyMUc0MjdibFV5?=
 =?utf-8?B?OCtQbndaZlhMb1NwcUg0aHlraW8xL0pIbWt6L0hCektzMHpnZDFYSUcvVzh0?=
 =?utf-8?B?WUdwYnk5cW53KzM3aGNOSFJ1MmpTSTBveHBFQXNvWUgrT3BseCtHc2RtTHlp?=
 =?utf-8?B?NmRmZDI3WVFVQVZkd3JQc0NBc3JGTlRNNDJ5U01Oa3JUYzlNU2NvQzAzR0xz?=
 =?utf-8?B?VEhWYnM1bkM0M2g5cTllVUx3cnVvaWs0cVhMRkoxTUN0R0NFdXBpazNtUjJF?=
 =?utf-8?B?L25XWStZMzhwdkhlMkY1VWxzZ2RzaUd2bUJweFlrSldzYzFFbnFENnAyTkcv?=
 =?utf-8?B?bWlwd0tuSjdlNUF1TlZDTUlFdHhrbkRNRUN6b0dXWUExbE94RllXOGpyeVdG?=
 =?utf-8?B?QmRkRjVhY3FOWDlYYldQb3NBTm1Scmt6aHJ3T21YSDc5YlVzaUppOVRwQmdT?=
 =?utf-8?B?YW1zeWlGRHdiNHRPZEEzTVE4ZXJWbWR5dXRKVHFGTWs3dWpQcnhlRldnWEJk?=
 =?utf-8?B?cUdnaXE3YzBiL2hnVzJwaWNRZmRWdDdVUWhOaE5ka0h4UUh4YjVMREk2bnVZ?=
 =?utf-8?B?a3Bkbi9ncXZESitubGx1QWh0N1FvajNpN0lOaHBpY09iZ0lmYlZuWHV5TGJh?=
 =?utf-8?B?anZoQ2pRWGxQWi9XVU1ndDNqSjlYNEhLazNNb0FCaTBMdWt5TWxkaDNlK0sr?=
 =?utf-8?B?S2tVS08vQ2N3Y2IxbXd2dGxNVGlTMGo1c2k5Yk5hVE5wb0tWNFJnL2p5amRF?=
 =?utf-8?B?bFk4WVdSUVFJTWgzUVBSaXFWclBaYnJjWS9mRmw4eVN3Z29BTlUvd0pVOUFJ?=
 =?utf-8?B?VDJBUlk5KzlsK0Mza0Q1dUFzUStPRVNxZUh3MlZoODlNY3dBQkZWTTZwakVZ?=
 =?utf-8?B?dVlHZ1d5cm1XZ0JEV0oxUlc5ZkI3YlpaQWIva29oRlo5Ri9oMElOa2FleE90?=
 =?utf-8?B?alk1UHpBUDVzcVpsSTF4OTBLRGY0Z2NwUE0yTFZueUZHWUFOUW5ZTnl5Nk1w?=
 =?utf-8?B?d2FiWHVrNlJxU1phc2daN1MwcnlWOWlGT1hPSGtNT3dHMWRsMnQ3QkxHaTFt?=
 =?utf-8?Q?GUpoKanR5RAMSkrDpp8tvunIg?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2025 08:48:08.8914
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf4f1d78-d1db-4587-2986-08ddfda2956a
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB5PEPF00014B9F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR07MB11191

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
v3:
- Add additional min() check if pkts_acked_ewma is not initialized.
---
 .../networking/net_cachelines/tcp_sock.rst    |  1 +
 include/linux/tcp.h                           |  1 +
 net/ipv4/tcp.c                                |  2 ++
 net/ipv4/tcp_input.c                          | 20 ++++++++++++++++++-
 4 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index 26f32dbcf6ec..563daea10d6c 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -105,6 +105,7 @@ u32                           received_ce             read_mostly         read_w
 u32[3]                        received_ecn_bytes      read_mostly         read_write
 u8:4                          received_ce_pending     read_mostly         read_write
 u32[3]                        delivered_ecn_bytes                         read_write
+u16                           pkts_acked_ewma                             read_write
 u8:2                          syn_ect_snt             write_mostly        read_write
 u8:2                          syn_ect_rcv             read_mostly         read_write
 u8:2                          accecn_minlen           write_mostly        read_write
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 20b8c6e21fef..683f38362977 100644
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
index 7949d16506a4..eaeb748cfd6f 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3416,6 +3416,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tcp_accecn_init_counters(tp);
 	tp->prev_ecnfield = 0;
 	tp->accecn_opt_tstamp = 0;
+	tp->pkts_acked_ewma = 0;
 	if (icsk->icsk_ca_initialized && icsk->icsk_ca_ops->release)
 		icsk->icsk_ca_ops->release(sk);
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
@@ -5177,6 +5178,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rate_interval_us);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcv_rtt_last_tsecr);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, delivered_ecn_bytes);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, pkts_acked_ewma);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, first_tx_mstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, delivered_mstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_acked);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 79d5252ed6cc..858ea87a32b7 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -488,6 +488,10 @@ static void tcp_count_delivered(struct tcp_sock *tp, u32 delivered,
 		tcp_count_delivered_ce(tp, delivered);
 }
 
+#define PKTS_ACKED_WEIGHT	6
+#define PKTS_ACKED_PREC		6
+#define ACK_COMP_THRESH		4
+
 /* Returns the ECN CE delta */
 static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 				u32 delivered_pkts, u32 delivered_bytes,
@@ -499,6 +503,7 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 	u32 delta, safe_delta, d_ceb;
 	bool opt_deltas_valid;
 	u32 corrected_ace;
+	u32 ewma;
 
 	/* Reordered ACK or uncertain due to lack of data to send and ts */
 	if (!(flag & (FLAG_FORWARD_PROGRESS | FLAG_TS_PROGRESS)))
@@ -507,6 +512,18 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 	opt_deltas_valid = tcp_accecn_process_option(tp, skb,
 						     delivered_bytes, flag);
 
+	if (delivered_pkts) {
+		if (!tp->pkts_acked_ewma) {
+			ewma = delivered_pkts << PKTS_ACKED_PREC;
+		} else {
+			ewma = tp->pkts_acked_ewma;
+			ewma = (((ewma << PKTS_ACKED_WEIGHT) - ewma) +
+				(delivered_pkts << PKTS_ACKED_PREC)) >>
+				PKTS_ACKED_WEIGHT;
+		}
+		tp->pkts_acked_ewma = min_t(u32, ewma, 0xFFFFU);
+	}
+
 	if (!(flag & FLAG_SLOWPATH)) {
 		/* AccECN counter might overflow on large ACKs */
 		if (delivered_pkts <= TCP_ACCECN_CEP_ACE_MASK)
@@ -555,7 +572,8 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
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


