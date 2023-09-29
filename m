Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A627B2C33
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Sep 2023 08:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbjI2GJ5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Sep 2023 02:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjI2GJ4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Sep 2023 02:09:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5226B92;
        Thu, 28 Sep 2023 23:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695967795; x=1727503795;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=A1/SjQTZUfmptWMZTEA6dgw2SOuCsC0Wsknvpvd1xvg=;
  b=UqmR7/+wosRWoLM24RdSjLWzFBlGRUdBwxZZMtfqYbBhfosVc4e8dguG
   +q8gsw0w1lPpMi5W+OVuYFA1pp0JH/Ou8T1MhSF3k1diZCVgv2jIGN0Gk
   JB6H/AocaWXRjotum3xcX+O4tcsI4CGV0RJuhkwD7u2LnkXqy0oTXeVW3
   X4bc7AmkMBS5eu8nLWhKm0oNh9VxUdqCfVIUSw/H9Yc4s0KCDzTq3Nh8/
   DrTLD53yAX+BoCGruLfFsbWkFC7oQ+wg7TxVlLu3CU3VErrINU50ybEJE
   OZsIcgL0sreDrtqmknkggWetKopxvR1vOrwHhBNb2rlKxv2QZ02f/hleR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="361617700"
X-IronPort-AV: E=Sophos;i="6.03,186,1694761200"; 
   d="scan'208";a="361617700"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 23:09:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="1080819289"
X-IronPort-AV: E=Sophos;i="6.03,186,1694761200"; 
   d="scan'208";a="1080819289"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Sep 2023 23:09:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 28 Sep 2023 23:09:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 28 Sep 2023 23:09:53 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 28 Sep 2023 23:09:53 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 28 Sep 2023 23:09:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mIWJwaHLQnebUBaYHNac2jINYOfsxtLGX5c8HVTnC3x8DSR0OwH1x6fQi6R25LGshGeEjmPoCeCdElNfGrTc6fyA2VJjiJmce/7J4Q08TAX9dNwKVORUEwQ0mVNdLbqtuDPBO366zFK/ErWBYruzfm8b0o264Z+0FHyG4r2vbzhwIlHB3F7SUso6sZ/ZKqJwomBW3CAGw+TkKiDMbqaXpJKXgs54gEVs284NNc/xpgq1UOFpGe8beNy5hTPk+UzGyPHK3inroz8OhifIUJuusJFkxTJMyQKCGaOENVHFHd1aZxaI0n3AaEDdSsOhT2J4AGKXoANeo4GX6TjjckCk4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDe36qGbzEa9hdeEwApdbvJwyhjqtgASrzxLFwcjVBE=;
 b=oXXsc29HJu+zxADDD/uW0pWCRcWteayR3aQ1UHmMO7uMRce/RtziKTElZQnSxKi/VcFaEVHLkykVo02UFczGOnAfd3XF9GPbpesTCMmd6V8w1kMo+Z26NCb53DE33U5dLC4SfRj8KFO04dcQ3j3Ecj8uKfAeU4tNyNGVnq20Q/u5/pW5VU6H59zsA1AN7L5Lnp8esbVmHFQd1YvspwHYs+DTyStaoJuSLGA1hIQ1fdhj9wVv0RaRyhefhlP6BDWcF1j7r6fZZbXrQlAaqJ6vH7fETb6JY6Go1A/tcR5gQBDBPWuQQx/F+hLgYp+HtoWRMibSXKmKTWbqT58wmDdYfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by DS0PR11MB7263.namprd11.prod.outlook.com (2603:10b6:8:13f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Fri, 29 Sep
 2023 06:09:47 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::fd1b:a3b7:11a6:4bc3]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::fd1b:a3b7:11a6:4bc3%5]) with mapi id 15.20.6838.024; Fri, 29 Sep 2023
 06:09:47 +0000
Date:   Fri, 29 Sep 2023 08:09:42 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
        <ilpo.jarvinen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] selftests/resctrl: Fix schemata write error check
Message-ID: <ga5vrewvoz2ijynaueycukmd6ipbg5ocbiwt6wlgjwsppx6b7b@ioo6xtrax2px>
References: <cover.1695369120.git.maciej.wieczor-retman@intel.com>
 <5e17ed39ffb8d6bd530c057aa04e3ffb997573a9.1695369120.git.maciej.wieczor-retman@intel.com>
 <322fb9ff-f3f4-45df-9b3f-524125ca6101@intel.com>
 <mrhrlwtpquqqyzznzqru2m5tfbz7cmtk76zxtamq76ssqthz6g@njfi4qvjclih>
 <efcfa0a3-3350-74af-5aa7-8306ab206b56@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <efcfa0a3-3350-74af-5aa7-8306ab206b56@intel.com>
X-ClientProxiedBy: BE1P281CA0140.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7c::20) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|DS0PR11MB7263:EE_
X-MS-Office365-Filtering-Correlation-Id: dac442a3-6bf7-4989-cbb1-08dbc0b2aee3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QDna8kaZMVQQcnVzcz5iHmYquHYUqfj7nu6IJnfD8MAIHm9V3O1ClhT28ksm9utkFfXlCN+7QIZXyYNCxV/IW2JseluCj5djKN7mTwrxf1MB38PXtAmg7aaVpvo5aZEIH0NGmDkapx2d9wx6DmazU+rQ7iyig56dowLUV9NCXlwGE7g7CZGJwxbKiNBqGMuDAdALOlakZPvT+E/fqIEhiGYbJvhBORZrMK/EV46xUbxls+EkfcHPHn/UsjXp1KzVK46JnGtQIKVTaLqnaFv9PNMjkZnvwaZ318wFak0qfISQg0uVfhio+l9EE4RTBx4u9m4hV737/bWg1sWecOqBN28u7WWkLmglGSe/Cj0qLnFs4jGb+Opc9wrCF4NTkZP3FY2kG78mYvHObT1Xnq1Rgj6gRXuozu4+v5M19OMifrXK84t9q3cwmQwtYy2niE1Tad5CdfclUtDBIFpLLSk/T70Do+an4cxzE/0XXmkg7PSsInJeStR190h9bK5ksAzqmkyySSRZeT1F+llkjBOtpokZiS4jgv5WIfSToZy4JqfIvk64EZnVDhRiTi9kPNa1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39860400002)(346002)(366004)(136003)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(53546011)(38100700002)(6512007)(6506007)(6486002)(9686003)(6666004)(83380400001)(82960400001)(86362001)(33716001)(66574015)(26005)(54906003)(41300700001)(2906002)(66476007)(66556008)(8936002)(316002)(6636002)(5660300002)(4326008)(6862004)(66946007)(8676002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?G8ckOqkfSNWxizSMHVHCI7dSyWhjhHcZaiUescN7hWHvT+l8XAABz/SO3i?=
 =?iso-8859-1?Q?zl/3T6KADGuv3a3g8FhqkinbzMi7VafczdCmGfhwKf1BkQeVZJEP1FeSLS?=
 =?iso-8859-1?Q?dZ0EwoTH9ly4D3IHn9cUl9y2YK2dr/OFIOUznU4ryJ165z7rJMq84KxXWE?=
 =?iso-8859-1?Q?PgDJaTxU0UILA481/W4WzRonFSTKCd3ofa1pESLxPYiz+Wzs9WW/Q5ucDz?=
 =?iso-8859-1?Q?7GUknChxe1NatgwaGNqZnIkzdoU6kpxp9aBoLepy98JbAclznc4LDUesi5?=
 =?iso-8859-1?Q?YzZJMHN1Fa8dPe85/AijcohzbcI4EJ2bdbVeBLok0+T29vu5QLLTGYwNoG?=
 =?iso-8859-1?Q?jeNpJ9lIKJO/xHmS31IzVzSYYm8Qp2HokyG2T6bngT24plLfYcebPyckAy?=
 =?iso-8859-1?Q?9FfSQRQm2iNo4jDoozi/U11HMPKJx3UxLdPK/BXWgmC7uqn4P1MspnH356?=
 =?iso-8859-1?Q?4avKr1K8XNRBDfoVkm3RezUsNrMy4VFCLOzPMWdTQN0IAIopbOz5cVOFvy?=
 =?iso-8859-1?Q?bwUtjzBOVinTxzsPiy++qAqWmbQUFTwmzDigjorl9bAkkRH5udBB0Q3q8R?=
 =?iso-8859-1?Q?s62EEi8XOybYCIyg1lW82z3uLkBqfxO8AyW80BEd/k5fQ4RUH401c0fINi?=
 =?iso-8859-1?Q?wcu9sz0Ac7zge/tUZiabXEwV0PyL6MbU/7a+0w128IZyb0eKSudB2/Z+k+?=
 =?iso-8859-1?Q?VPam0x9lAy6cwnSHOE0zoIQhvx3XyBfZjvNqgT3glt8NBBHuluTud4xrjU?=
 =?iso-8859-1?Q?Do2JuaR8T53yFmcl1yn3G+njBzyHKsEpiVz2Pm0fwuDCtaE/lkS2cb5cdm?=
 =?iso-8859-1?Q?tZzJMToejgCyYRxfGO+UplRtX2CV/aI8pF1LYKZDt1do2qUIZJOaxIY5Ss?=
 =?iso-8859-1?Q?AoYKTkJ4R2GFMFKn/JGkTXOrCjSKuGDtFbeK77SmLgfAC2UHTeYAoMOzSk?=
 =?iso-8859-1?Q?AbUXy7B1Mp7vEYILz18IHb6msVE/B8gG5s0eN+/4Ay/b3hXa8/NLggFnmC?=
 =?iso-8859-1?Q?JSW942tKnFShoHE9zubreRgWebYZ+9/LBRY2DHzmpYjmhRAQpis/PHJ3f1?=
 =?iso-8859-1?Q?5oovuCe0pYONpaXo7nzGnV3Vj1Ng46qHKvk/svvgTP9Jj+lFN6zern7CAk?=
 =?iso-8859-1?Q?KsMmkiCxYkYFrmCDopzaAUkUK8bFXWlAhTZ/Uz6LgT2EtamQxY6nvfsxIY?=
 =?iso-8859-1?Q?ersWZz3cExlUvJ3xrOZi5h26gPKl9prNkROPXobQUh4XtnMLH8B+1nwjDI?=
 =?iso-8859-1?Q?mheDG8oseH8AH4/Mac348jo1JrlpvZF7zRGXDz11bBXFZH2G+fD0pXGyxx?=
 =?iso-8859-1?Q?rvcwNVY8U3aLGf7NpMqPdHKue66HBT2TE3YS2RCissZnwXV52PqIQA1J6Q?=
 =?iso-8859-1?Q?nNyFQkQgH+28CKLAnrmEBinOmxBd/bZmRx3WhV7hpVQQ2kAAE4SwCwiWOA?=
 =?iso-8859-1?Q?pX9U5SpfhvoOMv3Y+xK+KNNC0vlSlXQ8mbA5PTJPxezmd0FdqNGSh248UE?=
 =?iso-8859-1?Q?RfFbvqiarZueuM/I4vg6cOZA71EM15DC2rlExDsWv2Ikr29+SY5pUrTZzx?=
 =?iso-8859-1?Q?ov5PN88F9G7Ys77P+OZF8PMXhJ/opo5TOgjtwcYEZn4BOHOYfkETbxjWrU?=
 =?iso-8859-1?Q?j74pvoH6IANM/B35weP6+KJJxde6F0y6SFp+sNlDsRzuMT7NtVsP7h3i8x?=
 =?iso-8859-1?Q?SCI9XDm2oEElyxZJZYE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dac442a3-6bf7-4989-cbb1-08dbc0b2aee3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 06:09:47.5293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EyLT3aUWveTxeaL+cPcgciCjoHkKvGEXHXNuSgXj/hZNVLPbRvYBRAPpcby86y0i3teSWYPJ+WBXdmx+Bln5vEYFy0tplp045wyts1YLsZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7263
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-09-28 at 14:25:23 -0700, Reinette Chatre wrote:
>Hi Maciej,
>
>On 9/27/2023 11:46 PM, Maciej Wieczór-Retman wrote:
>> On 2023-09-27 at 15:15:06 -0700, Reinette Chatre wrote:
>>> On 9/22/2023 1:10 AM, Maciej Wieczor-Retman wrote:
>
>>>> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
>>>> index 3a8111362d26..edc8fc6e44b0 100644
>>>> --- a/tools/testing/selftests/resctrl/resctrlfs.c
>>>> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
>>>> @@ -8,6 +8,7 @@
>>>>   *    Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
>>>>   *    Fenghua Yu <fenghua.yu@intel.com>
>>>>   */
>>>> +#include <fcntl.h>
>>>>  #include <limits.h>
>>>>  
>>>>  #include "resctrl.h"
>>>> @@ -490,9 +491,8 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
>>>>   */
>>>>  int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
>>>>  {
>>>> -	char controlgroup[1024], schema[1024], reason[64];
>>>> -	int resource_id, ret = 0;
>>>> -	FILE *fp;
>>>> +	char controlgroup[1024], schema[1024], reason[128];
>>>> +	int resource_id, fd, schema_len = -1, ret = 0;
>>>
>>> I am trying to understand the schema_len initialization. Could
>>> you please elaborate why you chose -1? I'm a bit concerned with
>>> the robustness here with it being used as an unsigned integer
>>> in write() and also the negative array index later.
>> 
>> My idea was that if the initial value for schema_len was 0, then if
>> resctrl_val wouldn't equal any of MBA_STR, MBM_STR, CAT_STR, CMT_STR
>
>Ensuring that resctrl_val is equal to one of these seems to be the
>first thing write_schemata() does.

Right, sorry, then I guess initializing it to zero isn't a problem.

>> values schema_len would stay zero and write nothing.
>
>Your alternative writes "-1". write() is declared as:
>	ssize_t write(int fd, const void *buf, size_t count);
>
>note that "count" is size_t, which is an unsigned value. Providing
>it -1 is thus a very large number and likely to cause overflow. In fact
>if I even try to compile a program where the compiler can figure out
>count will be -1 it fails the compile (stringop-overflow).

I tried compiling and running by passing a value with scanf to write()
(so the compiler doesn't know it's a negative one) just to check if
it behaves and write() was returning a negative one. But yes, the fact
it's unsigned means it's not a reliable way to catch this error.

>> I think it would be difficult to debug such an error because even later
>> in ksft_print_msg the requested schema would get printed as if there was
>> no error. In the case I mentioned above the function will just error out
>> which I assume could be helpful.
>
>You seem to rely on write() to cleanly catch giving it bad data.
>
>> Other solutions that can accomplish the same goal would be checking
>> write() not only for negative values but also for zero (since in
>> here this is pretty much an error). Or checking schema_len for only
>> positive values after the block of code where it gets assigned a
>> value from sprintf.
>> 
>> Are any of the above safer or more logical in your opinion?
>
>There is no error checking on schema_len. After it has been initialized it
>can be checked for errors and write_schemata() can be exited immediately if
>an error was encountered without attempting the write().

Okay, thanks a lot for pointing all this out. I'll do just a less than
one check and move the initial value to zero.

-- 
Kind regards
Maciej Wieczór-Retman
