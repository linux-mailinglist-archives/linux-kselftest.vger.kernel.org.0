Return-Path: <linux-kselftest+bounces-9315-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B16B8BA586
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 05:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B6661C226E1
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 03:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5C7537E7;
	Fri,  3 May 2024 03:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZYe0C4ik"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ACD2E620;
	Fri,  3 May 2024 03:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714705356; cv=fail; b=kJ/cywSEUHxgUonADyLN5JchSA2QU6gAD5++Gs/aKlzIZ3N3vEPvIbv2i66I4Ts/n41ebBN18YNpLa9YUwfp8BIhky/tu4Wpz5KfeBk1XzcORJnPghaMfxchS/rwSU5ZMQGyT4inUXPBpVDAt+lHJh63Hg+adqAO/gkQ1gJ2fgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714705356; c=relaxed/simple;
	bh=qixLcQ/9RwBg4QrHTHtOrHckZ7Ks1zlFyaakKsb9xV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kxWZdQFFEZKLcMOrbIe8hdov3ftZZKASjlpC9aYcRxvojtobxlWwbcPqbgfK7m1sjKXGeIaWnWEqJzBWs4ysl+LmKErVws/ClRfLemps0LGqfOKPyrfDTBoUENBZ5tvdZLQGns3rXj6p9LSrLfDfFj0kqym5oStRzMZBlaCdnSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZYe0C4ik; arc=fail smtp.client-ip=40.107.236.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6XPbUv+59m/bQyzKk9Hdu+QeqDQW1hFtzhrxnjf2sUbHcfFk2B7pm47wOggGx3hamYVQYyHV3OIFj6Hn+LtHEUjBRND7u4MYQcUDFvaGWgIEeMzkBaEOEmDW3qwROvoZs4qm8slec4c7ZqAtbLSdLp4yitfcV8M+5CkNVnTmitFtXokE8GcN9a27AglFsaKNgHwVCLdJZvM+F8el/My6tGu7mLW9MNgs/TLOchv1oA405VxZgm1Hgf741UFs5nv13G/EERC3AGBxKV0+IM6stiAZNlL2X9htrJTfUR5NCTgV2Pwlt1MAPnJ5kYFs33SWWqsSDJquEXxqyd50GDlBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YUgnb09vIQr3fcTeQGm5T6f7+6e3hOEfWyZnMw+AQ7g=;
 b=HbwjcpZw44BkE3Rpo3zlrz/azPiyZD5FmrSG7WJiGvRZaak58Qz8NYMEMtE1ihB79hZtZnv9QlwhwW5Ejzv9lNV4wb6vWyoVoKkuu8wODnYMre8sPgIi5W6JEto9Mj2zhpBzPqRXwcZYrGvMASqT9lhGzqTxWPc70Q3IZ0iyeU5n9i+jRranjPdxxCdeJ5xoAObPXRaYOgJcneGkxMpSXJCuB0aSR+9tZVzqOIxoiJ/y+BUyJ+2E/RPRJmao02zFu114ymK4w3INolahl1DtZwPxeMKzS3uJt5RDqrUUuRolupzWoUSRaHY08N7fcDanqG7pa853NvFq0MDyLzKCsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUgnb09vIQr3fcTeQGm5T6f7+6e3hOEfWyZnMw+AQ7g=;
 b=ZYe0C4ikpGgPuCCK13p6kygRaKoF6E9xDX8dIlqOW3P7MOksXnuZ79/ofrv57JevD0f63JbBIlztk65xXtSk8QzkvrRyedqaFGAwrovV5ps6fEXgNfwi0bX+GH6g1LGHQKu/7bpBSxzaFKa6YO7KN1NjEujJZp59Wcm08SsTVFYeDfJpqojIg2n8APpiAQFYuQon+ky5eUFusQSbxqxEP4vCjCFZl0X6ZgUqsUZbHnariPFsC2+oPSOeLXcPOBKMBjiVcz/dKVB5thgzSXkNVRHTA9M6QvuUkxZ67uj5Z85Irx7gm+nMimf8RO/uuomp7o3W0gC0A5fDWLATJL10pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by LV8PR12MB9109.namprd12.prod.outlook.com (2603:10b6:408:18a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Fri, 3 May
 2024 03:02:23 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7519.035; Fri, 3 May 2024
 03:02:20 +0000
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
Subject: [PATCH 6/7] selftests/x86: remove (or use) unused variables and functions
Date: Thu,  2 May 2024 20:02:13 -0700
Message-ID: <20240503030214.86681-7-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240503030214.86681-1-jhubbard@nvidia.com>
References: <20240503030214.86681-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0062.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::7) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|LV8PR12MB9109:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d287a72-affe-4a7b-c688-08dc6b1d72d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lnatlGNJfk9w6koRYePH5NZGgB2ZdgfTkLnVb/Ti6Wb3UA371nkFECbeM5MU?=
 =?us-ascii?Q?rv7iJKzdiLFkx1SBMZ+JytMlUYIndOBldW7+wetzirKsyj3MZ/GFu6GRES9r?=
 =?us-ascii?Q?ymvxQn7pY4zG7wOVc5FglGGWbmQDA4J9wldSI7HCBZziFXjnBINqMrdp/iCs?=
 =?us-ascii?Q?TLjLVDQhyuytnECKSvJ0umHh9CWVBWpmm/QZ43XK1Ybw9+4/w7Ajity0Zyjr?=
 =?us-ascii?Q?t1FERoeeDGmiZLMzDAcEVVZgIlcbqF+Vhx64NZ1XK8iUwu8MI5vGj97frWuW?=
 =?us-ascii?Q?AzgvS0W72KsnHSBUWwVykoPw2Hss5n9L2gLioo6L0Wn5RRTTV662H+ML0Owv?=
 =?us-ascii?Q?Qz1JjA0fUl6PTViR6ulWipsObq3jAgogH0kcqryv+RCSCCGEqBzRVTjbijns?=
 =?us-ascii?Q?/i1ALSs3ke3Of2ER6CA3dKEZXFitzNRSsx9q3cKy9rdu3Ewgp/a4N/dNNatq?=
 =?us-ascii?Q?Blq6rptxeJ9phE65heX4vhkO3iPfFjT10kNEN3GHiUXHtMVa/JlJP03vuz5X?=
 =?us-ascii?Q?blx53v9UxS7cx9gk41JiG0IPHyxYPSaePpwOGw0inXFn+Fn4EzuP3avzSZnl?=
 =?us-ascii?Q?Gha941s3weuUTmChOTdd2eJjJjqLLsxqomWIl62Kmdis+aE54ZEb3VOq0BT2?=
 =?us-ascii?Q?/58yYXlCkAr89NJmHKZ5vAnsj4xUF+lWamXri8c66kldjBJ6taLZr3fCL6mE?=
 =?us-ascii?Q?KOSpnjmDkBA/dpEQL06Cs/i6J3fe0Ou3CWJe5J6C7Cz7FArGTHSPDjwNZAkd?=
 =?us-ascii?Q?PoyBtxUCtHlsPhROHpuMw4deIhxxWyaCcspfz3ji4MqLnyy5CmZBOmaRn08S?=
 =?us-ascii?Q?lKe4nul1AhCLYFIJlQIgS1uTB83Txhrv+sZrQ8SEFwSlJM617GqPJIm96X7Z?=
 =?us-ascii?Q?I1sg2XFMjwnVDDGkF5FB0eQW2rUDmIx7Qt8h60m7eVElDR2ZzNYJEWh3uzKP?=
 =?us-ascii?Q?ArxhJg4rwpepxMhQJZNEndbmfjm9tOz+gJ3ZtCuwXjVZKyPnJ9XpOYJSxvJg?=
 =?us-ascii?Q?k093vqV4UMEp5QaPnnWkHJIfEg7RrdFCCrZumntHZfIkJPSqDCjCL8H/dlZy?=
 =?us-ascii?Q?64tf3LzBOKFOSG9PxGrp4pIMItfVV+9BdsmmzhYeo9X2AuCpS7MSHVgSzE+9?=
 =?us-ascii?Q?a3q7osl9LPUnCd9Z3hQRQK2uICzQ0PLzWPclxJs7MvHj8tZTxpxP2GF8nb1T?=
 =?us-ascii?Q?tkAiQfeT4G4IYB9tLlkQKbjZt/tII4HjQfRPLCbAdUAl02lvDo3/NjlZVWPD?=
 =?us-ascii?Q?xU7yAVE2Eb3+RcX0c8xUtlrGciRXT1s0vUKBe7c6qg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LjFBaQ+hn95mU9QZ9PflgOqxsaeC0W2tTMfx2fmHhrob4pqto0Zn9Mu5udo+?=
 =?us-ascii?Q?r31fF2UnTZsveaIzJvyq53nj2xSwuIyNcRnIsk6gAhcjuKXoRXajkd2qgJ3z?=
 =?us-ascii?Q?5PXU/bD+Gw+fCFvppCdOx9Rlhdv9goiB6bV8RtDsT+e7oRUy8aFl6qDlByzN?=
 =?us-ascii?Q?4ts7VMV7KQJhqRyICCPpKDU3Sh/m0JRfaDopdY7p4JAU8kGyKZQuhgcWNoK7?=
 =?us-ascii?Q?QjUK+kczn1N4LvM1tWa1aKP71k6ghlOT+36GxRy+aIZJ30zB8m8KibEI3RO+?=
 =?us-ascii?Q?L2Mx5w0zMGnhQp8b/aBuwEAEg6igWsbaZHBodyAveTTIMXyGl2oJg9+OBoxK?=
 =?us-ascii?Q?1lKnseD90bFgxsamZ16AKWCP+ix6CsmTXwXlnSsfANUJW61bBzaENZLNcFyO?=
 =?us-ascii?Q?QNc4dQNK3HCiBzQ6QDEJf0b/fQG515s7cdLY3nwJAq1Z/Ppwvbp+bYVl7uPw?=
 =?us-ascii?Q?1tAufI/VfbpVnanHouUMN0Z0Dkqdzv/o5MUntWbgePDvFw2pwjdA8DeiEwXg?=
 =?us-ascii?Q?9Luval6BwmzvQI4qBXSPHkc2fegOIqWcPQqfZGmpo5QY+fiJY1XRF2bQDNCf?=
 =?us-ascii?Q?ST4GN/NOG+EJYKA/Muf7Rw0YnZfJRyeUx05VndE6upIdf2e+Xdf4agJyBw6N?=
 =?us-ascii?Q?GlqNB20imbceHfe1Dh8Yl9jHPr9bTZPyZhsEEsjLW9kfBUdCy6kSobXiX+vW?=
 =?us-ascii?Q?sWWm5fOBcJl1J7/zzMkctF/ezC5b8HxHx+kQnIHoGk3w0oLp6+an/NVP+Z5x?=
 =?us-ascii?Q?Aopk2h7TySGnDpyuYZauDVw/nssBAHjZdspmQmiPaXiw7qIahhlWRkxJgHup?=
 =?us-ascii?Q?4QhKGPOoYJZ7LT2K6nyX+m4uOiz5IZWTn9vGhByMhMT9212RgTlOSClflJqP?=
 =?us-ascii?Q?MKAwrML0+2cjYGUntziFgp2hMGkewkl0J28M4VO0pcTOB422bmACdJ6hBx1b?=
 =?us-ascii?Q?ZGR/tabf92gsXxV2On7fHRHYokKur9s7v2xXuUpgWIzGzS23DqCbO5L5HfIT?=
 =?us-ascii?Q?jmaulvHxm/7X5keVeWHi+0TJhbR8b5huJoTvz6524nRgrxz7+33o+BU+m4b3?=
 =?us-ascii?Q?XYmc+b8vGY0W3U+OtrAkyvcTOUTRnpkstYCVUMrFVGMyjMgZJO6U7q/rzXMT?=
 =?us-ascii?Q?4NPm5FIqDkt5DwJhv5TAnxr8BxspBqF0z6j3hmCm086D/gS+QwWepfxWmf9t?=
 =?us-ascii?Q?2lyt9AaJJhd/ypCuWZxNY/C0mrnBJzKMJfgu5ExsfJMwKAwEPP1xepX9GITg?=
 =?us-ascii?Q?dSgUb8oWrG5R+MIm6I72J944FEjZoklQ46eGH6jjj4Ej4EU29SmIJtVA738e?=
 =?us-ascii?Q?k+PMuIG9E7OMpF4p90+abADJ0wm37o174pXMdyRtxQH2EVERKoUH9t/OG7Hd?=
 =?us-ascii?Q?Ry/h2dIk+QpPE9pB1MLomLn0A9of4DLZQQ5yG9z4LNjePAN3+j0HAMQQE9hd?=
 =?us-ascii?Q?qyD/qPJXu6XnBHu77UVgoZ/kFdxOnfk0Ogy7r3NIOfUWyNl9zvDlCc/EiihR?=
 =?us-ascii?Q?36adxkf1692JucivNhbT7mJ8C8mTxuj/7EEZbJS7KQiSwxaepbneh0f9m8eO?=
 =?us-ascii?Q?MwWo07ybRHqiyz4Ge+AP1XYECu4+ZTFO1rdvk0Re?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d287a72-affe-4a7b-c688-08dc6b1d72d3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 03:02:20.5341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i0GVUYpEQyxtl6MXXkBvCSMXyedkL5NiCttR+UlvO+1H9k+Q8hrHWmoF0j04FukFnNHVd6p3Fu7pYSDSz/kgHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9109

First of all, in order to build with clang at all, one must first apply
Valentin Obst's build fix for LLVM [1]. Once that is done, then when
building with clang, via:

    make LLVM=1 -C tools/testing/selftests

...quite a few functions are variables are generating "unused" warnings.
Fix the warnings by deleting the unused items.

One item, the "nerrs" variable in vsdo_restorer.c's main(), is unused
but probably wants to be returned from main(), as a non-zero result.
That result is also unused right now, so another option would be to
delete it entirely, but this way, main() also gets fixed. It was missing
a return value.

[1] https://lore.kernel.org/all/20240329-selftests-libmk-llvm-rfc-v1-1-2f9ed7d1c49f@valentinobst.de/

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/x86/amx.c               | 16 ----------------
 tools/testing/selftests/x86/fsgsbase.c          |  6 ------
 tools/testing/selftests/x86/syscall_arg_fault.c |  1 -
 tools/testing/selftests/x86/test_vsyscall.c     |  5 -----
 tools/testing/selftests/x86/vdso_restorer.c     |  2 ++
 5 files changed, 2 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/x86/amx.c b/tools/testing/selftests/x86/amx.c
index d884fd69dd51..a2fbb9b58ab5 100644
--- a/tools/testing/selftests/x86/amx.c
+++ b/tools/testing/selftests/x86/amx.c
@@ -39,16 +39,6 @@ struct xsave_buffer {
 	};
 };
 
-static inline uint64_t xgetbv(uint32_t index)
-{
-	uint32_t eax, edx;
-
-	asm volatile("xgetbv;"
-		     : "=a" (eax), "=d" (edx)
-		     : "c" (index));
-	return eax + ((uint64_t)edx << 32);
-}
-
 static inline void xsave(struct xsave_buffer *xbuf, uint64_t rfbm)
 {
 	uint32_t rfbm_lo = rfbm;
@@ -179,12 +169,6 @@ static inline void clear_xstate_header(struct xsave_buffer *buffer)
 	memset(&buffer->header, 0, sizeof(buffer->header));
 }
 
-static inline uint64_t get_xstatebv(struct xsave_buffer *buffer)
-{
-	/* XSTATE_BV is at the beginning of the header: */
-	return *(uint64_t *)&buffer->header;
-}
-
 static inline void set_xstatebv(struct xsave_buffer *buffer, uint64_t bv)
 {
 	/* XSTATE_BV is at the beginning of the header: */
diff --git a/tools/testing/selftests/x86/fsgsbase.c b/tools/testing/selftests/x86/fsgsbase.c
index 8c780cce941d..50cf32de6313 100644
--- a/tools/testing/selftests/x86/fsgsbase.c
+++ b/tools/testing/selftests/x86/fsgsbase.c
@@ -109,11 +109,6 @@ static inline void wrgsbase(unsigned long gsbase)
 	asm volatile("wrgsbase %0" :: "r" (gsbase) : "memory");
 }
 
-static inline void wrfsbase(unsigned long fsbase)
-{
-	asm volatile("wrfsbase %0" :: "r" (fsbase) : "memory");
-}
-
 enum which_base { FS, GS };
 
 static unsigned long read_base(enum which_base which)
@@ -212,7 +207,6 @@ static void mov_0_gs(unsigned long initial_base, bool schedule)
 }
 
 static volatile unsigned long remote_base;
-static volatile bool remote_hard_zero;
 static volatile unsigned int ftx;
 
 /*
diff --git a/tools/testing/selftests/x86/syscall_arg_fault.c b/tools/testing/selftests/x86/syscall_arg_fault.c
index 461fa41a4d02..48ab065a76f9 100644
--- a/tools/testing/selftests/x86/syscall_arg_fault.c
+++ b/tools/testing/selftests/x86/syscall_arg_fault.c
@@ -29,7 +29,6 @@ static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
 		err(1, "sigaction");
 }
 
-static volatile sig_atomic_t sig_traps;
 static sigjmp_buf jmpbuf;
 
 static volatile sig_atomic_t n_errs;
diff --git a/tools/testing/selftests/x86/test_vsyscall.c b/tools/testing/selftests/x86/test_vsyscall.c
index 47cab972807c..bef6abac331c 100644
--- a/tools/testing/selftests/x86/test_vsyscall.c
+++ b/tools/testing/selftests/x86/test_vsyscall.c
@@ -160,11 +160,6 @@ static inline long sys_gtod(struct timeval *tv, struct timezone *tz)
 	return syscall(SYS_gettimeofday, tv, tz);
 }
 
-static inline int sys_clock_gettime(clockid_t id, struct timespec *ts)
-{
-	return syscall(SYS_clock_gettime, id, ts);
-}
-
 static inline long sys_time(time_t *t)
 {
 	return syscall(SYS_time, t);
diff --git a/tools/testing/selftests/x86/vdso_restorer.c b/tools/testing/selftests/x86/vdso_restorer.c
index fe99f2434155..ac8d8e1e9805 100644
--- a/tools/testing/selftests/x86/vdso_restorer.c
+++ b/tools/testing/selftests/x86/vdso_restorer.c
@@ -92,4 +92,6 @@ int main()
 		printf("[FAIL]\t!SA_SIGINFO handler was not called\n");
 		nerrs++;
 	}
+
+	return nerrs;
 }
-- 
2.45.0


