Return-Path: <linux-kselftest+bounces-10746-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E748D0EEB
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 23:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 894881F21AB1
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 21:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9393A167D86;
	Mon, 27 May 2024 21:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YSEAxdJg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33ED1667FF;
	Mon, 27 May 2024 21:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716843678; cv=fail; b=BhJmFluRt70B/tsSSBOehxM/P+g98AkDlmM4TMaHm0LFhq4D1BHm/QljddnOsyIqhMYYGpXMeagRI7dxY4EC5Rx1+90OV3CpxFgRitIfgb/0kkLdagasvuUwX0uXSYY2S6P83eJUrMk3VEHLYu8osVTAJnbaYqVY40VcHY7yeS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716843678; c=relaxed/simple;
	bh=9vXO2O8P65102jHpZCmvZbsXezd5ETiqc9DbI3IYg7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WMu26shqEvAMAnlxkYpxvzJW/PGx7Q6CQ5CZEwPW273OniNUTOSL4FAgBQoSBQ23KEhzaf3OTCfhmFT+MbrLZtFA63H6D7vcDhtMOwoDoigCEivA3CkIAzhonGVoZXv/pxVb7h81N4pAGFNYuEn9CebFF5GxKoQ3LWzvJLMcKAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YSEAxdJg; arc=fail smtp.client-ip=40.107.223.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LIDevDuOA5mVzsrA1HwPAo1VCS1cHTEzlmWWLYSrJdXDegnjKjvxwD93gVjKVMy72nJJ3MVj4WDjEeLmPGH14qJ1Ov8mQM5LfQBO7JvRP/ZqIh4nfX8IyLNnTUw1/6iRAGzGQp+CvOsMGTQtt3X2Fc1IQV4ergjxAJjLafPQNflFNYPgu/gaia74cmzD39XZZfqP/oLWs0iB3KXDB0HLZoX6fka+d+xG1rZ+sVnHlF+UlgrNyBr9eav4nCLYoraOQC+U6zEAFBzaTf4tHyj4p67Ane3MtdxAut7wdRx4UQYvUdkT8TT3ZT/rQbfhhxoFa1QVe9hlae/3+5/mLcx1Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXxd3UDPrLIFQ0NXN7YcDKcV4htYWKypH3EpeO9mfUo=;
 b=GobRWtFqWeF9xLtZCcrp3uuTZTC0GKtgybTFxxWG3FC8mcScKgwQtmKnb0YW6guQOHcZpXApWOMNNt9CjtAL7UuegR6pbXU5NTo5RiUBZIs5wCPg7yLLW6wosTTzgl0prMoWmIxx0y7TWZtRSPDAssrbtqbqY674BK2GGAiKh1so1YASVME8/5K20vSEcZJZPA9FQnbLBA+3iqDVEj9el1iNxxY/ssnNPUt4AzyBQiDQAGsn9cekZBr9Z0/lcV2ArRgJAa2dVFFsOH/20LVcod51O69senrLoJwPHxUkphx1QwTFqLAj7idERGrKKlBFMcJZfqXIvdYi3NJgkUMmVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXxd3UDPrLIFQ0NXN7YcDKcV4htYWKypH3EpeO9mfUo=;
 b=YSEAxdJgvigIY42RzTKZO06oNsBnfpCSpchMAuj8gkmHMDpSj1EmNzmSit4G98DXvZwLJFyxHIbXHKhTRD3YXnggzWdrSPq2fgNySkKMFHG5iY6XvJXRWmgEYbn9MsoEAPip7265MFPUvTOqmdXXHFQ/78dZjBd8zcywW0c+++E+2uIhOVsFgzeouDG3akx1jXDaZEEqN+WXS47/MORKMaMBUVzWKUnYI9VImKxWX6olra31XxeT6dI09sSYPCLtqZlFGOZj1v8WdwS/7FrBDkSXsjgg2BUCnQBczKOhazYwuTRp+Z6ugvB/Ve4VBIJjUOkrxOeIVfLBoYwjHOwctg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BL3PR12MB6620.namprd12.prod.outlook.com (2603:10b6:208:38f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 21:01:08 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7611.030; Mon, 27 May 2024
 21:01:08 +0000
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
Subject: [PATCH v2 4/6] selftests/x86: avoid -no-pie warnings from clang during compilation
Date: Mon, 27 May 2024 14:00:40 -0700
Message-ID: <20240527210042.220315-5-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527210042.220315-1-jhubbard@nvidia.com>
References: <20240527210042.220315-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0025.namprd04.prod.outlook.com
 (2603:10b6:a03:40::38) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|BL3PR12MB6620:EE_
X-MS-Office365-Filtering-Correlation-Id: c1af2471-084f-4c0b-e9ba-08dc7e9021b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FDGz9Y83OqvgDW+he47fX/GhgZ4UbiOdWVnWApPI0EC+rivj43JyhH9Jy0y2?=
 =?us-ascii?Q?grr7HLOEdlZlG2GLY6BU/G8Zi8pV6GiL4cyaZG9ElT9wGA3kRr6gvoFvANn+?=
 =?us-ascii?Q?SRat2HTcZAMCrp2sc9k46sn27dLlsbAVSAcLQsvBHYRQGbQqGZVJ3bVrYCds?=
 =?us-ascii?Q?S9cR8F7W0dDLelsm/F+jCOi7e19YZU/YtbykKLWHPNAWgIrCUq2I18snP0gm?=
 =?us-ascii?Q?6xPd47uktjVoTs+mKKmpCzmQUg54IeMOMOJ3ZHF7sx0Dv4nWGnSC4rIXXiFN?=
 =?us-ascii?Q?EuyOPVQfPHoMfMR7YvxaM2DxOUje3Ejv3dX2WqZmOnH65rZfqgiqSK6/qfCC?=
 =?us-ascii?Q?HIhaliGczyQMVOWvkLkFlo5o1tJxgfQu2n0eJ4r/aHP/j1rACKGJTUkvJLxf?=
 =?us-ascii?Q?IHyeZsEGh86rWuyl5hSJSt7+ir+9JGCI8PYY5C275nRTdQGRUv0Rns3tu8Wv?=
 =?us-ascii?Q?0LNQOX0Ej8gv6izrS3q1D+xDhf1mMoeYl9baOB26k7VHy5TbQbTmvLaEwqI/?=
 =?us-ascii?Q?r3CVnNs9js1GlzArrwGJt5GLe8MtWobqGsRRfMq5eMVFTG+1clWixiUu5j5i?=
 =?us-ascii?Q?tH32C63GrvmrgN9MEL872X6Jo/MbaQkKiHxaxJ+LssZCFu5opBZsATumZ+9i?=
 =?us-ascii?Q?mJhPXb55FkaJgWfjzWMeUgeMHtAKeK8B5QvRQhSzWbLQOMFNq4PkkP9zxzTB?=
 =?us-ascii?Q?ebUbpfgi8rcHz7hWy9KhrhAZKHdoxWIylmVmjoF6eJum58WBC8EuOY9GFReb?=
 =?us-ascii?Q?eBcyRLVNj/XkF+utnFL0JeWetgsH2XEskyaWWK4nuVVVV0BFQOgdzWtqUH6J?=
 =?us-ascii?Q?RPyH7+mzxLKVMbJbWr9caqA4baC285wtYDgDWbBXUErSDW3OqYcIqfzSq5th?=
 =?us-ascii?Q?+HrkeO26oO1Iks1mf6xTEV2zGVNZkDw6vK9uZLh4bCaXl5TnRNg8xu2eYNY1?=
 =?us-ascii?Q?mwumIT/jlyU1Z0W21zPuaTKM/Ma3M/MizdCzierFdQxmcGDOrJkBfsIVBGcM?=
 =?us-ascii?Q?RLmrDI68fLIfGpwf4VLGZsvLgwMSxhZ3GRAVES0LHNcf7Xi2qU6mxR5upeXe?=
 =?us-ascii?Q?2iulIz7ORprNFDZ5wcSmf3C8Jrpcaqg45E0ZfEhKHOuU32Nuc8CRW0+qZIXL?=
 =?us-ascii?Q?bREniWBCiaY8dvIS5kyZzS9lo4qYXpLtuRKVdL120r6UDExBxDF62hoCBjsc?=
 =?us-ascii?Q?toYx+cBiCEeDcnocxqs/Xl+6iFHz4lZXbQ/qSTCeErLbvE9jx+TIt5WsqUSO?=
 =?us-ascii?Q?i2cCuEvn3bHm5NWlTXOKiFLK8rXM0aGeSMUWJuwXtA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?488qiQUBo5zrr+xA0IlwBfXhCmuPHgA1cWr3PcygaFAux5yoyoPJYPwsMUM2?=
 =?us-ascii?Q?O993mFeHL1aSaOXsBZkXkxV0a3m6opcty65aY6e6pNncxMCnkHLEEqzqU7ux?=
 =?us-ascii?Q?tkTTuRhkMeMmK2OQP2HDLexsCUt6PQX93FD6mdTrIEnAjoBi87LygWxKNPXw?=
 =?us-ascii?Q?JmGGIEgKI4hLZ9RE4YZQh/hfa9AR4Vv7ngtXitDMFIjZ5LIPNSPIjZh4B13T?=
 =?us-ascii?Q?nCE0lSTq47eHJWUT9wWmgQ9+6coQ/GaYMVBq8qXyX/6BZ2ohM8QuAlGNvwxM?=
 =?us-ascii?Q?W4Xuru6JUXBj2u5Sv/rNE5Sxhi0L6KUQ+ApKruxvavEFO8vfQ0cRPEDG2SeZ?=
 =?us-ascii?Q?C3vz0ZuuJk8uXH/X7L//2lvIYUouiCiXxvT3DBAJcIDvvanlwUcqXEQssubg?=
 =?us-ascii?Q?22TTuIaP5M2oKdFdsHwBoz1JPmzI9uk9wCMh2X4Gcydvns2Vp6ZJsoqlewL3?=
 =?us-ascii?Q?yAKaXkdyvFEIxztzbhyOpNjEjHuZ6uhCgFlY8kXscqbleRkDp83F5LQUQQjI?=
 =?us-ascii?Q?to/uGVggMpWu1FkJ+MRRLIsXT81rItGUJiMWwFerWv0+thwAqKNE2IpujG+H?=
 =?us-ascii?Q?P73sZ/TyjI3sCYFGYImNYF2qAJxR8rL6BtomYThcLdpPDs7IqvajTJqObFtL?=
 =?us-ascii?Q?N2y2baIcP1qnIMjsl+oTl8tvVAkdrKS/1WlueGXzebNNPtM9Kl6s7iNRzObo?=
 =?us-ascii?Q?6YI5h1/JcSi6El4Hyd8qvwMylGG8iGyqT3GETvS2Zhi59pzBBblazoHQXpr5?=
 =?us-ascii?Q?o4djVsJhVmE+HuM9Lm9ICOrmuW8ldRLXcw4w8zIHkAFDJ3eWXbw04ewfzxLn?=
 =?us-ascii?Q?u1U/O2o/HhnvxmVEHfZ4uZlTT4RTc7bYm3fTB6nqI5AaKi7FhXaMlJo19phX?=
 =?us-ascii?Q?Tlj0zqmWCBwfBK0lZDmOIOuLKumR4OsMtn9mMgje5mm5mJLDG1RvYeSOsKJ9?=
 =?us-ascii?Q?sRbKVmublX2pUkBBuKSuaEoEYTDktoLlz6EcfNIhOEEWUm3JEM9VJH6liXvK?=
 =?us-ascii?Q?ijOXKRPFg8ZIHloQNTjAmmX2m4D345dQ8hBW0PzL7qYOQ45ZiAUDzmyJAVd3?=
 =?us-ascii?Q?RrrppWLLKMvrzzS9hL/4u7V5M0lD202/rvrLLAmJSfwDU2ArDF1q66HPnQLx?=
 =?us-ascii?Q?fgfMCMOU5c3Me/rFa1YAo0GA0R5lh5Doe99xGw4UUGHKq8GXMWLaYN4qeodU?=
 =?us-ascii?Q?kpMqIQPAbAycHMetuQZTEip72ing2i/tMCS9LwrmR7SeAZ8LvoNsSq4ei3kk?=
 =?us-ascii?Q?4H1euxFZ8LQ6LlMSVRjz7UZXLFnzUqwMxS/obzRttH9IDqvCnV0sgbtuXcXa?=
 =?us-ascii?Q?Rby8ownInKUDGMYHOWzreR0Ljkga8tk9RHAzqSANKuMwxejssrCcWGRicogU?=
 =?us-ascii?Q?WaEyFDRgv5bxkxcqOcx3woqQSJhdXr1GH+BIBVViP5h50Ha4jrc+lF+zIi5V?=
 =?us-ascii?Q?BHeUThQBiBdAyWAQ4lNb8yZtYtXwgM2apgfbX75AAa+FmIoyWb022pKAEI8Q?=
 =?us-ascii?Q?e1R/SBikHmwWHT/IW457bsKHC9+ReUGR2APWYT7qP922L5dmwWAxWKsWHObo?=
 =?us-ascii?Q?eLIJDhdF987+3d5yUR6q71vvbdkTcFiHQAsooDVHUGitFnbPEb/GsIUy8PWV?=
 =?us-ascii?Q?Eg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1af2471-084f-4c0b-e9ba-08dc7e9021b0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 21:01:08.5947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w2kJJH2Fdy5qpp/VxuN1F+nr0scY/b9DFqV0fqQwzaXvxptI9T7vvdbx5+VULi2Z+E3x07apNbmPNEPxpwyyEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6620

First of all, in order to build with clang at all, one must first apply
Valentin Obst's build fix for LLVM [1]. Once that is done, then when
building with clang, via:

    make LLVM=1 -C tools/testing/selftests

...clang warns that -no-pie is "unused during compilation".

This occurs because clang only wants to see -no-pie during linking.
Here, we don't have a separate linking stage, so a compiler warning is
unavoidable without (wastefully) restructuring the Makefile.

Avoid the warning by simply disabling that warning, for clang builds.

[1] https://lore.kernel.org/all/20240329-selftests-libmk-llvm-rfc-v1-1-2f9ed7d1c49f@valentinobst.de/

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/x86/Makefile | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index d0bb32bd5538..5c8757a25998 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -40,6 +40,13 @@ CFLAGS := -O2 -g -std=gnu99 -pthread -Wall $(KHDR_INCLUDES)
 # call32_from_64 in thunks.S uses absolute addresses.
 ifeq ($(CAN_BUILD_WITH_NOPIE),1)
 CFLAGS += -no-pie
+
+ifneq ($(LLVM),)
+# clang only wants to see -no-pie during linking. Here, we don't have a separate
+# linking stage, so a compiler warning is unavoidable without (wastefully)
+# restructuring the Makefile. Avoid this by simply disabling that warning.
+CFLAGS += -Wno-unused-command-line-argument
+endif
 endif
 
 define gen-target-rule-32
-- 
2.45.1


