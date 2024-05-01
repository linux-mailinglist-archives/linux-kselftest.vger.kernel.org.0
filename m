Return-Path: <linux-kselftest+bounces-9177-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2617C8B8429
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 04:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 144D31C223FF
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 02:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD24746E;
	Wed,  1 May 2024 02:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AzehTrst"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439F33C17;
	Wed,  1 May 2024 02:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714529311; cv=fail; b=obgsGeE0TIc8W1+dC7miuAm6wHYHRIdg+lDZdvY5k3Y8eIQpm0tKnBd1mr0XJlAMOsGbDJ7vDuIXbGz1jjp+vYjS4jLti2VP6Qz7GLkVTVhUG1NdiTyHC1spnsVYeu3IYG4GUCO09Zcp2FO0hKqCHy7B+PNBbOOobL563WNAE7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714529311; c=relaxed/simple;
	bh=OwQN8gp1F3KVw6R3vwDzkEZAjgFzfAuG2u9tRLtD9eY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cXWTOt/88Wcy6LcuaeMm/1Z2vBHw1Tiud+E0A79b2sh7EXdnxhXMsKxVPLyxu3ewBruYdIQAsEqznE59mzO+WXzwoT+AhJRwJropYfUnTs7WBkqnXzrfi6waW8zCPNWmfgWmnKTnA0edXLX9PrgmxAl79Frp3Z/IVpgHATTNjTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AzehTrst; arc=fail smtp.client-ip=40.107.243.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9idxKtIlHBlfCRph3VvzxRRFw3Q6UgOz8Q/7LwXXHDiCxBYCSjBLlQgPL8dn2UbujXDlSsJdSn5PxmvsaJgb0dolu4d212N/457fhUsdu5npTMoWez/o48tt6pw5tMsvJa2nXIR2XJRvjJyzUsSvyz8t48bVbYLLCUr/DQfZxcbMliLNg+Xn1Dg5/L4lh9WST/YqHBt0e3AFwaYaeynw3kdB7QeGTGmQ1g+pxHoEemnzCrx7kVCSBQ+gI3RLkew2Ggr46nXh8bl0ERhkjiGlcvmKJSxw+fB7rlft9vmRRTa/Kbv/D83J8R4o0plgYaNc8xF2VAatv5CS2iS8n/bKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0vfJ85JOSr4rNqkaONoGV4VR0v1pDFVrmX2HWALeDho=;
 b=JUGhpQjHD1OZ0rYWZJUG9icL2AgLbV41rl+GrcYwAAH3BzFz912ePuV1zZ1iKx0c/4+lcIM9Fwo2BuwVZJD2MzmEU8YKKt3UC7K3Ne69krUT0ku8ILSUeg4av8uPFc5aMGIctymDnqQE7x3/eByQXFeOadJsMIreZtXEJMEVqTLyZhhEL2dHjyUab7Y6KmKhssiuJynAxReLDWGdQEold+hw2+NTHMa9DjK24Q2rTSBMidm92PGEWP1C8BnuMZVb8PIHfqZJZ0WHMn1xjywOQ+TJ2eCnpRnpscOtMK7jrAxt1r/9t6mPRbbnwys2MSqDT4JnzwGUUgAv440pHQ+QTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vfJ85JOSr4rNqkaONoGV4VR0v1pDFVrmX2HWALeDho=;
 b=AzehTrstDEN1RHwY9lbRgPbhPevAuLv55Zkq/V0S4Mmefx+j5nw8XMrS7er2JQ7T/NuSwlvs9I3lEixAQfyzGmdTFfAUSf3vVMc3ua026qh4pSLboWzta6UEAEIyR+32368QcTkAn+Ce9qHLSBQWFhwb6IAIHUrk2d6jswmRby+6PChuRgqUmkLf3uxgriY6IusqVFIVH80ruuJeqqGH5TGmsU/YSTUbtgVV9IWpj5bZPqy5vXYie8rsihqb6L14/jSus1DHN7ZhJwynoOqBzX2XtLVwOyuyKyZtGzZ+47SGzXfASiMkcyDFPjO0spbsj0pJwjgXpMXpSPOlrMmvYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by CH2PR12MB4261.namprd12.prod.outlook.com (2603:10b6:610:a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Wed, 1 May
 2024 02:08:27 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7519.035; Wed, 1 May 2024
 02:08:27 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Valentin Obst <kernel@valentinobst.de>,
	Kees Cook <keescook@chromium.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Bill Wendling <morbo@google.com>
Subject: [PATCH] selftests/harness: fix many "format string is empty" warnings
Date: Tue, 30 Apr 2024 19:08:13 -0700
Message-ID: <20240501020813.264878-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0021.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::34) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|CH2PR12MB4261:EE_
X-MS-Office365-Filtering-Correlation-Id: 254e9c39-5224-44d1-daba-08dc698396aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vJLeYDDceODdpULQ4R71yz9y+PQTUGtKEna3jqoniv0iFbIiwa0Y0Hb+OKSS?=
 =?us-ascii?Q?RsFLpGbuEImJzgaa40OKdXz5powBk51AuM3AWVKMOn4MnYqscMHijoSumQfK?=
 =?us-ascii?Q?cGA8orcGDtrd0eiopwbxHC3FvxgzImWbkFvIN5PfvYBWvIJoPVjYX6Jhc1So?=
 =?us-ascii?Q?wrFQ0I0K0x4QIyyRQ7MQjkrSgVAltTXXSDBQJkrooXfLjTD2BdQF6REHs1Mq?=
 =?us-ascii?Q?Cxe8PeaRg09eACSNFMWDyDNwWbRM5kxeh+ff6DnPowu61mo0zAwF9cCokynM?=
 =?us-ascii?Q?ZRswcQQF7FmfEN1Qe3UMryFpHCWYJ2Jw8nmivv81EEVnMk4EBS2Q8f43LxdP?=
 =?us-ascii?Q?uiYHx4wg8IQ2bCumULn/7AhN1w0llcVnEAAcmR4lXO8AIuWpz5Li5/+JUrIw?=
 =?us-ascii?Q?A/2OOI1iCZk55InDojN8QI3fvFammmmSBjrLDVP5PtBSTrOEMObeCOhL86Y7?=
 =?us-ascii?Q?uYokeSIXIG73gZF7rkuNJwucpVFibhxieF5jazmpf6kzHugPtnddZlF/IQTe?=
 =?us-ascii?Q?Xvy9N2xTMVdRk0BO6x/r20k7xI1Oxc7Adn5LuelO2iMOq01ZYLYBYwuoOEeQ?=
 =?us-ascii?Q?gSetYjx5gSYdX25MNSmhuaowP5vLoS3M3DC5NXB8yTN2VVDnpLP4NcxH+dte?=
 =?us-ascii?Q?MvpMu/NuuEznZR8Fcuu+0dEI+fd/tu7usqKv4F/5LfngCqNqfyiUEvyzemXQ?=
 =?us-ascii?Q?Y77xGXSy+8kYwVlOjaIlI6JjwMYl4f5jRpMCBJIQb50PfGZVQ8mIdXoPL8jD?=
 =?us-ascii?Q?fJ8NZBZyDarItGzRkWRrHVMIbWxMauLdW2Eqd+z0t/fvvcPZpQ4cTgEqDkkv?=
 =?us-ascii?Q?E8i7IEOG7uj/Mu++RCvI+jrMPvaV32m96siL1/gvldwjxuromY01jV2kLR71?=
 =?us-ascii?Q?Lp2Pywkv9Ss6UPtrOYz2qSdcErYmg/cxdJxdtio04LGES9PHr0kiIFcT03be?=
 =?us-ascii?Q?3I1owAKVWUiJcjXYzKJI711ayFTpiqEcswo+un38YhZfaczN6InPegEeHLzv?=
 =?us-ascii?Q?rSpnlvKsx+QssmPsSBEqEEZEB7007kugEuo1si6cIty9cUta86KlLNeDFaP9?=
 =?us-ascii?Q?tvG+z6jy8WPJB7UpfNfZ7//PLV3gvZGvgkQcP9r/L102EInsTmNDC8KlxeQh?=
 =?us-ascii?Q?KebwnMelvYjar3NIZuleXNOA5fOul0YqeNmBNk5Xfn5K3zGwvxQuXMiFf2B+?=
 =?us-ascii?Q?QACQt8MXZvkZ7plsVDb5SmZn9mIH/jq8XLeKCzru1+Tj8iF8kIE9+cs2pI2R?=
 =?us-ascii?Q?n2DqN0prfWChq5AqdQ0sRthTFSHc01MwgsrbXH8hYw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K3rRCNoBO7hwyv3srZXXZ98HTum+hmEib0jMU6W6v0dYwQRjVIlhAIjrNb3I?=
 =?us-ascii?Q?a8IiMhRQlzLJIqfhMAyfeqP+OagdB6hufAPeXgT+ILG0VwCwo7wKTbvaa6tz?=
 =?us-ascii?Q?aIXeDNxAbe8I8AR5okUOz1CjWoVIT/cbg47JCFMpVvpe9QHFtkXaEhNNi8qC?=
 =?us-ascii?Q?+/bNsu20H198cm3eOjYaVxLylxu51DON2zlrMOhwjAVPg/XIQD0/dNCD2ooX?=
 =?us-ascii?Q?C1KcXT6nymfzxUcFBHCkG7CJG1KsVfLNYkKalp+zNLQAgn/UkdcsD6EfA7/0?=
 =?us-ascii?Q?qxwNoyM7zgTkvTPArz0CAC5XAjhcqFeAHSXd+75EH5LCo96fp4IpcPUR3zxF?=
 =?us-ascii?Q?isoZC7IA9fUxZiAkbpxI6bDtuwbj1kKpSDwC6HfEeCQ05oO1XMsYjgVJcrPB?=
 =?us-ascii?Q?xiNmvspSqz7Ym5LSywncyGfdza0b2GBn0LVPoKhXibUs223bJOc9QKHDJi6R?=
 =?us-ascii?Q?iqxjr+Tmwa5SuxtN1i49xgRcFKOdQi2nyJkoz0rEWsNp4ZRoZmqJTsVJHNCV?=
 =?us-ascii?Q?2LKtbAey4tGmhe6m/tdMoMPJE9Hwm7uhGrUgoA+CCCfQJFyRR8KzcAfPmucH?=
 =?us-ascii?Q?EOuaAixaOqs2tI5+QLUYjyOEb6GO08yVjsZS/eLtRDx77UtLcdrfZesHf/Ug?=
 =?us-ascii?Q?DrHuUdwTE3sDo1+QMzpScL31L/Oc6f8Qr3N+fd9JB1wMqNQaglYNMAwO8/qr?=
 =?us-ascii?Q?cdPTHY2XfKf0uW80KHZsig9R9tEJl4SX6xgtWBHYsoAAvQK71Zbf3lHHguvd?=
 =?us-ascii?Q?OdBdphCGCc4gw6cySVqmDdNtt0A1TpjwJXZV9W9iU5bv6KtPPyTTGnM4QBtz?=
 =?us-ascii?Q?DCV6nSNkO/4/etVgaVDjkqGogwMy50Zab8zgm7tI/rX8M6R5JLzJWpLlum0k?=
 =?us-ascii?Q?3xAjxFvBzsnp4qD26vUmyJrLvuBycWRjKITzSbGs+05DHSqS0y4W67QnrP6S?=
 =?us-ascii?Q?0bjbZiv+36Z6pUDytR3JQR9rcoggNJL0P3O2bmtYd6SGgJUzQw0G2l1rIBID?=
 =?us-ascii?Q?2Ovc9XnCyNiR4HXRfFl1Cwsp3vALv1Q3GtPaSdjOLkhitms4689eqDAdKebY?=
 =?us-ascii?Q?192ul6U1Hg+9btGSCyBbIBG7KrqRs4wQasKJ8qEhZXaReaqkcAuY8fP8bn+G?=
 =?us-ascii?Q?Ph4dBs7AVgHFMGfX8d0ieiJtRIArj72pHz8LAFydJxZyXmwue+rAiioV0mZy?=
 =?us-ascii?Q?oHvxCx749NZgcCZhNLjAKt5kf3XIZRCvAXKRTTnWMnY0CbE14DRZzKoQ3zjP?=
 =?us-ascii?Q?CKEVsbyfvIFO6w7g/HWFbAGa2yTb9ZeT+OBKHjdwrE7UjQdTq1jP27MSKwoV?=
 =?us-ascii?Q?kwT8UygxoyrRk6G4MzMkxTTtylwyDXaP9BT6AzOjImw2CZrUpq4HqYEuQxA0?=
 =?us-ascii?Q?ulTu5H6F7tPKZzSyH61PWC7pklMBGTtBYwYNXuz6ZJ9vGMm8rKEoBTBjSiOL?=
 =?us-ascii?Q?TqRQOgD9ldplscF7QukuP7Tn9r7ud83HRLVC+a4ZTq/7tRKbTo6mDJIOPZEM?=
 =?us-ascii?Q?gW1KrOE3x4qJ7de63hLRZZhIEoiCTRBumbbW/HYylou3Aws00299BGOOnRZ4?=
 =?us-ascii?Q?fnfsGmabJsZjEN5rLITe83YZZjQnrWKKDXhJ2Jj7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 254e9c39-5224-44d1-daba-08dc698396aa
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 02:08:27.0202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JO2wL4HB7BFh/D45Eh6ncK5LO0N8GUlcco71xSgVvK89+CAPwIUPDDp9CUTWo2I6hoBFGlPTY+4zg5FFDj7AaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4261

In order to build with clang at all, in order to see these symptoms, one
must first apply Valentin Obst's build fix for LLVM [1]. Once that is
done, then when building with clang, via:

    make LLVM=1 -C tools/testing/selftests

...clang emits a "format string is empty" warning. (gcc also emits a
similar warning.)

Fix by passing NULL, instead of "", for the msg argument to
ksft_test_result_code(). This removes dozens of warnings and a few
errors (some tests have -Werror set).

[1] https://lore.kernel.org/all/20240329-selftests-libmk-llvm-rfc-v1-1-2f9ed7d1c49f@valentinobst.de/

Cc: Valentin Obst <kernel@valentinobst.de>
Cc: Kees Cook <keescook@chromium.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Justin Stitt <justinstitt@google.com>
Cc: Bill Wendling <morbo@google.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/kselftest_harness.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index d98702b6955d..456b8694e678 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -1207,8 +1207,10 @@ void __run_test(struct __fixture_metadata *f,
 	else
 		diagnostic = "unknown";
 
-	ksft_test_result_code(t->exit_code, test_name,
-			      diagnostic ? "%s" : NULL, diagnostic);
+	if (diagnostic)
+		ksft_test_result_code(t->exit_code, test_name, "%s", diagnostic);
+	else
+		ksft_test_result_code(t->exit_code, test_name, NULL);
 	free(test_name);
 }
 

base-commit: 18daea77cca626f590fb140fc11e3a43c5d41354
prerequisite-patch-id: b901ece2a5b78503e2fb5480f20e304d36a0ea27
-- 
2.45.0


