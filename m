Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A77D2474F04
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Dec 2021 01:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238416AbhLOATi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Dec 2021 19:19:38 -0500
Received: from mga12.intel.com ([192.55.52.136]:40612 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235557AbhLOATh (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Dec 2021 19:19:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639527577; x=1671063577;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=prAz/5te5PUgl2lxuGdl/wFjwUDw2KfuyMiX2PG4Wk0=;
  b=YTdLPTFuL4jR5LeFdaATtbjwClHhEVE9vWGyuBM7PPHHdv3kzaUZPdxM
   v9U24yNxGEjZQwtC6WnxAaUZM3rTF/qC6P3yI7W7Co9NTy79MMOOcut5c
   j8JkszS9dIskRvV7VAe2455/rb0lvgIiXufN3Ny2+o8+Cdbwruei72lpY
   FSgdWgJUIgnMmraRBCtpGh05s6LxQFlHb7BZ7d7wuFWI74o3I6VwkoFeo
   c96VA4UZRVEjRooG5VnmXcerDAFk86qLFkPqpwURMD+np3bpfLJyv04Zi
   D+odrCLg/BF8cw5QFRoP5kIe95ydSHGqR9iCCjd/ragIqkvOc5bxlFOBn
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="219127771"
X-IronPort-AV: E=Sophos;i="5.88,206,1635231600"; 
   d="scan'208";a="219127771"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 16:19:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,206,1635231600"; 
   d="scan'208";a="614501699"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 14 Dec 2021 16:19:31 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 14 Dec 2021 16:19:30 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 14 Dec 2021 16:19:30 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 14 Dec 2021 16:19:30 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 14 Dec 2021 16:19:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+2tUOH3StAmFtz7FSC7anoLynXVKUYDczuhbW5JVxXOxL18+OBNJifJELjl77CcJRZjHcJhZaLBCKg1q0A4gUwP9BiwmeqeP901OpkLSDOffzLEXeKDWsy+zzvBRjRVRM2ROK1WXBmquunCxREb4IZKxMqZIjvFTtsuPqXNoECynh8OoVokHKAENhJVww6k6d376dvLLaK6Q4EJl9KaFZ0YJKaLFXPbz+09CTlX0J+e9GQDOsPojRuTXMQzg28ujQA6ycXbHywhbAAJD4dmXa91R56ZHu13/lCriqWF93GAVtevGNv4+tbcr1RpFZ3xapr90ZUUoTyxgIiurqj92w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T97Z6tAP2h5SL8b6IkMnqRAazdKWimaf7skxsMknyFQ=;
 b=AaCEXCP0SoTyjwPstkAmOgRmjT7eZ56mJoZDvDT+Rxh98dUBUCteYuC3A4RYS5K9bbHtTaxEynx30K7RjTnjOj408E1+iM/oSLNUraVg4Mk/RZxDgeUW1P8kRINlCKKst/Oq6pJNzuEbTtp3RkjqQW8iY+cbMpUvoKBn/KJWRJUw/Ze/Z0oCJpulFq15EcPyKm/R8J4NG/gpHcl0Dq7F7c9HfaTLUp92YUAY2fUeQqA92ZFmCOqKIDoP2ysBASCnb9/WZbyfMylRlDlsgcoNiHkTBzPD1X+MQP2qWgYZIkWoPd32Tb4s2M+u/imrNB+wUPM+8FE4plsQ1DhA0zvR1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T97Z6tAP2h5SL8b6IkMnqRAazdKWimaf7skxsMknyFQ=;
 b=rEKf8EVhmKU3Jg6BtlpkyZ8fCzkyJip4nsDtOw1Z7QMoYKEOBrqIKRIOCzCmQZ6ay+WcRj7MP74bXAuHazvEMPFTVorGRCZE7JJ/CrpGZmQW8pEvDUcjEIB5DT8VdtjY7ULwJHEgZsAUhRm/l7PcXWbOHUMrLRHlMiwFOV/kM24=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN9PR11MB5306.namprd11.prod.outlook.com (2603:10b6:408:137::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Wed, 15 Dec
 2021 00:19:28 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10%3]) with mapi id 15.20.4778.018; Wed, 15 Dec 2021
 00:19:28 +0000
Message-ID: <1eefe8b4-feec-3f2a-7eae-c10e49fbedf0@intel.com>
Date:   Tue, 14 Dec 2021 16:19:24 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.0
Subject: Re: [PATCH] selftests/sgx: Fix corrupted cpuid macro invocation
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, Shuah Khan <shuah@kernel.org>
CC:     Dave Hansen <dave.hansen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, <linux-sgx@vger.kernel.org>
References: <20211204202355.23005-1-jarkko@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20211204202355.23005-1-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MWHPR10CA0024.namprd10.prod.outlook.com (2603:10b6:301::34)
 To BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49fa6af3-0b18-4101-df41-08d9bf608f02
X-MS-TrafficTypeDiagnostic: BN9PR11MB5306:EE_
X-Microsoft-Antispam-PRVS: <BN9PR11MB5306709064EB7CE676BFB500F8769@BN9PR11MB5306.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: spNng9+xmBH9FGT6A2yRlloYPdSMmKqp0MviPDzKO2DAlAeT61RwC0R8Gs8ilz1BTePoXDaXE4O2XjG8EzdhIptAaXTTkJe3HsWnWxJTOpFHRHsegV2Rs+GBAvx0rPd4rTiWGxnLKMuZ3nJ/5pqhka/4q8MhDeiRuP1Nja0xIU/zvdSEReO6Lonswr9G9+Ov4pQZ41eA/T3Jh5bJ9aH85wPMqsxtnO7TzItD9hS8sxbP9zOrOhP5CqZd/mYuFxJI/smfNJbJ9Yl+/hTrlW8tm4seJ1a31L2ze8EAouTWnmRfGqier3XUs1CGfjtPTh4gBXPOUmRPHWjSZv22g6vZj17IDjZ5j9n5qgQJGkc6AXUR+91G1zw+2gP0lSU44FX88DhCwFnVa4PUv99FFOEMe+H5Bz/t7GTyn3ROhf4+86x1uVSmHJzUqcNeAFd8JWndR7hylNCfOEzQMBaF73xB/jVasZlOVXOFK3Zxhv7n3zm+eaA0JyYUk19X25TCi/CzYRHsGZEd/tkv8hlg6Cu/2kJNmksKDwyuYRsXve4oqB5dRV5F6sVb1P+WaQlyS0+6TRTIzwCIO7xt1QsBRbKYj09edOS/UfBd462iFQ8j7Hag/geUo1KGVGbQQRucRb4cMxzRTbCW1x01FF6E4YKycEusvHyxi6+Mt8pUkVJiamI0nHozhSgnPX+fMykypJxLeyM96IFbLnlFVIf559gJXAhmXliFZ0U8xHJKSkgPIIN+mNEBStARQu7qZxbXJ9m65tqitjZcEq0klMlVVXlpNu2g/wgevUlcSL60ZFJcIRjv73ZMAGu33xTvKS/tm4ZlP9ZGt89dDoE0wD7Rm3p/Ew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(6506007)(82960400001)(2906002)(31686004)(86362001)(966005)(6666004)(316002)(36756003)(6486002)(66476007)(31696002)(8676002)(2616005)(5660300002)(110136005)(66556008)(4326008)(44832011)(8936002)(186003)(6512007)(26005)(83380400001)(53546011)(38100700002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjNERW1uekZrK3RyL2J1T1BrMjlwVTlSZnZYU29rL2RsVWlrbVVWWGZMb1Jo?=
 =?utf-8?B?RkRldXQvQ0NJd3YrSUV5ZytzbWRtLy9HZG1xNCtBK1FOcTdYTGR6bWc0N2pF?=
 =?utf-8?B?akx3aDlUSFRaYWlmT1liQzJJWVRBcUIyV1JvMXpFU3hKemxWQU5INUdIdlVx?=
 =?utf-8?B?R21RT0piTzM3cmt3SVhhUEVuaTBlcGlPb21xcjl2WllyUXRwKzU3TEJOVDZ0?=
 =?utf-8?B?ZGd3Wkg5SWJqK0FQYjlMNmFWY0FXY0lNKzloNmlnQnB5Y1I2WllJczA4VFZl?=
 =?utf-8?B?cWZ6TVB1VTFLVzc1aEN5blMzYlV6YUEyUmszMXVrS0JDNXVuVUJNcUd0SEl4?=
 =?utf-8?B?MDhLdks3OXcvL0E4RG9VcytKdjVLV0ZzdENVaU5UM1NRT2pEbFZ4aFVSMVM2?=
 =?utf-8?B?Ymh3V0VtSCtKSm9oZExXdVFqaDBUNGVQOVk0V09yS0s4ZGd2Q1JtNkx0MkNm?=
 =?utf-8?B?VEtnL3VvRWI3d0EySDNET0FlZHk1TmJYT3NOOUJmLzVyUmROT3VqcDdkMnpL?=
 =?utf-8?B?QnpEZGo0L1V0M2ZOTERMK0xZSFVLeHBLblROVks2RGJsbTBITklNSTIweUQw?=
 =?utf-8?B?VHZYUGpUbnBnb0JmYXlYMHViZm1xem0xb1lLUDN2V2hLK1BONWdscG1xVEEr?=
 =?utf-8?B?Qk16QkVTR1g5UUJ4MHFkQ29pWU1CVkxaWHVicjVJQUxXY24rcFB0eGxmcnlJ?=
 =?utf-8?B?azUyRFpvWGU3SUhqUktmMzFpaXhoeTAvcHlqYmM2QUsvbDdDYlpCZXNZMmg2?=
 =?utf-8?B?WkFXWUdSR2RXTlFXb280Qkp2SzhpMmZjN204NFlneWJWSEYvVUVkK2c5aDVF?=
 =?utf-8?B?dkgySmlvZzViQzRSa251SXI4bDNCTUJWelFGRWJxTldZZXNGVytoSE5NK1pq?=
 =?utf-8?B?eVloWCtFT08wZEkxdzhzUE1qSjlqemUybGNyNnpDYmlXUHV4SWpnR0d6UUFH?=
 =?utf-8?B?QnEvL1lhbEF3dGxHQ2ZJWlBaeEtqY0JkNmpmOXp2VW1YcGZlMC9NbEZmZFQ1?=
 =?utf-8?B?a3pCaE1rc0ROU3ZLSHVWL2JsMlFvREJidjFxRDlBVWlHUTBMSTNkWWc0Nm1G?=
 =?utf-8?B?SnIrbm1vdTc0dmo0cWxOaWNiSVZzTzN5b1pYZ25QamtxOWxwZS8xQm5kQndB?=
 =?utf-8?B?RnRraFBVekZvcUtIOVoxaVMyOUJLc05hWG5mWStJUnQwVU5hODhld0tjWEtQ?=
 =?utf-8?B?K0k0bXZRemdsNkFhY09DeHRheTdRMjhXUkd2RTQwWWhZZWRrd1A5ZE5tSFRX?=
 =?utf-8?B?akhZVnBXQWhSbXBKTU5vVFpzdXlXSVBST3VxN2ZtUlRTYWpxWEFpQ3g3R3pk?=
 =?utf-8?B?MExuRFk3VTVHY1YvRTdyUHNMYmtULzBaYlc3TUVKa2xCdkIxVDVDamFDTTFN?=
 =?utf-8?B?U2pPMUN3ZW9va3JOL1didjNteGxqTjU4b3FoTUdrTXR3ZDM4V3Ryd1lNL1kw?=
 =?utf-8?B?UmFSM2tqYlVFZm43YTI1OUx1QXBVcUdWUHlwekNKOGswVTYvRGZuNStrL25r?=
 =?utf-8?B?Y2JzSHIzUmJPUnRiRDBGUFlnT3UyZUgzZGVjN0tqNm5uUTZVMkw3ajlwbC9n?=
 =?utf-8?B?S3FidHBDbnZhNDdDQVVMclcyMkZDRnJJZkVzQ2s1MjRWT0R4aFZDL3M1S0lm?=
 =?utf-8?B?UW1xTGVXTS9sUk5rejIzOXpBaXFPQjlzbHBQdDVURExkeGQ2WGlaR2IwVGkv?=
 =?utf-8?B?c1RZL29ndnhpVFVKdFhNVEdMR1RCQmVwMlk0K290V2ViVXdydFMvSTFwbnhj?=
 =?utf-8?B?Tjk0TG8yN1piUVNDdnVYaFp5RURuenhOdSs4OFNzYzYrb3JPUEtVeDVNR0I1?=
 =?utf-8?B?azREWkxlRVZ6RjFyUUtYc0t6bUxLOHpkVzhSSzlUNSt1VkZyNXFWNDVzaUdu?=
 =?utf-8?B?Y1ZrUW1BMXY1a2VZYXY1ZysvelBvalhURnkrMUJBYkhnemJ6dmRXSUREdXlt?=
 =?utf-8?B?VFhVWk9MNzA0cGxJWW9oWnlCZnk4K255QnZMdjZUM0VtamhyYmhQQ1UvYVJU?=
 =?utf-8?B?VlZ4KzBzc2R4aWR2UXR6elRhcGQ2MGlxZGZBR01zb3RuMW5Fenh2T2RvN2FB?=
 =?utf-8?B?NHk5RDNrcVNMbmgxTFVEVklsRGxnaCtaVlhiWTNLaSsrUXB6cStRTys1NTlG?=
 =?utf-8?B?WXgzaC81K2o3WUJUNnRkWG1DL1hwbVBvSW9ZdVR3dzBudmJjUTBTWEdLc0p0?=
 =?utf-8?B?VlNlWFVLTGJxYmxFd1dBM0d2bnZRbmRIRldDcTczL0ZSd3JrOG80SUxhb2oz?=
 =?utf-8?Q?9Mtk7ejDvFb5ffr1i2EoqIl9v2aseR/xkYtF7XEsgA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 49fa6af3-0b18-4101-df41-08d9bf608f02
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 00:19:28.8702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m2nulqs+UzfRDPDyYb/myiyco0CE5hfLAZKHy4m5ezie4HPStKEu4SloJryleci0iLzapz6ZYfjPZHEPSQy7FpLtJaySIrFzF8YCTIjhhYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5306
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Dave and Jarkko,

On 12/4/2021 12:23 PM, Jarkko Sakkinen wrote:
> Compilation results:
> 
> $ make -C tools/testing/selftests/sgx/
> make: Entering directory '/home/jarkko/Projects/linux-sgx/tools/testing/selftests/sgx'
> gcc -Wall -Werror -g -I../../../../tools/include -fPIC -z noexecstack -c main.c -o /home/jarkko/Projects/linux-sgx/tools/testing/selftests/sgx/main.o
> main.c: In function ‘get_total_epc_mem’:
> main.c:296:17: error: implicit declaration of function ‘__cpuid’ [-Werror=implicit-function-declaration]
>    296 |                 __cpuid(&eax, &ebx, &ecx, &edx);
>        |                 ^~~~~~~
> cc1: all warnings being treated as errors
> make: *** [Makefile:33: /home/jarkko/Projects/linux-sgx/tools/testing/selftests/sgx/main.o] Error 1
> make: Leaving directory '/home/jarkko/Projects/linux-sgx/tools/testing/selftests/sgx'
> 
> Include to cpuid.h is missing and the macro usage is incorrect.
> 
> Include cpuid.h and use __cpuid_count() macro in order to fix the
> compilation issue.
> 
> Fixes: f0ff2447b861 ("selftests/sgx: Add a new kselftest: Unclobbered_vdso_oversubscribed")
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>   tools/testing/selftests/sgx/main.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
> index 7e912db4c6c5..370c4995f7c4 100644
> --- a/tools/testing/selftests/sgx/main.c
> +++ b/tools/testing/selftests/sgx/main.c
> @@ -1,6 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /*  Copyright(c) 2016-20 Intel Corporation. */
>   
> +#include <cpuid.h>
>   #include <elf.h>
>   #include <errno.h>
>   #include <fcntl.h>
> @@ -291,9 +292,7 @@ static unsigned long get_total_epc_mem(void)
>   	int section = 0;
>   
>   	while (true) {
> -		eax = SGX_CPUID;
> -		ecx = section + SGX_CPUID_EPC;
> -		__cpuid(&eax, &ebx, &ecx, &edx);
> +		__cpuid_count(SGX_CPUID, section + SGX_CPUID_EPC, eax, ebx, ecx, edx);
>   
>   		type = eax & SGX_CPUID_EPC_MASK;
>   		if (type == SGX_CPUID_EPC_INVALID)


Shuah confirmed ([1]) that there is no problem including cpuid.h and 
that this is the preferred fix.

Thank you very much Jarkko.

Acked-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

[1] 
https://lore.kernel.org/linux-kselftest/63293c72-55ca-9446-35eb-74aff4c8ba5d@linuxfoundation.org/
