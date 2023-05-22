Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E67D70B937
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 May 2023 11:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjEVJkF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 May 2023 05:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbjEVJj5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 May 2023 05:39:57 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741BCB7;
        Mon, 22 May 2023 02:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684748396; x=1716284396;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uLAb9CBgZUhOiDdXwAUM8fSGi8W+6P9c/CnKEAYfUVA=;
  b=QCwPQHgN+D9MvkCk07bZhLViN0IgYSg7nR4m79ex2X209L4k/lJDEcS7
   FFOoyUJV3+XUP8YF/CweaOdtarVv9PGWCRbRBatgxKAcQGFFC+p8gHbL6
   VwcSG1sMp6PFe+rLf+QE9x9Ew7pk3JGDcjpnIUma1M5fBsh1qg/03sazd
   bPHaita5CZ/tgRHDcK+AmmqI2ssSFo+6V0HudSxmywrYbQ84J4JHax7q9
   Q8uVr72tYhqw4GrWV/UTP7FiBFzHIqMQE0S8M+frNjFbGur0PuwurlvBh
   2ox9FkRhYrlekB8/O0pY0adgjHW+yjXr0t1l04qNHQT4L7ASVtZ1SUqSx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="355220955"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="355220955"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 02:39:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="734201827"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="734201827"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 22 May 2023 02:39:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 02:39:55 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 22 May 2023 02:39:55 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 22 May 2023 02:39:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6srtkOdNP6AKjj4eocGvRGCymzLWvHO7q0brsJNjq/4VzG6FKW9uZKBzyMG3dFzvvjSDLkI/3A3wIz7szdIy+72I69yvhcRkC0udqHLDsz/gTLfGzC7XtPwhchwT9vHdMXMg56rzt8CN1WxeYNeEJgLmKuPBwJ7stc/Md6BX2C7sRYC3cg/6FK6TnfonDOdHXTnrADgxao5/0XwnIfy6/H+wOP/LbE91YPZhvh7+zK+E/kcaMcFgcL1ZZT9gavQWPptIM/eaeSlQUoUFJBOpnqOwBD1Bqa8waOt6q4GMNs49Mf6XP4Da9nLfTJlX7b28lXSkKwb8tGMSrsFJuoGsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZoZpdyVVAJHCsnq3m82cxW41adlI7yj1jRfASip3g8c=;
 b=VUSI5bmXVc2jiub/zfEcTB4mIM5kKLHa0GdlkEV5R58seh7yZiwBmnoaP2qIGpPaBWKXpq5UJUb+FylchZ+rKPvoBnTTDK95JQ2NaZv3RKp9F/5UCMPes1/bG8PvBpUm/Ndhw3URFjgTSWQ1Pc3WVVXkalQvVcbxRbFtkQAe54E3qwKqHJiSqdUB+40aXcZpYm6RE6HJ/G5maylht6fHHT0B59cN4vsAQW0Ix8Vo33/m4tCBV2f7IcmEG0fHrjZEDI6llLwOGDWUq1lFV9e1H/ZdKywkdC4mqp8r4glfuI4CeeUPunvSdoraxfhvvcCi6aFRriBFEsu+LuqCbqBNoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5469.namprd11.prod.outlook.com (2603:10b6:5:399::13)
 by MN2PR11MB4520.namprd11.prod.outlook.com (2603:10b6:208:265::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 09:39:54 +0000
Received: from DM4PR11MB5469.namprd11.prod.outlook.com
 ([fe80::e825:c2b5:8df5:e17b]) by DM4PR11MB5469.namprd11.prod.outlook.com
 ([fe80::e825:c2b5:8df5:e17b%4]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 09:39:53 +0000
Message-ID: <4f548084-3739-b0b0-8a18-1384393fbfe1@intel.com>
Date:   Mon, 22 May 2023 17:39:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH v2 10/11] KVM: selftests: Add tests for virtual
 enumeration/mitigation MSRs
Content-Language: en-US
To:     Chao Gao <chao.gao@intel.com>, <kvm@vger.kernel.org>
CC:     Jiaan Lu <jiaan.lu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
        "Shuah Khan" <shuah@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "Borislav Petkov" <bp@suse.de>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        "Zhang Chen" <chen.zhang@intel.com>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20230414062545.270178-1-chao.gao@intel.com>
 <20230414062545.270178-11-chao.gao@intel.com>
From:   "Liu, Jingqi" <jingqi.liu@intel.com>
In-Reply-To: <20230414062545.270178-11-chao.gao@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0186.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::14) To DM4PR11MB5469.namprd11.prod.outlook.com
 (2603:10b6:5:399::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5469:EE_|MN2PR11MB4520:EE_
X-MS-Office365-Filtering-Correlation-Id: ca662926-89a3-44d3-78f8-08db5aa87ea1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: slr56xdtkBs9dbp3rgwQPKfNH3rlXNc6mIVOWyXUEeG6cZwePiIZMMtIpb93/ajt4Sj0xc+Ufsh0HP3h1u+L65tliu7nx6/sFJHBm5yHJt+B9JJ8x2WTwXO+1n5aIFWqCqR7Guy1EdgIT/XlAzMonGxWK3qaNx9vF/nBGqnwSetLSKiPulphJXNX3bNhqgKqv169UlXrIMtvzfCD5gBpYQTd5gacxYpO/EJYDL5xAxe9qLgHmLK1K2iZ4OGeTLNU18fbsIXhGWd68xTD/me8ZZ9duTUPJFul33+Vq6yIghcw8iCXPpCEfOy+ib0QgcWOKFARmFB4jj9xAUPnDmOdVDhaMn+YoNcpJm7kUMDMqEhXVWstX/Q7Tgfj1NxRDZlnvtLIsSSXW57MBhchu/uRmcapx2twz9/a4Cf85t/i6TapzjAuks199+izw09VVd02k0yYMOAu+IKdF5mmzEOqNvxHABWkQEBkqT22VEVGuF5jwO6WHWIDytk2FoLj+24kHdailJ+nTA6L4VB9R3it9eIXdiueOClqGb0pQqo78tsTE6jOUAp3oMb0aesLhlVyLiugm5+UHx/YmAEMj/47O5sUFByUeQY0/P4pL2s0zrAU6SSoIYmdQMSc4PqfYEIGAc7Qa81SwVqN4LQyuCRo3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5469.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199021)(6512007)(6506007)(26005)(53546011)(6666004)(31686004)(6486002)(54906003)(41300700001)(66946007)(66556008)(66476007)(4326008)(478600001)(316002)(8936002)(8676002)(5660300002)(31696002)(86362001)(83380400001)(4744005)(82960400001)(38100700002)(2906002)(36756003)(186003)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmtwSkEyb3lyQTRDQkRubjhWRUk2MVFGdXIxVGVHNVNYWVRDelhVd3dJbzQ4?=
 =?utf-8?B?OWRCT0lIN3dXelJVM295NXZ4QWg0SmN0M0lEMXRIbXJ3OWRGRFpyYjFISG9Q?=
 =?utf-8?B?d2FTRXNOV2l6dFlieGhFNmQzbGE3eXBERFNZZUxtSlJhRDFQZStYN2xQeSth?=
 =?utf-8?B?SHZqWU11VFAwQkdCYTFGWDliOEZ2SWJudnA3eFdFanhPVy9kMVlYMkhLaVhP?=
 =?utf-8?B?NjRMdzJIYXN1bjluU2VxczNyUllnaldJTlhWazVPTFNQajBFR3dWTkxGVXhV?=
 =?utf-8?B?dU5oYkRQNCszVnMrbEZLaUY5Zm5ZSGhaRWd1a0Vxb3BaeWdLOStZT0pOcFZl?=
 =?utf-8?B?SnB4MEV4b1lrZzlvM1psZlA2WWJCSUt6enVjanBLMmlxOXFMeFZqWE1qYjA5?=
 =?utf-8?B?aE9Gc1k3SktxeWdDOUJicEwxQUZBOGNnSitSc05NQmRaMEZ2SFRQTThFWWRq?=
 =?utf-8?B?bS9mS1dYRE9SVWo5TnV0bVRNOEZzS2ZiY2lSdkYwWW0zOFJXeENBUkdkKzlk?=
 =?utf-8?B?ZlFMeEtjKzdHQ3lJMmZjNTFMQm9hMlFsdE04d3Z1dVgrSWY2TW92T0pudy9J?=
 =?utf-8?B?OGlHbzYydWUxR1g1Vnlvd25TQVdyV20zamhwVDhxYnBGc1ZYcXVuaGJ5VnNU?=
 =?utf-8?B?WklOYzl5WHpwQ0ZFd0FQdUpMTGdCUVRjb0RYTUpFa01ZS3QrV2F0YmxONGt0?=
 =?utf-8?B?RU1mMTU5VUVPSjdRUlQ5WWM2NnJvS2YyU1RYa2hLRElUZnViMUoxbGRHb2V5?=
 =?utf-8?B?QzRUUU9QSFY3eDE3d2hlR2E0VEIrd0ExaFdnL3k5RVNiTzV3dUZLeWJ4a2Ew?=
 =?utf-8?B?eEYyRFJyUFBMNWNrT0xQb0pLeXA0ZGFQS0J5Z1c3NDZGYTdhQ3lJRGNEOHND?=
 =?utf-8?B?ZDZTRC9PZHF2K3RwVzZwUzMyWE5TV0Z5SktKOS9hOXJpcW9MVE1oMWtiRC9M?=
 =?utf-8?B?bVJ0bkhaOWhKNWRySEZjalRzeFJxNGFHOWxlTHZoYU1YZ3VhY0JncmFRTHA0?=
 =?utf-8?B?bC8rZmFSbWREV3pyeHRHK1hZVk9lNldsTExiZXdwVGFpYXZKQkFxWGM3Q2xX?=
 =?utf-8?B?MDJhSHJmaWZ4R3BkQWlvMThhQTdFRkZWYWVSMUpxZmRJbjZMREhrTkhrSTFB?=
 =?utf-8?B?UGhiUktRUGViTnRZcnFPWFV3WGQ5UEFyaTBHUHdyRkVSelZtOUM0TXZmajhw?=
 =?utf-8?B?SGZBWmEzekozK1J5VkZjWnVjZW1iUTJ2QjJSTlpGNjJGekNTTEt1b0lXYUNi?=
 =?utf-8?B?d3dnYW1vZEVOb3FqL2duVjF2bEFNcUdOR3RHK2s3RW1EZVBvRG5kb1hORk5J?=
 =?utf-8?B?ckdIRnp3SXFwcmMzbkxFYmZINURTbmd4cUJlQ1lVdGxEWlhGakpBcEtEc2xJ?=
 =?utf-8?B?cDFrNVc1eTRLMkNhajZqNm0vYmc4QkZCR3ZZd243eElQT1hhWHVwSVNDODN3?=
 =?utf-8?B?dXB5cTJ2WDRGRFpxbTJQZWM3ZTRHOW9IMmJBMnFFOWtlVWdzRGsyV3N6MGxT?=
 =?utf-8?B?SHRQblFtQUFtR3l2b2ZtSFNiMExtYlEzZ0thampPaWdMMiswWUJheWJZY1Zw?=
 =?utf-8?B?d3JXQmFqeTlrT3YrWll4YVp3cmZMRlpRN3dzdmR3RWZyU2UyRFZVbFp0TXRq?=
 =?utf-8?B?VlRldWlzZDJoTHlLOGhaZkk4UVA0b0djWkIrTlFIOHJjZTQ0M2k0Y002Tk1M?=
 =?utf-8?B?NmJRcEw3WmxlZ0k3dVB3dU1QVm5wMlNiclBmSm02ckNua0ZpdmZ0S21GQlFQ?=
 =?utf-8?B?QldwNnJqMEFZVlhyaTFwcGtVajNHNThoaXQrMWhqY0xQbXRnNGpEOE02bUFl?=
 =?utf-8?B?WUk3VWM1aTJ3S05vOVVEUWdkVGRDVFd4cGR2d0E2anVnRExyWUZFOWZiV0hl?=
 =?utf-8?B?TkdMdzZpa3lkMlNjaVdVeXBPeHF5QjYxYk1rLzJLL29YR3VodTBrM1A2Y0Nw?=
 =?utf-8?B?MHk3SWJHSmlkNURXa1dVWXkwRWtxOHpXYitOVVI0cTVmYk9vVTdBbDFoSUFN?=
 =?utf-8?B?SEd1R2NOdyt5Ly82bi9vY3ZUWU93czlxMEFmRG9QOXZ4VnY0bjlVbmtDU3RC?=
 =?utf-8?B?dnJzV1did0t0T1VleSt4cWVqMWxQYVZlaHNPUTd2eEVoYjhqN0VGWHZqR0xn?=
 =?utf-8?Q?mPyqDd1d9qXHbFJ890QuHS2d6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ca662926-89a3-44d3-78f8-08db5aa87ea1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5469.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 09:39:53.2170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l44tPTMY0Rz2oENkK9aMEfnlSoVXnK+uAAQ/MNJm6eHfwxSRJ/8lhQ6AlCEnRE9njsyZkbXiUb4EUlbYZDnBmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4520
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/14/2023 2:25 PM, Chao Gao wrote:
> Three virtual MSRs added for guest to report the usage of software
Seems it's better like below.
s/Three virtual MSRs added/Add three virtual MSRs ?
> mitigations. They are enumerated in an architectural way. Try to
> access the three MSRs to ensure the behavior is expected:
> Specifically,
>
> 1. below three cases should cause #GP:
>   * access to a non-present MSR
>   * write to read-only MSRs
>   * toggling reserved bit of a writeable MSR
>
> 2. rdmsr/wrmsr in other cases should succeed
>
> 3. rdmsr should return the value last written
>
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> ---
Thanks,
Jingqi
