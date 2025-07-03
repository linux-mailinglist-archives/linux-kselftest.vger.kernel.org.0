Return-Path: <linux-kselftest+bounces-36441-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B44AF7789
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 16:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEF7F58086F
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 14:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAABF2EBDF5;
	Thu,  3 Jul 2025 14:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oxVIx4hq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2044.outbound.protection.outlook.com [40.107.102.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDDF2EAD16;
	Thu,  3 Jul 2025 14:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751553060; cv=fail; b=cQZU6VT+g/NeXH3rFJKuhcQRgYXrr0IKvZVIrTQgUjShPj5uJRfhVXzUVWATNnRqVmkLa3Ww4zC/A5jerHY3okWkDk84kmozOhNB9c0us+2BIhFOwo4/Tu32Qrxo6Dh9hT/y+76FFHPo0aefTS/d3C49Z5pSjcex9Q/l48gBmG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751553060; c=relaxed/simple;
	bh=OYvXYi1TuI7JxgEkaZMvI13J5Cfo9Dto0+E2bIkdXbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fr9tQOZGxb9grYnyDQRux/6yzj8Bi1dISs3IE63fpuAbe97BUIGIbG5DNeJWu80diFPkMOACvDaBqulrFDKx3rb4zaQamlLon9aiyTbWh+CAbQuyVcPua2OYksrXSzWEOkZJV+MSyHoxhuNiJk9VZxeN9jV4ikXS/Ovj4cCD6Dg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oxVIx4hq; arc=fail smtp.client-ip=40.107.102.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y1GNYZZR33cJ1kRcQB4OQEMUbCnsXOFTUlBR3Rme+5uW2BZncCPhcGyajLXKt/9xnTQgNwmXV/N2teeUFzbfux3KOXC38CGOfatst/pPpVz+UnDwBRdu0ZZmdfuKzTlR1Rv+EoGPvNBBS+gKW0SmSv+953lU3JtdVyT3Rut88tuUyimi/VaQwyvXQ+LsUqsrgBAQKmvQqSUNS5QCRGY9uVOQHXGhxx7eNACPF6adwn9d3X1ViOBPKKxNbm35+786+PW2Zd5zI/EgXvkqk+n5RPeyxE8hCvwQia97RcJuhwpxPV4LfI/STgQjAuXx3YzoiDTcRbgEr+I4aEWK6XafJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3143KGAFRD6CPEo1InfBERGBgx9WYbD4mNIIvS03EI=;
 b=RWZUfnHsYDlRxPpGsIRHAj4kKwJPVGEB66+99t7GkJt4GitwKPIf1UP27FWpbj4Qi5oX9rkNHZuWOiJrsspKCnMVLpHwfqP/FrfmwLagLn5zppjBtamLd2+aebNclbDcJEDMhLHfs/oMRXB8d0iYJLrMuICdvs6vg+KwSqtjqqLlUXrYMJamvPGiNsNRY1zdysaDg31WKxDFBwmRDu6jvUj3Ye6glyM36M87/DYaBOSIqbd8z+ufFrwQGuL++ZSKkkXpsThOAmeCe2ZzNHsBfq4V3dmrkPdeYRc5Hd26+q6QdXAboj973tUPUQwsWduH78jXxmGgGljcFrq3tc8UTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3143KGAFRD6CPEo1InfBERGBgx9WYbD4mNIIvS03EI=;
 b=oxVIx4hqce/2p1TpI9zPHyauwEWiWuBVe1EIKz/8dEXjn+uUu80OHjZIiOGQVBEPB1/gkqd4iUmaBwVpOOo0XUFjdPH4i7yhC4phj0lJHLdGG8u9xRxirRWG9s82wnjmqcph1whBV7rwOEzk0eKlVeg06v/6UfdFivYF4hhuypK7CzxaKNRvoWCLN4QFvkFRd/c3TG6YE8GALTePI4VaIWSnx7M/IhzBL5bJjAA/wF8XLZ7c33t3O2uRTH7HhUv9Rvc7BV7l1hGu1MHv4o0qxhGI2zfVKZHLhoRafD0oQ88aqB4D5bAav3/ta2q8KufjRolUVbBdZiwteiAxZOAJdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA1PR12MB7126.namprd12.prod.outlook.com (2603:10b6:806:2b0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.27; Thu, 3 Jul
 2025 14:30:55 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%4]) with mapi id 15.20.8901.021; Thu, 3 Jul 2025
 14:30:53 +0000
From: Zi Yan <ziy@nvidia.com>
To: Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com,
 lorenzo.stoakes@oracle.com, shuah@kernel.org, pfalcato@suse.de,
 david@redhat.com, baolin.wang@linux.alibaba.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, donettom@linux.ibm.com, ritesh.list@gmail.com
Subject: Re: [PATCH v2 4/7] mm/selftests: Fix split_huge_page_test failure on
 systems with 64KB page size
Date: Thu, 03 Jul 2025 10:30:50 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <9440CBF1-AE4E-4C9F-ABC6-EBCB74316CF8@nvidia.com>
In-Reply-To: <20250703060656.54345-5-aboorvad@linux.ibm.com>
References: <20250703060656.54345-1-aboorvad@linux.ibm.com>
 <20250703060656.54345-5-aboorvad@linux.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1PR13CA0210.namprd13.prod.outlook.com
 (2603:10b6:208:2be::35) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA1PR12MB7126:EE_
X-MS-Office365-Filtering-Correlation-Id: 70300ca4-d081-459f-aa21-08ddba3e3769
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BWM8IqsPT6G97kDuUYt+5IoxcdHu8Ph/TSMkR47dfGc/8smeUHEhcynENnKo?=
 =?us-ascii?Q?MeF9M6uR2Dqj6yQuXUhdtXT1aKhNzp9d8pcQ5roZ6D/FpZMe2+QyMUU3afcc?=
 =?us-ascii?Q?/T0ppoaOFU5Ir1DO0+rDqL7dEQS2K0SUocXuz7Tcn3Qerh15Grc5f2pPDYJ2?=
 =?us-ascii?Q?s5LXydwYLRxPtNyhzTo0tm/2WW+X84bEwf1nzVKLbYXCdpWeW093svJOrZXL?=
 =?us-ascii?Q?BEnN63WzDy0bxecTjdul3vcYSKxegh8zKA8TroVd9mMCTM2uvMyA+Z1S18yh?=
 =?us-ascii?Q?L/CmKACPVI8B5Q4iobqEWEVMDBFp4/OW+zmFXyGdc+QJUsGt+60WJFxvBMq/?=
 =?us-ascii?Q?UrWy3bivZY1yfYls1a4dd77QuhEPVoYqSRhzT1OIBG6ibp62TwEdwZF5MRon?=
 =?us-ascii?Q?EWBOqwzpYOYvhYt24LTSSUpPH4iqYmKUAkmOTVZJ0tf1ji4Sy725QRyr8VO3?=
 =?us-ascii?Q?NabTu7i3dyQKXn0rsAqdG2RFBW/9umtGLAQ0y0oztVw5mALhfVTI9xY2TyEn?=
 =?us-ascii?Q?gZliotNtVT21k3b41J0BoLc0MUZWIfUMHfFIlejaGWNU2F60+EjlfC8l9qgS?=
 =?us-ascii?Q?IG0FYVRd/lf50d6t0UiZ3i7Io4aEuFbKAR5fjcg0pyq78b4V5lMp4wEnODiy?=
 =?us-ascii?Q?SJC+8HfK3zjbRgJvwaXW2fDqlL9KNowJUhPuCJpw0km/g2ZwFi/Ayd0EHceH?=
 =?us-ascii?Q?v/g7edjcwSG9hUWC/t4axmgZmEhC8QkmUp5TUgtgOdK0tLAtNvbbMZJ85fDr?=
 =?us-ascii?Q?LkROvFKu+4DS0JvdinSii88DrNAgQgoVMAcFw137bZiE2BIXxi3/WZZqk20s?=
 =?us-ascii?Q?DjZmfFACX8tOmVG/0EuBrintP91sGgLdO9r2I/mq7O0UzOBQ8xV5P23vbJLz?=
 =?us-ascii?Q?8+39Ojrk8NzjU6yOaNd3bjJQ8+NrEh5/12ImMwZ1CFtm6+ba40Pl7mb1OUVu?=
 =?us-ascii?Q?Y2QIumQE16ADxhocKXgHcSzwpypiHC+JrBZbiZoDKNr3BunEsdrGQzuXwkql?=
 =?us-ascii?Q?OhOpQzpBQXbadq2zgnVEUfi1xTWdDZe3PSXjqZliop9GxFzKaZ+HhjQuRxFd?=
 =?us-ascii?Q?j3SaDyhqb9msC4EVCheIWZAbS1FIncUMkDAOJJdu5gIqNDV8ybFQOu7X5bQ9?=
 =?us-ascii?Q?UXmRjuTOSXsxrUNXhJvv0ZJgmUK3US62bLRbz89Ok7o+KqmpyoZbTV4DDj/f?=
 =?us-ascii?Q?KcRU9Emb1gWg46Ttn7/BnwEe6fq1N87U3ecg2z6ZV6qJMLyyS/BvWAuB14VT?=
 =?us-ascii?Q?upUvh+R4cIxzoXMetpobeC+Se5bE5LfeNVB6M/ElgfE0IQAuZw1e31h/otBd?=
 =?us-ascii?Q?H+6Ip8zcA5OlVo0vWEMKPE53gEMpfyVt1kmjiKa9sZw4isyjHtXjcvbdooDr?=
 =?us-ascii?Q?Ku0ty/IZDIdTG3EiGdQLLwDrX+wWu5CwJYz6lAGglRWE+yxhiL9Jo0L21Hnv?=
 =?us-ascii?Q?YuuI3qva9EY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wugCW/cGYMu8u7W2VItHc2a1xR0bQ1VdpuDqWlyyfLdISz55NKdbVcyZ6X2h?=
 =?us-ascii?Q?JWCioWvAgRDPvMz+8o+lopERlc16D98eKeYGIIz6v6GZJgCb9JbKgaxMkMif?=
 =?us-ascii?Q?ERLv4Xys0p+KuV/n0i1XcVbUFg96XZK/mhWSSMJY5PpJqOL6CUrEVjBO/GKz?=
 =?us-ascii?Q?XnbwG1AxwQZgUm6efIu6U0HSwmx6UrXpA+9oWmOofs+Ma0Fk24eQOn5O3PKF?=
 =?us-ascii?Q?BKnnloU2BYN9HgVuerO7lTjFqC0WAi3dmFaN3ke6rjIaG38pxDgCqhj51xTt?=
 =?us-ascii?Q?rw4zCJSdd3KSKM0ehL8vDblKSFJjrlZYoXkY73Y+uH1cPBrAd5B4w4ZuI2fh?=
 =?us-ascii?Q?hO0UBkizQl+vRfaYqr7d+jEk/lMfB1UjHezJt2KTiSlp6/f2uSyW3Jpi60ML?=
 =?us-ascii?Q?/o0qWdgJUCDKaC7iF0tfEhszVybztMTl8TkVxFme+faD56k9gkONEVkdQer5?=
 =?us-ascii?Q?48G7xCZoVltXNtQnIh3gNe7peg5luY/rTtCjfUqqiAYDhQBCQ9guTLvdPTU+?=
 =?us-ascii?Q?RI6SKLdYbdGGQHzlHncRSw7v0sh19FXTdoem0fS1Rbiqh+FPLMmluMU8jaHL?=
 =?us-ascii?Q?6HJnjlPXKkgVovCJzdfmmhFr5MFaNh71CvlmqSUTDP9fs165jhlbREgZ4ROb?=
 =?us-ascii?Q?8y82D6aEvcUR7LX99UrHQ8fYawYi4IrkNdPIb6OLVIhCkcBzWMTp4OFsO+A2?=
 =?us-ascii?Q?VHfTsKJp9nT9MaKolmN/yJyYjXH1J1cS9HBDEE/BXqvrfyputN6tA5tbBrru?=
 =?us-ascii?Q?1MoK8yG5j+FlHgcU2dwEY2zs2ubjIC/SNLgTounrcm1BC0neVMN+V4ZprHU3?=
 =?us-ascii?Q?AJ/NG36ZFy7uaRpuyAn8ILqeSHTqZdb6f62D2q1552sUxxzhBzesoWT1Vx3v?=
 =?us-ascii?Q?yF/dlPvJF4d0Bee2QpCVLNt8gF8g00lmAlLXDDqzGOgXBWCijY4g/whd/Mfv?=
 =?us-ascii?Q?kyjLAilRNU5usPX1X5RxVVtVNwnGz6Fh5T/+6Q94lLl4beR8iUS4uR3N824a?=
 =?us-ascii?Q?dviJDxia4GFb52sw5p+P3CK0LqtXIB+qhToyKK7k53FAUHp6jjm0+r83+PSU?=
 =?us-ascii?Q?KCwwPjVAb8ISKs8MvA+YssuyOoyM8Ipr5A5wCj6VaAE2S9Yfn4JXeLB5DfAw?=
 =?us-ascii?Q?DAX9kW78C+zSYtFrnh+sl1kjeWvwzZGWYJpzF0zJ8pk3Mgd7FzgFNa9d+XK/?=
 =?us-ascii?Q?lpchIM2WnNlUpfhDlr8pkVJdPq5V7Uucaty+8NRrO1fG7Gs/83eio8HKADGE?=
 =?us-ascii?Q?/rvSjxeOWbX6nitXK98GdyARTUI9WGq9oD8ln8UNLrppPtm2jcpYpQCBq944?=
 =?us-ascii?Q?sS9lCvJKjq8gR6gMrvmrPh8oE1CfE6E+mYxwoijNld83ImPVwEsCkbr4Aew2?=
 =?us-ascii?Q?ntSpCtC0BGkam4l1LgyDg7T3S93upLG419YFrPYMMSrVFw3J0si4LWttNF1J?=
 =?us-ascii?Q?L+mv2dfOwrKGTtV9HNVj5lLppCTPdkk9wFJapSOzzITCfPBWerzNONxXa5/p?=
 =?us-ascii?Q?mhoNG7RmX8QzYRHkTJ1TM2b9y4RJENJPD3Jl4UdTo+CxiKseMUWFuFSvz286?=
 =?us-ascii?Q?FpLcIF/Oa54sFB9gPppl/DZyt/z+ESORJ2Qw8wSs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70300ca4-d081-459f-aa21-08ddba3e3769
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 14:30:53.7724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dTB4xkvewa2Bj0uR74HSFZ7D9DDAcoIvjc3DgBpUi8hQTgQY/sqT0jXACZcRl3D2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7126

On 3 Jul 2025, at 2:06, Aboorva Devarajan wrote:

> From: Donet Tom <donettom@linux.ibm.com>
>
> The split_huge_page_test fails on systems with a 64KB base page size.
> This is because the order of a 2MB huge page is different:
>
> On 64KB systems, the order is 5.
>
> On 4KB systems, it's 9.
>
> The test currently assumes a maximum huge page order of 9, which is onl=
y
> valid for 4KB base page systems. On systems with 64KB pages, attempting=

> to split huge pages beyond their actual order (5) causes the test to fa=
il.
>
> In this patch, we calculate the huge page order based on the system's b=
ase
> page size. With this change, the tests now run successfully on both 64K=
B
> and 4KB page size systems.
>
> Fixes: fa6c02315f745 ("mm: huge_memory: a new debugfs interface for spl=
itting THP tests")
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> ---
>  .../selftests/mm/split_huge_page_test.c       | 23 ++++++++++++++-----=

>  1 file changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/=
testing/selftests/mm/split_huge_page_test.c
> index aa7400ed0e99..38296a758330 100644
> --- a/tools/testing/selftests/mm/split_huge_page_test.c
> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
> @@ -514,6 +514,15 @@ void split_thp_in_pagecache_to_order_at(size_t fd_=
size, const char *fs_loc,
>  	}
>  }
>
> +static unsigned int get_order(unsigned int pages)
> +{
> +	unsigned int order =3D 0;
> +
> +	while ((1U << order) < pages)
> +		order++;
> +	return order;
> +}
> +
>  int main(int argc, char **argv)
>  {
>  	int i;
> @@ -523,6 +532,7 @@ int main(int argc, char **argv)
>  	const char *fs_loc;
>  	bool created_tmp;
>  	int offset;
> +	unsigned int max_order;
>
>  	ksft_print_header();
>
> @@ -534,32 +544,33 @@ int main(int argc, char **argv)
>  	if (argc > 1)
>  		optional_xfs_path =3D argv[1];
>
> -	ksft_set_plan(1+8+1+9+9+8*4+2);
> -
>  	pagesize =3D getpagesize();
>  	pageshift =3D ffs(pagesize) - 1;
>  	pmd_pagesize =3D read_pmd_pagesize();
>  	if (!pmd_pagesize)
>  		ksft_exit_fail_msg("Reading PMD pagesize failed\n");
>
> +	max_order =3D get_order(pmd_pagesize/pagesize);

pmd_pagesize/pagesize is reused below, a tmp variable would be good.

> +	ksft_set_plan(1+(max_order-1)+1+max_order+max_order+(max_order-1)*4+2=
);
> +
>  	fd_size =3D 2 * pmd_pagesize;
>
>  	split_pmd_zero_pages();
>
> -	for (i =3D 0; i < 9; i++)
> +	for (i =3D 0; i < max_order; i++)
>  		if (i !=3D 1)
>  			split_pmd_thp_to_order(i);
>
>  	split_pte_mapped_thp();
> -	for (i =3D 0; i < 9; i++)
> +	for (i =3D 0; i < max_order; i++)
>  		split_file_backed_thp(i);
>
>  	created_tmp =3D prepare_thp_fs(optional_xfs_path, fs_loc_template,
>  			&fs_loc);
> -	for (i =3D 8; i >=3D 0; i--)
> +	for (i =3D (max_order-1); i >=3D 0; i--)
>  		split_thp_in_pagecache_to_order_at(fd_size, fs_loc, i, -1);
>
> -	for (i =3D 0; i < 9; i++)
> +	for (i =3D 0; i < max_order; i++)
>  		for (offset =3D 0;
>  		     offset < pmd_pagesize / pagesize;
>  		     offset +=3D MAX(pmd_pagesize / pagesize / 4, 1 << i))

With the change to get_order() proposed by David and ksft_set_plan()
simplification, Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

