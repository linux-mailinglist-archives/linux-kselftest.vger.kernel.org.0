Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAE058727F
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Aug 2022 22:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbiHAUwi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Aug 2022 16:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234425AbiHAUwh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Aug 2022 16:52:37 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8555F13FA3;
        Mon,  1 Aug 2022 13:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659387155; x=1690923155;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZGjFU1x0R5N86+q+tOTvhXdaseKgl/v1u02OkY5drTg=;
  b=JFluqdfM2AXX0L0/w9jJQUvx4WGndFkE7AZvV5A7SFEuMUe31kYiWUbd
   UAom61w3b9/zYJ7rMWx0pFHs6dLkKjnvQMmuckxiAI9js6oRibssJeFrp
   lYS0iuvCu5UbWhjROcETOUlgJnUurGeP4s38+uXsiDpkyrFyFOsJtBBmp
   yd+r0dAvxUW1Ye6lGvuBMF84xEnR+yPqZwhzLdWfWp/K64pSOGHiwkzRN
   tGR3ql02jfEDma5Nagvkha/SZlqEQDNgd3eNXRiwAnYHQqbjcDXq4nQyY
   32AZLW3sXcy1oXil5KNLTD46+ojI1ECm2ejr3inK//3ZCiW/CTkJY4JbE
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="276153485"
X-IronPort-AV: E=Sophos;i="5.93,209,1654585200"; 
   d="scan'208";a="276153485"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 13:42:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,209,1654585200"; 
   d="scan'208";a="577927058"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga006.jf.intel.com with ESMTP; 01 Aug 2022 13:42:10 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 1 Aug 2022 13:42:09 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 1 Aug 2022 13:42:09 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Mon, 1 Aug 2022 13:42:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOJFjscVSGBYYMTN1xi9wIVMjfoMNuoYGqopfRfa+I3oInsPi2eU1tQl3epzlNm73C3pYufbbsSNi1ccGvbeUy7RdGD6+Ypd/jHwQbSrjQa6cJ2qoNbvkCewGK9uG/Ub3FpWDGZ/zTWidCc8bRz9wUeNO/DEB7wPUBdS/kUmX0kcGKOxnzwqi91pe3clo/DzETWTM0XSqggdgzgr7dzCfCoxvoFpTmom2hoIYBHjiBSVg0X62T+wS0ZJCXmEYFT/MUH9Wgn2D0LN9V1krbM7IPqletdD4b0ZTGBjRkIgk7fOkUKfBvb9aj4mSmSopQ9GDoqMCJCK8v1Ww7NkctI2CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IOQZFuNXcc7Dc2r6E6kAZoOTHrYeJ7oeeJw0xYxSp+s=;
 b=lOL44cxiCTcpax5Udejc0COLsP6xoOtSUxbno1PDpm+C6RIEEYbkbMcPGC0hHDZtzAYbXvq0wE/yTAu3ql8Ss8lS/edXR/uPVdP8RIw5PGt4RUpbVGnBfXwvglyEVT0n6VMjRcsgMCCH5tuyR7sv9YzhN/Nx0X7cvqtmttJg/MCgzQ2fCKSY41fhdvcoZUsQSn9GSuUkRIwJIHqxuBZjBwSRwJicnnwhOE34JvRjmrwII/4UbIIa8wao9YM/e/DPOGUx029mWcA/dGxj2dVczsIda2DsDij6g4V0Qu9RY4rP062DFjiFc0JDCbequ9FUgPbqRpMNHqx5+sNvG6tdsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by MW5PR11MB5761.namprd11.prod.outlook.com (2603:10b6:303:195::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Mon, 1 Aug
 2022 20:42:06 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::e5bc:d418:aa62:955c]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::e5bc:d418:aa62:955c%9]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 20:42:06 +0000
Message-ID: <aa03b329-ba27-d0bd-932b-7b1e884cca9d@intel.com>
Date:   Mon, 1 Aug 2022 13:42:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [selftests] a37ddddd86:
 BUG:KASAN:use-after-free_in_firmware_upload_unregister
Content-Language: en-US
To:     kernel test robot <oliver.sang@intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <lkp@lists.01.org>,
        <lkp@intel.com>
References: <YuOHivPKKyhPBXv2@xsang-OptiPlex-9020>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <YuOHivPKKyhPBXv2@xsang-OptiPlex-9020>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0360.namprd04.prod.outlook.com
 (2603:10b6:303:8a::35) To DM5PR11MB1899.namprd11.prod.outlook.com
 (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7931dd76-7a31-4053-f973-08da73fe4be4
X-MS-TrafficTypeDiagnostic: MW5PR11MB5761:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5CJCkNDliDaPT01BQpCLmPjCQDGGjiGSe3jsrTHlP6HFmDt2I+ieoqaiRpdrk9K2d6OR4HaPhw6s5ILEjtNX36kXnO2UV5WdCiLGUyzvPUjHEFCAbplLRValSgEjk9YElbu5Y9HBRzPdilyxeHdzaQPPf1ZJEb9yCnleXzrqWAbgOI+4DoEHJS5ASDOAhfsWTv2FaSufF99PdvbbtYg2cyUZRpWYcDAw/KBfM0ECSEkCIS+mpqxHT3qe3vw5olk8gUeUfnQcBjgWeoBNP08aZT67guNjDkVdi06vaV5o2H1INtXjFWPFnrj9vO96dFe3qaXugK6iQ2mUWbhrGC/bgb5CfBTwqXK2NY51WJ5VJutBbtTgLWzeJPsa8EPNc78yQ0K5tkS8Wmh6KUdnnL9SdPxaVdjjT19KbY58i7cxnzdEaEhaFeCZlARyxF5OA8kW0r/5uarRQ6Dq1YIX8tx2s8FjqElonAo7UGm+9oMHlCN6jmeeEXxUu4AxhXGUwBK7ABxxfX9VZCz9srgS7P7057RLu803YZMogyVJW6b91V627qMtbz91o28vSnYZs80rl2i539P+v6FKjDTo0MTR9OjxmYhkjjsU8UGEiQkEDpdS31iqLlYn9+6RCxXFAmvkSGjyp3GZqx3tC6MnqqXqMfgRNM8d4PoRH+OLat3oiuuzqeyD/cvG4tqJ7iAZ/y3LhK9m1rMH2IKSispI7GNs2yLnjA7eCF2QxDJit59i4NeM8K1n4c69QipE5jfBtI7uOueD3kJLTDaoJ3KduhtRJZxj4emhBfBcB7vqG/RL2e0VL+XGwkEfNSzNDJyl/Jjw1jcuSRTEKeHWFSam3Qq8h4DjSocALNg3aqUiHe/4VXKuBv6oTkZxltwMqlxqeQ4RN6lsUp3TvPfR6bn9SlI6Cg/+n+RQCdLpErj/D7NQzHJAADhOOoLC/byItPa6/k/p
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(39860400002)(396003)(136003)(376002)(38100700002)(82960400001)(6512007)(31696002)(6506007)(86362001)(83380400001)(26005)(6666004)(53546011)(2616005)(66556008)(66476007)(8936002)(186003)(4326008)(8676002)(6862004)(5660300002)(2906002)(36756003)(31686004)(6486002)(30864003)(66946007)(6636002)(966005)(316002)(41300700001)(54906003)(478600001)(37006003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUl2anBYUnNmTkVkek12N05YcEVoRldPamV3VEVUZ0NrWXRRU3dFLy9HekM5?=
 =?utf-8?B?Nk9tdjl3M2pzOVZnMit2UnJwV2EyOUxuTWpMaDhUL1JXQ0JrTEcxTlN2bEtX?=
 =?utf-8?B?QkQycVZEVUNKWllVVVlDMXlsSmhMKy9wSnFYSFlyVTZrdDNOSXJUNGVjSDUy?=
 =?utf-8?B?MXZQWUR0NDZ1K0tzbm9WQ2ZET3hOeEJIbTBYdGNFckc5dm1ROEtaNkYxK0Yw?=
 =?utf-8?B?bUptNWdJQ1BkbDJzT0d4eXFDckRLSURWTmF2L1RERVFoWjg2djU1SFNZeEh1?=
 =?utf-8?B?c2FBa2RLM2NQdlRqZ0ZQNUpYckhJS1J3NWp1NWlVQzM0V0NvaVdJd2dXc2dt?=
 =?utf-8?B?RlhLOFdxMjZaZHZEd1dndm9DMWhGMGJsTWwzdjd5ZXFqNFZKbzNMYlVEbFBp?=
 =?utf-8?B?ZUgybVVSS0g4a0grUytMYnljaUF5K0IrVjJNZjl3S0lsSmlPTFBkQURjTTZm?=
 =?utf-8?B?amJ2N0VITGpzN3FnT05JYUwyWUhQVFVRaVZjQnNDVnREZ2NYY0VHR0VtTW9y?=
 =?utf-8?B?VTBCa2JZRStNeGVHQTd2UHFmdWUzZ2dyR0IwRytnU0ZNby9RbXc5Ni8yMGJH?=
 =?utf-8?B?Rlo0QzR0ZkZXNDZxYkxlblZVbmNhblpkWHdJd2o0L2s3TlNDbGFmQlBWMXVs?=
 =?utf-8?B?WmU2YndoUGwzTkx4Q0V3U1NIVEhUZVZvU3FXWkUwclVPZ3M2VG4wWWVVbUpr?=
 =?utf-8?B?dGlUWHREUVhYbVpQclMxTU9reFgwWUoybW9INlZxTjlaTWNIZm9aam8rMlJt?=
 =?utf-8?B?Q0tOZDJBMGtwYW83cGVQTmExRGdJNHdZUVZ3QlcrSWtiUHBscm14SmtGcHJu?=
 =?utf-8?B?dnVseWZ6dDNzeDZEWHR1UThPTURYNURCS2tXNURjYUVMQ0xLcFdLYWpYM1dI?=
 =?utf-8?B?cGswY25mZHd2M2ZPc0UwQ2VEbjJvY3UyRGl2MWMxc2NCT1JjQ1dtbFVPc0Zw?=
 =?utf-8?B?emFjeGpPNlFGY05BZktOL01Tbk5PQXRaWksxbVc4a3dBN3NsMS9nZHk3UUFp?=
 =?utf-8?B?MnFXVmV0b0lrclU4cUsvdnBBckdLaFpRUXpraC82dW9PTkJjcVZBZUUybDBs?=
 =?utf-8?B?ZFBTMXRNSkhuZEFHZE5HL095UHlZMlVZSGw3a0h5cmxab2hIL2hvbnJPU0la?=
 =?utf-8?B?RkZBVGl3clRQU0FPNmxUYUw5b3BFZHk4MU9tKzlGOVY5azF3V01tQTdkN2lJ?=
 =?utf-8?B?dktzYkc3Z1hCS3Y2c1lhSjRqZTA4aDh4TkVQTTN4OUgzcnM2WkpmVVFIS0NB?=
 =?utf-8?B?aS9UM0FmVGkwQmZRWXJRdUE1bHJDZUNVbkowOWc0RkhaWUJMTEw0NFk2cWVn?=
 =?utf-8?B?RjZDelRmZ3NOZFloYUVJVXdzU0FJTmNCU2gveUVicDk4azA1dzdxeTlwbEVw?=
 =?utf-8?B?UGY1cThGcmRibWhGL1dLWjE4bWhodEhyNzl6Yi9nMjE0TmtZVmkrOVFYWnJq?=
 =?utf-8?B?dnpMbWROd0JJWVZ1TVViQ2pFR0xaMThsL3F4VFN1Z2wvWmc4MHg2dlVreFU0?=
 =?utf-8?B?MndvYzZiNUNSMlVJNWFkcHp3dytjbDJHWGFLWkgzZTg3b2FVbVgwM1Q0ZUFi?=
 =?utf-8?B?MzFmVDNQZGpCK3U4bXVCWnZWMkllZXhIaW9pcGFhMUp6SXg3ZFBZNS8zRVB0?=
 =?utf-8?B?enpZS29ZdG4wdXZ6YkpBYXNGSDBTbDBDdms5RTBVYUdpNkZSTldzWkxxVnpX?=
 =?utf-8?B?OGg1OTQwUGZjblcxamExWFZLTVpQQmdib0pHMlFpeUlOaHJxNElGdjNXWlhH?=
 =?utf-8?B?VHhyS3o0ZGtNVlo5aHFDZnorWFNDNm1KZWtVblZhSUw2bGh3RGRBWWhhYW5u?=
 =?utf-8?B?S1pCd283ZkZzK09hdUJ5eThMVERYL0l5aERsaEp2UWl6NVpPekpwbklxNnhO?=
 =?utf-8?B?c3oyU1NyNzE2UXcyQzh2RjUvdGxxQ3pqcnB3bzZlUlFUUEVkNU1uM3VWUTJO?=
 =?utf-8?B?Z2dTVGxvZFRVSTg0cnpCSmxwM04rVk0raDIvYm1MOVZ2MVlPcWQ2V0ZaVXJw?=
 =?utf-8?B?bGpmMmNPdjFPb1JWSjBaanRuc1U0WGdvTExad3NYaWMxaTJabHVnUzZpVDdR?=
 =?utf-8?B?UWk0bDVLVVZFMWxFQklqc3cyZm11VmJGM0tFb09Fd1EvUG5YemtoeHBMK0lJ?=
 =?utf-8?B?dW95bExkU1ZLUVdtMHprYkFHKzg0RnlocnBYdUF2V1lSWHNHbWdsUGUxQmVo?=
 =?utf-8?B?REE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7931dd76-7a31-4053-f973-08da73fe4be4
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 20:42:06.0249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +tVyakJH+n+N4fqv4XtLuvmU1ZC1XbLyIdgLTJgvf2soDUicl0DfwnHMbgzWCfS2dzXxkBSq+a8T6PVgSeOnOXBC6RvHBXZfuPdesRxohA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5761
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Oliver,

On 7/29/22 00:08, kernel test robot wrote:
>
> Greeting,
>
> FYI, we noticed the following commit (built with gcc-11):
>
> commit: a37ddddd86037c896c702b4df416bc4e51b2a5a0 ("selftests: firmware: Add firmware upload selftests")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
> in testcase: kernel-selftests
> version: kernel-selftests-x86_64-4cb0bec3-1_20220724
> with following parameters:
>
> 	group: firmware
> 	ucode: 0xec
>
> test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
> test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
>
>
> on test machine: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz with 28G memory
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>
>
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
>
>
> [ 103.520572][ T2443] BUG: KASAN: use-after-free in firmware_upload_unregister (drivers/base/firmware_loader/sysfs_upload.c:395) 
> [  103.520579][ T2443] Read of size 8 at addr ffff8881e186c808 by task fw_upload.sh/2443
> [  103.528481][  T395]
> [  103.534696][ T2443]
> [  103.534698][ T2443] CPU: 7 PID: 2443 Comm: fw_upload.sh Not tainted 5.18.0-rc2-00036-ga37ddddd8603 #1
> [  103.534701][ T2443] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.2.8 01/26/2016
> [  103.534703][ T2443] Call Trace:
> [  103.534705][ T2443]  <TASK>
> [ 103.534707][ T2443] ? firmware_upload_unregister (drivers/base/firmware_loader/sysfs_upload.c:395) 
I believe I understand the problem, but I have been unable to reproduce the error to verify the fix:

394         device_unregister(&fw_sysfs->dev);
395         module_put(fw_upload_priv->module);

The device_unregister() call could result in the dev_release
function freeing the fw_upload_priv structure before it is
dereferenced on line 395. Copying fw_upload_priv->module to a
local variable for use when calling device_unregister()
should fix the problem.

> [ 103.534713][ T2443] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 4)) 
> [ 103.588011][ T2443] print_address_description+0x1f/0x200 
> [ 103.594406][ T2443] ? firmware_upload_unregister (drivers/base/firmware_loader/sysfs_upload.c:395) 
> [ 103.600112][ T2443] print_report.cold (mm/kasan/report.c:430) 
> [ 103.604782][ T2443] ? do_raw_spin_lock (arch/x86/include/asm/atomic.h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qspinlock.h:82 kernel/locking/spinlock_debug.c:115) 
> [ 103.609624][ T2443] kasan_report (mm/kasan/report.c:162 mm/kasan/report.c:493) 
> [ 103.613861][ T2443] ? firmware_upload_unregister (drivers/base/firmware_loader/sysfs_upload.c:395) 
> [ 103.619561][ T2443] firmware_upload_unregister (drivers/base/firmware_loader/sysfs_upload.c:395) 
> [ 103.625091][ T2443] upload_unregister_store (lib/test_firmware.c:1060 lib/test_firmware.c:1321) 
> [ 103.630377][ T2443] ? sysfs_file_ops (fs/sysfs/file.c:129) 
> [ 103.635046][ T2443] kernfs_fop_write_iter (fs/kernfs/file.c:294) 
> [ 103.640145][ T2443] new_sync_write (fs/read_write.c:505 (discriminator 1)) 
> [ 103.644642][ T2443] ? new_sync_read (fs/read_write.c:494) 
> [ 103.649225][ T2443] ? ksys_write (fs/read_write.c:644) 
> [ 103.653463][ T2443] ? rcu_read_unlock (include/linux/rcupdate.h:723 (discriminator 5)) 
> [ 103.658057][ T2443] ? lock_is_held_type (kernel/locking/lockdep.c:5382 kernel/locking/lockdep.c:5684) 
> [ 103.662909][ T2443] vfs_write (fs/read_write.c:591) 
> [ 103.666984][ T2443] ksys_write (fs/read_write.c:644) 
> [ 103.671057][ T2443] ? __ia32_sys_read (fs/read_write.c:634) 
> [ 103.675645][ T2443] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4501) 
> [ 103.682051][ T2443] ? syscall_enter_from_user_mode (arch/x86/include/asm/irqflags.h:45 arch/x86/include/asm/irqflags.h:80 kernel/entry/common.c:109) 
> [ 103.687756][ T2443] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
> [ 103.692010][ T2443] ? pick_file (fs/file.c:660) 
> [ 103.696165][ T2443] ? do_raw_spin_unlock (arch/x86/include/asm/atomic.h:29 include/linux/atomic/atomic-instrumented.h:28 include/asm-generic/qspinlock.h:28 kernel/locking/spinlock_debug.c:100 kernel/locking/spinlock_debug.c:140) 
> [ 103.701094][ T2443] ? syscall_exit_to_user_mode (kernel/entry/common.c:129 kernel/entry/common.c:296) 
> [ 103.706539][ T2443] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4501) 
> [ 103.712929][ T2443] ? do_syscall_64 (arch/x86/entry/common.c:87) 
> [ 103.717343][ T2443] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4501) 
> [ 103.723747][ T2443] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:115) 
> [  103.729451][ T2443] RIP: 0033:0x7f1020308f33
> [ 103.733709][ T2443] Code: 8b 15 61 ef 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 48 89 54 24 18
> All code
> ========
>    0:	8b 15 61 ef 0c 00    	mov    0xcef61(%rip),%edx        # 0xcef67
>    6:	f7 d8                	neg    %eax
>    8:	64 89 02             	mov    %eax,%fs:(%rdx)
>    b:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
>   12:	eb b7                	jmp    0xffffffffffffffcb
>   14:	0f 1f 00             	nopl   (%rax)
>   17:	64 8b 04 25 18 00 00 	mov    %fs:0x18,%eax
>   1e:	00 
>   1f:	85 c0                	test   %eax,%eax
>   21:	75 14                	jne    0x37
>   23:	b8 01 00 00 00       	mov    $0x1,%eax
>   28:	0f 05                	syscall 
>   2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
>   30:	77 55                	ja     0x87
>   32:	c3                   	retq   
>   33:	0f 1f 40 00          	nopl   0x0(%rax)
>   37:	48 83 ec 28          	sub    $0x28,%rsp
>   3b:	48 89 54 24 18       	mov    %rdx,0x18(%rsp)
>
> Code starting with the faulting instruction
> ===========================================
>    0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
>    6:	77 55                	ja     0x5d
>    8:	c3                   	retq   
>    9:	0f 1f 40 00          	nopl   0x0(%rax)
>    d:	48 83 ec 28          	sub    $0x28,%rsp
>   11:	48 89 54 24 18       	mov    %rdx,0x18(%rsp)
> [  103.753040][ T2443] RSP: 002b:00007fffe4075988 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> [  103.761244][ T2443] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f1020308f33
> [  103.769013][ T2443] RDX: 0000000000000003 RSI: 00005582df845b80 RDI: 0000000000000001
> [  103.776791][ T2443] RBP: 00005582df845b80 R08: 00000000ffffffff R09: 0000000000000003
> [  103.784561][ T2443] R10: 00005582df833c80 R11: 0000000000000246 R12: 0000000000000003
> [  103.792328][ T2443] R13: 00007f10203d96a0 R14: 0000000000000003 R15: 00007f10203d98a0
> [  103.800100][ T2443]  </TASK>
> [  103.802957][ T2443]
> [  103.805125][ T2443] Allocated by task 2443:
> [ 103.809276][ T2443] kasan_save_stack (mm/kasan/common.c:39) 
> [ 103.813781][ T2443] __kasan_kmalloc (mm/kasan/common.c:45 mm/kasan/common.c:436 mm/kasan/common.c:515 mm/kasan/common.c:524) 
> [ 103.818190][ T2443] firmware_upload_register (drivers/base/firmware_loader/sysfs_upload.c:160) 
> [ 103.824150][ T2443] upload_register_store (lib/test_firmware.c:1279) 
> [ 103.829250][ T2443] kernfs_fop_write_iter (fs/kernfs/file.c:294) 
> [ 103.834350][ T2443] new_sync_write (fs/read_write.c:505 (discriminator 1)) 
> [ 103.838846][ T2443] vfs_write (fs/read_write.c:591) 
> [ 103.842910][ T2443] ksys_write (fs/read_write.c:644) 
> [ 103.846975][ T2443] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
> [ 103.851217][ T2443] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:115) 
> [  103.856932][ T2443]
> [  103.859100][ T2443] Freed by task 2443:
> [ 103.862907][ T2443] kasan_save_stack (mm/kasan/common.c:39) 
> [ 103.867415][ T2443] kasan_set_track (mm/kasan/common.c:45) 
> [ 103.871822][ T2443] kasan_set_free_info (mm/kasan/generic.c:372) 
> [ 103.876579][ T2443] __kasan_slab_free (mm/kasan/common.c:368 mm/kasan/common.c:328 mm/kasan/common.c:374) 
> [ 103.881331][ T2443] slab_free_freelist_hook (mm/slub.c:1754) 
> [ 103.886517][ T2443] kfree (mm/slub.c:3510 mm/slub.c:4552) 
> [ 103.890156][ T2443] fw_dev_release (drivers/base/firmware_loader/sysfs.c:102) 
> [ 103.894483][ T2443] device_release (drivers/base/core.c:2235) 
> [ 103.898902][ T2443] kobject_cleanup (lib/kobject.c:677) 
> [ 103.903492][ T2443] firmware_upload_unregister (drivers/base/firmware_loader/sysfs_upload.c:395) 
> [ 103.909034][ T2443] upload_unregister_store (lib/test_firmware.c:1060 lib/test_firmware.c:1321) 
> [ 103.914311][ T2443] kernfs_fop_write_iter (fs/kernfs/file.c:294) 
> [ 103.919429][ T2443] new_sync_write (fs/read_write.c:505 (discriminator 1)) 
> [ 103.923927][ T2443] vfs_write (fs/read_write.c:591) 
> [ 103.927990][ T2443] ksys_write (fs/read_write.c:644) 
> [ 103.932054][ T2443] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
> [ 103.936290][ T2443] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:115) 
> [  103.941992][ T2443]
> [  103.944159][ T2443] Last potentially related work creation:
> [ 103.949704][ T2443] kasan_save_stack (mm/kasan/common.c:39) 
> [ 103.954216][ T2443] __kasan_record_aux_stack (mm/kasan/generic.c:348) 
> [ 103.959400][ T2443] insert_work (include/linux/instrumented.h:71 include/asm-generic/bitops/instrumented-non-atomic.h:134 kernel/workqueue.c:635 kernel/workqueue.c:642 kernel/workqueue.c:1361) 
> [ 103.963552][ T2443] __queue_work (kernel/workqueue.c:1520) 
> [ 103.967888][ T2443] queue_work_on (kernel/workqueue.c:1546) 
> [ 103.972141][ T2443] fw_upload_start (drivers/base/firmware_loader/sysfs_upload.c:263) 
> [ 103.976723][ T2443] firmware_loading_store (drivers/base/firmware_loader/sysfs.c:213) 
> [ 103.981910][ T2443] kernfs_fop_write_iter (fs/kernfs/file.c:294) 
> [ 103.987022][ T2443] new_sync_write (fs/read_write.c:505 (discriminator 1)) 
> [ 103.991537][ T2443] vfs_write (fs/read_write.c:591) 
> [ 103.995604][ T2443] ksys_write (fs/read_write.c:644) 
> [ 103.999673][ T2443] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
> [ 104.003930][ T2443] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:115) 
> [  104.009631][ T2443]
> [  104.011800][ T2443] Second to last potentially related work creation:
> [ 104.018219][ T2443] kasan_save_stack (mm/kasan/common.c:39) 
> [ 104.022727][ T2443] __kasan_record_aux_stack (mm/kasan/generic.c:348) 
> [ 104.027938][ T2443] insert_work (include/linux/instrumented.h:71 include/asm-generic/bitops/instrumented-non-atomic.h:134 kernel/workqueue.c:635 kernel/workqueue.c:642 kernel/workqueue.c:1361) 
> [ 104.032101][ T2443] __queue_work (kernel/workqueue.c:1520) 
> [ 104.036423][ T2443] queue_work_on (kernel/workqueue.c:1546) 
> [ 104.040658][ T2443] fw_upload_start (drivers/base/firmware_loader/sysfs_upload.c:263) 
> [ 104.045240][ T2443] firmware_loading_store (drivers/base/firmware_loader/sysfs.c:213) 
> [ 104.050423][ T2443] kernfs_fop_write_iter (fs/kernfs/file.c:294) 
> [ 104.055522][ T2443] new_sync_write (fs/read_write.c:505 (discriminator 1)) 
> [ 104.060016][ T2443] vfs_write (fs/read_write.c:591) 
> [ 104.064081][ T2443] ksys_write (fs/read_write.c:644) 
> [ 104.068144][ T2443] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
> [ 104.072381][ T2443] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:115) 
> [  104.078083][ T2443]
> [  104.080249][ T2443] The buggy address belongs to the object at ffff8881e186c800
> [  104.080249][ T2443]  which belongs to the cache kmalloc-512 of size 512
> [  104.094049][ T2443] The buggy address is located 8 bytes inside of
> [  104.094049][ T2443]  512-byte region [ffff8881e186c800, ffff8881e186ca00)
> [  104.106914][ T2443]
> [  104.109084][ T2443] The buggy address belongs to the physical page:
> [  104.115315][ T2443] page:0000000037a5888d refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1e1868
> [  104.125336][ T2443] head:0000000037a5888d order:3 compound_mapcount:0 compound_pincount:0
> [  104.133454][ T2443] flags: 0x17ffffc0010200(slab|head|node=0|zone=2|lastcpupid=0x1fffff)
> [  104.141498][ T2443] raw: 0017ffffc0010200 ffffea0005491e00 dead000000000002 ffff888100042c80
> [  104.149885][ T2443] raw: 0000000000000000 0000000000200020 00000001ffffffff 0000000000000000
> [  104.158274][ T2443] page dumped because: kasan: bad access detected
> [  104.164492][ T2443]
>
>
> To reproduce:
>
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         sudo bin/lkp install job.yaml           # job file is attached in this email
I have tried these steps on Fedora35 and on CentOS Stream. In both
cases I have missing packages that I have not yet resolved:

Error: Unable to find a match: arping lib32gcc-dev libc6-dev-i386 libc6-i386 libc6-x32 libhugetlbfs-dev libmnl-dev libmount-dev libpci3 libreadline-dev libx32asan5 libx32atomic1 libx32gcc1 libx32gcc-dev libx32gomp1 libx32itm1 libx32quadmath0 libx32ubsan1 linux-libc-dev-amd64-cross netcat-openbsd openvswitch-common openvswitch-switch sendip libpci-dev

Simply running the fw_upload selftests in a loop is not sufficient to
trigger the error. Can you provide additional instructions for
running the lkp tests manually? Do I need a specific OS? How can I
access the missing packages?

Thanks,
- Russ
>         bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
>         sudo bin/lkp run generated-yaml-file
>
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
>
>
>

