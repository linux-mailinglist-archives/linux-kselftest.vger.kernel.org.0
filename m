Return-Path: <linux-kselftest+bounces-24274-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 390C7A09ED5
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Jan 2025 00:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14997188ECC9
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 23:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29802206B7;
	Fri, 10 Jan 2025 23:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rikZQAlQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413D01ACEB8;
	Fri, 10 Jan 2025 23:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736553034; cv=fail; b=L85t/WlKckMumXqSphGAfsMqolFrL2mxPAwlBTMWStTvPdwMOifD/yKgHJjA709qSR/cA3/T+NYRrYRGnJ4fSDk5K507rKa290EoHQQEvZ1ZUcleFrq01sMFY6qa02zSrUiqimIv+gvK4jxGBgTb6GlqQjT0LYhewesJ2m+X1tY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736553034; c=relaxed/simple;
	bh=AtLKsIIsxMQyEEX0kD0aydaUfP7LX4JEygwoM29x6Ww=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tUKss7hfsOPrUk6m+eDc1TYcUke7p9xTbpd/Bspv9FbISx44k8MeBns6NNv1e/6ZeT/oD/wfeYaOV2Obg0GZ/fyzu+lgKNFlC3trbXBD3fYwIg4GbGotfODy43RS8cmcaHTI+l2Fsa4CA+79mhFMPtLmorN5Gw3NJM5ekQXYsMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rikZQAlQ; arc=fail smtp.client-ip=40.107.94.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UVPLjhs4T0KxFAtQePS3gmFnADBxjEXF+UxGrN98EtUxMkkFtLXAE6Ijj3IhKHzdjf1pFLbxvgBHAARN3h7AutPEpvTv0yiArcVmS6yN8GFojLpPafPSr1ZFlrG31LzFQPxzrNYXu2ndg7AIhUATAQfxKAjjIj9gBu4CYTf7qVagbIkWj3q+DXsTQOUWnqNFwlnAjh0oIGulhXbhtPt1fbHxfxwpjfwTbn27d0svmH0rBOIAptC3S6HvaUVsdoMfgw0e8QNCl3rcsRpdgA8uYkURPb2/ql3waJnKDA+qQuik80q91v4Fl/41NjsB4wiGkIe2dH/nKEqAxoXCYwyjMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pvuo0DQWBpDZQjd2+y9sIIdbZUUKkDzGaFuMGZpzt3k=;
 b=XHOXLhpNSrtUD5seJogV1RQK1tU4er52pIJniR6KQJmMTxTUNhVyEXIT7FGvO9uJLWc8yokdLUSgtUAa8XCatnY4K4q7lriWJ+03NC3jBDDCpxp0zRk7pMjRkzjlvU1yy70MpH00DarAtw86jTtCBX1A/VMnB+HUmWy4Wfs7v2qZZP5SGBEDEmVQMQuEQG6MQfmjRubUahL3887PuHPS7XCFDJI7QyktVx2zAji4dwYeq8oFQZE0L+hrrz2PuuBPp8U85t7jjMbaVbHIOQgnsSAMy2dx4dD7ucLAEIa4Sm1+jvpH4D1CKh0nJ50recgU5tqVgNnfOfX9lg2h6uezKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvuo0DQWBpDZQjd2+y9sIIdbZUUKkDzGaFuMGZpzt3k=;
 b=rikZQAlQiaGyVWG0pW9gqXKpE/lTZPcTLCppEnGci3df22Cz+oXtSaz1JPx/lC9oT64tMRvM+Z5TicH8RF/kYlQBcjkGeBGRzxTL0SmQSf9kIx1IRSA0A7kSNEhxrc7jml2kFQsMPmlRukpiR8wM7n4iLGW0mQC4Lug0ZhvyrCeSWnq5PTpz9qyl2+wgYrOK0XRVxQgpLRj/batmgamPQg5lyWslhUwcl5iCyxWh3q50UqQFgh3YDDM/olf34rOqaWdKrYyNt8bSJegL+P+NCGeU6N2BCr3CjOCPRKtr+s+tyiDm6B/6T5rSaTYFZiMhBjVYxIo9ENAxHzI2M26iTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CY8PR12MB7753.namprd12.prod.outlook.com (2603:10b6:930:93::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.11; Fri, 10 Jan 2025 23:50:30 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%3]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 23:50:30 +0000
From: Zi Yan <ziy@nvidia.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	Alexander Zhu <alexlzhu@fb.com>,
	Usama Arif <usamaarif642@gmail.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH 1/2] selftests/mm: use selftests framework to print test result.
Date: Fri, 10 Jan 2025 18:50:27 -0500
Message-ID: <20250110235028.96824-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9P221CA0019.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::34) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CY8PR12MB7753:EE_
X-MS-Office365-Filtering-Correlation-Id: 46ee9696-2a14-49f0-2e82-08dd31d190eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hNGo5CZSqNuLXVsqJZdERHIzPnKI4mY2kFYLOo+IaXPrchvhktmvzWC3iQkN?=
 =?us-ascii?Q?LYIHbX9qfE+LVlZ7ELL55+q+TDzqDGO2aFhu6FLsb0mReYmtLiSKc9gulE++?=
 =?us-ascii?Q?qlYsfKk5MQHz7YU7DaxrZm+LLtB4ai0M3Ryso+KT4CWuNKOmkVMt/0hOyrhh?=
 =?us-ascii?Q?KmiOVzr49uSMaQvLiuuS3t/7TY5jD72VlisS2WM1Ny25gPgxYhD+PM8qSwB3?=
 =?us-ascii?Q?Z1xLfokg/IKrzDP6J9HMzRdrh/dHZPNjM/jxmnaCEaD6g3yNBfjLkcMZVBJ2?=
 =?us-ascii?Q?eu6C4fN84GFB1lfOFjeAVt2e8BurTVx0nuRsMW6ozIrHxVE076Zz09wcKz9P?=
 =?us-ascii?Q?n1SH6ZHIcQoP9apMCMSWK1tBy5EyJZkhofeOOBfJEw3COQzTRmUr9GHqFSRK?=
 =?us-ascii?Q?1cVa+Io2iS+IUfagi3EFrjo8cmSkip/hscz8ygyoyKnKg7fxAcHG/1a3FQpG?=
 =?us-ascii?Q?Z989nmT0YuTJ6UJTqk84swJGI8TVZswTpeDAiutHyVQJXHSCb2fldz7nich4?=
 =?us-ascii?Q?RggEKSqgvCv58QpaMa1dw9BFiSmQ3js9BMfrAtb6Ds1PMpTDL0KAF5qhv7Ba?=
 =?us-ascii?Q?i6ERruLPcJYVD3vFeF650QkZJooiZj3HtIPfdpjhqi3nVjp9MMj3zfnzKWxy?=
 =?us-ascii?Q?w3qD//oppgsGMi80j9+gDbTnaAREQitGpNUHZgkHS1h9LqGkBD4uv0bm8gso?=
 =?us-ascii?Q?QpyCklvL6zIqrIE4FixRR/yTlBwQmtRC5jTdW8Q9skP3F3EVPzjeTODZUrFR?=
 =?us-ascii?Q?fZNQQYvvz/6mM2nbUdl3G0BRRorueIl4JsGoBE5XrqG/Ykti5XQq9k0orcRl?=
 =?us-ascii?Q?DitElQhSFuZUTpwIzRUq9ksRBcf0+bfKfMZR69JR6zX+4Okq9hgAQEvpu5Mx?=
 =?us-ascii?Q?eJ1By8Ros10U18+1aqe4eYxazWAchlMqb0DlNTG3bN+1vbHT2FzCJiYIcdGn?=
 =?us-ascii?Q?UvkfbJHd6+kdo9+PAYj+t9ITQr6gBI2Xn4N362i1dW7a84ZA32hbPZ7A9nVb?=
 =?us-ascii?Q?BaTGnd4fBuTKvTHqBES5mLSTUxHqBPq2sLImobdFBkBHRdI9wPNQqCm2glo+?=
 =?us-ascii?Q?sZIVbVS0ig/4pCbklTInzs7g0kMYq9M0f0BEz4ae/htgsc89hqsTAWoERoDP?=
 =?us-ascii?Q?Ckxf8dArJywHaLdRPRGuSJBln6uwuuWjCK3zAP/eFybu5B6U4TQfZO7Nefs7?=
 =?us-ascii?Q?MnXqTSuJcFCUO1QHLJyCR9hnrpmY9izv8LuaNHTq1OMEYPoFNbThAeucCzO/?=
 =?us-ascii?Q?5EheUgxr1OBMDH2lrbyI1aRahSG9ykVKzv02L8yKQg46gvEf2uQFlOL6uVg6?=
 =?us-ascii?Q?+SlmfXXEsSxUy+Fz7cSeFq4utj2KQICLjIV57pBZVaaDFX2fpaLNarwVW2PG?=
 =?us-ascii?Q?QTug/OgyRhQ7CZ1zyEQl+9pWoDge?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pC4q3dHGSIXZjCaQuRnye32XPNzXlz9Zll+X7pVnVgPocgYM3qHZI5L2v4cG?=
 =?us-ascii?Q?0Ru5bq5HNoNTGmyPVAcqPzryF3/3FcYMJ1eiMTw1OQX4jNRcR23eoZxKU7GC?=
 =?us-ascii?Q?PMmX+i6mWldN+OFz1SffOqY/lv1SHcLAV4ojh6aFosT25eTc5rQO9pQrObJL?=
 =?us-ascii?Q?udGeKfXo4imk4DHWzYxX2gTR2VJUZ3CqzVQdxrLb/y6NUiQVQnYJHc6nsI1x?=
 =?us-ascii?Q?OorQzHnOw2gRoVqIwwkQzqn1LVtPNCws+/TH/7MXRGhSyphd4YDCaEkb3Mwm?=
 =?us-ascii?Q?yH1qw5OAkMnsIPrAUDzXfdm/UVWhwZ4IVycTQTV+C4LfGbWmBPQP6jK4MaHP?=
 =?us-ascii?Q?T/NFPP5CzT6ANACavdF1slupe3S0VJpF6C8HVifsfK1VXcUPoiMK4qvASahV?=
 =?us-ascii?Q?CUsBxIJVgOgw6plrLAg5ur2v/jOEV4q49KFo/dXbDH9tZsetFFyYg8wSuOl9?=
 =?us-ascii?Q?+SJbdWINBVtyviyWOk0cbJam4eMyol4FYS9YA+TSkaVpJtZwkmNNSDMEcS6d?=
 =?us-ascii?Q?ZV0rfGMHq6oWgLeNLNJ7kswRpTfPUGugWrKYr5pChWOGftmW0U5i9d+nj3y5?=
 =?us-ascii?Q?rk2IiL/oS0byLQat6agJqqhKi6t7KMs63kBstixTJ2EshrBA5jxOlZ/eGR0k?=
 =?us-ascii?Q?IBC3wPlNa7BnXH16eIoOnr9xpjenLiYuzNZNc3NCc/tFuh4DIKgkyJW5L0fT?=
 =?us-ascii?Q?tXZM71xge1hc03m3X/GPPGaonSzKU+7UZkqAES2CAhsLkafNKPOvF4sLjXtd?=
 =?us-ascii?Q?lSwKVHyWe3NSizWXrnYk6jYorWnZyE89wiVlpytC3fId5uBS5HHzfskua9VV?=
 =?us-ascii?Q?cdELkkaT3ZaX2z35Ol7BWtcLXLwleHW272EA8cwNGuaJoY4ciNas+nsvoL5f?=
 =?us-ascii?Q?Od6IEpqN0L3JEChFuQl0bZDlHv9xX2ze/5w7AfYr9lGp01j1kMDu0hrLS5ro?=
 =?us-ascii?Q?sLjPXD7iQ0AIhGAkmvwhrH3JKUlARzxRnADLV1zhQWCeCc7/aZJ8ugKtOtA+?=
 =?us-ascii?Q?gp6gwBISZj55a33cFJUwhwKyOIskWlFs33/6OVRpINw07RRWYyasyGcDPs/o?=
 =?us-ascii?Q?ieyfhtbj+lZfkenodLqdtxIgyL67kyw0C+OMKefzrdnGMzrH7FO1dwAZF9rs?=
 =?us-ascii?Q?5w8FQUkXpERYi5oAZ8V9iJl3Wq4zk6KXbQ6r0lLKxj9XyHCdf+qH0HNEKO1P?=
 =?us-ascii?Q?tI0NNSLQ513ZQu2O8tD4mJQpHIJdwgimA6l9iIAmZHx1o665eLbk25y8Nfbf?=
 =?us-ascii?Q?5BTGsyI3YaToTfn10gJPujg9hWD0Fbwax4E+3LZfExFhbz2l2FW4FmgAij6H?=
 =?us-ascii?Q?deo8fgAEsOffPB30cskicdNyH9aW4seP0cC6ITQ5XA79V+82zkSVX2k3pBo3?=
 =?us-ascii?Q?1iXR4lhxUp6+MjN+5Wo/bzXEpfnVE38g3bx8qBAHayq6qZ6rb0PvBwzAdgOg?=
 =?us-ascii?Q?3HN8n+TPCzZ6ozAIpRccjQGsuD54mBupjuHCtMKjV0Kd49ENX7WMOfJbckfT?=
 =?us-ascii?Q?/llBQFGdRo1ozs3WbSFH5MO1hYmcnIdVcJ5iE2F2yY9oq8AsDwFe//7paOaX?=
 =?us-ascii?Q?QQwpmGmURVh1Gy/dd2I=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ee9696-2a14-49f0-2e82-08dd31d190eb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 23:50:30.7037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UeA6fN65/Kz+E3r8nFwQMHYcqR2tZ9hc+nDenfZG1pYwe+nn8aifS03WYyFmwBFK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7753

Otherwise the number of tests does not match the reality.

Fixes: 391e86971161 ("mm: selftest to verify zero-filled pages are mapped to zeropage")
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 .../selftests/mm/split_huge_page_test.c       | 34 +++++++------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index 84b1251666aa..128004308233 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -108,38 +108,28 @@ static void verify_rss_anon_split_huge_page_all_zeroes(char *one_page, size_t le
 	unsigned long rss_anon_before, rss_anon_after;
 	size_t i;
 
-	if (!check_huge_anon(one_page, 4, pmd_pagesize)) {
-		printf("No THP is allocated\n");
-		exit(EXIT_FAILURE);
-	}
+	if (!check_huge_anon(one_page, 4, pmd_pagesize))
+		ksft_exit_fail_msg("No THP is allocated\n");
 
 	rss_anon_before = rss_anon();
-	if (!rss_anon_before) {
-		printf("No RssAnon is allocated before split\n");
-		exit(EXIT_FAILURE);
-	}
+	if (!rss_anon_before)
+		ksft_exit_fail_msg("No RssAnon is allocated before split\n");
 
 	/* split all THPs */
 	write_debugfs(PID_FMT, getpid(), (uint64_t)one_page,
 		      (uint64_t)one_page + len, 0);
 
 	for (i = 0; i < len; i++)
-		if (one_page[i] != (char)0) {
-			printf("%ld byte corrupted\n", i);
-			exit(EXIT_FAILURE);
-		}
+		if (one_page[i] != (char)0)
+			ksft_exit_fail_msg("%ld byte corrupted\n", i);
 
-	if (!check_huge_anon(one_page, 0, pmd_pagesize)) {
-		printf("Still AnonHugePages not split\n");
-		exit(EXIT_FAILURE);
-	}
+	if (!check_huge_anon(one_page, 0, pmd_pagesize))
+		ksft_exit_fail_msg("Still AnonHugePages not split\n");
 
 	rss_anon_after = rss_anon();
-	if (rss_anon_after >= rss_anon_before) {
-		printf("Incorrect RssAnon value. Before: %ld After: %ld\n",
+	if (rss_anon_after >= rss_anon_before)
+		ksft_exit_fail_msg("Incorrect RssAnon value. Before: %ld After: %ld\n",
 		       rss_anon_before, rss_anon_after);
-		exit(EXIT_FAILURE);
-	}
 }
 
 void split_pmd_zero_pages(void)
@@ -150,7 +140,7 @@ void split_pmd_zero_pages(void)
 
 	one_page = allocate_zero_filled_hugepage(len);
 	verify_rss_anon_split_huge_page_all_zeroes(one_page, len);
-	printf("Split zero filled huge pages successful\n");
+	ksft_test_result_pass("Split zero filled huge pages successful\n");
 	free(one_page);
 }
 
@@ -491,7 +481,7 @@ int main(int argc, char **argv)
 	if (argc > 1)
 		optional_xfs_path = argv[1];
 
-	ksft_set_plan(3+9);
+	ksft_set_plan(4+9);
 
 	pagesize = getpagesize();
 	pageshift = ffs(pagesize) - 1;
-- 
2.45.2


