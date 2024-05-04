Return-Path: <linux-kselftest+bounces-9451-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C11118BB946
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 May 2024 04:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 347C41F23663
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 May 2024 02:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E357AD59;
	Sat,  4 May 2024 02:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ncvmKhCX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B90D28EF;
	Sat,  4 May 2024 02:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714789389; cv=fail; b=QWhlmqXSQBMaQ8NQbQ3/rxpc/1AZeJbxaZEmlAY1fS3837B52KSTp5D5qXOp7wGSm1AjQl6BAQbyH6wuLdmjJCnhmpX8PoiKVlKUEBO+D5+rTUaA0eBLaZH9hj2VZd2y6Aby5Bvq9sQ7/U4BMx6mXAJoDjUbaetZyFdw6tTqpvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714789389; c=relaxed/simple;
	bh=PU+BoW0qBtK1q1SrYcQoEmPWCcEc+yd+c3ao/iEOTHY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JB3BfPx4BDxOkKEuZZepimVYotxQxdFV8rlYCvxmKLWJicjQAq9pmoRNVLcImaYyqzGPyEMTBt9ImoIzHODmAfQmEAN1he/uYPcX1Qux8N02pjCmedltXsfYxFmuBbF8seG6/3CRAj8+uYnQoAAGmfyN/Z2kBZbsEaXV0ItoQb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ncvmKhCX; arc=fail smtp.client-ip=40.107.236.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+UU2Im8GwXMmRCu2sL2riOwrrw/oizxLDZLL2O6h67ZFbnCz8am+cFPsOUTE2PDUlP1BKDS+6gwB1inPjNd60qIgNDaK1fMm2aJndOhaqyISDUEGqJYnIut2y5l7zjdHPOE5fKqiv4q5g/GfIbX+TeZJ3yJjQ9JoeDcbMoViWIyX480BxRNflTKMZEfsTIGmIXEyjZiCNBs+EeeKm1bQWRPwoaG2m1N3cmvnir2eme1cfPHVLhPr650xdAaZm59V7Z+EPRfpu1z9DSwxyTBuPWg7MAR27agLWeDxw9oOWxjmi08aJO+BxbUs2ByJekfCCmWHB7tACRwRPwpCDs5Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1ishcL6GenOO2CGGqEjzdJ/qOHZEfytWpY7wQb/Nqc=;
 b=CT5T020wJK2Z1bw/CMf9kuMTGdblJAlRtBZ1nNuaCpB2Y2LgmpfJdog1McxN6tGBh9Q8CLU0PlSkMwI/+rBLfu/tfWljLFudRKnsdEpiUqL5agOvMOvzqs/rOjQin/xhUCAMovmfOrbNDi1jK/tQJbsJvNsK0eMwPywwAwVfL5IZ8hqmkWl3/fFRk9TKXc/ZekfpcGZtekZuZftae+HncFdEGi5pmfC4KRKd1aeCyq5HhN1Y7jJ889WgykJcREgRodXFxKKh4COatPs/TjsiX4iAdS7B3778a4j+CUR7HDh8O/5rUWSyTQCTcbHOZpEebUOxxtPf0zfKJ0x53+8erw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1ishcL6GenOO2CGGqEjzdJ/qOHZEfytWpY7wQb/Nqc=;
 b=ncvmKhCX4tTFUYAKooYEkqBbbGNouC9KyQmjeJp4x20NF3m+oskU0mjWXMpovdjd5uwEKasVVLGEtiJc1ekFOUYGIz28UoqfmB65n4/Rm3TeJshoPZeF/IJCM1u63d6tas6RBDsRRkp8EwBwANRjVFEKasQCw+ScMG6kWhLcwzwc5P7dTKZlRHIIsB8r3hWwASBAlAgQu59G+mdz35jGApLyaNV7J46mkAnsye7yqJt3zO7hEER5Po3rz74bn+lnOaSyF5msw1PrYJWHSY4HNb02Q+aFQhzqKWtOnSOlgTDNhO/k6lPvtwP2+Kqp2hUGJi1hDALeQ6oqVC6hQN/iaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by CH3PR12MB9394.namprd12.prod.outlook.com (2603:10b6:610:1cf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.38; Sat, 4 May
 2024 02:23:04 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7544.029; Sat, 4 May 2024
 02:23:04 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Mark Brown <broonie@kernel.org>,
	linux-mm@kvack.org,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH] selftests/exec: build with -fPIE instead of -pie, to make clang happy
Date: Fri,  3 May 2024 19:23:01 -0700
Message-ID: <20240504022301.35250-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0001.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::14) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|CH3PR12MB9394:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aaaf012-af93-429b-11db-08dc6be1209c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YTJbkHNs2IcxcTohIiA/4kp30ZxRJdNGw3pDq8FfsMoYhwhvSTScet8fIDe+?=
 =?us-ascii?Q?e/uKGRyIrb4eNjaRCKIlTegx/M7Xwqt6m8QzPbGRHLpAuB25EnCgd6cZf4h4?=
 =?us-ascii?Q?hHIomTfyFXKoumT8Pf6N8hOq83TjAk1JtSGWwgBpLwCUCjCPCfadbMfv3faA?=
 =?us-ascii?Q?OCudXeGubHMjOtFKXdZ7ug6d9rGPlqQQSXc+ArvDVLW11aafmbdGsf3RVmKW?=
 =?us-ascii?Q?q3mwhc2JPQud+ph8UOfTG/J+MhOBjRrrFKgtLYeaFvHTuC28UFkJ0bDolhb6?=
 =?us-ascii?Q?TPPtaAsXFPWsFcw8VQYpTPF6jPILLDFwuYdcN7ijeiVKkbQEacoUcQbv6EqE?=
 =?us-ascii?Q?nqM+uIhfFFmWhDx6SC4dr7+8VlNN6zEILROaltj/zUtLxElLhPavcvBJRTLM?=
 =?us-ascii?Q?ssCtBNBmtCLx3Ogu2NHTID9po3T2APCxg+8yd8CRV+2YL7kaOugAeBIVGDFH?=
 =?us-ascii?Q?QtCGJq8kjbSGzUsLHXzQEy0rJbrrO+r+gNREHm0W8FBg4aZip77N//sfarIP?=
 =?us-ascii?Q?8idZSNnVEyakL9Y/M/F/qW0/PhyZAaQKT6BxBh2+IF1Y1CyIdAbsA8hG7PiR?=
 =?us-ascii?Q?i7bPTC6Okn2MI/AEwTZ+QKmUN6VmBYdYVXHHnl5dKWe+mE2TsfKamBh8LBzH?=
 =?us-ascii?Q?pS5ju69jqcMD5hw6s/qRqa1g0KgoMD3rEPPA59YjFPgCp6AjeitvN0tfxFAP?=
 =?us-ascii?Q?MVIHIcMh+qjBKrkRpmjpKleBt3Bp+ZHhCckBb58zFXmK4yyQVYo/1ozwK5Hj?=
 =?us-ascii?Q?PNPAvC63EObRkHOtc9YGJOgqaw5W4XZmUlFsJZnDdrw6stLFpMEzkS92EVCw?=
 =?us-ascii?Q?W3t+SUNuu5/JQp+Tqijjt+Yef98iayAkWpbcEg5rRfjvqCjrvn9RD+KYdISL?=
 =?us-ascii?Q?cXZg8ku8hdPxSL1ai1l7EJTX8QgnlbN3w0pGd8xjBVTZLZ4wABLn0zqazoGG?=
 =?us-ascii?Q?n0JlzBecxxVB41d7A74Sj249W3a5OTClDKMeqynIrPKw8ujd1FQt+Sb3oGKd?=
 =?us-ascii?Q?AXwnbFIHCVTxROtAbumxqamv/Eve3FCEE0f7eBp8fv+0F9J/hSeZeqEUNbQY?=
 =?us-ascii?Q?S8HdTbU+2VZWKhayA3jCrV92b3umhj1FXNhvtgBZcUeIa7zB4Iral9T4Abkx?=
 =?us-ascii?Q?cWhk7s4xVTt2be4jDE/fxDpQ/DCOihyUimBf1weU6gspbiRlxpIhxuF1h6o0?=
 =?us-ascii?Q?rVNurCIFbtNSCt572S9NEnsCK/BuLJ8ShV2gvrJZX9Sv4713UBpRGmeqLsDv?=
 =?us-ascii?Q?KGkh10p9LDi06S78jY3ktfJFqt6T6bUTepIZyFyL4A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t52vRHxscE+4WQVnDvACikPq7AEMp3oDAvLnTT4hgaJMr7GRLGSHFxKd3hx5?=
 =?us-ascii?Q?YC/A5mZW+CEjljiMm3nM61x76LSVX3VVV9SznGs0J1Tle8HSo8SJSMoQmg46?=
 =?us-ascii?Q?9sRPuKr5mutvz2AoqJfbVEVhHrvWsMKGEZhyjiaLvKQif7jspGPrbOYLPI4W?=
 =?us-ascii?Q?gupyBbA19K+ibpECS2xf2DugZjhXBZCI7tDayFaT7ivwERs+Ohn1jWb7z86Y?=
 =?us-ascii?Q?mR1br/Tb+NikMiLLvBmHbgOJFmiIlohKkttXl0qzJ8s+Yy18lgJNDsVeG0mj?=
 =?us-ascii?Q?rS5PRBJE80HNxstdmcqwmNEc/fN833TFqnI36jypad3ra7lGSl9wej8XlyX0?=
 =?us-ascii?Q?7cqx5pyESLEkz3DYfBnHBEO9/iitPlbVzjG7RiAe1lmGMeifd+rChB5ajIKa?=
 =?us-ascii?Q?so4b5JE8SREsg80cGxcCaCz9Kh8Qw0OaC22tybJqffrXWljLdeUHuEGiRxuf?=
 =?us-ascii?Q?sl7yCtHPvukxJBRGkuk+xBf4KoJA4tfaG9IbjIgqy5M4CYN52zm5ot37/FXS?=
 =?us-ascii?Q?PIcMH5IWOW1lHDIv/+2iD9dP/YIlUJ2hABN+stCt7wIX7kKmyx/86pV/glhO?=
 =?us-ascii?Q?AUcBjjKlOtcuHOq7iSj74SPquXm7CNqsA7RuqqqkLwnge30pJMAjEZmJ9vvR?=
 =?us-ascii?Q?oovT9e4ZNSEPT5mals/40ulvKksB60pw2xMrHqMtyHYG94gCSR80uzYahn2F?=
 =?us-ascii?Q?9sJR0efujZfdC/UC1uwNclaUF4hiUpJvNRWGhLFziasAh7t8B5z+79JIfZQ1?=
 =?us-ascii?Q?tRExegY+CTR+TIySUq6zSVD8k1dIbh1WOtcKqMsd+kszFOsCPNbco+ab3iUO?=
 =?us-ascii?Q?JTDx9atvS7mVzM7Q0w1namUNs5RnMYnzxrQFp+7NN8QhdMRIfB1mCAYLhIcr?=
 =?us-ascii?Q?LV0nRPi1BYxu/LbT9wMtCWwpFKARFt31ujjzJfdCK4wtGqKAQuEQV2aFp1fS?=
 =?us-ascii?Q?eXEw+6A/fYWZDgK1xKJtCLGgrPpB0sVHjj2rrXHA63RDmXkjAMkGXA5DQzCM?=
 =?us-ascii?Q?xr6eq9OrldfqGrYxhc/adJ046pEhc1yGUsoLChiUAGa5E0uy/QIkj+MGmjWZ?=
 =?us-ascii?Q?/1HaPVNo1nJggHN90/rrTzpeIHzfPZ1wtVjTNATIk0oJW1w9NZgZFPGpYV43?=
 =?us-ascii?Q?LpT0UB92jHX83fcPtDQ6cBIXruJYIsTAa63jx7RLcZq/1lrVSFizTEgD3DsC?=
 =?us-ascii?Q?ycRPqSdjinZi3PxJeqGluDGngrYGuP3iIkS2RBdt4F8PbTLgmIOAmHV7RxEd?=
 =?us-ascii?Q?XCe238F7Ij7s6yXVJihqZHhpFK7zyvL+vZMJNxX/I4nMo5MfPpVX+41+GE6s?=
 =?us-ascii?Q?txIS3psLCnj/AHvyraf9MB0cvNZKi79r+mN9K+1EFiP/ZNqAMc/lMMB6bvPp?=
 =?us-ascii?Q?zXbU8935i066L7yfmMt7g5R5QyF1iTBlYNQdnyfeMyAgK2hUjXApwuvlW2vc?=
 =?us-ascii?Q?Ep9zMMUt1ygWuZfFDVUmYrfp14ZO9a8mCtEEdXShHufQnHOyaxXZROnAS/00?=
 =?us-ascii?Q?5pOqlukBEJCUo8EhLhCFjT01J0eVCCn7AzNnHq+6ZBpOg/4m8TKbOYGXXo5P?=
 =?us-ascii?Q?bu9qRSYkUJyjdO1uyASOoXuPrtoAOGr4ceUmySN3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aaaf012-af93-429b-11db-08dc6be1209c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2024 02:23:04.0061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FfRnOZYuMavkwowwLcAa56ciMstkf4scAZ9FeEgdGVmHpRop3AYljvZaF+ya+S1mpxSJ3BjkMMm9mbJ5isXxVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9394

clang doesn't deal well with "-pie -static": it warns that -pie is an
unused option here. Changing to "-fPIE -static" solves this problem for
clang, while keeping the gcc results identical.

The problem is visible when building via:

    make LLVM=1 -C tools/testing/selftests

Again: gcc 13 produces identical binaries for all of these programs,
both before and after this commit (using "-pie"), and after (using
"-fPIE").

Also, the runtime results are the same for both clang and gcc builds.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/exec/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
index fb4472ddffd8..b7b54d442378 100644
--- a/tools/testing/selftests/exec/Makefile
+++ b/tools/testing/selftests/exec/Makefile
@@ -29,8 +29,8 @@ $(OUTPUT)/execveat.denatured: $(OUTPUT)/execveat
 	cp $< $@
 	chmod -x $@
 $(OUTPUT)/load_address_4096: load_address.c
-	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-z,max-page-size=0x1000 -pie -static $< -o $@
+	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-z,max-page-size=0x1000 -fPIE -static $< -o $@
 $(OUTPUT)/load_address_2097152: load_address.c
-	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-z,max-page-size=0x200000 -pie -static $< -o $@
+	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-z,max-page-size=0x200000 -fPIE -static $< -o $@
 $(OUTPUT)/load_address_16777216: load_address.c
-	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-z,max-page-size=0x1000000 -pie -static $< -o $@
+	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-z,max-page-size=0x1000000 -fPIE -static $< -o $@

base-commit: ddb4c3f25b7b95df3d6932db0b379d768a6ebdf7
prerequisite-patch-id: b901ece2a5b78503e2fb5480f20e304d36a0ea27
-- 
2.45.0


