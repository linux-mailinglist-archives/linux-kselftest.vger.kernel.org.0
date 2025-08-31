Return-Path: <linux-kselftest+bounces-40371-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E90BB3D08F
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Aug 2025 03:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 675DE1A81B0D
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Aug 2025 01:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098141A08BC;
	Sun, 31 Aug 2025 01:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b1Znb1UW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6371528E0F
	for <linux-kselftest@vger.kernel.org>; Sun, 31 Aug 2025 01:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756603984; cv=fail; b=m3Q03faG7W/R/M6Zhls45JalJQszGuSWStPKH42RqZ/lHFpnRN4+Nv2f5fxZgW1dlluKA85ifEXZ72yegCQsBJlbIBXmlOZSplYkoY+zLWB7RFZ6rbgq5DiIax+VxAbRnBByB+mtP1fn5m31UjnWW8MuNwWoGTOVfQYuK01t8nA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756603984; c=relaxed/simple;
	bh=FgbQwW+MV9nGtbfFTINcptdPbhThNMQ/lfaL5mkyX2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n13R33QAUuMys+gDR/K9z7aIvB2oxD43kRXKnMmXuaR+LkBQUt0jx+teC1F/3oUARtAP3n9pF3c9SLN59g4m+3rP3s/xcTJbREl1HWg4yLDnD/GeGibLEElKxvIg8tQYhkQgHFF4GnBihv/RMfE3H2Y04XGXdW19omjZVop56Z4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b1Znb1UW; arc=fail smtp.client-ip=40.107.92.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PbgSjrtc7G6FbPn+iyfUbXtV7F0TlDIcASmDL0wAQU1pyFnGgtrFu3aLcCy9yLlZf9Nv4NBAeK1Xvc+6Yh8f9y8G/7Ss4yjuUXfv3XbtdGr2AMue46Al2Zmew7nc0xaXlzisWmFKxapD8hDFlip/BhlfPJ4kbhB0Cf8h8MxxeJri8FC5HcSfgbElYiUtLnVx2OfRp7154VbIOb+/LlZ+b0lUV3ZxUd1SIrN2EEjaCjMl058fA8nK9Zup6FlXDJFPoN7JcEQNrkI0UKmXPln00cdxVsol/uyISMwTBwfaiZvMuvd28/If5RakU+1gP9AeTS6+lLH2bL7Wf1pFtHz/3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rk0aODzr0I5mVcT8krO2//DH+SZ1zwoY9cdqrPr7ecI=;
 b=pgyl558FHTLKjGmcMXfZPiGmNOW8QhpVP1I8RefIBlFcqAjzEciyUD11WmmwmiTxZWoB7GiAjbNjrlUTmXOW8YU5ZErWfUfhc3HSl5uO15u/+Poj5ohwS7GMB+LLZVIp4br8ZbuDqN7qszw/yjk4aRS5kjFQ56dSWFC7+HMyTemVruserVgcxGuiIR/9VDoo+kX8U+F3djXMmnPOKMtgY9+mwaM1dUQfNId6ctdq4y3eCYG1hUalCV0h9Z6dqBA48Zp4+vjLixxaZfAiEeMyHK+KfOH4Eablk9l5PF3wGRhDCYGBpyU8cCsvdMgcW+rJZ4nhNIANrEf0vFbiEKAs2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rk0aODzr0I5mVcT8krO2//DH+SZ1zwoY9cdqrPr7ecI=;
 b=b1Znb1UWEE2hS8mp1afX9QGT4XAcI4Z4sfyRoghfTtb//nQfwfZ8TJXUTAQ8+2tn9RwleTPyfHBAINs2hoSiQ0BDPFtd7TqPXTv17dQPrVJjsuAp4yJ1JhawSl+8Ze03aPQkBXA2ME5tcpX299oeZqed6R8C7BCODoxEnVwHia1GhDJckkB5Xi0XgPcYsN6OmyqvZ2UuIYWx2+JlF5Gyq+7QXEiAQUFfGBRFVTq+p289XJtZM1JwAfjavpXwfMuWIwZFR63iklbEuJbPoezceVlssM+nwgLgt5IOSbEf8MqhWTvxtI38W+ZeypI5ii8MpufWQUrlC6v9TDrxinWdBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA5PPF3C36BFCB5.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8c7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Sun, 31 Aug
 2025 01:33:00 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9052.019; Sun, 31 Aug 2025
 01:33:00 +0000
From: Zi Yan <ziy@nvidia.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/mm: directly add pagesize instead of increase
 until page size
Date: Sat, 30 Aug 2025 21:32:58 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <E0C570E7-C4CD-4E41-9590-DDB64757CA2C@nvidia.com>
In-Reply-To: <20250830023102.14981-1-richard.weiyang@gmail.com>
References: <20250830023102.14981-1-richard.weiyang@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1P221CA0040.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:5b5::15) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA5PPF3C36BFCB5:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f9aec61-7409-4870-0aa2-08dde82e5242
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HapYqXsh+OYBn36ujb2IBCE87Qx31g0yfoHqqb5YrqMZz7DyV89ZMY5Yrwch?=
 =?us-ascii?Q?G2X4kZLr8jmjCsE+PdzfD07G+x89uqsncb8Knna+PCY+YhZHhU0k0cklv/UM?=
 =?us-ascii?Q?QCTKMjhyaQHjLvWLsyjAeR4fo5JldNfU5LB7RrZ+bWnhpEzWx7gew+mdWmIy?=
 =?us-ascii?Q?ot0tGXsMpLCpDQLthPhT1AZCAjQG/jzOJSLSI0aVdewf7e+xWf7Hgo0gMqU7?=
 =?us-ascii?Q?qhxuWF3OK0Zq5zrpQw9l75AcdQREdKr+IUKTPFdUtvA2Q8pXEDE2hMgEHB4w?=
 =?us-ascii?Q?VT2eU+bLUvr1P45aREpPSK06+3XCEDj3/jWLVp4Elv+asK5+3rt0oJ15f2Jq?=
 =?us-ascii?Q?T2pMQuAboieyEH4tDjlaXxPZ+TeGGkfnY0zGBRujHhMywOvLcGERamk8e/hH?=
 =?us-ascii?Q?kxOmaVPgaizli2kEmOdYMTmUv+dCeRfjBYxHXCSmmaivh6bNv4WqPQ7ZiLQr?=
 =?us-ascii?Q?CX6DPgA6Vb3EMFaLpyEjOW3zZJigWvV67koO262U/b/pM/4wSYanWzgTw37p?=
 =?us-ascii?Q?YJS4ecM1cv+n+1EP9YwnIB5P8i7bxUIg5A/ScSFCt3y6Y7oZenheYX3h/9Qo?=
 =?us-ascii?Q?LnBfu68HiFYIwksfVBHQDdRt+ih+QK32T6039h0aZwuSGS21doffnJtdIcxN?=
 =?us-ascii?Q?0vSGuEQRI9QPXJN3BF+BZR6T3mqLi80IKoD6hbZrKafiPtVQIscAnqfkKQ60?=
 =?us-ascii?Q?Tw6Fs42TgDCukbUlrj33k7ADKbFuMxHZHgi/8XEm/c+yPCF/i8W/ySe1Obg9?=
 =?us-ascii?Q?fbLpbDGb+VWq3W1T60DNpMaJDl9gLvJo9CY7+QazOoH6e1JJeVpi7Tt/WTa8?=
 =?us-ascii?Q?W84TrhE0fibDzi82WKA8T6jWv/gc6wINhpSFctMS8YjMDTNuUS9XITiWGGdT?=
 =?us-ascii?Q?073BP1sXUqOzRS4oRyl+FYqi5b96+m3ZuPQ4v2pzE3Btp3Cuw0ZCci/0r8BP?=
 =?us-ascii?Q?CmxNH4JjG6ifj+Uj3bL5jvCTdKer/jZ9buinHdKounrKTSRZU6uf2JXMukm2?=
 =?us-ascii?Q?Au1Vofx1qX9ck32NuBAOW2eNkvNLd26zmt3Gss0w2kjZQ3ftzzTnZNB43ZSa?=
 =?us-ascii?Q?+aWBe0j6CCV7DCVvHMourwe760KcjkimM1CxCmxs8RRw7u7IRmOaNPE/ZBl4?=
 =?us-ascii?Q?JBbJHPaofK4JNbnVFHS/OdRMT0t5RJePx5QT7rTSFAQ4QwAouWXJ72G3aheX?=
 =?us-ascii?Q?7anGAgvn0VRvgs408+vPy3dc2z6pKloyX93yHjzypZLs/QFWcTKMzY9oar7I?=
 =?us-ascii?Q?anOivahjubxcERkkoo17GPAiSDuTS+8c/NgJ9VhLePCehIL2jDc6jVhCB7xp?=
 =?us-ascii?Q?nRfcYfJoWQJxZlA0dwfpcA4nO6TVoLnUKA0NAPVU2+qhmIZpE5qMyGV2kGmR?=
 =?us-ascii?Q?3d+FcBs2PLmDQV9kB/ezIUdiiKLCaqhvqQYL9cL6gPxImaLWSssHx6hK3Y8H?=
 =?us-ascii?Q?IBxkPszjg04=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?onLkwkEgc6hV7mg+JrOSOQbeA49o5LC333fL0ugUk33wKeLqESiitBonglwe?=
 =?us-ascii?Q?3MjGaGeUaG3Q9cjL42VABZwlAAKewtUiuxQAFey7swkRN2+eSAjm0ecafjKa?=
 =?us-ascii?Q?Idupz6m8z17CqtJEPK88bipxs7KNOLv4c2qTyKAUcMsUBXPyaQttRGCxMnVE?=
 =?us-ascii?Q?LCpL/f7V14MW703iSdwQr7ePsuUg+Jhtk9ietkilSqlRQk9cyNd/nQVauQBG?=
 =?us-ascii?Q?wscZu92hEF6LwnAE0rF6h2OYtSDMrbhZg/ieYDbJAVQMQObyZjkwH55qFusy?=
 =?us-ascii?Q?rsoZpAjcBAXAUXAUB+nMtTtIHG+8Hu/wgRVIVcIS3GDYyaGl0/W6JO4+DxjI?=
 =?us-ascii?Q?6SXYcqbzevn7oUp8xMMWhliZkGPGyCEy8b19sB7nSu/ehDMjM6leGXleJ10F?=
 =?us-ascii?Q?9xs0d3zSms9o+VnpPtoGl21Wxy30bQGwem1AS5hCAb1pmiyZSSIy2nstrVnk?=
 =?us-ascii?Q?2pbHHegWZu2fWo33H9QMJwxV1wP2RoQI6HfBwoGQUb+dR+N5ZyjUWZ03+pqa?=
 =?us-ascii?Q?75bocZp8etyqAOZsfqfwxHqLBZHW2SOYbQa9H/JuzEHEH8LTAdcpBU8Pbv0g?=
 =?us-ascii?Q?hVVs5N+NPQtKe8496bP+fPJXOA2JP4DXqtqjxKLlDUa3rkAI44Vw3q2zV0aV?=
 =?us-ascii?Q?/PxSdt32OMfko+P2BYEOizuVC36t70lrxNsf8+lJ+2GWhNJPkvGuVwWNph/a?=
 =?us-ascii?Q?2HDfTYuKjE03MMlUuS8h4PYgcOnWIuU8qZhxUkGmW9Zs5D395Wt5dHhvNR8K?=
 =?us-ascii?Q?nEr5RuVQ5bmcFZqPMy6SqPZAyFLEZwaq95QyL1nkunfqL6b6eyNQI1ALS+KF?=
 =?us-ascii?Q?MzYKiH7VvzPLLzOIdyS5hHqs48uaCseTJ2m9a4/FnvYJpsaaeBk3qfAUjwWM?=
 =?us-ascii?Q?Q2NxYkdwL8cM9UXfyl7X/DYoKcsBnWi/Wi3O1EphAIT4GldUksWEln+iQarA?=
 =?us-ascii?Q?BU51oizGM306OmVMifmOsizNWYByxQBVqjoR/UVBWguvExr6THWP417N+SXC?=
 =?us-ascii?Q?dxyifcqxbD1oQgr7VwyfWLkFfU9u4V9mmeVe9HtX2n/1+i+M4EegPrp7EA5O?=
 =?us-ascii?Q?WIvgutvgJSOZzRiofcNoEX5Qvo25TRjy62waMnTkkxCCuOeSsn9lsWS1YbvC?=
 =?us-ascii?Q?FN+E1sQ3bhZjXDyYhfbRKlEwxKRyMkx1oDLk7hCANIvx6gi8NzJZFanYlfOd?=
 =?us-ascii?Q?hUYwewRR0OIGtYC2KYqMX+nfa09XF6QVXQuIbSRzGjKaKZOzMJJklMtVveD0?=
 =?us-ascii?Q?FU1IxOBh0DaDd51E9X9NnStjYINsHFeLAkJvnb1nHK5dn4vfa+jKix4LKZV1?=
 =?us-ascii?Q?xVnURCe4a4KjsIeHMmLyhrFfkSHzGC50up38zmHwFcaE11GMVSZ24A1XFOa8?=
 =?us-ascii?Q?VcFIzwgQa4QQ63G+i+/tMzUIAwpSnWjiG9ni7DaZyQaECF4sAY1M31lBihjV?=
 =?us-ascii?Q?rrMB6pgxcSpS3hf2ErYfqP+sQ6APJUro7I2XEVK7mO9nEmVWzIKpffcXObbj?=
 =?us-ascii?Q?C+NJpszJ8ttsi7yL2dwBt9/alo+BL19ut47j4SH/+AjMMAou/9poI8VfUsbm?=
 =?us-ascii?Q?VeQXGKX7MyGGj3QxG95a+BBDtKN7z25HMsGTr++T?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f9aec61-7409-4870-0aa2-08dde82e5242
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2025 01:33:00.3707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CfVepTwRaWBg7VxGlpsaRr4RraRJp2U0jIeoBuOaKGqWnf3WZvOyXaWpXErBMMkp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF3C36BFCB5

On 29 Aug 2025, at 22:31, Wei Yang wrote:

> The check of is_backed_by_folio() is done on each page.
>
> Directly move pointer to next page instead of increase one and check if=

> it is page size aligned.
>
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> ---
>  tools/testing/selftests/mm/split_huge_page_test.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/=
testing/selftests/mm/split_huge_page_test.c
> index 10ae65ea032f..7f7016ba4054 100644
> --- a/tools/testing/selftests/mm/split_huge_page_test.c
> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
> @@ -423,9 +423,8 @@ static void split_pte_mapped_thp(void)
>
>  	/* smap does not show THPs after mremap, use kpageflags instead */
>  	thp_size =3D 0;
> -	for (i =3D 0; i < pagesize * 4; i++)
> -		if (i % pagesize =3D=3D 0 &&
> -		    is_backed_by_folio(&pte_mapped[i], pmd_order, pagemap_fd, kpagef=
lags_fd))
> +	for (i =3D 0; i < pagesize * 4; i +=3D pagesize)
> +		if (is_backed_by_folio(&pte_mapped[i], pmd_order, pagemap_fd, kpagef=
lags_fd))
>  			thp_size++;
>
>  	if (thp_size !=3D 4)

It might be better to add

if (pte_mapped[i] !=3D (char)i)
	ksft_exit_fail_msg("%ld byte corrupted\n", i);

instead to make sure mremap() does not change pte_mapped[] values.

--
Best Regards,
Yan, Zi

