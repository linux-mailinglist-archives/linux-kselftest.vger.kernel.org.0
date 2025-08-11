Return-Path: <linux-kselftest+bounces-38704-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BB3B214C7
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 20:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B1894606B5
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 18:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFD422D785;
	Mon, 11 Aug 2025 18:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PLRFESk9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2087.outbound.protection.outlook.com [40.107.95.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A972E2851
	for <linux-kselftest@vger.kernel.org>; Mon, 11 Aug 2025 18:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754937736; cv=fail; b=IEGAoLHRIoJ98H5KcyDwyk/i2ecc4LLXqXn6GlDaLR/+9L0HGq+OpzqjvZ6Iu9ejRCt/q70HuHFavt0nOddXChhpCFLMj2B78AonVb8ca03E5DIXopFacpZBdLtVuIqpOoaCAJXXPZT8RWLoW2Oo9UVwbYVaI1Oa0SJ+8c6vg98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754937736; c=relaxed/simple;
	bh=wMU2AIbxsliOIh/Ogn/tLIUO2UZxNt9Uw+HRYVwVq5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=siQKnp16yf1vdvwigXYPCSZhlDvVXbNybvx/nAa8yxdR+6P5zctD6djp5W2wCoGak5OnFHKzo7f6/SZ9oeFEqRQskyzMYaNF2ap3U4xtTVzqYP4TCeP5ZZfPQSgLtOAjnRTV96EXHAnvUm5pZOS3taiWCRTguOwDlkdOWZ1Tujc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PLRFESk9; arc=fail smtp.client-ip=40.107.95.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YjcqAcOBn50MPqkMg0xDtF4CWNrNFc7/ETTGV5P9FnkzjnWriJYKkrA6GESggRFnY2Dvyfp6T8HcJWy8IUMHcyzN6TXe35aQjSA027U/aDn/SJtG0pPsqpXwEMc4GC62/RcURncbScwHPertUfIH12jSN5ywvm+J0AILIlpetknL2o8af28IA+MJClK5g72YUNHiU0+ULJN8sjQIBiF2TlvdaJww/GZ9MLb1FrTnY9pYui1jJAF23Jkj7wPsMSGJLFRpBjVTJ++cZGq+lMT2miR5OJo9SLYbqq60h78Dky0wCgvRUpw7ecugnJCsdxf/f+Io+BEUTc3QHqHMeXKpLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DMXW0HErv3tMiPB1T3MHcB4RBN5WzZO97u5HZU37laY=;
 b=Mikniq7Y0ojf6e27W8IvwyxG7Q/YvRmBGZAZpVE5Nfp3pL8ucn+CT2C9B/xoh1BvJ6PDkkZbLG/y1uiCRSqLWVF9Vt/MnoPQ/yGx4P0VyVYDO5T8stS//zl/PmAo11cHzx1YxMYegrNk9UFaDJVspiozgLPOD7K//WNnEak5dXol6/a+wEd/q94j0eam6juu/8nsfQYIQyWJJtpKS7wA07sQ9UtawxorClqkO6VgWvF+WRTIbFSKX2KPOtH7UW6c5lusrqULQ77nWaJhUhikS38r8ZxHhEawdLKdXunkBzdIr66KXZgE9pcVcGarfXNpJe4l1NiQkEV60N+sHMb4BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMXW0HErv3tMiPB1T3MHcB4RBN5WzZO97u5HZU37laY=;
 b=PLRFESk9AxfVO/WVrB32XVkajlf2XqumDgkEy4qWOyNDn+Q0yN3VnfIz25bUOeBtJmHlKfZNTpO1AuVBb5TXPThjQj0+EQoPCLPHioxXRqpfYBymca666/CgHmXl4JMVMgfxSD59rKJTi0JpKD+jyN7iTIkdMW9vuSocc0fAgQ+GNtWyQM105bV+D5v/lkeXoI+OXyGNOoFkCJlMtLJdnPfLRGU2tqNA+jKGEVh6o2QF25+8AdSoRcqpRJuIH44lRcuXY/xALV4SG1PvgLqZoxy87Ufqi+RDV/v7+SF1xF6OKq2duexRqer3OAp6rLG6G2dSIhwtAdN73IKrbcPHQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA1PR12MB7759.namprd12.prod.outlook.com (2603:10b6:208:420::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Mon, 11 Aug
 2025 18:42:11 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9009.017; Mon, 11 Aug 2025
 18:42:11 +0000
From: Zi Yan <ziy@nvidia.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Donet Tom <donettom@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Dev Jain <dev.jain@arm.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: Re: [Patch v2] selftests/mm: do check_huge_anon() with a number been
 passed in
Date: Mon, 11 Aug 2025 14:42:08 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <F08C69B5-9906-4FD9-899F-5CE6E725ACAC@nvidia.com>
In-Reply-To: <20250809194209.30484-1-richard.weiyang@gmail.com>
References: <20250809194209.30484-1-richard.weiyang@gmail.com>
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0605.namprd03.prod.outlook.com
 (2603:10b6:408:106::10) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA1PR12MB7759:EE_
X-MS-Office365-Filtering-Correlation-Id: 675a32a7-ad97-4515-275e-08ddd906c84e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Vw9EEUGSraNihAvUST2zQdBrDPCnp/Z4L79E6c8CumAJ5C2k7U1BYOzzes3s?=
 =?us-ascii?Q?EmBxAlYlUvwnCu1Xsj5bPxhbJYHKZTSIgndURgs9DEpaEULTuAZ24FPKl3YE?=
 =?us-ascii?Q?u6wPjJCMAoVw6U4g5IEj1h4u7bj1UcnE9oKSnmNNA09TpTAgXS43bXHqLxRi?=
 =?us-ascii?Q?4Gx3PXTB0xAkvRM2S6zbCDzh1SyTfqOpnWo+Mkpysmjhx7GAECMKkXhIARKw?=
 =?us-ascii?Q?4Mxq0WfBqhbS0hJK4cwEsywmaFMw6G6iPe5/MFBpP++xo13kZcseTePzgTEk?=
 =?us-ascii?Q?2jIZU9qIR5T25gPKLfoc+WnR/mP73drNVAz6N3We+OSm+IrSYdMmASsst7oU?=
 =?us-ascii?Q?281WUY28n3/TzNYCTOL+xRw6yJOefnWSnkw6DGee27O9QbGe1eEoOwBsaHTL?=
 =?us-ascii?Q?seksBeCP4Dr+Ea+NYCoSc4CYCJO1ItpvPEZG2EsnxDl62eSnrmkJRQEA6XTE?=
 =?us-ascii?Q?bMP/Y3dziU5QbPBNhig/MKnqyMXaPIdpoh3kxEy/EDOlX5c/aw/5h6RM91zI?=
 =?us-ascii?Q?eL0TFfYN8Da5/aaACeOGzYtsKVQDtuP/Uy8ixbk5zDK6oC4CeNR0lc7aC/Gw?=
 =?us-ascii?Q?/bxoK7OTQ2qytPBE2Xn4+JByQrHVsNYYMVbrTn3nBWnx1uMkfZY/7WtnBsSw?=
 =?us-ascii?Q?zUQ0+DxADL10tipqeoSzEzYetmwKkde83FrqbOMgP72HZ4mfzhZ6fNo4kf9g?=
 =?us-ascii?Q?U5EsByH1cypOveHwZtfhE/pZVCodaAqrI8XYr70OlDL7jA/+aVuO1znxxolV?=
 =?us-ascii?Q?6xCuOIdMapxY17dsiyGl2sJazrxW9JiimCtBW2k8AFLQv/TyNeoLmZY0zYsJ?=
 =?us-ascii?Q?BAByBGtrZmV5EUWL/o2Wn8saDxYINo1Tk4+sjsdM+VzV4F3B6V0kBgq0DXi9?=
 =?us-ascii?Q?yyImGx992h0yrL+2QMWjrd5BKlk8ylJ9YxyiQMqvIjNniYog1ZLbdPzZiwVy?=
 =?us-ascii?Q?qCmLDeqcHbEicxNq5FgsZ/tsqCEIp6gu8g5yg/QLEuc+e3S3BBd+2jmBbKTm?=
 =?us-ascii?Q?XlFcSQQLgy+5awtfj1KOx1jq9NnGqO5c2yYpsqLKHTx/KuecWSmuxgK/3IaZ?=
 =?us-ascii?Q?Wxn2hZ8rswdL8V8IAknY3MYg+AvVkaYpvFka6bn3rZRN0dV4Cj6M9zwhqATV?=
 =?us-ascii?Q?hdIX73mIIYi1455VGCf2wrtFB9rPjieTPyX0Ez9GfcyV19vKHhmgxYgpppqC?=
 =?us-ascii?Q?HjApTeofWS3FifnXb9y8LAhBI3n0ygdIv8/SBy9npcdoHQwftR5avUHSqAUo?=
 =?us-ascii?Q?6fJ0iOFG5q9HD373yNM7abrBNXn6RdV/8C85MdU5pIX00WnNhGZMrGmKfa++?=
 =?us-ascii?Q?BJ1+MlPKvnE0VfPpv4hluSZTtPt05msW8newFLqL/29PD/F1dPaM4H6u8rV7?=
 =?us-ascii?Q?CDiM7Ke3N+aYfbmfWscyClgWpgOAarS7MBIrEIjAI50YDuCJHaHmysX2Yb3/?=
 =?us-ascii?Q?AgV8VxecSSc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qTTAhPQVGvt5or6L/G6+0yi9LWOG32IB/OIPlBqYLGvhQAjobgmPxd7zw2SI?=
 =?us-ascii?Q?itzrLx/o4lycHNjT6g56auzZoLykd46Ak1YYUzM9Vwjyd+5hcGHW4UKJ9d60?=
 =?us-ascii?Q?1mod359TqFKBtk9r6fPWsT46vRWJTg2yxmAlDqp5sWvBeQcCVUr6g9sW7h+7?=
 =?us-ascii?Q?SpfIXX7F/kRGCSkCqURIIMf2wn4JqfDB95yTI5+6ctoFl+AZOz5QBIVRrYB6?=
 =?us-ascii?Q?ahCRXp0nAD4SmysO38Jq5BhxtgkVA+XcbIBjTwGOkDqwR5CUg7YDmmQn0IpV?=
 =?us-ascii?Q?JuAJuxb3GAXgNR0mwK+6kH+F4XkbUJuJ7Dm6JZwJNbQjDE4eaxoYNLwEdTpx?=
 =?us-ascii?Q?dSv+6aHCaYsop6HsQQ584BqlWHM6cny/+f+Y7HT6LN7yXXhDxXjd9kAQzOA2?=
 =?us-ascii?Q?OQlxQun9X4aQu0oDooFwEAibjfOJGXD0niap+Q3PMzALk9XSvia0tlLg13OL?=
 =?us-ascii?Q?9QRxdjiOBf3ziT1lwiczI6P0mHVl1VJlhNHTapZrCZs6Zgm62kIM6QmkIvBD?=
 =?us-ascii?Q?kOLM++AAQeZaO4iwmjk2AOuy5kxP1tdkQfX4Oo4SH9LFSpGS8uTL1ts8dvcg?=
 =?us-ascii?Q?Rzmd0eSefaRqFBfzvgyvHXIyajYUYDt09SfDhZAK5eZXblpKTc5f5Vp0JuFv?=
 =?us-ascii?Q?GsqU017zD4mzKclvrP+W/aZ0Ou0NKe7MO0iI9z5mVL5MEKH5YTFcDfxIo9JB?=
 =?us-ascii?Q?J8yW8IVSBM8vJLSbeEEXoz3gEdcA0BTPzajtjuvZvGLfCUpHKaPpIVrtzfdN?=
 =?us-ascii?Q?iF0aZNXTvXp/nXRBmC7djNXUjP9jlj6QXgLFbbTX78Zms8yRjLuQMSgz3bGm?=
 =?us-ascii?Q?g+9Pz5+i4BPkNTgL/VyXD2U99lahpX43d+Fsd2HUuZx4LqxuE/ssHGoUtY1T?=
 =?us-ascii?Q?M75x7tZ3CQtH+u1b4VabOsAEBit2qjwA7ebRTQNGSBMRAHhWEymt+oNsLaza?=
 =?us-ascii?Q?Yohkv8nAU4CZK7kz4aT7yiczqlhIYOT4mQS8/0vEEQ4SPsgn89Iy7QKF8qA3?=
 =?us-ascii?Q?iognXS5YNfi8cAfLCleBH7t/iFIPcYsJnVCqB10fP7ZVcfjzfENMOAXCdA8d?=
 =?us-ascii?Q?P14OSXGPMMUixvDzsd9KkWgpWtbjEqUrtEKYoD5bms288iWlARUn6nISFiD3?=
 =?us-ascii?Q?yh/5Nr066XH9+h9UVoPoPDa1CkuD6E1zCt69g9Z+bt4ZT7ucuYJSZQ5Qryj7?=
 =?us-ascii?Q?thAe0hMciJ1Ad4d0quMxuMr3NZsEt1cDT8VKwqWa5NhJurQ6P37SzFNX/mHC?=
 =?us-ascii?Q?G0E0DiisJ7zN6LvxbMucYY9ngEEWzb1OT2EmRlL1zHuCJ0wCQPIpTPhamVf5?=
 =?us-ascii?Q?Ge7V0+Ei574NW1ExrgZDpi6R7+el/lVMeUf7SyZ1zZGaYwylmK70jguA286r?=
 =?us-ascii?Q?A8yiQ00h9/noPF5Ik8eI5M7kd+BsDB57xGLdHhTiooWC/V0wGTVVUeQ1hxOj?=
 =?us-ascii?Q?Vs+uO0cfffcfUDYMAXDrJUUmA5r1s9aYRGaV2c1z8ME8sNM3LfPw+uzswRSE?=
 =?us-ascii?Q?rAvKRo7ozvRPkRxGxaJADprZCFCevhK8FrjQmBvMwI1GR02OsD5NPvcyhl5u?=
 =?us-ascii?Q?pldCU4NMoi6EEbA/tO8cjVXezlHx0LtUy3cSw4NN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 675a32a7-ad97-4515-275e-08ddd906c84e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 18:42:11.1207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HI3SXont/8aspXaFJaamdgtWxD+apSUstsEjOO1IuAUZsmds1w6U0MgYBpQqvXMB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7759

On 9 Aug 2025, at 15:42, Wei Yang wrote:

> Currently it hard codes the number of hugepage to check for
> check_huge_anon(), but it would be more reasonable to do the check based
> on a number passed in.
>
> Pass in the hugepage number and do the check based on it.
>
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Donet Tom <donettom@linux.ibm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Zi Yan <ziy@nvidia.com>
>
> ---
> v2:
>   * use mm-new
>   * add back nr_hpages which is removed by an early commit
>   * adjust the change log a little
>   * drop RB and resend
> ---
>  tools/testing/selftests/mm/split_huge_page_test.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>

LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

