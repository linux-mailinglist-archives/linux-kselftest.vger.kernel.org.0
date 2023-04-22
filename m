Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3D16EB627
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Apr 2023 02:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbjDVAIi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Apr 2023 20:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233793AbjDVAIg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Apr 2023 20:08:36 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9901FF1;
        Fri, 21 Apr 2023 17:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682122113; x=1713658113;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=X/xtFQANtX0PzkJI9cf68XOfCEYIwOMsvatMyNrfTCw=;
  b=kmD22pK+HawUDiPEJhL7ibeoHAEhW9saavplOzXihnMF5VGZHovlOpUn
   nFGPW83HACQMHbMBxnD3UKmH79CD1o10Ff6WFLD47NhHAVzbjajyvBbnf
   pxswViBkt5X6cZ4poJSdK6Lyq1E3SpbxuJTRnh2tN7N0ZsHmPGlgJu2P+
   TUm5ZCzsWhPTCmMopGqWBnliHdZCXYykhqbca/W72MswTtKUu+EgA8uXh
   Zq+8VwbmbuOg0P7aWeYmM17YPV2jOxbTT0frZ18nAZY+JdPXOPEcm3VrW
   FDNtY0b1qNVww0FN208IcHSMXLN/FpJ4uxE+Ya6oR70lqnY/rsZlbGeUr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="411380347"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="411380347"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 17:08:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="866852188"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="866852188"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 21 Apr 2023 17:08:26 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 21 Apr 2023 17:08:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 21 Apr 2023 17:08:26 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 21 Apr 2023 17:08:26 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 21 Apr 2023 17:08:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJ4Ft/u7GQl0+pJ0lqSvvZAzJbXkgIP+lIfTAX2xS/kq83Wxtq7Rh+/j532Bm7C0tYuR3+x4AIR9Hztys5rpzS/FnTJxuYT0suCBKAn0065bPoQEIgWuCNQucCj4XFHWDTgNy580oqK4tg8++8iqAfH490VpMc7IBXeH+tR1J7xkDPh31afh3mG/LA6evQWoJynfWNROuZppovtyHKx6Ivs87gFjNmw9TJCooa1tYNQ+gaCa8Iecce0KgfT7GolBFOCdtFOO6mKr4bCEwT01+JF0BdyGNp2GUxZ2T3QzCQLQ/BWZqmdjcnIATM3sn5uI5Yjbhl8Hn1e14OzqTlOXBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBniSR/Sfu5KtfMwYTvMjGzI/1f5Yuqbn/spkoObGP0=;
 b=mpmH6elxghMvY1Eq1+xx6ICXMLAtRq+irqkj7lIRYfxSGVlz22xC3VyD0o4TXQWdfyMhshpKxbDCcSwQ7o+6RTCpaTrVd92SyhBihP2+4+PXQbVtVorZQgLjSzA+q4IOb7mAhfNVahFSb2bxD9xUL/qIbhQ+qdEyeopPEAL4beDEy6K/O0B/83BTPqyynMAosRSUyHv4bXO/MrZW1FSqg6gxo+v8astYX8fT+IOGsVfiCgE27fRzyeb1jS+uWh7x1oB8kYsYpnK66jOgHpE8LbFx9LpuokesadNKgwCYZI7qTTsw7THfntmnpCZ4ITLmJ/d6Qitk+tIojuwOCVeTdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SJ0PR11MB5937.namprd11.prod.outlook.com (2603:10b6:a03:42c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Sat, 22 Apr
 2023 00:08:24 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::2854:770d:2a43:dbc6]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::2854:770d:2a43:dbc6%4]) with mapi id 15.20.6319.022; Sat, 22 Apr 2023
 00:08:24 +0000
Message-ID: <4bae56e1-9223-7d94-e6da-72504f3d0be3@intel.com>
Date:   Fri, 21 Apr 2023 17:08:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v2 02/24] selftests/resctrl: Check also too low values for
 CBM bits
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "Shuah Khan" <shuah@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com>
 <20230418114506.46788-3-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230418114506.46788-3-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::35) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|SJ0PR11MB5937:EE_
X-MS-Office365-Filtering-Correlation-Id: 57687a28-dea4-45f7-b0ae-08db42c5b0a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k5xjXBBYeYm0lCQIdkwJLTM5DU+WBzqsjFECPaAETV3XSZFalpEs5QoE3Va3nGpQvhdZANylf5WD97ThZPjJb69q0cuJMPQsXMIB2VKiDtO+7VIVXTQBeUYoPBQU33H4fXy5L72xPV5fqP0pzMVdAQsd1AhOvwvqQT7PqaISkqg6TCdGszre5XgAITuNEhnuIlwo75VHDF7gbrI5eP7dDKwdsJwKV+ColMjsVY9/6KztTnzqlswCzZeqhjsDxJ1HpScnWv9q669k+gqLFUcUGmXmwQiC769/xAglnTjJauqFNNh6ZoCcKhN4/x8gYYihE3h8ltuQwmEB7b1x+aNSC6z6+/D6N9aXH62XvG+tInm6P18fZ5PxqPyUJahHUbfQnFxXXeW9S5jEE/pd+oX2V+F+jlH4gPatjw1jIFYiaSvyeaCHWnnBqDYnCOKL0oDjmAYE4NytUx9RkiLNv0Shi0kCMilT4ICG5zUm9SLMIgNPg49DldL6XZPSFZZSGtsc61KGFCdci1rKsKRcV4HXwSdoOS4e2MtV7slpnIeViKufnSBfQoTGmfX6f3bJAk3tLRXQIW2edcPbbGBxFJv+gWl6xNL6OFIEXuJ0PZsEXHBGe4jM320D5rY+bfhRloZszz/UlcaDME9Q2EQmSMODCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(376002)(366004)(39860400002)(396003)(451199021)(66476007)(478600001)(5660300002)(66556008)(66946007)(82960400001)(8676002)(8936002)(38100700002)(316002)(110136005)(41300700001)(4326008)(186003)(53546011)(66574015)(83380400001)(2616005)(6666004)(6486002)(44832011)(6506007)(6512007)(26005)(31696002)(86362001)(36756003)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REhGSUZiYm1ILzZSdTNmbkFCeXhRaVJLMDdTZUFzaG5MalRrbU1iZFhOQ1h3?=
 =?utf-8?B?YlhrWU01NitFUkd3YXU0YzhsOER1Sjd4emJ1M05UNkFaSWV6Z3hoaXlzVG01?=
 =?utf-8?B?eHkwRXdieitneXlEcXFnc1lBQWszWnp0ZFhyaDRQZ0UwMlhvT3R1MDB4elJa?=
 =?utf-8?B?N1ZRTGpudmhGdzVKSHNjWEZLQ2QrYnNZeUhKMTVqWW1ML2tmR2c2RXlQamhY?=
 =?utf-8?B?ZGdHM3M4L3VQMStwdmdkTDFLcndXbG1wUnFIQXdDTTN1MzBzVWFXSDFKMU9j?=
 =?utf-8?B?OTEvUTY5Zm52K2dQSnR5K2IvZ1pBdDk0Q3BGRTV1Vk94U1gyenpnbG9NR1pw?=
 =?utf-8?B?RUQ1V05hbW9MbVlQZGFmVXVnOE4rdDFsOWVRM2l0SENIYWFLWVRCWEplcEJE?=
 =?utf-8?B?bXZacDVuc1cyNEdNaWFpYTBUVWk4RmtVVkxtZm52QlB2YmZFMGN5YTVmM0ZF?=
 =?utf-8?B?emFCOXdGV2t4SlVaRTdONGpZVjB0aFNjaEZpeEtBRWZ6Yk1pa2J3bmdybWtr?=
 =?utf-8?B?bFllb0FRUFBxeUFmSlpqZXNabTlURmhpSXdKT3hycUxyL2RVS1RFZGlLeXlU?=
 =?utf-8?B?Vm1KV1JJZ2F1NTVwckZNZkhuV2J6a2Z1VXhxU1JxekhhaTlJSkxsTFVNNzFa?=
 =?utf-8?B?RHgvWmRvS0pYc1NoZE44bEZKdHZVSkhoS1lMOC80NWlnWUdyZTRTQ2c3VHBw?=
 =?utf-8?B?UUZjSWFicTFVVWFlV1BsODd3T2dIaTA1UE91bDQ2b20yK0NvS2VYcEtLZWNx?=
 =?utf-8?B?TEZVWUZQeHM1TWFZd0ZHLy9JemVuQ0JLdHpZL3ladXdqdGdTVVhycU5xZkNz?=
 =?utf-8?B?R2RQMnNZSUZSMjloTENGVDFUQy9pM0YzNXkrNXdQMUpUT1BMZGt0N1EwT0Vk?=
 =?utf-8?B?blh2Ti96d2RwQW9EU3c2TGhFNGttaEt4eHA5ZjVsdU9zWHFTSzRoeUQxZkNC?=
 =?utf-8?B?UTV3Tm5IK3MwV1RDbXk3WGJqcytweXJDUFJ2NVFNNjRUa1B4dXorQ0ZpVmR3?=
 =?utf-8?B?T2Z3ckdqbnpVbE5XZ2xTZnNHVXlmY1RUMUwxanhucGJnQ1VQU28wcWd3WVEy?=
 =?utf-8?B?a1JnN3FRYm9KN3AxaU1iRktxTkdsV3pqL2VJK3NXZU5sTW8wTnpDa0xQazVn?=
 =?utf-8?B?OHpRbXhCQzZBZ1U4NHMyTUs5S2drT3R1enVLSnNSSjZVaDNwQ0ZBZ3k1cEpJ?=
 =?utf-8?B?Qmt5NFE4QlROZlB1S1JTSDErRHZZRXg1TXUyTjFpdXJPc3FnYnNhdkt2UXpK?=
 =?utf-8?B?UzNBakxCRi9IdnhDSzlPcG1PalNBL1RwVzM4SjNDL0hWT2xidkpmdUYyb2tM?=
 =?utf-8?B?N3JPSjRab0dUNFh6Z0IzZ3U0bm9GSDM0M0V2Mnl5aFFmRktEZWFtTmppQWoz?=
 =?utf-8?B?WUFLelZRUEZVYjJrU1ZmRENCbWM1WURzRWhJMjhqRVZPWG5FZ09oRXNEV3pa?=
 =?utf-8?B?VmU1UzhlKy8xQnF6SklVaTN6V1B0ZjA4a0RmSGFHMEEwQ1pWT0x0bDI2QVVX?=
 =?utf-8?B?V0g1cE1KWUZTdnJTTmhFeXB4aEsvaGhzelh0QzgwNjgvMThkbU9TVTgvV214?=
 =?utf-8?B?azJjbG03ZzE5ZWJDaHhqVERSRzhPNUZneVJiTlVSOFI1dUh1YlI2ZUNkRzlM?=
 =?utf-8?B?L0JrL2FTWDFZOUpjU0RUT2hXSkw0SEl0dlp1SFB6MGxpRkx6ZFN0dE1YaTl5?=
 =?utf-8?B?OFI5QlpKc3JlTjdhcUpRT0tRdWNtRVZQakNjR1hWOGZpaU1ndlJ0ZlU5bnJw?=
 =?utf-8?B?cmY1ejArKytyVGFJZmRoYzJMQk5ZN3h3OU95RmlsWjRtaDQrU0FzUTd3eklm?=
 =?utf-8?B?NElnaXlBTVVXTEtmK2FNQkNIZitlN1FYK2pJMmltY243NlJFandXUG1sYTBV?=
 =?utf-8?B?ZFR3RSszU3drTXplZ1d2S0NTa1pEN3hjUzRnRGhWcE9BTVkzY3FvRUJwaFVW?=
 =?utf-8?B?UDFuQWs2U2xzVWJiS0dlK1pUbThUbjNvRkZ2VFZIUVRjWCsycmFkTmJPZisx?=
 =?utf-8?B?cStlS1U2cUowRnNiUDdDVllxYVRIWVgzVjJOTGFDTEdXT003VUVudlFQaFpu?=
 =?utf-8?B?bUIzY1huN01JQUNZMTlZYUsvK0t0V3UxZ3VreWw4MVBia2t4bEJKWjhNNDZr?=
 =?utf-8?B?V2JZRXhDcGI5T0V4ZXZUODdMamV3a05IaDVlZ3MwcTZPRGhabEJ2U0VGYTEy?=
 =?utf-8?B?UGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 57687a28-dea4-45f7-b0ae-08db42c5b0a0
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2023 00:08:24.4350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zNtglNa8oByy/V8o50d4BWosBKsRa0RAaFHTfneavw7X+Y75WfARDFmiEUQeY2mzPeq2cMRFC7fGLVfWcwEUYl8K8oXWZYCd+ZjZQkH4GMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5937
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 4/18/2023 4:44 AM, Ilpo Järvinen wrote:
> CAT test only validates that the number of CBM bits is not too large
> but it could be too small too.

Could you please elaborate how this scenario could occur?

> Check and return error before starting the CAT test if the number of
> CBM bits is too small.
> 
> Fixes: 09a67934625a ("selftests/resctrl: Don't hard code value of "no_of_bits" variable")

This fix is not clear to me. This commit being fixed already contains
an explicit test that will bail out of no_of_bits <= 0. It is not clear to me
why it is necessary to adding a test for < 1 as a fix for this commit.

> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  tools/testing/selftests/resctrl/cat_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
> index fb1443f888c4..722c9cd4120d 100644
> --- a/tools/testing/selftests/resctrl/cat_test.c
> +++ b/tools/testing/selftests/resctrl/cat_test.c
> @@ -129,7 +129,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
>  	if (!n)
>  		n = count_of_bits / 2;
>  
> -	if (n > count_of_bits - 1) {
> +	if (n < 1 || n > count_of_bits - 1) {
>  		ksft_print_msg("Invalid input value for no_of_bits n!\n");
>  		ksft_print_msg("Please enter value in range 1 to %d\n",
>  			       count_of_bits - 1);


Reinette
