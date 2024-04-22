Return-Path: <linux-kselftest+bounces-8624-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 797EC8ACF8E
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 16:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 872F3B2151B
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 14:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4A1152180;
	Mon, 22 Apr 2024 14:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rz2vkW5v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6287A1514F0;
	Mon, 22 Apr 2024 14:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713796503; cv=fail; b=gR6FncSzScDbkldR6nVQ1tzp+p4JUYRaczTEnqhHCTe8YdqXSXneMfSqat4cpawUWHjxaSIjq8FKaN+zJ8cB8X0lArxVbZAiltq/+ino0VzlsjobJtisL+ANC2OOgz0SQoixp42Y337q2gyAPbyK2yN1TC3jDH1GGwVLru5575o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713796503; c=relaxed/simple;
	bh=yofH+Y73fmGXwyTRD8/dUy+fjoUFunfNPGRB5rcF+js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZdX0pgq3LQsyRA3iJ5ihU7nuI6m470eRD26g093yyr0vMPJAhzMhxfS2sj0YwwSiz14eq5pjZAANVtRS59PXaC9dm2TfIl4G8T8LiJ/TJHWYTo1039di7BozxvfpguD18baGGJecxkj27AoMi3jHDbCUtlz7xQgDkaQt9ttT/rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rz2vkW5v; arc=fail smtp.client-ip=40.107.92.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=caoFtHGyf5b61hTgK7MzjsdVUt5pprX13eRtPBuYQYu48Zg982/GVFJYj1DyKD3hybxSNUDXDU6QFHj0h8UOXQT+xgJRzmDj0mrOi9JN1bZeXPnD++AwiqFo+bbMuWlZO45EbC8UP7sgHsumzUbt8YM6RZGh3whiulJMMq7C7rGjRQW2wGYZyrYzVdvS2zNA8NtnSBls6HwmYZYw7YIcLPokVG23chYq5kJTHcPi+Y8oxvIL1vhaFAAsiCi8+Gt/tmp2NZVc3wwRAEcojDIzdIWmX4RAL8QDi/OYwi54mR5gZOtHXooKqhuOZEiuLadum+VfqaE73hgfpshwJxzLUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkIZ2St2At/SGQvWXNajfcL0FCyooz9fnBUgP6XV8X4=;
 b=gMpvrbMZS/IZOJ/ZKO087oalbccSGfxhdl7GIoPE/bYKqwSud1/lvzcYRh0mMOrOCtzKcT6avIbtVayyNxfuKnBA/g7Hs68k2P74gDTqDz9puNNJ2692YCiUh7qo3hPEVq5ef7WRANKH7Y8Jphn20T8TzAssEfwrkqE4+hhMuVzGWCDWTT/Tlrae1ZgsT4parsqbYPW1h0Gt7QKztT6XVvyrkBdMCzEMTj87bG3o1kiTj0Jfa7OLhpDlnoBGxeJcZKfDLIXFOkAP7ZB1HNi6S4QvUQYEJ89m+8UFm0C412QIrWJ/0ujGfxxO7Op0ViajmoSsfSwEAfxn790c6V5zFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkIZ2St2At/SGQvWXNajfcL0FCyooz9fnBUgP6XV8X4=;
 b=rz2vkW5vFRbeq3RR3zYDqg6v/HE/caDq3jpqT0aasAfHxKB3pYb03ka6IHGuePk45uDj8BN9rIFeYP6YHv7edrVUgfRfpy3/4qCwyJ2AKlAy+iDyBFLt8Qk0CIAbn3W93RZ9rlTBfjgmgpQEQdw3YZ5v4gCRhhBBLv3HIYyvu2OeSn2474FHp0KDEDOL4JmGVO9K4xg7QgAQP0xOM1OhPGOu75e5XxAfpCDdFGNES6zYtipZ/ljDM24ZFnKub4yVluoS1Yp2f+Y0Apa49zu4EtFxSWypJ1TQ0xm/1hmAnxhFytqYUVTZAIACYNHs4wnSVClyFZQ8uBGH89zVFIfjKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DM4PR12MB8557.namprd12.prod.outlook.com (2603:10b6:8:18b::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.44; Mon, 22 Apr 2024 14:34:57 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 14:34:57 +0000
From: Zi Yan <ziy@nvidia.com>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, kernel@collabora.com,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] selftests: mm: fix unused and uninitialized variable
 warning
Date: Mon, 22 Apr 2024 09:59:08 -0400
X-Mailer: MailMate (1.14r6028)
Message-ID: <CC621D9C-2D1B-4CB7-A5E0-ACE0850E6B0D@nvidia.com>
In-Reply-To: <20240416162658.3353622-1-usama.anjum@collabora.com>
References: <20240416162658.3353622-1-usama.anjum@collabora.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_48CB3BC0-7E89-479D-988D-8B56AF4CB946_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0270.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::35) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|DM4PR12MB8557:EE_
X-MS-Office365-Filtering-Correlation-Id: cd8a434d-7101-46bc-b826-08dc62d961c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JWNkKTIP5ylNJ+yC+JCSsVdt7sw4xIoJshn67IXjQUmkUsAfSN9rKuxSoSAp?=
 =?us-ascii?Q?8st33WwaBGi78giY1rCBIGUVdeNPzPeQgFtEXnFOfcCob67aukagzXOQOA6o?=
 =?us-ascii?Q?d5+U5PQ+7Ptcs3TSN4H7xj5Me0OlUZWWS99yqajb7xj0M1lLjTEahZw5oXAN?=
 =?us-ascii?Q?jfNVLqSKUMdFfPxHFdjHAc2ZGuIc5c4VxoUkuxckksAWavA3j87+a+xrS6GW?=
 =?us-ascii?Q?kTT5JaJEiXdWCNHuuh3covDGT2K6yrgVl0LxWl3gZSniH/BPEPDFuHwdVB/Q?=
 =?us-ascii?Q?tptQIenlCCNZEWD65FkvNjlQ1iFPzzTJS3RhV07cUEExC/N7rMevgHH+xl6a?=
 =?us-ascii?Q?KYwkAT9qVmIM51i/hVuCTCCjBJF2AEpUZ1RN/3APItio+c/9z31livsQ7//p?=
 =?us-ascii?Q?DiLcnZfTjPOg30JiyR6VIobcfjcCjh5T1WORblOAMjLZD8W5ZcZa7zPCZppg?=
 =?us-ascii?Q?JOMAPiEHH0vKaDKqLGpGH0C93Dnv6LH9bf1cgUzdRF04cc+usMm+5h6eN4QI?=
 =?us-ascii?Q?4Qjnm6b+ijr0QOX8z6d7zSt8qq2Q+HnxPLiBM2yKetgxyQo4D4NdIUlGB0Yj?=
 =?us-ascii?Q?EybLItsAm6DLyw5NSsy1XaNeuW8MpoP1p7ZBcCoQS6YGHDLKjElQvUb3u+7x?=
 =?us-ascii?Q?hrtgOr1cKXo2u3szwUkpGXi11mXpLrbnvKChw0BVBCcps1ajosmx0IdAEY30?=
 =?us-ascii?Q?PedHXVA3MVm1MP1YhXRRVLwf7JT5fJHLaqt76iAsF0izyGvOIn9SFjtboX2L?=
 =?us-ascii?Q?8yt5AyEmY1bGUvDLP5WOHNVXNAzT7mXxC6lQcpjbTR9I5EINqIU145loYLbd?=
 =?us-ascii?Q?J8ulyrSf9TSAOGP8FtyRBxeWAihH8iGXgNoSjrjl3ynIQaUJ7+xA77DEfw5P?=
 =?us-ascii?Q?mwnb/1RY2f2vbjBBvmyam+5nQ/RCgn55nYi2aCW0HhfOACChBbT7Q7pR9qYN?=
 =?us-ascii?Q?GBq2KtlwQJYPJ9DzJZ1vahlzux6TRbmQKLMfozPc4gD+JYq7C4SOm61Jag+F?=
 =?us-ascii?Q?PXfNDITT9meogMMl67tjo8KG72lBt6R3ZommIWGa7NUqwQ0+2Ba59Z7MX+wu?=
 =?us-ascii?Q?iRguUQHVJUhvzwJ6JoWPjtLhtPNiyOmf2gdT8wT8TvTdJQsCNcFXtynyRiCM?=
 =?us-ascii?Q?1geWRev6WQntps4C/3cP5l7pGA1A5ZkvZKobLqAAkwIBMqFsGUAigRVCaSHF?=
 =?us-ascii?Q?GpCk0NpcTOwe6sZCo7UkO7GI0zEPAYHCLg1qwiIzJhRNan5pYZ78MqCebHq0?=
 =?us-ascii?Q?+h+b9Q1FfzQF+kXUJA60rthq5QqZ0ifFr+qVRZNocg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5cMXCA2IJL/hW/Wc6rz7nIt8nlQnTj3FDLj6VQlguvkw9/gU4GVD8RUo/yEe?=
 =?us-ascii?Q?Gop+X/xMrXomCOfm8hSlwgjzQSruilZVlRjTnAYrFx1hK476h7Wac6Hkz6FK?=
 =?us-ascii?Q?qASLiHCwE/dfdfTUEV+nP/Af9MsLB3qGDI3A2xTkBZlLxnguGG9wygH6cwb3?=
 =?us-ascii?Q?f7dAuEWLingzxQ90DrBMHaBbinZtZEqjenaia7/RfdasudgGOUzgjjcSVaa6?=
 =?us-ascii?Q?9tESVwaKkt9sHF1jCPaJz2wFpbLSlH7aHFlAPxMK9jRAMbrFK73kNn4zKSJV?=
 =?us-ascii?Q?zdGUbDFiU9QXQWZc+kHXmAPuDl09PhhuRE7ySilUzf7d7bfwCN+vcPo8SmBQ?=
 =?us-ascii?Q?wZeZtU1+MF9a4tG4qJAb6heGIN1hdPsE+as8T9fw3criFNB5OKtxw4T5vjVp?=
 =?us-ascii?Q?UbXnAFvP+POpS6w6I4mzCUYZVneID3h6OMScqnpXP6eFOApla3SU7nZHNp8K?=
 =?us-ascii?Q?2gBSNw4xtl7krOAwzIIiWc56UShk1daISgtI+2/2PIm+uuMvJxpXXirzLf4C?=
 =?us-ascii?Q?Bqlnl6lVt06s63In31gr526RJKaF/TWoxCVW7RZLdflQR9KVLun13d3+EzX+?=
 =?us-ascii?Q?7zP1Qz6uc+vCtXsmRqCxmea525es/YSJJXSJS+iDX+tZChZ5xQ5+jF6DnV7O?=
 =?us-ascii?Q?Tlc3XQCM3eG0KDRhWMmZxmxRrLrUEbB8DcMswv+FzOUb1vO+FVHFoHUMfeFm?=
 =?us-ascii?Q?ttGTBjYIMXqhoIY70KFrpornPws6w7IBDUBi0lPPLqN4inIGDHTsypMqQu21?=
 =?us-ascii?Q?vNukcb9aEqY6jd27hS0wThsBJjKVaeHWZQuWvPLKy97LlW2dBO46Wi/RbG91?=
 =?us-ascii?Q?dsXntDCt3Ne1SWhpG4klAbo5Y1YDy7q/Ew/eqtoWsz5i8SQzLyHAVU4AofWT?=
 =?us-ascii?Q?JMb371bfA5QinkAQcvPDiJ+VrSHUqBQBjuWvtpUsig72dAfhaEj2xmnXBlHi?=
 =?us-ascii?Q?0bVfsaHdWNt04HpjCVBMD8SDcszwRbAAM2k2CUxwqRygRDEpk6Zojl1r6u7g?=
 =?us-ascii?Q?NF1zl9SKx2wRbLPHR2gdbB708D8tPmJcxXDPR07mWfP3pPaCy6bk3bxPtUQU?=
 =?us-ascii?Q?7isLAMInaDm1D8W6AUaKONf0wkt9wTzFZ91VVlHrlcXwRHphdqLO0djj/yix?=
 =?us-ascii?Q?orD3I9LulVq9L4dSNO45SP+2+MVoM0sv6gjNJlShI6DUbwfqyv6MGGnLGpR0?=
 =?us-ascii?Q?u1aM/CAa/Xxf+fhIXQoaA0dLsVyrhEkHVo/1jkdQz+KzVMAIBuzW8LoJBQwA?=
 =?us-ascii?Q?MuJk+JyrbnuJFdfHTntljUx3ZQC9UOZf0r9rzjxIAT9qBK+XsoJi6Nm/dCjn?=
 =?us-ascii?Q?akrpboF2a6DRddi4C6mjYbM8lOJhXn7Umedp5s0jLkRR15/sD8IzencA3FJi?=
 =?us-ascii?Q?8Vomgo0psw0p2B4ERDWay8kRbw7LI4FiThnaDF8RoywK/rDFK6dYU0SGXs/p?=
 =?us-ascii?Q?Wb20z4abSc8LcwyahaXwBC7ximBmPseNUnZOSRt58ygcBsyybDs/2MPUKnjD?=
 =?us-ascii?Q?UKQKO+KRDnOe9lKaRgjD2qRgTvuqgiopyqtKVSdg7LREP2+eB2cbN72RR0XH?=
 =?us-ascii?Q?2q3JFXutP/Hn7b9pgQQTyV7kZMNPFUfydQjA7juK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd8a434d-7101-46bc-b826-08dc62d961c7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 14:34:56.9002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gcKYQsM3gM/aWId+q4zimMmvsx5Do2V5z/0lhy7s8ffatFXREN9H57f3cTZu33pt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8557

--=_MailMate_48CB3BC0-7E89-479D-988D-8B56AF4CB946_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 16 Apr 2024, at 12:26, Muhammad Usama Anjum wrote:

> Fix the warnings by initializing and marking the variable as unused.
> I've caught the warnings by using clang.
>
> split_huge_page_test.c:303:6: warning: variable 'dummy' set but not use=
d [-Wunused-but-set-variable]
>   303 |         int dummy;
>       |             ^
> split_huge_page_test.c:343:3: warning: variable 'dummy' is uninitialize=
d when used here [-Wuninitialized]
>   343 |                 dummy +=3D *(*addr + i);
>       |                 ^~~~~
> split_huge_page_test.c:303:11: note: initialize the variable 'dummy' to=
 silence this warning
>   303 |         int dummy;
>       |                  ^
>       |                   =3D 0
> 2 warnings generated.
>
> Fixes: fc4d182316bd ("mm: huge_memory: enable debugfs to split huge pag=
es to any order")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  tools/testing/selftests/mm/split_huge_page_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
LGTM. Thanks. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

--=_MailMate_48CB3BC0-7E89-479D-988D-8B56AF4CB946_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmYmbSwPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUQ1MP/iC7xLfLjN9Qmlbjf8QP7EYroAKz7uTgH0aj
RPGQnC1e4RBMGmct5k/8U2NrqRFDs9UrbXv+Lv0bvt3vvn3R97aDAXvHRjqyOwGj
OTDsPDYsgIv26/uKQOd7N5/+3yKa+BRpiH5siGtvf/0Q3+Khhc5Krxyx9eZW2cle
9CkAxmWoE3MN8bMEWZDGxyAXnKAmNNihlwtntAkBj2VF2zL+Qb8lezHFUojtvcIG
WihNYJZbtBpcWEkaAxAYRniKflXe1dP7X9NeSctsp36XYDGeQ9JFkPSeq4qIFGo9
yYtoGz5Fj7giiKbi1wwVjflKNrQmBommm807cZh6U0pT4ZGBx1hrcW1TnNultzk3
6zewtyfZ8PAKuyMyK5U8am9x4Wx/jZN6eO3ZQ71hXR+vcZfae1ekzydb8gzLC3sI
hHbXr+jmmp5RjeaaM+q+T19YNUoKwWMriEqsZUwvBAf/hzsjJr1E02DjydQ40Bdo
gxom/vPBAc2poUCHwJB0/AA9P1wuyDzakUAiVXzszySZiUs8krxpouw2PncSQ+aN
tcRqLrwXP87rLckbayiEYyGqEiUiyS9Clcz9WlGzNAxy+JHQJs13X2aa8gd4mVWa
jRS74KM9otQ3+TKl38m6smny4xEfPBIuvWnGGQdMp5PZ8wdgB6QASEzt/XU6kR2w
9onacvIS
=yXTU
-----END PGP SIGNATURE-----

--=_MailMate_48CB3BC0-7E89-479D-988D-8B56AF4CB946_=--

