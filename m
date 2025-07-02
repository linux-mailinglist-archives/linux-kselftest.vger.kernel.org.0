Return-Path: <linux-kselftest+bounces-36266-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 325BEAF09E5
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 06:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D55F8480B0E
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 04:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756A3202C43;
	Wed,  2 Jul 2025 04:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Iz28shaT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012025.outbound.protection.outlook.com [52.101.71.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53021EC018;
	Wed,  2 Jul 2025 04:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751431069; cv=fail; b=YBhCYElZllzTlF6eBV9UnGKj8ZiHSLaF0zTKvFKO6NgmJUUMc0WUTBTsAGyNpBvtRx2OfuaQFSwtogW8riE14oLHYB2P4ZH8kYsUw04xPDZ2AfwCOwZOw95FDqnkTcKclBdfUiQssKbjMzsWtOigck6Ml7d3ORkvWKdI3nMcfXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751431069; c=relaxed/simple;
	bh=bK4Xx+l1sBybj9q09xns660ule0tkgq5RmKraqLaarI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lJR7vElgjbMkFcvZsTggoSKToKwrq10eqiPGqNBS05GQSyfA/UEym5FuLAK2goQ6zWcnaaLwJKi5Iksj27x4VpajPcEQxGsr9aBp2cPq98Ae3z9717MtC8uNaRlieTkDHNvFoIzL4BTYgI56reI4slirAsR/tUfHh2I2pwRWcac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Iz28shaT; arc=fail smtp.client-ip=52.101.71.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=us0SJt02ASnCCZdQEuPnftHfiBKpppQjvqif5y+7C6J9FsHaxz5jhNxBZnIU9cTpGXpGM3iejwic9z8HeZ6IblQPoHSKwyWAioRrHFQOA/jVRxdUE+YI5Xqu375FXf5hz/6fUnMNxcHEEhGnxarx0rSrurQrgHTcV8ip3jzgALPn/PydVO24spVttVMuYNias0KxVGcOHCcG34QyVDonflGHpqXg4c3LcUgKJj4b6KxRimU+RhWgaMMJAKma3hbeRO9AYYf1m8Ufc4dhLKfDeIvw+lgZHF30NiK3txXvR7Vl+4TS6r73Z0Vl3dzLjw7+uOZBAV8AMKw+vT11Tj+0Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WuJewFzdWKD9IyHemW8hHrpNiwXZBmYIn67ozvm29Bo=;
 b=hvrqKb1C68BFRqEy6o2rEA3uhLgviMNVMY4RBNG0FDrfRBHg9tehCdRk0QOnPagIMbNFbWEapBPdMKYaIhmwdqnbhltraMror+wTe5ZPhH0UcKoaPCgsdY9R49v1/ruDOx7iKCPtAauUkSeWfMvM9KG1FjJSrK3x0F0rcYNTvQCOIqGBuxIYXuM3jljCB4b5KVJPd8AokOBX77Y7HGtuQTka5auPlRnAkNSQEzltI1RLABfxP97CBeC6ctoxYYtp+SsBqWYpTKjGb8INYR2WxKBQW4TIunTcEPd6OHyyR2guoPNN+M0u+jLsN0petEF5bMd4zTl+UkJafcdBXWhrqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WuJewFzdWKD9IyHemW8hHrpNiwXZBmYIn67ozvm29Bo=;
 b=Iz28shaTx+3eIgb/ZilbJrPDcbZvAgp3KT+IHCo0cHDDrlb6U1shrhzT/ucxgpANUdGmuoytWB7eFEd7HYpFGE/cngKa6nT4a/PwwHZQ3q79kMjXiRdQVtTKnr3kuuBBe2Gy1PNKgRCJsuD6aHiEN/z9OjaudqTO4ZOEBZ6OV4C1Yvw6PK058GD48ZXeZJeI678O7ZVR+7nhprY2GvKACx8N7iIy3vx0VCRniFLUPWIv1FEGCOgKxd/ZV3yARvKU4uMYC5Ake0D46YTSNBtCMG6pPquzT0vc4SKAA473AXPKt1LZfATPrRDgXvqxNEtsTpREa4XXjVPPBJoNbZlWnA==
Received: from CWLP123CA0135.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:87::27)
 by AS2PR07MB9026.eurprd07.prod.outlook.com (2603:10a6:20b:556::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 2 Jul
 2025 04:37:42 +0000
Received: from AM4PEPF00025F96.EURPRD83.prod.outlook.com
 (2603:10a6:401:87:cafe::1) by CWLP123CA0135.outlook.office365.com
 (2603:10a6:401:87::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.30 via Frontend Transport; Wed,
 2 Jul 2025 04:37:42 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.6.101) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM4PEPF00025F96.mail.protection.outlook.com (10.167.16.5) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.1 via
 Frontend Transport; Wed, 2 Jul 2025 04:37:41 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id D9F931C0047;
	Wed,  2 Jul 2025 07:37:39 +0300 (EEST)
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
Subject: [PATCH v10 net-next 10/15] tcp: sack option handling improvements
Date: Wed,  2 Jul 2025 06:37:14 +0200
Message-Id: <20250702043719.15130-11-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250702043719.15130-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250702043719.15130-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F96:EE_|AS2PR07MB9026:EE_
X-MS-Office365-Filtering-Correlation-Id: de53e146-3de2-4ced-d38f-08ddb9222e72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UnNXQkRjaXBYbTkvaVU3WUttTG9KeThLZ1FOU05qQ2RFdmZjNHU2VStqWXV1?=
 =?utf-8?B?WVVWT2RJa2FYcXUrVlZnZWJZZ3pjYkFxcnJtRktiaTQ2dkp2Zjh4NlhHZmN3?=
 =?utf-8?B?Q1VQZ0hpM0lwWTJ6WXBYOHJ5ckRrUGl6UVpHcEN1Z0JnWGVJNHU1QVdVbk5h?=
 =?utf-8?B?Q0VuTXRvR1F1cGRBS2dVb2VsREM3TWlNSzRPZHZBdXo4b0lkT3psVS94cEd6?=
 =?utf-8?B?Z1lYdklsamtqMEJSV1dPYlZ0c0g1Y2d4QldKdmdpMk5MNXFnZWo3U2lWa2Vq?=
 =?utf-8?B?bHlCamxlOXpqQlM4blcvQS9DOC9nSEhyaXIrZENtMjdDakw2OCtPVXRNODNJ?=
 =?utf-8?B?cm1kSVlwTXZkY3BLa2NRNVE1a0Q4MlNjY0krbEFOcUFWYjdpRFZHOHdEUXpn?=
 =?utf-8?B?VXJwNmwyelJySlFVRHBnSmc4NFFjd1hsUitpNDgwVkJ5Z0tiemlUK0J1VGZ2?=
 =?utf-8?B?T2lGYnNpQ0JLVTlNRW5pRDluN1owaXZUWEdiMDMyMzJIUVpvTGNvODhnWlB2?=
 =?utf-8?B?b2FoWWJ3SEYwM0l5V3NMRXQwRDU5MTVQbFNiZFhPOWtTWmVwUGlXT0xSUlFV?=
 =?utf-8?B?MG8xeGFXTDlLTThxRFJPZUxFbEUrWXdpblAybkZMZkxrN3M3WUtSUGhlbVJj?=
 =?utf-8?B?NWRzYnQ4RGJBZDR5dGtMTjcrL3ZpSFBSaENtMEMrRm1KYkdMa3lJOXVKNnJH?=
 =?utf-8?B?TjZDYU9DRzc3aUdwaXl3TndXRytVaFdaQVd0T0lIZDBSOGtQWjlNa0VpYzBt?=
 =?utf-8?B?VkZVNjR0YTJsQ205c3ZVWGxwdCtQNjg1S3lFMzJUUGNZZktlTDRFK1FlNTF3?=
 =?utf-8?B?ZkRXd3VxNGtHRFZKMTc5WGRUNml2aFd2T29MamhQRVExbGdWUm1WRHYzWkZD?=
 =?utf-8?B?aFlZYkJyNy9aM0ZhQUN4eDZRZFhBZjg4QTdVVnFadVFhK2ZvTHQzWStFd1ps?=
 =?utf-8?B?a1VnREJzdm9wS1hzZ0k5RVZ0d1MwL0FlanJWaks2QjhqU3lSalU3Rnh0UnNN?=
 =?utf-8?B?c0hyV3B4VFZYZytPRVVrYXlHQnpHeGhTTzhaTm5ZcXRGMU12VVFvZEthbFV1?=
 =?utf-8?B?Q05pbDhzbW9zNDNRWUNHQW1WVmhVYkdab1k2UFd3Z0RxWEQxZWE1djVIUkY1?=
 =?utf-8?B?Tnp3ZkdiYXJ6YStkMDNxdUhxV1dmcEhSMzAvZ2p5b2NJYitYVzhrNjlQSmhE?=
 =?utf-8?B?RnJ3MlpySVl5YjJlMnByZUoxSW1YQTFZSGZVRjdBN000cjZZVWZlQVJtQ2tF?=
 =?utf-8?B?R1VlMjFlYnBUeFNid25SVDFablgvdGNtdXZKVU10azMvaXBBOVN0ZE90SHRH?=
 =?utf-8?B?RTRRNUNDWkRKTVVQVktOWmJkM1ArWWc2cHd4NlJPeXdwL216R1ljOTdlZjlr?=
 =?utf-8?B?MEtiNGJFTnVkakV5eTU0NGxHYjRYaG1hdG5EWnhueE43ODBhQWhxY3Noemhq?=
 =?utf-8?B?a0x3SHhZMDlJMWExT09zNkRPbXZIekp4MUlyejlabStENnVob1FSTHUxTmpl?=
 =?utf-8?B?UTRMMWYzWTd1b0QzcWpNR0tHUUpUWjJxa20ydTJTYllxeVVNRFNsVE5XUVcv?=
 =?utf-8?B?YWNJNHVWUUJoM0JuTTdLelAwMDJtMk02SzNGcS9qUGRTZXduTXdITFo3V2tj?=
 =?utf-8?B?eEx1Rm1FdTU2Q2RoUnJSdjBqcmR2emtWcXBweksxazcwUWpkR1NzY0JleEN1?=
 =?utf-8?B?VFEvTmgxK3E1UjM0WlpDY2IveTdMUEwwL3MvVlpxV25rbDJqVTBMRXNSbFBN?=
 =?utf-8?B?c0VQeHAzYzNlV090TGpyVlJkd3pzREs1MEVkZWVHNzZOVkl2TXJUeTR1MElv?=
 =?utf-8?B?MFVTUWdQQVNrZHp4UGZnQUYyRVFsbXVYckFITG0zTGRJZ0VuYUNKYXAzRzBu?=
 =?utf-8?B?eVJlZDY1ZlBwSU5lSm9WcG0vaWtDZitveFpNTjFXR0pqaUlTVHovZVI5N0Vm?=
 =?utf-8?B?MUE3dFk5L01jRVZzSFZCeCt2bGhoaFZWZ1k0QTRYR0huNkQwS29Bd3orM3F5?=
 =?utf-8?B?ZTdoSSs3MjV1blM0WmJpZmk4cU83MExUOGlGKzU1YWdFQmwyWnlYeUQrRk83?=
 =?utf-8?B?YmxLNzVySVJ1NVp2VDNKdVQxYnJsYnZGMDFQdz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 04:37:41.4571
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de53e146-3de2-4ced-d38f-08ddb9222e72
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F96.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR07MB9026

From: Ilpo Järvinen <ij@kernel.org>

1) Don't early return when sack doesn't fit. AccECN code will be
   placed after this fragment so no early returns please.

2) Make sure opts->num_sack_blocks is not left undefined. E.g.,
   tcp_current_mss() does not memset its opts struct to zero.
   AccECN code checks if SACK option is present and may even
   alter it to make room for AccECN option when many SACK blocks
   are present. Thus, num_sack_blocks needs to be always valid.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>

---
v8:
- Set opts->num_sack_blocks=0 to avoid potential undefined value
---
 net/ipv4/tcp_output.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index debcb1d431e6..d98a1a17eb52 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -985,17 +985,20 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 	eff_sacks = tp->rx_opt.num_sacks + tp->rx_opt.dsack;
 	if (unlikely(eff_sacks)) {
 		const unsigned int remaining = MAX_TCP_OPTION_SPACE - size;
-		if (unlikely(remaining < TCPOLEN_SACK_BASE_ALIGNED +
-					 TCPOLEN_SACK_PERBLOCK))
-			return size;
-
-		opts->num_sack_blocks =
-			min_t(unsigned int, eff_sacks,
-			      (remaining - TCPOLEN_SACK_BASE_ALIGNED) /
-			      TCPOLEN_SACK_PERBLOCK);
-
-		size += TCPOLEN_SACK_BASE_ALIGNED +
-			opts->num_sack_blocks * TCPOLEN_SACK_PERBLOCK;
+		if (likely(remaining >= TCPOLEN_SACK_BASE_ALIGNED +
+					TCPOLEN_SACK_PERBLOCK)) {
+			opts->num_sack_blocks =
+				min_t(unsigned int, eff_sacks,
+				      (remaining - TCPOLEN_SACK_BASE_ALIGNED) /
+				      TCPOLEN_SACK_PERBLOCK);
+
+			size += TCPOLEN_SACK_BASE_ALIGNED +
+				opts->num_sack_blocks * TCPOLEN_SACK_PERBLOCK;
+		} else {
+			opts->num_sack_blocks = 0;
+		}
+	} else {
+		opts->num_sack_blocks = 0;
 	}
 
 	if (unlikely(BPF_SOCK_OPS_TEST_FLAG(tp,
-- 
2.34.1


