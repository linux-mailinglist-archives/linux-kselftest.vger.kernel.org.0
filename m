Return-Path: <linux-kselftest+bounces-6381-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F348D87E25A
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Mar 2024 03:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 164181C20DFD
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Mar 2024 02:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE241DFC7;
	Mon, 18 Mar 2024 02:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q39JwddN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC42A81F;
	Mon, 18 Mar 2024 02:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710730783; cv=fail; b=Umgvm6x3c4SB+XzlLumkf3eIE75pxGWEwTNLKyQ4Hrv/DE5DQ6v7fCllalJInvIVyECxkHJsFPx2UBJULaRHGY8bUATLrth5daqaXhEdUOloZuD1+KN7GRgQPtWau9SMhj01K7W/4idXMAVGQ2iyX9phlgGJ3AtglEIJoZriBNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710730783; c=relaxed/simple;
	bh=1UqiASNBEiHogCuw49LFNi66C2u1HpLIbb4BE7qTUaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W9M4dODY7zdsPPaiGZfaJh7YLjfBHqcK7k1pJJ6uzyVcjOJhXQ3WaemVgci1DuDVMbQM0O5+RLy4b3kICNOi/65hnALe+ZN0UFBVT3oUL7gZgXbbBx7eA2nwwBVq4GnXHWRs5i5C/URuwWIf0cIc5mnRR/V4l4uksJadFtw6QPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q39JwddN; arc=fail smtp.client-ip=40.107.93.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZx6ZFG/5TD5mQXPvxh2oJoR2fL4XFWtdbIXjgE23KLsxtkXQo+VqySLI8X7nBMTGFKoPNyj76yqgVMjjHzsMDijZ4IrT1fmd4BpkshgKB2LcEzefD8+gFO9uFDFaJ98TNrBrlQDKtQvIovG3tMY+KTpjB/AONrp7aMmjtIGouwXrsIsjLqmR+bAOsYuUY7i9pAYrx/quUK5v8e2gK1Vp+L17nYlFaiahKD2BaQa786zqHYK0YACw/eigrPiiRBkaAiG3AInxJl5WPFiwASiLepOHmbykKvIztIiLz4IxRoUjx2anL8nXC5CpiugdBq/5DgL1W1Qet4Ni8lagbegLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czCfXTeTUGWlCNZCIIL74VR+KH/qZ33PaNd89wYm5bg=;
 b=TvMoZULocB3as38sfKBbApYuxl31xDLEGy0Sh75vAQ1vMi6MNnOHEhlkPT0OCR8wDNG2S21OeKH3/Ck3Uphd/brtMBq+DcjXta0VgS+j0+13fGW1v8rj1WDeC59PqJuLINqHwBHv0FDkYSLEf1sZ9Z/t/5m+VSdUPTJY5HxQ14/xT8oCclbTcXK/XwCkgwmAVZ+6dMAuSTpbyDDxzW4jIbIiTSf7Knmo+k4gB1ifbsyA3tu31lj08qf24/2Zkwn7nLeZg+z2U39rQp4rY+35UZ5AqjqAn12smbhIXkZlBVQgaC016a81NUTKUufgh6qb4JZthfcoX64Af5znbfEtjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czCfXTeTUGWlCNZCIIL74VR+KH/qZ33PaNd89wYm5bg=;
 b=q39JwddNasfy44pS7PN2XZyLextVhfTSEIMeBoljbYg3vZuQR8pwaSrzyl0eZCLNIsb0wP/SnsEPBTLoAKltTXF+DQACPDhAjQ+RMYLOKPr425rZWpI7bMGELV/Lwn2A+78a/MJRu60R0CJ8wCJJtfc9i6iCHcTI73TD2dhusG8fqNDOi15YPH8G2SJctVc3vqvl2uSwEVBh7b7Qi9FhmVVN+bIlt9Hpj3P9hKe4xVggT5/6aUqmPoEZWnmXdqghKyuhMSphZP8A3lWCjJ8nkYpgNgxgkK3qCRXb6swAcqunAYf0MmN/gifAw6pg7wXVN6wMPfySVisbMZgnuZcn3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 LV8PR12MB9133.namprd12.prod.outlook.com (2603:10b6:408:188::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 02:59:38 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 02:59:38 +0000
From: Zi Yan <ziy@nvidia.com>
To: Vitaly Chikunov <vt@altlinux.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Keith Busch <kbusch@kernel.org>, Yang Shi <shy828301@gmail.com>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrea Arcangeli <aarcange@redhat.com>,
 Nadav Amit <nadav.amit@gmail.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] selftests/mm: Fix build with _FORTIFY_SOURCE
Date: Sun, 17 Mar 2024 22:59:35 -0400
X-Mailer: MailMate (1.14r6018)
Message-ID: <86DB2DA7-5D38-4E45-B810-225E4F75067B@nvidia.com>
In-Reply-To: <20240318023445.3192922-1-vt@altlinux.org>
References: <20240318023445.3192922-1-vt@altlinux.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_519C5D90-A726-49A4-89BD-B41149B7F45C_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR15CA0065.namprd15.prod.outlook.com
 (2603:10b6:208:237::34) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|LV8PR12MB9133:EE_
X-MS-Office365-Filtering-Correlation-Id: 2779e855-977d-4e12-6140-08dc46f77334
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	reT+/rRlGjaTO2cxGkAoRNr7zajLH4jrzPfvEbXIe6H0WwwOsBsKiZ3I5NrRDghFWzLxkTS1yr+MY8Zcvq3L2l7QuGiO0u/xyevXHDmmkXMAoE1Qem9jSuNGOT33H6vv0qhRUOD2bAjjexdtbJLup4YMtrzIkpsefMwmOPZEcoa3yXZ3CB9UBXjNItIdFAv4wl2WbL2/k9u7Bl/UTMer0fA4s7u/3A1q0hIsA3kaLpdpX94HQ2rOSZKEJ8w8Qt5tcajxrrpSdoGs14aLTNgMPhyIIYalc/xWkFIC4hdq/Xc54u12TlKOkPZOoe5Jmw31aOY85SfFE73ZOeaA/e7mnkyD2pGxv80GBMq9DCeYeROPpI47lFLwnoIkrsBqICvR+8f8G4nupuYsVDo/QTGzW/FGza4mtqelfUoWt/cGN4mC3VtoSDpXS/qF/ie0z3AMO27L5bBjnl9QXPatwe7kIGKD5cH1s9edzsjhx446i6qt0h0tRWSSzXo4m5FBVSMnRYJD9YkOGTjaVDNaoG2l0mmdCSjq47njhaz7Im3Q3GrwangFEnZseiHaKDk2YpZ+mYNbxtBjEPBxlRfOsCVzVBNAfh1vexTq3MRdwQyvATpxgR0JtV0OihlstNedfWia92HSwCoaxo7Gs0Af7tUvJq1YhCkLy++d6Wx+1B3VIPU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zQUuLuJRC/ilbA4YeeQlgCOCLWDxBcVuz62mw+zbbVL8qFG1DoBNxdcnVrXg?=
 =?us-ascii?Q?6djAdObOZTdL83stBZMag7k0IQ8rpWn/CHfek+M23ZxwxxlKQwvJ81i6sYlH?=
 =?us-ascii?Q?9MaFtnu6F5uoBnubUJqhgM9wYxJZFSE8TEh4Icfm2lIS+r4ADigrF/HR98+K?=
 =?us-ascii?Q?QawtJ1G4iAkdURoqIe+psPKNdsLIHEE1y1siOGF289vHarEtjjYFqF3VS2Sb?=
 =?us-ascii?Q?tjQyEscj66Enlk1nYW2TMixLDxRWcBnsZbbMtG/hX3J16jk1deCeNDmz5nuw?=
 =?us-ascii?Q?FQUpKJVvc1qp8GmKdXcWOqzx5QmJZtMBQOE9Z1oOHaqUg3gE5Cy7oEavnv4f?=
 =?us-ascii?Q?gkJOm0pTarXWqFD8GP5z/4/aCqCLFRHYnYOBJyZwEXLb0dsij/lDGZrpPod0?=
 =?us-ascii?Q?YiZxJ46XHO6zkzn/tDLVNj/4x5dEkqK2B2e6CTP/SjpbAIjdgCkpsVGXuBF/?=
 =?us-ascii?Q?+KNKF6fiZsU/LoPZbmR7az1Mg24FstoYnl/r7OUfamfsMRiHZf6HrDPnODNw?=
 =?us-ascii?Q?iybZ74ya9jCKom554qT2ehKgwiDi3BCF0D8MWqM5ldjAG6Foz2OCbBEsqPzW?=
 =?us-ascii?Q?EKOEFJj6FVTTEsNE4zC0AeIqqjtIXcx8Pc+GrIc9qGrbKBSO1y0e0tvQGr1V?=
 =?us-ascii?Q?/fi5k66cjEcC4H4dt8uVJuzEU/bHUpMxJpJu6XzEF3MWhUhlCi6L0hOni7+V?=
 =?us-ascii?Q?+4soPS8RmSa1v7niuuK5ARMMBq4sXqW9TmNqWHbsR+RP0bSroleMuDRWstM1?=
 =?us-ascii?Q?CtrTsm+J/Nvm5mqnB19sc0FfV7OYmmu36Ea0qPAitStSn5T3mG6vIRa1ZZVb?=
 =?us-ascii?Q?H1Qhd/xqkdIQalItJIyjJi+eHMWMYyUQuBXmDcFnTvxoRNxLsB6THYBfkCr2?=
 =?us-ascii?Q?FvNwKgYIHEJErzxL8IR5OOecp9vJk5qyTPKrFwJEkl5gdxmmS6Ev0I+nQWNB?=
 =?us-ascii?Q?mimoEmDIAZ99QNeA8N4sHbUTVksNj2pDvJ4WYkmMqTVlnJEEQupALhbl2W95?=
 =?us-ascii?Q?Ff0JqBeHMrRTBNMf2JuQw6Ji0rBtqXdltEDEkZ5VDbIVQgEFWsIsjE3PBjV/?=
 =?us-ascii?Q?lxmAUTRiwCsNQZlwucrBcXQouoFWnOpG6LJyrJD/abGo1L4f0mnqu540Nk9N?=
 =?us-ascii?Q?BUAlvPCMJsNo7kMJV+BJSPn8Mq0cWu7PKJ+c1Djb6e2yQ946WpRc6EDhctXs?=
 =?us-ascii?Q?weFpqRqvQ5ZNKpmgJG8cTpmg7Hz3Eds6HiEbpQQIt7MSS1zx93y0FPTJDwx9?=
 =?us-ascii?Q?43vfLJ2iRXf2RnLoC+wIj24HsVFBKOW1GFtrm44yKsMAs7mJCzkIb9rEDWbA?=
 =?us-ascii?Q?buptjVlsLd4hUMBEzl6WdDFDEzJ3z6RgfYpUwGo3Bt7VUhIZWI68rbvAI8YW?=
 =?us-ascii?Q?HbNbn7zu0dClPJPf7SS4NiLQFK4q6bXcqq7x7L4+fuaNJsGvE04/gb5zX4yf?=
 =?us-ascii?Q?fEpC74BtGiwzlI7u4vwkA/gK+AvtphEp8u5rOSyAPEa7/U5K3pSpTI0Qy1w1?=
 =?us-ascii?Q?twfRRpdGfF+Ufc9uwgoCWKcG8TvP3wCt6iSq7IT5sDG3QZbowswB7/XqDzLq?=
 =?us-ascii?Q?40ZUd/Nsym2brOBo4VM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2779e855-977d-4e12-6140-08dc46f77334
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 02:59:38.4341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wWyYT7gv5Ng13dFR9itJndKN5BkIt4l7m2eYAkv1hlQ8SAVSpFLk3Zp9t+qo45gO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9133

--=_MailMate_519C5D90-A726-49A4-89BD-B41149B7F45C_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 17 Mar 2024, at 22:34, Vitaly Chikunov wrote:

> Add missing flags argument to open(2) call with O_CREAT.
>
> Some tests fail to compile if _FORTIFY_SOURCE is defined (to any valid
> value) (together with -O), resulting in similar error messages such as:=

>
>   In file included from /usr/include/fcntl.h:342,
>                    from gup_test.c:1:
>   In function 'open',
>       inlined from 'main' at gup_test.c:206:10:
>   /usr/include/bits/fcntl2.h:50:11: error: call to '__open_missing_mode=
' declared with attribute error: open with O_CREAT or O_TMPFILE in second=
 argument needs 3 arguments
>      50 |           __open_missing_mode ();
>         |           ^~~~~~~~~~~~~~~~~~~~~~
>
> _FORTIFY_SOURCE is enabled by default in some distributions, so the
> tests are not built by default and are skipped.
>
> open(2) man-page warns about missing flags argument: "if it is not
> supplied, some arbitrary bytes from the stack will be applied as the
> file mode."
>
> Fixes: aeb85ed4f41a ("tools/testing/selftests/vm/gup_benchmark.c: allow=
 user specified file")
> Fixes: fbe37501b252 ("mm: huge_memory: debugfs for file-backed THP spli=
t")
> Fixes: c942f5bd17b3 ("selftests: soft-dirty: add test for mprotect")
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Nadav Amit <nadav.amit@gmail.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> ---
>  tools/testing/selftests/mm/gup_test.c             | 2 +-
>  tools/testing/selftests/mm/soft-dirty.c           | 2 +-
>  tools/testing/selftests/mm/split_huge_page_test.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

LGTM. Thanks. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

--=_MailMate_519C5D90-A726-49A4-89BD-B41149B7F45C_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmX3rhgPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhULfwQAInZeU7jCZM2Ek8wXoXDMTh9ikiJr4zsO/hE
Agzva6n0LYhY4eF/I+iHhPJUNM27OjLp/mODixUW2VNfAwGyerhQaMRsn36C6vHA
t5qn0yO47nCo1jIn3Szyh8JOCfBghhH7hcBRs8bRBB68ihhVicjBvqkKuejx+RpT
ceFCx8Y4wMF4ZUnXhtM05RuxUYmuF9fHF6SLePFJd+z4tpZvQN/cy9tcG+hm/OlI
ZDHwNTrqcvjsa6UKYhn2SuHTbRo29+lrPNMIjr+wuQRHgPUZKtLo8d40QfOMCv8M
agURsyEnkjMCWkalZap8GeF3z2Ecy8DZ6Ik0SNSN7ym7uqgoNA0GCkShXv5jJS50
wjAcbVYQabBbra0/AGJb3XWhzSlIb7rnAoU6ixd6VJMViN0VlXduwJ8jITOuEeYs
VLKfPMFLRGSFkyz2vH6U2Tf3Mv1TPuaqrGBuLm1Ious5a+PAMOashMscj8pOUrl+
hx3pPMJ9me0ToWdiQXYtx4WHNDrGqzYAGbkMTTuc+JlcoViPT/UuOyD08kL8S+UD
jXiN0ynPbFBjqp3asbTJIPr5PxFqJyythfJv0p7Yuiz5h/d4EaLwCaL8MbUBPM8w
HFvXNcLm4PlmnSLK0Z+LxtqZ2p6AjfEEnp9FPlxZkqOY0ZJ4Otajof5xnYb574pm
7dl6mcSC
=RRJW
-----END PGP SIGNATURE-----

--=_MailMate_519C5D90-A726-49A4-89BD-B41149B7F45C_=--

