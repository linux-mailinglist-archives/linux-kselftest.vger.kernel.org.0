Return-Path: <linux-kselftest+bounces-46816-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3F5C9849F
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 17:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AD7234E26EA
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 16:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3F9335561;
	Mon,  1 Dec 2025 16:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="gcOMNBL7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013043.outbound.protection.outlook.com [52.101.72.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D542F616B;
	Mon,  1 Dec 2025 16:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764607110; cv=fail; b=Eg6kB8WInXR+jZhqCYZk2tbj22GuV+0ZBEn4CKOT8yFtYzExvnpWh73H7POHbHS5e+pNSIVXNYh/uVZ1XgBnfSNDf2CUUTBZTNHZMNyMdOaw0bQY2yApcTBcEk0LvjdLpPqOg1rLVPCdAwJvpnDHT4UYhxL7+ZWR66bIUr3JJVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764607110; c=relaxed/simple;
	bh=WAKU0kvy3ZF5Mj8iz45FyNQcw7gu4ZyVU4VeIRtHXJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=To21QmXVHhE33Ek3GAX4vcveoCWSgO7vYuV/P6eFMLrL4DxapnzYrDk33R4a/F9iNybNiOOg9nC/T3Hkg1cMW67V8/l30QGhjbe91OpB/w8fbM+gPzO85c9SVUd/30nPgTPB/7QStuM5/uljgyipAWlYaDijyhejS3Ll9EVZ0tY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=gcOMNBL7; arc=fail smtp.client-ip=52.101.72.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ji/5tVKPPFc5P0qjH6oOU8mi6IazVl4U+PGWuyXh3whKkPpinTHzZ6/S/Tr/fP/A3wH60qNuXC8n273/vPf+BsZzyfWsa5XXJ7ZWA39/sMaJw0X0f21zWDRFM3cAMN9DsnqQNSKito9i1ULsRcSrSDFj9i7wWYkOyPRJ2hRPIDx6bs6atJ0LTWuOv0NORrcNIzcC47WnOgaeXHbVzeF+PE1ziklcG/es030HAEnilMssdQyj+9Pz50fWWWkrFe6mTXIdXCiaF5zruaO890vsmx94WcfoK7hHV6GhBSA1c5cKqoPcxjYhUQgGUxkxznQai1I4aZFlg6HkYyyTzHA9Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ne3qs/zGP6BVjX5gcf0zk2hQAjKSiY2XXy4NASEemw0=;
 b=vIJA3DvPE2RHIKBAN7kViSPV+uane5vxo9sZmC7QDJcrE1ycuWnIvzsd65+OXhe2a6izJl0usuEefS5kf/4v/r+j2kMQd+RtZcX54L7Bm/WFag+I31YngIxKVerjLxo19EAu+bJRUQr7/RCum7zz2WNabnLFjG366+XZahSGmHKeEgVLHzNYt33R4r0fh9IdI90xJ0ueXYdmFXRCIjDctfcKQXNzaPWaIe6OKaO0C4uxjkO488cZt6Z2xG2eAGGFpJmf4JBxpQpPkGrDcEGcX1z71mRWJfiMqEsnkeH403CLvZtSgfRvpqK73qaIsHHX3/OaCHnVQXcLJZAnApEE1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ne3qs/zGP6BVjX5gcf0zk2hQAjKSiY2XXy4NASEemw0=;
 b=gcOMNBL7t5vqjiTGYqRcu5GVdkiE8ZK9ttOlb28c26Olz1pUO6olzGWYV9u1BcUfJVsSSUvtDdEb9Xg4Dc3unILf4FzYwTtoNSrZD2BtNrgAlryLyktJJLw4zhcJrLiZ/EtJyQ+nbzpWTUMKrGYnTRkB0ys3xBcgJgsJPT0Hr2z4e5E4PhWrZk/Eurr9keC5R0C02lUeuhLXv1+dux6YQuwQ7oUMPFvC/1dkapI0LXNc281EkfWRkcy+ex78MAtf6DaTCb8jDTL07FKNttrmxO52ybXxBZZnhyWsZ2x+lKu/bQLSTSZ+sGu47AjZqk8XHYEsu6TaD0/rqj/21EgKjA==
Received: from AM0PR10CA0052.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::32)
 by DB9PR07MB10812.eurprd07.prod.outlook.com (2603:10a6:10:5de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 16:38:19 +0000
Received: from AM3PEPF00009B9F.eurprd04.prod.outlook.com
 (2603:10a6:20b:150:cafe::13) by AM0PR10CA0052.outlook.office365.com
 (2603:10a6:20b:150::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 16:37:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AM3PEPF00009B9F.mail.protection.outlook.com (10.167.16.24) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.8
 via Frontend Transport; Mon, 1 Dec 2025 16:38:19 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (Postfix) with ESMTP id 031E568004F;
	Mon,  1 Dec 2025 18:38:17 +0200 (EET)
From: chia-yu.chang@nokia-bell-labs.com
To: pabeni@redhat.com,
	edumazet@google.com,
	parav@nvidia.com,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	horms@kernel.org,
	dsahern@kernel.org,
	kuniyu@google.com,
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
Subject: [PATCH v7 net-next 01/13] tcp: try to avoid safer when ACKs are thinned
Date: Mon,  1 Dec 2025 17:37:48 +0100
Message-Id: <20251201163800.3965-2-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251201163800.3965-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251201163800.3965-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9F:EE_|DB9PR07MB10812:EE_
X-MS-Office365-Filtering-Correlation-Id: 46506e62-45c1-4d60-e8fa-08de30f80918
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?VXYyTEJYeG1HT0RhSEZaOHJ1cDFhV0g0MDRzVlcrWWRPU3pzam5BRCtydE94?=
 =?utf-8?B?SVNEbHpNbXpZMStVVStOM1hPRDRQMjRUdjRNT1JwR2NjMmtaSkJHLzNGMFQ4?=
 =?utf-8?B?dy9wZjV5NjAwamdRaVhYeHZsaUNQcTYzK2xLUENRVHN6MzMrV0RmL2w3dWN3?=
 =?utf-8?B?bWNzWEo3U3hRai9KeHlFMERrdUFqVTMrRkFvdm1HRXptbDN4Q1FqZndka2dY?=
 =?utf-8?B?NXNDUHVHT3IwY3lHakYxL3lzQ3NKbXdwVmxrQ2UvRDl0cXVmVlFOQ3VuZ2dp?=
 =?utf-8?B?eWtIeGRIcmxRMlZhQXdoZFpsak9KcmtHcnZTR2lubkVoOWdyTnRLeXVyRUFH?=
 =?utf-8?B?YUNPNFdTekd2N255ZVE1K1pYYnlDNXNGNldpVlphRERycFVoTkluMEFocHlN?=
 =?utf-8?B?aXlSWnZ5TUNMYi9LV2hFVW5wZXk2emV1U1ZNeXRHa1JNZXNSdUtCeldOdjhF?=
 =?utf-8?B?eTNOcjNSeFQ3blZvTkt6MEptQW9jWlF3RFI4Kzg3RjNURlp3cUhWREpRN0VM?=
 =?utf-8?B?N2Nvam83NWxGUjk5YnBEVFZ5YmlxbjREQjN3eklKRUM5TzNjaUtsMWNNUHUw?=
 =?utf-8?B?OXVYVHoxc1hIaHczUENUUnpSTytZV3NXRFZLZDNhcGN0TjdyVFdFWlhPM2Ro?=
 =?utf-8?B?UmNYSjh5YVhSQVBXOCtVbnlVWjl2K0g5czFHcGpVWjJ5ZkNjV3dhZkhCNjAw?=
 =?utf-8?B?MXp1QlRudXJZUlV4QzlhaTByY0JvSFZaT1lnK05Za0hDS3kzOE9xL2FWb2d3?=
 =?utf-8?B?eTJKTXByKzM2Q05RVytDWlRxakw0aUF1ZlBiSUJEZmNWMnAybGVMV0ZiVXN4?=
 =?utf-8?B?OWVwTHZrOGNkMkJGK25HZXVFRkpWUmNZRTI0WWFWRmpDZktMVmRub1NwQ1N4?=
 =?utf-8?B?S0FGdFdwMXBKQlBTdWxPOTVMRGVSR2J1QmpISDBXTkJubVBZcFAzay9vM1dl?=
 =?utf-8?B?TklwcUgvNmFBbFpCVVZIQkVacysvaGNvVUtEeDJ2WEIwdGkwT1BOUFZ3VUk1?=
 =?utf-8?B?TXdTMys4d2Z1WC8vcUZnWndhWWdMVkZvRmsvN1JuelBsZEVoWkY4Qjc3bktp?=
 =?utf-8?B?SXB1U1VMNUo1WnVJbjFON3hoWkg2ZEpaeDFjS3hwMk8zekVmWWVHM1VDMGdB?=
 =?utf-8?B?eHlRdzM1Um50WEtNY3hyRGlvdWR6RDlvaXA4ZVNJZFZyN1pXQVo5bVVtYi9H?=
 =?utf-8?B?VFRJcEM2MDNlemxGNzlPNkE5VDlDWVZIL09kZTNzL2tBQjFJTWlMclYwSzNG?=
 =?utf-8?B?RzZ5WTJ4WTRSRnVjTzNyK0craENFeVltL0Q0RW1TQXdTMnI5RW1tSVJEWXRh?=
 =?utf-8?B?NG9WbU9FWDBBUTJmNGNCUnV1L042Q3pUMjYxZWVhTUJkdWpoM1JWZVhHUWtF?=
 =?utf-8?B?ODA3STJvbUNEZVZ4TGNFVnhRSFVnNUsweGkxYWhWdlloQjVGcnhXT0MwRkdn?=
 =?utf-8?B?NlVFdWE4dzdjcy9PTWFtUmFLZyt2SGpUQXRaOVBrNElDNERWMGQ4VjBCNlk5?=
 =?utf-8?B?TlJSSU1JaUdNTms5akIvOGpIZ3BlZ1dCVklKaVBlYkZsL2QrUlZ2V2w0VktP?=
 =?utf-8?B?bWNIcW1uODR0d202WExsYnJrSFZ6Y2FXTnQzQSt5RVpuVnU0L2ZaYVNaTWs2?=
 =?utf-8?B?M0lhaHZubW5OWDA4K1BUR3JZRGltLzcwUWF3YWJROFcvdVJVY01mSUJhcXVB?=
 =?utf-8?B?REdobUtUQ1crclRPQ2poNCtXUUo2ekJnUkFOQk9vU1h4M1pRc2I2WFRqTGhj?=
 =?utf-8?B?VldGbmJPS21YRlNyanZpU0dGK25YRVI1UlVoemkzczlqVmtqeTd0QTJESGNw?=
 =?utf-8?B?RFNCT25xMmQyZ3RkOXJjWWNnczlaejRta3RnU3ZPby9rRERkbFFLdERwWU9q?=
 =?utf-8?B?TWlVM3FGZnZQSmR6dG9QbGxpajh5VGdRaWE2d1dtazQ5OUl1ZUZ1a29ZeUl6?=
 =?utf-8?B?OUdUSHBFTC80bEpyalJua2xsd0JteEJLNTE3Mk14cUN0YThSQnZhMFBMVmNY?=
 =?utf-8?B?Z3NyT29WYjR4M0paODF6N3VDb2lEK2YzMURUOUpjOEtRa1kyMGMyaUs3YndP?=
 =?utf-8?B?K2Q4a21qWlI1RmIrT2NLN0RJT1JRSDZRV21QMno5WjhLZGViZ3d0Z2JOZmNZ?=
 =?utf-8?Q?GpqTdApgUjMNKChG2TCv3IPYJ?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 16:38:19.5173
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46506e62-45c1-4d60-e8fa-08de30f80918
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM3PEPF00009B9F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB10812

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
Acked-by: Paolo Abeni <pabeni@redhat.com>

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
index f035440c475a..cd25fb50e81b 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3420,6 +3420,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tcp_accecn_init_counters(tp);
 	tp->prev_ecnfield = 0;
 	tp->accecn_opt_tstamp = 0;
+	tp->pkts_acked_ewma = 0;
 	if (icsk->icsk_ca_initialized && icsk->icsk_ca_ops->release)
 		icsk->icsk_ca_ops->release(sk);
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
@@ -5193,6 +5194,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rate_interval_us);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcv_rtt_last_tsecr);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, delivered_ecn_bytes);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, pkts_acked_ewma);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, first_tx_mstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, delivered_mstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_acked);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 198f8a0d37be..8e95a4e302f4 100644
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


