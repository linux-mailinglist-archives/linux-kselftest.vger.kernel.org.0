Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 439205308B0
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 May 2022 07:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354587AbiEWFaA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 May 2022 01:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344163AbiEWF36 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 May 2022 01:29:58 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2071.outbound.protection.outlook.com [40.107.212.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDD61EC58;
        Sun, 22 May 2022 22:29:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhclRcP1da+PtWIHc1ga8DhAia72wEmuSXlpHoq4wHCmzLLPLaCLpoNiJgi5LL1cM67g9NnimELK+cC+wNqPjq1BCiKp1e+2k/9yks3Mcr7EVY+ltKqnRftVaiGpmS1bXuScKVRQahdHfDGTHbDa6IXnL6eFpO8Tpf4ZYKlCV1iK6uVfhNCyA7pxF8UDq7RfsoeIdn13Vf8MPmCS0eh3l1LqZEwCsIhhq00vk+D0l6rZ6fUaGorfwi4+Ks/WildGIAYwvv5DW4iDWvrT4F+DubWyeE2v2yMjVk0tgj9H4/5MHVzeOsLIVnC2+M0OYoU2m53BsPBZ/Fw1pm7YU9xyhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cc7/ps/V4TgS02Nq5GTwUlKjXNaQu+7G64wmW/2yyOo=;
 b=YJuLLbKMKThQEUvGCmxNMMqYAZYWgvph9WlWGjaYr2+TTbNMeOwXzbNHCSAjM5MS1O5VsEqmmKzwfPzGmvziupJicZ186QWK6pVurYZqulXv7lcCs1Vt86fjAqAzzD1iNjuRrTo9kBn7fORtrp9S56xt1O9zg9SNFfyV6NXdgkjxfZpviiuXSF/F0Fp0aSAWi/XHO7xQOuso37C6Zi77otPc9TXa2lpvnu4RTvWcu2MvFZSu/txWKTt9H7wZAUd1NC5HTEn9Xr3uUIIJImYZ3qxNfS9D15jTim8uQugeo0+CSZx2inYX9u8hoWBvZRjJhpAS4nb5Coe3e0pYDReWNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cc7/ps/V4TgS02Nq5GTwUlKjXNaQu+7G64wmW/2yyOo=;
 b=uhWQgHiB3eesKYGFmXO3A5iAiMguE2iHOVGg8EiqWuypKs5xHsvC0rh2fLC+46LglVCXL1VGGIFvZisbsWLe99RVwJvrNcuzEmrf3EZx1hs1mUlsI/hDdo5M1poNWTMo8FrDI4pNAdLMOZQdiaEID94wya1FSR/9Qw1RizfLMAzNCKuO+9hijhlSK13swLj9PvtjK7TT7f1KlcjoguSJ0DngYsedJVdY/X5Vv5GxmbQmwNiB3LqVZdWKnMdf+v1vpJzKxRpg2sTcfHIcEtlnO7HEY/KlHc40lLEHSIRj/rfZu3ndAeF+N/VgOcm57Q5TP7q6FyMp+HF8g2kFincVCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by DS7PR12MB5814.namprd12.prod.outlook.com (2603:10b6:8:76::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.22; Mon, 23 May 2022 05:29:56 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::59cf:d090:5d26:6e7b]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::59cf:d090:5d26:6e7b%5]) with mapi id 15.20.5273.022; Mon, 23 May 2022
 05:29:55 +0000
References: <20220521094313.166505-1-usama.anjum@collabora.com>
User-agent: mu4e 1.6.9; emacs 27.1
From:   Alistair Popple <apopple@nvidia.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, kernel@collabora.com,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: vm: add migration to the .gitignore
Date:   Mon, 23 May 2022 15:28:46 +1000
In-reply-to: <20220521094313.166505-1-usama.anjum@collabora.com>
Message-ID: <871qwkizow.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::36) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e08e9cd7-7a75-4525-2a93-08da3c7d44b2
X-MS-TrafficTypeDiagnostic: DS7PR12MB5814:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB5814E93EBDC0E7D89C26584DDFD49@DS7PR12MB5814.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0DX/wkcbpFrcEI5D9x2GkbZ9Gn9nCZYvNDGKhei31+iVyxQc0djoTht9niUUQH9UVJwnQ+BS7St2U5YPt6KqC/+5dIFT8TIA9qrfWl3bhHvjb5qpjtjJdkvAXmNFiaKTlbySb9UN2nNALnhAbW9sxN0yS5eGKBKPdbUcgGDfArl5i5WEV3Kw6PMMuBxQBY+xkqAW5lwUhTU7jb/l8ne1QGAMe8390CeD2fJJE0T3Tz0mQsCHsWyZIzYR3GHUShNtCxS9Ed46KHCSozQfn9FaxVJxmHpFaw22pSSBY5mJQG5bYWCRknhIdWuENwon6dc/Enku/6AZZcA+HICJvOPRg4Ah1Ud+q6TsHEHhRa/Ggwo0XgefS/wUfXLYMBx0Itaz0HKGa+xPA8+491NV5uRJsMsCCxm1ijb/MqT02G6Cpd97vQuvpv81Yv36yE6Vjt+xZXWGUh2LJ3U8zdYRXDkLD6TE4hEVKFT7zaxv6s4nii6yD+i9+cnN/PFaQLGLcqd9YFM1LELFvpHfNPhTTC1rrUcuPlKVZoeM0Ohcmmt18W0qz5McD+g5acV2q2UkeDkqHtu9SxInGqnzEZIWidahiGh/Y6uREy6lXXQx3/colFylWwmnZ8Z9gnwLyFCdKL0R0orGTSdQrld2hozmXr4jkyxdw4fo2rQcEpJ2rjdTXAJ3k023sjOBhb5uiETgDz2AnywAHFzm82Wbi7Dc9x9rOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(4744005)(5660300002)(38100700002)(6486002)(508600001)(6916009)(54906003)(9686003)(26005)(8936002)(86362001)(6666004)(316002)(6506007)(186003)(66946007)(4326008)(8676002)(83380400001)(66556008)(2906002)(66476007)(142923001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lhmaNUhKqh4mI2w2kMc0o4jEHvdFDJgVqjVQIj+26x8+NfhsxBM3ymIWop2y?=
 =?us-ascii?Q?+yLJUY0q3GbMB4mfyKIjgI6oyM6a9Ic6E9Z9zkJBfgzEBH99iRRXYa1WDDsc?=
 =?us-ascii?Q?f/XE6MP2Cgg7UX/SSFcLo29qjgMVUvE+f40gwT3mVBBA9XMyEns6CkYp+i2D?=
 =?us-ascii?Q?4DB1yVE5uqxxOSnCFtJtazD2SfnfNPbUU0x3o5nH7HNxX/2s/kU21h0AWZmY?=
 =?us-ascii?Q?4/S6yF/KB70dHV1HA5TqUsS6q/QyHajZaVf7nOPrnVVZFIMiqdT3r3MK9w6e?=
 =?us-ascii?Q?Iy89lfxcG8IW2QZhZt0seDUzVRxb4Oln+5d98xsS+BPLoW2+RsINh3AY5KY5?=
 =?us-ascii?Q?Gmwzgy8yh+CXYbQglUGnjuyEzjiziG72w4o5Orpnv646Hq5/b/nMnYFpfqxr?=
 =?us-ascii?Q?YPUW2OAxiwyCQDE2hRrasomKxNyVHcqky2a5M7Pm9pXz1JB1omEeLb92aIT7?=
 =?us-ascii?Q?OKkZquRGR+vjWyblt725taFo2ECRetFd1DG/T54sqbxqe5I5dwWFalid5T48?=
 =?us-ascii?Q?O9DPCVgiBnIG2y5t3a7Lec/98236/Gb0l12iVFYa+D+1s7LhZ86sfOeRFNNH?=
 =?us-ascii?Q?TDYyH8TYRpNlv8Ul5SWwpcfgQH2B/2OJtIDFbSy+iqAxD8BkzQs1KJX+Ceyb?=
 =?us-ascii?Q?StPCuo6HciikK1+pqvxodW2ZuVUoqBg8FJY3WWO+peXY2aaIUacX+P6qlRfe?=
 =?us-ascii?Q?KrMBTJZQmUGS88KBzLwv/6MtacwuzvI9gghHzCTZ6ukcNTPyPmIZmnFQYmvp?=
 =?us-ascii?Q?F33XCSQawIoFju3woxBbli02M+QuEutH3AUlBc0P1S+md0tW/W+5XmkuCnGz?=
 =?us-ascii?Q?5SCxGL07KRORgo71ynzgUhEEykc8hspkPQ+ugpInm4ipBf63b7Ed1PpYZpSp?=
 =?us-ascii?Q?tWri16bnZ1L/rs9NA+05ZTNjRW5ayuiTW9CCanZLjQwRXSvI3QO0iFcbKpZy?=
 =?us-ascii?Q?xPgJamURN+NmCwb57GeJuK8CocoRg1y9X177i/jgWe2h2pfpNwSZ9+rxEOMr?=
 =?us-ascii?Q?vl8r9U+ct/WSrE9VbUZm5Ckc1p1Kfq+SLqMHPKyji0vBKaiN9enciycMGJ/5?=
 =?us-ascii?Q?R9KGeQ/tA+Zd3GDQE0BUNJHnLWzcEziFoWfVr1G4F8pi/9bmhevwtL3xx69z?=
 =?us-ascii?Q?cM166vxD6CH/EehutWkrDl7fQ3AgJ/FioNpT4LQsfVqPCbrFZGzYafzVcbVX?=
 =?us-ascii?Q?2wF8NvtYTgorK3wbno8RbshZUobrY5q1+5wTGGk45D3bOaPXMbgyy5jZ+HvW?=
 =?us-ascii?Q?l3oQMA6xAvXHw8tKG3tXmnftLbkjPRNdN0f7WNkgxuwchbE6eK/SlF/bc47Z?=
 =?us-ascii?Q?B3n1vkhJ0N/TPKtQNNbd3h/z6b9qscsRwukJPp2GilRHsMjCo/MVPJRFcprD?=
 =?us-ascii?Q?Tmu+gue7AebEGAKUiNnCe9gjiCpcFc4aOH8Gm4a+i7/RYkmtV8ugEJuxZanH?=
 =?us-ascii?Q?hvUjzhUl/P16hkrCmNl2Q4d1NfYQcWOC0+3syA7oPrlMS6GcNNzX3fFizr5T?=
 =?us-ascii?Q?l0Nrn6dEId9+Wng2ZhG5zqBdu7lzWQl58DaFPkAdmh6NO0mxz0DImM3DXCq1?=
 =?us-ascii?Q?VMCH4iT7P2Cd7N+NRggT1JTKgiexwGVKLRCOIY7zmjpCR+hHNhQI/1lVt61T?=
 =?us-ascii?Q?6Z+unWPoEe23TJ0EVpqpTUqemqAXhjChkA0Zrk98vOiBCwLE1ASAvdx0bOrP?=
 =?us-ascii?Q?HjG4VMu0LTJXd+BmNLyuMQOGeblUkSlxfEuCfKvV6Ojw5hJ5NcSnhz5l3S5J?=
 =?us-ascii?Q?dP7y4er24w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e08e9cd7-7a75-4525-2a93-08da3c7d44b2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 05:29:55.7763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +YIkYYcNBerHWar/jM3xf+XGhErVJtjZ3BX99xubANgVF0+qIUyfQ6KijuJQ/5B0qXH3kyV1yvMPv6g+pX0PeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5814
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


Oh thanks for catching that!

Reviewed-by: Alistair Popple <apopple@nvidia.com>

Muhammad Usama Anjum <usama.anjum@collabora.com> writes:

> Add newly added migration test object to .gitignore file.
>
> Fixes: 0c2d08728470 ("mm: add selftests for migration entries")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  tools/testing/selftests/vm/.gitignore | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/selftests/vm/.gitignore
> index 6c2ac4208c272..31e5eea2a9b90 100644
> --- a/tools/testing/selftests/vm/.gitignore
> +++ b/tools/testing/selftests/vm/.gitignore
> @@ -9,6 +9,7 @@ map_hugetlb
>  map_populate
>  thuge-gen
>  compaction_test
> +migration
>  mlock2-tests
>  mrelease_test
>  mremap_dontunmap
