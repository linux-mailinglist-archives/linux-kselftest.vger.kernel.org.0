Return-Path: <linux-kselftest+bounces-9316-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9638BA589
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 05:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5FDE1F22366
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 03:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7A95914C;
	Fri,  3 May 2024 03:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VROUjg8z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E0538DE1;
	Fri,  3 May 2024 03:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714705357; cv=fail; b=lF1dIVBWiSX2TR/xMLcdHicc1nk/4/AR8bChlXNwZcSKO9O6o+p9f1zrgAjbNoMgUKcVpjKvA8kDJMhhB6FanqNTUTRra2gjFsr4aSurhHUCNDW9F9ofWA78iFHhFaIoroRhVdSULdCiX2+WcPq0zF8qFUUrzIBR3JZeRye1wnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714705357; c=relaxed/simple;
	bh=q/s+MCqqUwm9QYyXcfnP6HFL7eldF6hXYw3yadOljDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YB29xuJIyUB3Gftjnx34QfxPBClAwkjUllrRnZ6O/WWN2PLQybhzw+kjw+GS2zZEKhUpjSyBANSu2hoeM/MkxNB+uReyK0M2oW0HTepMH/gsJ6L4n6hAe48YFLmMeoM9ds+J+60xhanP1GwEsG/GcZsMmDW88p33+/MrFwCSjxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VROUjg8z; arc=fail smtp.client-ip=40.107.236.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SF5nKRaO3bYY+Npvw9mp0TtDy/iNPW4XslqM8BoL3ucuwiHvnNEL2XMnFcC0rDfqCbAZWfUQpBPFIGnqtDvMa6FBmYg7uV8529cjvBYciz4P8uq1SDhD2lqfvW9D8uvb99FY7UkwY5qZXr8Ky5Suuhz0lVo0pB7+tUEeXNCVqRctPuMWpn+cPRy9HXeWCc3+mIaZmmcSv4rRxRzGtAt6ji1iclS6EoxxMQJaZGChL4MPazvz3d/Qo/nEzHh29ypQlsahL713WdGFcAqs3IQa7kMKeojO+8zs/D2R47mZiFzCA8pyS7z/QkomFaVt7fzuhDVOghv1eQSQfm1pR4Ykig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sRSf0YN+kJmQNBcetisQfacrBGQy+f7g8zeYtQJYIXo=;
 b=cNDd97JMDxE8lDw/qs5z/9T6LP1p0kjHWODLXtm7sDodF2puQqnE5L3A5gH3YzKuNV5W92Is/9xFjCVgW54mLsZxWgRVAqxVPsr/ZW8tj6qfUA3klPiZKwb5bLvOSqQsk1HArVEa961nW/z02sm5bBU/NcLhmLhlX89ORqzf+QQmongFaTPFKohb2fnsi/E3xM3Lg+fYnq4yxAGsGxHtLipzKipD1IyC42Sm6EDQMwvp5R1qVM7PljmuxKdAa53Z1kiXpO2cboxrKHkMmy74LexX8PrDPUgMULCOuiCLZ1NioFse7zBulwj2Qw3XDNauEVtgOijyFqDSfYtnf18eOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRSf0YN+kJmQNBcetisQfacrBGQy+f7g8zeYtQJYIXo=;
 b=VROUjg8z6N2jy56FLiR4C6nsIbfuz1ZEn1JCWKAH7eziF2adA4RltzBqnc0uoeZMY4a3/FOnmR8m+AU7Gq6hYIVHb+4mg8+NTTrzxp05iOH+yUPT0G9EtDw17fn8bqax/UtRQmrYterXRqEFw0BrRHZCdtlCX6lUKjKhEnHTU6VsvJzuchVkvpYfgYBDvEevN1QIKMrFNk1pvpx1kA4CX5ynOsCzQXgiGJ2sd3ak4KQtqJf4uP2c/vakY7YZlN34XiCJuKz2m04oK+gpxaywN8j27GKjdSF9E34wJKcbHdnB+ohOq47BFhybGPvDPMeyIdmtRYhzw2UV2FMreGEE/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by LV8PR12MB9109.namprd12.prod.outlook.com (2603:10b6:408:18a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Fri, 3 May
 2024 03:02:25 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7519.035; Fri, 3 May 2024
 03:02:25 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: angquan yu <angquan21@gmail.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Yu-cheng Yu <yu-cheng.yu@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	x86@kernel.org,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 7/7] selftests/x86: fix printk() format warnings
Date: Thu,  2 May 2024 20:02:14 -0700
Message-ID: <20240503030214.86681-8-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240503030214.86681-1-jhubbard@nvidia.com>
References: <20240503030214.86681-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0007.namprd10.prod.outlook.com
 (2603:10b6:a03:255::12) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|LV8PR12MB9109:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eb231eb-789e-4e70-4b9b-08dc6b1d736c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DgFiWw+ltA+agySUdx2rlsmnyjD/jUgZQsR7cqceYsLdLxoyumaxwrHRNYad?=
 =?us-ascii?Q?ZZsRZtn+7eOGsOqea0Snz53DC0ZK+HXmo9lu4H5WgmZLg8qBhltMF3dUTNQK?=
 =?us-ascii?Q?XIFql+EXtTADLQhJ4w2s2dbP0u5U7s609YRHK7C2BRcJEPSdbJXPhhLoTh7U?=
 =?us-ascii?Q?OrSlVvDn8HKrN45OEVHw+HirlTwSaoQWeGdjlws0vQT+bBHKHOh61rzZJPt8?=
 =?us-ascii?Q?M6kDbEit1RpZSGVy+inVwJcFDjfbIKCJqmUaiEeSNQsdJ1H0OxceSNI9zm0D?=
 =?us-ascii?Q?0ZvuWJ/+LV8E4rHmD4kwHyC9rBl4lIMxnqX4G/urgIPqXthkUkDNOjVf3U4D?=
 =?us-ascii?Q?qsrN0pC6GiXqGVTQixjVL76800aS2jyv7Bq9k6fZgRfUK+/OVNUOKcJ6yUwx?=
 =?us-ascii?Q?FRBQDk/vN4ngO7dW4v1x9VR1XqKIQeTQ07Q3Kz9z36NFRKpLpS49+tFLO7Hy?=
 =?us-ascii?Q?ejJaQONHPI0WyQ2fpIjhu/ylrJMm0jHVJ3fKuWLfE7Roa4755o8LswW9uxOL?=
 =?us-ascii?Q?ZXLSax9kL/tyHRGjQ8dFFFqXaVGGYEKraBwK64SQORWzIBJa25Cg/FpN/riP?=
 =?us-ascii?Q?m7nQDPKs8V51cR3+h64qIewsfvG02eNieCKCVCKK+u7TjHSPDWtk+UBoyMje?=
 =?us-ascii?Q?Ki3AFeyoaxJwQQZdChjpQAiadbZhga9eiLX+eGBSlDEm+5qY2pmRW9xPdr/F?=
 =?us-ascii?Q?soxhScGKljP6wGaPmf5T9PqwLG81DzV78cguEnOn2bX4k7M0KZldEnmZfDAY?=
 =?us-ascii?Q?odMw30w8ezQUtw1NkusEtuqAElNfa5qVBauflMq8yPG/sUKW8Ibt+n8F6uqd?=
 =?us-ascii?Q?etmAZ6B+KJmLITx/gqYhtSFHqxH1PQYoEBkIxs2V0ucLWB/XArQb9XIZdAad?=
 =?us-ascii?Q?dpy2tbhHyippYXt8W9m8vWeE1wIpChrOVpb+Ej2VQcir1Hl0/+XaS9/v1emC?=
 =?us-ascii?Q?+v/h4jlThxc8dQPwKsJ9vu0uFY/Y2U6ElEdlL/o3fRmjzksZdnePRBHgBido?=
 =?us-ascii?Q?fB8EncbaMX2Zs58WZ2lOZUifT+6cUvv+X1ZB68IfIdu/Abdl2ok3L4RxXHue?=
 =?us-ascii?Q?9Deez+C84NWpvqQX5WF3lTUkZsnQlucGYJn/UjVRblw1POSpAiyOYXqovBBD?=
 =?us-ascii?Q?ZWObWcWHZRhVubtbeehaYh+LQ177OHzDZF0HKQdBaWKIi21rg1SISHogwu0z?=
 =?us-ascii?Q?HlIjDVOqQcXScEq3Ku0e9OUzEdJNduA1bLp/77NmEUwmVqdkmCc1Q7+EsPjL?=
 =?us-ascii?Q?KYnTBFpRWiyFvQtC4EYHNoDLwI1PfRb7C0nWUEPLYQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sfgQyftVYjX4rM8wchjQ7H/ceO57SYB1RYIl7HLHBn3O1N0JV9TwdEIO67gY?=
 =?us-ascii?Q?1CLcVsPSiF9BHaMeBF0PSc/+TzrmDRDSywW7OhhoDnAJGXVuQfPMWelXcp/o?=
 =?us-ascii?Q?5Jz8Mbd9z9EthunghZy5NleYn02Abn7j3sBnwulD52qv9/zZu9SXZKHQII3h?=
 =?us-ascii?Q?1dRFY2E3+up5imN2+Roj4xEetVBbLfMNK59FpH7dVqxEhTuUheOBzQO0lHRa?=
 =?us-ascii?Q?c+SAOY4P/sgvEahqMfJJc5t8kLd1TNtXQv2nmu1FO9WuZbL+fh6uTLDuMUNZ?=
 =?us-ascii?Q?8I66f6HjBQYDe4tuzILtjJ9/BVEtepIL4umH0PuPrGvdHdlNthWNWkSexyhm?=
 =?us-ascii?Q?9awVfovFU8ONrxFDnDkdz7SDhmXYUYnItiGqhpzPqa8ySWW7Yl4AOdjcEUkS?=
 =?us-ascii?Q?GgTZyie2u/54RoYn6CMChhGluEyuv9HuV09a04z5NPVu2r6NAotPmFJu59Gw?=
 =?us-ascii?Q?ipwyKFgDPSC/sjAJelXNlA63wqwDV9DIZ6uNUhIq21cFc74h96tORw0UN3hW?=
 =?us-ascii?Q?+I4A7lAWksiPyaKRytxIthNxQSh5i6suXUWYqoyYKb7mIH0d2oDlqNamuTNb?=
 =?us-ascii?Q?RgGl2hilBTgpHLczin9tVu6zKxKTxWabmY82cyHh56/L2660muhAbONw4d+y?=
 =?us-ascii?Q?yy2noT7hEzuij1Jo0zU2+7hm+zdtEDwpyEFelonSPEI95kYh59dDrFe2C1+A?=
 =?us-ascii?Q?xwipmFvL5GUGfoLukiT9X8F3l8W9ntY6kdGDIdSO3fqWTW7Fo2lzCIWq5xdi?=
 =?us-ascii?Q?QcWQjgYkn95kXoYzgg44ZlncmbAFkYw7Qi1ry52fRtwNgeQmw+fTrIeW8vMH?=
 =?us-ascii?Q?qEmV0EB2YvUyqWneV0bI5ruMGOx3dIKj96yOI56lFp7mWnDDetXkae9xD/TA?=
 =?us-ascii?Q?pj3xEA3S0//Hqzf+uXOGrUJWZrGxbDMkebHnLfgZg44ipYxxiIRta5hjxYeK?=
 =?us-ascii?Q?PUt9nn8lqUF6PuD2kBM8dge9cxp3Yd99+0lFZ2ZZEIg8bThX0kZ0vo35Md3P?=
 =?us-ascii?Q?WY2DKW1g+IuZiP/0LzhNOeD+5FEQJy9ru8ei3B6ZbO8uiOkJtNoqVqjDponA?=
 =?us-ascii?Q?fXQHE+fDpnYspZR6T80k1p11J45pXEA4OOzWxogT1LEpNCDU652jsL6TP9sU?=
 =?us-ascii?Q?D1JnhyM0tdddDRAmDCzez8MU0IRRPil8scBf4lLtdSkEkdejyN/dLCOaS2+i?=
 =?us-ascii?Q?8qAVKc8z+UtrSvfkETxwuy6bHzVDCgp6aHPO/AvdcOJ9Z/VYBNtRvj18i72k?=
 =?us-ascii?Q?8wJudmVwYAf2jBAgaGnqGqDVUNj3R92Kpok0E/gX4xoexHYt7hOgx3SH6Xsm?=
 =?us-ascii?Q?DTOTLN6bFR1RJ5nFySIgXNts0XFqWb4zHJjHTa84ih4SE9GKmVlMj74RTE/m?=
 =?us-ascii?Q?5EnDXE8ND1624lMREmF3XVaYEkiNCl5NQYlxDpQmyYJkBLKhjNBMCr7lTBoz?=
 =?us-ascii?Q?xGill77w8KIMIZkB5edXBrXtkTTmaPnHojzyuz2C2umDkx3B22ksIMwj20Un?=
 =?us-ascii?Q?Jm91BK/sMRp9hL264trcz2arADmPx4cOJcinrR7tB13J+AVeJRm3U1pz/im2?=
 =?us-ascii?Q?1o55h/HxmQy9Ily7NbL6LjLjGDXKsfA7q+Qx474L?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb231eb-789e-4e70-4b9b-08dc6b1d736c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 03:02:21.5391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cYB/eqgx1kdCi7hTY9QaRzB6sR/EpFq2F7of4HKWLE9ofgfGAlROmaMBMbi80fpiOgPq5ltfNQcYpBmOXwO5qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9109

First of all, in order to build with clang at all, one must first apply
Valentin Obst's build fix for LLVM [1]. Once that is done, then when
building with clang, via:

    make LLVM=1 -C tools/testing/selftests

...clang finds and warns about several cases of using the wrong integer
size in various printk() format strings.

Fix each by matching it with the size of the associated variable.

[1] https://lore.kernel.org/all/20240329-selftests-libmk-llvm-rfc-v1-1-2f9ed7d1c49f@valentinobst.de/

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/x86/sigreturn.c     |  2 +-
 tools/testing/selftests/x86/test_vsyscall.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/x86/sigreturn.c b/tools/testing/selftests/x86/sigreturn.c
index 5d7961a5f7f6..0b75b29f794b 100644
--- a/tools/testing/selftests/x86/sigreturn.c
+++ b/tools/testing/selftests/x86/sigreturn.c
@@ -487,7 +487,7 @@ static void sigtrap(int sig, siginfo_t *info, void *ctx_void)
 	greg_t asm_ss = ctx->uc_mcontext.gregs[REG_CX];
 	if (asm_ss != sig_ss && sig == SIGTRAP) {
 		/* Sanity check failure. */
-		printf("[FAIL]\tSIGTRAP: ss = %hx, frame ss = %hx, ax = %llx\n",
+		printf("[FAIL]\tSIGTRAP: ss = %hx, frame ss = %x, ax = %llx\n",
 		       ss, *ssptr(ctx), (unsigned long long)asm_ss);
 		nerrs++;
 	}
diff --git a/tools/testing/selftests/x86/test_vsyscall.c b/tools/testing/selftests/x86/test_vsyscall.c
index bef6abac331c..63aa3abcd741 100644
--- a/tools/testing/selftests/x86/test_vsyscall.c
+++ b/tools/testing/selftests/x86/test_vsyscall.c
@@ -328,7 +328,7 @@ static int test_getcpu(int cpu)
 
 	if (ret_sys == 0) {
 		if (cpu_sys != cpu) {
-			printf("[FAIL]\tsyscall reported CPU %hu but should be %d\n", cpu_sys, cpu);
+			printf("[FAIL]\tsyscall reported CPU %u but should be %d\n", cpu_sys, cpu);
 			nerrs++;
 		}
 
@@ -347,14 +347,14 @@ static int test_getcpu(int cpu)
 			}
 
 			if (cpu_vdso != cpu) {
-				printf("[FAIL]\tvDSO reported CPU %hu but should be %d\n", cpu_vdso, cpu);
+				printf("[FAIL]\tvDSO reported CPU %u but should be %d\n", cpu_vdso, cpu);
 				nerrs++;
 			} else {
 				printf("[OK]\tvDSO reported correct CPU\n");
 			}
 
 			if (node_vdso != node) {
-				printf("[FAIL]\tvDSO reported node %hu but should be %hu\n", node_vdso, node);
+				printf("[FAIL]\tvDSO reported node %u but should be %u\n", node_vdso, node);
 				nerrs++;
 			} else {
 				printf("[OK]\tvDSO reported correct node\n");
@@ -373,14 +373,14 @@ static int test_getcpu(int cpu)
 			}
 
 			if (cpu_vsys != cpu) {
-				printf("[FAIL]\tvsyscall reported CPU %hu but should be %d\n", cpu_vsys, cpu);
+				printf("[FAIL]\tvsyscall reported CPU %u but should be %d\n", cpu_vsys, cpu);
 				nerrs++;
 			} else {
 				printf("[OK]\tvsyscall reported correct CPU\n");
 			}
 
 			if (node_vsys != node) {
-				printf("[FAIL]\tvsyscall reported node %hu but should be %hu\n", node_vsys, node);
+				printf("[FAIL]\tvsyscall reported node %u but should be %u\n", node_vsys, node);
 				nerrs++;
 			} else {
 				printf("[OK]\tvsyscall reported correct node\n");
-- 
2.45.0


