Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289354BBDAA
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Feb 2022 17:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiBRQjc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Feb 2022 11:39:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238004AbiBRQj2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Feb 2022 11:39:28 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988981662F7;
        Fri, 18 Feb 2022 08:39:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5F7le7eREqrop8ZcIdsfsQzhY7lk+0bETgrrau/6FHhd9z3gkO8r3aTmYLbBGRMK+HQe9IipsDOOXKB0kjyh+KlEUNalxDe8UC4R/mnldr6w2vX2TevRfluWYZ5etMmo/nBhdovWjqCLQL/mtfmvw6VsvN10mv4QvjaHDVVonDwj1GUivIdHL5siBaSMcb4ucC4AV816+EBeRFrLS0Y/Xoo9czIohEnkwYKPOh+j3CnkYplcv6IigoTBcvKsvpNQD5Mo391ndQPBqj94gKgtq6gtO7YHIBirLM0JwcWjq9DK2rG0SgJzS1rTBQWpBqkmra4xoGi/ugykyWEiS3zgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U8K4nHhF3MUtPwGga/Rwo8zRVwIJcrjcAIiAlEDOjaQ=;
 b=kseZo0Oxq3FYdxKVdaO7GQhc+9vRVJvsMGoADOufNKXxi9+X7m1MkKlSjWOaVZDzOxdxW//gU1IFZFaaMcAyk52PoFA4dw/judQHpNw/fiV5aCgRLPKdxW8PsQRDhcGGymqRlTwOHbQprRSMhBH7Ieu56ulos46MYBp6Dlf+bTbMofwGv9SK2oXR8agBbj9Vr97l49S9CmICCJ5/eC/+JKTLp4nS+T0OXqTSZy5CH5EsEErJoYXYgSIBMTXJr5BWWmB76dP4g/JGtqWe00+u+Bf9RWsiO/EK2SNpU4vPlf7RQglyAeAnPNCUyQzl6bFA+1g00UcJYWgxu+jpqCuMLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8K4nHhF3MUtPwGga/Rwo8zRVwIJcrjcAIiAlEDOjaQ=;
 b=io4QpOdoMs9A+D6vWx3lQTOI84Me4sE5eq9ZKTVZQFnKBHgI+ImLPdd9tFbcbhj8ErqY/cBXmIiQJ2Oez8K+eL9sspD9G4tcKDRNFhWerxDiStVnBrGrjoJb0a0bzA4XGuXofIT0ihCv06lIKihgyB2XD/Jlq1rqM9WD1ptRI30=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS7PR12MB5886.namprd12.prod.outlook.com (2603:10b6:8:79::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.11; Fri, 18 Feb 2022 16:39:08 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::38ec:3a46:f85e:6cfa]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::38ec:3a46:f85e:6cfa%4]) with mapi id 15.20.4995.016; Fri, 18 Feb 2022
 16:39:08 +0000
Message-ID: <ef8eee23-ba8c-e76a-d32d-68658841708d@amd.com>
Date:   Fri, 18 Feb 2022 11:39:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/4] drm/amdgpu: Fix compilation under UML
Content-Language: en-US
To:     David Gow <davidgow@google.com>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-um@lists.infradead.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20220218075727.2737623-1-davidgow@google.com>
 <20220218075727.2737623-2-davidgow@google.com>
From:   Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220218075727.2737623-2-davidgow@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0039.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::16) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5f41edb-2fa2-47b6-f61c-08d9f2fd2f49
X-MS-TrafficTypeDiagnostic: DS7PR12MB5886:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB58867608D812DC6B688EB29192379@DS7PR12MB5886.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hQDQLpEIC4kW/aO8RI3YuutEkW/NVAJceC/3IqLTGiMjlCm/sSKjsBUm8ZQ2PDl+lUJQ4ZUqbVaMNOiL9ldg6LOUYoWkSHrHTi5I/ozldfAWXVB+cz4/iKG4R/d2TohPG5Yc1ocyUzZLrl1FM/fub3F5fteLfs9+aU/IohZQ19WvigSRE407mWDDjJPwGwaBKPGZzG2SdBhOmbbt8MlXL8ZNrWdavKgw6SRwKma9wQdAFRneXeMBhyPM/hWWadpRLX0lmIAyiy0T4h/tNFNEHG6kBYd4ivLF4RlbVQXSYTaOPZvzuD/GPbt6MdN5VfesTzLp/+mPS3dm4aF0WZsUXMfo2tyr/eD+ktSqJImMeFq5zKM6H6z+DA2LynL1vuxxNQmWB85NDGC4ry+39Asbqg/G3FdoxDFeQIf1mID0QVVwa645eV4xnp3GKhsLLtTzdst+pAH8QVINDA3nVTqT7juoCq8jQuFwx+xkHxLqjFSoZifXe8tD4OPXb2aZMSodWhubKWI/M6zkJbRjI2+omRGgW8aCwQLFM2erSGpZCNqG4mOSsHuv0B4l0HrDKOTEeXEADnZuZXVqRF+rBBE4j0OhNiwlkkHvMOSyf0+Rjqa8Gl0+UTFjYtzxi3bz+R4SSpv6P1jv3ATAUL3LtsyPfbXJMTEaqsFrUbqEwbN3JKT2pfAOzkFHRiLwPm4K/Rv/ZIi78+KiQl10DHId1UrkHfNYoUhUTaEmDz0RytGtcczkXHlWoCcTZyZsJUf6O3YlH3Sp7JXvvE4UcbFaa1gEtDBVEBO8AEhp2sseWwGiNd4HxsUZqSLNnpzb/FF3PUPm7xzMbC9zk2p0pPAxJ6Zo4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5115.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(38100700002)(36756003)(186003)(86362001)(66946007)(26005)(4326008)(966005)(66556008)(8676002)(8936002)(83380400001)(6486002)(508600001)(66476007)(6512007)(6506007)(6666004)(31696002)(7416002)(31686004)(110136005)(5660300002)(44832011)(2906002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFdpZ2ZzRXdBU0lDdjE5ZHZXQjZ0bXdSQWFXSGUzbnV0eHFkZ09lcS9YbCtq?=
 =?utf-8?B?L09DbVI1TWxvMzdPMXhJZWc0NU1OOFdUR1BPRjZjQ09hR2lpRitBY0Y5cHhw?=
 =?utf-8?B?ajU0azBLMDJ2YVV0Lys3dSs4R0ZMU3VIaVowVmUreUtuQ3dUUHBLREU5Z1hU?=
 =?utf-8?B?LzMrSlVNTW8xRHBLOW1MSWRJdGpTZG9udm5yMnVDSjc4anJuRjJhMjMyWkVC?=
 =?utf-8?B?aGUxcEMyMWpjcXdEOWtobXFnazZycWZEZWVLZWhRVUFMNkw1RzE3b3JSNnJn?=
 =?utf-8?B?Z2RFd2Z3Zy9xU2gyaWJPbmFtc0lJU0dZZ0Nkd2RJWVRCL1dXV3lYUmNaamZL?=
 =?utf-8?B?VHJUaitSY1E2UHFGdUFHaURDT3cxSjdaSytWNllDTEpaN1ppOTRDRTd2NnV5?=
 =?utf-8?B?TDRRUjFyNkcvSHZyRTFkOFQvd2w4UTlyc2IzTjIrUzdDREVzbWVtNEd1UUVw?=
 =?utf-8?B?MWVoUTNwVXhaZUdrWWpON1pxWnNTNGZtNXVkcGpVbWxwRmVocU5pTjZKYlNR?=
 =?utf-8?B?V1plS0JpalpVenZTMEt0UW5Xd3VTSnRHSmU1ZGRIcm8vMWRGUjdtNlVlUDhB?=
 =?utf-8?B?TnVtOVh4TlJONGt6VHg4U1REdjhKMmp2SS9JVU5FdzlNTkJzbkpnRnYxejZx?=
 =?utf-8?B?WlZQSkJFUDVINE5FVFlYRE9sNVpranNJZnZqVnZpOVFDb1AwR0h5eU85Wlo5?=
 =?utf-8?B?VXNhQ0FlUFcrbUYyZWdxNVJGQXpjZmZ2UUY3dWQvU3d0dWJSTlV1NHVmbHBa?=
 =?utf-8?B?NHhkTmVHYU5aandaTDV2Tm5xcmtybk5DUTkxY1BDYUx5Qk1tcEFUSzZMT1Z5?=
 =?utf-8?B?aGRhNEYxSGNNbVhEVVBoR0F3R0VwSFowOVEreEp3YmFJSDJkM0FvTEkwM3pZ?=
 =?utf-8?B?V1R4YnhMWUkrekUwdml0MFlNaksvRWttUjJVSElqWVNHRzV1a0xtbDFWSzk0?=
 =?utf-8?B?eXVzZGRUc1RnaTRHcWQvNyt4YWZtMGxTcGl2Y0pzajNId21tR1lqckhWVXdH?=
 =?utf-8?B?M2V3MUFRb0w5dWk1anluaWFJbDlwUi9vdG5BT0ZBR3EyUUlUSGZJMlErcjl6?=
 =?utf-8?B?WEoyYU5uY0xtblh6U0tJeDNIdmVkL3VEbnVVa2ZrWE9LZHVoc211cUFmRGdZ?=
 =?utf-8?B?RUN3YlpHOVp5UHNobndlSnRjNEUwNTBSckh1Sm9iY1VNdlpDaUE4YWM0Z21l?=
 =?utf-8?B?dzdUV08vYTRHdlpQbHpBZTZKYStxN2t1SVdyNGRMajNsWUNFL0tiOXQxYTZH?=
 =?utf-8?B?d2M3N3NpK09YRmlVbnlaSzlnRlpxc0U1cTk4cWFrNUQvclVIcUxWR3hJVjJn?=
 =?utf-8?B?cGdpdFdnY1NLTFRmOEdvTFpYNll2L2ZPWWZiUnBTMWFtOFBIUjRScGlEZzFz?=
 =?utf-8?B?SUR6dUVXMlNEa2J5VUFiSGlESnpjWEo1OUc0ZnNkQ3VsTFZTTk9RblJ2enh5?=
 =?utf-8?B?Y3dMRytQN3dmN3hXWXM1Vno5TGNLWEZCbGxjaTRqTGNsZlgwNE56RldBdHgv?=
 =?utf-8?B?MjNRb0ljSlV5T2NZVy9pSmhhcnEvQVNDOFM5cmhkU1pGdUlmbDZXMFQ3Y2tC?=
 =?utf-8?B?aC9EUm9NWVgyQ3U2MHFHd1NmT00vOHdGeGRXS3BFdEN4RGVUK2ZJZmFJSTUr?=
 =?utf-8?B?L0JJdDRmUnEvbkdxVGpEeHJGc2hWelVtNkN2RVZTY3Y3WEdMYjIyYjVOQ2NS?=
 =?utf-8?B?WGJzcnQxdmN3WFRJQXd0ay9tVFJlcGlkOVpIRnFyRGhjd3RCb09hZHdnU2VZ?=
 =?utf-8?B?MmhhcGxrMGQ4ZVhSZkNSYXNlZGVwd245VUlEd1huYWJwUGZEUGdIY2FUNHpY?=
 =?utf-8?B?UDhDVzI0ZS8yU2lNWWRVQXcxUzluSVNWdHAzUlgvcTV1bi92cVRGZUoyTXYz?=
 =?utf-8?B?ajV3S1dEQlFMa093amh3NmVpcnhBWVJQRHNPNlVwSUkzTng1aWhwOVVuRTRJ?=
 =?utf-8?B?MGh6RVlKU0lPamhBWnYrdy83RGJrQVFHMWRyZ1pDUVJVN1VyMkNWQmVsNlV4?=
 =?utf-8?B?ZTBwbVh0anlndXlsaTJQL25NTmVIeTRrZ3l6bWtVazdVaTlVNnNZVHRDYTNC?=
 =?utf-8?B?dXpLZ1diV1RxYWEzdnluS0g2UlgvR1dpYXlTU2J4anpKc1NhMmJyaWpacE1z?=
 =?utf-8?B?NnM0NGlhMEx2bGc3emkvcTlhb2tJd3ppVVJaMXUwOEF2Y2hjTkl0V0lEdG1n?=
 =?utf-8?Q?VFXwckF1+YS4jO4WUcmZTGo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5f41edb-2fa2-47b6-f61c-08d9f2fd2f49
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 16:39:08.4597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ck24OJR4xwM5fo5sFpOg7/6EE7mGzMS+Zv3DWSFenVwkuTAT41zmfyrL0fp0MCJmkX/ynLJKpbU3KM5rW5J9kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5886
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


Am 2022-02-18 um 02:57 schrieb David Gow:
> From: Randy Dunlap <rdunlap@infradead.org>
>
> cpuinfo_x86 and its associated macros are not available under ARCH=um,
> even though CONFIG_X86_64 is defined.
>
> This patch (and discussion) were originally posted here:
> https://lkml.org/lkml/2022/1/24/1547
>
> This produces the following build errors:
> ../drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1556:9: note: in expansion of macro ‘cpu_data’
>    return cpu_data(first_cpu_of_numa_node).apicid;
>           ^~~~~~~~
> ../drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1560:1: error: control reaches end of non-void function [-Werror=return-type]
>
> ../drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_crat.c: In function ‘kfd_fill_iolink_info_for_cpu’:
> ../arch/um/include/asm/processor-generic.h:103:19: error: called object is not a function or function pointer
>   #define cpu_data (&boot_cpu_data)
>                    ~^~~~~~~~~~~~~~~
> ../drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_crat.c:1688:27: note: in expansion of macro ‘cpu_data’
>    struct cpuinfo_x86 *c = &cpu_data(0);
>                             ^~~~~~~~
> ../drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_crat.c:1691:7: error: dereferencing pointer to incomplete type ‘struct cpuinfo_x86’
>    if (c->x86_vendor == X86_VENDOR_AMD)
>         ^~
> ../drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_crat.c:1691:23: error: ‘X86_VENDOR_AMD’ undeclared (first use in this function); did you mean ‘X86_VENDOR_ANY’?
>    if (c->x86_vendor == X86_VENDOR_AMD)
>                         ^~~~~~~~~~~~~~
>                         X86_VENDOR_ANY
>
> ../drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_crat.c: In function ‘kfd_create_vcrat_image_cpu’:
> ../drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_crat.c:1742:11: warning: unused variable ‘entries’ [-Wunused-variable]
>    uint32_t entries = 0;
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 6 +++---
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 2 +-
>   2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index 9624bbe8b501..b1e2d117be3d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -1682,7 +1682,7 @@ static int kfd_fill_mem_info_for_cpu(int numa_node_id, int *avail_size,
>   	return 0;
>   }
>   
> -#ifdef CONFIG_X86_64
> +#if defined(CONFIG_X86_64) && !defined(CONFIG_UML)

I don't think it makes sense to compile a hardware device driver in a 
UML config. Instead of scattering UML #ifdefs through our code, I would 
recommend adding this to Kconfig:

--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -254,7 +254,7 @@ source "drivers/gpu/drm/radeon/Kconfig"
  
  config DRM_AMDGPU
         tristate "AMD GPU"
-       depends on DRM && PCI && MMU
+       depends on DRM && PCI && MMU && !UML
         select FW_LOADER
         select DRM_KMS_HELPER
         select DRM_SCHED

That would address patch 2 of this series as well.

Regards,
   Felix


>   static int kfd_fill_iolink_info_for_cpu(int numa_node_id, int *avail_size,
>   				uint32_t *num_entries,
>   				struct crat_subtype_iolink *sub_type_hdr)
> @@ -1741,7 +1741,7 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_image, size_t *size)
>   	struct crat_subtype_generic *sub_type_hdr;
>   	int avail_size = *size;
>   	int numa_node_id;
> -#ifdef CONFIG_X86_64
> +#if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
>   	uint32_t entries = 0;
>   #endif
>   	int ret = 0;
> @@ -1806,7 +1806,7 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_image, size_t *size)
>   			sub_type_hdr->length);
>   
>   		/* Fill in Subtype: IO Link */
> -#ifdef CONFIG_X86_64
> +#if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
>   		ret = kfd_fill_iolink_info_for_cpu(numa_node_id, &avail_size,
>   				&entries,
>   				(struct crat_subtype_iolink *)sub_type_hdr);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 948fbb39336e..b38fc530ffe2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1552,7 +1552,7 @@ static int kfd_cpumask_to_apic_id(const struct cpumask *cpumask)
>   	first_cpu_of_numa_node = cpumask_first(cpumask);
>   	if (first_cpu_of_numa_node >= nr_cpu_ids)
>   		return -1;
> -#ifdef CONFIG_X86_64
> +#if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
>   	return cpu_data(first_cpu_of_numa_node).apicid;
>   #else
>   	return first_cpu_of_numa_node;
