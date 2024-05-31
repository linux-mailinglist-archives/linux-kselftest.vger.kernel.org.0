Return-Path: <linux-kselftest+bounces-11038-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 773788D690B
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 20:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD168B21321
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 18:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB8E7D40D;
	Fri, 31 May 2024 18:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ta+AKyaq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2083.outbound.protection.outlook.com [40.107.102.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117971E498;
	Fri, 31 May 2024 18:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717180680; cv=fail; b=Ho6USfHaZV/8lSYAl4764+mtdathTXAbHA5zC749cCNi9DX9Tm6p5cHodyWJwUPHqq1aD9gIoJdlk8ykAIvXM/y7arw9Voj7QgvLAGcUCOeSA5fSY8sgLI9rJ1RhNnIt8JCl1NsO7OcZEq/iAWZT5A/jfOJGk2rL/CJM3UeW0Hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717180680; c=relaxed/simple;
	bh=GzjEbfimop3SAkZZAlIY3mVlXBrmGSQzm8+f6vDyFBk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VuNu8P/X4z3IBOiE66CV3KIXJi2g5glmSODEAE2P+2bWClXuzgR3W10tnlkwk4p7tYIioeZ6heb5ojNYPXKJQGcUGhNGAc9nN+207lpn5xT867QH1dy7RFZR6YFVSRhvYsLmQJxF1kGOWYbSQIKsEZyS5VJPnYqgEKiCloP45A8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ta+AKyaq; arc=fail smtp.client-ip=40.107.102.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FArRqC1f1OLAGbvieTgYPOLNkOOYIcwMvFasZquu9BAjIMT6pTm1N13eSxrwrEnJi2YFMsYKvXPFVhNbqi2VULFfl8/l6Bi7z8UVaMyu+ZKy7gRyxH1RNV/hbLrrMD/iD8IC1K6fRMx9f/C9m42NoLGNK+TI2dTzW7SNv7jbEp4Zy9LXxiotUErPdXJaGrOwy7vBXw8zzZ/J6eM/kWfT95j9+Es4iOlQtZKTCJEL8M7IR1QpBfrFbNAdAbY+a4KUEiOnO5mOoQkAItyDLXIR/XcvUNt3WuCh0mp0+vZPxBkrJVE7dLn1VYVgbbU9te4vm2wX374nNfSpE5JOKtRw0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/kcJYJUpVe0Yq+qPmhqPxZG7SCujOjdfK68cv6DE0PM=;
 b=WI56KEl2py8i8S/1w5XcT2pmINOloQiPtyWyGkpaAwYBWa4KhZR6XhWljBA2EAODojLHZGC0z8oH0TyXePs3wzXUCBLcRyCC7DtlS0rxIVmBx7T1JyixwkKEDlz40BbqamcrOnnx9EsZINff5QhRmwQubxaPS6UQFDjWU7A9GHdxwyFjgdk016xLPVxgjzvVv8hVzPMfACqYKxWoO8SYcv5ZwzA5MVuxOdtaH37JLDRFA28IBH6HLF8iv9GgNuXDn8K1GBRhn12Hic09ufxYZ8+s9zkV15pPzBa2OgN2tmQ1X3b/eW1R4slReocs6jDeNTegHK28azxAGmyJIr93EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kcJYJUpVe0Yq+qPmhqPxZG7SCujOjdfK68cv6DE0PM=;
 b=Ta+AKyaqApiKuuoXFOIasRj6VL3wv3QkbqtTq3btWiUWG3emmYriH0T6GKh4r1eIArKBavQc6MSGp5Pmxl/bsIx0aMhPbFRdDmjrmy/CBFm2nlK6A47ElKi+wD9igiKWo8BanfzPajA/z6DXbW5c0bnuLcE3MwcVB3hOcLep9oJP3+JvYicLArxGs6skLCTzvu/eOmdM1CDTqPkSUg/z0JugVC4yleX5Xn4ksyQWHwgDpKHdWyd5XiDU2xt681EiiH/ijoKdWOqijrMjshpKxTWwIJDmgqFCmQysOYwiFOjmFK4c7fEQK4dLSKJ2sCsZ3A7pY71+ntwTl1YNyDZl4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by LV3PR12MB9167.namprd12.prod.outlook.com (2603:10b6:408:196::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Fri, 31 May
 2024 18:37:55 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 18:37:53 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Beau Belgrave <beaub@linux.microsoft.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mark Brown <broonie@kernel.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Bill Wendling <morbo@google.com>,
	sunliming <sunliming@kylinos.cn>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 0/2] selftests/lib.mk: LLVM=1, CC=clang, and warnings
Date: Fri, 31 May 2024 11:37:49 -0700
Message-ID: <20240531183751.100541-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.1
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0014.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::27) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|LV3PR12MB9167:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bbfc306-dbba-4344-19e7-08dc81a0c862
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Sgb5LerssgrIQmped4caiZGGV8tJOCvHiAxIb8baAFtEJk8RNQhqaOXr+qA8?=
 =?us-ascii?Q?sPlftdtEOw/PpLKgAyRckDISd0Wl3ilGBFQAbUxlzA9zemYRZZC1uxGyO2R4?=
 =?us-ascii?Q?KqbjEV2t06VpT+X6bFAEagmZZ/26ln8j81RcVi9o2+dpD3xbAtjljffeDDUt?=
 =?us-ascii?Q?DGae3JefGGCBeJQ/AhWWeyF+VO7F2A7C06Slhu8VUhbsnIbIruA8UxRgSwOZ?=
 =?us-ascii?Q?nDD/0Z+3GONF6hyUiJ6FGXznSEI7nxp1FnFrR+MPaBIZKXPWrEIASiNfPh+e?=
 =?us-ascii?Q?eHmdAIPzIjyxSWn4NCO+1ElSBAK4UHl9DmkZKRSjmPzMG8Hg0qCdbQwDjTCw?=
 =?us-ascii?Q?x2lou9A8sAa/G+PZY/CT24JpV3MaL1id67M7cpk/2vY33Ox0yw2af//auiIB?=
 =?us-ascii?Q?ViG4Dg8TklzbA/EKs/Ky2MOGpbc2Jc0VuMwl4FkpVYavgXnQOHn+qiVDK+RX?=
 =?us-ascii?Q?bR5zziSgXWJZKO61TU3+lAn5P501WfFgpjODChlmdX2hW0nkYhuTwuMwDYWF?=
 =?us-ascii?Q?ygbXtYG20vkOZ4Wd9Xfd5soOdbDebN+uuUESqofKanvn0CRmsXz6g/PkxVb5?=
 =?us-ascii?Q?jVIUjFemHrcEipWEIX0sNgpQj4fUt8eCuJ82XX09bVcoYtgXFUeb1kBYXcc/?=
 =?us-ascii?Q?+nhZNXIyyWbe5QCp9yxZMtNMmGKZovnxxp6Iz5bt9hWI4VrB9mrboloSjGW0?=
 =?us-ascii?Q?+lm6JWu4tx12/c8tAXKJzRjfByDp/paf+AMpHnsNbofqZWdozcS5pYCxp/Z1?=
 =?us-ascii?Q?XnVE5Qb1bAjz/Y0ULVy8tsBbQciKLcFee/aKgurYIKPPf5952pV06TH826xy?=
 =?us-ascii?Q?0YFIlGWNZo0GFjh56tgqtiKEb67KnmLEEslXypCJ5dkAlaLqTYYp6kgLmZYF?=
 =?us-ascii?Q?w4U/7OlGFuD5NcNw+NQMBr8TuZcRY2Ea0Lfpy9oL/zTazCas2MDOkZk978YP?=
 =?us-ascii?Q?vUYTjjmpAJ7w9YXMo2kVWniXyhAvuvyDRVY/iXVRCR31goo09CTKqxVrx13K?=
 =?us-ascii?Q?+axqhof8e0Li/XB3E7Bn98C32Km92wqr3xpZjiyL38fcRlSq+K3nfho/J5ZS?=
 =?us-ascii?Q?kKct8VkEp2OiwGGsIYaSibi0uPyP6n0nUTMh/y82pJoIhI8T9F13cPUV3UNh?=
 =?us-ascii?Q?O3coWpMnSCuhKqewwd0LWSFRGm89PSnqr6f5HUYLI9hMKKlYlYC7IRN/Lx+K?=
 =?us-ascii?Q?X1hj6FEziR/obcMYxcqhTnURta1MIqYLyTOfMQb8w34tnE8LY81iMzupt2F7?=
 =?us-ascii?Q?kFPYm+JpK++3IxQuczPM4UFS0NbmOLpcEYuF+vHRW4uA3E6LU+2R7aYdlLlM?=
 =?us-ascii?Q?+LU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AVB+clfungYo4qYfKPA+RD2BZC6qLhqffnyP6IXkcWGBHC4+qbfueKDLJX86?=
 =?us-ascii?Q?boCCErjAFh00c1G6o4KfSQA4tJdtKTb2a5+rbgb2J+T+aCEDtFlNcZPBlGnD?=
 =?us-ascii?Q?hVQTcluWEceoZRrelDcHN/8m7lFFS69DbesWKvnfeLtZFU6Hlvak3Le2IO49?=
 =?us-ascii?Q?V6GwBw9pyP6p/bfDD8Ji7sqpb90LixqS0AyTzn3t1PD9MS1ls00mpQJJz/DN?=
 =?us-ascii?Q?7lzYz9OlGnDabzqdrj/B7BKzcmWguER2nguWO88Tmu98uAl63wESgoWKHHE/?=
 =?us-ascii?Q?UeMqvnELMX5jR9fJeaSHfwAIUBDbRweg71eUSiUW3/nDB7twvWPkYf0Z1RJD?=
 =?us-ascii?Q?MC+L+YXa2Zi/CPcesys58C7SBZkk/wpnMvzllLmYG1neok7MfgSfcRoBaPVO?=
 =?us-ascii?Q?PSxkIQLJBJXkk4UVjG8F5Ku3u1fv/0dbW3QMk04vh4fpqq7ioTjMpp7BRar+?=
 =?us-ascii?Q?IEUQchsCNZhvfnlyOFfH2CniKrbW6SMGkpNF5hqyE9SgtE9tsnwOZ2B0t7D8?=
 =?us-ascii?Q?d0z8vO2sxjCkn+2w4+Awl8PRPUDMDlfkNnbjB9y0FjBjIG4frAD2boxn0kqL?=
 =?us-ascii?Q?vlqwdZuALeHPBLYWZ6h+wO0QGMc0xHCrdlSJFTduPB0eSOuKKZKnyDYd/86A?=
 =?us-ascii?Q?+AGwG6LM/0hPynlVJ1EYS/uOubVIHqrmRa2XBLnBlKfcsMrZ32tQPJ4KRw+r?=
 =?us-ascii?Q?UJFK2uM6BJofLHbfXcqTxdQzXk+nj4GekD6UeJj7mVkvo371qDSH7OCUrrZH?=
 =?us-ascii?Q?ujQ33bZj4sf1CEiH9x821pCeB9wEdb/PYm+2v4faMIco/QYuOZ76014rfDL1?=
 =?us-ascii?Q?eKujC5dPdUyrhMiZKsdf+Q3xMXbJ3sftpumu8CD8c/BdwCwQoP+javblmVRy?=
 =?us-ascii?Q?E4Y+Hi93pGPyMcLtI3zaCmcZgyPevC5DoXCPf7bos8iaKfyvL7nPXptea2N/?=
 =?us-ascii?Q?8f6Lc1in+FnvwQ4bMxv8ZdtzVVMf3eUBrNA/ijBRM+w/OaNUEByzU8p6VJhX?=
 =?us-ascii?Q?h9YyPesDS9uV0kBds2LXAKJSkOR8SK3NxZAr8nyIMMjUlODaw0Nl3uERBh4R?=
 =?us-ascii?Q?sQ4G0xcl9ZrP5TulGHMgj5DfBJ8/ZIUgbgUpvGIZ7WqglmlCYaXoL1vgyCtc?=
 =?us-ascii?Q?XAN4+uUZJINX3xnR0JPyPoaBWocK1v36XamWO2gVwM59YKyy5B8Kq3Saz7B7?=
 =?us-ascii?Q?BxbfLT7FIn2r8I3hh08GlI7oA9rYh+lu9ZV1x3azPQZefJet1jAR/TEQYnkr?=
 =?us-ascii?Q?JUsi/FjB0E0tCHaBjVRI05E6STe2JPNpx6ppFuLkWRxC2v02kiPvEYxaJybV?=
 =?us-ascii?Q?8wpyg38vhUPdwJBSOyZSLLodYF0o+4eX25eemnNuRKcOl3LyUXIxEfOjWm1Q?=
 =?us-ascii?Q?NR/ds3t1rB/KO+/TlW1dexyDWGizt4eVAerolUkCRxMsgOfK68Vj0zPXW+Gl?=
 =?us-ascii?Q?tuDJr/2+XiXUQMPNQB7qXy2qGGyFUWfn08gLzfmpa3dFyX9ZeW0DVEWF18cg?=
 =?us-ascii?Q?QEsPSPpd4FI9sHJWnuWQhsYGyejkqRUq2ifRaBko3ivrNEXt8EXbpJd3cvyL?=
 =?us-ascii?Q?GZgSEaFCZ2e9KouvIBOEStbXCGkNt+kyoF37MwIh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bbfc306-dbba-4344-19e7-08dc81a0c862
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 18:37:53.7288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hfBbFv+/utxK1n+X+6+tZl00pCl69bxcfoeZyLggr5vktRwBq+QmJUE4t2Qa71RCVW6u3VG0erFKHF/xApde5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9167

The kselftests may be built in a couple different ways:
    make LLVM=1
    make CC=clang

In order to handle both cases, set LLVM=1 if CC=clang. That way,the rest
of lib.mk, and any Makefiles that include lib.mk, can base decisions
solely on whether or not LLVM is set.

Then, build upon that to disable a pair of clang warnings that are
already silenced on gcc.

Doing it this way is much better than the piecemeal approach that I
started with in [1] and [2]. Thanks to Nathan Chancellor for the patch
reviews that led to this approach.

Changes since the first version:

1) Wrote a detailed explanation for suppressing two clang warnings, in
both a lib.mk comment, and the commit description.

2) Added a Reviewed-by tag to the first patch.

[1] https://lore.kernel.org/20240527214704.300444-1-jhubbard@nvidia.com
[2] https://lore.kernel.org/20240527213641.299458-1-jhubbard@nvidia.com

John Hubbard (2):
  selftests/lib.mk: handle both LLVM=1 and CC=clang builds
  selftests/lib.mk: silence some clang warnings that gcc already ignores

 tools/testing/selftests/lib.mk | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)


base-commit: e0cce98fe279b64f4a7d81b7f5c3a23d80b92fbc
-- 
2.45.1


