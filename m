Return-Path: <linux-kselftest+bounces-34828-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC24AAD76EA
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 17:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCC6318887E4
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 15:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49998298CA3;
	Thu, 12 Jun 2025 15:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FmzbMymR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2054.outbound.protection.outlook.com [40.107.96.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAEA221DA8;
	Thu, 12 Jun 2025 15:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749743232; cv=fail; b=N8WEG731++ezNJui5HSb5HJXqhm3cGdCMw0brqT4yLMmvv66Rhcz2nIX1+izbDqZR3j794b1GxBVcq1gERa8EvBEfKuDjebxSnPUQuyjzxId8C/KQ43aYAe0C1m4X9Peee69dD2CCD/bgcX9n6THAzZitT8NJOBStkbsgy7eCQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749743232; c=relaxed/simple;
	bh=4H56IBisipagJts9+A5a0drKUS42cQXUfXY44MNHIRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eCoOg+D7YoBFiGK1kk8yftl5PguhgdIRfT0eiFs12tx7q8XWRF9K+zgbkFzM1Prf4f+e8glRoGXRluLN++ogfTSJTDCyK2vgBWyduFbvm9qua/KRyDbJREu8DC8JGKlVFjFk0bJ8h6MD4sMDelbM4LAQCGNM3poYPFj99yuk+WU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FmzbMymR; arc=fail smtp.client-ip=40.107.96.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NfogNINNQsaSwlJngP2mySOy/g5FYIhEeRcqHozmoLIX3v0sXR+hlp2y/RvfL3GYfkKAM1ZXbi6ugl6KCE/tz7hfNnQh844OVDAVTU5Sw0JdTX/Dj9VwXKaW/n6gY1IvU4FudJeMeWSxaZjd89H3A95vKDqtIxfwvXa58vYSDtq+laVvGSBUZ+COonbgBgR9JfqVTA2n+X3UXmfKM4KKa4tJXcRb4rwLzmVrM6Hcz5KmlwmPhXloAZJjYDTpb9c0XlhJ1TqAzf+LXUFTxj2Qta68xuWLeNF0z3mWOuPJqGItHJayl6U/+DyEHZMpVTDPVpdEVp6iaXFnHeiTHkx1Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NcKX/WiAZIIdtds3461+ba6rrLEFi40U7r9oogNp3GI=;
 b=o4VKhHOeRs4fGE/ol4AXDSdcUvTWW/WaTfMztXwPn5sC3N8yClkiSBCLBUHibsa/WFjlsIZ4s+PNpSSNzd9tYHP4OOHgaoHimhsesrvMi/kdDBJy12TfF8WTUz91Feb6CMPTDIjKU3WOZo0dHN26Gp137viUKmlw7dQPW1j78bgh5crNChskxvAciWlrqftJAwdJFl1y1P4ZW6ck4WypGsU+2+KjWBpujyC21CJo/m0xSToKUNExWe/bFfWBNzrx8Q6s0dd6VdJmbEzjQMxKJrQqWWKOn/Ho1mB6tah+6yDATnf8ltD/6L7zAXi8l7jJFJCwqMluAYj+r/agJ+IyVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NcKX/WiAZIIdtds3461+ba6rrLEFi40U7r9oogNp3GI=;
 b=FmzbMymRmeT41SgwnPVM3jw8Wk3BnA6+qjrG6eCrtUsyzEeselWPR7uPf+60RO7PckCE437PBAhactGksIplHLhusmNRvSpnarg1FA/+viEdfBMQAf4Fm4CD7tY3jBD/VdYvuLStnMzkXKDUSQ5CrTIySV7XAg5LYyrDUWbvSIs27E5GqFMm0To7919VnIPQJ5G/uY98koCEgBhHk5vQUeTgoKX0J1KN8x+UagCm3mp58WqbkozXQdXH5c2jYHe7m5lZ4B5pqnvCss2MHSkoujdoWWJYpjArz38PcRelW5q/ope3i5FvYoAkSFkMttbTdTlYSneOIdLmNv3jb8vB3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CY8PR12MB7219.namprd12.prod.outlook.com (2603:10b6:930:59::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.19; Thu, 12 Jun 2025 15:47:03 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%4]) with mapi id 15.20.8792.038; Thu, 12 Jun 2025
 15:47:03 +0000
From: Zi Yan <ziy@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, shuah@kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] selftests: khugepaged: fix the shmem collapse failure
Date: Thu, 12 Jun 2025 11:46:59 -0400
X-Mailer: MailMate (2.0r6263)
Message-ID: <AFC17CA1-DF5A-48F0-8E63-E139005F5880@nvidia.com>
In-Reply-To: <c16d1d452aa876b449324d12df6465677158a711.1749697399.git.baolin.wang@linux.alibaba.com>
References: <c16d1d452aa876b449324d12df6465677158a711.1749697399.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN9PR03CA0971.namprd03.prod.outlook.com
 (2603:10b6:408:109::16) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CY8PR12MB7219:EE_
X-MS-Office365-Filtering-Correlation-Id: 516f07f8-498e-441f-8b02-08dda9c86049
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z2v2c9SlWQTm7I64h92l0k8GiookKfaAXbU9gEQZjQ11Zi9nkOOxWc7sWg3Z?=
 =?us-ascii?Q?fzz/NDjXDd1/UEfcR32zoAfo9G3aE2QBZXRxIo/uqCWtnt2VpR9hvvQItpQ/?=
 =?us-ascii?Q?ga2kGC6GUyT/Kqozt9rDZT2zz8rBthzWg35NJF4CA2/hRaK23yRtN2RFH2Ev?=
 =?us-ascii?Q?vQVodlv7U6/B2BArcuOpFVmsjQyqjmc0we/8hatNXy8+nE6WSs5A//XqsdWt?=
 =?us-ascii?Q?/xvgFmjQjzYhSMpN3HWl6GFZVDwmbW6XoV09uvA3QKqu+ynr/4smqfmuVyAf?=
 =?us-ascii?Q?vvWXYKItThIvKYHl/wqIU0fsaZaFMYPXREtKWM8gEtlsWFKuBV/vi2GKxRdW?=
 =?us-ascii?Q?kPzmZ1VbB+pG3oFCHIiQJqkJhJ8GIF8k2jv/x6MrDkpGiyvnDn8u9sBare8/?=
 =?us-ascii?Q?zyNjOARY7QSaHHi/6Ol0vsXq2vfNoYDzVGr6Pyl32svmnOx0dq1RcFy0/PUe?=
 =?us-ascii?Q?xEH2Vk0IxhXWxsiwhLzlstgW6ipAsnCtKF4xK4OqPiU1+1Z9LDyCySiZ5gIb?=
 =?us-ascii?Q?nkCPcDVnc28Jio7TRJAyY5iE/LYpb61Z4GAYvHTwKGSKWoAFsJDWwYQsfujo?=
 =?us-ascii?Q?U/G+YBxI/fnjS/S2QZ6Z0vAxxC2bvFcU4lCjALFxjvKx5WZM2Q9Ps38nYJmY?=
 =?us-ascii?Q?Q4lX0De+KvX4hd33c9mRVP6ndvq6t+exK4s675PoG/ocYyY0KGPQvAShLDJ5?=
 =?us-ascii?Q?FULbCT9k348np1ifYlsLuPAihB6JttSv/xG0/R9x0zgRD+zQjaliITKgUkdP?=
 =?us-ascii?Q?3tMy+pKu12RlAnI9XbihspV+IEtrHfV2IBDVCHG4N8gHLsMWWtwmKkFDZP5f?=
 =?us-ascii?Q?oAo0hKzp5MpdtDRKhERL/uZEOPWpYiUBoIYNuwA7PfK2v+SykAzB6UnFxW1U?=
 =?us-ascii?Q?lRLMsFspJ3IvmdF4MtpfZUy/AOlON982Ovjr+n0Np0GtEW9yqwxnP3DNwRgI?=
 =?us-ascii?Q?I9/ogWhkSPo5828nppXVNOjfVQLZmPOpoA1DjzE520bMVH0kWO1ksmF7ZJM+?=
 =?us-ascii?Q?Nn80/c+VGvJbJ1fjMtBMi6YRwxz768Z0OXkpJt0Cmex07gyuQVNJV7QIqOrb?=
 =?us-ascii?Q?vHhIIPK9GXYCE2S0T+LMVQ39Bbt6mIHk62x0o+dgQx/OAhjFeEAqHOr2gulw?=
 =?us-ascii?Q?Qe7iSCk9qt/E7wCloGclNf6ZHuAqflCp5xoKLDACZKMHROmWRwE5V1i5rpyP?=
 =?us-ascii?Q?ne9+Tk+vyn9J8o1q9/eQMCLJAfczGo3JjltUgCdC2PBYGDBErJH7BWb2iCuh?=
 =?us-ascii?Q?W89UnVTYpfSZnnFkmIdb8H595f8jo2NZM3vJd77UJ7ehTvpqutTYbKvGCVQ2?=
 =?us-ascii?Q?fTWncv17kfj838TN3SbtEK2CgcJUmgEzcNPaAy7eY8o46vLiOLgSHBJLb/Oq?=
 =?us-ascii?Q?5FK7Rj2eV5+Hl/JHnA9ITD0sySsbuGFdOFJIzimGhhjHuOMNWg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hT2SJNIi73V1rCMlqYCKenmNKuH0pvFcEfNnEYTFLLz2138GmFy9FGDYtBQU?=
 =?us-ascii?Q?+9go8qS2lDTuGhPiHpb5/R2bRlx7NB0b92574vy25yLtuu4YW2QIk3Lnxbkz?=
 =?us-ascii?Q?5Zqn/xfDGeq1jViqiAUUIpBnK6BKnQGD7NIbKW399aNnw/5SKG0OB6ye7Qim?=
 =?us-ascii?Q?P/wO4/O5EVI60XxJ+SQlbVb4ww3oSoITCBYQHfPAXAw92fsMh3ig796hI1Tn?=
 =?us-ascii?Q?itR0PjTK/t8T5P4LO+l6JTIgtCTaa5xXLlsqjIR2rMMIyqmK/lui+/hfgmNi?=
 =?us-ascii?Q?J26ftyimLOcCRsLzmjuZAbRMrM6B6O3qekE84FUc2f+1TzjM9QxlNDGkjX1a?=
 =?us-ascii?Q?DEIvAi14KPqw9iG6V5AG9foYg8pl7d/yyUmBpnOZ4upyHRDN7y0iEmd+2w9u?=
 =?us-ascii?Q?eb5JXCbd2G6pXR6Rgs3/hPAwLOX2rCHCkrFs75JXOSi5owIuUMxaeV2tqsQa?=
 =?us-ascii?Q?VcnpviVjrFvP/yIPyBa6EhCqUWHYgqm6/pA13r+uQljurOsmaJetLp3ipUOA?=
 =?us-ascii?Q?eeGaj+MCMeMAmEL5UuwKpqqnnwD3UFp1YEymrZFYatNbHqHq++B1I65aECCM?=
 =?us-ascii?Q?wKYTshoMruHfrg2aG5eVQ5p4MWF4V0EFYvmi+suhvCzidv99D5uaylEHAwRL?=
 =?us-ascii?Q?yeyQlWXU44b+FO/rQCFR5s2l/PaFtHWxwMVyZfbBZwcNFiPmld2sqnZKH+kH?=
 =?us-ascii?Q?P+8HmHQcgETTFlebCHhiWWZDM6yV65H74lCSlmneSkTOfa/KnFym7JuKnOjU?=
 =?us-ascii?Q?Uq5pI12unx0m5c8wEJcyBVBXg24p2hPHe97MH9qyVd6e3EOAgb5XMT0BZ9S+?=
 =?us-ascii?Q?AVKJ8JZRJ/vii2bfixGJ15wBgqrJt5bazcsjVg75q0YO1ND2pgvsdVN4i3or?=
 =?us-ascii?Q?zu9ay+5nzIZnkaXtcClyDKhzRVlul+4q/q7UGseDfNGmamvtSON4LU/hufaQ?=
 =?us-ascii?Q?/kQNeXU0CS2Jz8G8zMOxjtXWSYDH0nMvlMK3WtK5gntLf9bXrybLJXIdcGA8?=
 =?us-ascii?Q?vZbSxORILaC8d19n1zUzTFHDLDvT/34ra4edcokL9KAAc9mmcpzvhlymVkdB?=
 =?us-ascii?Q?Ga2I1yQEUuthIEOT9cKOU9csTZ/FnZdjg7zX0z0l+bclrkghYVxNHfDlYglJ?=
 =?us-ascii?Q?6PcQafNO4dE3k8XaHpg7t4zrjGVAvFoaI8/WGacE/M9ywlqApNP+1yAaJpFI?=
 =?us-ascii?Q?LTGfQWvFc8nsXx53YK6bW9YQKhHym2UE8uNy01yPr58HXar/1UhcfBKNxHPW?=
 =?us-ascii?Q?lqz0gIJ3wNZdmS9hBO8c6CtAczgqHgPE07v5mE2mEeWl8rpB+/ebR7D5n1Du?=
 =?us-ascii?Q?j62f6VwrvNUyqC6/uquWIBoZJ8+lhxxdBBTjgf3gyKZ4GnKgjOq59bhv/zcR?=
 =?us-ascii?Q?dSKYKMdmz5YvlmAlu6kRxZHfBLcERy3pX3D0d1+SrzW1YA2nYmMsVsnYoyIa?=
 =?us-ascii?Q?D6jpnyppN+JfqJo5Kl0KANr1MeA/CGkKkfHqOoraaZxaCjS9Gkp/ehAdKkEA?=
 =?us-ascii?Q?2m9h+bdqia8qU61otyFUaFHPLCZwse49i6C/GUcu1s7EvggBb3pttvCm6usz?=
 =?us-ascii?Q?X/8f4G73LU3yQoEvQmk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 516f07f8-498e-441f-8b02-08dda9c86049
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 15:47:03.1899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JM/azWHFGf7gHcwrz0WWQWEGRJv0rYu9dxI0i5P/bWUfWH9TUgnjP49tlekADqzV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7219

On 11 Jun 2025, at 23:54, Baolin Wang wrote:

> When running the khugepaged selftest for shmem (./khugepaged all:shmem)=
,
> I encountered the following test failures:
> "
> Run test: collapse_full (khugepaged:shmem)
> Collapse multiple fully populated PTE table.... Fail
> ...
> Run test: collapse_single_pte_entry (khugepaged:shmem)
> Collapse PTE table with single PTE entry present.... Fail
> ...
> Run test: collapse_full_of_compound (khugepaged:shmem)
> Allocate huge page... OK
> Split huge page leaving single PTE page table full of compound pages...=
 OK
> Collapse PTE table full of compound pages.... Fail
> "
>
> The reason for the failure is that, it will set MADV_NOHUGEPAGE to prev=
ent
> khugepaged from continuing to scan shmem VMA after khugepaged finishes
> scanning in the wait_for_scan() function. Moreover, shmem requires a re=
fault
> to establish PMD mappings.
>
> However, after commit 2b0f922323cc, PMD mappings are prevented if the V=
MA is

Can you add the title of the commit? It is easier to understand the conte=
xt.

2b0f922323cc ("mm: don't install PMD mappings when THPs are disabled by t=
he hw/process/vma")

> set with MADV_NOHUGEPAGE flag, so shmem cannot establish PMD mappings d=
uring
> refault.
>
> To fix this issue, we can set the MADV_NOHUGEPAGE flag after the shmem =
refault.
> With this fix, the shmem test case passes.
>
> Fixes: 2b0f922323cc ("mm: don't install PMD mappings when THPs are disa=
bled by the hw/process/vma")
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  tools/testing/selftests/mm/khugepaged.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/khugepaged.c b/tools/testing/se=
lftests/mm/khugepaged.c
> index 8a4d34cce36b..d462f62d8116 100644
> --- a/tools/testing/selftests/mm/khugepaged.c
> +++ b/tools/testing/selftests/mm/khugepaged.c
> @@ -561,8 +561,6 @@ static bool wait_for_scan(const char *msg, char *p,=
 int nr_hpages,
>  		usleep(TICK);
>  	}
>
> -	madvise(p, nr_hpages * hpage_pmd_size, MADV_NOHUGEPAGE);
> -
>  	return timeout =3D=3D -1;
>  }
>
I assume you are going to just remove this madvise based on your discussi=
on
with David. With that, feel free to add Reviewed-by: Zi Yan <ziy@nvidia.c=
om>

Thanks.

Best Regards,
Yan, Zi

