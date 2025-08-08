Return-Path: <linux-kselftest+bounces-38600-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E976B1EC97
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 17:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E39118C2E8E
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 15:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAF954279;
	Fri,  8 Aug 2025 15:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OZHesZYj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533FF285CB5
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Aug 2025 15:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754668622; cv=fail; b=rBqcsX4O8GY+00jiW4QycpDYx/IsZFl+H6xwI9sYcKOHOGZkSWtNjWH2/aWgRxwuytPVd1fWuyvpQciHSQbz2VjtPwVxI72/7roAW+RkZHmzgsjoieqY3dgNzhsXgp4mLwYlDQv9e9nK/rgXzct2MJlEXyOhzJqeq9bRMVxraQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754668622; c=relaxed/simple;
	bh=cxTHSNjIfwKZWas0VLIdRBVmt+JhHOPMViNZlmY9Lpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d0EpzuOvxIrfurwC/R4nZbjPWS0rOpHlu1mo3juKRcBfCdTZmlyaSjvG7v09odBZPA9nR3yrKNIxx4Puauo9AsV18iNjTy2MbPgZPXl+v+j871l8pYQmnX4haKeCoj+9XNsRyQ3XusXi7UQo8mgf+J1q35JrXWvJr4C46UzEXHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OZHesZYj; arc=fail smtp.client-ip=40.107.223.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LakIxGXHiv0qK71pEHQgWeiiMArdG7VEYPKbQs17TS4WNU9hpcQ5RPTTAlC0WZs3YbMLNRT2VIO/xwMNSX6TWnT1b1UPgvuR6bH5V0hnjgiaklTktEqewLS+Re/Q5isxkX4fiBx9UToZEUm2WGDB5mgH+cZD2noTrUSSbPfIPzb4OjbfaHhZRKws6c8HnkCHzoazsjrRr83EVd+r2Iusn/g42MNXGNOTz7bWVpfH4NpRRBna9OOSgrZ6Y6S6JonPqV27etp4knDZRp39dKSmcIexkdNWgzk0zEJyYpbUK0IrYofxcgbDmd19f0xIadGeLviDqc4nBYAUB7GyKXwjag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2oJqHtPFbIyX2onlmlpgEGiQEa7V8bxtg+E3GbD2ob4=;
 b=tzOVp968ifmQMTb/ltc4NueYf+x+VRtqfMINGHxZacFlsx/MhCHUOxE7bU1k7dOhgTN6e2D7+wFzlpcfkLUOTBrkHBdjzRVJQfzoTkC3mI819phGVoL12DsjjPTWooK5xPnzOKvr1PvaEr9iqkygNOv6psCv7CLWbBoI3gqjXZrSxUfkhuizCiiRLAi1EytW7z3yLPb6yCyVR9JFcrXRq0i+OkvywMVmR0ryiOjiRFMmy9fSOohg7CNohbDxrknDe4H7SLNdeOGnjMaSWLkSDNMJ00JE9HE5lPpW2x8XNuJiYBxEMiVgOKk65hXGMPrC8XDKE2ihKTvyxL63cz6J6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2oJqHtPFbIyX2onlmlpgEGiQEa7V8bxtg+E3GbD2ob4=;
 b=OZHesZYjrhAa/Btfm1vpi17xPXr9gob3cDeaFJJsQp2rhFzqjvfD5SVoLmXZowbrtaXXPuYsxpcjSR+uVUH8a7LivjoT84RS22uc8Gq1xuq9V6XRWybI1C9JNzv3Kr81WOK7uq3oHo88tkR8ecT2AVD5yhxv/qD7CStM7Cuv1yyx6corWPBT9ICsnKgkloa05PH8XwiQsgViPmzNg/FUQjD7f5VDw8Kpfy2zCT+TgMN85mZgLN2H/iFgrBboHyTbXKTuLk3cYEqVSNrE37SDnSWXVAuLWqtSIszEbvNprJYUu/SOKTer6dhPYZ0dvdETk+kEgiFqFrf24w4fg0L91Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA1PR12MB7541.namprd12.prod.outlook.com (2603:10b6:208:42f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 15:56:57 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 15:56:57 +0000
From: Zi Yan <ziy@nvidia.com>
To: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org
Cc: david@redhat.com, lorenzo.stoakes@oracle.com, dev.jain@arm.com,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/mm: do check_huge_anon() with a number been
 passed in
Date: Fri, 08 Aug 2025 11:56:55 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <0467FDBA-A2CF-4CF0-ACCD-760ECD30BA8A@nvidia.com>
In-Reply-To: <20250807082707.30647-1-richard.weiyang@gmail.com>
References: <20250807082707.30647-1-richard.weiyang@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1P222CA0017.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::22) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA1PR12MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: 79da1092-86db-4232-5e3b-08ddd6943402
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FRyS0/duYXVcCXbn4VvNd6NMyVqNDik61imiejOjrEHvUVd1Ugvfvzllvdt7?=
 =?us-ascii?Q?7E9T7N3ff3+xl+MT+stNG3lKAtcQweaJt4hhfnWLQWB1/ulLBiFA0TEI56cQ?=
 =?us-ascii?Q?6zEl2UE6GixH7j3l8Nk/MKiP+cqNxLjvYlc6gxzXWi+y1BP+3nKZBoXKDHzy?=
 =?us-ascii?Q?pDNP+NNk81Yz1wHy5TMaA3++KxCWmDWjoXvjiU7/UArjcPS8WxEUKwNker0h?=
 =?us-ascii?Q?dKdODg3hejnuEIj0cKm81etkGF2+Rz8cwD1RXITWfh7BaBQlJd4vocTwEZGI?=
 =?us-ascii?Q?6IpatCz/EcGaHaY0o5R27vCGCuNaMwRUpLTlbyagx+0v35sJIST8NsE47jc4?=
 =?us-ascii?Q?K2vCNazRP97mmio7umiHE8zaZYwgPa48oTqmBhUJs7dWi8pl+5JSsqi8FGbY?=
 =?us-ascii?Q?nk+W6PbH3XYg/NiLE+kip3NBevdq9mh2JRRzXnY0eecPLuk6KbBf9VSk0Hie?=
 =?us-ascii?Q?IKuH2Fsue7+dm+qPada2wwEM+2uKfgmh6B1bPuvi5l8QpoRCU+JCyBIJBDmX?=
 =?us-ascii?Q?BDX7R9zAyi+9I4EwBFodmm0iFUT6r/uM3r6wIFrdXDF/OGEjdtRWhwZx13M5?=
 =?us-ascii?Q?M9tiQncSE/mQMpUcnUHkLNEz1eN9fNHdbbnEcQOA17OUFGoP6Qa51wbXNOb8?=
 =?us-ascii?Q?+LUJ4CWwXmZ1qNwLNf2Nk5PFGMMuADdha9KiS0707xh9Sz2w7MsJBcz+wWpQ?=
 =?us-ascii?Q?224GANLxBRKMAJqN7PDZSYZ/a4vPVycxhBFHywXp/91jyfY1jIV5ftZUH7Xw?=
 =?us-ascii?Q?kXWNsrVuglRsD1wrFSpgvt/57KAy0ZrhZJqH5xghJIANP9IpUzDRAbFldThf?=
 =?us-ascii?Q?eaND66XhekVMWj4NDKI09cT+43CQFa0rdHhz/qUR2E7rPUhktHFXvGD7j0AU?=
 =?us-ascii?Q?Sf5OPLvsAqqRo5luxRpR5Yg0QypD8M1bGlzMQnfjVLk+6q1InAQkTUhrk7jd?=
 =?us-ascii?Q?mGQJh1VgoP/PCgKzrikQgPRIgnglT3B9zj+l3iqKMcny4/a1fuapxEESXKCh?=
 =?us-ascii?Q?pDcLT8g2tJcQV1hAEIdmcPsdsNGETyLaDwLusAaB+Nfp1y5mv7v0VQhcD4L2?=
 =?us-ascii?Q?Q/7iVo9aWzqArx7I9Oandss1jd15GpWXgqmh9Q3wy+hYLRNHQEVWNupzAxc1?=
 =?us-ascii?Q?U+4824GPcHWVWLSxuqCDCD04dRis/3P7nxN4EXdqirrFMGsot22kLOEEXpqL?=
 =?us-ascii?Q?Cuqnbljlh+VbsaqKu8voBFhPvaxDTMn04Tu7KgD3ruCy1lUieTNCWxxyAHSV?=
 =?us-ascii?Q?MSBRUAgFtbmR6STAmX3SbshRP4VcOfmyHzL7g5ngC0vGKsZVq6EdPpuP3oWE?=
 =?us-ascii?Q?ZttefQlOU4/y/RYjDFageRFrkGS5/pbUmDtiqQ6aZmnbuee5hTTCCfO+xeEH?=
 =?us-ascii?Q?9WS4JjRv/UyWIgMoXENM5L5PaFOyHNu0i9LzsCwVovaVgpSrQsmaD47vFE0E?=
 =?us-ascii?Q?WmaPegdVFTE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PhlN5sJdpNUSXSWvZsX03lFJ/lonsvOUngZKYqGebH0c46DzD09/b1GH44kB?=
 =?us-ascii?Q?n6VHJh3/5vWDdJjxviLA9XWK5nGvfdmFE7Zpz3am69h8m5VY9mktF/dm7/xp?=
 =?us-ascii?Q?JleaYlLRQj0otxJS6l2YZ2XqOZt0sIjh8tIXYvKoL1rKTtZ8RzCJARpvnKGr?=
 =?us-ascii?Q?4MsBOEgIUUEOpqNZnPKAHo4bDwIR8Aj98wePnkC+1lOrNrXvKS29IabALUr3?=
 =?us-ascii?Q?69WRBrQGG1dLZWGX/mQTVZBM1jJ4R0PSjVfqhBi04/mqtgClrHeeNzU5kxVM?=
 =?us-ascii?Q?uxjICkH6IEQ1mweUn8wQQvRKEISC2swrCJzoMyxs9rSzIedPyYvI6k+8ZRhm?=
 =?us-ascii?Q?lSp5unZqmQBC4BSI/mZkd0M58RHeqfmP4W9OxKYQVFMfd9G1QKckDRbOljmV?=
 =?us-ascii?Q?OHxkMB2rEST62pLB5clJ1Mk+vboODCndI+/QsE41X7IbS+qd0q6zphbPApT/?=
 =?us-ascii?Q?sGhq2tGqIiBic1VxxezqKQFKoVBt1IfhpWV6TIMYN1hI1ef8b0AQAPPEJhte?=
 =?us-ascii?Q?vGX6CM7lKp/1SY/iiJfAbDIwCZhPm5wnk8zOtr48hSEesXhAijDLVslT6M88?=
 =?us-ascii?Q?17TCiG5BACfeyF+XPph0gZCBSmcux5HB4+5pXkVKmbb4MRaPY3jJa0G0JXc0?=
 =?us-ascii?Q?WWUteLGIUwviUop06+U+UpEOR3cQzEgpA34QBZPP6pWKYUo8vKHIhtT+yDGU?=
 =?us-ascii?Q?rdZGwYPYohppdYBCslWpmGrHq+v4GcpPF/V98dBeCw81o4OWd55xzQFCZUD1?=
 =?us-ascii?Q?PDflkYMt0e4ZdY4rXP86/uhTuc5C3ZrzhqRzl8hCsweVnFTJ/KO8uJhc0rUr?=
 =?us-ascii?Q?LD7eYW/X63AM32s7/5Dm0gxcbSONFtwUfbYysXZhaSeWillFZBZMrExXImYn?=
 =?us-ascii?Q?lk7qxXvtu+9QLK7qbQ5SdVoURvjNjIEQIGSnBrWYvQmtBxubHKG58PS5OFgj?=
 =?us-ascii?Q?EQT4bXM2mXEwDuAP+fuhVh0dWUlfamde0AJNdS+3zqbcBRs67Ig8DyWoB0pB?=
 =?us-ascii?Q?pdcdCV6rTXJfbt1dNye3//AOXwK+u2MGNnWttnS0bbHfBivf2tCJMvwRpK9s?=
 =?us-ascii?Q?GKgn9hRG7nQWi++Tf9UL9V5nwgGlzslVMbI4J3xsdYgiaERVosgppvoFQz+P?=
 =?us-ascii?Q?0kanKI8RI0bAM0ss8fXDnTNwkJvjk5wTF939AwAkIZk2DUyoLDbUCTe5FrW8?=
 =?us-ascii?Q?8Gz2rf0+4kyuaCWT+QfJFZULR/l989yD5H8F18Pdcx7FJpaD31c9HVwEVOB3?=
 =?us-ascii?Q?/+jhdmzj1EVVm2IZtdK3doVhfv1cyb1gfmglv96LZbT3To/RmwYdm1wr0HkI?=
 =?us-ascii?Q?6R/ahnjO9VLockncVvCw1qZIpek+xpk3fYbEq5ML2LK7MtbnX1mkdt7kTwI8?=
 =?us-ascii?Q?hyR6jgIX//ZX4vE2wkCDMpuHoV1MuIvhSnENZ+zoC+IsrmTgCL9R3vBbc9ap?=
 =?us-ascii?Q?nDYv0CWBjfKvaIqfjPuND4FI1Ikt9vUzT30X3wsvcMCZySwGsKsFKe90MOZ0?=
 =?us-ascii?Q?Ncdvbqyn4U4Jzajsv7lgWstDv+GV4hBSaxrugAFqonuIQNUTBRuoxB5g+DOL?=
 =?us-ascii?Q?j+WMuAx3GXjBuxChBBRgMgaEZ8MVafEFo18mnuPD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79da1092-86db-4232-5e3b-08ddd6943402
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 15:56:57.3674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ruXbhz7YSprqFl9z4FeZUbGOzSym2ez0V2LmQuAcjcgeasQSpVkaZp0g2lMh7kf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7541

On 7 Aug 2025, at 4:27, Wei Yang wrote:

> Currently it hard coded the number of hugepage to check for
> check_huge_anon(), but we already have the number passed in.
>
> Do the check based on the number of hugepage passed in is more
> reasonable.
>
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> ---
>  tools/testing/selftests/mm/split_huge_page_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/=
testing/selftests/mm/split_huge_page_test.c
> index 44a3f8a58806..bf40e6b121ab 100644
> --- a/tools/testing/selftests/mm/split_huge_page_test.c
> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
> @@ -111,7 +111,7 @@ static void verify_rss_anon_split_huge_page_all_zer=
oes(char *one_page, int nr_hp
>  	unsigned long rss_anon_before, rss_anon_after;
>  	size_t i;
>
> -	if (!check_huge_anon(one_page, 4, pmd_pagesize))
> +	if (!check_huge_anon(one_page, nr_hpages, pmd_pagesize))
>  		ksft_exit_fail_msg("No THP is allocated\n");
>
>  	rss_anon_before =3D rss_anon();

Which commit is this patch based on?

In mm-new[1], verify_rss_anon_split_huge_page_all_zeroes() accepts
char *one_page and size_t len but no nr_hpages. This breaks
split_huge_page_test.c compilation.

Are you forgetting some cleanup patches before this one?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/tree/tool=
s/testing/selftests/mm/split_huge_page_test.c?h=3Dmm-new#n110


Hi Andrew,

Can you drop this one for now? Thanks.


--
Best Regards,
Yan, Zi

