Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D655A8738
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Aug 2022 22:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbiHaUHu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Aug 2022 16:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiHaUHt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Aug 2022 16:07:49 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E33C6EBF;
        Wed, 31 Aug 2022 13:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661976468; x=1693512468;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HT62tIMJakZpW/Qoo3dTO9AarZ+iZqBDputEViopdbQ=;
  b=LmX1ahTWRXDWqyQJiPYeSQiitsXCmxPFVLzoY9H7+4fAn3nsGQinrBkb
   6dJZ175MP8S6gbtP9BgUqCJlTxr9m01iD8dscWj1PzHCezvH8pEEnd1eQ
   IIHW27QF3skEZpnHMf/AymPvlZqVeaWAEopkm8JH9KvrZj7zoz/4RzFs4
   Fpm5GBEmGmlupxd4t/kFhtDhjZ+i7EcubuGm3fl9QA+qlGv14NRIGpuTQ
   +R/UY96wZELao3l8wu42IU2lEZhIzC0ZYFLe+25qmfdIaBdWNrwkReRjJ
   kHfZhbwyZS5iiI5Zjs8YVsxi33PWYvD5Om643620P4e8qi80eFmxUuK/F
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="294274252"
X-IronPort-AV: E=Sophos;i="5.93,279,1654585200"; 
   d="scan'208";a="294274252"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 13:07:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,279,1654585200"; 
   d="scan'208";a="608296978"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 31 Aug 2022 13:07:47 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 31 Aug 2022 13:07:46 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 31 Aug 2022 13:07:46 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 31 Aug 2022 13:07:46 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 31 Aug 2022 13:07:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3SBZbkIh+BiPRDr780R24bEWoXZRlj7znqTWE5LxIULJ/V46jRAx/0zz7SbXnYvjUIlwTIC8lBUqS3mykS1lJSs3p9X7J47B8e5Pd8hx/veN/MEdJ9oMYJBhmM4ypxRs2y/q2soGjspphczzo7qPsY1u6dnOgADC3MFaYXU4Me92ckTAHwchijkTyAF/h3RuiGW0bi8GVODDlcP73lzsHSRpGj3GUGgbvtCm/zko784rdwG/adSSncNWa/TRCveNDtSa3bB/gG6sTRkg4mUdfo71EWxAdJCnHuEP8RAAGmPGrx0FaQZoz1mrTsZPmi8xOrfEYoyAClKSUmrQMNeDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PoF18tjz699krIbRHQYhVYiyGFssEtaatan7Nf2I1dk=;
 b=XAr7/4mdmMo8Y990etjgbRadq9xKXg58ad9362rIIHmORSGybzvZBiobOBypaZG2sF6Cr7oHDsddnElRzCI82LxthgXcCDD5zUOI9rLvMvoOK4C0npvf/XnKjLIB/f9jN6UIgEmq13aqLfl3AKxaY4Us79hvcYiD3X/kemIEHHexw786EGfvuMwKBinIyO2FS1ra6wYFhF6O2zUsntYYek/vjd0f2bIGNwBrJIHYPfbn4YSLLgf01zmJyRqL+zm3XxiRM1qlrVivr3+pFJjpkjKvjd917nyMp5ycItvTV2SbOjSuGcbFNGwltAMTJ9MmekoP05z9JyAeNp3agpsHEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DM6PR11MB3116.namprd11.prod.outlook.com (2603:10b6:5:6b::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 31 Aug
 2022 20:07:38 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743%11]) with mapi id 15.20.5566.021; Wed, 31 Aug 2022
 20:07:37 +0000
Message-ID: <d2b76530-82a2-6ac1-32ea-696e653d767d@intel.com>
Date:   Wed, 31 Aug 2022 13:07:35 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.0
Subject: Re: [PATCH v2 4/6] selftests/sgx: Add SGX selftest
 augment_via_eaccept_long
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, <linux-sgx@vger.kernel.org>
CC:     Haitao Huang <haitao.huang@linux.intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Paul Menzel" <pmenzel@molgen.mpg.de>,
        Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220831173829.126661-1-jarkko@kernel.org>
 <20220831173829.126661-5-jarkko@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220831173829.126661-5-jarkko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0361.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::6) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 984be8f6-5cc6-4323-52bd-08da8b8c7382
X-MS-TrafficTypeDiagnostic: DM6PR11MB3116:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PbTfw8xgV/lIwZAb3YycnL4gU7tbz6t9TxQ5rS2Y2xtsY8TPSn+vPBOZ+xd4DHMWW7Jmctk2KEy1WQrZW13NILjLgOXA5ICVPxMTIqWfU8L6+puTcIlkBbKCZVp9IEBG4hqbWZ6351Ud6Xmh8zldMhIR9fxL8LGpX4L/Fn3O5ABYm/E+xAzxCjyde0Jyc4tQwPKHybwDOR90hqnFoQzhRSB31qRlFuneDHOExP3GHaVFtJENIguV2ZUuO0RgMgPzSVovKMt2LP/qMpBdmwfrC4SyXbglJdZD2i/K2sWWk4nvu9CsYTGKPr34v09+ldx38pgnBSdMhQN9qRLogpx9QiR6HdfH4lKVyTxTdtgqERRiZPAR8cjhGl9UqYDtYi+9w5E68MwySnOMVxxz+GA0d9x+jNkVBj9goQ7NZWiRBXMAT5c1osd66NshgqOW7yXHoqIKFJrBxCDL2TIZbFOu7CX+MgXYXgIfuIkWdI92oIXNoGsW5Vhj616DkTqYUypCP3VTwEUWausTC9Z/MG7mV/W7Sohtfyp/z3o0sNnI6/hnwYRlKQ6GBJcenaf/R83/QsFKTZA+ru120Zp20ggEt4YSH4bZcFTiEnBN97zjh02O+yo86OKlJ+c6UonWoTwwRNPnOtmU0MGC5UI7HsKL5cHznnzNNHHagyE5m8Q4H69T3jGa9qmII9Ueq4dsPfTwbaHyedza1HsbKi/68ZnRrQD5yjNh2E+QhPtQrSvNxlL7mcAwVl7uAqIy+zHxL5YAz/QcNeiHCjxGZNki9xkXQNgjhuaf338msi92B+1zpZ9Rt85ofKljKelmwgSzdN0STda2UbfMFbGXt+vU4mTLfQ3oBHWj/iHRaOoy54NUNif/PcmZ9RXNqnPz6NPC3O76
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(136003)(346002)(396003)(376002)(45080400002)(31686004)(66476007)(8676002)(66946007)(316002)(54906003)(66556008)(6486002)(4326008)(966005)(31696002)(8936002)(5660300002)(478600001)(36756003)(82960400001)(86362001)(41300700001)(38100700002)(6512007)(6506007)(53546011)(83380400001)(2616005)(2906002)(26005)(44832011)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1FLSTYyTEs0ZnJDM1FEN29ZQURrazg0SkZkRW4zYkI1clI1SUc3clljVmU5?=
 =?utf-8?B?SnNXQ0pWaW5ZSnRra1h0ZDU0YmZQMmx6RWQ5WEgxVmhXK241U3lWYW1SdHhF?=
 =?utf-8?B?SEFQeDJmTzQycUpsNlpXK0hNWW9DWmJtUzF2cjIxYVZrYXZJWVZ4TU41QmpR?=
 =?utf-8?B?dnBOS1VkL1gyR2F5THJSbWE3MlJGMEladFN6a3BuSEhFNUkrY3p5dTZQcDM1?=
 =?utf-8?B?Vy9sdkVQeEd5bUxHalM5RmNBekpMa2tlZXV3bFRvOG5FMnoyZ3VzMWJZWU93?=
 =?utf-8?B?QVNlQnNmNHAzOFE5UFlONnhpWjlnWmQrRGc0WFZJZGpjb2ZOQnBOQ21vd3NI?=
 =?utf-8?B?YWY4RjlsS1J5NkJDSFhQR0d0R1VRaGVDTGFkNkI2MFltcUd4aXR5bDRmNEZ0?=
 =?utf-8?B?UnRUVGhQNXZhSVkvVU52UFZMZXA2Q25ocDJRSitWRFd2Zit4cWVQYlZUQnV5?=
 =?utf-8?B?MTNWREU4bG5URmhiZkVTd2hKYmJrNHp2b0JyVzNhdFd0UU1BK0pSZllZaEx4?=
 =?utf-8?B?VCswSDFuckVwekVPUUc1cTNpRVBtLzE0ZW1vVzBwaEZSQ2I5RGFzUklvczlh?=
 =?utf-8?B?cXl1SGY2T2hvRloxZTQ4S1NjNkpEV041TjNRcDM5QVJOcjlOSjhRSkh4SDEr?=
 =?utf-8?B?QWFRZ1h4b3BXa0JEMUpUL0JqUkVSdm13bmJGT3cvblVzMmFKOHZYT3RKb2Jr?=
 =?utf-8?B?OHB0U0xXQW9qZnhUcldSRlBMeExocW1wUmwrWWM4RnNzQlhyL3dZQ2kyNDZO?=
 =?utf-8?B?a2YwZ05sbXNDZ1VmOUJjdEI0Nk5COGgxOGFnUFZ5ZmZjRlMxTUgyOUJkSHNs?=
 =?utf-8?B?U2xJZzl5Q0NZS0RnUUMzTDAwTlU0ZVphbjVKYUh1dDBxa0ZFSlY3c2ZGTkdz?=
 =?utf-8?B?eC9Lc1M2UHh0SHNwV0Y3TmdUdDJsK0d3Q0pvd0F3emFhb0pVWEF0ME1lNjVo?=
 =?utf-8?B?dEN0UnNDdUFud1ZGNXJEWnI4NzhadFNyYm1pZ2R6Q2cwRGF4N0dJMjl1NWMv?=
 =?utf-8?B?YkFiamNRaW1nVkJxRCtyQWFKTTJLeit2T2VPemJEQ1YvRWRZamVTcm05Nkp5?=
 =?utf-8?B?SVdLUFlKcCs1VnlMM08yWkRoa0tMMEVPVzU5SFkrZFdSajlqQmUyaVhwSEto?=
 =?utf-8?B?Q1FMWmNoT1lYMU1ZMFFtbVRKK1JjUjJnYVV0M2pwUllNUEdrcGNYcFFyQzRm?=
 =?utf-8?B?ZEdjRkxmSUF6R0F0OGJ3UHhGQnhjc3ZuajVBZUtXWUV2VGhyUnhEZnM1VDJ0?=
 =?utf-8?B?dXpKbFNzaHp4RFUrNXZwUGttWmEzV3BwKzdYbUZSQWVhTW4xUTdzcE5UTU1Z?=
 =?utf-8?B?YTVsNi95c0ZhR3QxY1BWNUJKTG1rSnFLR0ZOZkxkVE1TTkdFeDl1ZnJWampr?=
 =?utf-8?B?dEFaLzFaMHQ3eEw0UlNVeGFzNU1Kdzk4VkFKZEp1bmdBNDBGR0ZUUEFrVEtS?=
 =?utf-8?B?TUhxV1BLVy9KT3M5WklON3dFYzZOQnVWU1RzRUpaeU0yUW1mWmhSQ2JPQW5w?=
 =?utf-8?B?NHlVL2ZWazhuZ3NsekNOcDFBRTY0WFN1dTFjdTdTQ1Z0WDNyZzhuTU0rV3RB?=
 =?utf-8?B?Tkk4SmtKbVBXTElsUXlxZTlldmpkU1JVNkNOMzcwdUhqTGtBUVdERkc4eGRY?=
 =?utf-8?B?akZkT052VTZrMldLMTM5dkR6RlloNW9hYlN1QnBNTkd1MnRlN2R5K0lySU14?=
 =?utf-8?B?RHh3bzJLR25NeGxzcTU3b1FRS0Q4UXJ1S0M2L3NZU0dGcGhLSU5hMWFOVm52?=
 =?utf-8?B?LzN0WEoxQWZaeWFWZEV1RkdGcVl6eW5GZmdOa1dvaEJ1U0lEWS9xWUduc2pa?=
 =?utf-8?B?UEZ0VmxFeEhReXdpTG4xZzFWbDZtbmNMdTZ2ZVprTnRPUVZYWnR6RENlYTdH?=
 =?utf-8?B?SW1OREIyeTNmUXNXSXUyOUgzdmx4OTZzM0xDajJONnlTWnBQSDd5YzZWNWd4?=
 =?utf-8?B?OUJya2lSejd4WnVaZkxDS3FuZXdVa2VaUUNFanE1RTVtWGVrWFNKUE5HRE9j?=
 =?utf-8?B?aXlGRnJkOTlDaUwyeEViVGgxZ1c3emdRMkdLSi9udG9XcGNxT3lpY3RZVldF?=
 =?utf-8?B?S0lJUXN6ZG9rTTZPV3RvVytrdXdtWk9kRGlZUzNzMmdXNmVJY3JEM1hudjVo?=
 =?utf-8?B?OXVpVXhoRkFncGZIc3ZXMGJQUUY0VFZLQU8wb0ZoM1R2SEU5WHhKaXBHNzlo?=
 =?utf-8?B?MUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 984be8f6-5cc6-4323-52bd-08da8b8c7382
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 20:07:37.7980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GpA8/+8sJojTEYPb8bPLTBmKAif8LlbsggDWBZUd9IV79ys/ybxIFDObYZucbjjMvmIyd7PwGdfXXq/OUXoK/mXhvbREymnjdID82icPPGE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3116
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jarkko,

On 8/31/2022 10:38 AM, Jarkko Sakkinen wrote:
> From: Vijay Dhanraj <vijay.dhanraj@intel.com>
> 
> Add a new test case which is same as augment_via_eaccept but adds a
> larger number of EPC pages to stress test EAUG via EACCEPT.
> 
> Signed-off-by: Vijay Dhanraj <vijay.dhanraj@intel.com>
> Co-developed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> v3:
> - Addressed Reinette's feedback:
>   https://lore.kernel.org/linux-sgx/bd5285dd-d6dd-8a46-fca9-728db5e2f369@intel.com/
> v2:
> - Addressed Reinette's feedback:
>   https://lore.kernel.org/linux-sgx/24bd8e42-ff4e-0090-d9e1-cd81e4807f21@intel.com/
> ---
>  tools/testing/selftests/sgx/load.c |   5 +-
>  tools/testing/selftests/sgx/main.c | 143 +++++++++++++++++++++++++----
>  tools/testing/selftests/sgx/main.h |   3 +-

Is this test passing on your system? This version is missing the change to
mrenclave_ecreate() that causes SGX_IOC_ENCLAVE_INIT to fail when I try it out.

>  3 files changed, 130 insertions(+), 21 deletions(-)
> 
> diff --git a/tools/testing/selftests/sgx/load.c b/tools/testing/selftests/sgx/load.c
> index 94bdeac1cf04..47b2786d6a77 100644
> --- a/tools/testing/selftests/sgx/load.c
> +++ b/tools/testing/selftests/sgx/load.c
> @@ -171,7 +171,8 @@ uint64_t encl_get_entry(struct encl *encl, const char *symbol)
>  	return 0;
>  }
>  
> -bool encl_load(const char *path, struct encl *encl, unsigned long heap_size)
> +bool encl_load(const char *path, struct encl *encl, unsigned long heap_size,
> +	       unsigned long edmm_size)
>  {
>  	const char device_path[] = "/dev/sgx_enclave";
>  	struct encl_segment *seg;
> @@ -300,7 +301,7 @@ bool encl_load(const char *path, struct encl *encl, unsigned long heap_size)
>  
>  	encl->src_size = encl->segment_tbl[j].offset + encl->segment_tbl[j].size;
>  
> -	for (encl->encl_size = 4096; encl->encl_size < encl->src_size; )
> +	for (encl->encl_size = 4096; encl->encl_size < encl->src_size + edmm_size;)
>  		encl->encl_size <<= 1;
>  
>  	return true;
> diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
> index 9820b3809c69..c5aa9f323745 100644
> --- a/tools/testing/selftests/sgx/main.c
> +++ b/tools/testing/selftests/sgx/main.c
> @@ -23,6 +23,10 @@
>  
>  static const uint64_t MAGIC = 0x1122334455667788ULL;
>  static const uint64_t MAGIC2 = 0x8877665544332211ULL;
> +/* Message-ID: <DM8PR11MB55912A7F47A84EC9913A6352F6999@DM8PR11MB5591.namprd11.prod.outlook.com> */
> +static const uint64_t EDMM_SIZE_LONG = 8L * 1024L * 1024L * 1024L;
> +static const uint64_t TIMEOUT_LONG = 900; /* seconds */
> +

Apologies if my feedback was vague - I actually think that the comments in V1 added
valuable information, it was just the variation in formatting that was distracting.


Reinette
