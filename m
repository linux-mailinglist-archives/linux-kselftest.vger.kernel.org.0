Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3E678E791
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Aug 2023 10:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjHaIHd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Aug 2023 04:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjHaIHd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Aug 2023 04:07:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F81A4;
        Thu, 31 Aug 2023 01:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693469250; x=1725005250;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=KuO7hc69zZ7ajFjKx5vfL5zyGtHNaBKsIh/chjSoTTM=;
  b=EQRVUcnJH/AyZMjLi2a3KjIWLGACf9BuOB/shkNZwf6KCjNj+Hwrg3Vu
   EexXZJNG/3YBNqkxDyE60MJlR4vZXDYKmoWBD09x++XZYyRl9VaDHbGUt
   RJv+orRkjThmAGeP4Zh0N5/Aqzq7mlDoMa8By4v51fuR6xPqMyjrWU1+b
   APBzVCc9chKQKdey6PEpUXy1xZKVp7g3uHu/FAVo9DV7KvkLNa6OOSDvS
   myFCnB474ZV87ke5TfFY5QQPyEvM8J2uoTiGS25aHOVZ7H842vMWRl0Bl
   PZDyEzJnqEd05zso5amsSp3gvy0crHJhJlmkt1Wp9T96aHbQaH0nVqxz4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="375801658"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="375801658"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 01:07:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="854056443"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="854056443"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Aug 2023 01:07:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 01:07:24 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 31 Aug 2023 01:07:24 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 31 Aug 2023 01:07:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qfmfcejj52EcVE8EuCHZRb9uiq0Uacc8MuyOQAZHE+TdY41DiH1Md5LJjBEB9+bzwYrQ06F15Fj20lwyrUYT3jOQFjG4vBWiw4EpOSKCH9IdKB1BA5uYQB0Ug/O6wV1C55LLuUzRdW1njTGO5DZWiOx8GHqyWkeGqD2qEDRN3ukIcpUl7kJkZW8D/07tx3WE7FyVJXuwhMslYaRmEUIpQ2xpiN4LngFaEo9XV/FcZgjTSaaxgGI+n7ui493rTW+1ZYlLNoo3BsBXOklBqtAGNSibIkJG5O5RcbGGfMqTBb9d2PqGH6SIKWLq+xD6BfKymNzRKJ72UCXygcMs30WwtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gAnZHMBnv5BXVz1yuIIEM7dbzq5V0z1ulpbsTFcp5YM=;
 b=MUeOhjSBbP6UJYt0aVVP7kmwt8rU7cG11vy0qgcPlQWzQd/hzr0WdeySulIhuZPpq1G1TVMpK42ptz3Wnia1QiIHxGwNZ/Q+sYAaq3uZonlRqycWhYyus2LGsG8dK6mG274rTgYz1kqFnII8jBHpDD37z7atP1noAFqlNsspVdKWkdC5xqQCpnix2SZS2/lLwXiTZqfSs3qkV2CiVMv9Nqz9I3ZoY63PF7l8X0NNobsJ3d2GYW2PLMKWQebei5gnsTC66VofQQTmmxALEGL25+1hGV9eynXeg1r9GQyw07JOcJs8nC15iA+ckCqhnjxOlLoQHMqnELt/KdW1/GfufA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by IA1PR11MB7176.namprd11.prod.outlook.com (2603:10b6:208:418::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Thu, 31 Aug
 2023 08:06:57 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::8824:ea30:b0ab:f107]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::8824:ea30:b0ab:f107%4]) with mapi id 15.20.6745.020; Thu, 31 Aug 2023
 08:06:57 +0000
Date:   Thu, 31 Aug 2023 10:06:44 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <shuah@kernel.org>, <fenghua.yu@intel.com>,
        <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v2 1/2] selftests/resctrl: Fix schemata write error check
Message-ID: <gp6qu6zqa7h23ddqfff4mwigh7b5tzfsfkqlrpu7xz4yydk4ck@pgxge6ftz7we>
References: <cover.1693213468.git.maciej.wieczor-retman@intel.com>
 <6c263fdd2b09060e667d179be13ce8f989821673.1693213468.git.maciej.wieczor-retman@intel.com>
 <57f891d8-09f9-fe5d-fa85-0669f5e8d1ce@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <57f891d8-09f9-fe5d-fa85-0669f5e8d1ce@intel.com>
X-ClientProxiedBy: BE1P281CA0031.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:22::15) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|IA1PR11MB7176:EE_
X-MS-Office365-Filtering-Correlation-Id: 0815d73b-5f7f-4cc8-e264-08dba9f93ea3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qEnOUWM2zXHoqLgWU0N6SNrZT/Nh6sr/U1CqbXvRCabWqOz2mtG25YylXlwMIrx3eYOdEwRZ1WHHWJUU/JkDsjCFoh21V/YqnsraLIXkyvsMCPN7D28YbK53PhDzF0Ieho4wVU+L2bzZfQQw6qg7tStttZf8P1J2oeMhGi9p7Oba6y0tzut+cHP/EXyVkjuePHMW2UEiQ7LlM94k36aDsgCHphu9otsl8sPiP3LxE+sIG5AMDH1EtDUX58KPWZt5xdWlUUnOD5eghgQerSien9T83xBNFBat3+U1BhQhqzGXJjOKRAuFKt879oBNVTgMYqbO02Cg20lf2dZ2sbDyVDHXnG3wAA6hYOI8INThWKHOGoh38jZO0gEAoJDr09l6zhEHnmfypRNtpk6iqF00LutrQwC8OUJ79OVM3HM/jv/CedorXOAW/mFIyDw2T7V27WA8KYlLiCtsA+FBN+D5SbOKMJ9h8neJBN+4D1OfHTRdFIMOfZAjBcn38eyIjsD6bwmxzLRMvenVCJAWV3hOvm7xDZYbnzdxPIf9FEfM4KK7m5tqBy7EeuE7lMhlDKnv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(346002)(39860400002)(396003)(376002)(136003)(186009)(1800799009)(451199024)(6486002)(6666004)(6506007)(6512007)(9686003)(53546011)(478600001)(83380400001)(66574015)(26005)(2906002)(33716001)(6636002)(66556008)(66476007)(41300700001)(66946007)(5660300002)(316002)(8936002)(6862004)(8676002)(4326008)(86362001)(82960400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?4A/at5InewFoJtADUY7yFjped9qJyssaiYbw08nFxAJeNi5JLn5CNv5fZz?=
 =?iso-8859-1?Q?fp3PCchq3QeDPd3yIovr7sBZGiXDLFTbEsTztmml7o6fnvRZb9CqXZct54?=
 =?iso-8859-1?Q?GF8Q91ySgHgx6jW8VcYwYXnvi7t+OExowRZ1keLRJRJ2sTh3rfWfVFR8Qr?=
 =?iso-8859-1?Q?gpuONJxP2N8K1G48PNyQokU6XX2zMxLDfcf1vw4vR8gknbpibDJ5tOKV8U?=
 =?iso-8859-1?Q?isOMMN+3kiwBFkv22gtdU0Pogz3+PdHtUM08iwIeJ/Kt8NO6CXkDngce+s?=
 =?iso-8859-1?Q?wOB/56RqEgW6sIpe2XaFWIYOE5DK3I+f/uvE7kqbLS/UBbpfXgRaf5fAEM?=
 =?iso-8859-1?Q?L7Hpi6xQk5fh1GLxZLxyBpPvheJSsUOju7ccAkoqRdbIo8CYSfVAyhddw0?=
 =?iso-8859-1?Q?39UNmQFdslcdoqzQIJNsknNuKTJod7j5vPv78pejTjdkvvs2txqRIzTIir?=
 =?iso-8859-1?Q?/vWoEcVXRcDb//3QysazR/0K+y4sgXgzPLwdEDJ2ujaR7z/sXhvN2xSAoF?=
 =?iso-8859-1?Q?KZ9AoRQg+EX9QpemK41GMSUYIlNSAGD7tzLb072vVv+Phy/MR+gkdBK3os?=
 =?iso-8859-1?Q?ofiFLmG5mIUMCU9V6f1oCz44Nd5zSyzrQfjpn4p8oqSU2QOfXR1pSZ/kT6?=
 =?iso-8859-1?Q?JpChV423/i4w02ICLKHDVIaTZmJ+wgtB00XCIS9ogS6a/Bo6NgLWTcw/64?=
 =?iso-8859-1?Q?bNT8pwjaR+nZhefPe47rkYVKv84SvBjZZWGvJHQg25RVlubh5RXNymVdw8?=
 =?iso-8859-1?Q?O2VRnrdvioMyKpKirhtgUpkHqITQItsT8nPza3H58YmR9KmOlI4DkTVxxe?=
 =?iso-8859-1?Q?4dtjQtsf4M747nKhOkTeiJZ8JQh8SaJOAX0IqeDGqOBFUx5CG9RDaON7sP?=
 =?iso-8859-1?Q?jFQAuBcJ2s9hqND/FOqICY3yWXcbCvRmSU3Q42G1zGL8nixyN6UAC5Oscq?=
 =?iso-8859-1?Q?ALRXK5PaHDjkGkEqPE9p/Smd2mSGD+/oXZEbh4p1n26XeH6ZGeE6OSlNuv?=
 =?iso-8859-1?Q?s4bPOME3iICxiRuhKgc3nlqEPmmZnWHh7i0rh1sj7o0cOW4BL0D8L2tSjR?=
 =?iso-8859-1?Q?T4bGiJX8Hc0K6DWXu2r6QKqHaQlc04PfyFW+lz41eRMp4aHNVz5dJ+6d8m?=
 =?iso-8859-1?Q?IzfEo6O2/g1Td6icSCIvcwax6+cJd9Ejsvvs6LEsa3QxlREbQSKbsIBrs3?=
 =?iso-8859-1?Q?+4TqzaYrN7Yn2QaVNweICpiv5IcEwVzw/YvV8vbqFbZ0sQ7147ibde+4+Z?=
 =?iso-8859-1?Q?I38tBly+iDVFyGuDxBlRCXkP9so14Sc0qeSce2EeUlZ1ZzX8hM2XDG/eob?=
 =?iso-8859-1?Q?01yVWBb/0vpFgSNPgfoO7A6AKmep7ykZKF+MO17nK+sLYJ0HCvk22bu9vY?=
 =?iso-8859-1?Q?QuzPu0dTatP/JD8bwJLA5Wmiyz2yoRJajeFuHHz3VlGHrJiamrdaboXq6D?=
 =?iso-8859-1?Q?BeKBQ2bbQ6FH2vSxLeF906k1ly2gaY+yj2RDrRdzJKoNGnAL44QHzl7WfG?=
 =?iso-8859-1?Q?PY8aaEtBVQUa13DUS3W6qWj5f4V7T4wLhYIBxzexuYSWrPmzOUWftsJAro?=
 =?iso-8859-1?Q?I/kNSAfZJ1UY/A8fN545QKZnxxXX5mwyO0dcn3eEJcBCrqgiwOESZuNUZF?=
 =?iso-8859-1?Q?ONBODuziXIRY1A4MxJ6VvUpQlCkVnMmAjBVZmEa6tcE/3WXETHnZbqnMex?=
 =?iso-8859-1?Q?c430mePCRQRjKRXPfBY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0815d73b-5f7f-4cc8-e264-08dba9f93ea3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 08:06:56.8754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Js4+Su++EZ2dGobQ0s9rM7nKtRhSh0wZeoW+4CsTZ36OZa6/wnq7FOpDztDvPnZjtOfXrB2DU1ne49hhXsg3XFI3DfVXI1k83da4quLBwdY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7176
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,
thanks for the comments!

On 2023-08-30 at 13:49:18 -0700, Reinette Chatre wrote:
>Hi Maciej,
>
>On 8/28/2023 2:56 AM, Wieczor-Retman, Maciej wrote:
>> Writing bitmasks to the schemata can fail when the bitmask doesn't
>> adhere to some constraints defined by what a particular CPU supports.
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
>> Add newline to the end of the schema string so it satisfies rdt
>> schemata writing requirements.
>
>I am not sure how to interpret the above because existing code already
>adds a newline to the end of the schema when the buffer is written to

Okay, true. I meant I moved it a few lines back but there is no real
change there. I'll just remove this paragraph.

>the schemata file. Also please use "resctrl schemata" since RDT is
>Intel specific and does not use schemata terminology.

Thank you, I'll change it.

>> 
>> Remove newline character from the schemat string after writing it to
>> the schemata file so it prints correctly before function return.
>
>schemat -> "schema" or "schemata"?

I'll stick with schema as that's the variable name, thanks for finding
this typo.

>> Pass the string generated with strerror() to the "reason" buffer so
>> the error message is more verbose. Extend "reason" buffer so it can hold
>> longer messages.
>> 
>> Changelog v2:
>> - Rewrite patch message.
>> - Double "reason" buffer size to fit longer error explanation.
>> - Redo file interactions with syscalls instead of stdio functions.
>> 
>
>Please place the above "Changelog v2" snippet below the "---" lines below.
>This is text that should not end up in the kernel log.

Yes, I realized I made this mistake a few hours after sending the patch.
I'll correct it and make sure to double check it before sending next time.

>> Signed-off-by: Wieczor-Retman, Maciej <maciej.wieczor-retman@intel.com>
>> ---
>
>(list of changes should go here)
>
>Reinette
>

-- 
Kind regards
Maciej Wieczór-Retman
