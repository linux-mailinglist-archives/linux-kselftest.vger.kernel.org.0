Return-Path: <linux-kselftest+bounces-9489-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE578BC401
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 May 2024 23:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A46972823E6
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 May 2024 21:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5F47E56B;
	Sun,  5 May 2024 21:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tn9gq/zp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857E47D40B;
	Sun,  5 May 2024 21:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714945656; cv=fail; b=N0SoobSerfIUXTZd0aW/cq75Ev+4vRu6DkP/4qQ0FGjC6GR1j/0wIv6LeTmKSX6irEoa3kUjAJnAUQ9Lgcb7uVS/+CNjL9iBDlRpfpt4KDGJgWa+sn3OAzK/6bC1GAvJ/g7/K9Kvv9vs2deyNclMwkpsK6XaIQj+YK2v0q3SZ5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714945656; c=relaxed/simple;
	bh=XacfLRQw1yUePRYMz7AsYkCowpt13BJNCt/3+EfSq00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FQ7kcCllHTOmehY93lSfESRUdea8RBZi66+UpvwmHvBWbWp4VrqxhksvmWUqfVReDUSmPw7/9MLwPocAew3JZOPVoNW5uIQKuDIWG+RQNsqMXE6NQBu1xe/ViCtrXzESN4K0TITXaSn8k339Oq1KUNHYVxI8LEFF2mrIJK13Mbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tn9gq/zp; arc=fail smtp.client-ip=40.107.94.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zt2M4fro7QH5ixbGMfsdXMq5lHPmzW7a0ypjLLpQaPmRecUEaQVzrbfhkJs39LWk/dikWmwKe+2DRCErSg6xmcoO2I9SFufDcowG5/Wsyl9EL/vwIoTpoywlKIyaWBgIhn4kfRsFTgj6faW4L3wZt6tS6RIpiEcOUwfwxoav8AYaJRUYjCQkm3BQLDizFNLx5F7xSA8TEaawtYewQJ7SjLXE4BeMYJ5zsTfTuzMKgTcG+iSOxaCcHCqHynzkRwqSffF2D1ohjrTVH5PBvqHmB5Cz2dSJx5rpbKYYIAgzRHj80RGaklzZVc8O1921Ouhu2szCsVmNjBTmw6hZ4fx4bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXCsCCwEiGhjgUtDPbCjDLRGRxfOzZaSLbP0XdJdUPA=;
 b=m14HvLcYVBHDwCTNYQ6WwuWWynvGFYKTnS0ibo/RRqajs/lV8JVktb8VbY8HA3KPJAHkxFW1v45r5U+M4woB8N5XRcSOajsK5Ymlt6FkyRfbFUdMxrZ5afK1uzgYNgb8z/on+mfpOztQi0oy4twXiR86vfmSi73I8n5KN19k3Tm7sofCp4akWPZlq7LCvd5spNRkz4j8kucbMjkYGb8H8yg6r9jMsrsiun50ybvLRNOs5WywBGszaatWaCu7aXn2bSGF/Cry+UMbUptuDkN3eQpl14cxm9h8DNnBJHHjCRBl60BAE5BYpFWY0AfZu0NoXa3OC+diEUooUMisGfR0kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXCsCCwEiGhjgUtDPbCjDLRGRxfOzZaSLbP0XdJdUPA=;
 b=tn9gq/zpJEe6kzRRb3D2UkpNuBPAWp25tFlyDB9tXXew6pDrnm0XB+odbqQ7pfz5BoTBcLb6kzJy+au6Yf6Uh3KJn3b1uLjQVSNfKz2l9nI/fy662obNeXdpcpxZFly0CI9Skg3ShJ/PFmwqY6vQaES7EpJSdlIWuk8d9raf2o50idivCgdnuE6TAnxFseMQ2f7as4qOUItxZhuNa+XYr+JJnacYqYxK0d1dWvmY/cX/SMZqBFg4Dv11hnzvCnFUZ/XzCvw2pzGoinnjm4ueUe6+s+R1DdxKL4w42LidjDLH83K9Bp5vgn57QwrQUDGo42B3MJepMAs1UnPDb5LXWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by MW4PR12MB7013.namprd12.prod.outlook.com (2603:10b6:303:218::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Sun, 5 May
 2024 21:47:31 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7544.041; Sun, 5 May 2024
 21:47:31 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Phil Sutter <phil@nwl.cc>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Felix Huettner <felix.huettner@mail.schwarz>,
	Max Lamprecht <max.lamprecht@mail.schwarz>,
	Luca Czesla <luca.czesla@mail.schwarz>,
	Xin Long <lucien.xin@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Paul Moore <paul@paul-moore.com>,
	Richard Guy Briggs <rgb@redhat.com>,
	Boris Sukholitko <boris.sukholitko@broadcom.com>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 2/2] selftests/netfilter: return a value for several "int" functions
Date: Sun,  5 May 2024 14:47:16 -0700
Message-ID: <20240505214716.62304-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240505214716.62304-1-jhubbard@nvidia.com>
References: <20240505214716.62304-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0151.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::6) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|MW4PR12MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a3f12ed-0a46-4a29-7748-08dc6d4cf779
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vopTOohxrsl8hSEdoLCQHImTGfMP4TW/zJFTYZ3EAUcSbnDEDt6iRZQ3tCd/?=
 =?us-ascii?Q?kjcYU5+cXazphXFXcOPKaToE02UvVOQQhVC/3T+g+JinPRgTW+R5bEntIItS?=
 =?us-ascii?Q?ymKHkPRhDC5yDfaSbNPe9fpTKTz+JJDpwIGNjsLiXwEThNaq4pQVsHXvIGQw?=
 =?us-ascii?Q?Up4qPhwS7kOJtZUbkq3muRRi29u1rOfAdZJum87RJy1hbwgTHq/BmJnRf0OH?=
 =?us-ascii?Q?8d+9uXymoEgtQQWiQEcoWCfOTAUFEWqiFtYeD8+529Oh3ECYLfX6VZMw1/ad?=
 =?us-ascii?Q?zR6UKKOUWrTTlicM/w3nJFJLdUf3kzmasd/u/i/Mhc7T/ladg+3VipTFf/lt?=
 =?us-ascii?Q?PW0obXiuDt7rPlnFUKyuHUHC9XIrAjZgElfwJQ3W0SOlSAVmUl7XRW52zvVM?=
 =?us-ascii?Q?FaYEttQmZezA4AtaZ+p6Z2pvBy5pEP6wkv/HwXQ/R2Uc/k3gJdWmmwdDzKMo?=
 =?us-ascii?Q?yzHHDKBT49N3Y6P1BUsNMWeCisZKCRQ1lPswSPxDYaTKkfRUpIqaNK/6DFKF?=
 =?us-ascii?Q?ffpeXiL0P4MYsJnB7PlOy1noTcTZl/u6htaNgmkNDvDMgO0L1Q3nHiU9iOQF?=
 =?us-ascii?Q?tvFilBezQPG0J4fuzt1X4BYtoJJ8JkZ5tfa2l3ydZOrMDXqZok35Kt8vf3qw?=
 =?us-ascii?Q?Kfvn2EKNA+7t0aomI48qUzLB7YSBlq+58EQPyf6eCnkk9bxE1qQGt8LlN/yj?=
 =?us-ascii?Q?t2QA2lcY4srOEvPzbFFydlNMi5ZBWz0nq45KTf+1wgjl0U3Af+t3ivBVR43R?=
 =?us-ascii?Q?9Lw1a63KIxvk/1a8LnYHCuW1GW+iY5trWQl/VJiSNQ+jEMzncJkO0lKLNy6i?=
 =?us-ascii?Q?E9yiYHcqIeHYQMfg8C46CU3V5hid6ZZ2SaliaY6pFGDSmb0CxpKoJFpRHznL?=
 =?us-ascii?Q?YhcCisFH2397TasYfUOAfdO/jqMJjaWoNF9Gi7zebNLI35Ji4iH0+GDMmMFY?=
 =?us-ascii?Q?XmCYlE6Hp1S758rAZ6bkOI8aeFUwo52ubsbBmcWpaQEgOHbSldti3O9a58+B?=
 =?us-ascii?Q?7sCHXoYfB8cnn8DQ9v5FwsPql1Uf1lpMkMcNs9HP9IgkCAGKJf2SI5bbsF3P?=
 =?us-ascii?Q?c+9+6Pku53rK53XBWyNCVEF/rcEtO3so3Fpjl8UCDbMcV0zrfaHo7T08PB01?=
 =?us-ascii?Q?EN1k1Nf4ehMouvqUHwH814a7KB6jfNXn4ip6bALL6JbutH90KObHOtiGkhU/?=
 =?us-ascii?Q?kj82r51wigsNoiGcfUpzl6hi2DhHA6UoJP4Q7lmxCepihZAZwIMsxTacHDzV?=
 =?us-ascii?Q?km+JwBxuhTIvfgRLsUXNiE66gstlu2E3nstZkpFFUA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ljTiAj5Mkytir+nXOQM7AmI82yIRq2MAYuCe6U+o36k8BiVDSTXInyWrfb+d?=
 =?us-ascii?Q?cafWBJo8lqfVH3dvd7p0qgARZEfjj6YTn5U3N07jLePfRyvtVj/jQbs1QjZn?=
 =?us-ascii?Q?5iOWjqr84Ut+2JZRbhM1zLaujEb+ZnkRYQ+E450e4OtH0OuAULJPF1F4nEAH?=
 =?us-ascii?Q?Q3XEsaSjT//yKmv4jwcgUUedKnoVtR3W/2G3tbsFvTMk6f+BAzG1rU1ZdSl0?=
 =?us-ascii?Q?Q2gZxdhvh+klqldkOg/+hkEv2zto9jwHSARbWRv6I/LUO9qW353sGiFWT6ut?=
 =?us-ascii?Q?L3roqMSsfJ+7GZwH2o0hP1zbNh94885Fpu5XS2GbLO5s+fHyAc9STL5DWY9S?=
 =?us-ascii?Q?VFldGDcwZw2p9ELymGNA7WuwLwefcC/q7mjDCbzJivpp6lV+6ydIBUFY06QK?=
 =?us-ascii?Q?1rfj1VD/9+DV4ya5cet7xMCOV3EqXn/l4E0CFyVBnerZ/Mch81+8Om+90uYB?=
 =?us-ascii?Q?qXHGgue37bMhbTws9XCmXdwRto3kjsVjjeephc5NYQc6edL57ktklKslt61P?=
 =?us-ascii?Q?clf0MPOnUAcYYmulw5MnL+YufDUtgsiFejrOtZlXUmM4VMQfvuHxnNyf+P3S?=
 =?us-ascii?Q?ka5G4ebXPy+NYftcuzpKwC8B3hPIcpVRCikduJWxOI6xriI5lNQAoIlpE2JS?=
 =?us-ascii?Q?A2a5TnVA/Kfu5ISiJFHpwdCgLon+v+rlS/d2Vxnu3yFoxrJ+oJnes51OXIjd?=
 =?us-ascii?Q?iE3KZk1qDcqANzop1AT6m07pnd62v9fajzQkHiw7bFIqhUMPlO+Ww5mN3TUy?=
 =?us-ascii?Q?nLfC210urhJHuoQ/NLBalXGx/42LGxvxQcLygONdjDiAZ/J2Fn/dIix7sl6Y?=
 =?us-ascii?Q?nFkv5KZFuAx33IWFIQsg/mkQhH0PtwNFtbV4E8KF+1Sk+p2V2gEgZ8n2IdG7?=
 =?us-ascii?Q?++MDrf0ce0JCAX516j0gRV/rzDf2OZ0JNtBhYsiP0/yT66efMtNjnpbvC8/d?=
 =?us-ascii?Q?PFp/dLtiqrh4VEKJ2qKNlpb3Zb0uQg8D0NODjU8mqJah0r/irWp1jd5QxpXu?=
 =?us-ascii?Q?M1oMLYIuELxbuyp+ZddDjwK6smqyI1PXUstQve3gWsOnKyDedsSw6RFUgaHP?=
 =?us-ascii?Q?MSGx+AUTQ/v9QAGRw+tlMWM1FZHiaQzI/IRUo4ATKqhmYeEJi13/gL8nQmzA?=
 =?us-ascii?Q?AdoPH7xAFcPul3euKIQ8INcStXy33JbAYuM4R5kVrtPBh5pEXosTosGJklMJ?=
 =?us-ascii?Q?oJucpw6ieFA5KPYczQw/XdzSo84YzT40R9IzvP4mi+hZiw8e3kOuvsvKBCR1?=
 =?us-ascii?Q?v797BKVdXQnNwWi1iGIcNC8CYZDi9m/n1EfcvpPNYPudPwApzsPPwNNfzylH?=
 =?us-ascii?Q?K73pPW4uW67uMAoJywTdP0csJbpIdRK5iIQhvdg+j1h1H2+kntRazfYK/zAC?=
 =?us-ascii?Q?Zmh3XSZ3uY9g0I7ns18b2QkUYFk63gHvqi9bzCZcPYKEDHA1U5ugd3DepcIw?=
 =?us-ascii?Q?pc3eUlObK5z1aYo04HJ0jeTUxA5KWO2AEApA1WzNE774quMxCYR8HsSU8okl?=
 =?us-ascii?Q?/di/A6hwYOqp8t5PL/jgolXq50gNCA0ezoBfGEZYpxCtBMzACJPTlJlPpGIK?=
 =?us-ascii?Q?NyQDPE0mlW+imzZ5Q1VLM8TmDospMDQe4OKUU6AzvkCzeMcvtnJSkeoLChBO?=
 =?us-ascii?Q?Tw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a3f12ed-0a46-4a29-7748-08dc6d4cf779
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2024 21:47:31.7519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YmECuSCWt3GoCliUAGBtUaRzk71pnw9ajpdkYZyKnzftbtumXIMdmvKsE0vur19OHNlLq7Q+WhzNk/+9eEZVVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7013

When building with clang, via:

    make LLVM=1 -C tools/testing/selftests

...clang warns, correctly, that several functions declared with an "int"
return type are not always returning values in all cases (or at least,
clang cannot prove that they always return a value).

Fix this by returning 0 for each function. (For these functions,
non-zero values indicate failure.)

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/netfilter/conntrack_dump_flush.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/netfilter/conntrack_dump_flush.c b/tools/testing/selftests/netfilter/conntrack_dump_flush.c
index b11ea8ee6719..2513221ae5e6 100644
--- a/tools/testing/selftests/netfilter/conntrack_dump_flush.c
+++ b/tools/testing/selftests/netfilter/conntrack_dump_flush.c
@@ -43,6 +43,7 @@ static int build_cta_tuple_v4(struct nlmsghdr *nlh, int type,
 	mnl_attr_nest_end(nlh, nest_proto);
 
 	mnl_attr_nest_end(nlh, nest);
+	return 0;
 }
 
 static int build_cta_tuple_v6(struct nlmsghdr *nlh, int type,
@@ -71,6 +72,7 @@ static int build_cta_tuple_v6(struct nlmsghdr *nlh, int type,
 	mnl_attr_nest_end(nlh, nest_proto);
 
 	mnl_attr_nest_end(nlh, nest);
+	return 0;
 }
 
 static int build_cta_proto(struct nlmsghdr *nlh)
@@ -90,6 +92,7 @@ static int build_cta_proto(struct nlmsghdr *nlh)
 	mnl_attr_nest_end(nlh, nest_proto);
 
 	mnl_attr_nest_end(nlh, nest);
+	return 0;
 }
 
 static int conntrack_data_insert(struct mnl_socket *sock, struct nlmsghdr *nlh,
@@ -207,6 +210,7 @@ static int conntrack_data_generate_v6(struct mnl_socket *sock,
 static int count_entries(const struct nlmsghdr *nlh, void *data)
 {
 	reply_counter++;
+	return 0;
 }
 
 static int conntracK_count_zone(struct mnl_socket *sock, uint16_t zone)
-- 
2.45.0


