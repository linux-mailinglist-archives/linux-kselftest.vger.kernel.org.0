Return-Path: <linux-kselftest+bounces-11460-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E3A900F31
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 04:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5057C28346C
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 02:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03991FC18;
	Sat,  8 Jun 2024 02:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K4ofHFid"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623A4CA4E;
	Sat,  8 Jun 2024 02:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717812635; cv=fail; b=iJR38d5fMBNnRmEEN/nVpxx8/EN7mwf4AXAj6VNXNPkwcvT5Pf0yuMPqbCuawUoG6lxgNfJf0BO+9k6TcL64N8+ONUawresROBUUCgHt8TFTMTAZ1EOZOEBAaMBqfx4CuM0r1MAIgFwfjRBUcL6G3FBwhpcerzrQTeV3fhLXZiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717812635; c=relaxed/simple;
	bh=zzqEeSbHMdKVIHB/G4eL6lLIpGPR2PpOMMdSWwUgClA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CfykS7j1gkZhaz7jE7zQnPSiidqlCNaWhtk5wZf65iimgENrJhbGWmzbIp/0D9lwPSZAX8Wo/nFD5flEVS91o1pW3UVu2KAAVk3ZI1lmsLOmy6ZJR6E6fsxA8ejlrvkpv4pmObmrwiRAUTexpe09FIkcOItnWhbf32ngZoPcbBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K4ofHFid; arc=fail smtp.client-ip=40.107.243.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K7MM/04yEVKR/HAbvqcqqlpZlevuLlfmTGPTJ5QBBJmK20hJV3t2c3ULJzYlYOt5PzqwgTyN1hkDgMzDJuMh4dA3+lBYTCtrC9FYf4pwEUbyLJD7N5Qk7pLgUp5RvgeiBPVdjX8YaSAFepx26CJuvil9SyNcuP1bO/CET3WB3DsVBTDZFy+NfNFvOl4SrsjZKAjSc/y624ou+nhCVWSjR6nM4tqmoDh1QnLfRLlJpWKWtLP767cldfCpLFayU1MfyNCWz1WPDdD1T+gPBvL3jwGxYyMaCk+tWVNzytNO8GmaPlp38FR4QsP4w3KoJinqtikpVDK1OgsWoW3thC5kfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZDWmta/WEXdEfNKbz6L8CJQ23neTi3jcvsGNZDTPnA=;
 b=hA8Dl39Fo5QT1cUiM/WA9grnSE9qDHHq9L+naDEepJTFp+99AHOMVSPV/LaJI2pV/HedHUntU+rpaONqEkcwO8H9jGvMeB6O8O6BcKr/P+5KAZS1L0zETczYMh1WK86GROXp1aFsPCFL52aVBmKqK8xFyw6ttCvYirSp+CcljuvRx3yvUWn8LtxcJ7AQ3OaVuLOHr3i0ENNIzE5x3p9usP5oZko3L8eMIwLTDxupDtTg9vSpb/qytR9/8ldR8Q4F9l6L1j1Q2XSJGcVgW4UBY9JNovp9BYtvnl2rJVHpFve0F6Eok3iIskbORDCFbDHkMGFaSGNix0Gvzg9nOTAPXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZDWmta/WEXdEfNKbz6L8CJQ23neTi3jcvsGNZDTPnA=;
 b=K4ofHFid38R13vXO8Lod44S1u1R3iPrv0KvAddkbmzB80JjlekbAUqgORHFAx+44KjIJdE3TWQ2DeXCpVQbbJzs8zstm+NKFa/6Zx6xhjc78HOiboQaQG27Wmvrg4aJheUk4SZqh8Oer/z/nEwD2i0IAdoVRgfiFVmZ3PswzXgHtJYC9MnJuY8GpMWsXHSjEel/VLM0PcVAyQv6ddUnUfMIq/mTtP9i4RO5JSlXw7olidIOfU8rnsUY8ajZZm6KNJWBxmvjGJSRPv1J1Z2j43Rm8fTVb8x0Rx/0A+bazn7umgb4xIA+01qO8S8bENzZX903wjH605xglCacj6Nng9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BY5PR12MB4196.namprd12.prod.outlook.com (2603:10b6:a03:205::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Sat, 8 Jun
 2024 02:10:27 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7633.036; Sat, 8 Jun 2024
 02:10:27 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jeff Xu <jeffxu@chromium.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Andrei Vagin <avagin@google.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Peter Xu <peterx@redhat.com>,
	Rich Felker <dalias@libc.org>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 3/5] mm/selftests: kvm, mdwe fixes to avoid requiring "make headers"
Date: Fri,  7 Jun 2024 19:10:21 -0700
Message-ID: <20240608021023.176027-4-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240608021023.176027-1-jhubbard@nvidia.com>
References: <20240608021023.176027-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0011.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::24) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|BY5PR12MB4196:EE_
X-MS-Office365-Filtering-Correlation-Id: b60665d7-8178-418c-bd07-08dc876029ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2qiHPAyWD8Hb6R5735J3OwTh83F1MuMFW/p67G1DfhsOtxiGYP74L05iHwht?=
 =?us-ascii?Q?9PNc7Amae3+XrG7hEiv7vU17WzoLj88HPXYAix77HKlybPmqjjSkoahdi986?=
 =?us-ascii?Q?lyfjhGKeMdKGtJ/bqbFdtgQJow4ZffU+qukhSR606C9Q3nQM5OQIKnr6aBfl?=
 =?us-ascii?Q?OpDjWkIBtTN8Fsd8d6WNJHEXDbU1ruEUiwriBYizIRKcwUbw6moLarsOgsZi?=
 =?us-ascii?Q?Lt4IR3JOEMba2U3yIjZvbRMbrnpqug6elmgE/lzzq3qeNZHXJMI/anUXg1M7?=
 =?us-ascii?Q?WJs3CjlGfH5FUpefi3W9fLtYHNUHoxkbPk6UQ4bTVK6s93LaP59Wj6pRFs2a?=
 =?us-ascii?Q?QGxNQULN0qpKMsq+gijfXYUjptiS8l+ylv26wyfrjbY/U99fV4s10ow4i6Vf?=
 =?us-ascii?Q?i3E5/ZeRH7di3oLeCF8ATpJ8GsRFyAKU5IjTh66i0J/Pe4/KhGAm3LP1cSM2?=
 =?us-ascii?Q?mFq3jk8/6uhPm0Q3ECVMvehp5Q94BcBRtH/i2w1NTyP+NQXAOzAdEnYW2tUv?=
 =?us-ascii?Q?neTr65v5FyrTwa28OF0jg6RIO6xf4po6sK8B4lO8yG7GgtNZo/8qNAiD2Di9?=
 =?us-ascii?Q?oz+EIlZL76jFosm4h4Gwqnz6UeNCoqqKhaCghj7lFuEo2E9+qvY9PJ63I2X0?=
 =?us-ascii?Q?LEKpb4fVv3aRTBbxPpHO5R+KiiA2vaaBq0m9gGKOz3i2HKxtmVabsWtGL1LG?=
 =?us-ascii?Q?zv+pwxSfV7tto0JPGU9SlHGA16vNAsf/UmQUltK4gLAsKynZr2xd6HinMXQW?=
 =?us-ascii?Q?N1ny85buF/kOIiOWSw+U3s43IkfDMMUL+NcOwglPOGXZjHAQHtGFDMBUeR6u?=
 =?us-ascii?Q?oDHPStcT3bBr/fWlmbiCHJwBEaEO+7l/k0eOlyY9KpsV0qgKTWGLadqUKfrl?=
 =?us-ascii?Q?MQo2nHTwXMsex6N30ilmyCUu5WVLzOXMheN6bgSAof8UNYN9RWdgb8mCFooX?=
 =?us-ascii?Q?RrgLEqMSZ5sK/pSY/BHXGtk1rMWJIbcyKppAlbaUEek/76woWxkkasFM7b5n?=
 =?us-ascii?Q?ptd20k17WD5dzSkSvB8ZmTDwMnACrUOKQJFqsZxmuZOWHhYBgEm4A8LSX7kQ?=
 =?us-ascii?Q?TBvKZ7XHqcS9s5T3PcBoVLbygL2IMFI4m+PqaApqhYyA/B61Na8dQM92ErvS?=
 =?us-ascii?Q?+K9FwBb7S3cAj33Qmy/DC6lC86WwjVpQ3PvHDmoxmsZUni4rv3GMPRpibZ3R?=
 =?us-ascii?Q?LfZttv+iaORjxLB9JyUI8Pfkp3sXGBaSjWuf1oH2YZcVu0MB4f99FbAeCWKZ?=
 =?us-ascii?Q?AgzD7hzwezCZrMsmvoIdWBhVqEPXxAY0QwHM1AZAd9s7MDurQB1RwunSECck?=
 =?us-ascii?Q?1vb2OsT9Uc2vbNdgz52ukT65?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XbnsU/CARXPSNyLe7X0EEvKcL0h1QilFx+346PsYtjX3QqyBLVzFHzvf9qIL?=
 =?us-ascii?Q?SMDjKRi1PfA5kgoPgFX3KrMIOPDs66lUmOSznNZEH1MAcSTf41t+zJtirGhN?=
 =?us-ascii?Q?/ey3UEOIlHInhdX7+cflI4xBUziHYbZqB7bdinxtprUoof3dyB7ieHQ+xSGD?=
 =?us-ascii?Q?KFtTMB3Ni4QTtklNSB8fiuCHRFxuU3uJa8x/m+/NNE+jUxg8UM/oZggupedI?=
 =?us-ascii?Q?aU8F+9aknWhZ6EPP5XsYPrOPPkLOPYxFAhUeZDLVxRgTJE8wVjcjbYWr1MEA?=
 =?us-ascii?Q?UrEtWBEpJDF3yeGXm1VjWrPTmKSH5aLVFDiPPwnS1wYP7JVg9E/lVkcHUSQr?=
 =?us-ascii?Q?L867nwpNwOpTsagPlnm5uoBPWlwjmohSRdLDPKpnf+EJUTDbl4ykQy2iV24K?=
 =?us-ascii?Q?/eCvCG1toOVxGOmKYrVBamJQ0s4MpVnnpIwnScMFmOzL3H3sdff37oPWEto2?=
 =?us-ascii?Q?IR6pXmo0Z7Mpz/VJQdtBCG6XZXVxwaZflAjfGnqwTbVFZQjI0KpGbn24RMo4?=
 =?us-ascii?Q?cCDMoFi7/28ZgmnZ8F+IcLU7kPRZgv/A0voBMKPLit++uS16kUImWL6jRY02?=
 =?us-ascii?Q?xY3K7RT7DE6t3PoV9FMAD7eJuXi+moYmynXBQzF9zYqNQM1nox7e2KDjdMZm?=
 =?us-ascii?Q?Qjd10fBFhscEgipgGZf735GUgeWQKdf/Ym2oW95hhwSWR66jRW9yKe6DFLVk?=
 =?us-ascii?Q?uOPG9Ciro/Q6aRMZwbAU9IaT/bNXytzaqzupgtHfvb6aYlPJ1EIuDfxEWTae?=
 =?us-ascii?Q?9cqSx4WegScAmi5BS4Nw1ovfKwpxIodKAbubfv7vvaKp0y6AFZBm6mg7rovO?=
 =?us-ascii?Q?uNqSaZHxPq2dKUiv9GsBea+VNqnD6sWf8pDvxjZvXFRt2rNg8dBtenNU1TE8?=
 =?us-ascii?Q?3YbDxy8PR09odXAbzevT3eH3//uL0cgFWBzbHD3W5Mo/KNJq1pdoxbX4daPO?=
 =?us-ascii?Q?ElkwpdUWbvx6Q4zKsOlwT5NU02FnWfQmYvnM2cEfhZGgQf9+4vKwHmHSz1yZ?=
 =?us-ascii?Q?Sejwn0/SlBXwSAX12MXVxohYNNKpF1BFAIBEAzXUXugWVsOxE79FkDt5/H9x?=
 =?us-ascii?Q?MN+O+KF1euelwm8LUjmo86lzCcE7AvgIRZTiWYO+2y1qMN3tJ2hPfHFgFun3?=
 =?us-ascii?Q?Xm5TfSd7kDXLRZ8d1i6SNdrVw+SUaS08/zRhG2roZg69AT2QQLxV4gcBa2n7?=
 =?us-ascii?Q?6mini/BgfshvWdHPotEHEEPr5ujm/ig2aq81k529XXvCA3y93kpepEu5ulkz?=
 =?us-ascii?Q?tu7Pckz1YNX6n/UFBfRa5qW3T8118EhKDfnZeVaKB5xmNDmgJgN4pOuX1QF5?=
 =?us-ascii?Q?E3fI0c6fLEDIhKO6AM8JVd3UQePjs9DnSoOiZ2P39PnnsVKIRTdtY2+f3Afe?=
 =?us-ascii?Q?lURcg9f0m/aI10yi3e+LiQnd+wiCMhwWx/02ZQwbJb0pCZsAN2zGaPumY72w?=
 =?us-ascii?Q?WU0sELna3uZTD9Gll74cMSTcxc3ZLGCEuU3K+8IvDjuMDMCT71j2DpzxFeXp?=
 =?us-ascii?Q?lffPCQbPydcMJjAuJ8ozk0WaeRsDJSuzktq2Y7b0pRYQZtdEHSXZ3AKyhIuz?=
 =?us-ascii?Q?lZsdIZcaR1STGToIhHWwK8HTQbCOaZ1cqaavDm+8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b60665d7-8178-418c-bd07-08dc876029ee
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2024 02:10:27.0586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XOUiUa4bDVCqtTg5O5IzGbsoQD+nCRFIP2SLtpJmzggqelYQ4FQro5aVd/nFKV+G5Fxr6SaFajig/7Kap19dgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4196

On Ubuntu 23.04, the kvm and mdwe selftests/mm build fails due to
missing a few items that are found in prctl.h. Here is an excerpt of the
build failures:

ksm_tests.c:252:13: error: use of undeclared identifier 'PR_SET_MEMORY_MERGE'
...
mdwe_test.c:26:18: error: use of undeclared identifier 'PR_SET_MDWE'
mdwe_test.c:38:18: error: use of undeclared identifier 'PR_GET_MDWE'

Fix these errors by adding the missing items to vm_util.h, and include
vm_util.h from mdwe_test.c.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/mm/mdwe_test.c |  1 +
 tools/testing/selftests/mm/vm_util.h   | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/tools/testing/selftests/mm/mdwe_test.c b/tools/testing/selftests/mm/mdwe_test.c
index 200bedcdc32e..cfe0b64d1567 100644
--- a/tools/testing/selftests/mm/mdwe_test.c
+++ b/tools/testing/selftests/mm/mdwe_test.c
@@ -15,6 +15,7 @@
 #include <unistd.h>
 
 #include "../kselftest_harness.h"
+#include "vm_util.h"
 
 #ifndef __aarch64__
 # define PROT_BTI	0
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index 9007c420d52c..99cbb7c0ea9d 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -61,3 +61,18 @@ unsigned long get_free_hugepages(void);
 
 #define PAGEMAP_PRESENT(ent)	(((ent) & (1ull << 63)) != 0)
 #define PAGEMAP_PFN(ent)	((ent) & ((1ull << 55) - 1))
+
+#ifndef PR_SET_MEMORY_MERGE
+#define PR_SET_MEMORY_MERGE		67
+#endif
+
+#ifndef PR_GET_MEMORY_MERGE
+#define PR_GET_MEMORY_MERGE		68
+#endif
+
+#ifndef PR_SET_MDWE
+#define PR_SET_MDWE			65
+#define PR_MDWE_REFUSE_EXEC_GAIN	(1UL << 0)
+#define PR_MDWE_NO_INHERIT		(1UL << 1)
+#define PR_GET_MDWE			66
+#endif
-- 
2.45.2


