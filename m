Return-Path: <linux-kselftest+bounces-11060-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B27328D6A7F
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 22:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5D2A1C21B45
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 20:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168C218628C;
	Fri, 31 May 2024 20:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tYtzQq/B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0D717F4F0;
	Fri, 31 May 2024 20:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717186093; cv=fail; b=IefZjAGaXTgKNX6ucBkHXSYHuTC5CRwjHD+fXlhSvrk8RxM3izVvYEvNZK+EmfPaMBKhGNYE+J7F8MiToIGyFVKGuj83VkC06cFSFIa/HiCNiIzv2DxbTSEpyO55HOTDqDPnrMsz50mW/MYithxb0Zcjeh+F+Vpi2Y7tsWzRc9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717186093; c=relaxed/simple;
	bh=xkF1tllS7e+DZTZ9jHJSvdZ+FCkY0pPkBri0DoOV1RM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZYj5OKVsOPJ61SVvf8ediqf487yh07xbAWXN2gt/mEjGmYE+aLfIBGmrMd0lnyO2EXoxCI4ODQ2EFKnbtRfzo1p30qR3mzYgdxvTSD3Q0uxXoS6nD73OJ9ODmryyEl/jZ5eeTcKkS1rLkaVYIpFHDbvvqTsBKVCBcS1eC4M+0ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tYtzQq/B; arc=fail smtp.client-ip=40.107.223.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OP7SfuQwCRaGtLJw4ZsfJkFN0k2qBjbAY75s3Pn/HN1eFk/CcfOaGyGfDNL3oXOIbvpdAjOGJjvUd2Y23Z5q2je9MSnQyiFUuprBqoq5dMutP5ZbyGeTk1oEPPuiu5LU0bkyH8IFBwi2l5Bn2SfDs1KuYbaZVRdDL8mYxzSuPgtNOxo8tJ01X41SsBeNau9cCTNlq2Uf+U64KIjb7C7xk9YobBWt3ek5j0M1uZJFIS4FpqXJwNiXAzYAUz7FZjzGQpqc0NGPX2YzFZWipWT6fu2g3cwqQ+baOPXom7y5leUDzK2TialiphXBLZ3cmGCnSxit+PTbdrQj1kGvOmQl1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kec8cUwqo8PXdu5+3RBtwP8N5SJ9HTi/RyoulnN5bi4=;
 b=CncQB156/S4gbS/Y/6EkAR81LiScEDAF1y1oI+tLPxbfOHM2vBeRPq5HdbnXO8mKit0+kj8d7xWGM/HC2Kn+SE7Wo+7p5uoquFOEsHXEeUAnROuPvUbzYMtN2H6kQyFYu3cxfG3KoNeaACLty8YZ2HKvTSm3lj5BQ7ipFYrc1rtvqK0AnUbypH9fQMeYHf9j7A5Ld2APVB+JwwH0NDermzzJpFmHS0FC+sPGFfIzjcDpUeuQ/ymgAy+u9GrCnslqe8GACxlQatN1MH5CHStllx+3nXmzpgapfU2dnVjMRYWpas0ZHLDGpcH482CPf+07pSMW0FD5IYf1xg7ZX6kKoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kec8cUwqo8PXdu5+3RBtwP8N5SJ9HTi/RyoulnN5bi4=;
 b=tYtzQq/BobCI6EX8YHbd+W6oiOEL3mFZsPkoh1+NBuWGT+lE9SCTn49wdzhDBZs0klC2wd6kQNV70Dki3VCEwuUN+ze+MfXD3GtAlD17YBf+0WybVmkAXWCXLxNGVZlD3LfcQRUs8f2GiRrIyMhTrcog8B+3HekfeF5yE/Bqs1n3WtW3awA8mG7OoHZehbb/Sj7NOue2KpDG+JYEfIsGtph7+htBtwE3aLvhobuhR89v+bD9aD46qr2HL4v/fTpAf/RmGGQC/OcSgUmsHQWaVCS26rErGEdlzJol5mB51pxyXgB0gXxp6yuDClR8sp+qiPxmkjFKseqCbaSAqmuaEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by CH3PR12MB8880.namprd12.prod.outlook.com (2603:10b6:610:17b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 20:08:01 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 20:08:01 +0000
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
Subject: [PATCH v3 3/3] selftests/futex: pass _GNU_SOURCE without a value to the compiler
Date: Fri, 31 May 2024 13:07:55 -0700
Message-ID: <20240531200755.128749-4-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240531200755.128749-1-jhubbard@nvidia.com>
References: <20240531200755.128749-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0061.namprd05.prod.outlook.com
 (2603:10b6:a03:74::38) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|CH3PR12MB8880:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c8d40b6-9056-461f-6020-08dc81ad5fbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tEF/tLgv4sa5bXDoZgd7AX6ndBhs1pf0EHRmLjTjRSkxo49jwNAw4lB5pJ7C?=
 =?us-ascii?Q?DWTZ7zV2nzO16seN5cyyh7KGDiTeVDrXd2Q3+wapWOtWxxBYTz69jLUo0N1C?=
 =?us-ascii?Q?CeiFF+4sqGwmcb4h7iuiO9uU0F4axeBDPFuk7g2qjfmGiyElgkUN3AXQMSNR?=
 =?us-ascii?Q?61iahpDLgTCDkZNwSGRJn6/csMZKS2r0czOzBSCw1sTxpPfhwLj9NGy72dPJ?=
 =?us-ascii?Q?AVxR7rckTAXLOERLWxgI0UKoEAJKDv9uoQ5Fd8fgUzVMLCeIb0/jOZMkP3qj?=
 =?us-ascii?Q?Kkywt81dbi7zl52coPodaV+F5KUYwETPcuqEyYIXIxONxpTDjY0nBwV7F3jH?=
 =?us-ascii?Q?i1NSTtJZ+sEGUPhVhNaoWUrSIjl1QQdtCUrXIQtkXmhKA9gbmOJcVZ/oCfi+?=
 =?us-ascii?Q?Dc4oDOWTNBU89yWo2o0biYneKGrNM/wql04MANY42Em5NKCcZCrgRkdVMWjd?=
 =?us-ascii?Q?cPjFp4OW8gAaDTmOHGLs7HREAo5ZuHznVgRYcj5KSq+L9WgArCplmOm+O3+t?=
 =?us-ascii?Q?mOFJER/aHEuq5kTJ/RzcRggDlJs1o3UuFl4DH92wde5T4gbME5UNgwHrxaAo?=
 =?us-ascii?Q?lj50C7g8+xIpSrkPQuUnxyicAfMMR8AbaBBc1vIE6/hzKdAPlYQ45GCPTt/i?=
 =?us-ascii?Q?QvNtGRtRGDLCTNCRIIhOGb9sQEgdMixnizUlRuqoWDmOpBjyIOQ8Lc+JyTHS?=
 =?us-ascii?Q?uUMNj4d9aU3fHrQ2mmb4hv7Bib3fp+tPl65dg2A8xwpyZUyAdmguJlN6ketJ?=
 =?us-ascii?Q?6Zxd8MAK8/FaiZfIo4WjpkZvT4m7TcWSN8FpebQ0YKXbfqCgupPN1PBrbAwZ?=
 =?us-ascii?Q?lOBqmNEpSTTJkOsPrGRGtfWCJFqbr7vuhK/rvVqyKdS/DOFaBJKRllUZR1N/?=
 =?us-ascii?Q?K7gWi1FmJPADPnT9MlmFEG5Fsl7rJ4TCd0uYHWGDH4oWgvrz/coB+rBv4qZg?=
 =?us-ascii?Q?H7NNI2gtCbhz2wxQmuBGEDrznDSZmxo6FTRyUYlgQ9F7Utjyi6c9RPQTT7LG?=
 =?us-ascii?Q?vwCDf75ipMQqsqoCF+RFOqk+6wFBDbSoeiQnchwb7Ri1zvfHsFlUPYF71Toy?=
 =?us-ascii?Q?nViUzbvM5DhUvrKhHwvb9nBhiMkrhG3G8a63A3xZwwW1OHWau4G5cyHQUeUF?=
 =?us-ascii?Q?DiTZetppB4+aJ4ZZwYP4rabrPJXiNJmp5VHWCnB6XCtk7MlOHKD2EaDojYri?=
 =?us-ascii?Q?CAUKDaWTXxc0raE0JwkaOcdxyvv4Aee/uaj/yfj9nz62MMX+fTk5rpl10nKo?=
 =?us-ascii?Q?MwByJENuV7qDj8wb2S7ieaIijdye+uUe6YQRr11kow=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Sx49zpABabw+98W7m+BDF7X1ID8xqDMQ7rELMN5e2cNAHV3uMveQEXmdPWjo?=
 =?us-ascii?Q?8QWK/QmswGOb6+CjQqyfJH9GmjR1BPYiCk+EoR+nD4s5AmiQprN7TqFKOv/O?=
 =?us-ascii?Q?j+AGa4NyW/nJynr3SWfZbssN4mp5Lq/rTYu3COKVnK1mK3bqXIN7fPNDteVh?=
 =?us-ascii?Q?wN8h5id8Wt1a+OLGpQecTQ6bIUy+c0e8QzthluJAKfJBfjPjgQ25zqv8AiIy?=
 =?us-ascii?Q?qgSNCyWRIV+F0k2EFZYVBl1MhKowOpsVO60xexYznnCLOaPsC7yEha4eo3nS?=
 =?us-ascii?Q?/AJWv6hNCeMoYSMf3Eq8vLg7tbsC9KvbNSA2CFccNXK5rwtc/puPw4z+Ed/H?=
 =?us-ascii?Q?m+yiqYRjGoGp72qjSTduZEQMMeBkHoLcHTzUa9OJGzyYPl8tn5VFG2UgG9Ge?=
 =?us-ascii?Q?bAMN8z6VKWh6oyWxStQRK8SAFhN5PBNV9U3uOiLK1eAjHF1CNemSjwaNM8Kt?=
 =?us-ascii?Q?Zup6OSpMAbB0niC09rENKka1mliNvyIrz0+exITGg5cKn/6sDg5bAlZeEGvw?=
 =?us-ascii?Q?2U+GNBRwh3h46Y/vN1FkEhaqwMsvx8KbG2WsTxCFbKaa3u3pKViHM2P5GLYw?=
 =?us-ascii?Q?OcVAXYFUccq5lrrBlkrVkwEP5gnu0aKu8/cr/ukkhLxk95s38Ab8kU0iFqjh?=
 =?us-ascii?Q?rEhetDAt/YUPkLTS0kqwjLrbNKLITczIrXviOGPvMkkXYkb06EfD3yKNwi4w?=
 =?us-ascii?Q?KtKigGzAPd/7Q/k4ixUTMmQF2XfyPV3FemUHQhzqmaFw+lPQSyWWoJBDqUqh?=
 =?us-ascii?Q?jgkBVWIJWDkfpSbJKzhA3/ABanDgF9xOYGS2e/Lpfw8u3EkEdGXGc/CChQ8/?=
 =?us-ascii?Q?jw/LaOf3ROgrKO7DSEIX765Me3vrO3gzxqCAH4gDucwTRg08YlhIJToMM3KU?=
 =?us-ascii?Q?3X3tCcoitiIo5OGku68reoFgCr4P8lypMARe8C3h5t0jRbklgNCIk7kXzOM5?=
 =?us-ascii?Q?aUAwYyZh0hVg0wFQwm2XYFPtBbJhiySmxxkYxu+w37yUDJ6VSpequo7+llwZ?=
 =?us-ascii?Q?BL0aJDSZM2An8KsyadVwmKuw7615OEP1IMfeMpfwzD3V0P7Zdq6+amvOEwKt?=
 =?us-ascii?Q?Z7BLTjNLMOcIUOB8sZPN7QAZwCUhwQA5eHcB0AUzl4Vy6r7Muaqf0i5bjDpG?=
 =?us-ascii?Q?eln0yjgcNJhJRn2IKEbA9cbyYOCn8iCpNbLyAyf+k8ASpV6p/pl9Oi2DPrVb?=
 =?us-ascii?Q?P6r+aY7ReFfNDcPQs7JatQs24QULKlW321nkcFZObKLtPw5VdRCRIVeH5r2m?=
 =?us-ascii?Q?8axGFQjzEW4k7lS5Xono4zIONSQlg6bp+4onukH/CU2yJT36ZbgKcpdvra/w?=
 =?us-ascii?Q?LnBHWoHXQpO0iw0qLH0HsqFSU5YfMLTpWQBicO3SWjk8gy7cBc+70yJxcJz+?=
 =?us-ascii?Q?Ok+tW8lEaaWIQqWsFLaP+RuaIh13DuKo+3eZR3yNo4PDcZKnjOwavWIkou+d?=
 =?us-ascii?Q?omeDfUUM6hU6qxa4eNvQCj2MMbgXLL8ZilkLRoLIHTl0nww1rQrtDb38tZQz?=
 =?us-ascii?Q?f8/r0KXkJVVRRwZaLYGzz9TseL0WlPjQNVTyPhsLlIuvoq4MTry757S9b220?=
 =?us-ascii?Q?XjqNm6IWmTrIQy6OuB9VjeyYq85N+h2nHdmOk1qg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8d40b6-9056-461f-6020-08dc81ad5fbe
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 20:08:01.6616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TSnSRU0lxLdPUunJKyR9cxI6LryTrSwuOnXA0qmF//1TdR1S4h6XcfYL4DSSSoADjlCUVMDj/Dp0jeEUcg9lkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8880

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


