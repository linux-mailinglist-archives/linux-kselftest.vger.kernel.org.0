Return-Path: <linux-kselftest+bounces-32947-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB37AB6DAE
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 16:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91A257AD183
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 13:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D5C284662;
	Wed, 14 May 2025 13:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="U6i3oinL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011059.outbound.protection.outlook.com [40.107.130.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CF6283FD4;
	Wed, 14 May 2025 13:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747231042; cv=fail; b=aAGfHHLegN7zuPKY/GUD8yoIL81+k/7CJUkFRcBdX0Pl1RFiSJyH5qGBUhbIzI3aK9fkmBsc6yDnHRuVHAFF2tQFDOqQbE3VYaY4eqYg3GcG9oISaEpaXfM772jUkgZaOnJ7RgnyS0QI3hM+SV8Tdg5ZDW7ros7ABnr62mD35eU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747231042; c=relaxed/simple;
	bh=fzdmbMlDFSfz9D5JclJq+MMfeINB6U5xwyzRoWOoF7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cBii0xnwerMVCtVjfGra07Jgwb6GJTOk+c+HwFcWcqabq2tRR5kHRlKf/kFG6Rlx40kNzKoYOwDLZvhloM0ljz2+37s6T/9gNzMDRhzNhXcUkrp9FIv36qk8M/wzSYbqougITRhrdrD6pdbmY/ZAeI4GJeDHBrBYFSQRH/yUGKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=U6i3oinL; arc=fail smtp.client-ip=40.107.130.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K+BOJjHpVd6o4gA2PlrUDH7+UXi8Lv8kavIbWuMtds3vXjh11ttAaTEF24EUKB9y1C4mu3H3jmMmJUok6OQab7IWrObA1SvsAkPSZW3fzbi4YZWXBvsp6OIVgxRseCp2YXeMu6ohvb5H6N/OsJ/ocRJo9IunaMspojJB92TjJIPq/5hsajNpxojiFpnbyu3CMgxsLP/FIWfbzdmGWy+0rt11qkr02+n1I/mU+fYntKgYSMkSEuT+7TQvYOSQKNuchpl+BPJ9kaEat+9G0TBD2OKbroNrgjLuNKYVa5L4hkHe1VdQvX2qIaSYbsp/BHbBdGvhgBzbvn4R8B/3DffnZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDrl+/6MKZU6clhwC3c3K9/dYY3Jj2BGOr7YXH5GBCg=;
 b=AUXMNyESsdz4Axc4kgpD/IiKfMKFgjX0bDgxb1oWkl6MRcHk93c4VTARAR69D/vEKT873hegsGVIhu15tYl6h15mtWkhTPH8Qm8y846s/GXKI7RwxCevZIo929HihLN+S7FttU6yn+43vC178CagtAmy17ji9kr7m16J0CPyI2qwYA5ErkKciA6wEGYiKSFgE9K5r48xdaehjI4rAYPaebkeaqkekVM+9+xiW2OU2suuT+YQjdwMK/ebog6d2rHkJ2GOInHFrtPYiQNrOtHBig/8n9qG51FuRrpue1XkyCJNBWeiEF3KzK+Ashptg7mMLf+1HnTTy6ub1pHvBeHixw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDrl+/6MKZU6clhwC3c3K9/dYY3Jj2BGOr7YXH5GBCg=;
 b=U6i3oinLAGDkfSV3XKqO19nnmGEW0qiodkrf7r3bWQAjI3jwPLCxkmuwfz/iMbf1P7ZI5L1V8jFJHjSZExS2YepvM/DXcu2m4WLDe+MI7B6kOGlGW8/wzbhbAPyc3RG4t8fIfn+MlMRjLK6Uey7yIg2r1MuoTwHLhzpyU/SL1UdJ0F0xaZAp0p0xHg4Dk7cMRnsl+IVgl++TnCHbTnKpRLHDelHD2RcKN/QZ0R0mEvGVXkhsOyiR/i0FC/x5A+AKV+EzSIwqzg2e/LMfbxMiKiIZEeZE0ACzqwN8S3K5xKEWKjK5rAmUUPrsI2dsSSOwjy+AIm8SqfihIAJ15J8ndA==
Received: from CWLP123CA0058.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:59::22)
 by AM9PR07MB7842.eurprd07.prod.outlook.com (2603:10a6:20b:300::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Wed, 14 May
 2025 13:57:17 +0000
Received: from AM3PEPF0000A790.eurprd04.prod.outlook.com
 (2603:10a6:401:59:cafe::82) by CWLP123CA0058.outlook.office365.com
 (2603:10a6:401:59::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.17 via Frontend Transport; Wed,
 14 May 2025 13:57:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AM3PEPF0000A790.mail.protection.outlook.com (10.167.16.119) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.18
 via Frontend Transport; Wed, 14 May 2025 13:57:17 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 940B5200BA;
	Wed, 14 May 2025 16:57:15 +0300 (EEST)
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
Subject: [PATCH v7 net-next 14/15] tcp: accecn: try to fit AccECN option with SACK
Date: Wed, 14 May 2025 15:56:41 +0200
Message-Id: <20250514135642.11203-15-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A790:EE_|AM9PR07MB7842:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c2c459e-3fc1-46f3-2eed-08dd92ef3cd0
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?TFBPNFJidGpRVVRVTER2WWpLa2tZTk4rM3hlazFnZHBKaHpRQllvejlWSk45?=
 =?utf-8?B?VnMrNkdsTUh5TkI5Y1NBRUErUitsUjY3OTIvZkNQbVNjeGIrdHRjc1RSUlFC?=
 =?utf-8?B?Zk9na3BNeVJOQ3p5aUpOTm53Tyt0SW40ZEFvNi9CSURhNlNvc0t1V013YW9y?=
 =?utf-8?B?d2J5QlllTi9ycHNHZDk2MGJ6Um1PZm9nZC9QU0ZySHJsZitEdC9ML0hPNTBF?=
 =?utf-8?B?OEdrQk4yZ2tKbDZFRnNjT04vQjZFWHZSYlhhdVFxNEtrNTBUc2JlMVdzT3p2?=
 =?utf-8?B?NC9qVUJFNWRXZ2RtNHFCb2NqZ2hTU2FHUDlzZG1NN1ZYd1h2THdGYmhkcVhr?=
 =?utf-8?B?TkpENGMwdG5KMmJ0QU5MTTQ0SVJpY0ZuejRKVGtBKzVodE5GUlhkamNEeHl6?=
 =?utf-8?B?WkF6QXVaSk5FbGdMWmlkRXYybW9scHBxMERsS3ZrcVNTUWlHTlNlZGhEL2FO?=
 =?utf-8?B?VDgyV2lGVTAyYlpqV01qcTFMbkN4ZWNwNmNuSmQvOURIbGZkcTRiRXJFYXFj?=
 =?utf-8?B?T0l1U3RTUHFpcFowMVZ3SjUzUEVaYU5IRklzbFNPdy9LZjJmT2Noc2YzM3ZD?=
 =?utf-8?B?aVdxR245OVFpVk1IemRUMzEvUnVkTTJmYXQ3enpzd3g4SGsxOTlmbTQ1RDFS?=
 =?utf-8?B?Tk95NVVEYzJSN0hCNURRckdNSjh6UEZUbUV1c0hIbjFBdFVBZ1EyMS93R1M4?=
 =?utf-8?B?T3B0SXo3SVNZRTFyQmFqblF1b2lCK3R2Tk01RTZXdnRXb1JlY3pDWHhTL21M?=
 =?utf-8?B?TlRDSTIrYkFSVDZsbWwxY1JaTDdxY2Nlbi8rZnA0OFFvc2NHMEZoRVhUOVFj?=
 =?utf-8?B?UkVkL1VJb1ZmRk44Q0QvMHRkRXQ2R1A4bXZUMnZTYUFhaXJPN3dXaS9ibUFk?=
 =?utf-8?B?RUdRbWZobTAzSk1oZVk5UkNFNzBLN2QxNm9TRGJ1NjBWbEEvcHJsYWc0SWl1?=
 =?utf-8?B?ZGlPMElQRjl1QjgwMnRaaGoxZytpTWFpVG9CQVYzZTluUUN2ZERQOGxGeXRU?=
 =?utf-8?B?SFJPTitFdzZsbzM4Q2lFc0VkMnlqSE1senhMb25DSmtCQ1JkNlRiU3lBcDll?=
 =?utf-8?B?V2NFYXZSNDQ5ektqM3dMMlhKTTV6SWlWeVA1blJsYi90OWsrNVgrbm5sOXNW?=
 =?utf-8?B?RUpoQzhpZTBic3dCazRmRUd3N0kzeWk3ZVBUZlNrQUJUTEc4dnp3QmJ5OHZI?=
 =?utf-8?B?UmRzNlcxTFJ4Z1ZYSW1vZk5zTkFPOFJBaVY4TjFBK1dQMDkxNVJzU21ISFBJ?=
 =?utf-8?B?bk95bU5lblVLK2RGN3RRM3BiWTJ2MzZKSkhPOGlBQ1BKRTJFWDU0M1pzWXZz?=
 =?utf-8?B?V0hDSW50WGVXcldyWks3ZFEvd3g1cnlOZEh0cHQ3d3BSSUtDeUJHanpadUND?=
 =?utf-8?B?L3BhNWRjT0pjT3U0OGtQUFdEUExwdDNzL0hTdzRjQWxJWW1aQlRGcjlnMlJM?=
 =?utf-8?B?TUJOamYxVjREM0pIWDRlazN0cjQzN3JrUU9vQkpNMTMwZjY4UEs5ZytLb1FG?=
 =?utf-8?B?cXVjYjY3ZERJMEVLR0VJZU1mZDNoMDc1VmErajNDM3hHRVNnRFFSbUtHTDhr?=
 =?utf-8?B?OUxJRi9IWjkzVHJFRWJYUVJNRWZ4UkVFeGZ6WlBTU2UwdXEwVVY3RVdZRHFM?=
 =?utf-8?B?VDZRTis2MVIycWJLbjJhelp3TWprbHpRenRHd0JiaFF3SVJQdmRQM2tzcis1?=
 =?utf-8?B?NUdTMHpGRkorUnBSQ2ZuenZncE95bVBRdnAwbVJaOXExK3MyQnFERlRCcWw2?=
 =?utf-8?B?V1ZRMUhUSmdSaDI1TTE5ajhqRG01K04zaDd5d3VGeEJLTi9mS2lKTC9wOGtI?=
 =?utf-8?B?YkVWU3V5dzdtc0hTTmhUN2hIWkZKbTF0aEZEc3c4VzV4blN1NWRPYjUvY09S?=
 =?utf-8?B?MkdCMGJTKy8vdktFSml2TUlDb3JXQnRoVUhiNDR5bnlxN3piSkpvaXp3RzJh?=
 =?utf-8?B?N2U3b1VTSXBYaVNqMFVBeGN6OXUwV1RKblhTQldEZnVYV0xxYStTSTJtOTUw?=
 =?utf-8?B?enpFazlEWEg3RXZBZjNvU1praXloTkV2cEdBc3FJTUVvL2lMZFI4OG4rUGRL?=
 =?utf-8?B?TUhnTnlKMTQ3azVMZDdlMFVDalA1eDlPcjlVZz09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 13:57:17.0919
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c2c459e-3fc1-46f3-2eed-08dd92ef3cd0
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7842

From: Ilpo Järvinen <ij@kernel.org>

As SACK blocks tend to eat all option space when there are
many holes, it is useful to compromise on sending many SACK
blocks in every ACK and try to fit AccECN option there
by reduction the number of SACK blocks. But never go below
two SACK blocks because of AccECN option.

As AccECN option is often not put to every ACK, the space
hijack is usually only temporary.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_output.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index b630923c4cef..d9d3cc8dbb5b 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -982,8 +982,21 @@ static int tcp_options_fit_accecn(struct tcp_out_options *opts, int required,
 		opts->num_accecn_fields--;
 		size -= TCPOLEN_ACCECN_PERFIELD;
 	}
-	if (opts->num_accecn_fields < required)
+	if (opts->num_accecn_fields < required) {
+		if (opts->num_sack_blocks > 2) {
+			/* Try to fit the option by removing one SACK block */
+			opts->num_sack_blocks--;
+			size = tcp_options_fit_accecn(opts, required,
+						      remaining +
+						      TCPOLEN_SACK_PERBLOCK,
+						      max_combine_saving);
+			if (opts->options & OPTION_ACCECN)
+				return size - TCPOLEN_SACK_PERBLOCK;
+
+			opts->num_sack_blocks++;
+		}
 		return 0;
+	}
 
 	opts->options |= OPTION_ACCECN;
 	return size;
-- 
2.34.1


