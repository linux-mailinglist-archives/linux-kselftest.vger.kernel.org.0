Return-Path: <linux-kselftest+bounces-11293-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD838FEEBF
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 16:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 380A91F25330
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 14:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351F21C6197;
	Thu,  6 Jun 2024 14:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g9LfEZFA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828B31C618E;
	Thu,  6 Jun 2024 14:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683697; cv=fail; b=W5iJReM2UjqwgWYJxOzrnm4v0D0VNDPFpapir+a3u5YwvS8KJvsbmKUVYcN+hpO9OlbN1ooLAeMiJovvSrzTe7qjA7gGX2ZQEq50xWIw9cV0Hb4aT1/TLyuNtU338HlsKhRsJZfvUdO5oDROkpQEHTIYqx8Jqtswy3ulPMecw10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683697; c=relaxed/simple;
	bh=9tzDugCuHhStexc+3jEiCM5qTz35g5YfDKbmBosDfoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H+B/+MQiPuqrw0S3GL7EQBPgKTz98qV2HEFR5W+NpWDi0B4vKI4M+EstkIMBhhXN1pePXDjHaxBQx1qkJtNCUpX12nCy+XN52R+Im3eDTlyFzCi4BUXI/Bn5kx3xt4m+0uDnt6xkm17x/VANTXD+fNLKoI6xkIgUKh9iXd9KJKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g9LfEZFA; arc=fail smtp.client-ip=40.107.244.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I0QjARFUNf5r931zkbnQ/ecf1SmvXfcCaO+0nI6xy/e5LOE0S4YT8xOcDD+dbWa76CVCLsliehlj7+WU1FFbJ8c/+lddRbdHHLZfHjKilzHrPu7ezPR6QX5uk7I2itRhnfNuJD3mc9JEMI+rTe180iD16WAbrwVBTvdQY3FX7TlAsOQh/pX58EKgJ/3BOVTGCI3jy13qoMhgxoyqX8cp+5h/AwKtB1YokL+Ju3GWFPK35cOP9VHeoNqhZjkjeI3jI4z3mza8og0Xn437/k7uqual7sPnPaWT/0iNH/tXgbCTq6MeKbXze/4XfkMLl8/6fVR8At0yXdApZzKkcODh6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IsHbdVmQNX6NDEUvl+Qr21Oiw/DkeFfk47dFglpHN0o=;
 b=W8ywclkbw+dxKu/K5Xgdp5HO1VzV32Rob7J+yUJukfriRYbpIHsd8rlpvQrA/o38Zw3+J2w66V169wDTwh5KDxVnSfr5hRABhNAFOtBKhscY2+jTRSZS2jOdPLHCPTzm1o2uLo0vX/Q9kdl9A0sFOW+whSPBZrT0pVZ7LrRsEwcZxd/rfKCEGuF43WuhKitQfm050OWEsHID7+GVfA6Faa3ega/7Le27wBu3KaYQmt5of44PTAXGmBECUUH5Kd9fDqTI5t72xgjYpjEza4J/0Flugwq+foFbNthyT9VdViS2inCqdtHWT2sSujfj/KbPxO1ik/qeeMUP0B8b4DMEtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IsHbdVmQNX6NDEUvl+Qr21Oiw/DkeFfk47dFglpHN0o=;
 b=g9LfEZFA8+x6bCNp3GuHBxu2i+Dl3b6o1StfIMV6ZN+OzqhH87ANg/ZhELdaayJ0FZDf1HiMGastrYVyy1qZHiD1r2raN8OMyGpsfyoSS6ezhxQT5d1LOggvqWWaefMxibXRIKsF0e4MCO3lYs1S9tg58f3XAtzPK7ol5KhejowREBvpndPjh014k4svMs2GMzpz5PnkZpxkUD9x/5vc09LkzzO8EnMa0vMlkVNKFe9WXF1gaW8TA5eDJuqEUYuqW1/7Tn12RnZmrHyGBrXktV/CqZDz8TDu0oVSb105vZwOP/ROA0GSSaNZEGIbr7oDtboO3ZvvJjfAt+HaDGncLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 PH0PR12MB7886.namprd12.prod.outlook.com (2603:10b6:510:26e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Thu, 6 Jun
 2024 14:21:31 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 14:21:31 +0000
From: Zi Yan <ziy@nvidia.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Shuah Khan <shuah@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 willy@infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 gost.dev@samsung.com, mcgrof@kernel.org, linux-kselftest@vger.kernel.org,
 Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH] selftests/mm: use volatile keyword to not optimize mmap
 read variable
Date: Thu, 06 Jun 2024 07:21:27 -0700
X-Mailer: MailMate (1.14r6030)
Message-ID: <4DEF0691-B0F7-4A9B-A8F4-115304419B0C@nvidia.com>
In-Reply-To: <20240606135835.600022-1-kernel@pankajraghav.com>
References: <20240606135835.600022-1-kernel@pankajraghav.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_388E47E6-D338-4A30-96DA-6174F3F35436_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: SJ0PR13CA0074.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::19) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|PH0PR12MB7886:EE_
X-MS-Office365-Filtering-Correlation-Id: f3c378c9-ed9d-48ae-17b6-08dc8633f655
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NlvClqTDCF6BxlSUGwPA2MUS931yIiBeyq9dF7tKPrAiEp0HoudkVT8dftcW?=
 =?us-ascii?Q?ObDPXoEvVkCUnEbv+Rl2r2CF4vdUeAWG/zChmu2ya9LbBYeIQAHIAlYmTtDG?=
 =?us-ascii?Q?9PcQnV+jcskGd9XJxgR1r59Ka9TOzpNvtBDq9rT6prLKpHsbDcm8ECFvwvwl?=
 =?us-ascii?Q?sXkMhRw1iWo3qEqApobqtBzKg+AViWb1q6Qxmk+DIfibHjgPlSaf8q392P4q?=
 =?us-ascii?Q?6rv6pLE8u1ukuVgUPcD4bKIhxT8+SJ1Ip3WrZoQaBXicN1EYfwmFGoJERegl?=
 =?us-ascii?Q?ASIwGgLwtoYSW6GJJncDfu9QQQhu9bnzkwCYAEp6OsZ6ZeB7/HIL/ZQH3hwX?=
 =?us-ascii?Q?7DPx0ErqBwlOZHRKsJi0jTLKKyGzXjRM3ZZOgO5dqSFv2PPe7jkWsMEoNUOh?=
 =?us-ascii?Q?sjCshAjnIwpaI7JyAKieHp2r9vyBD3OjxYuXt5sAVcMqwSnUgpFhmPpscsus?=
 =?us-ascii?Q?LFfn1V0g8N3ECAubD2SFCUdm7lNyG3pAxb0g4MU+zPPcPAaBx3lJynEFlLG8?=
 =?us-ascii?Q?3eDIWAC0QbHuGzbyjjFJ91OmbsRO2jNAm6MGDLfyUigOsRyMOf23hcEZ1sy4?=
 =?us-ascii?Q?ZV+nyHt8dD9VH8bzPPyxwg/6QevIQ6DIbGQPAe/DbYvaDmfpWp2Ykvs7o+1Y?=
 =?us-ascii?Q?6oihhANEbjsCERxHhcoiBqP0PhwubVUtTUlV0EFX7f45hRxhPsGOzwJ8CEIa?=
 =?us-ascii?Q?uAWof9n1hJHZVWsmd2NldDp8DQBcTkZpSshJCjwPk4lnuCGwA+RvBrBTtkqb?=
 =?us-ascii?Q?WR1vRYWUXOF6SCRdmy1blGD4A5iuhSGseivFmup8PMGbGJ9mtTho6s0IlCrD?=
 =?us-ascii?Q?qRSt9LMySDZZsC0GXXAg0XzuPg6ReL4VqzKei5/FhKkMC8Dd+FNmbvZhxCR5?=
 =?us-ascii?Q?uqdIMX7Je1mjmQZwhsQ7NlGVmkShbCO1jjZMXeb7ZO8iEYBtyy3JP504xqQw?=
 =?us-ascii?Q?Jr/9FZxImn+oXiOXvUcqozkhtw1T4TLFoFYl/jVXtKf8sry2iKZtrXX4xH4a?=
 =?us-ascii?Q?BggJ9Y2IPcwrCStm2vygRuGuP0IkwA8D+xE7BOR0kBjWUaxdUpEHVcvWU8cM?=
 =?us-ascii?Q?2BXLpSXuZgkWQk9QbgxG6UottHfa8UTSb3/EqLTr2/UuoFrI6VkghvdvTPEJ?=
 =?us-ascii?Q?mIhSgft407liesCo5FB3s8ztSJGa2NbzMHpWYqGYZwqg4z7VcYtUnhYU0ojc?=
 =?us-ascii?Q?X1wjbI+ImRfnbdq4Hn/lI2aNbfbqilSDUV/GajFxkX/2sweUn/O1kE+RIyBZ?=
 =?us-ascii?Q?ky8MPJCzVR5+EXTakWDxDvyCZyWu/TClaOr9np/fKeXpaywBwUeI8CMwJPLs?=
 =?us-ascii?Q?QOxLrtW5wQteJSkme1XztDMO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?us7gVA3yZTMqtAPbCkV5lprdCLTYUPi+AfII+LIqVNxK3h9dmVLpijxgjfdm?=
 =?us-ascii?Q?X9T79H1fAUyyCYxx8EpIA7itqxre/qe4SlGcRO+tpwtqHSE4qVHcAptcapEU?=
 =?us-ascii?Q?OHOFHtVgQmVbCH8VI+AJdZNg6BFzFQmSIxSizpqimj8/K923Yt11rxXrKHDq?=
 =?us-ascii?Q?P1Rx+UpGVxCE+AvwhlAvx2UvCg0JVqRQJA9qSuIKSsP3WgLgb3JQsgqpeZ+l?=
 =?us-ascii?Q?jB0v0emuMEy20GlYFc7G719W2q7FpfZX5xMRUcePlEkW0So/nPTlYiVHogio?=
 =?us-ascii?Q?QRTF8SfUe5sBSnpkI/g3sH3jZar8fbcUWQ8bos1EnpgizX+cfg3EoDE22kRZ?=
 =?us-ascii?Q?SEcQ0Hrxc+vP66dNZ+VPvmTq/iTS4SjkTabmjTjNqqOD9THhWCf8uFYNou5w?=
 =?us-ascii?Q?GlI8KUDBThCnbR2jkfeXDtjoI8dK+HnvjMAh6oEcO+k6JQD1LJzp3/m7NEs7?=
 =?us-ascii?Q?6jqOhGTonHfQiUmFPLYMtDOHYpg6MBrIyOO9rDJKM10u5dzIUaMqZt/+dcAs?=
 =?us-ascii?Q?uvFQFRE8L6sCEful7h4zPL5IALcWqeQEsgxedUU+ens22GNisbDnvTOIQMC4?=
 =?us-ascii?Q?t617kN75XEcydqq06VQFDW5Vvc7HYM2SfG1R0CQuN9Fy/3XVtpWryjHH5Jio?=
 =?us-ascii?Q?1Wjbozd1T9fbPvbFY5l2Y+vE016nHEO+F+VZ0S9HhXY9O5vK/ndJhWbJ3hjt?=
 =?us-ascii?Q?pICA4ETFAQ4vyzQuJ6R4OV4XPFNarEXY8yYRHnXaZD2L0teAyG1p6te6imLS?=
 =?us-ascii?Q?pJ4DOjnGd+jBHDZ+IwnAKNN357oTOqFaX0M1BhWHA0a+UayyFVlRI0/MFoVU?=
 =?us-ascii?Q?Bo5TPVWmdmNxE+lCsYA7cLhXWjMyyT4vlhDDhnDsVxXmTcF4DQdaQ4QGMnec?=
 =?us-ascii?Q?iWaplubSbpc2Xiqp5qXqHB68mT3GancH8JZvwSf765tIpioYGi3p5RWxLV/R?=
 =?us-ascii?Q?HOOIooVuNFp/eD9vhGYKnqKKNHE+NDMhZV+fFXvicgYFoE/HhsXVoq1jtW8p?=
 =?us-ascii?Q?FYO74pI0uRIat9c2Wib1/SXTW5h60dUWGkIrOHur666YppBitQOrSEhvIGFj?=
 =?us-ascii?Q?9L3Xwi7hd96C+pVu5XPzGIWgRFxOVsvqIpLNeKp35fhLTcTL1nELEDwfzuRi?=
 =?us-ascii?Q?YGG4SCHf6ndgoQx+ka1UDjAkSEw4D4waXR0PbfJFLOy4WfrJPKA89fSO/ANB?=
 =?us-ascii?Q?Vv0xH/QRKZbCCjqEq/zb6NsqwjajkbUsNUvILUXf6er39mE8v0n8MBj7823I?=
 =?us-ascii?Q?ugnCpXYMdh3j0oGFyYE8bIkOiPxIJiDP+L0t55ecY98Qh4ziRUHADRJQS8Jl?=
 =?us-ascii?Q?OZZMKtfUtyLthX0wGbVHsw1PDcqrg6iOydagAZtzlmL4sJJzK7oWVYyA7j+c?=
 =?us-ascii?Q?MhVCVIWDVlHFtuuw4DWwTLxEYRRjCkJED/AUKZL+hJ5XapYTydeFDD9Ux0Oa?=
 =?us-ascii?Q?Lh+HIWke8VZkmZbe8A6NnupCSxYXmkllMSNq5sGfeL31P/t838JKaNzAY3cg?=
 =?us-ascii?Q?7PG8dQffm3NcM/Kb0wTwiTArjT9TJv9PUSlSG/yO9jaCaKcoA8aEHo5sHfSQ?=
 =?us-ascii?Q?pkt8uFEG+kAgpq8TN6I=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c378c9-ed9d-48ae-17b6-08dc8633f655
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 14:21:31.5576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pL4YjAgOGSoBm6SRulhaGWH1kJ22xF5qt27s2gJevZ8Xcio4OehUvJ9KhgBtBjpA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7886

--=_MailMate_388E47E6-D338-4A30-96DA-6174F3F35436_=
Content-Type: text/plain

On 6 Jun 2024, at 6:58, Pankaj Raghav (Samsung) wrote:

> From: Pankaj Raghav <p.raghav@samsung.com>
>
> create_pagecache_thp_and_fd() in split_huge_page_test.c used the
> variable dummy to perform mmap read.
>
> However, this test was skipped even on XFS which has large folio
> support. The issue was compiler (gcc 13.2.0) was optimizing out the
> dummy variable, therefore, not creating huge page in the page cache.
>
> Add volatile keyword to force compiler not to optimize out the loop
> where we read from the mmaped addr.
>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  tools/testing/selftests/mm/split_huge_page_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Acked-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

--=_MailMate_388E47E6-D338-4A30-96DA-6174F3F35436_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmZhxegPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKVWQQAJu3Xas417qiFgI9qxQNwlVQxhcPoTlehgdo
xh4QwoJVQxHCid5fSneDTrroL8CEgYAcgROh5mItEJnLzkDWovD+mOydR7RNW5ts
w7hl9MTPItip94pmKcplh6WnxF8tsbWlkXZQQyEceiNSQ7JVC/2XSt8MXhaxMJ5h
kSiVshYl4/+oOHF5FuZTDEGlIyg/cAQkY7YH9CF56gYkIVFrnQtyZA3y+MQ4tRkI
MloeftwpXa5y8kUrzy5Al5YNVBMN/7JTlvbYQIxpOeYNuLhA54vaVTMJiH7V1zLr
rwkY4tsUmVU3a6dLa+ekiLn5SKu7l+tksKLooeiDiT95wcJaZh7k1k8sLkxk63Ce
kJ5xrdHts+ohezeYooVseR0DZ96m5GQmCXSKCWFoJ7PMoHGdUjv91jyl4jeEM0Qu
f8XYXArH8s+MtLBWX/3HH7HUv22yFL694HCVMfLWf/WmWqfxE6pQot5NQVNZqSNy
BHlZOIazyvMnRILCypXukgTje4jar93NIjvvI9MVCz3QaodMtOlvIX0RUpO2P8aS
xXlsz6nM+fDKVPU/seNjjwTXh08QnpJoMY4Qa7uqiJ7X+kEBJ6K3y6n2jIHvGyDg
62DG4LLOrc7E7DfvK0B/Tppo/SbSPg5mt+wTEb1Havxfe+aehS3f7oACx8wBjXeK
S3ynFX3g
=e6x1
-----END PGP SIGNATURE-----

--=_MailMate_388E47E6-D338-4A30-96DA-6174F3F35436_=--

