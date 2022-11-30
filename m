Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227AA63DAB8
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Nov 2022 17:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiK3QeF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Nov 2022 11:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiK3Qd7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Nov 2022 11:33:59 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033767BFAF;
        Wed, 30 Nov 2022 08:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669826037; x=1701362037;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=O38EYA6G9ifarvTxg5lwmhwEvLFlfmF4WwTHCfk3YwE=;
  b=bB8i5s6xRlfuukHiBsZc9kOeq9eRvspMfvdXOcVvcJCG7kStVGYKSgL7
   RhC2TofTaYh/4fU+uhiUoEYE7qKbFNWaOWgyRoNplgqNIXVRLYevs6loy
   JoWLPKM+cP5DbsjSGZcC0uN963cX7i8h0otm+qKn2/bUPoNfcSaMd4zk1
   crt1iHotiGsYrvy5wrJKZS26u1+YAwXofBx+IQU/Fpd68WPVBqgIrD4rT
   iz1oIelxpTCDcZ9+ZyxvLeHDgNLVXx7qOrDTJqv8vcMMRl68KzvH/+j0z
   dkbqlJ674ckKukZdTgVsLUmulpowA4Vx0lXtfklFitcJ5tq01yu2gDhMP
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="401718257"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="401718257"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 08:33:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="621943245"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="621943245"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP; 30 Nov 2022 08:33:56 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 30 Nov 2022 08:33:56 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 30 Nov 2022 08:33:56 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 30 Nov 2022 08:33:56 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 30 Nov 2022 08:33:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=klqe6To5Cwq/lGHIrpZtn0PT4JXnw8cjIYiENwJ1jM65g1zr6sRqlwKMaOaErNXl4ceg2ObdrSQjnFF/3KXNNKkrwTCg/Ihaq7k3Ne5SES7hLXo1ZioPZbHIPGHr8FSYEBvP/8M4VogFKfDm1fx6CRvTd6LmWkBEqgOA0VdJtDsVfPO238/oQv8mX5KREfWyFwoxNWj6OnRAs/btDBgrhT9pyd1ikmFlw9fAZObhmsNZhnIGJ2qdh+eG0VoofPbDCD5Akv7SWvB77ne33CHigf21kb3tr4VY0vtC1VEDkHPAAaFSTECGrSwP4a7EU8zNS9+I+6I1A6r8o1B4Vaup3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2BKBTBcwPpJmTaja9H3N5ePa71y4z6U5ux7D+e+kC3Y=;
 b=irGj2t+EawyMAAmbO+uRVr/tTHmhDOIpAO04VU8usGtkdrFEqP7gs7h5f7lCZdBFLM6TQJIQNvqynscCcsrIro3Shl5uiCe7yA/CwuCOSLYwCNBrLrNQx2JtOuM/Ew3RYXL2hQufMCRyUlrxAuEHzxpzPVnLqna3rotWnOtZcqWtAel5yUBLJNTg0BYy42kR1/ESUB04j2o7r7kehpsF9dAkuLQm0Cmqy4oPyZXTQ41exgow9k3JwjMCwe3oVKF+Y/SGTCWgJrW8uTQbLWDcrJc1076+pE0TqV8FfTo1d3nbdDQt/+jxXPUX570/Rs/K4ChDdSBmtkXGAxOWt1tUeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by CY8PR11MB7688.namprd11.prod.outlook.com (2603:10b6:930:75::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 16:33:53 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::b518:90b6:52bd:bef9]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::b518:90b6:52bd:bef9%12]) with mapi id 15.20.5857.023; Wed, 30 Nov
 2022 16:33:53 +0000
Message-ID: <ce549bc3-7e54-b1d3-7ec5-4cde66bd468f@intel.com>
Date:   Wed, 30 Nov 2022 08:33:51 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH v4 4/5] selftests/resctrl: Cleanup properly when an error
 occurs in CAT test
Content-Language: en-US
To:     "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Shuah Khan" <skhan@linuxfoundation.org>
References: <20221117010541.1014481-1-tan.shaopeng@jp.fujitsu.com>
 <20221117010541.1014481-5-tan.shaopeng@jp.fujitsu.com>
 <af1b4e59-2b4b-ddbb-2218-0e2808b718a3@intel.com>
 <TYAPR01MB6330CDB2C59C58EE77B912538B0F9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <ba5a9ef2-b4ca-5c90-cc03-2296586455a6@intel.com>
 <TYAPR01MB63300F91A0755310E78D98308B159@TYAPR01MB6330.jpnprd01.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <TYAPR01MB63300F91A0755310E78D98308B159@TYAPR01MB6330.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::30) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|CY8PR11MB7688:EE_
X-MS-Office365-Filtering-Correlation-Id: a760945c-8353-42d1-89c5-08dad2f0ab61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KRtDSPY1U9yJkHD71hfKJuwbYPEh2eXVOhVKuXD0bJr7/0a9lQAhVivV12yRR3JUZAZYgaQI5xyUg6D2dDhc6Pj6xB/J0t6GGQeJwknmoh5QMy3FwCsIvXuhXp+tpnJmQWZGgN9h8+8/WWIC7Rj7NUurKSEAcPwos/ipD6Bn5fVqV6WkVhLcCKg7BDO0IemKuoUGj4q7zszagzjqcggOMkwVHQ62780phpDutAnze90DegiyBNUak83Z32u1MQWaYqaol6feYOQCqd0yR2SRKNHAQ+2PuFg6OYqmwm7HMMRwmw2M8b1208Db1MJX+uC6P/P6x1rlrB8+Pb9K6BIMryVTIEX18Jv39EZOj617yjE6oezPmpRSjzWtFvLyEyrUcNo7MCAitt1SMvn9+YQ+oUiRSzfYsRx62aJ5z3iXlPmRz7OYNRHF9pTGOkR/a47qHQ3chOJQXFgNrWql345CBa6iU+kBenGokC/wVphEZiq8SRFXjC/ydrx9066gbDpkytPyKHG2KwyKauIi5qeh/zFXwvLuXw/DO2VJg1/YAhLpA4cVX7ZAE2RzxIcQ02WANnwTcXmaWXbC3xr9/i38d0gTEfX9j0/dwUGxsxtA7YZuPALhdPXVohHaVJl3WPeTvenT/KCCKQ1WtXxjjezBRwgoa/BXPNcC0iwZXtzSnOPn0yDTh8iWgPsxfWfaOkjAbzR++rpj5mAauAQp/jpHJ2UEXzSnb8NsQucPofal4rs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(39860400002)(376002)(396003)(136003)(451199015)(5660300002)(8936002)(44832011)(8676002)(66476007)(4326008)(66946007)(66556008)(2906002)(38100700002)(41300700001)(31686004)(6486002)(54906003)(478600001)(110136005)(316002)(26005)(2616005)(36756003)(6512007)(6506007)(186003)(53546011)(4744005)(82960400001)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGNLOEZuQzBqS3BTR0hlbFdOQ1gvdkwzU2tMTFl1a2NMUG42c3ZkK0o1Rkw2?=
 =?utf-8?B?QTVheXBMTHFPckRJMUZDc01ndHd6cHY3QllLT2t6K0tJeGlyc01UL2ZEcGVi?=
 =?utf-8?B?c2IyRERUVjJXY1lCOXhJQzNxblRxS2Z2Uld5LzA5ci95U3NGYWZIM1JDdVZQ?=
 =?utf-8?B?cTVyRkNLVHRLS1dUdVVreG1tMDc3bnltY2IwUzJDcE1paW8wZzV1UW9zTzha?=
 =?utf-8?B?clNtUUpnSUp2UnFGVUVtcXVrRUVRTGMrUi90YkRMdUU3VVZoRUxuV2U4M0xP?=
 =?utf-8?B?SUxpZElzQmg5WDJLNFM4elBZNE8vK1g3VlRKL2xPa2x5eTFiSzQvVmRxYVpU?=
 =?utf-8?B?azIxSE9aQkNtRFkwWXovWFQ1Nmk5cFEvS25vN3czV21tRFRnOTA5bmdraC9Z?=
 =?utf-8?B?VEd2QkFIa1ZUUkEzbHJGbU16Qjg4eWhkRHZCWW1KUmJFVUhXMDluVGRmTnRq?=
 =?utf-8?B?a0VGUmhkd3UwTG1pT1J6cDB5a3RJL1NtVmxIY3hxVEJFbU5FWHVIZ3cwMHIv?=
 =?utf-8?B?SFhQOHpseGFTQ3lvN0pLM1hRNVNJdDBROWlhbExHOFlaVlJFUTJOTk5TMTYz?=
 =?utf-8?B?d1oyM0pyb0VtZ2prOUViWVhZUTZZS0hOM0lsbUlkdjhKOHhnOE5VM1d6c215?=
 =?utf-8?B?WEc5MEc2TzJKQ1BNM2c0K29XYVo3Y3YyWVc2bGFQUklVRU1uY2RSaEtmS3hv?=
 =?utf-8?B?TWhXS3FuUFpLQzlicFR6UEE5enJpZTFmU1FJV3JiK25xNy8wYTRYNGpVaHlN?=
 =?utf-8?B?OERBQmhXb0tQcW50elRKMHUrMnNxOEFEQ1VWQTVkRGwwQXRPQVdod0diM3Bs?=
 =?utf-8?B?dE5CTEFzSVZxRTUrZW8xbWhELzM1TlVZM2dTcjVyOExNS3dTN2I1aE45Y1pG?=
 =?utf-8?B?c2FGQmNWa2xDQjduSXQvUDZObFFoQXpjWE5QV2hiY0w0YjN3Qm12UXVweFBT?=
 =?utf-8?B?OUYvNDM1V1M1LzBJWHk0amFVOUVUMEZwTm9UMUQ1UVNOaDhkL1NJdHEvdUg2?=
 =?utf-8?B?emJ4V3NHSFY1TGExczkxQ2RwaGFFS2ZzRlpqOTRiSXhybWl5akg2d2x2ODNv?=
 =?utf-8?B?bVhKaHVBdFhaVmcva0NSQnF3NnBlY2x1OENJMFEzN0xCd2ljeHlxU2c0NHRm?=
 =?utf-8?B?RXdrQ0FvcThUNEVXWGg3UUVXTzhIZGZ6eWRkTDFnOTl0N052d2xFc09FdzNV?=
 =?utf-8?B?UTdWdTJjZDhwVnhYTStyVlJDSnFHa2QzdGN6by9hZ1ZsaERnalBqK2hnMndX?=
 =?utf-8?B?ZTdaRGt2eUlBRmJCYTVVY0Q4RzFpVndNajNKYlloU3FyRkFQcW9BOGI0OXVu?=
 =?utf-8?B?blo5Wndwa0ZSNyt6TXI0d3FZQlA3Wlk3NlVOMDExYnJRQXFQeG5vRUNpNGJo?=
 =?utf-8?B?eCtKOWUydFNwS2YyNUJVcEtPRWRGMDZpUGZ3aHVpSVNZMVpzb0ZjMGdoTXlz?=
 =?utf-8?B?N2pZT0N1Uis3MEFpMFpCb2FTSmVSYyt4SzVjRk41Z2xQVWJ5V2Vsa1lvVGNB?=
 =?utf-8?B?NjYyQzlneUtTbGtnK28rYWNPb1NjanNDdHFXU3lBOW1yTVdQWENlcWVwaDZC?=
 =?utf-8?B?a0JSOUNQZzd1M0xiYUlpK3ZSNlNIRjdiTFFsazQ4V1lmQllndEJVaW5MS3dr?=
 =?utf-8?B?ZW83M0cvdld3ckJOOHJNNElXZjN5OURNQU0wYVRuaHpTUnRLVnZjdW9QMkRF?=
 =?utf-8?B?TUNEK3FzWW9GRFBEUHowUEZzbCtTRFlPSmpjK2xjTFhMOExHcWI1cllqQXRq?=
 =?utf-8?B?ZmMyOTlYby9YRVJ6SVBIVDJWb0x2RVQ4TnpFWmJzZHVhaUpPMmhWZlF3UmZ6?=
 =?utf-8?B?S3FkU1k5QlJrS2J1Nm9mOEVJL2pkUDlUZjArT0E4T0VJRUxpNXk0czlRR1Bp?=
 =?utf-8?B?NHBFZXM0b1hIaWt3THdBRXdKUnlrOGcrV3JQZ3l0WEZCRkU3anRKaGl5eFh3?=
 =?utf-8?B?eXhIc1RxWGRZbjExQ0lVQzQ4dEN2ODhlUWxCOHBaNURBRjRkYktyeENYWWg5?=
 =?utf-8?B?Y3AvcjZtc1ViUk1pKzhoMVF2alFFQjNiRkJ1L01aMTEvc3Y1T29BUzhsNjBX?=
 =?utf-8?B?TE9QTFJhbkFTYjNJRHBJenM1YlhiMDJLMFc1SkRqT1g2VnFESGZoTXRJK2J4?=
 =?utf-8?B?SGlNWmx2WWQrUE5Qdk9GVWJVSExZRVJEREtiTy9WZ3VTT2tCWUFuazVEakFT?=
 =?utf-8?B?SGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a760945c-8353-42d1-89c5-08dad2f0ab61
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 16:33:53.7657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8f6MlLO49Ybry+vKUYDmIlRet9b6D8BYPtMhWE+e7i0YaoHsWW6YLJ+EjQwcYqM3xCI3ZcLUu6HvaI5m2wH35nkp0awSkIMeWglpTqLcTXA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7688
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shaopeng,

On 11/30/2022 12:32 AM, Shaopeng Tan (Fujitsu) wrote:
 
> Removing ctrl_handler() is only part of the fix in the next version(v5).
> All fixes as follows.
> 
> --- a/tools/testing/selftests/resctrl/cat_test.c
> +++ b/tools/testing/selftests/resctrl/cat_test.c
> @@ -98,12 +98,17 @@ void cat_test_cleanup(void)
>         remove(RESULT_FILE_NAME2);
>  }
> 
> +static void ctrlc_handler_child(int signum, siginfo_t *info, void *ptr)
> +{
> +       exit(EXIT_SUCCESS);
> +}
> +

Could you please elaborate why this is necessary?

Reinette
