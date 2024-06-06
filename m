Return-Path: <linux-kselftest+bounces-11314-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FCB8FF615
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 22:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDF3E1F24E88
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 20:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9739C7641E;
	Thu,  6 Jun 2024 20:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eoPHZ2LH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BAB196C7D;
	Thu,  6 Jun 2024 20:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717707165; cv=fail; b=rXbJsG5m+Lu/fh4313f+6qnub3O9KuP7khhFzTfHFC3F4/y02VIz0CFOeiAYyZb6JEH9HPLZQG0GjuF/YAu+QI0Vw228Dw4d2Fi2vZyTex/ZokSX3jMEVPB2IC2T1i5P2KmfJBOGypUWSZaBFJgfMD7YL6HF0t12d6TlmqpSzFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717707165; c=relaxed/simple;
	bh=USFPXjaCdXxprPKhF4OO58Zka2SpqCA7MjYwkGRrGqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hbPPQKvOJncSX4Uig1JUeTAhi4+HlNa+hBFBgmIYH9MLRbrGK0VFhGFJog81oWtKh5T/UlPMg5IMz37WEN8DQLeWN8wcJFnWk5XTZ13pTzctgJC33H16WyyMyMHUbneXV71zHl6UFGSpBkuyRne6dna8Dg1rubAaIX8UCCdF9iY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eoPHZ2LH; arc=fail smtp.client-ip=40.107.223.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wgzilu7ksrSkLnxntLV7aRh1xWS0wElh8rcoAzzgz9Y3qFMJPHMfVgSkO690e33MY+aKaQq7H62OnL2phdkLqjgIp41uPlfX9hyYjKoQ9cacdbb6MLQsXIx340o1WGeJsaONWyPeeUbtsKc81UAiLhhtXjSJ3Q63Mx42Aia8/3+LSYEeDAmcgFE3cHpWIvrGXiELlYfVwCxU4MRUbsXbt9QqDctU80PHJzsChuSGselp4cV77qk0GoMAv2ZO603r9FNDsz1e/NCHmh8VHLOWaGGEXkxd8fbd8OFzqdHt9lFHHUBwyM7n7rH9WbZMYS69db4iYOx7Vkpgwatp9GVe4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pr3s4mLaMCNzGIJMpoNKfoawcDGPXGMhPKI2VuxL78A=;
 b=iVMVi0u9lBfsHp7yFoCniA2tgkAR49tBWbMKPYKLAI3u8/K1Ev79GoZhxMOGAaOuE0+i4yIf//PyDctYWuqDHbE3PxOBVU8fZ53DClsjCL6GJdKskyV6alid9cSCDzCPN+nYC184e039jJ6nKDRx/xrYdvgxThMaS06IL3Oi39auyRWls5DokU29RzASWUHN/W+xNxxIEiNBLdrKzJvT7zJF1mzRjfzHE0LHOV+t3mA90H4AfDxzL4FqYQ3Txjjq0LbkIcI8JetSRK3o4OmJDFrGA9QsmX8Lh1STWMKlamTwS+NuXQms+Hca/sDsGjujQb6wYNSZwQehW/mea8m92g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pr3s4mLaMCNzGIJMpoNKfoawcDGPXGMhPKI2VuxL78A=;
 b=eoPHZ2LH3uTBy/upXQXWdmUYWweqWFZB2T5OWpwQ8jzIrxB8DJ+X6b3k6JsGul619C34/XOLfS9FjsbyxDrpaPlnHZzheNzF54cbIKeWUlw3Zh3IUAS8/7HE65AaGShWyioQIj6jaAE2VFGG0gg/hGFIiwm3crpSEagGeTWNXy36V57oDnkjrLDGnb6VD2uI3VnHbCMaw7Y9ivMd8PVfjYUDEZwL1trFpKgeD5HoD/SQ542Z8/5StBpLGAwMdDoT+rwgDPrCxPRLtLn/5DwqFA/RFq7S/7mOftLXwiZZWG7i10c+yq8TgVlhNOCkex7nm2RpOzTtuuJasbnC3mXRjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SA0PR12MB4495.namprd12.prod.outlook.com (2603:10b6:806:70::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.33; Thu, 6 Jun 2024 20:52:40 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 20:52:40 +0000
From: Zi Yan <ziy@nvidia.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 linux-mm@kvack.org, gost.dev@samsung.com,
 David Hildenbrand <david@redhat.com>, willy@infradead.org, mcgrof@kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v3] selftests/mm: use asm volatile to not optimize mmap
 read variable
Date: Thu, 06 Jun 2024 13:52:36 -0700
X-Mailer: MailMate (1.14r6030)
Message-ID: <5B059AE5-AA46-465D-A91E-9142A4FFA0F2@nvidia.com>
In-Reply-To: <20240606203619.677276-1-kernel@pankajraghav.com>
References: <20240606203619.677276-1-kernel@pankajraghav.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_092E7FE2-E062-4802-B1DF-23A3367946F5_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BYAPR03CA0036.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::49) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SA0PR12MB4495:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e1af498-c6b7-4d23-9c71-08dc866a9ad9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ze0MxrHrm6+474orFjqZ7FMWBFjqJfwSSXst8Gm6vIUWoTviw5ry8Tt8W7QT?=
 =?us-ascii?Q?viyEDWjLsrgBWcnbbg4VzvJM1sXwAK2LxLwl5GeWw32K3QqqrAMJQcQ8+khk?=
 =?us-ascii?Q?Sw0KDOvjGMhi60Ib/v2LXoimKcG1NcOJsioymKrAoNm/jQ+KsZFkMAneW26P?=
 =?us-ascii?Q?p9n/HuPLrXt1CdEM1cG8qjZ1tcY4EQJe2r9X1c6B9vA4Un/MKloPWf6u/Wyn?=
 =?us-ascii?Q?Abho4F61zKIGOhdPoW7xAQ4hmuy0oP5LN872mItoRXaNn8+B9z0QF8kP9qCp?=
 =?us-ascii?Q?1ElLCEl11unAoNhrp135CgT8Zou+ElPzdGwEwYywpGrsa4dXm/MJBh/VdSWl?=
 =?us-ascii?Q?h+jayu+zQtHlzpArzJ7+gteCMl0MjYrH4sqy+UEznH2Ds988fq+GI+JyAhtW?=
 =?us-ascii?Q?nkT/uEkR48lcw9em1mySwSQZyDaJuTdkitvlp9pmEL5wx4AGgDV91MF4gbhq?=
 =?us-ascii?Q?Nv4Tbsee6VNv2q0S2XWBuqQlhldLjddQav0CeWv1RdNh563VsDn6wJYvBGpb?=
 =?us-ascii?Q?up/+gUauxYko2+/vbR5vzcoJdmlxd5cWbXhDoY+xmhXBRcVqkiX9G9NjpzhV?=
 =?us-ascii?Q?vvIFtzm4Ja6euX+AulMcKzF2pzMUlNASgWyA6YCJ+Y60KTvoh8QrYweq120N?=
 =?us-ascii?Q?6ZbgQduEFYthf+k+fOsbLVx65mhuModR2usUgVCpVYmRaY9C0Cwzo4avcIAi?=
 =?us-ascii?Q?4L5xiUM8ALcbQ2tiSxapAmammmnq3Xu9lYZ6g4GMLzaSZAfBJ6HCVpxhQWBZ?=
 =?us-ascii?Q?aP2YeEzzdN9D/sPB+iF4J5+TImbKUT2zFXead8Vv65r6u0VB3nqmB48oGgwW?=
 =?us-ascii?Q?78ewVLL+gKenV4PXpU0GsAFa3umb/7DaM4EwPYqnlQV3ztHuFzHQAZRaRwH1?=
 =?us-ascii?Q?LxKpfXhqhtyTjgEGYdwpepSq4dup9VFBajXwUSsdtQ47noQTUnKbENfCtqrd?=
 =?us-ascii?Q?oGdU5L+L1K/BLpnwoJRt+5FsVY22L0CKJjCf7PSfi5IxfhIMnptqZ52hpvm8?=
 =?us-ascii?Q?1gf4I+Qf2bFcJbJlol+7RtRUbOnSJA1KX0mp1hUNDoOOzuwvKx5WgIFtkeu8?=
 =?us-ascii?Q?zbwM/Kxx4HaYpyZzPRKj+Oq9zADn5f6KBfrAz7bSfmVSovEo/05MEXhR+daC?=
 =?us-ascii?Q?rKuZSzpvKMF8lzN5JBcOsKD3hN3RVOaPZxuJC4BBx/sdD5FLt3HC/HAY87O8?=
 =?us-ascii?Q?7GI4Ako6mDDUNcCXwug0wVrHEZzWI5Z48BEy/u5/+70E8qAmUmuCjM3DVTDj?=
 =?us-ascii?Q?Av+JmnzAmw3FHO2y7o8wXfKubKQjWD3HVgSgLI6fz7PdLuOIVNQSy2ehktzl?=
 =?us-ascii?Q?6wk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lOr0Al+hBoQyvj7BrN/ieuanuTEagf7r7Pd0hbEFjZwvQ2NaynyDgyFWiIf7?=
 =?us-ascii?Q?6ScINjpr8gt+rZ2uPyR43EegU3GIhRaggZ/uDpHWN8QE+EEk7kJx9MjCDnPp?=
 =?us-ascii?Q?xgatrpOWEAk+5v0Swf2iNgRqjiyxvx2AsRFL3AVjlzC01GsnZgLNEmbu/CVP?=
 =?us-ascii?Q?GlFpY4yF5ZeNdvoi4mG7hFXe9OJFnihuW7Fiz1aaGvyMPU2Rvh7OupfP5x+v?=
 =?us-ascii?Q?DRPy223NalkJaFBYvnyR0qEUCirbxY1QDwCa7hCSu7bxFvQ2m+Y32yYNMWXG?=
 =?us-ascii?Q?NXDkt1ip/QOKcuDTIjSvTNB16Q4AMteOV/UJhmenwvFeEU3Sljlnjlf1g3z5?=
 =?us-ascii?Q?4Y4cj39YECaTNUsoaaqZ42bP+IgQI+ufUV64It09pg0twl1cUIgY6jA/0mSE?=
 =?us-ascii?Q?wQ5W9P4/1bD1JkQYYQE0FdrkJ/mbvfwzx5PlJ5ds6ElacZ8LWDaPOkMVDjGe?=
 =?us-ascii?Q?KhbY2572o3BbrN/AUZypkoZj3jbCZqIoqLr5r5szqMLnLQr8G4ojoR6hzpk8?=
 =?us-ascii?Q?+2bM1lsL4ZX59eIpTbSYf7q47S/VJuhZNXx7vxDIznbZ8S0ovjIrnuS0Igqi?=
 =?us-ascii?Q?/2m99VB+ZMhhxAdK8aJ7r/qaeM+PZIvt2OYjv2ge6WgYGE45D3hO87pfzd5U?=
 =?us-ascii?Q?8B+ascGQ1qpNt3HqdyGdCcBXnJOg7dsepv+QsG9D1fL1GDht8rJpJcG/3BCT?=
 =?us-ascii?Q?6k29Pwl8RYarUyuQV65I5mQOj/wi1wAafeuK7OAzj33Pfc9dtH+pt5QHRQR+?=
 =?us-ascii?Q?npYWWcsp8VnAO2t8l6Gsu2wfevAkEJ7OhX/Qt+r/WpjFRn8zHYBBQ4oL36sH?=
 =?us-ascii?Q?d3eN4OPniLQqb961hLkItdEuGR5O4ke0wftIdw/MykTHBmWWKEF1SRnQsE7y?=
 =?us-ascii?Q?+yNB5vzGif9edG0aCJRuexBTAyzGzjlht23Ct5yvhxq7/+bMRvbh1KYfHgZT?=
 =?us-ascii?Q?7JWY5l5c9/sPiHA51eOvdkAK3HRhF/6MYAW22pCfvkqC7NA3mW1FjzoLW9yx?=
 =?us-ascii?Q?IB8k9OjUz2WlPbncZ8Q40sZOxQxRv4YDNwt92yT79+duQW6UUwF8z7dR5Lef?=
 =?us-ascii?Q?lVGE/q2rzeGkV+aJL6SDD89sXq5m0umcGNT2TJiSXPdaZZ0LXkE7ySoGHylp?=
 =?us-ascii?Q?e628DthBYwe+LP3rGMjpJL1TDZneQVj8js72VjuTepKL6wppcyRKKqy0wnjE?=
 =?us-ascii?Q?1s9dPcRSOD5zF2YwXcyFx22wDtnrYvcvJco1SEI2giyiKRcveCSrIsp1N8+k?=
 =?us-ascii?Q?xeiwomvEEkDgoT9CVi+aVboAMcxNMxSd2RKRwbMUuUb3urmJIunJqHSWpSIR?=
 =?us-ascii?Q?l8WMCoExn/xxOfojIHZ8RiuN0o62RHGnYGFjly5JRGCk4JvOY+hn73AI2TfX?=
 =?us-ascii?Q?6KgbP23alSHDcMiDFEaBeXQvtHJQs9X8yS8FhqUb3P8AJQOWBLoKNOVBT8Ea?=
 =?us-ascii?Q?5BFWQNx6aABSJxMGH7G6Su42PSkyt35brJVG+0n11jTaenGZqzxyU2sgz1KA?=
 =?us-ascii?Q?G+8MK8zWptIXpCGsl9yB+jtLVBaBboMTH91BSWmvXC+rQ6kBZ7TEyXBWMwPn?=
 =?us-ascii?Q?6gi+i99GVViiH6y6FUA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e1af498-c6b7-4d23-9c71-08dc866a9ad9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 20:52:40.4431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dHAQG30JVYmb++v9d0hsHA7LoeHrJbvBTu47HOnI/atxqvmhK4ELFT/uMzlar/rr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4495

--=_MailMate_092E7FE2-E062-4802-B1DF-23A3367946F5_=
Content-Type: text/plain

On 6 Jun 2024, at 13:36, Pankaj Raghav (Samsung) wrote:

> From: Pankaj Raghav <p.raghav@samsung.com>
>
> create_pagecache_thp_and_fd() in split_huge_page_test.c used the
> variable dummy to perform mmap read.
>
> However, this test was skipped even on XFS which has large folio
> support. The issue was compiler (gcc 13.2.0) was optimizing out the
> dummy variable, therefore, not creating huge page in the page cache.
>
> Use asm volatile() trick to force the compiler not to optimize out
> the loop where we read from the mmaped addr. This is similar to what is
> being done in other tests (cow.c, etc)
>
> As the variable is now used in the asm statement, remove the unused
> attribute.
>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
> Changes since v2:
> - Use the asm volatile trick to force the compiler to not optimize the
>   read into dummy variable. (David)
>
>  tools/testing/selftests/mm/split_huge_page_test.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

--=_MailMate_092E7FE2-E062-4802-B1DF-23A3367946F5_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmZiIZQPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKFG8P/3n929AP8zttgexd8vlAsf0flN2SyuXkiwdN
poeWe0VtzTP3jnKSfO8hXGAoLyJGwLVnNLFzpAnI9PA5o8ABuPPY5TE/ae/jOySS
A5eIeeK8+2WypdtX9vVB8kb6gkmWOf1Wq3wwvLaR1Fs5c9cyeQheGP3Hy14sg20m
44PODhji+8FJuSQ5RH9zi2XyWXm7QX4no2fvsQG816ZuocnR3hEMl3Kkol364asq
0+hq9ubDieoFUZMrvsEmMs2u35E1c1ZgqecjnPWIwmiFJo+SrIqj3IZFb6uZ0+VF
duyj0SkQtU24VyvDlEpLy6fUKsMkNq67XlG7NfqG0x+IfdmFuBt3i8LNxn/J0z6T
845dSX0jEXQIjvq0zWXTkf2gbOdjyG7uBmeLrnHNeofOYN2MCbal1cTEGhXiIWbq
ruAD9LxDsKbc/j0Hlz3OQPXjH4tE8Q8SWJkDm5KbS5npDR9mhM4txqTtI3ivmVoD
qxzlN/sOMrRl4fU7I+02HrhqHbJms++1E79rXV/DsQSZlnK2iEyRYdBwhi4Rzqo1
TkfFQpcrHk5jaYSHR/h3Lu3vjzhbdYqG6FAKPcEo1rAxnXmxOaMKS+t/+TAsS9LN
WsmuU32+pEDvS2Cqo+dj3U4FGqP8nSGgBDS826jOSIUb8J9SK0cpjt1IT2WtMsX7
cri4k9VA
=LG24
-----END PGP SIGNATURE-----

--=_MailMate_092E7FE2-E062-4802-B1DF-23A3367946F5_=--

