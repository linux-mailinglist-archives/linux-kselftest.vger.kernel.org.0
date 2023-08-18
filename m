Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD66C7805B0
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Aug 2023 07:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357278AbjHRFdE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Aug 2023 01:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357238AbjHRFcm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Aug 2023 01:32:42 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F94FC;
        Thu, 17 Aug 2023 22:32:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DVtQeyzQjO3aRmoUKrICTcm5L6B8pA17YkaIxOoaPMuLLptvltzw6zcR6tQVMGgLkcVq2pXq5HQmUySMmIdlHvsZuRWtK9NGtyS8RvFaK5LfA2vCVso92AiGnwaAaipJPCG1lrQi5tfd83zGf7xieXPQpTMUwnBRD0lXioZFGCAX0WoYfPvsw5HNGBDrfUc5/EurN8w6u2vZmwlDhkA4K9dUmAOK7kyhhhb4MIgvLwiAWoDuj53DmQNjN9OORMn4ziJLJ5uUX1ovBvLgBt95El4rwAtei6S2G4+hCI+Pkg2LraRH7ZxmycoH9ZcDk7bUbl5TEvwrzQWRJjecYNYCVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7G7G7qrvWLv9jHCCHdHlvH+1VHbH4qNm4ZV5AvcS0qg=;
 b=FzRQ1duCsq14NR/fOa3NXs7Uzd2hC11aBH4k0x20OvcV63eswyOhBiR21Gh+DGNlhPxeU8plXhecSXKi2q29E10jwv4fnPRplZhqV5HJI0cCTZpAP4lAQ8XDdjD7NAJnYMTQz+tFqmyjL5gHIaWi1yEo9/eOhX2UoDeL7hqDX5sXnyzQ8rJ6olVPJvLsmeY2/V5C+cmM8uYsOaj0zc/YO2/JndvBRIxOVm15/SklQRSHi4METlf7U5qUo8dMAYg3e3trv6RgJTQyHnTAgtPN3Y8vlcwXI/fi3j2Wd/DbsCCk/OdXLmPhSXN3Pr/V5BhvjuxFQ/ZFF6GpAObTtP9Zbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7G7G7qrvWLv9jHCCHdHlvH+1VHbH4qNm4ZV5AvcS0qg=;
 b=S72BXVdHVd/QsM6MHow/tB0bWX4DZt4Olv/I5qms1OYPfngZxRXyUk4+4n5wR/JlWiqnCPVTeEUrlE67Gw2+0sZwFzdkmqmjSAnlghBIiSl44FwS3PpP2ExpiJiKj7xHYu4pBAHWBKW89d/t7G4DhsOSiecQl4jQJZEA1S/AI2k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3589.namprd12.prod.outlook.com (2603:10b6:a03:df::29)
 by DS0PR12MB8561.namprd12.prod.outlook.com (2603:10b6:8:166::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 05:32:39 +0000
Received: from BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::3624:9885:6e0a:5d97]) by BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::3624:9885:6e0a:5d97%6]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 05:32:39 +0000
Message-ID: <02a565a0-9307-7620-7e53-f2630b97f0bd@amd.com>
Date:   Fri, 18 Aug 2023 07:32:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: linux-next: Tree for Aug 17 (DRM_TTM KUNIT tests)
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Karolina Stolarek <karolina.stolarek@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Huang Rui <ray.huang@amd.com>
References: <20230817144729.7d2b1b53@canb.auug.org.au>
 <17065c3f-87bb-c2a9-e8f6-82fecd15b9c7@infradead.org>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <17065c3f-87bb-c2a9-e8f6-82fecd15b9c7@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0230.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::17) To BYAPR12MB3589.namprd12.prod.outlook.com
 (2603:10b6:a03:df::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3589:EE_|DS0PR12MB8561:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d176f4d-c256-4bd4-7dac-08db9fac892d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oU54JQSSc6gRaO/Akbwtd9+/cCxGLnP0XLvQOgCHdI5UHxk2t6FjFljJRsUlSrSqbYJYdhNHWs8OEYolra7sGYn2WvizImP62zeprPSH4HJB7JjrqzhkzrFh06+DGFf9jrNtkf0Y4Fs/GQlK5WVqYdL6wq6srsRRzWJvZOf8df49OLCA2ZqNuM3rnwPWkaJvyr6VS8Fb+uF+pmRSDOyhudnM8aUK6/aa+4RWDuErRacX1HcE7wH89iAfG4jOAKWo92zlU4qX0+5gsLG3P61ftDN7bp9+JcBTKoXFMTDQsP0dJuAoKEWehWOqviHvOjZ0x0blLRCoiqoDqWHi/W+aphfSyxv2YNEDNIYv+O7ldiS6RrDJa/KQXfMdrGHLf6J/J9eEvH27/E4cXC3ojGkZ1gj30WZWHniYPm6y87fE7Vt4p1rqzkxaCgLhNXK56R67+cjd8TJytmuyujMKHNc0bRxT04bO+iIK+zkAAqLFoyA4QhOKicTNPExkMe6e+Z1PPkl4fTz7iGLMBlZHOTv6hd6MVLetNF8olxoeUzyRdKxDVrXwJrnRF/3WEepGdMRjC/6bQ1CEDdr23UaJ0TIGyLp/a0ZaN627GDWnO9TfrrBAh3LM+z0SKzzezdu6cDt0LBvIn7MDjUdjF6Jl7VkLKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3589.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(376002)(366004)(1800799009)(451199024)(186009)(6666004)(6512007)(6506007)(53546011)(6486002)(83380400001)(38100700002)(31696002)(26005)(86362001)(36756003)(2616005)(41300700001)(2906002)(316002)(66556008)(66946007)(66476007)(110136005)(54906003)(5660300002)(8676002)(8936002)(4326008)(31686004)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmJFMHM5SjRWTUpkemtIOWpkK1dhNUpNcTJjZjdYOXpFN2J6MEhFWUEwYmF2?=
 =?utf-8?B?NlVZdnNySlliVGY5andiT3R0UUZId3EyNEdzZmtCQ1JtZFl0MUlVOGQ3R3Mv?=
 =?utf-8?B?eXJwN0d3RjByM1E0bCtCR3VzYTNvL1ptdk15bjg2dlBQckpDeGRxamRNRi9G?=
 =?utf-8?B?enhmaTJSTFpVa2QzSWVZV0dyZ0hBUjVRNk1ZSzJGL2Rua25ZNVM0WjdrSklM?=
 =?utf-8?B?Vk1hVks2L2tZUXBXbDJUMmpuSGZMc2I5RFAxVGRURUU0eXh5UDNKTFdQTlJT?=
 =?utf-8?B?V25WMExhQ1ZvTnNTZWlZa3pDMFpHQVhtcVJ4ZGY0RmxQTlFBL2M1ZHVwSzVX?=
 =?utf-8?B?aGZMeFQxWklPNjkxMG9zeHNSZVYwNWN0bWZvZzlMc1QvQmFVYXBieXY4bHlN?=
 =?utf-8?B?UDh1WExaRVBLdUE2bXhmNVphMFdyb3lRblRvNGw2T09sWXNkVjk5aGx6VXZj?=
 =?utf-8?B?Uzcrd3FDNnArZmkzYjJPaFRkMDN3NlljMnNQYjVWV01ZQmdvdkdjS2NRcmJt?=
 =?utf-8?B?dHMzTk1zeW90YlRPeEdUWllNcEthN0UvaVRhZGxWV3lhWTNDNlNvaGdHRjFH?=
 =?utf-8?B?aG91Y0VwejBlbFNqVEdxMzNORkJhMlY0amI4SHNnOHJDOFg1RGFFSjdrSFdH?=
 =?utf-8?B?MEZDME5NcUNiU3BibDJpc0txYnpaRzdBSEZtWUdrTUU4VDllZmJwS3pjQ3ow?=
 =?utf-8?B?aFJTQ0NWams2ZFpwbkovbXdJV1B2aE9NN1hrWXdKSVpkTVE4NEhWaEYyVW1z?=
 =?utf-8?B?NzFGVUwvMU5JdzJ6bmNMcFlBNTd4a0xBL2N4VjZKMGNyakFUaGJWVkVpYTk2?=
 =?utf-8?B?ZjNuVGxjcExpenJMYTdUNVZlYkNCZW91bHJ4VHZCN0FySVhJblFJU0ZPMmU0?=
 =?utf-8?B?Y2xnek4wTm00V0lLR0pibzdnV0ZROExXTk9TTFk2cXJYOXh3S3lUVk9EUk81?=
 =?utf-8?B?cG1vaUlzZjFoSHVROEtjZDZ5TTkwaUpKWHRlSE1ndWdNdTZtZitXeWh6RXI4?=
 =?utf-8?B?dG1tS1U1MVhzZGJIWWRKdlRodHRsajJBaDQ1SWZXbEVwdXIrODJ4M0VPTCtk?=
 =?utf-8?B?cDVVM1YvQjhaQUlpdjZmbkliN2FHZHJXRUo1NDlIcDlkTGJPLzM3RXBUN2xW?=
 =?utf-8?B?SGNPLzMxYzhzUGcwTWxoaHdFQ1Q1L1RTTEtEL28xbjhkR1F5bDNEeEdzemxj?=
 =?utf-8?B?WjQ4eWNRazhwSktoRWo2dG9IcFM3eEdXMVp6ZVdJUWlJZHBYaDRZa0ljUzRa?=
 =?utf-8?B?SDVGeFJYTlkvMFNyaTBabWw3VkJnOXVzamJzR2xNcWNjZlpwa0RkM254UnBk?=
 =?utf-8?B?VlNZV3hVRlIyQzJpMkQzSXpxbzBkU3NxVVRDWTNDOXpxb3hFQVlKbGd1OExW?=
 =?utf-8?B?ZVlxemVDM0JjRExsNW9hU2w5RDVTZlg5Nkw5VThGNDdhT1NScjB4bkhaZFFK?=
 =?utf-8?B?UmlYZjVwTXJxM252RDJtbk5nc0NJVVpRK1EwalNuTFprSzYxcGk3KzN6azdY?=
 =?utf-8?B?cGJGVUg0L2QzZVlDZ3FDUTErR0ZaU1E4TTVTYi9jZTFmYnl5RUJmVEFTTFVP?=
 =?utf-8?B?cHFoYjR5cWM0YlBpUnJnbjQxZDRKZ2RscWVDU3FjTWFrZ010VllrcmhKVXZK?=
 =?utf-8?B?VGcrbkxXeG0zVzJCUm5SS3czODh2NW0vYUZmdFE2ckh4dzJadnNHbjJBYlRH?=
 =?utf-8?B?aDloVzBoZDhnejhUOHNqR01sWkVMTjA2MklMN2xjRU5FVXBYN05HZkw2ekxT?=
 =?utf-8?B?N0ZiWkVXYVRtSjJvaGd3VExjYnVGV2pzRXQvdUM3ZHI1ZXZsaWlIWDljVkti?=
 =?utf-8?B?RWZVQ3BEbHgwTUJHTTVXUmlqcHc2MjM0aHFuL1JCN1o0c0ZaakpvaWZlQmd0?=
 =?utf-8?B?L1VkTS9TTXBZMGx2OG5wQktFS2RmS0xWYmFMT3BSQlg2R1RXTHdkL0lIa2sr?=
 =?utf-8?B?WFl0Q3Urb3hWMUtvTUlDZXgxblBWeUQ1Wk9hS2pZU3pTTVlyN1JmTEdpeWJw?=
 =?utf-8?B?d0RtNFBWTGNrbUtXektJdTQzS3gxRHh3YjZmQ3c2M2c0Sk9pVzRvV3ZuVjNs?=
 =?utf-8?B?dXZUU0hUUGgrMTJKRmlWSUI3RHIvanIxNHpwYmIra3U1dDFCdnZIL0JiczRF?=
 =?utf-8?Q?7bSnwRul3i1lvwBkgo9v4bzON?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d176f4d-c256-4bd4-7dac-08db9fac892d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3589.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 05:32:39.1155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K2uNR2FrCi0yytM3r7twZcvzJjolivPipqx0esjseItMVGPn6uOK55yupPmP5Grx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8561
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Am 17.08.23 um 20:44 schrieb Randy Dunlap:
>
> On 8/16/23 21:47, Stephen Rothwell wrote:
>> Hi all,
>>
>> Changes since 20230816:
>>
> on risc-v 32-bit:
> when
> # CONFIG_MMU is not set

Patch to fix this is already queued up for the next pull request.

Sorry for the noise,
Christian.

>
>
> WARNING: unmet direct dependencies detected for DRM_TTM
>    Depends on [n]: HAS_IOMEM [=y] && DRM [=y] && MMU [=n]
>    Selected by [y]:
>    - DRM_TTM_KUNIT_TEST [=y] && HAS_IOMEM [=y] && DRM [=y] && KUNIT [=y]
>
> WARNING: unmet direct dependencies detected for DRM_TTM
>    Depends on [n]: HAS_IOMEM [=y] && DRM [=y] && MMU [=n]
>    Selected by [y]:
>    - DRM_TTM_KUNIT_TEST [=y] && HAS_IOMEM [=y] && DRM [=y] && KUNIT [=y]
>
> WARNING: unmet direct dependencies detected for DRM_TTM
>    Depends on [n]: HAS_IOMEM [=y] && DRM [=y] && MMU [=n]
>    Selected by [y]:
>    - DRM_TTM_KUNIT_TEST [=y] && HAS_IOMEM [=y] && DRM [=y] && KUNIT [=y]
>
> /opt/crosstool/gcc-13.1.0-nolibc/riscv32-linux/bin/riscv32-linux-ld: drivers/gpu/drm/ttm/ttm_bo_vm.o: in function `.L31':
> ttm_bo_vm.c:(.text+0x42c): undefined reference to `vmf_insert_pfn_prot'
> /opt/crosstool/gcc-13.1.0-nolibc/riscv32-linux/bin/riscv32-linux-ld: drivers/gpu/drm/ttm/ttm_bo_vm.o: in function `.L104':
> ttm_bo_vm.c:(.text+0xa70): undefined reference to `vmf_insert_pfn_prot'
>
>

