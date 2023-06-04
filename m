Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6818721495
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Jun 2023 06:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjFDE2A (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 4 Jun 2023 00:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjFDE17 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 4 Jun 2023 00:27:59 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CADB1;
        Sat,  3 Jun 2023 21:27:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+Wd1Q/Geq7aVFU2mph4HOWmeT/f9yLiYkfQ85tA0a4DWSVXbEkkbYiZoilzHNA87qQcIc1HgsKZTJC3bGh3Nh4EOzaNWyC2KbCjmuLXP78uyHLyf5GdW+OLyKq477C3LMpcI2cp/+7HClx0TrEu9EfRPkqJqCQot5j4W66Ki8M/bdpblbiEASG2T346mzoPGBqJZJvAnFhh101XFtCBlXCI+d5622FxAk5mixvFti3SONFOmIDzwIxi4YMysIKm/+2LRQejKb42OPBybZ2WAMyzSMPAqs5tGe61mc9hTqsx69StHnWo8wkcq2WDz/40orZltAyaGovQHfO/cZvipw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ccFl7K0bbPJ2q4pSFM0GKsItEyjpZ80/Rzs2aEzC96A=;
 b=NrjhbPeX6jiEihg0IbBR8a7Pw3Q6S+WN9pQ1au8oi4he77bv0bNi/zimIJQQW87uFzRyJ5+QHTlEVetXyf7y9mRFhPbp4nMZQCb5dcuPxs2bTTTo84D0Mhwvk3vfaCgr7E21e2CyhIx8euWPYMfXviYsmW2usmiAubeqqyRyuDdzK/IkjXlUZvyVkq0qhWplp5JukuxEXVYNPuo/1uppwF/kkv/LHSdXvWxhG34vdPX89F9FiGzviRDH6bWefgrQRQqPsHJ+mLFyTI4OCfrnE+TigIlUmSBtftyIn/zTEVFwRYocXz+zcDI4bJZA6xc0uWLvMgtpNkX4wuZbPSSbAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccFl7K0bbPJ2q4pSFM0GKsItEyjpZ80/Rzs2aEzC96A=;
 b=K/QhVUedViYgEXCIAd0p0Eaa7RjweEipgxyW4FU3b4UfeZa7nhH6C9SHqWqOEVJrmOKvkojNeaLeaM3CcfSSD6SwdSykJCuagxSTX+TvZJ5BDWHWQFNloODCbQGi4ey6RnO5i/6OjLzDd6+lWpTyizIZBOR8vHVMeytApTo0D4ZjR9OgmAr89Oec78lLP6Q8TcHKUaFUS9DZ2lbA4pfL6bnUuXL25fZbdljxs+BgCxO7o6LQih6ZA5+r4TT2avmdy1veVF8l2bb7UfbSNdtrvFqUTKCDxjdutFbS2NcTPP7I9eNF45e0IUoCzqDOpUd6bNbqSENDzcyLuOVT8PN8+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by CY5PR12MB6057.namprd12.prod.outlook.com (2603:10b6:930:2e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28; Sun, 4 Jun
 2023 04:27:50 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::e01a:d41e:80b4:7cef]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::e01a:d41e:80b4:7cef%7]) with mapi id 15.20.6455.030; Sun, 4 Jun 2023
 04:27:50 +0000
Message-ID: <d899bc01-1fa8-02b2-5309-18c092fd4760@nvidia.com>
Date:   Sat, 3 Jun 2023 21:27:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 08/11] selftests/mm: fix uffd-unit-tests.c build
 failure due to missing MADV_COLLAPSE
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
References: <20230603021558.95299-1-jhubbard@nvidia.com>
 <20230603021558.95299-9-jhubbard@nvidia.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20230603021558.95299-9-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0180.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::35) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|CY5PR12MB6057:EE_
X-MS-Office365-Filtering-Correlation-Id: 08e95790-53f9-45e7-2e4c-08db64b40e88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wkiFFkTbhQph9zQ/KDFIaHq8wmbOtk4T9UrMLrAbbQYC8RWw3LhRZivuGY9ZuUdUKscT75O8GGUUoas0MwhuVYBoUYPfFXCoeBhIof3804YfTW0Hb+EDx6zWZhL06eVMJG8bUVjoo2fU4irw4ZmkY/0GKHOSdJ1CcGBqoG1M8l8tjgY5eZei740hjPVwvgqbC1XofJ54KrAIKEhmLYyJkswrMK+t7gzSSKXpV21lyAu8RbaHHKvElrd3zZ1GBQ4j2wfxxetAgH0sfY/pK4dI7Clj75pMpf0ETU4Ctly4sZ5qsQIw8yAEpamh6UyHrd46SaTapIE2t4zWh2RGJy5xbJyL/0eHnY+6l6YMaFBf5S6yvlDtmAp7bbVF7CotaQ1UrP6w/ZhOwPdq4OH0kYQJMoKa7jU3ZX9EtQbRSIy+5ynT3PfOB+kuUkvUuzp4Y32q5XCOUZ+Dl4RVJGIq6qEbBDDmidMyRC8Xl2gg61Y6ajowZgYFjjlfX6jolI7IR07QpnwecOMXNhUKs5z7UB5PxolXWSZwPCpGu9sK8b/sK3cU5X4N0V/V0qANzDvj+kaAQ1B3FfKjXfutDy/x8arb1LACSI41QKTRtOjTvZqpSdCZWOULOTCntsEXTEwe1kfzNxo1Z9fCN8tltrJM0Kh6Hw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(346002)(136003)(376002)(451199021)(2616005)(66476007)(66946007)(66556008)(53546011)(6486002)(6506007)(6512007)(36756003)(86362001)(26005)(478600001)(31696002)(54906003)(186003)(83380400001)(38100700002)(41300700001)(316002)(31686004)(5660300002)(8676002)(8936002)(4326008)(6916009)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlVFcXcrdVZTQ0IrWm4wWGdNSHNKTEdtYmRscTdSalJyNFlveWhTT3dWKzhD?=
 =?utf-8?B?czBqRUM2azJhbnhaSldCK1NQT0VJT3A3cGxONkxmMFdnTnVIN0hzcW50Q2NW?=
 =?utf-8?B?N1VZZE5pNmZoU1Vaengvd3lrd09Ud2hWYmlRZmZPNFJ0SGU3c3dwK01NbUdV?=
 =?utf-8?B?OW02STEwT1hvaFVlOHNQMGU1R0pDdnRYbU5JMkRtVisveHp2cnhBWks4RjA3?=
 =?utf-8?B?N3ZnU2kwSlkxNDJ0Y3dIdWczU054dDBuZ0lBZytWeXJSSXdDcDBMd05uV3FV?=
 =?utf-8?B?ZFJpUll0UEhaQkU1OHEzZk1FYkNGV2dMMmk5aTV4UWJWbkVUM2JZRVRTeFdn?=
 =?utf-8?B?TXRBbUIwekZpck9GbUE2M1ZNSEZsT2dtZXZHSlYwZlpBU1AxS2JuVVB2S3Za?=
 =?utf-8?B?cXJsN01HaWJ3am1HenVJZkV1RHp4bjQ1Rzg1RDN2Vm1xenNNbEVESlIra2I1?=
 =?utf-8?B?TWNUeE9tOWhFcURScE1IYVZTdklnMFcvbnR6S21WRENPTDVQbHhlSWU1Nmxa?=
 =?utf-8?B?T0thaDBLMjAxaVl3b3B5eFJ0cmswN1JtZTBTRTZKQ09GU29RUk1wLzRzallP?=
 =?utf-8?B?cmUveVRLaUN2QzlvcFE4ankyM3p2T0NDeXRld0I2SytxSCswME5WSVVrMzhI?=
 =?utf-8?B?WEoyeW8zbHY1dTF4dTNiQjlSQjFaNUhxTUErSVJSVTE1a1ZrQm1MamJVaEpV?=
 =?utf-8?B?NVZEQmdjVzRZZ1NYUnpPbFJaZDBTZDZnR2NEK1F1bGlvT2FuWUwrTWFnSTdD?=
 =?utf-8?B?ekdyN290aGxrcy84ZHBoQlZkV3R2aHZNYkZ6VUwwMUlKSFljcUZtNThMVzk3?=
 =?utf-8?B?SU1nUnBZU08wSTFXdFVSb2lGUTF6VjVnVlB5ellVU0RlNmhyNmxOQk8zbVpn?=
 =?utf-8?B?U21FYVVlUm03bUZMQUNTdEd5ZkxJb0tTK0EwaXdZRWJyM2hYeWdlbkZnTmo5?=
 =?utf-8?B?dlhyNU85MUZNdjJBUk5qUkJTTllJS2k0cStxY0xKcU1rMTYya1hsYW4vdnVv?=
 =?utf-8?B?NTBabjJ4c2xhN3NUUGd3OVJvSWZ0RmJaSGJiMUdSNzh1UUtyeHNyaDcrS3hr?=
 =?utf-8?B?TVlYZmZOeFpnaEY4YU1GbXNVYjRFb0I1aHdmZUxubURnaWp3NzhUQUFKcnNQ?=
 =?utf-8?B?TTNKNE9SYUVwQWxKdm84enpLZzJtMXhPUkNraUJQUHFlSlNmclQwQ21PeFVX?=
 =?utf-8?B?SWtaazl4MmNaSFdtV0M3RS9mL0xoejVpblpZKytVaTh6bXpOQTFYSnl1TFM0?=
 =?utf-8?B?YjdSQ1o5ZXJ2RXVuTjFSVk1qdWM3MzgrekJONlROVkxLUldSZS9iRFZ3cWhp?=
 =?utf-8?B?dERzZTRrSWl4M2hNSmxIbEoyOXZyV2RtSUI0Qnd2WURWWktHQlZZdW1hdnR0?=
 =?utf-8?B?WWx3UVRzL0Q2K3Z2K1BFMTM0K3RzNVp4VnQwTGZxWndKdGlLYXMrcE1iUElS?=
 =?utf-8?B?cjNobzRoZkdwaFhwT3RhakFneXEvZWVDS09jMDZhdm03NnpjMmZtdndYWS9E?=
 =?utf-8?B?Z3Ryc3pjTHJERFBWSDM1QWxueERkOGpSQWdRKzlwbEEyMWhjMW00N1dVeVps?=
 =?utf-8?B?RGJWeWFqdnJvMGgyYkRQVDdNSkNXYXB3WUVjRXRPMmYreGFEZ3krMFRwRDd5?=
 =?utf-8?B?aUVSTklNd3hSYSs5K25yQk4xYWZTa2Y3eGxLRFQvbjBZRENNVEp1N2dFNjhz?=
 =?utf-8?B?QXA2d1kwWE92WHdvS21CWGgzaHhzdTNWU3NYdmpSK0hLUEwyN2Q5aGt3UTZK?=
 =?utf-8?B?YkR2cnZOZmd2RzM4V1pkNUh3dUlvWnoxcTVoOWc0QUwxcWN6LzdFTEF5cXUy?=
 =?utf-8?B?RlRFV3Vzd05HYjhObkNGcllkeEZlbldjSVFWaDhSQmg3bkFHNVl6WEowKzJx?=
 =?utf-8?B?OHdkTzFlVXUxN1IyNC9rUmlQeERYUGhtV2dwK21Xc0pBelB0N0xTQ2FHUFQw?=
 =?utf-8?B?UlUreldKSjMvL1ZMRzNnYzExSml0RUFUa0tsdjJPQTVJUDZsektuaURKbWhS?=
 =?utf-8?B?aVdkRksrUUtZVzVKYU9GYVhBdEJ3Z0RzaitrSU5CamJNMGluMTBCbk1raDZh?=
 =?utf-8?B?SUlrRW90QmkyOGJraVl3S1grVXltblYxUWRzdWwyTEFSRDVOMmRsSmlvTm8r?=
 =?utf-8?Q?OfGRIrhxA3xktLQ0dC9oT1jWd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08e95790-53f9-45e7-2e4c-08db64b40e88
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2023 04:27:50.5948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QQ20/0g1BxDL4/dxzU9264mUpZ2KNVzxgaYH6qOEn1XtU3OvbAcpvcd3KYpJAjQPf5Ky8DbxZ7CBWZ3ADLeyYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6057
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Correction: due to refactoring things a bit in v2, this patch's subject line is
no longer accurate. It should be changed to:

[PATCH v2 08/11] selftests/mm: fix build failures due to missing MADV_COLLAPSE

thanks,
-- 
John Hubbard
NVIDIA

On 6/2/23 19:15, John Hubbard wrote:
> MADV_PAGEOUT, MADV_POPULATE_READ, MADV_COLLAPSE are conditionally
> defined as necessary. However, that was being done in .c files, and a
> new build failure came up that would have been automatically avoided had
> these been in a common header file.
> 
> So consolidate and move them all to vm_util.h, which fixes the build
> failure.
> 
> An alternative approach from Muhammad Usama Anjum was: rely on "make
> headers" being required, and include asm-generic/mman-common.h. This
> works in the sense that it builds, but it still generates warnings about
> duplicate MADV_* symbols, and the goal here is to get a fully clean (no
> warnings) build here.
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  tools/testing/selftests/mm/cow.c        |  7 -------
>  tools/testing/selftests/mm/khugepaged.c | 10 ----------
>  tools/testing/selftests/mm/vm_util.h    | 10 ++++++++++
>  3 files changed, 10 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
> index dc9d6fe86028..8882b05ec9c8 100644
> --- a/tools/testing/selftests/mm/cow.c
> +++ b/tools/testing/selftests/mm/cow.c
> @@ -30,13 +30,6 @@
>  #include "../kselftest.h"
>  #include "vm_util.h"
>  
> -#ifndef MADV_PAGEOUT
> -#define MADV_PAGEOUT 21
> -#endif
> -#ifndef MADV_COLLAPSE
> -#define MADV_COLLAPSE 25
> -#endif
> -
>  static size_t pagesize;
>  static int pagemap_fd;
>  static size_t thpsize;
> diff --git a/tools/testing/selftests/mm/khugepaged.c b/tools/testing/selftests/mm/khugepaged.c
> index 97adc0f34f9c..e88ee039d0eb 100644
> --- a/tools/testing/selftests/mm/khugepaged.c
> +++ b/tools/testing/selftests/mm/khugepaged.c
> @@ -22,16 +22,6 @@
>  
>  #include "vm_util.h"
>  
> -#ifndef MADV_PAGEOUT
> -#define MADV_PAGEOUT 21
> -#endif
> -#ifndef MADV_POPULATE_READ
> -#define MADV_POPULATE_READ 22
> -#endif
> -#ifndef MADV_COLLAPSE
> -#define MADV_COLLAPSE 25
> -#endif
> -
>  #define BASE_ADDR ((void *)(1UL << 30))
>  static unsigned long hpage_pmd_size;
>  static unsigned long page_size;
> diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
> index b950bd16083a..07f39ed2efba 100644
> --- a/tools/testing/selftests/mm/vm_util.h
> +++ b/tools/testing/selftests/mm/vm_util.h
> @@ -63,3 +63,13 @@ int uffd_register_with_ioctls(int uffd, void *addr, uint64_t len,
>  
>  #define PAGEMAP_PRESENT(ent)	(((ent) & (1ull << 63)) != 0)
>  #define PAGEMAP_PFN(ent)	((ent) & ((1ull << 55) - 1))
> +
> +#ifndef MADV_PAGEOUT
> +#define MADV_PAGEOUT 21
> +#endif
> +#ifndef MADV_POPULATE_READ
> +#define MADV_POPULATE_READ 22
> +#endif
> +#ifndef MADV_COLLAPSE
> +#define MADV_COLLAPSE 25
> +#endif


