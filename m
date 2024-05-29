Return-Path: <linux-kselftest+bounces-10815-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB2D8D2ADA
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 04:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A9C9282F86
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 02:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7D915B14B;
	Wed, 29 May 2024 02:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j/Wmk0n7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AC315B134;
	Wed, 29 May 2024 02:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716949791; cv=fail; b=QgJSyerpp8tasINkxE7PCh/L0WqVuCkTASJkWU6Y/ppFTeg2aJxtQNcEX5MDcOJ7bRPrvf4CsK5cXXYmqHzNrvLjkQYtLV3wvAcjx19u1SQNnOR+qFuaRyiaOaGgVP5BRuo/KP4rOJP05iWxX2h/vmG+5aUaefM2HXQlZQ05cm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716949791; c=relaxed/simple;
	bh=xkF1tllS7e+DZTZ9jHJSvdZ+FCkY0pPkBri0DoOV1RM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BBSCLuGLR9YFRlZZj9M76ylcFQZn2/7EPhgsdqkJli4WOmkMREAoyIbPElA38CDMhc5XezK26DvmSgVgp6lJ0YymlnHFFt3W4YrpSvx2iIHxeJRJH1AijH6L11qNcUox496ZdLzyz8MyiOcNLc5PijdxBC79HgNiCHzQcPMYPIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j/Wmk0n7; arc=fail smtp.client-ip=40.107.236.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ANzEtoY72FMqL1QuBPt1r06HkrDQdHaaYS9mLRD8Ngquaz1JK2VoajwOfqzccHlKzszBUr0o763VX2xlyJbrZRgCUU3Wy8jSg1zH6SS4P6xdOVP2HibQFgiIAfFNXk/r7jKbTFA+SCQWLL8xsUFC5rK+NQiY2IAiZ/9rokqtw9i0MwYjQmJgLYtA5Q5CjI70ss41ARQ8FxEDbnwlRgxMMUWYsAFxWfj14GA38qHBi9YPXenrmwNOvb9+camlRYWCHSA623KISvlW6WOxvOYjVe2BLAgDM0LmL/MvdPAKtN8eO/CMim8xRX04SvxWBvRlrx1K1BNRIcm0hvRW4y2X5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kec8cUwqo8PXdu5+3RBtwP8N5SJ9HTi/RyoulnN5bi4=;
 b=J6adr3vqLGtVOM0APBhe1qV1xawH/WWXNWXsHN6EfddLagkfM6EA9q0iM7RdROYlm8+JALV+CrO7o1s2lGsi0aoWU/R9U7C1obEqW25qzPwNpTrIn2AudeNjf3YHiSjigxUHBW/v7qo6bYAB94fjRlJ3fQnPDNsZJ88pWSClM8NhyMNbn0XaO7s/Rh6tW82DbqCIqeXBwyia+8c1P5EFlsA9yOuSXCUE3nYw/iL8bdbgU+0Z6Avn9gC+KGDn1qs7RKBOMCsZvfrYlwc+2ACWRi7WAmVA0iptOZzUHJckbim+XCEwL/7EFs9RMR3Eo1WQLA+99VXTMmjFbof7wta64g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kec8cUwqo8PXdu5+3RBtwP8N5SJ9HTi/RyoulnN5bi4=;
 b=j/Wmk0n7YZeqHwiYD9dbsNiG0D/emPJopUZy2Fx7jSLynNKgCjDvS7SRUIyoLdaZmMvrHBMQVJuo3XzgoDunINM3ZRq7qe6FstJ8+P7FI9k/Z0ByW44d4pwfIOG00GIsMCLlcC2DjDNz6z4DCo/nkWLct77sPYe2/Jj6A1DFZiz4HughQLH1TfQ2FJfcxZcmp6mwlUb/sK3HxqgSE35fI8PsNUeF0ShX/V8zpeg4xEp6DffCNlt2Q2a2/JwU+PsWnjC5KiCjSk7qqilFj7lPO4CY6qB1yHUrvdFnZitEsGkI9lZ8jQQEA32vK8Og1FHOAISXCCZLs+H38PIfi3B7hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by LV2PR12MB5725.namprd12.prod.outlook.com (2603:10b6:408:14c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Wed, 29 May
 2024 02:29:42 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7611.030; Wed, 29 May 2024
 02:29:42 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Edward Liaw <edliaw@google.com>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	"Nysal Jan K . A" <nysal@linux.ibm.com>,
	Mark Brown <broonie@kernel.org>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 3/3] selftests/futex: pass _GNU_SOURCE without a value to the compiler
Date: Tue, 28 May 2024 19:29:38 -0700
Message-ID: <20240529022938.129624-4-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240529022938.129624-1-jhubbard@nvidia.com>
References: <20240529022938.129624-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0051.prod.exchangelabs.com (2603:10b6:a03:94::28)
 To BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|LV2PR12MB5725:EE_
X-MS-Office365-Filtering-Correlation-Id: a380de59-e873-4c3d-f469-08dc7f873295
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?npLtzPX0i66kFFdml2DvgqehsUrSx97FzUR+lGi8IFBt7PI9oh2kUCxzVaeB?=
 =?us-ascii?Q?nhtJwRqgrKviJCiq0Gm02+K2c+WYHQ5VrlcDzaoYEXEo6ZR3SR7olwdeL12Z?=
 =?us-ascii?Q?x8C+PCgNte1EmxfNpGThD4105S0OtFqoqFtlcPjxWL5LksT5WzjGpwSh7p5g?=
 =?us-ascii?Q?YgeuXodVCgpoRK/IJRgLmw5/jJK+V1BtZmTNTI3N8+SCT0+nX3sXTsq9KmOc?=
 =?us-ascii?Q?oIjibptsDP5sQkFsPZuZuOcX8Qi2jTWOyd1AeFMyfIrKglZHZtaRuTO+5Bo7?=
 =?us-ascii?Q?t5R+6aIwIq8r2HAstj1vw/4+/rnNnap6kaaeY0cGUcX0F65S+ePRL9x64ROe?=
 =?us-ascii?Q?lwEN+ePhYFUD82uCyQ/yyJbEMEZJzjswgvoeC73SvNdkt0JxgAK2jBE1Kr10?=
 =?us-ascii?Q?J/IqioS5SRbqz6z/YSFRhAzPrbC/ddq2rDLhmLCWBtAJ9xkVBHpSfQivxU7y?=
 =?us-ascii?Q?UmpylwRR2MyaPxo0sESrtz5ALhA6dr4qJHf29BJokMYaWNpNgd3UUazdtuQ7?=
 =?us-ascii?Q?r8/05Z05MVs40n9tbIrjI4oeAUBQXTNV9drEP2qarblnFkziKMJ4RoAlMug3?=
 =?us-ascii?Q?cB+uRQTKl/uy2YGXoIbFOMXyEQIGJc2JAoAOItUMm25Jn1lCFWn747CsnN4w?=
 =?us-ascii?Q?wAtSDBSGPjOtTSARB+nEupaQx5wBLRZGBuPxX/G3cU0toM5J3jMdprxeC/kh?=
 =?us-ascii?Q?aM3fEyKeIbvj4mzTcCXJBC/XuAxTuuJFvJq1NafP/8lfQ7Zx4XPSjC18f6J8?=
 =?us-ascii?Q?bbiAYMkTQEi6Gdk6gaqs7i2Z7d3tftJyAmLHVPZA34RaqRs29Z5wdE00w5zQ?=
 =?us-ascii?Q?DIlcqNGd+cKvQjGFChQE92oLKzWza8Zsv8NVCAtqnPJvvo+gWO0XU4PZ0MFf?=
 =?us-ascii?Q?xzmY5Z2mgnuOwXjzJSo3XfLlZUI3BymWyeSQdpzoOYFY6/JFZiGzExxKswA6?=
 =?us-ascii?Q?+QA5YDCsaZMc2ZasRgClCm0r6rwazRHpG+hzjQbM0lGiIw/2sU3cBbcIEg9X?=
 =?us-ascii?Q?/WFgR0lVXptrQ7f3uaqBYf+dCCe0E9TzbiBetpaP3ftwkmkj6V4iOYmy5hNy?=
 =?us-ascii?Q?mNFZWftaxqfPVBKj89QYWg3NKapVubTDhH8miOUhnA83fDiEeaFz2n1UVIoA?=
 =?us-ascii?Q?uhOlqJqb67QQ9TJ0ZHhqGpngcrd18nllE8Sbm1T33YxRQ5dcQM+aHCVcUEM2?=
 =?us-ascii?Q?XKFmzTpA8OsLLtjRyt6Zc9u3DXK/1NxP8+sDFmfreKZK1G4lW2Oa9G6N3O/I?=
 =?us-ascii?Q?6q2VnXQxgYBdrEAyjd4/B7n5SNqx32j97ZPsEtbaOg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SvGrp1/s2leccSg0K8xBVT2COSGlfmhXSPBz4BwAhUwcNhnZf94qCL6zoEEj?=
 =?us-ascii?Q?HD6GIf32J1pLax0NSs38K3ae8PBH6wNOk+GxXK4Sm9qHPZGzJtIp1L167qCf?=
 =?us-ascii?Q?UEH60olPNSiq8P2HXW/jU6/afUoXcpUiXO0kR5dPEiqmJtOcdkrGaRPVSZ86?=
 =?us-ascii?Q?qBft3tEcnfUiZ0lkNJuVCttQf2xHSwlZTjoyQwVfT9m/0/muwcWANXpm64B0?=
 =?us-ascii?Q?jxyeJWi/Bnv+DfjFxG/tsuG5uC3xm6/ldK5OysJquuxpWhkc8pYPh6CBhupt?=
 =?us-ascii?Q?U0941raczuldco/WKewg2C/5iF9pkdHx31gKZtbYaMQD6a1Xi42nursSSubG?=
 =?us-ascii?Q?knzll/K+LAPkHiURsq3EyhQElLi1CZhE3yM2ptrOF8TlOq9edKhIF4FE5/CY?=
 =?us-ascii?Q?/hgGflZkvLNShUzPCO9khearQG45rtiUiwpCVZZoDT8DPpzCz/xs3cBJAZWc?=
 =?us-ascii?Q?8a/LRlzd+QZheYVT+ugQ4WOGy1DWNAZBxrZ3nTZWRfB80jYNAuut3zygwxA5?=
 =?us-ascii?Q?ySaVPFZG5CU4ZFDW8nCJPFxzPCBbYKCVPT2RCVFoeYN45ZXDukwOyKx/8OPB?=
 =?us-ascii?Q?CXiLk9rf92L313XPnFsQGjx1wzixySPA5hZi9CUOrSaAobia0W4AI3hKnIqY?=
 =?us-ascii?Q?1n20b4Wvoum6rGmjjDfBDbStf4MO4oXmFgo+TtXHK9p6nEVl3a6u+vTndkqU?=
 =?us-ascii?Q?1y5mKCj16xXGMZI/SO4p5a/w7V92K638ZrlAJ8OGduait32ECSeqSy4vIwc8?=
 =?us-ascii?Q?zm2N4e2RkHV7iWx9kT+cFp22GTy8rVrLZdOF4CEeqQlhh1/a03f/BxJzsrpX?=
 =?us-ascii?Q?hB0EUau6MItIa5jUrahBzPdRhukOG+be5zpYESrVi9aNKIKOv4Uz5KrnrWbH?=
 =?us-ascii?Q?Oo5gIwODrrKvWuaRs7HprVepEROf3JE7NFCaWWzfoK6yYbeylxSl072Ts3Lk?=
 =?us-ascii?Q?v2XBu1RTDyGVvcyD0BLs7RfI9HvoizO0536YZx30msLIrnD0vg8CiWIDp2Fr?=
 =?us-ascii?Q?IE+29F0NLhP2Znp/VIzgEjPoIMSfzW7F5bLyNp/jxm16LmuC90Xt+jdnCmkb?=
 =?us-ascii?Q?t3WYpCdUnxGbBSFa35ffBZPCX18R31kQGnlpS09uTn71Q8EvMKly/6+O4MZ4?=
 =?us-ascii?Q?GFne+1KYfHhWoEbadISv81ErIBDGTblmBh1AbYNzQWyKGtJP43U78eiC7eLV?=
 =?us-ascii?Q?HCaiOQUMSgiv3jx3QB55NFbRGSXdwdXQAgbpn/7n4fEBAS+jJD08cf2Y4xiK?=
 =?us-ascii?Q?JUYkGLzmLTj8EMXjSUiac1WQ8nL3sq3QlcIM9b1U5nCwLvLVwpAedpAtEEKB?=
 =?us-ascii?Q?FKCJ7UiEgFBzULeRM8pJ3d1g/Bq83aU2rejkp4T+QKlfDB7H5BtiWPsD00cT?=
 =?us-ascii?Q?jDQDOdca2SszW5cWR/hYT6CheZPmVXOB7AnL6Li1BbAdAS3rmtTKd2q1WXyc?=
 =?us-ascii?Q?D9SYHrS++UC0D37PpLXNGPxzHjy4LRDyatwnFeLaZ5cA86w+Vtdfd7cfd7jG?=
 =?us-ascii?Q?fN1qW9Xkaz4gau0VkYTy2pBRgHRTgMS+jh6leJ30rSomX6S8DHv/60JilJWq?=
 =?us-ascii?Q?Sb8PxbWGZjT2U74F6NUE78m/UJuwYeLGYtXgovvd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a380de59-e873-4c3d-f469-08dc7f873295
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 02:29:42.6437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pz48Syd1TfxOdbjrKNfjZ1mGJfj8Q83hgIgCPZoW7pZ4JP2PlQUn7qF7wmQz5SpDK3a7PSSzGx3YXYZgYvkTYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5725

It's slightly better to set _GNU_SOURCE in the source code, but if one
must do it via the compiler invocation, then the best way to do so is
this:

    $(CC) -D_GNU_SOURCE=

...because otherwise, if this form is used:

    $(CC) -D_GNU_SOURCE

...then that leads the compiler to set a value, as if you had passed in:

    $(CC) -D_GNU_SOURCE=1

That, in turn, leads to warnings under both gcc and clang, like this:

    futex_requeue_pi.c:20: warning: "_GNU_SOURCE" redefined

Fix this by using the "-D_GNU_SOURCE=" form.

Reviewed-by: Edward Liaw <edliaw@google.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/futex/functional/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
index a392d0917b4e..994fa3468f17 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 INCLUDES := -I../include -I../../ $(KHDR_INCLUDES)
-CFLAGS := $(CFLAGS) -g -O2 -Wall -D_GNU_SOURCE -pthread $(INCLUDES) $(KHDR_INCLUDES)
+CFLAGS := $(CFLAGS) -g -O2 -Wall -D_GNU_SOURCE= -pthread $(INCLUDES) $(KHDR_INCLUDES)
 LDLIBS := -lpthread -lrt
 
 LOCAL_HDRS := \
-- 
2.45.1


