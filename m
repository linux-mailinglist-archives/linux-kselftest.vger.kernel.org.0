Return-Path: <linux-kselftest+bounces-11050-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8292E8D69DD
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 21:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5B711C24FBD
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 19:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4949617E477;
	Fri, 31 May 2024 19:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="im8TVFn3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAB917E456;
	Fri, 31 May 2024 19:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717184330; cv=fail; b=NHpT79Q5JTl9enYobLjzzimEtsjjRC/zNi00GrA0f1TxLVf/y4siXYq2ZQw/kMbB7X2yFCxDE8/Y1rGXe6BpIMjV1SHErjS+yoxmozF+/0+SAPVxX0TpD/JbpyjDdTtelpq8uYceN+/PlvRsGOiw0HKT0PfDC4Qi9tswbFxSl2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717184330; c=relaxed/simple;
	bh=j1r/O+m5/SnyXJQtoW7/oSbwHkqoSQcmc0v8OIHSqCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EJf6yz4Hmhf7evnO8SPPC6wktb77WQWHqg4xVEDoINl8eJORRR0/LX+Gde4PvErx+2JuN6GoWJmDWwQ2FlNHYtZiFUi3nUFEdEc/S26Qa1htdYIJlTOjwI1ywnWwqcUuI+5LBqsuvoMjy/fEP89yi7gv9LkEKib0Bc0fFEtZN1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=im8TVFn3; arc=fail smtp.client-ip=40.107.244.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGsGBXiom3X+Jj8Gij5A5OyYmzRwU1dwqCfGCuXIx7Y31Zfsz+5/POiPns2qlVHKCbvfbQQ2twjS8HXeIgEotLW4ioKWcdEixitweOgbY5bFMHE1C/U54QvvbKa/2e4rBbZulWBgX2rvOouP/Bkf+IvkidQz57LpzGOvn6oCms1F7lTqFnF9HlQ8HDAnumWpemyDwuklou9bCqcUKqAbczq1msnGV3v5blzP8JYZerZ93UQWTzVZQ3WS0qU7HyQ08DiPs4zyxZD/PjrYbz5RZgFTGRf2c+KUDDtrOLXf4Vy86HQRC4xAri+Mt7L+DtwFzw+7kG/ZDzZLHteWhmM3BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kifX0dBfivqv+TOr/XeTYG3usjOdVIqdYoKHiCltU0U=;
 b=j59Vg7HuGp6vOpuJLDQ18/OoUScDgP7mRPM2wQujhVxqOmjwvXdlO4HacktrxIlbq5ehLr3c9gE0MphExiYN55tFqfUqYnTNwJfN2SXVPReRnuAlcbu3sRbHY8q4F96oDgVYIJuSi92MI/Lm/UOEySHSI7xHfcx9M9ws9Bm4rbBNqK6lvyrXw8/+VQMHX+ojlI4VKLmevMHhf8Ret73eEK2pRnFirH80EZMd749nefbgTJnosgnRuV/b4j09KaHQKMmIOZF5oRtZ0xmVT1osUY+JYcbkO/sePjvlWoPN1CASu0N1AT68sA3L47rClnVhfWj6HjCfDfVT5yP2VtCa+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kifX0dBfivqv+TOr/XeTYG3usjOdVIqdYoKHiCltU0U=;
 b=im8TVFn3zyFpmm/dzoT3hs8ukGO2RncsgBxvW+bIYfQhDDC42uu2sbSl4Oag75IXz7qa1qmLQ99qAV9pBrcv00AGfCwZ4uYyzkc2d1iyE1O+eNb1urKQMCVLVbhe/g9gLDSubJEqqrpy7NKmEogR01DT/qW6kMO3rMCXJ+BSnQ47ecnkqCFBu/v1A5jZOnsNth9u9Mj2Z3MfsRqpWOdzrrCrXHA1SMKpaupJTo7eqvis2PTbnuMNj8n+X2p0uhg5H1wbIvAGD6hmiK6E9T+IX1josI8aXB5dZk4iT83ToBJQjffVG5QAt/lJcmmQkekp3VMbIFnrmmvlMdyp3nzuIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by IA1PR12MB7712.namprd12.prod.outlook.com (2603:10b6:208:420::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Fri, 31 May
 2024 19:38:41 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 19:38:41 +0000
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
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	x86@kernel.org,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v3 2/7] selftests: x86: test_FISTTP: use fisttps instead of ambiguous fisttp
Date: Fri, 31 May 2024 12:38:33 -0700
Message-ID: <20240531193838.108454-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240531193838.108454-1-jhubbard@nvidia.com>
References: <20240531193838.108454-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0072.namprd05.prod.outlook.com
 (2603:10b6:a03:332::17) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|IA1PR12MB7712:EE_
X-MS-Office365-Filtering-Correlation-Id: cef0077f-628c-479b-f454-08dc81a946d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cc3qVp81Wsh1bsaFoXvJtVq8qg1duLI63hPHXzgqe6yPvz8XOJgfK1choLST?=
 =?us-ascii?Q?lK28EMerBHrY7ZHM/PmNzX2JCITqTUsryS4DBbePPQCFuh2fF55rNxQngL/y?=
 =?us-ascii?Q?5g9+TKFqbp9fcx0kHLUr2QSuvWjS0+AS4VWZWflvY2X3dFN7twMzH67sqNUc?=
 =?us-ascii?Q?p2QxYkPY757bK/G8QIg7uarwZO92wrU7bi1Lq+Z+1aCMbwKL/5bypYUUeReq?=
 =?us-ascii?Q?wO3w7utc1HEPKdPTNu94H22h8bTqnI+WaIoF45mQ8Hgf2FBX9hLmBV7vWyWL?=
 =?us-ascii?Q?MnCRXWfmY2EVapwy6bMeHJP4i13NhCXNRfSm0GKt3JrEVAmQzRsmgXeBBtKx?=
 =?us-ascii?Q?fIwr9Ogm1qOusawkYZAITBNtlbLSEz/oO7jzs66Uukm54k5TP35sTfvJyzyV?=
 =?us-ascii?Q?3Z9k40pKaU/JuGB57t1OMhc3SUieFDMG+IwqHDwfvCLel3I+VD7rZ1+D4ZrS?=
 =?us-ascii?Q?hevgn5oIB+iQOBkVC5+ce5o7meXW9IoHcWe26YJrzMOEgLxQhyXYmS7rDveI?=
 =?us-ascii?Q?MJ6NOpqjpirC0iOY+BYS7F0JOZprsuK6S8o+vjMBf2fvuresLwdeR3tYN2Wo?=
 =?us-ascii?Q?+TyJaAdJ/a6hM6Ar7s2zmE5usJABNoW4PvBrYTHXQ4CK22IEbmuTJrQdvWkQ?=
 =?us-ascii?Q?fRkI0F7fzmbpP7dsay/MMTMSsw5707ad3hQnp6moFwFA37Hj+UOViKIbtNr2?=
 =?us-ascii?Q?tAmsDDq623slvyj89VDZniN+S75VTwP+BDicscpVC6unjcQ0V7j9vJyoRNaa?=
 =?us-ascii?Q?zi+DH0d8jjbNtZ1ouuTOaRKHbJrZ6C3yLrPJJEBJdtxur/s0xX+jobYznlsz?=
 =?us-ascii?Q?F/ejD80I48i7iMtOqhg6foEvoW1T5p6WeCbUi+KDmmIoCVsJl7BunFjkUXqB?=
 =?us-ascii?Q?MfqUJdiPCRXZscKGwdcsa0aiHk9WJemwCL/lHUfqav3Kvfe90ENm9Oimqtiw?=
 =?us-ascii?Q?A4KiRZmT9O0+TKha/MdchcaRoxlh1rJQs9mPf97Vuzl+wmqdCbQ5oyS//1EM?=
 =?us-ascii?Q?Fhk3yC2he2b15RmNRlu5a+KoLUh5DTTQRiQneWdEJgXhXPyORrN9MWRNxOQZ?=
 =?us-ascii?Q?/zIqbqCwzuo5d4A2BZtJl/AdMCBw00/a4Nz1TbcyjkQkiPViTYGpmFVKbUVc?=
 =?us-ascii?Q?dZJk9EWm5quFNZ9dchPau0si660aj+UmL+c12STDmVUDaXerFQtCKx2wDWuH?=
 =?us-ascii?Q?SWf7byEWzK+igxYZKLDyMUm+RGWCE89YmexBy1uTwomdBlKCpF/ObwGl+WsN?=
 =?us-ascii?Q?7kh0jfySDRtP0E9IQLsa6cjdR1BWY4kKaUdqNYxshQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l3Dw55TeSySlnIrt4shEgLbfuat5p51eSoZxkYQuWGd54N1zzc8kYtreNY/J?=
 =?us-ascii?Q?1579vc2UwMdxA8IVlwZ35gUa+O+I71hFG/lfyhv7sxJfm2TOUiBES6LpsIKL?=
 =?us-ascii?Q?NW5KE63sEMmWRTTeeFA2v9u4r9RsAyAqb7P6C+Ty8sK2/Wr8SMi1JAgb7h9y?=
 =?us-ascii?Q?BXqTA3vV0mFX6bB7OuqTx56GJp2CHGeaiDsgyAfCsu9vrgj2WmnBMgKK4nWV?=
 =?us-ascii?Q?FPnSTYKBkYICLoeU6ZvHHt9JKF14q70/3Nt2yjHkc9V5wcmlBcI/gRjszlpU?=
 =?us-ascii?Q?FB1dveY7K+TkKCmBYtkdRxWzLAATv+yIrdEoYvgG3ffBvGDunrF1TCK7Dlcj?=
 =?us-ascii?Q?IgnnJzjUfHG9RQ4NESSftNmjB6a5BR0KYVm9rGo2UmY4BSdXCZ7HLvK8OgxQ?=
 =?us-ascii?Q?rL4iVSSkgm/EDSVKRoXYeHX/Que0Opve5fYEGzj+kkqSm3LVwGEHb+88FIcx?=
 =?us-ascii?Q?LF4Qc3rVhneGiwrGg8cdb1MFy2TX4NaPlxrqH1WIoEw0rd7vQeDphjE4SFSW?=
 =?us-ascii?Q?FuJgAR5ryJnr6OMFRqz1nFcqqgdVc7YU4QX9hDG8EXbow39PWSWd28sGRV2+?=
 =?us-ascii?Q?bGM8ca+nGwy31EtUT0Jib4X2dFUu4NY4yW8GmW8Xr/8TqsS3QxgMedwqVYmH?=
 =?us-ascii?Q?amk/0DhRg5tnhUtFzUrvvi+9nnDw0hw8xTADplNd41F0mrPgaMDlCAZIDQIi?=
 =?us-ascii?Q?vY1p2O4whyKaZjjp+Q4cWI+T/UA09J3/GwrgY+EqAjsW6GdNvZJHu84lmRGv?=
 =?us-ascii?Q?kMIkOwQbhFgN3Dxwso6zOeOn6QwQrNxi7Db8MJ3j9ioiSQJYoaxO4YW4SYKx?=
 =?us-ascii?Q?t2xYTrgkYyoS1iPZTjZPeVHYLTEfYmX357wb9AE6j5sc1/bwtOIrbvIOhNRy?=
 =?us-ascii?Q?exepc33sOg3H6h2Sr11PWTyjhAfh3mzWWt3M3TTnVtdmpEKNVsEhigkb0+g4?=
 =?us-ascii?Q?NTjpH5+8+ih6G8QN8H/4S1p8rKQIJ0wr4XXeesqQakdT5SCOA1o5tJk+eF5m?=
 =?us-ascii?Q?y9O84KtMQhkuv+vzoQiH2rb9NLD81fw12hSH0TPrMSh4iMqr6BoVJmkfFn3g?=
 =?us-ascii?Q?2KDZ0EoeMIc3+JOdJAmCwlSDo0sg+55f+FaARG1cRsw1lDquxljZcN+mLvsQ?=
 =?us-ascii?Q?cEc3P5Efszd9p+8vbNchO1T9OByoIEBnE1E9/fw25N9hnY8BX3Bz0cXW6Bt2?=
 =?us-ascii?Q?8qnbPj6v9kX9Rx/wFNoukxEtU5n9Ci7E5J7fYF3W2BRodQhbekZ1aW+FAF8O?=
 =?us-ascii?Q?JNcsiyuvokzcAk2jnjH4hotUjr6SBqMOuy8i+z9GagCvHYPygPBJyTCbY853?=
 =?us-ascii?Q?qUGYf+qHMC1u2JLtPFt5O+ioIWouxLkJ3H521yNscKdZWQi3z39ZfAV+qgk3?=
 =?us-ascii?Q?wq0ORIyc6bY6APbCuJRPhYBId62zLl7yoXkAwUR1XOUyqrhOnu8juXYmqqJc?=
 =?us-ascii?Q?w7emvrFyykrKD/VLhN9lSbN96xHqWwMkna6mY34fzInnWYUYYBYwbzT7InR0?=
 =?us-ascii?Q?6Jik4TbdfSSF4lOJ2xdE9mMZ9u++t59Ztj8wAsSh+UuHOTm96r9GCmRUkQ0c?=
 =?us-ascii?Q?ru1QTwNAeFx6llz9Z6wfFv5U/GIjySX3xRFJfLSb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cef0077f-628c-479b-f454-08dc81a946d9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 19:38:41.8638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NP5JlPt+tBcu6nnIeMzXbIzCVpjOKwe78gTLA+A8Xy8QJhG0CZOjUJcOUghukuNSra7nX3/ZYHOMpTnfXazTNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7712

From: Muhammad Usama Anjum <usama.anjum@collabora.com>

Use fisttps instead of fisttp to specify correctly that the output
variable is of size short.

test_FISTTP.c:28:3: error: ambiguous instructions require an explicit suffix (could be 'fisttps', or 'fisttpl')
   28 |         "       fisttp  res16""\n"
      |          ^
<inline asm>:3:2: note: instantiated into assembly here
    3 |         fisttp  res16
      |         ^

...followed by three more cases of the same warning for other lines.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
[jh: removed a bit of duplication from the warnings report, above, and
     fixed a typo in the title]
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/x86/test_FISTTP.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/x86/test_FISTTP.c b/tools/testing/selftests/x86/test_FISTTP.c
index 09789c0ce3e9..b9ae9d8cebcb 100644
--- a/tools/testing/selftests/x86/test_FISTTP.c
+++ b/tools/testing/selftests/x86/test_FISTTP.c
@@ -25,7 +25,7 @@ int test(void)
 	feclearexcept(FE_DIVBYZERO|FE_INEXACT|FE_INVALID|FE_OVERFLOW|FE_UNDERFLOW);
 	asm volatile ("\n"
 	"	fld1""\n"
-	"	fisttp	res16""\n"
+	"	fisttps	res16""\n"
 	"	fld1""\n"
 	"	fisttpl	res32""\n"
 	"	fld1""\n"
@@ -45,7 +45,7 @@ int test(void)
 	feclearexcept(FE_DIVBYZERO|FE_INEXACT|FE_INVALID|FE_OVERFLOW|FE_UNDERFLOW);
 	asm volatile ("\n"
 	"	fldpi""\n"
-	"	fisttp	res16""\n"
+	"	fisttps	res16""\n"
 	"	fldpi""\n"
 	"	fisttpl	res32""\n"
 	"	fldpi""\n"
@@ -66,7 +66,7 @@ int test(void)
 	asm volatile ("\n"
 	"	fldpi""\n"
 	"	fchs""\n"
-	"	fisttp	res16""\n"
+	"	fisttps	res16""\n"
 	"	fldpi""\n"
 	"	fchs""\n"
 	"	fisttpl	res32""\n"
@@ -88,7 +88,7 @@ int test(void)
 	feclearexcept(FE_DIVBYZERO|FE_INEXACT|FE_INVALID|FE_OVERFLOW|FE_UNDERFLOW);
 	asm volatile ("\n"
 	"	fldln2""\n"
-	"	fisttp	res16""\n"
+	"	fisttps	res16""\n"
 	"	fldln2""\n"
 	"	fisttpl	res32""\n"
 	"	fldln2""\n"
-- 
2.45.1


