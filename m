Return-Path: <linux-kselftest+bounces-34575-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1C1AD3817
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 15:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F28F16CAA7
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 13:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B5425B301;
	Tue, 10 Jun 2025 12:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="UH7b5wDl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010023.outbound.protection.outlook.com [52.101.84.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B5B23ABBF;
	Tue, 10 Jun 2025 12:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560031; cv=fail; b=el7eEFMRfQwobyFTKpaHM1xbVB0ohnHqXcczaOkS/i0carSlsO8fdaTnY9CHzjsyXtykX/C+U6oju5JGPuDBGtw91AHfKE5csc+okPXoJKK9Eiltmsd6Glc90qtMKnRZ/9FEvQpfnIpJv3E5sI2oP9AsLLXeUKemqWll6Z50Vgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560031; c=relaxed/simple;
	bh=ncaM4GpLrsb8HkA12m8+f9h2FTdryvTNHt+DpErzoN0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d1035zyoRqDCc8dnEYvvf4N/9kACSZp+SVFNCdb/XPkh7BgHdPCEaB55eNNMlD3UbuYfE6iVOK+xg9Ev0UJeu2cmX1DmeSDpXMxuFUfx/MCbrNz9geAM15DXbRd+NA/cKcmrxol5EUy/Uyo8UpPcy/zYd2PnYWt4oeA0bZcaHfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=UH7b5wDl; arc=fail smtp.client-ip=52.101.84.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qtW2vYFoFcmALyt7iquJ1XFOcaIOQW3yjvEd/Pe6wr8e8j6HTloFoa8uZlzR6A/4ap5lHHAxYgGgtVdFITkwcoFr+mnn2YVbgd8dgOzWft7RP+jejf9Vr4MoZHShnC+SDu8Hx3oCUBz9kAJ7gqVDBrEurXXrXHBWtJXYp/Ihqd/kncmECYy9Sh7UEd+1l6nzJ32fd5l+yjHuPe+fvKBDVdStZ5N1pGztv09kUNnXYczQKvL7FDgf0dp1furZHUizseYjiBluP5UohnS4WoAI27F6ayBsjC25k2kNStWZdkeoCXCOmBsMgvRUuETyUQzWBL7yyAzsY6W/jxJyDr0qag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6lOf9SXGnFJXc2ZbUYoljV5VizE0UVbOjXFuFOxyf8=;
 b=IwIqBIFHgF5k6VcwWFFI6cgmhm5ZTzvjoVDbwHjBPXkkCxStGMdqCMqw7lE2yK8ZI2bC/eVQOulEydU+q9+2GGXyalLpcQhcGR94Sh3w3mIx+C7nu15Y8sr2gJIJRJ0ReeYYC2ZzdvZ4hPhv6g0GKyGG013ehK0TkukeRY+IIX8BpTJKCQkiG0uObucJT2My0iKbrzzghZG9ed0/suBx3vvmshPAVVNUdl5xfNWUSDJJ0E8pZ0Rn8IqJMWs1BVeRwKGlMK+z3onCXP9nh1T2LTWCcFHFyd5BOO7N2zBFC5gDkU56z+onPV8QRKrfNVP0/wqRJjDMsfqAmEnOBV+Cug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6lOf9SXGnFJXc2ZbUYoljV5VizE0UVbOjXFuFOxyf8=;
 b=UH7b5wDlO5nrrtIZlrt3nl2Knggkog6xKVWypOivojzgyYNSmkfNMBxB5qHDJwANggpbF/wB/s0Itk/2p7HNzAZgFVyp/L6kuX2+iB2llHNB1iXBPvH6sdlB+gAAJsfK41xwe+LWxe4+G5jbiEV4D8UQS4mrvhBCgfb0P3OV1H5F5jTyDawpY8C71XhH1z2D+wHWQZUU/pDk+D/P2Ij68j/XogF4J5efTlTLXY1OXsfmEyr/uNXvLv93GEnCvi6rnmnGaABZTouD7IdCVKSvILQJitFgU/U8yyMz9r0IBOMGiGfTMSMaUkaX1tmPrca0xs7cUxmANYMWR6Fi7sVPoA==
Received: from DU6P191CA0017.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::28)
 by AS4PR07MB8583.eurprd07.prod.outlook.com (2603:10a6:20b:4fd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.28; Tue, 10 Jun
 2025 12:53:46 +0000
Received: from DB5PEPF00014B97.eurprd02.prod.outlook.com
 (2603:10a6:10:540:cafe::a4) by DU6P191CA0017.outlook.office365.com
 (2603:10a6:10:540::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.17 via Frontend Transport; Tue,
 10 Jun 2025 12:53:46 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.2.240) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DB5PEPF00014B97.mail.protection.outlook.com (10.167.8.235) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.15
 via Frontend Transport; Tue, 10 Jun 2025 12:53:44 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 5C79B2004A;
	Tue, 10 Jun 2025 15:53:43 +0300 (EEST)
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
Subject: [PATCH v8 net-next 14/15] tcp: accecn: try to fit AccECN option with SACK
Date: Tue, 10 Jun 2025 14:53:13 +0200
Message-Id: <20250610125314.18557-15-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250610125314.18557-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250610125314.18557-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B97:EE_|AS4PR07MB8583:EE_
X-MS-Office365-Filtering-Correlation-Id: 186f1b8e-53f2-4e1f-6ce0-08dda81dd5b6
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?dnZEdlVIUUc5YVd5YWZpSWh2SnZOMzJkeGJrVFB0TE84VnRHdDhPamgxbkJw?=
 =?utf-8?B?ZWZMSFpwQy9aNERIVk9FQjA2endnajJMekNFS1J4bnFLc1lPTCtwRjVvTnZy?=
 =?utf-8?B?Y0RpVDV1QzVsSERSMzl4bVF1M1R4SU5DTGFmZVlWVzdkV1p5WVgvaXRsRWFK?=
 =?utf-8?B?TFhORkV4ZDhJZVYxV3BHVE5xUExqQ3hra0VWS2FSRVEyb2VGWnVqMkxzcDNr?=
 =?utf-8?B?ZXNOWUVlMXNCZjZjRVZad05MQklIZGJELzlpQXpDKzNKbmFkOHJiU210N1FM?=
 =?utf-8?B?WHFyclIwcDNkV2RQMURIbzlHbXlMeUVvaCtlR1djc05VSERsQ0RSVUlSZ243?=
 =?utf-8?B?Rk9PVEYyVCtGb0QrUEhEYWxSMU9wZVNieEtpV2tDQWtSVE0zcUV0L1RNYVR0?=
 =?utf-8?B?bDF5QUI2Z1FsZkNKTkpVWncrT3FtaDVQdVo5dTJmTmY5UVVtN2cwWi9KOGxo?=
 =?utf-8?B?RU5CMnlEWE5VdGpQRkF6V3R1QlRXdnp0ODdUeldpUFlocUtISURxRlNlM1VB?=
 =?utf-8?B?Z3dvamFXVzdVYitZd2paMG1rei9xQVMzd2kxcEl2VFZ6dUR4MVMxTHdxbzNp?=
 =?utf-8?B?UFk0b2VoN2JENUZ4b2ZEWXJUU21HOE41NjJDVjZTTnNLbHNqYzFYbHFadkp5?=
 =?utf-8?B?RFo2ZktrYm1UUlZONnFUellCZ2FhK25RN2x1czJpVXdCdGxxaGRHZG1RTDJB?=
 =?utf-8?B?MTEzeXM1N1RyUi9rT21EZjdNb1dOeGZXVXErbkdlOHZRVWh2WmlXNTg2NzBY?=
 =?utf-8?B?TE45K09oQVoxL1Y4cm0xLzNrNGVYYzQ2a2lLa3I1eUtnL2JZNzhWNWs3RGVT?=
 =?utf-8?B?NFMvNDBacWpxREUzdzBUSENhajcyY2loVlZRVnhIR3pIbS9kZWR0SnBzYzdC?=
 =?utf-8?B?SUlYY2FxSmtXR0VrV1hnTVM3dGwxeG1qanlnOExqSlQyeUJha0xVWW5oTjJy?=
 =?utf-8?B?VDh3ak9nZmd3c2pGelFiK0tOSmU4amVLTmJmYVNLTTlMZ0YwU0lFRlhWYUY0?=
 =?utf-8?B?UnpObG1OUll3UjEyLytqVHYrN2M4Yy9UaWU4VnpsdkRBbUFZejl5ZnZMU09p?=
 =?utf-8?B?T2ZkRG1CZ295dWJ5WEcrMm40ZjVQbDAzQ0pPbk9RNVVuUHNDTkIyTm4yQVNE?=
 =?utf-8?B?YUtZVUdLbllTN1J4bXBKZFlUUzFrYlZrVks5NUNZUUU5Y2xsN2pVd05uZzkr?=
 =?utf-8?B?MEFYNlpWUFRBMWVMUEwwWlhSMkVwaDhjUWlwZkkxUHh0RTlkeG9XdXcwczhi?=
 =?utf-8?B?Z1E2eEU1eTJUYW04L210Ym53a05ZL2c1MGNCbG41em9jSXdsNk5uZ1NGNFU4?=
 =?utf-8?B?SG9xSWVaRjhjVHpFZm9LdnhmS1l3MXJrWTZjTWZuM2tIZkM4T3NHUVdWc05y?=
 =?utf-8?B?akNHanpKWExZdDRMRjhwcUdKb1NZNzJ4TmZsU25xMmd5VEJBSkdzelN6Ymt0?=
 =?utf-8?B?dTB4aFFwQ0ZvZnV5TjBjcDYweVVETW10NTdUNkpOK1RvcGVsM1RnV3RWWk5x?=
 =?utf-8?B?U0lQeUR3OCt2YnJROU9XWDNFWXNRaVNDb3pOMWpUbDJZbzR1eldMRzZOd1FX?=
 =?utf-8?B?d2IzVFFXU3VRWEMyd3didWtVWTQxQy9XZkI3TlZBSkdGRVpkWkd3L3k3aXJp?=
 =?utf-8?B?OWRGSlFGMHI0YnpQSXVGVlFybi9oMllnR3E5Rm1rZmgrQ1dHMFNOMGRwQU1L?=
 =?utf-8?B?aU8xd2RMVnNPK0dGVk9wb2xBVkcraGFUUWxoQkNNazQ0aTZ4WTBaMmxsR2Zi?=
 =?utf-8?B?MjFzV1l0cm8xb1V3WHlJM0loUWl5V09hWFBHYWZDKzFRaUNFRG80N2MyRXpH?=
 =?utf-8?B?VUhIMzZWY2FOT3poTEtpVFdLY3BsSDVycFVDTDJBSitnSHZzc0c0a0VJWkJM?=
 =?utf-8?B?aXkrL3k1eVJLeXdBdjg1RW9qTGp5Tk1UUVNCNFVyc01PVDJ4aTBxbE9EWmFP?=
 =?utf-8?B?NS9EYkZBZXFjNCt6WnplWVhPaitvcWRnRGpnMnBxRHdxMlUxZi9WZkh1d1gz?=
 =?utf-8?B?c1d4L1BJT3JIZjVFdzkrMlR3NXRvSjMvVnlucHEvaG1mNWdCMVNpVWE5ZXVI?=
 =?utf-8?B?VzJjVlVVRk4yVXBGRWU1MUJoekJ1MzhZS1h2QT09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 12:53:44.8610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 186f1b8e-53f2-4e1f-6ce0-08dda81dd5b6
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B97.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR07MB8583

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

As SACK blocks tend to eat all option space when there are
many holes, it is useful to compromise on sending many SACK
blocks in every ACK and attempt to fit the AccECN option
there by reducing the number of SACK blocks. However, it will
never go below two SACK blocks because of the AccECN option.

As the AccECN option is often not put to every ACK, the space
hijack is usually only temporary. Depending on the length of
AccECN option (can be either 11, 8, 5, or 2 bytes, cf. Table
5 in AccECN spec) and the NOPs used for alignment of other
TCP options, up to two SACK blocks will be reduced.

Co-developed-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

---
v8:
- Update tcp_options_fit_accecn() to avoid using recursion
---
 net/ipv4/tcp_output.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index d7cdc6589a9c..fc67c6760bef 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -966,23 +966,41 @@ static int tcp_options_fit_accecn(struct tcp_out_options *opts, int required,
 				  int remaining, int max_combine_saving)
 {
 	int size = TCP_ACCECN_MAXSIZE;
+	int sack_blocks_reduce = 0;
+	int rem = remaining;
 
 	opts->num_accecn_fields = TCP_ACCECN_NUMFIELDS;
-
 	while (opts->num_accecn_fields >= required) {
 		int leftover_size = size & 0x3;
 		/* Pad to dword if cannot combine */
 		if (leftover_size > max_combine_saving)
 			leftover_size = -((4 - leftover_size) & 0x3);
 
-		if (remaining >= size - leftover_size) {
+		if (rem >= size - leftover_size) {
 			size -= leftover_size;
 			break;
+		} else if (opts->num_accecn_fields == required &&
+			   opts->num_sack_blocks > 2 &&
+			   required > 0) {
+			/* Try to fit the option by removing one SACK block */
+			opts->num_sack_blocks--;
+			sack_blocks_reduce++;
+			rem = rem + TCPOLEN_SACK_PERBLOCK;
+
+			opts->num_accecn_fields = TCP_ACCECN_NUMFIELDS;
+			size = TCP_ACCECN_MAXSIZE;
+			continue;
 		}
 
 		opts->num_accecn_fields--;
 		size -= TCPOLEN_ACCECN_PERFIELD;
 	}
+	if (sack_blocks_reduce > 0) {
+		if (opts->num_accecn_fields >= required)
+			size -= sack_blocks_reduce * TCPOLEN_SACK_PERBLOCK;
+		else
+			opts->num_sack_blocks += sack_blocks_reduce;
+	}
 	if (opts->num_accecn_fields < required)
 		return 0;
 
-- 
2.34.1


