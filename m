Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB6A7A18D5
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Sep 2023 10:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbjIOI3p (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Sep 2023 04:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbjIOI3k (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Sep 2023 04:29:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A682718;
        Fri, 15 Sep 2023 01:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694766536; x=1726302536;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=rXN2vgEFOe/d/osAOl68swQSsiQm+9U6+UAp45TzebM=;
  b=noYBeUd5AlorByGQUOR7bjwNjLbNj8/V/nPAIkwnWCBSJSDdZ8KNv8RX
   9FAYoAuaNV+f8hlNbAes4FxHtXayk4el95pspIRIJTdIuUBpPJGaQlorF
   9Fjx3dsYlHZfzYXEtcFPHGAyJ2F3dQP0BgP4XfoaUsnouLvrXgqvLnoio
   /GVzyHj5AOCrQHOmOpvNaC6ihjI/R37hlgLVzEwpS2c8s2RSyXEX8atHA
   Hax81W23e6m+szBXunVSQquja5EZtQNbXaKGmEsrPOSETwX6S6RrcVLgT
   KlAAWvDCBMDw6CQ4Go7/7/FYT3bTlWW66bi0AXt3v9qYhrFexEJ33SUz6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="358610438"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="358610438"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 01:17:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="721600644"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="721600644"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Sep 2023 01:17:08 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 15 Sep 2023 01:17:07 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 15 Sep 2023 01:17:07 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 15 Sep 2023 01:17:07 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 15 Sep 2023 01:17:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UaftalRJnvHFuvlQNVCGw33iThParRq4yrM4/V9ulpM7lA9l6301YX/N4//HmsQMww9a7AM8ZZmoieE6XRqXhcckyCG75ATDMGIDUR/t1kTgR7uGYh+Riiy1SOJiJ8774JVBjgzElJYaoExMswdNNHE0KnlkEoaLh3K2DSiaO1sP1oNznqjOC1jLvxmc9EAGBnQ9CYs2vh5WuPUXKiB/wltc7lzeiFCTFw2897MQ/UmhckDqMR0IkVGgTRccHxT0Pl3S7ZxpEnsw2AMXZaHLPD3AHW3FH0eailfjkSshBvLhctZnrsZbvhsAuCSr5XuB70Dem3j4bIDwcGC7W0rkSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKafXxime7pzf514Gmq3uPCTkg8cnCJpwci8xz7v8qI=;
 b=chT7smKSKPrHlaGEvzSAbuagxvrQqnSmDucPDYjGBPNRWKylprS7mC+ZW6WS139JXmKzZ655WpG7ikMIpyoKTdOKa4atCB76z1aLIzYUPByJYDBCM1sB4qXiW8u877CJN6VkHSlB77iJ38CfxT2OZUMKyJI7pw1KvOERfXzlXMbtNd2BFUW6pd9SF+yJVBGGVJY0BVsGSJzdDOz3XJQAzpfBwP3qyABz3aB8D7PJs7F2lUo7tZTCbaxpaZlIiFZfZs7FFrs2iM0Qbb3qFeeF09vIYb47trW7VGJDhbeM0y1TOdefHpkgsiMhSiGSzxz25+INJZObACQXUaOGrqUR9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by BN9PR11MB5225.namprd11.prod.outlook.com (2603:10b6:408:132::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 08:17:05 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::6ecb:9e9a:87e5:f342]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::6ecb:9e9a:87e5:f342%4]) with mapi id 15.20.6792.020; Fri, 15 Sep 2023
 08:17:03 +0000
Date:   Fri, 15 Sep 2023 10:16:56 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
        <ilpo.jarvinen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH RESEND v3 1/2] selftests/resctrl: Fix schemata write
 error check
Message-ID: <3a24bhplwgpn343hc4vwze2jnt4jebzvoigtbzom4gb5xuyb4c@ffs2qhy3ouay>
References: <cover.1693575451.git.maciej.wieczor-retman@intel.com>
 <960b5302cee8e5bb0e83dcf20cd2ef4d353b7b0b.1693575451.git.maciej.wieczor-retman@intel.com>
 <99eabc5c-f5e3-27dd-0a29-ad0cdb7b4239@intel.com>
 <sr6ana6d7ebtuxbhjuo6kcnhnn2zzvg3ivve6mndqeb3nxrzo7@mrfmtzlxlwdh>
 <a7f0dfb9-c841-b240-fca9-b908517a44d0@intel.com>
 <jyxp5mspjn7xbmclj5sumbsuwd424fqmdvntiiuq24tiz5yqb4@qunho7whbamf>
 <6d6dba28-a7f0-1f49-3f59-4e0026d0c2b8@intel.com>
 <ycbcan5wcxtz2mbywz6zdoyfus26vrhus6enipe543x2ejyt77@m3l4ksir7k2k>
 <6fbc0b65-0f02-3c7f-bd7a-5183d24a1fe5@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6fbc0b65-0f02-3c7f-bd7a-5183d24a1fe5@intel.com>
X-ClientProxiedBy: FR0P281CA0221.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::17) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|BN9PR11MB5225:EE_
X-MS-Office365-Filtering-Correlation-Id: b3862636-e134-4af9-903e-08dbb5c42403
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XnrDggRTyKA3a+LKMfPk5sncRrikUUyQUR3YQ0uVklW/R6lFT3z43Dfd0E11PucCR+YAvCGY6z/4nA0+L95yAPobSJHGZmgxd2Lw5+//yZIPc3kUMOxj5q2zI429RbL8xQOb0wb7ii6mGftgNlMILQKXLPT6cn+nwoa0nh9S12DLOXaUpUODTgfQGO12gMX1xIJUCg+qwQ8tu3qrseBm2+09QLdmHb9YuOl6cvbjkTnFzEJ9f7YLOJ3+ePcb84rtaYBiweBFSWEyM3J3icvJfcfkNhdE8b6trkrpdb6yPJ67DCXzh/VgV7oiJkvQOeblkL5miu/ZG9hSgrqYabVysv33XrK7/nAuuw964CmYw0CPaX9B32j9bdr9vA81hMXk8+393rmJ2SErEF1/mZzt46SX5XDQlANiIxN0ftfzLoF7UKIfxx/HKt+2HMHKfC2aVLfMM20tN53i2oZbyUvKuS4MQESPPuVQCRrQc79fCo2u4wvppkUhWEOaZ3wKvVPxnzp6Ho83VgF4n6fCSYXYzCxyy2jZcR+2wJ1KHaMgmbs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(376002)(346002)(366004)(396003)(186009)(451199024)(1800799009)(6512007)(9686003)(53546011)(82960400001)(6486002)(6506007)(66899024)(33716001)(38100700002)(6666004)(5660300002)(83380400001)(66574015)(26005)(2906002)(6862004)(8676002)(4326008)(8936002)(316002)(66556008)(66946007)(66476007)(6636002)(54906003)(86362001)(41300700001)(478600001)(966005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2JrUnZlbEhyZE0vMGhjUkxMVHdNS3pKOEtibXFwczcxUWdCNTVqYmd1ZU9T?=
 =?utf-8?B?OGRXMW81cndmZTl4anBFcDVNS0psUFk3KytYWTU2OVRrTlluQ2p1ZTBxMGov?=
 =?utf-8?B?Q2F4VDRFN2prOVkyZWlnYmRwbWlvWTFYbnp5aTF5bnJNVnFOYzVzbFNySmtR?=
 =?utf-8?B?RXY4M1pxRnV2cmRJSjJxT0wxZUZieVBzSUhmTUpLUGJ2UjZ4RG1vaHowSG5q?=
 =?utf-8?B?L2paRG5CVkVtNVRwTHBvN2FDZ3hzaEo1c0ZtN1JlMVJJT29hOWNjRktKcEc2?=
 =?utf-8?B?aVMrTkE4VDFvQWFvMy9RNzRQTUlLc0pnMkp2aHd1VnFyTjJkQ1MvcGJXYWt4?=
 =?utf-8?B?Nmcxd1RYNFhoK05zV0E5V21RdjBNQTJtc21RRmRqZzdFdXU4OTgzSU12b1Nn?=
 =?utf-8?B?dTIvQkFpSFBOOTNhSkt0UWIwdjlQNS9ySmVQWUxOMUtwVnFwUkNQcVhuRVRQ?=
 =?utf-8?B?cFRGY1JTVk9IOHRZSUR5eUQ2clVWUzd5V0kvQWN6WXVFK1lubC96NUU0aUsv?=
 =?utf-8?B?ejE1bTJZU0hlVG43K1I2WnIxV1VkeDBmSDdVN1RQUTlUZzgraG91ZytlaHlZ?=
 =?utf-8?B?NVlTZTFmUXlPZjFnOXhaSXJFVVI3azh4amJJRjA5NkJZYzRCM3E2a2lXQzRH?=
 =?utf-8?B?YTlMdFQ4Y0RuY0IzU1NVaG9SbkIvcjREN3ZJSjUybGpKcCt6cEFWV2lDcGg4?=
 =?utf-8?B?VW5xamFCSUg1cm91VXhOOVRDUHlLc0RIZ21DNzJEazRBQW81VVVOUmQyZkg0?=
 =?utf-8?B?bndXcmt0NHJPSVd5djIvaTlDT0YxMko0bFA5M2RRellmdkdMb3RPYzVsa3F1?=
 =?utf-8?B?d04vK3lUZ0ZQRE50VXo1ZlpCalE4bTFHOE93ZU5qaTNySGRGbnVqYnV0eldv?=
 =?utf-8?B?aTRqSllXRDZJQzJvdEVad0VvekF5ZExVM2tTOTlGbXdlc0JRY0t1U083UUla?=
 =?utf-8?B?dE5BeUN3RlJ2VDFuUS9XVHhHcWJ5ajJHZ25WRWJGL0JSeHFmK3BYN0FqWHg1?=
 =?utf-8?B?S1dZZUpDUzcxb0FGY0FnN05LTCsvWmFaSktzMTh3TkVLK25SRHVsVXdmeWcv?=
 =?utf-8?B?OWNBclE1LzVnRW9idElxWXBNeDlmM2ZvTnp5cDh1TDVZejlmNTQ3NmFZZTRL?=
 =?utf-8?B?cGtJLzFUN3VhZ3ZtQlJsSU1nLzBaWndIOTZnMGozNHIxRHMxY0xiNkxKSnY1?=
 =?utf-8?B?Yjg3V0l3b3FaVGc2Sy9KbWVQVVNzemE0ZVllZ1N6YXEwSTRTbGpveDFRSjhu?=
 =?utf-8?B?VjQ4TGptSnljQVMwUlJaa0JFUWRTaWs3WnhNZ0VyeVNMUDE0aTI1Zlc3Vy9p?=
 =?utf-8?B?Q1puS1VsUS9nQW1jM3J0QzlqWkl5eXY0MXF6NStBenRiMmdHL3FJYzVxZFpZ?=
 =?utf-8?B?dHlMOUl1R3h4TXF5MGpTRkdhd0RvZjBYMlpHVXF5NWF3ZW5hZDBBMjRIeS9o?=
 =?utf-8?B?KzZjSXhYWUZpdGNqTUpTaThKa0w0c1Robkh1YkxQdHlrT2JWa2Z4MEUvSWgr?=
 =?utf-8?B?amRJSzM5b25pbGFhVkxKUElrbDFPdy93dlE1Y004OVFNeHZKQ2tQMHhuM1g5?=
 =?utf-8?B?bk1QZmtLQTBRclkyZ3YvcTlnNktjQmU5enB5RmJuSXhORVpROURXRndUTGRh?=
 =?utf-8?B?S3dITVdVZHN5OUFPRjFNYUtmQ3JKV1VrZis1S1U4azVHNktJRzZwZzFKVmlt?=
 =?utf-8?B?M0k3UkoyeDN3cTFrajY5eHYrQmw1a0FSVHQvMVEyWDhSNDFQRmtGN3pzQW1o?=
 =?utf-8?B?N2N6V25NK1RmUG9YMmJrZW5pZE9KY2haUHRrNGE2ZnBuL0VZTW9Ic3NsZ29n?=
 =?utf-8?B?UGFmRnd1ek9ieUxabXV6Q2xjamEvMlA1SUQzK052VkorNmdCQUI0Vmx0Zlh3?=
 =?utf-8?B?VWlacm93eVBXQVBiYVBIa0dqenh6NWx2VXVuc2UxNVhkSzRISFJyYmhCWW9n?=
 =?utf-8?B?bVNENk14a3F0RnFaWU01bHhIcXVIbUkwL3hyMXk0S2ZtbThWNHZSVVlSMDY5?=
 =?utf-8?B?Zk9IUFFWMzBWTS8xNmFHOGhZaytMNDdVWDFtZ1duMi9JN1JJRm94QWtSTU9p?=
 =?utf-8?B?eGlVcUIwMDZvcjltS01vaE9mUS9xTnNBZzR3V3ZlU2d2dzRQMG9UVjRTTlha?=
 =?utf-8?B?RTI2aWxJRXdqbGFRMTVraUVPd1JZVjdIM1FjSWQrODEzeDk3K2wrVTJ4b3hu?=
 =?utf-8?Q?mLiDpIuj9Kq8B4W7pJNTwJ0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b3862636-e134-4af9-903e-08dbb5c42403
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 08:17:02.6895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5HvVyaBOrCQ+5GsCCpoy74hpwLVH9ZIA1RBXwrGQeqcJtvTHqPf/MhetnxkkLO2wmG+iI1M9GguaNgzHhkyWVdl++kxCzMKJrhoxLo1zzOE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5225
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

On 2023-09-14 at 08:14:25 -0700, Reinette Chatre wrote:
>Hi Maciej,
>
>On 9/13/2023 11:01 PM, Maciej Wieczór-Retman wrote:
>> On 2023-09-13 at 11:49:19 -0700, Reinette Chatre wrote:
>>> On 9/12/2023 10:59 PM, Maciej Wieczór-Retman wrote:
>>>> On 2023-09-12 at 09:00:28 -0700, Reinette Chatre wrote:
>>>>> On 9/11/2023 11:32 PM, Maciej Wieczór-Retman wrote:
>>>>>> On 2023-09-11 at 09:59:06 -0700, Reinette Chatre wrote:
>>>>>>> Hi Maciej,
>>>>>>> When I build the tests with this applied I encounter the following:
>>>>>>>
>>>>>>> resctrlfs.c: In function ‘write_schemata’:
>>>>>>> resctrlfs.c:475:14: warning: implicit declaration of function ‘open’; did you mean ‘popen’? [-Wimplicit-function-declaration]
>>>>>>>  475 |         fd = open(controlgroup, O_WRONLY);
>>>>>>>      |              ^~~~
>>>>>>>      |              popen
>>>>>>> resctrlfs.c:475:33: error: ‘O_WRONLY’ undeclared (first use in this function)
>>>>>>>  475 |         fd = open(controlgroup, O_WRONLY);
>>>>>>>      |                                 ^~~~~~~~
>>>>>>> resctrlfs.c:475:33: note: each undeclared identifier is reported only once for each function it appears in
>>>>>>
>>>>>> Hmm, that's odd. How do you build the tests?
>>>>>
>>>>> I applied this series on top of kselftest repo's "next" branch.
>>>>>
>>>>> I use a separate build directory and first ran "make headers". After that,
>>>>> $ make O=<build dir> -C tools/testing/selftests/resctrl
>>>>
>>>> I do the same, just without the build directory, but that shouldn't
>>>> matter here I guess.
>>>>
>>>>>> I use "make -C tools/testing/selftests/resctrl" while in the root kernel
>>>>>> source directory. I tried to get the same error you experienced by
>>>>>> compiling some dummy test program with "open" and "O_WRONLY". From the
>>>>>> experiment I found that the "resctrl.h" header provides the declarations
>>>>>> that are causing your errors.
>>>>>
>>>> >From what I can tell resctrl.h does not include fcntl.h that provides
>>>>> what is needed.
>>>>
>>>> I found out you can run "gcc -M <file>" and it will recursively tell you
>>>> what headers are including other headers.
>>>>
>>>> Using this I found that "resctrl.h" includes <sys/mount.h> which in turn
>>>> includes <fcntl.h> out of /usr/include/sys directory. Is that also the
>>>> case on your system?
>>>>
>>>
>>> No. The test system I used is running glibc 2.35 and it seems that including
>>> fcntl.h was added to sys/mount.h in 2.36. See glibc commit
>>> 78a408ee7ba0 ("linux: Add open_tree")
>>>
>>> Generally we should avoid indirect inclusions and here I think certainly so
>>> since it cannot be guaranteed that fcntl.h would be available via 
>>> sys/mount.h.
>> 
>> Okay, would including the fcntl.h header to resctrl.h be okay in this
>> case? Or is there some other more sophisticated way of doing that (some
>> include guard or checking glibc version for example)?
>
>Ideally fcntl.h would be included in the file it is used. Doing so you may
>encounter the same problems as Ilpo in [1]. If that is the case and that fix works
>for you then you may want to have this series depend on Ilpo's work.

Thanks a lot for finding this, and yes, I get the same errors by adding the
header. I'll send the next version of this series with the added header
rebased on top of Ilpo's series you mentioned.

>Reinette
>
>[1] https://lore.kernel.org/lkml/dfc53e-3f92-82e4-6af-d1a28e8c199a@linux.intel.com/
> 

-- 
Kind regards
Maciej Wieczór-Retman
