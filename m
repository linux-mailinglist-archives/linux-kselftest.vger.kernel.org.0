Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A723D7B134A
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Sep 2023 08:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjI1GqX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Sep 2023 02:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjI1GqW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Sep 2023 02:46:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E765499;
        Wed, 27 Sep 2023 23:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695883579; x=1727419579;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=KZ01bvVwnuqHZyBf/wWs9LUhjoIJmrDIs9ETi4J7fsE=;
  b=NoCxL1jK6S8B/IYckwDjoFNmOusRkZbGoY4uKYEzH5s0UwVttP5urTH5
   Qyd7t+qhZ0cMXkdF3iravoG9dUHGe6IrklXcMrh/uDb9kJ88TLuuRu4uS
   Ia8ZuE20DUfWMoanxOtfySQIknvbP1G958MdpO2tlcbsI7KfpBTLfMzm9
   e6k7xYBSsyJUlpuBfzmGNxeZB1LhufNdAoMjNgjr4L1d3+rIsxoJ8rHE5
   EC0hgCcGOxxAksM/o2Foaz3Z3I2/35bt0eq7SPbkNi9TQHErw5fyvGfHp
   w0YqImOpZvAidYNvkb36TBq0Yf6hRa8zGD8BfDGeme4RQd4DiKsOLBIMM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="372355563"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="372355563"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 23:46:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="749511056"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="749511056"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Sep 2023 23:46:19 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 23:46:18 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 27 Sep 2023 23:46:18 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 27 Sep 2023 23:46:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VE2l15zKcNqaKDBC7NZFbBoXfbFQXQKzDJoM1YT6lluEgiNVobGJZ4lYGaHF0vHJsjjLCiz6X/3CAdh/ZXMUFZTDqJ+dpuaslpNWwTSykvQbXeHiCdNqN+RLVL0+HxFDEitFulhcWW8gezc2nbktrioTPBB4xeJAeL+jtnuPy+2CorIKQr+JOdyT1qJS3nyzwnOp1PnI6pYeEsmkuGsnkycKm1NQQSKYRUbVHf3bXz3sA+Ay+Q3wtzlufwt4muRqThoZxpzaU0WwUTdBrKKjkgjbjHOU+DEvdBLRkxDOGiHOYrfzi2v0V11U7z7dG6zBnHwXzeO8/xYAgIOjOGNGVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=olCg7VH5dAqHpPOmaNyvBZPGqdZUwKRdOelStT2aioo=;
 b=XIOg+blshnNvXnkyKJj/jWuLdvam4oYrCj5mUXGD56om+MfplWJBBFv0mhanGv2VTRAdo5cLnOIiH7vJa7T24oy5uvZ7aEMfG32jAUOQBx7mZEsn9H2XFjQ2PSlV3rL85QEDOkBKXKq9BAIkIvbcs0vR/NdNvQsOMOHNwTd2rtBQSCS4XxD0TOryx2ed2/LPuLuZERRtzo9/z+IpKS1i5M0EtnYyr4akmPzUr7+tcKrUOpD9WvRtnQKpsgPAsYEWFn1z/pw0HEwhxL/QHhN9+NopFD1c/yUmx6fAlsnVu5YMvMqZ7Hnj5iqeI6i+JYMH8FO2uhWUg8oQaHd29xiFJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by DM4PR11MB6454.namprd11.prod.outlook.com (2603:10b6:8:b8::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.28; Thu, 28 Sep 2023 06:46:16 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::fd1b:a3b7:11a6:4bc3]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::fd1b:a3b7:11a6:4bc3%5]) with mapi id 15.20.6838.024; Thu, 28 Sep 2023
 06:46:16 +0000
Date:   Thu, 28 Sep 2023 08:46:11 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
        <ilpo.jarvinen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] selftests/resctrl: Fix schemata write error check
Message-ID: <mrhrlwtpquqqyzznzqru2m5tfbz7cmtk76zxtamq76ssqthz6g@njfi4qvjclih>
References: <cover.1695369120.git.maciej.wieczor-retman@intel.com>
 <5e17ed39ffb8d6bd530c057aa04e3ffb997573a9.1695369120.git.maciej.wieczor-retman@intel.com>
 <322fb9ff-f3f4-45df-9b3f-524125ca6101@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <322fb9ff-f3f4-45df-9b3f-524125ca6101@intel.com>
X-ClientProxiedBy: BE1P281CA0100.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:79::11) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|DM4PR11MB6454:EE_
X-MS-Office365-Filtering-Correlation-Id: eead865f-7ea3-4a35-eaf8-08dbbfee9d5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +MtxlBRBQR+TpZY2F2+t8SNw4i47TMoGt0mf7BsH3xoi4QWx61NQEdhkb++W17ZvWBch6ASg66Pkc93j3WW8tVkn9Dd03fXemtECn1ToYuq+gu9IDtApZfUAGwNJOBw9IPF6k6T1Uc2NYhy2hyvgs58gueltkK5B+QC4LvwVk8HFs/YoAXWNSjuCGrKmE7l0TG31zI44c8Cg8KRp4ZPQ7l/XX2QrigtWGQmTcBgGVHmJCVwZTsJ06G0o/MH1+mA5+unhx9pkmXX37fV9lOwmhmncWOCVbkr+WLFdcatE0lyLl9oGP168xyHC5jVGSTDDlVyV4ghmA03M8SP0toJW7G0rei1yoFQVnHAgsYA5D3NBIhMWTZHSn3FjaZQZXV4sWZjFykoqzE+7S8s+VDjdgwPwPMmk3xQ2qhsfltL/jVBclnGAG7aJZLTH8hhCsfT7x1gHOEXwoQXuHzkuIaNmGrOxGNbrKXM9caEF4z5N0W6TGrNiKkspL4bineqVgmeq+e4bdCzulN8gVcyrKF1PXuZfBdFGfFZX+bKF9Hat2CgMt7FikEX9rXUxBhY8x3yY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39860400002)(136003)(396003)(366004)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(9686003)(6486002)(6506007)(6512007)(53546011)(66556008)(478600001)(6666004)(6862004)(83380400001)(5660300002)(66574015)(2906002)(4326008)(6636002)(54906003)(66946007)(316002)(8936002)(66476007)(8676002)(33716001)(41300700001)(26005)(82960400001)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?kI5sqE6WiGq5GJmCbhsZLh/X7FRJyhiwPkuDLEXOz/niIKeCh6pPHT5rJd?=
 =?iso-8859-1?Q?2nB+XgaewV66lQSe5YZUOE9N0rUsemUWcnPCbIH2G3sJuCwmMwkyO9nreV?=
 =?iso-8859-1?Q?NCq4sAZUjM9FDYO1emL+/+8fy/jIGylqsA4E4TIoz9g33qXOaQMYobniEl?=
 =?iso-8859-1?Q?jCEjYpU0cfTIeL4QlH271Jhim47Y6pnJBueZSRYpcBrzTeWrHKAriIya+A?=
 =?iso-8859-1?Q?zvK2dBpp1sck28EfNDnWH2jux9XLgAnmx1mRxD4Xh1nBYbaQ5ery/5ZBuj?=
 =?iso-8859-1?Q?tlD9LK1m2zCs4uM+8NcV+MI6gVH4lpMxhWduu814pkQTA++t4FLld4Bhs5?=
 =?iso-8859-1?Q?HJHKn6R1vxAHisHdq/HKU53I7EvXcciqsFSmcrOEUnuBnEXJcszAgZdy5Y?=
 =?iso-8859-1?Q?wHlzWergEa5g0nRu0bNoifrSHefMIH7VPQLN1+PPcBAj6+A7GmBKLcxfuT?=
 =?iso-8859-1?Q?cpqT5KnwsS07lePAUnr0zavMAsRijyvQBLsnRPgrhCqwWazuJ+5PU3KS1Q?=
 =?iso-8859-1?Q?wevUlidmoq6ISE47dzq4rt07JydZ7E7CjWON9ZFb+lM3pcbND1e/p+Lbr7?=
 =?iso-8859-1?Q?5vdNqqPASPEVtvKZaHQFY7F9wktPfer/wePEADrUAvRiowawsea8jWJitU?=
 =?iso-8859-1?Q?VGHAP6fK6Q6Jph6+MlLVdNxbUm/++ZgNYRwskLy/wITVfR7V7tctwzlxDm?=
 =?iso-8859-1?Q?1Jprgd22/5CP1mY0rGpwFD4Qr2G7hkFlhpGztxIlc3RymqfYc0YUwz5RcP?=
 =?iso-8859-1?Q?qZJSoqBdfyzJpUe80LinhUKBRRdPC2YShM3mmpUf3XAxfuNkndIQJEv4z3?=
 =?iso-8859-1?Q?unM19n4wRnEz8joVDpBro5cQ5ze24qZx/+b5HN1MVmD+52W7CbsDaNNlcp?=
 =?iso-8859-1?Q?czddF40iAV7DKlhyoBJXVZCeW7uMw+m+toEnbQw1NAR7RzD/WwiBYvbPOR?=
 =?iso-8859-1?Q?INuktEJmatC/sk/OmG+0I1GfOoyGk5oBBcAxhWEUH9yTE7SbIvNuqYIv9K?=
 =?iso-8859-1?Q?FgRW8Uj5o1OaEiAAoxkmM56yj7l1GSYF2PDD9olQoYqc7Ak4rM/EqjwEiO?=
 =?iso-8859-1?Q?tIj2RjpZ1m2A4+gvtH8Z1hUSyolp2MSpdyHPM0/PE3u3UHP7CeAFCXojG3?=
 =?iso-8859-1?Q?FeOCeIOOlYVVTiyIvdKqFtjs/UcToW7YLh9GF+KT5SDGZ6uIVoLk1lnoeL?=
 =?iso-8859-1?Q?1sfR6QhdbrTPhhsHm6DIUHET/19Bs3DjmFvTieQL96xjuk58aUNRhPEDxn?=
 =?iso-8859-1?Q?DwJz32qI/4oadRRBDEEncdl/QMYAZbeQMl2b5sZLOmCJH0F3pA20zJcpuA?=
 =?iso-8859-1?Q?ghBYEug7RvmJV+xFjsourwNipNYh9Vp2wi8mm4BvSdyQOVuZzVaP4qnOYp?=
 =?iso-8859-1?Q?2hSrcKs1Fc5KVHnMhU+Q500jznc9aNxQd8UTdkmQWuth7vTW0YLKo4W/dy?=
 =?iso-8859-1?Q?vnhWbbWaWh8ZRNszRW03QY+Q4VPNGQVB9Bex524h1h8Nyw1idfN6zyo55e?=
 =?iso-8859-1?Q?Sm7XmLBESt22xDYrLuKbFfsJx4hSoRPRDE2Y8B/Ky+WI0XcgeH0oZTHR1A?=
 =?iso-8859-1?Q?Z3jHNcitqDCOx7d9gg22I2LLgwXriG16tHToH29WCKWZBYSh4VtQ/losX0?=
 =?iso-8859-1?Q?YqDlIF7Vj0X4UW5mjosMLBlw63yI85D1xyzqbeDAVLdrGUX00ZnyF3/dJz?=
 =?iso-8859-1?Q?2c9Y1mzEZwd6r3NLVmw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eead865f-7ea3-4a35-eaf8-08dbbfee9d5c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 06:46:16.7672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dQ0hzRiYFLzxBekZSl8TgiVvV9fRAOfwEGLwWMOzzWA8ZEP+qGCeSZPdatQNYUtAsNzc4WTkS2m/PYnZCFXJ7nIKAqsUceu/ORlhHqIcplY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6454
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, thanks for the review!

On 2023-09-27 at 15:15:06 -0700, Reinette Chatre wrote:
>Hi Maciej,
>
>On 9/22/2023 1:10 AM, Maciej Wieczor-Retman wrote:
>> Writing bitmasks to the schemata can fail when the bitmask doesn't
>> adhere to constraints defined by what a particular CPU supports.
>> Some example of constraints are max length or having contiguous bits.
>> The driver should properly return errors when any rule concerning
>> bitmask format is broken.
>> 
>> Resctrl FS returns error codes from fprintf() only when fclose() is
>> called. Current error checking scheme allows invalid bitmasks to be
>> written into schemata file and the selftest doesn't notice because the
>> fclose() error code isn't checked.
>> 
>> Substitute fopen(), flose() and fprintf() with open(), close() and
>> write() to avoid error code buffering between fprintf() and fclose().
>> 
>> Remove newline character from the schema string after writing it to
>> the schemata file so it prints correctly before function return.
>> 
>> Pass the string generated with strerror() to the "reason" buffer so
>> the error message is more verbose. Extend "reason" buffer so it can hold
>> longer messages.
>> 
>> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>> ---
>> Changelog v4:
>> - Unify error checking between open() and write(). (Reinette)
>> - Add fcntl.h for glibc backward compatiblitiy. (Reinette)
>> 
>> Changelog v3:
>> - Rename fp to fd. (Ilpo)
>> - Remove strlen, strcspn and just use the snprintf value instead. (Ilpo)
>> 
>> Changelog v2:
>> - Rewrite patch message.
>> - Double "reason" buffer size to fit longer error explanation.
>> - Redo file interactions with syscalls instead of stdio functions.
>> 
>>  tools/testing/selftests/resctrl/resctrlfs.c | 30 ++++++++++++---------
>>  1 file changed, 17 insertions(+), 13 deletions(-)
>> 
>> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
>> index 3a8111362d26..edc8fc6e44b0 100644
>> --- a/tools/testing/selftests/resctrl/resctrlfs.c
>> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
>> @@ -8,6 +8,7 @@
>>   *    Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
>>   *    Fenghua Yu <fenghua.yu@intel.com>
>>   */
>> +#include <fcntl.h>
>>  #include <limits.h>
>>  
>>  #include "resctrl.h"
>> @@ -490,9 +491,8 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
>>   */
>>  int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
>>  {
>> -	char controlgroup[1024], schema[1024], reason[64];
>> -	int resource_id, ret = 0;
>> -	FILE *fp;
>> +	char controlgroup[1024], schema[1024], reason[128];
>> +	int resource_id, fd, schema_len = -1, ret = 0;
>
>I am trying to understand the schema_len initialization. Could
>you please elaborate why you chose -1? I'm a bit concerned with
>the robustness here with it being used as an unsigned integer
>in write() and also the negative array index later.

My idea was that if the initial value for schema_len was 0, then if
resctrl_val wouldn't equal any of MBA_STR, MBM_STR, CAT_STR, CMT_STR
values schema_len would stay zero and write nothing.

I think it would be difficult to debug such an error because even later
in ksft_print_msg the requested schema would get printed as if there was
no error. In the case I mentioned above the function will just error out
which I assume could be helpful.

Other solutions that can accomplish the same goal would be checking
write() not only for negative values but also for zero (since in
here this is pretty much an error). Or checking schema_len for only
positive values after the block of code where it gets assigned a
value from sprintf.

Are any of the above safer or more logical in your opinion?

>>  
>>  	if (strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR)) &&
>>  	    strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) &&
>> @@ -520,27 +520,31 @@ int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
>>  
>>  	if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR)) ||
>>  	    !strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR)))
>> -		sprintf(schema, "%s%d%c%s", "L3:", resource_id, '=', schemata);
>> +		schema_len = snprintf(schema, sizeof(schema), "%s%d%c%s\n",
>> +				      "L3:", resource_id, '=', schemata);
>>  	if (!strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR)) ||
>>  	    !strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)))
>> -		sprintf(schema, "%s%d%c%s", "MB:", resource_id, '=', schemata);
>> +		schema_len = snprintf(schema, sizeof(schema), "%s%d%c%s\n",
>> +				      "MB:", resource_id, '=', schemata);
>>  
>> -	fp = fopen(controlgroup, "w");
>> -	if (!fp) {
>> -		sprintf(reason, "Failed to open control group");
>> +	fd = open(controlgroup, O_WRONLY);
>> +	if (!fd) {
>
>Be careful ... the error checking appropriate to the original
>pointer needs a double check with this new usage.
>According to "man 2 open" - open() returns -1 on error so I expect
>that this should rather be:
>	if (fd < 0) {
>or
>	if (fd == -1) {
>
>The rest looks good to me.

Thanks for catching this, that is very helpful.

-- 
Kind regards
Maciej Wieczór-Retman
