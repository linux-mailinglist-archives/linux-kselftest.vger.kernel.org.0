Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A8679D5B5
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Sep 2023 18:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236570AbjILQEU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Sep 2023 12:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236583AbjILQER (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Sep 2023 12:04:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4505D1706;
        Tue, 12 Sep 2023 09:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694534649; x=1726070649;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DcNw3y2GZV+k/WWh/4XFQOumjrWxckL+sMT17wgRhjs=;
  b=BG37XKdH7nvuRuuNz7vuZpMj+A514qEzWhjPfnJOuGAhswyNTH3PEwn5
   jNTJ1V/HoQf6Ze5p328GvnQ4ZMe72Ik0rrSKV3oTe3JbJwAvt2IrwAWM9
   JQ7EtD6mCueeAKmt1Cz8qaPc2Pt3unq7c75v6pCTG5S8053KOytiSFXIK
   wH8xceUh9GI1CG16wvfxmyp3r5AvREKeOrvAK8KOo66nvH1tjrSC1re8r
   Xg/8dazj0H8OXM1KknqzZIt1uw/Jyv+ZIUK1K40riSz15Q/eR4W6kDBU1
   el8TyZfNTGCstXXERGWwF2QVU7RCJ2VnK2q470XdEMcGpKLfN0z8omomu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="378325818"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="378325818"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 09:00:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="720475862"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="720475862"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2023 09:00:37 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 09:00:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 09:00:36 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 12 Sep 2023 09:00:36 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 12 Sep 2023 09:00:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SoqyusGgzfKjMn3/wKzOU9pKY8ZGr1NtHhqf6mrAeopLOaAVk4utOIPRAZ5VFM5j3LwkV+WgXu8H1F2GnzJUiVRzrfkawMBOuEn0QhyY1cMghmDhiywYHqEi3Otq1YbYN3RMMdkzKsGlKWNxyJTrxVjp0L0AK7/MHqyw56wTX9CdU7YGxkhBWPorYilypzh1aE8ko0rzr1wCHV70oKVjZa3aTM8AX83c8iqjv/RtRX6hWNo2KwHaXyrZb+FEMMwI5fvhB6woBGx7lnG5AfmX/1twcOxHbkZvlKW58dcQEewAh6xvZaQiiJYPYtcHBXd/dFGOzwi7n0v7oVr++bf+GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ylmtwQMZTsfjHpWh0KiBLFwLvU28/gZJTV4z8+15R2M=;
 b=inBU8W9mOqJqDoW6RyXs53IUoBFpGj5TDxpv6EQqfegeoiZOdyAuwrSumhqVjlwLCXl7tUwHziURZWyrnicBhk6n6hqwRypCtOyP/i22wlfT2DHHqou4qVuzbLt7WIcwbiXbwv/O0dl+AMdm5z1uPw4g/wOoBCweQHMv29cgBk8Z3/9H0uzg91el7o5+mC8w5XzM1XvmdfcHKG6MLu9UgE/ws6xKvAZU1groj050Goe8TXvv2C2jmci/+oIjKxw/QXXx+d3kkvldSRyCmOr2E5UnERA0jccFrdPfn4nhSnascCxWxfBXbAi8VnD/bLuJK+MGBzmPmfYMvMWOfAiYig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ1PR11MB6084.namprd11.prod.outlook.com (2603:10b6:a03:489::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Tue, 12 Sep
 2023 16:00:31 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203%5]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 16:00:31 +0000
Message-ID: <a7f0dfb9-c841-b240-fca9-b908517a44d0@intel.com>
Date:   Tue, 12 Sep 2023 09:00:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Subject: Re: [PATCH RESEND v3 1/2] selftests/resctrl: Fix schemata write error
 check
Content-Language: en-US
To:     =?UTF-8?Q?Maciej_Wiecz=c3=b3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
        <ilpo.jarvinen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
References: <cover.1693575451.git.maciej.wieczor-retman@intel.com>
 <960b5302cee8e5bb0e83dcf20cd2ef4d353b7b0b.1693575451.git.maciej.wieczor-retman@intel.com>
 <99eabc5c-f5e3-27dd-0a29-ad0cdb7b4239@intel.com>
 <sr6ana6d7ebtuxbhjuo6kcnhnn2zzvg3ivve6mndqeb3nxrzo7@mrfmtzlxlwdh>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <sr6ana6d7ebtuxbhjuo6kcnhnn2zzvg3ivve6mndqeb3nxrzo7@mrfmtzlxlwdh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW2PR2101CA0013.namprd21.prod.outlook.com
 (2603:10b6:302:1::26) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ1PR11MB6084:EE_
X-MS-Office365-Filtering-Correlation-Id: 51730321-09bc-43e1-5e78-08dbb3a963d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nGoJg/YhH3WecwgbH549ZFNXurTa6B0lrIoU6aCG83h4KPw8+G7ADKU+h+9jFyzJJzWze7haK7IiKjcR7jyZ6RSjuYgq50iA829CJy4yfA2npD0DxTHlXBtgZzOIqZIZRayV0on2lHH9OxEOWOIxr7lfm/0qJMB+rE9VFODKYukgHF262U1NU5GrgbOBjUkhMNbPOQVsGUp56iHxNsPHgcAKYYH5BZUdIXpuGvKdgfbxbrjyaFW5tG0NRL2HU5g9/bYN1dAnn8qQ+tu10DkJzRqmT/OuqL/eizbGeUOUHLEjbGtxtt+fAgL33ZQ//gPpAr37Yn93ju6LrMVRXpuWQOaeX6BqbMZf2mn2soZIlI5oFSwak7b+dFQt5tGBDEpEkB1zEXex64V8H3ZKTqmkOX+ZzfpBuSN9nV6Nvuckc+H+IF6uVqmjQ448C46U8ADxQnUVRId5LPtRCmxLnPZE68s8YBfAzz3lBvQV6jx0hSk/6bm250rOFLgzAgYlsHX2bO4s2aoKBuT49IpHNQKYDNSR4SuDZmFtzDj23CyRpdgGbwNLESWdV3gOMtaYuseX2LZBNf6iixTCBOQQz+zlA94jxvP721vJEEpIjRAR9vcXBFCZZeQMLnDKk6OHMISXnYPqhgaexlZ/SrxqsUEMsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(346002)(39860400002)(376002)(1800799009)(451199024)(186009)(44832011)(6506007)(8936002)(6486002)(5660300002)(6862004)(8676002)(4326008)(66476007)(316002)(41300700001)(31686004)(6636002)(37006003)(54906003)(66946007)(2906002)(53546011)(6512007)(6666004)(2616005)(26005)(478600001)(66574015)(66556008)(83380400001)(82960400001)(38100700002)(31696002)(86362001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEFobTFMVHVrU2twVUsyczh0T1g4RUN1ZGdrTmdNQVB6UlJidmphVEdJeGU1?=
 =?utf-8?B?MmYrNGhSUW14MzJZUGcyby9WV2ptTEVjOE1YMUpnTUtmbnQ4VnF0ZFhkWUZU?=
 =?utf-8?B?Y1RBWjZMdGxOOU5jM2c4b21QdjBkM3JUbGl5TVEvL0wrRVZEQWlMMGowSW8r?=
 =?utf-8?B?VnAwNndhRFRVWnhnczNuL09BaFRsdGUvdnVmdDF6cmV5VXVjMlE4c1dkZith?=
 =?utf-8?B?ZkE2Rm9Ra0J6bmZneThESGlsVTc3SzBpUkVBYmx3ZW9KMUpjS1IySDZPSTJR?=
 =?utf-8?B?Z1NhajBUOElqMXY3ZkhZZ2NkWjVscEJQTi8xQkY0Q0lpQmhMTnM0WHF6ME1U?=
 =?utf-8?B?MnFzS0cxZjBIdFByMDJ0U2diMXYxZXJ0WkJoTkl6ZWVDZWdiWVBTS0pjSEZx?=
 =?utf-8?B?dDNxSXN2Qk5mOWRNbkhheUxnY1BsWXVaRXJheDIvbHZManU3Qmh6YXlYRzZW?=
 =?utf-8?B?a1VhSlpyc2JsVXlTYktsYXZ6ZUhsQnFXUk1YY0twUGc0S1ljRFVLS2M0YTV4?=
 =?utf-8?B?eFpsdDIwek1GN2N3SUlzd2RobjR0eDNDZGRUMkxhTHFlV0RpWDQ1QVhqWmFy?=
 =?utf-8?B?LzlnbVMrYlhBS0VFTDdDYk45VXpDWXV3VzdJNU5QdXJVeUM4Q21ad1Z2T3pi?=
 =?utf-8?B?VVpjeXV6bjMzQVpHSGs3OW5DUHhmRWVsWnlFdml5UlhTOGl2SDhKUmZxWGFE?=
 =?utf-8?B?S0todGRtYUZ1TEdOcld0b1M3QXpxRDh0VFEzYVY1SmpScFJPQzdWZFFYNEdo?=
 =?utf-8?B?NEZwR1hGMit3UFdLQkFzc2J0VmRmZ3dyczBaM0VNMmpJckRZVDJ5TmZuMXFx?=
 =?utf-8?B?UHJZUE9vOEVKaEIvS0pvQ1ZRYXpGL1VCUDY5TlVBMkErdm5PRnA2TjV6Uzg2?=
 =?utf-8?B?b3VCUW9EOVRObGRuNDRyMklDUTgvREw2SmlTelZCTTU0azEwazZwU0dmWjd1?=
 =?utf-8?B?WmdQQlhJVGR1L1hoSWlCQ21hcFcrMHdkdm1yZ2xLZ3dHdWhDSHVpem1OdVhj?=
 =?utf-8?B?WWV4K0c4cktqTWpob2RNMjh6YW1WTXRINlRqM3RpeWRSMkZkMHRValR3am5G?=
 =?utf-8?B?NVQwNFRsQXlBMExyU2dCcGd6ZUk0RTBHamo1eTBMcnFNVXRRVjgxL2dKTi9x?=
 =?utf-8?B?OEttNnZ5T0lKaE9jdVl1VGVDdzMzeGhCSVFzdDlIWjVZUXoyNGIxSUQrT05F?=
 =?utf-8?B?MzdqUnAwYmR5TE04WG85c25velhDVmZRVDR2VDl5THk0MHFUejZpM212REU4?=
 =?utf-8?B?eFRxUkxGMVV5RU5mK1dhSjdPUDhYMythc2hndnQxVUY0dktuNllqai8yZzBC?=
 =?utf-8?B?YU1OZDlpTTlCSHVyc0hpS2lZUXEzMktYZEpJcGNtemhBaDExL3RMNlZRSXFy?=
 =?utf-8?B?MzNma3FtV2NJZG92QlJMSm52dkVGWVl3WHBGKzBLUmZXNnhObllsS3VQN1Ji?=
 =?utf-8?B?VmdFa0ZEY2pmb0tWWmFSVmdKWEFFV3FJd1h5SmpJbkw3UGIyd1NtWHVOSG9m?=
 =?utf-8?B?djRidHFjRWZETFIvdjU1YjNVMWZBSityaW1OU3pIKzNsMkwzbURFQ3k5TS94?=
 =?utf-8?B?NUplZ0hWWSt1bmtRZzVWcnQvL3IxZC8rUlBQR05JdE5UOEtCWnJiTWJNYnl4?=
 =?utf-8?B?dWVNcG1NVzFPTW1XUTFIUmduVi9wZmc5UnRmQ0NJS29KOWJtN2dxMEZuNnFP?=
 =?utf-8?B?SzljekV4aXJJaU45NnFMdW0zazBMUEI1YzFhaURzUUtCTGFyT3kxSG5FSFpO?=
 =?utf-8?B?dVV3M3BoK2xLZ3ovR3J5OXFwTmg1NWJlUkxkbzdIWDNtbExNS1A5MWRaR2Nm?=
 =?utf-8?B?WFkyV0ZSMTMxZ0xqd3o5ckErdTVBNGVVWE53NS9rSlZlQ2NDQWcxREJKd1Nu?=
 =?utf-8?B?VnIvYk14WW5qN2VlUW1DYjVYd0IvdEltbzZYS05FOExBUkF3ZjZhRURnck4x?=
 =?utf-8?B?enJuMnJDdHhSbk1NUE1ZNHFLVitvb0paYkpsV01KWWFjOXB1ZUlwSEl5TDQ3?=
 =?utf-8?B?Z0lRamRwdjM4QmJSZkozUUgwY09tQTVWdTlKQmlsOVZRaVR1Mm5JZWVSTGpI?=
 =?utf-8?B?ZGhwbXRPY3RkbUc3QVFBeWRZOEpxamVpc3luekhveXhWYmtDRFpKZSt1aUdP?=
 =?utf-8?B?L1lHckphWDVWbG43NHduTUJySktQQXRyOVZVS3hqaS9WeElBRnZOL3MyVzdH?=
 =?utf-8?B?Mnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 51730321-09bc-43e1-5e78-08dbb3a963d3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 16:00:31.0105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u0N/tp0eGWUJ/gIkk9W1Azec8M/nMFMdnz3+6UUj5Ge8bqD57QTycPAJTyLAPKbOtfvPt1+1+itbfENZny7kAL0+Ow4IzFjpx145aK31i4o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6084
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Maciej,

On 9/11/2023 11:32 PM, Maciej Wieczór-Retman wrote:
> On 2023-09-11 at 09:59:06 -0700, Reinette Chatre wrote:
>> Hi Maciej,
>> When I build the tests with this applied I encounter the following:
>>
>> resctrlfs.c: In function ‘write_schemata’:
>> resctrlfs.c:475:14: warning: implicit declaration of function ‘open’; did you mean ‘popen’? [-Wimplicit-function-declaration]
>>  475 |         fd = open(controlgroup, O_WRONLY);
>>      |              ^~~~
>>      |              popen
>> resctrlfs.c:475:33: error: ‘O_WRONLY’ undeclared (first use in this function)
>>  475 |         fd = open(controlgroup, O_WRONLY);
>>      |                                 ^~~~~~~~
>> resctrlfs.c:475:33: note: each undeclared identifier is reported only once for each function it appears in
> 
> Hmm, that's odd. How do you build the tests?

I applied this series on top of kselftest repo's "next" branch.

I use a separate build directory and first ran "make headers". After that,
$ make O=<build dir> -C tools/testing/selftests/resctrl

> I use "make -C tools/testing/selftests/resctrl" while in the root kernel
> source directory. I tried to get the same error you experienced by
> compiling some dummy test program with "open" and "O_WRONLY". From the
> experiment I found that the "resctrl.h" header provides the declarations
> that are causing your errors.

From what I can tell resctrl.h does not include fcntl.h that provides
what is needed.

Reinette
