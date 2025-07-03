Return-Path: <linux-kselftest+bounces-36444-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8881AF7798
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 16:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1AA71C4046F
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 14:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324792ECE92;
	Thu,  3 Jul 2025 14:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ir2EjZvc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2058.outbound.protection.outlook.com [40.107.101.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEF12ECEBB;
	Thu,  3 Jul 2025 14:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751553213; cv=fail; b=tFNlogI5jDzgpqBGxmXusz4BbYOxk/6ZOByOeHMJsygayTfehfjHFKQMUUEZuobL0xejEUKZsxG76zLTief31Os2zukj5uP9wUqGw5AXDumPaAxwQcf5FmURxfgESauIJ+prml6//034w1c+SO9UkPXFZKnbMk59uou8ck49tdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751553213; c=relaxed/simple;
	bh=e4tvTaNacUzDy4RR66ct90gHwTnyThuNpUggALFUuO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EsP0YxkK9oLkyIe1GXLlauxFklEZ3e1y/JzFM+iMm+vyvW32wOv730SNNpH9GRMa0M8SSi/xB5tHW/Q8N78pVnwHqd7kGp8OtVUzBCcAgap3QuojKimLjaUdubLhm0znyaNvS20d6t36mny9gwhO8Kjy8FgXWImnwox8LP3CnAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ir2EjZvc; arc=fail smtp.client-ip=40.107.101.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OQ3PXkSTVgApS8CfHEg+8Onk5iyzBokN2jj+2rLnUZprEV4BxGKxPbVR2mJjgjWZNWipTiGwMP5ZklIxyzly2KtI8P5y5Z+L6lYCk9LuVp2ll0HzASYGcs6rxVBHLU+4NpD5QdYMRTOa3rqzKIhgO7UUkamsKgeC++6amYduu31EUfhDH+ScdF34q0sDg7G4DkGhyAOsQnIclQTXQbhlB2i3PK/+QlbwDv38H3VPFYgMlNHTtBGQuwsbu6zGXghx6IjO9KuGvLYhWVUeU0MtTNhEXH83T/TerDI0uWfRM/YJwR/D9pv8rF/laLfnZn2PaiXN9ZWXc1iumDsUUuwJAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8z1uMZElHJ1FEORnr2kz+U5yrmY0ZBGxUG9upS4Rx0E=;
 b=u/G2DDvq5VcOUQptK4KU5cEjkzurm/GoBtUHnd8N+k6PW5agKcCCCQIkSkrdG3X4pAV5iL34IJj9dg2y6EcNOpqBpfoJGiTJ9W8WjlIUwo8GyYx1SAvEuhzsv4N1e/IfTWM/xi6t8Ze2CblRc8Ywm/6sRY0FQ3t//GLWPlnXCXns7UamXGU4564DMWT6Tkgz6el7D4xi6s1GLX+BplDvvmeHvc17zPsBQXwbIP3B0W4le0+jiipXVDXWxwr4tuSH/TkvbRm6CRVwxMszsrwjrf4J50DJAN02lNUJNPOQm5/06kAFKZ1ppgQQ5Bj4Kvr9KJPsR1WmX3UuFWMn99+Aeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8z1uMZElHJ1FEORnr2kz+U5yrmY0ZBGxUG9upS4Rx0E=;
 b=ir2EjZvcwPkbnUAHNEnbyOARVcz2Ad3AY3TiHDD4qLvl+YRCdOF7hToaFUSfGpddyC6cmvA0c32yqaEcZ0SKCyB1zF6wR1ZMqXCDzJCYF61fku/cxJ/RdrIpzzQrvtRW+GNCRKVhTm1gkF57x/nxZRFMREEuw5tu65SGgqofl/UmeZdKp8YdRIBb6wNkc6SdnUQaxTWlbkoni+OpUkaedTVnoUznFnjPgUfiLJY4kZW+D+nNVdPtUlGtc+cphzY7YKN30cqjjokM6kLSoOMZobz4JK5vUNmFufIRsrFFJM3Jl/jWinu+1NaAyrzCZb73FUIR8dw5vFTf927/pBdgMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA1PR12MB7126.namprd12.prod.outlook.com (2603:10b6:806:2b0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.27; Thu, 3 Jul
 2025 14:33:26 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%4]) with mapi id 15.20.8901.021; Thu, 3 Jul 2025
 14:33:26 +0000
From: Zi Yan <ziy@nvidia.com>
To: Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com,
 lorenzo.stoakes@oracle.com, shuah@kernel.org, pfalcato@suse.de,
 david@redhat.com, baolin.wang@linux.alibaba.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, donettom@linux.ibm.com, ritesh.list@gmail.com
Subject: Re: [PATCH v2 1/7] mm/selftests: Fix incorrect pointer being passed
 to mark_range()
Date: Thu, 03 Jul 2025 10:33:23 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <D34D3DEC-996F-4ABC-A5ED-0EB1C7AF99ED@nvidia.com>
In-Reply-To: <20250703060656.54345-2-aboorvad@linux.ibm.com>
References: <20250703060656.54345-1-aboorvad@linux.ibm.com>
 <20250703060656.54345-2-aboorvad@linux.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR17CA0012.namprd17.prod.outlook.com
 (2603:10b6:208:15e::25) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA1PR12MB7126:EE_
X-MS-Office365-Filtering-Correlation-Id: dbe267c5-72ed-4a99-d81c-08ddba3e926b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Kz5/CjWVVOtsPDjLs/gmR5f7LD3OPfOur1NC2yW9WP/DHCckaYYyv48fp+aY?=
 =?us-ascii?Q?Z1DubVQLRDupMoBm2fkbi3ZfnPDmabe3+5gL0k2GCYgVyTovW8fdYl093jFZ?=
 =?us-ascii?Q?nLotFVrpsk4iApXPOcDyldC0Q+Phbh4uhWI2RubsbopM7nr92hGaI0kOGnCi?=
 =?us-ascii?Q?Uc9sBJ2EjtpJu6L7g0AVKHy3WA21AG80zvaF3LWJhdY0rN5k36uh2ssuB81a?=
 =?us-ascii?Q?XS+kITaT1XhC/wn4RmFvtT1mQ6WdsstNKC1IRXnTdawh85fCBVTosJTvAU8L?=
 =?us-ascii?Q?t/6DkUhVa5x3bIl7gxIbNolC9Rqvoh8Tp0tVYtKjc+rA7T9dBtWRAkHh297s?=
 =?us-ascii?Q?gAnZ26b7I+ucIemeHnOrlqtxWnOMErE7koOq8cTX4n3O3CiPs8i6PLJQ8zHI?=
 =?us-ascii?Q?xRWEqC4fDNvKp6jMVF5VTQdNTV5MJQyLjr5Xiabkyl7Bcxuu8e2yhrdxLPDG?=
 =?us-ascii?Q?nWnvgMsSCSVzC3mwBNd3VvDP5TXsLZkrjINjFrLLiBgzxPqKCRznozeQ1Vpi?=
 =?us-ascii?Q?HWb3AbTiemXX9OkZMQdHoew6rNJEGMVH0qt3kFi+hX/5+lQcw8PsErk16vJi?=
 =?us-ascii?Q?3Nko/3xX9qPnSjzpC5CmnUMdsf7UqYWrkfOpFhbItyltFLNt7lfAEsfHypWl?=
 =?us-ascii?Q?3wcbnCwWa96XMXE6VdI7S9G8+luFoE1GJ25CVXcYltFwrQ7atfjfm1eSm2g0?=
 =?us-ascii?Q?GeRkFrYjeJ53fo6EhbKGC/GPSq9iD2exo+iPb/tjDBg14GAK0AZu9MM/Ud9l?=
 =?us-ascii?Q?9IMkrGlJLkBUnTsv2OSWjY8IGlrcRl2+qVtnrGbCabkT7r/HfMXVPwfume8g?=
 =?us-ascii?Q?Glyzvhho6gQWNU2zGN6ZaCa7r+IgzExVPYKZWobLATOKT+bjmFNbr8YT0dxo?=
 =?us-ascii?Q?XViJ2cWOgk1gaSqM+Ho5TtLVWgodeZt/7bh6e3umHzYPYQ00/X9Noxjymvkw?=
 =?us-ascii?Q?FC5Y27DscVjOPveZ0CTZ0CZ1x3rzoK6hxg9O1ALKRF45GO92L6RTAKe9tE8Y?=
 =?us-ascii?Q?eYeOoHi4asY791DD3D0d3FMvQC3PiHPrcumtdWk1JhKjrTJwy5dKrjbktTu2?=
 =?us-ascii?Q?ybfZnU9OZCTXW93j9LtbxKqn4VNK/ax+ZJd7oJF/VTAXQsMQrrRwzw7kfbsF?=
 =?us-ascii?Q?OPZ+s/Iof0o2ybnB85sPD8yjJU3op6cqEnrPT5okF7v25Td8kYubrI1nDZox?=
 =?us-ascii?Q?VB9kzu3lNcSwWdap9rxK4L7FjsEf5+9lBKvuxcDL1XZteOD0sGhnV67uVWf2?=
 =?us-ascii?Q?LV6RkdX/Q2JnQVJDvuuX7xMYyynerOXNmqnVQGFjkHIs2/AGiyzSmhi1b8pT?=
 =?us-ascii?Q?VBakuXHXOxFkt/y0IcbcRHHylDJCpJ2ogobabAB47OGc4G6NlHb8OxUYEgzx?=
 =?us-ascii?Q?D9M1yzeamxrQ2qYJdZdQB1JSlRE2KKQYNZzuQs+uyGgKN9Ar7t1q3MrOrhne?=
 =?us-ascii?Q?V/nHIjGU4X4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L7uLe1qpPYT0yZuK8HVs4hn9eXd+KiOzUl6JAIWsKCWh0DwEUwjRYlIPgbF5?=
 =?us-ascii?Q?sM0KCZOsx6/vjgbC5TXg1YtWeLHioEmXOO0dzhu3RWkH+seZo3BV4AbYbyDl?=
 =?us-ascii?Q?ZfYO3dKFpZIO4T8w77Oh1jxg4BXUMfSTBI1lGphEQIETWea8BKgavHHo1e9U?=
 =?us-ascii?Q?ORPq2FOR76/gFPjdh51Im4q6fAjdqDcLkW2qh4WDsKpoJ6ulNbeKDTH3Ehmd?=
 =?us-ascii?Q?fdVCXLXSWNlTe+m7WCVmoovmPCyNe/vADbF76ClzJ4+70Xez0wo8CU535Y6v?=
 =?us-ascii?Q?5Hs3fTbQJQvVkNoqTLLDBzE8BT7twqW5wX4L8yMVOO3Eqmt9weMe1yYVjRGX?=
 =?us-ascii?Q?oSIazLxyrDIa1i/eW5o5hA6eEHmL3dTAhGMG8NGBevT7kKSBSrpsU9tvX4d7?=
 =?us-ascii?Q?L3j1wX6O2zxm6Bm8MKLNnUZkte16gJZvFZqQa4TMr0D01PxzIoANnr+EWeZn?=
 =?us-ascii?Q?BT8INQvSEBWJsPqXt2DLmbJ+f0v6Hy5eRWUVeDv/o9PLxl8fM9mxOcuXQ65p?=
 =?us-ascii?Q?r9Chro1lftpZySuine7exI1R8QQg2/PP4ZtQPJLT3s8cyx0A22R1chm5K7b3?=
 =?us-ascii?Q?jlFt0xao0uBy2GXOkvKDm5rRup3sPm3KyRrlSXhjXmVW+2WlmRFc5vBWp30y?=
 =?us-ascii?Q?8tioL69xcCfPNIlac/d6BwiIMpxGNAqJvvjajzp8UW6CekkQKr0KuqZLp3xe?=
 =?us-ascii?Q?jD2a//uG7FIekI8BUbYiZv1D3ziAzMdMTYWO9Yjp+KIJCgDztntYz/NE5qWM?=
 =?us-ascii?Q?81Nsrm8QcShwE+YeL22FeUyamc+/byEnyl7VOCNeEvkOlWWSA7wsfWNFCu/M?=
 =?us-ascii?Q?TdXRT/67nfSzMg+JBIt8orIyJIYrWWxmW6Jpl2dCfP5jwLxDdMjxCwXLHkgQ?=
 =?us-ascii?Q?LzePyy+T9pjYqT1ViwFe743Ool4cWmhEzfafusZfqf5ia4x22GcNygnZCgzM?=
 =?us-ascii?Q?h7M+Lb4jqNqEyNHFIYuwwgGFxqhOk3XX6ejdu9I1hUJblZafbGn2aqlGR2TF?=
 =?us-ascii?Q?86WxJa5+JuWlRhbWLfzfCqWrgtqn3t5s3UXANGZQBrmozXDAXQNIfvQS9iEJ?=
 =?us-ascii?Q?QLIF2U2XiGyE7/f9iKvE7Rb1TNvj+uoJzo16rkjBTtgZcYbKrHqfz8fdn0yK?=
 =?us-ascii?Q?E1wJ2jr45s1h3irL6CJxtAty5pPamlNTcTE8nS0vMbG/ZjsLtjxt73rfJwnY?=
 =?us-ascii?Q?vgnRpZuXhuN7w7Qb5vAtgNPEAsmMfY/p1MyxL64PyTmDLdoVVTqXdsjLadvb?=
 =?us-ascii?Q?u3wjsZobkIDA7K4LEOyfvwJFd+ir+6OFGtvT6pVcWFEmjO0XiqVrdbFndnEy?=
 =?us-ascii?Q?hWSnu0V+hUYuc8/l0PPsKlVyXQr9mc1JD2y3Nf7TS4Hw24AE4UyuN8A+WjUX?=
 =?us-ascii?Q?wn6oVzNPRxgzvLG+OTYjxh0AJrhHfWsLrwpTsT5EUIOwV6PdQHY4m1EABNuf?=
 =?us-ascii?Q?4PvJ00pKQRDOt8LK8UE6nVdom9WpT1Xeoh3iyywKlI8bp3Z6bRFODsqSEEPA?=
 =?us-ascii?Q?xZwLEiTPuXDjij/q7QtsSvLdC4Gru0facpcuUBrGq6SZa2wt0BdnJBeEDy5/?=
 =?us-ascii?Q?x41Eb/jc1YimQykxRAyRLBdERHFuUUOB+d5LeSym?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe267c5-72ed-4a99-d81c-08ddba3e926b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 14:33:26.4699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n+UX7Ae6MmRN4IleUsj6atdP1Lf1UMRLhmqT4Ws51gImM2Rt5qC4804WEueszBT1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7126

On 3 Jul 2025, at 2:06, Aboorva Devarajan wrote:

> From: Donet Tom <donettom@linux.ibm.com>
>
> In main(), the high address is stored in hptr, but for mark_range(),
> the address passed is ptr, not hptr. Fixed this by changing ptr[i] to
> hptr[i] in mark_range() function call.
>
> Fixes: b2a79f62133a ("selftests/mm: virtual_address_range: unmap chunks=
 after validation")
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> ---
>  tools/testing/selftests/mm/virtual_address_range.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools=
/testing/selftests/mm/virtual_address_range.c
> index 169dbd692bf5..e24c36a39f22 100644
> --- a/tools/testing/selftests/mm/virtual_address_range.c
> +++ b/tools/testing/selftests/mm/virtual_address_range.c
> @@ -227,7 +227,7 @@ int main(int argc, char *argv[])
>  		if (hptr[i] =3D=3D MAP_FAILED)
>  			break;
>
> -		mark_range(ptr[i], MAP_CHUNK_SIZE);
> +		mark_range(hptr[i], MAP_CHUNK_SIZE);
>  		validate_addr(hptr[i], 1);
>  	}
>  	hchunks =3D i;

It looks like it was a copy-paste error. Thank you for fixing it.

Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

