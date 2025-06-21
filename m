Return-Path: <linux-kselftest+bounces-35557-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44726AE2BAA
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 21:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CA73179454
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 19:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6E1271452;
	Sat, 21 Jun 2025 19:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="tJgLccT6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011057.outbound.protection.outlook.com [40.107.130.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1C0271441;
	Sat, 21 Jun 2025 19:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750534682; cv=fail; b=QflEk5Ajw48fWfYXM2KkXwtaHzEUW57IOJNIcJHSNnKjcbm7LIlrDrl0zyf1cfzpmDP9gs9YzICPtyR1ZIUNhKQCPGk8lmgDAka+Gj2kS0xkoCTgbYholS/XPl2PNsLPHUQr4LbhQYEo6UqyWllboExgxD0dqqYfF1l9QPdK32Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750534682; c=relaxed/simple;
	bh=cXDxxqZjYwuUFhfArfwmR8C1PMi46PlQdyemKT2pXiM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nS+RFJLnScyXuOr4CarQFRgGUFQXR8G8eBBbUZXnAEr0UzEA8mmbBNsWB/pwMFXWeC5OrFwRtYgP/Nvs9BNKuC3Betuh6eRz6VUiw+wL6y6lz9pzcpp4pvwGZ8gYzSGM5vT5/cWiryPx4pt1TmTE4HWhDNoH8WJgbuYuDO2gnbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=tJgLccT6; arc=fail smtp.client-ip=40.107.130.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T25/8qBwk28oLALhKPhzPDSNURvu1jkGCRjWM4FNI5C92LQidyEXSjjpZPXtQXRhDXylT2BQxuRaV65rUxGJm+fjQVw/iTROjMTSGbEmu7i9L+BfBg7uoDFPO8FqTcYho78XlnUd4vjRZqfr0jE4yj5G7Dtm4jpVM5BXoZHgxQ6HFd0qJR50uzSO6rjPVIlJFbjCfSJeiAW/wgbmN+ajr7QrMojx352/Y6rfXp1MWyAgbVVzYP7Xk5bFYPSOWEgXy6JTvvWJCINAYOxWx/aaMpVzkbEuqhuH9BvV6IMdmd561HCga8QKKsmx+E3/9LlE9wzadFO5T03CXdPSzBPUXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPOAQU/te96NrkWhNBihknml/Sn+kaOMwRsDqN9Ipb8=;
 b=wjc3DVVqBv0atXSBMXGmBbx/+dlBRGghGOr5GqmgNFtX2ZhNB5BZnY6Qmo6GSFoXqe7Zi6DMeQ5yzkc9Px0u7OPMNhqlbkmH0tZt58luWP61I5lzkxl3d72ePAuQ8rdugKWnFT2CtSq2qr7f63BU0YVMoGK0DqfKF6IWHP2S6t3nqLIzRAsVY9owU7dZvyLiFRNXjUbs4eCaIH8qDObqqt5IH5ZEjshDZQqdCJUf0UQ2EWUxw0KcP+HnoTZy+Adl1Vt6kOuvdduA7wyAis+8tsZt+e59eJdWlhkIcKtW2PyVXqBAktslmkPZv6ahTN0ObYy61gcLGfk1+7qOmqmuyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPOAQU/te96NrkWhNBihknml/Sn+kaOMwRsDqN9Ipb8=;
 b=tJgLccT65A8EBO9lzVgBQ5KZRy4cEXtKWOFaSStemrkp7Onl0d9y6Pk4tt3JOXuQb+Mi8hgrP07gAQuKXQtMO5u0J6rpenMwfGxye8gw3Dj6BU+99oIjwB2Z9v2AyuzXUwe81xvkbcWg+4O+el+Xw4ixqdHlF7rNTzEKJmif/ClxOShgogLK1ZWdf9Wq2o1vsQnhQVmYM40hsmZrV3ftgobeCig8dj/BsljgaNzV7145LTo8D+Y81r7yR02YQWmWXUao0J018fb5QR9SjPIdHUiCfZbduViy4Hg+KYHfVChTea0ZT7MJ41xQW8e6HhmmSoqMg60CwFSgWx8ZGJDkXg==
Received: from DUZPR01CA0004.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::20) by PR3PR07MB6939.eurprd07.prod.outlook.com
 (2603:10a6:102:76::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Sat, 21 Jun
 2025 19:37:55 +0000
Received: from DB1PEPF00050A00.eurprd03.prod.outlook.com
 (2603:10a6:10:3c3:cafe::62) by DUZPR01CA0004.outlook.office365.com
 (2603:10a6:10:3c3::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.27 via Frontend Transport; Sat,
 21 Jun 2025 19:37:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB1PEPF00050A00.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.21
 via Frontend Transport; Sat, 21 Jun 2025 19:37:55 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id ED3741C002B;
	Sat, 21 Jun 2025 22:37:53 +0300 (EEST)
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
Subject: [PATCH v9 net-next 06/15] tcp: accecn: add AccECN rx byte counters
Date: Sat, 21 Jun 2025 21:37:28 +0200
Message-Id: <20250621193737.16593-7-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF00050A00:EE_|PR3PR07MB6939:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f913919-d964-460a-fe5f-08ddb0fb1ec6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RzNuTndvSlN4bHBTVWlhNFRGUWFGdEpoejVneEl6cnhmRndKS1lqd2x4NnRy?=
 =?utf-8?B?ZTZadkVveUNsY2lMUWFqSU45dXVaVkNCNkVUdVNzVk96QUdYUTNacE9HbTZv?=
 =?utf-8?B?Zm9WT3M0UEFQVWZlOUZWcXppNDhuSmVQL3o4NlJHR3VEMDJJYWxoRHBMcHJt?=
 =?utf-8?B?bXBWenpaTUVKT2gwWGw3VmVNY0tOYUNkUDcyZ1VKSnE4N3A0ZTlwU3lMdjJl?=
 =?utf-8?B?L2dpNE94dFlvMEEyZ2FMSUgva2xFYXV3ODlnSjJvSlNwUXlVeXV3UXRSNTdx?=
 =?utf-8?B?dDZJSVdCNStVU3BiRmFxZnltK3FLVFZGV1NCa1NuT01oWlMxVzIzUVJKSnY2?=
 =?utf-8?B?djdzYWdFbjFnMVk1cDJMcjg3OURoQVlmSUNWTXJvVUMrZkpZU1ZuczlyRDlG?=
 =?utf-8?B?WGN1cEVpdGNycHROSWRBL2x5NDRGVmU5cmhhNDhxMEZBN2pVbFNpNFRnbEJP?=
 =?utf-8?B?ZUNsd1dGSEYrSmxMMFlwOFNIUHdBTnhwNHpYYzlOejYwdlVFZ01RSkVvd1hC?=
 =?utf-8?B?NGhYRVI3cW5vRFhPU3QxQTZPaFVCVThXVW9vdHRyOW94S3ZHbW1zOWJWNVcy?=
 =?utf-8?B?UHVwSVRhNUE5aHRIcUtQWUlRNk5XWUZoVWdidG51NTJ4L3crSUhrRURPc0Ux?=
 =?utf-8?B?WlFQeEp4MHphSGZ5WTkybjEwUnB0L2dvT3BxeUI0b2EyU0F3MHF4b25BTlZP?=
 =?utf-8?B?UHRWSUJnUXhrVE95bXhlRlFEKzdFcU9LLzQzVUlDZGpockl0NUtyRFJjQ3Bq?=
 =?utf-8?B?VlNGRG9pSjY4dmIxT1NCOW5oN2d3Ni9QWnFLZDRySFBOdFRiSjhHYy9pRyt4?=
 =?utf-8?B?KzE1SXRORXBTcHlpQUpJdzd5VUpFYXlLUTh1YVJMeFFHUWRZZWYzUEpocEFT?=
 =?utf-8?B?K1NWbklidERCWm9sN1VkcWRkOCtLU3NSamZBRktkSm1odTVZWHgvWkNvRFNJ?=
 =?utf-8?B?enk0Zm0yb1Z1aHJEYUFBSXJvT0NpY3pybmFSWVNhaTZYZlpZY3hWSS9QcDYz?=
 =?utf-8?B?Qk1ZMytxbHZJWmtSdk1JUTFadWxQUnpKcmZyWlJCMit3TzlZL2ZTNmxIc0tt?=
 =?utf-8?B?WGtXRkZFMkNLeXpZdlVnR3BndzM3anY3YVlZd2lBeFVVaDdMUHhpU3JheVBR?=
 =?utf-8?B?Vms2d3Mxc0FXaTRJVjArVWE3cnkzekZkUU51NW1RcVVncEwzOHN1Tm9ZVmlE?=
 =?utf-8?B?ZmY5QnF6UUdidUlQUC9sYkxWQTNmZ2VoblBBeEhGN1c0T1JMMnk2U0k3NXBE?=
 =?utf-8?B?VjVpWWpPZzNqZDNNU1graWZCUi9iKzhCUUhjbWxRZksxNzZ6QlpiSnd6NFUr?=
 =?utf-8?B?ejFBWHJIQTRQOFdrczNwY3FxMmVhd2drVWZsNXRKQzZKKzVBNGhnZ05NNkk1?=
 =?utf-8?B?QklHVFdlQ0FCNVJ1RlB5RUFnWWVhQmxXcnpucDVZWnhndzBDdlVhSFd5Zkxp?=
 =?utf-8?B?VWZieTNhTERUWkdFb1JrU3l5OXp1cTlyVU85bzRENGZyVGRnRHFTWWtGUFRr?=
 =?utf-8?B?c2QwWnpoNXZERll5ZlBFSDJHRmdFTm1ZbjZQVyttc2tBbnJkV1RaK2F0cU9R?=
 =?utf-8?B?OGJjWTRkekxSeEVDT1ppaEpETjZKVTE4M2ZGVFpLQzduVmhJRDdrS25HeWpW?=
 =?utf-8?B?VHQ5SStNUlVsbGVzK2VjYm82UjZxQ1JMYUluTE50YTZvZVNHdDJZdmNMRWt6?=
 =?utf-8?B?VU9DdkRuVld2czJRblJoYlgwVlNFNE1hVm1Sdk5mTEVSSnQzZUlaL01hakhp?=
 =?utf-8?B?YWxTSU0wbWk2K2tlUzRYTUFlT3Z0Y0syb3d0WWcvNU0zRjhzRnE2cEgxVUh3?=
 =?utf-8?B?ak40Vmk1TEgxZ2FPSUZ6TXQ0bmMrazRkVFpHQ1F6VWFWTlExa25VQ0xNZFp6?=
 =?utf-8?B?cUJQWFlwUDFRQllRb3dxSmFaajQzNm5iOG1EaUhBeVYwTGlNK3Z6Z2NyM2ZU?=
 =?utf-8?B?U2VSNUZWR2d0TW5YbkVkMkJjbTFFZER0TjN5R1RYUTdydmRsZDJzL2NjdEQ0?=
 =?utf-8?B?cG4yVHkvT0VNZkpmck84MnliSXNoV0dIMzVGeFR3OCswZkFkUi94bEZ3VjFD?=
 =?utf-8?B?cm1OS3IzTFREa2dmS0Mzd3VBRWFaOE5KejFkZz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2025 19:37:55.5305
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f913919-d964-460a-fe5f-08ddb0fb1ec6
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00050A00.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB6939

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
    u32                        delivered_ce;         /*  2640     4 */
    u32                        received_ce;          /*  2644     4 */
    u32                        app_limited;          /*  2648     4 */
    u32                        rcv_wnd;              /*  2652     4 */
    struct tcp_options_received rx_opt;              /*  2656    24 */
    __cacheline_group_end__tcp_sock_write_txrx[0];   /*  2680     0 */

    [...]
    /* size: 3264, cachelines: 51, members: 169 */
}

[AFTER THIS PATCH]
struct tcp_sock {
    [...]
    u32                        delivered_ce;         /*  2640     4 */
    u32                        received_ce;          /*  2644     4 */
    u32                        received_ecn_bytes[3];/*  2648    12 */
    u32                        app_limited;          /*  2660     4 */
    u32                        rcv_wnd;              /*  2664     4 */
    struct tcp_options_received rx_opt;              /*  2668    24 */
    __cacheline_group_end__tcp_sock_write_txrx[0];   /*  2692     0 */
    /* XXX 4 bytes hole, try to pack */

    [...]
    /* size: 3264, cachelines: 51, members: 170 */
}

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

---
v8:
- Add new helper function tcp_ecn_received_counters_payload()
---
 .../networking/net_cachelines/tcp_sock.rst    |  1 +
 include/linux/tcp.h                           |  4 ++++
 include/net/tcp.h                             | 20 +++++++++++++++++-
 net/ipv4/tcp.c                                |  3 ++-
 net/ipv4/tcp_input.c                          | 21 +++++++++++++++----
 net/ipv4/tcp_minisocks.c                      |  2 +-
 6 files changed, 44 insertions(+), 7 deletions(-)

diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index 22ac668fe6c7..804480d39132 100644
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
index 1d8301f2883c..0c2331e186e8 100644
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
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 4d6325fa3f67..b861941a2213 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -467,7 +467,10 @@ static inline int tcp_accecn_extract_syn_ect(u8 ace)
 bool tcp_accecn_validate_syn_feedback(struct sock *sk, u8 ace, u8 sent_ect);
 void tcp_accecn_third_ack(struct sock *sk, const struct sk_buff *skb,
 			  u8 syn_ect_snt);
-void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb);
+void tcp_ecn_received_counters_payload(struct sock *sk,
+				       const struct sk_buff *skb);
+void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb,
+			       u32 payload_len);
 
 enum tcp_tw_status {
 	TCP_TW_SUCCESS = 0,
@@ -1035,6 +1038,20 @@ static inline u32 tcp_rsk_tsval(const struct tcp_request_sock *treq)
  * See draft-ietf-tcpm-accurate-ecn for the latest values.
  */
 #define TCP_ACCECN_CEP_INIT_OFFSET 5
+#define TCP_ACCECN_E1B_INIT_OFFSET 1
+#define TCP_ACCECN_E0B_INIT_OFFSET 1
+#define TCP_ACCECN_CEB_INIT_OFFSET 0
+
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
 
 /* The highest ECN variant (Accurate ECN, ECN, or no ECN) that is
  * attemped to be negotiated and requested for incoming connection
@@ -1053,6 +1070,7 @@ static inline void tcp_accecn_init_counters(struct tcp_sock *tp)
 {
 	tp->received_ce = 0;
 	tp->received_ce_pending = 0;
+	__tcp_accecn_init_bytes_counters(tp->received_ecn_bytes);
 }
 
 /* State flags for sacked in struct tcp_skb_cb */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index e6d7b5420c88..0e779de3ce01 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -5122,6 +5122,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered_ce);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ce);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ecn_bytes);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, app_limited);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_wnd);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rx_opt);
@@ -5129,7 +5130,7 @@ static void __init tcp_struct_check(void)
 	/* 32bit arches with 8byte alignment on u64 fields might need padding
 	 * before tcp_clock_cache.
 	 */
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 95 + 4);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 107 + 4);
 
 	/* RX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_received);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index c986452302cb..5c0159cc0083 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6013,8 +6013,17 @@ static void tcp_urg(struct sock *sk, struct sk_buff *skb, const struct tcphdr *t
 	}
 }
 
+void tcp_ecn_received_counters_payload(struct sock *sk,
+				       const struct sk_buff *skb)
+{
+	const struct tcphdr *th = (const struct tcphdr *)skb->data;
+
+	tcp_ecn_received_counters(sk, skb, skb->len - th->doff * 4);
+}
+
 /* Updates Accurate ECN received counters from the received IP ECN field */
-void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb)
+void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb,
+			       u32 payload_len)
 {
 	u8 ecnfield = TCP_SKB_CB(skb)->ip_dsfield & INET_ECN_MASK;
 	u8 is_ce = INET_ECN_is_ce(ecnfield);
@@ -6034,6 +6043,9 @@ void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb)
 		tp->received_ce += pcount;
 		tp->received_ce_pending = min(tp->received_ce_pending + pcount,
 					      0xfU);
+
+		if (payload_len > 0)
+			tp->received_ecn_bytes[ecnfield - 1] += payload_len;
 	}
 }
 
@@ -6307,7 +6319,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 					flag |= __tcp_replace_ts_recent(tp,
 									delta);
 
-				tcp_ecn_received_counters(sk, skb);
+				tcp_ecn_received_counters(sk, skb, 0);
 
 				/* We know that such packets are checksummed
 				 * on entry.
@@ -6353,7 +6365,8 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 			/* Bulk data transfer: receiver */
 			tcp_cleanup_skb(skb);
 			__skb_pull(skb, tcp_header_len);
-			tcp_ecn_received_counters(sk, skb);
+			tcp_ecn_received_counters(sk, skb,
+						  len - tcp_header_len);
 			eaten = tcp_queue_rcv(sk, skb, &fragstolen);
 
 			tcp_event_data_recv(sk, skb);
@@ -6400,7 +6413,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 			tcp_accecn_third_ack(sk, skb, tp->syn_ect_snt);
 		tcp_fast_path_on(tp);
 	}
-	tcp_ecn_received_counters(sk, skb);
+	tcp_ecn_received_counters_payload(sk, skb);
 
 	reason = tcp_ack(sk, skb, FLAG_SLOWPATH | FLAG_UPDATE_TS_RECENT);
 	if ((int)reason < 0) {
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 779a206a5ca6..f1e698c323f3 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -500,7 +500,7 @@ static void tcp_ecn_openreq_child(struct sock *sk,
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


