Return-Path: <linux-kselftest+bounces-10744-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D48A88D0EE7
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 23:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D9021C212A7
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 21:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0524B1667C3;
	Mon, 27 May 2024 21:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fMUG4x+P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B38016132F;
	Mon, 27 May 2024 21:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716843674; cv=fail; b=sQS+6/kxNhMi75+Swgt2rt+ze3Woi3y0NaxjtNdJJP+47kTYDrLxVRxmNytLwO1fuaJ5ZuBOoJr/owI1Djr7Sxx9DvamkgMcc5L4vK7LMQZt++AuEInLZ0BBE/9YIdnnj8SVU9eFX/D7BVl+VNLoryle5fbjFIo0powGzZZ+vCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716843674; c=relaxed/simple;
	bh=z5voJfi7a3PhbCCNXPEPmo1CBZBDZe8GBFDWfB85VVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VWEeKYowd1TKL4CgB4khZWctS6Z0fG+YtN3aE501vPSyJajpNPnSFMwQnqFPghI9tbsOHVTcA1AdRFP/gyztUFy/urG+fD5qZ2anTYfpxpuu4lflbepH3pKfwLKcn2pn1HpM52Rweck9374lX+OSOFfMrQzPK08xsmLO7MbmaGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fMUG4x+P; arc=fail smtp.client-ip=40.107.223.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TkRWCGXZKIE3xFJvYD4i+0LvCSUlnDm+NHCpl2w4+2csVBdLJD9aJsP9F2BW4fOO4ic7VMya9+jt4K4hMDl855rAV8akfOnsUxggRxDsckd6bLOcqC7Du9xNNIv1KgL8q3cpvvkexhhE/kNoIFHzeQJ4OLsPVhZirCrCjCxWDWr5unfqJ1frypQX30obl9w6PqPQlvJ1SGvN8LHLvHN2eTbnmoNw/qdBBa3EGLUBHQ3PEr3O3E0PCF+1E6JOtVD7iIHdegYDiv5SimafYYmK/rYX8GBKbjdaVDtLPA3jhkICvRAg1peE5aK0ARUU80sVAXCm6mX1h0QFSdINg5TS0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rB0oAED9EaadsAW2/z4emTVYa+TrZ0to8ZFumYgF+ws=;
 b=K1V0PtCUB7XRpQbs0+v8LxR1ysMJmR54e9TcB/xKEjmuitqrYAOzriweK/ZLEPqZTH8ue0v55ZeiYUSbURGill8Q/xLxk7otOcrRGRAw3SDQpMaRiH1HtXpxkVzCvorv9OaGqUyKWlVEDDckSLhonE59+XjldxePqDB98wN0ONbwQejATe/wo3P6//Wek9ZqA+CTXAubfNm2tMqM9MTrWXrOuBu8VPcMRuvPNVVl0NwSy76fh0F+nb/xeVVg2abS6tHjpPXAGGHrI9S6sJkoQPL0yp8CzV4+ZG9KQ3lYV31HF2zr/WpwrtD1bTpeaDx6zTQD1a9M5YYLRp1rrWnLqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rB0oAED9EaadsAW2/z4emTVYa+TrZ0to8ZFumYgF+ws=;
 b=fMUG4x+PxEMNYl0fEuC85cUYNPI/ktKGTMac/IwirdWYJMV6PyvYl5hKtJratUzYCCq2ewrDRneCOQZGaOzpnKdGHFoY08zpHenKksn/5biqucd8qnFPFNz40lVr9xbGBuJHL3mf+sgwFhpQYYO/3+6ShIL1et4aiiWq0tbynARvnZpswPsFumN9pt6VmYGfLpGPw+nDpwVaqbooy35VIWl2ePgDSM/8y303/8NMBDtdJ3/NtqfbJnXgDXHuPbRbTR1qF6QJ3mGKXX05sNFRKjzY81VBCKlAMN/SOFCHZZ3uVhRITnsMp6wevJVPFgxP4XqgPHw9FqAxyXwgYrOrWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BL3PR12MB6620.namprd12.prod.outlook.com (2603:10b6:208:38f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 21:01:07 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7611.030; Mon, 27 May 2024
 21:01:07 +0000
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
Subject: [PATCH v2 2/6] selftests/x86: build fsgsbase_restore.c with clang
Date: Mon, 27 May 2024 14:00:38 -0700
Message-ID: <20240527210042.220315-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527210042.220315-1-jhubbard@nvidia.com>
References: <20240527210042.220315-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0380.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::25) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|BL3PR12MB6620:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e3fa4da-1e66-4a99-6887-08dc7e9020d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5kPsmIBtaMaFaCTnspPDWrIm5TVfln31ZTo3Ug0PaLtcl3H/P+y9/tBHBbpF?=
 =?us-ascii?Q?4/F77f4QG3WY/fDGl2/aMTVAnWcEoFqMlPEhI2HCEh05Ey6aN7Cmf7A6frhn?=
 =?us-ascii?Q?PYukM7nDFnWW9oozujIzXFNm7ENhiTLo7URlvkunNPc5XFnWO8y/OtpOO6V8?=
 =?us-ascii?Q?rAFj4sEfNHqY/ZDdvXfkyTJ6xa2rr2oZdhHyJlmdhsgJcE/DXxfs1cweIk2R?=
 =?us-ascii?Q?dXgtCrRl8m5fMSqeK3LbmmjgT3ZjqjTjbPJyBkr/VRa5Px0GFlQu5+iWH+7O?=
 =?us-ascii?Q?J+EM05DAoyjiO7CvuYYrzgikL8qINwrkUeoRxS9/LrexiDe68KL+qx5lNJGE?=
 =?us-ascii?Q?YwIkAJHBewnQu1ZxEerSMAVq/kryfpgfUj0ikbnMwFw5apUKlgnSuKh6Ho4E?=
 =?us-ascii?Q?L3A9vJNt1UL5qCW3xyO2gf6+hgGobBlhAr1ss/rUpWrXDSEwHMLnFFZAg9Bl?=
 =?us-ascii?Q?qdgyMLJwlbD0CtetKpglbOftQK0jOh3AMuhBqPtY9N+Gs9jjUwsS0f7YLdwL?=
 =?us-ascii?Q?dR0Htma3KMgXk4djiTlnDocCCi7zuHH6/scSq9rQz+vblGzluiadlNt60XTS?=
 =?us-ascii?Q?90wQWjhp0SeZca6cy4j7nG2VJ4UB5m8ELagIAZG5A32+HxxM53fOXqSMhpXv?=
 =?us-ascii?Q?hesekAYE2CJbUhHUHxXWrEREgMgCfZ94V0ijwJ9WY08gCbRTRYrTmnHGRAgb?=
 =?us-ascii?Q?38St5vZR8d/X9O8+HRynBRtmxoarhIRyuvcCTU2Rh0KhYWzQAbsk4J7l6ejz?=
 =?us-ascii?Q?Jm1H74lHCEi2b7+IGHq/VAQg1J82gX3H6YBvaYzHNMEWZuwFaILINEijHicM?=
 =?us-ascii?Q?6fnVu7Wd3U6YOl/ywtSO28XZ7TGmQBI/kC+I3HEVBdCSEz5621Me+dZO5Gwi?=
 =?us-ascii?Q?UiKoCKs/ShzTIOeMi8iVMWxHCKVNjylUnVxgZYZlE7pP7UoNFGbLTDoNZjM0?=
 =?us-ascii?Q?r+1Eyzn9xaECQJAEo6QjHtXwTvL9p6GcyivrcKw5wNwa4AVw+n/099BRso6m?=
 =?us-ascii?Q?G+Kov6uLuyWx8jJX7KUvfDWVgTVKaTAtQuLs80iduohI1VU3TOYHJdV9+h9x?=
 =?us-ascii?Q?qSwwpYT+SzoPPvMIdQ44AQWM57+WmqBNi8qQrqPYOuPvA0uG6Kz7jVd5IL+z?=
 =?us-ascii?Q?svp495M9evPXQHuPiULlXdXGI8A58yB+x6QSx/ANQtqks+8bYP9tXIqUC2TN?=
 =?us-ascii?Q?kovkFqX2WQhX/+4JHjc+VpJy4rPweMZEdXtWNgul7NVmqNwThDP+sIXOuqOw?=
 =?us-ascii?Q?iKTb/1l5/qARqKv4S7mn5iiMwYp+EEsf9icJdxb7Og=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JnU2qd/t7Siq2LA8k7hAUGpdSN62hpG+XWr3e8B1QNCR3nN9foMcyURV6qoO?=
 =?us-ascii?Q?DYyTuWifJsL+w7Bf21YIGKcMB4TAa+vkR9blV8OFaftVvLORFd/TQTKu42CB?=
 =?us-ascii?Q?YLeO2A4gRiKBY7WXNFazcddsTxZFMu8lTHmIbczZXINPziF/ZBP56hgqc+7S?=
 =?us-ascii?Q?F90mwbCKiKkaLxt0AyUS49lxhSGCHZ5Q8cE4bHy/7b0JGO5pXqiyt16sp7zS?=
 =?us-ascii?Q?jFTZDL76A/z1rnj6lDA1mnNnCTjD+B5EFJme8zlUEByQnb/StzVdAyXvqT5f?=
 =?us-ascii?Q?2/CpiuA8bJwTKfoyLqEJEquTmj1wi0Qoabc3FnSYTRJcn6QwSXDd87I9QWS8?=
 =?us-ascii?Q?uUFGPSJfrDrDWufijtbv6sNO6O4PlD+NrSn5wgzAOKekgr5Brc1QMqeLOaPf?=
 =?us-ascii?Q?Fqbf32Ji0JEzgVuOHh+kWrvHu1sTcruve/TtgH5JLarNIv1EZ/h92leEdQmd?=
 =?us-ascii?Q?vaqyEEF1B9TD5VV5bQpi+ujRWzf48bRpunMgTMvaqYLR87myVe+9P9P6NpPh?=
 =?us-ascii?Q?RqLNuTKbBkHGh0W5WCCSJEVPxviqqJyTpY4DEe4bPOZaFTjrtLkrOWv8zr2T?=
 =?us-ascii?Q?dcMk11iCIpWEIMEBm3VyC1FPTB4r4G9WYkkDbbne21C1i6pdSEd0l0H4uvIn?=
 =?us-ascii?Q?EDFZJU41nbeQUDkdop+MUSIvVrOznZxxzB1HVd5MS9ThqGg+9krBREed9xTe?=
 =?us-ascii?Q?XgO0Tl9nc584NSTKTWVCenycQFxi255rEFAIl5j2oaXu0zrJ9i72q94uCJ0C?=
 =?us-ascii?Q?VNpGF5PyzvnGRxvOdmBwy2sf+jJ83EL0PvTHGNNKUmJaShA04HoWrl+d2018?=
 =?us-ascii?Q?fPHO9g/+koIhe3lnWMxRLZzDHtU1chmED1C7V88R3W/j/14eUuTUWWoLWHtk?=
 =?us-ascii?Q?27Cp2B237G6J9Ed6Szg67DouDg9+2x4qoXO0HivgdDRbwm5IvLmN5rMM9nk6?=
 =?us-ascii?Q?V3gqN/zZKBYqlU3VYHBGf7Wi/HberTAON+DYtbdbVpG/iLV1VjHh9zWUC8y2?=
 =?us-ascii?Q?wCY71zY2YgX1T8ro2aF3Q/SAyGwZJwb6WN1GZbNeKNpthphJerp+7K6JiTDS?=
 =?us-ascii?Q?88fepL1Ygl8yOsq96R4Y9FxFgeytd/1AF+COznUDET7Gp4FtibZ6KIUj7tB1?=
 =?us-ascii?Q?TmVfTkiQ3NJnyhzX6kN45jRKZbsJZ4VMrI9Kd0lREycIwCmlQErIN9cTq5N7?=
 =?us-ascii?Q?fSFO6crWE8Sn4TZkWqyiLYIhYsZHd4ArmSjJ/dp+E1BXAwIzWuSV+P3D83tJ?=
 =?us-ascii?Q?Nj9I4377c8z3zBgITPKUu0CMZaKG2ru0NeeNWwWZR1/3T0KCIqYiHW5OSlvh?=
 =?us-ascii?Q?pJ5eGC/HX1etdhRu2tJn1yb93iivX9F0OJ1GvwiU6RORgbLOsihoTbV3wUD8?=
 =?us-ascii?Q?MuOE2oReoYMmfwtyfnHqy2W9E4PSeODMFAzJ5zVICLaRmmbOf32yVCwnRtc7?=
 =?us-ascii?Q?T+mg4vB4tlHNX5yPZEXTcaxHX0v54NtqhLa6Ju+bwb+RLIaAAqoUaqNpOVq5?=
 =?us-ascii?Q?8FU9Z05Oz55XxXNUXqfqfL7uZ8C0PkHK8TyyQ3d97WZMGO5QDPktPRgAUqb6?=
 =?us-ascii?Q?Old1oxC9xGikqzNql4yHUu9e5AbR0Up0AZNHof7wjWgQEkQfpHyODMDDwlHt?=
 =?us-ascii?Q?nA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e3fa4da-1e66-4a99-6887-08dc7e9020d1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 21:01:07.1438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L2dptyZTpLprx3zP2QZuGufdjipxImzDv6yYLj53VieYoNXsfEweouiTRgH9eI4hE6q/MJZ068ukvMWWVciz+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6620

First of all, in order to build with clang at all, one must first apply
Valentin Obst's build fix for LLVM [1]. Once that is done, then when
building with clang, via:

    make LLVM=1 -C tools/testing/selftests

Fix this by moving the inline asm to "pure" assembly, in two new files:
clang_helpers_32.S, clang_helpers_64.S.

As a bonus, the pure asm avoids the need for ifdefs, and is now very
simple and easy on the eyes.

[1] https://lore.kernel.org/all/20240329-selftests-libmk-llvm-rfc-v1-1-2f9ed7d1c49f@valentinobst.de/

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/x86/Makefile           |  2 ++
 tools/testing/selftests/x86/clang_helpers_32.S | 11 +++++++++++
 tools/testing/selftests/x86/clang_helpers_64.S | 12 ++++++++++++
 tools/testing/selftests/x86/fsgsbase_restore.c | 11 +++++------
 4 files changed, 30 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/x86/clang_helpers_32.S
 create mode 100644 tools/testing/selftests/x86/clang_helpers_64.S

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index c1269466e0f8..99bc2ef84f5a 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -113,6 +113,8 @@ endef
 $(eval $(call extra-files,sysret_ss_attrs_64,thunks.S))
 $(eval $(call extra-files,ptrace_syscall_32,raw_syscall_helper_32.S))
 $(eval $(call extra-files,test_syscall_vdso_32,thunks_32.S))
+$(eval $(call extra-files,fsgsbase_restore_64,clang_helpers_64.S))
+$(eval $(call extra-files,fsgsbase_restore_32,clang_helpers_32.S))
 
 # check_initial_reg_state is special: it needs a custom entry, and it
 # needs to be static so that its interpreter doesn't destroy its initial
diff --git a/tools/testing/selftests/x86/clang_helpers_32.S b/tools/testing/selftests/x86/clang_helpers_32.S
new file mode 100644
index 000000000000..dc16271bac70
--- /dev/null
+++ b/tools/testing/selftests/x86/clang_helpers_32.S
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * 32-bit assembly helpers for asm operations that lack support in both gcc and
+ * clang. For example, clang asm does not support segment prefixes.
+ */
+.global dereference_seg_base
+dereference_seg_base:
+	mov %fs:(0), %eax
+	ret
+
+.section .note.GNU-stack,"",%progbits
diff --git a/tools/testing/selftests/x86/clang_helpers_64.S b/tools/testing/selftests/x86/clang_helpers_64.S
new file mode 100644
index 000000000000..0d81c71cad97
--- /dev/null
+++ b/tools/testing/selftests/x86/clang_helpers_64.S
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * 64-bit assembly helpers for asm operations that lack support in both gcc and
+ * clang. For example, clang asm does not support segment prefixes.
+ */
+.global dereference_seg_base
+
+dereference_seg_base:
+	mov %gs:(0), %rax
+	ret
+
+.section .note.GNU-stack,"",%progbits
diff --git a/tools/testing/selftests/x86/fsgsbase_restore.c b/tools/testing/selftests/x86/fsgsbase_restore.c
index 6fffadc51579..224058c1e4b2 100644
--- a/tools/testing/selftests/x86/fsgsbase_restore.c
+++ b/tools/testing/selftests/x86/fsgsbase_restore.c
@@ -39,12 +39,11 @@
 # define SEG "%fs"
 #endif
 
-static unsigned int dereference_seg_base(void)
-{
-	int ret;
-	asm volatile ("mov %" SEG ":(0), %0" : "=rm" (ret));
-	return ret;
-}
+/*
+ * Defined in clang_helpers_[32|64].S, because unlike gcc, clang inline asm does
+ * not support segmentation prefixes.
+ */
+unsigned int dereference_seg_base(void);
 
 static void init_seg(void)
 {
-- 
2.45.1


