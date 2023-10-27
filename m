Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7D27D96E5
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Oct 2023 13:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345737AbjJ0LsJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Oct 2023 07:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbjJ0LsI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Oct 2023 07:48:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D45CC1;
        Fri, 27 Oct 2023 04:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698407286; x=1729943286;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=pIwtqXDZ8MIW96KphHoeCyYq4Ndrtotu13FQGs+c+MA=;
  b=HSUUTr9QBN+JmXIfcFfmhljepJDLM7VRz9xrQmC3PIqSHO1ZGeB/cn84
   pxc9QQYFK64lb+E8v4O5apZNc1Sd1EW5ykB6/c5KIiXdxArl+NjxGy+J/
   nZAQbxmucYPHlfkGKXJutZdqCX0r/pkqkGlvRnyaoIpHNlXF3gx+ttiAi
   UhzOxJlFVquYKqIeGBRUyvCMiGs4waSSvHh4NeHXiqLZaXxum/ubiq7K0
   oY9DChZd1uEu/2MuLRdZqZRMTXeKm1sCcn6qkSJdqqQ/x24TkcwizGiTY
   DlJvLKitO6AgxUG4I5CetkE6fq2rQjgggf0m3T+KKQCMaSxsr3Jp8B7SO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="9299286"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="9299286"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 04:48:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="763192466"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="763192466"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2023 04:48:05 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 04:48:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 04:48:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 27 Oct 2023 04:48:05 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 27 Oct 2023 04:48:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QbbUMPzeuqqBDF+fMYoeCZqmNVKNxbDIW9IOMQoLZsGc24nEwC5wMPLBSqy89dzkTpQ17f3Xhhz07SUr7zImo/v7cajxJOu+WHKMVrHiOOYFWd9MTvAMrn5q0zvwPiDNWlONXL8L8lIG+1YDgqx8gfvMRJw4NC638pYQNOO2cVtvqPNWkmz01gRt6pYPuLX2nlOGJYtJTYXUgHDgRTxpltBlqKQk7bSW0Jc5KmpUo5I4SpOyBBerkPwTbg9932f99rGjBsFKfADB7TnfoM2ze+GFO9zzowJumRtXO/YpRph9FvHWR/DQBsm91q36rToM3B6hRUVFxtD/cCrLXic0pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VPoey5XJkHI7BS+ukmw5F+nMXsii9+165dEykTZgSEs=;
 b=lY0vjdZg5gGnalFj8Lr9YGIQOBjd1lIjHI4MCpZyO58xuj6cgSTWIAzyvuR/ip/L1Z7I8gG6H+GYl1jXkTWjxAQkabm+cwlRlEWU+hPaRFVMWFqvKgvzqa8gfHEEQjCXW8Q/ikcGjvYbKMIPGZ5i81lMRnZFSCm6juls9CYfzP/Ux0B5gKAr7DKhbTP0rDnJzwZkeJ4k3jX4SZjiaSJARX2GdKFmJYcz6L5p7AYGDoBmamTCjscjRw9ZplYg0iyHwdySOvcqE0Ed1hD7LbVKZkus6ZeJU9rsb6bD5Ab9jaIHUFAaEvW2LrPiZo5JDXP1Kd0pHr9OoeMH6ODhV0pSvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by PH7PR11MB6905.namprd11.prod.outlook.com (2603:10b6:510:201::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 11:48:03 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::f4b7:72ae:86f6:450a]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::f4b7:72ae:86f6:450a%4]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 11:48:03 +0000
Date:   Fri, 27 Oct 2023 13:47:58 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
CC:     <linux-kselftest@vger.kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 13/24] selftests/resctrl: Convert perf related globals to
 locals
Message-ID: <f6b5e7eqjxyt2fcpeub2iusxdpnfkmvaiudgthwmowmgdmc6gt@uaxdzdwj3fg7>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
 <20231024092634.7122-14-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231024092634.7122-14-ilpo.jarvinen@linux.intel.com>
X-ClientProxiedBy: WA1P291CA0020.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::24) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|PH7PR11MB6905:EE_
X-MS-Office365-Filtering-Correlation-Id: b3ccc402-9a0f-47e1-0160-08dbd6e29374
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O/sSerH9yMr4aOZaqJ0iLnk6LH3e4JwG/eRnv+GQsHbnpE8lU9b5o0J0XNNjNk7zDTh6RKSTwEclod7k3lel9EQIk/rJKUJnsiGTpwlKpFocE3zKUbhdnH/IqzePvtKfsKLxXRpuUDIAJJ9SM5RnWyoTf7KPJtTwBNsWwVS6eh8AoEJcjZOra2hsntID5pQFLgJTJVBm1Yzj4oK9MWN4hVUFMuleI2maxzIB4fWVLZNENJIbaD3lM4JyiTrpIbgmDPUpYw044gl1k+alT/RPz89ocyr72ElVaPR0wIGZimChyZKfjeXYlxGcL3CDI2bfK5frucAybeSuIf7A7iDfjR8jUAgj4dUw3+9XgeoN+6Yz+SyLC9QcfgLS7kSSgUx2JQl/U0xTYggnLFRP26vDXSL9dO6AXixgwRJGjePNzs2GlnXeoemg8AuADjx1kt3A8wltFp1mnsIk10J/l7HlrWZWhmcony1jqtQdmjdIm1d9Lpw62faUtGpkF2pg6k4PXZz+nbXmGo3IeMTHKtsZpbNATYKBELPU6Tewjq4/X17l7sLJ3f0uRJ9fuM8m8IR2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(396003)(346002)(136003)(39860400002)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(4001150100001)(66946007)(2906002)(4744005)(8936002)(5660300002)(41300700001)(316002)(54906003)(66556008)(66476007)(478600001)(6486002)(53546011)(6916009)(6506007)(8676002)(4326008)(6666004)(26005)(66574015)(6512007)(9686003)(83380400001)(82960400001)(86362001)(38100700002)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?gK1y/Tig3AtylfvB961+skxlIR9IAzre10EEK+LGDf5d9hn+Yaps/XZ30D?=
 =?iso-8859-1?Q?q9eEU9dNoqbaXiibVi6Akr6UeoY3c48W0pUbhMBruCGeWNKGc7oecZzVWV?=
 =?iso-8859-1?Q?ODB3VEN+JSj+MDK6ISTPJH6UP8qYewQLAZIlP4jpycybTzTTVdN77t0MmZ?=
 =?iso-8859-1?Q?JjBEBESlwvqHYWfUCBKKqOR/Kt2Gks7mEL1TnxWNbpJ0eQd8PyLZ+CwyG0?=
 =?iso-8859-1?Q?F8EFblvFYoKJxcZNTjRbIMim2sXLFbWQE8WSW1FAVE9Gb4fePCiXCI4mI2?=
 =?iso-8859-1?Q?e61ZZ8hqb7SzjC89p5D1+znhZhDllW7+Ay+2TvoYY/PPYC1ihoT4pnqh8e?=
 =?iso-8859-1?Q?bHsui3wVOPYySW2336w+XJOn0P0wFI3nwh5ujVlWPhl/+GtMPYlLRFKg03?=
 =?iso-8859-1?Q?zfMmAVjlr+19SFtuS+eBSycj621WYpW4A3U5cmivtkxkGMKFtpEWEm0aRT?=
 =?iso-8859-1?Q?GADuSK/wfOEDW8dr6otl05QLnQxBec70rx2USZDpS3XJ0SUK3PxfUaQf5T?=
 =?iso-8859-1?Q?rhlU1wyZiCcmPQBSt+0fHFd6uaXMoUbyP1naQuRG2KsXUnPrhsyvOZgHkT?=
 =?iso-8859-1?Q?d0H/FolJ5kxZwNuWPjB5K6pwTXnUvqp/IbCsycSognsJqVZPGnOK1mnvfu?=
 =?iso-8859-1?Q?LEB/CUW6hNLpZyv1L8S21wHErPuqct3vP7EcKmwOrmZI/HC3+xdv1+AQE3?=
 =?iso-8859-1?Q?M9gmtVlHCnTn+i9oGQ3p5KBPd3iKH6hPQHLewFaNI0DpcNAGWOLqfR2C1W?=
 =?iso-8859-1?Q?FvYhWXpdbWc63aSv06co70Ln4bkShurP2j7kfoBt2yV+PKJfYCXClx6QyX?=
 =?iso-8859-1?Q?pl9nwFCPZGES3UodY6V58at1GfQSlzxR3sv71exLfT64W9oA551E/PvLqo?=
 =?iso-8859-1?Q?hixbzxC+7CRpbOKoyJJkw08zvvp6LfrPYmEXij5CODpP11vsqvSH4C7E31?=
 =?iso-8859-1?Q?0Vh84OWqMgVAqb8uUtKNtkFwqCB8nee3rExysXYAVjqjkZ0L+bw17ewAOQ?=
 =?iso-8859-1?Q?1FtvHudpTIKMh0tBazrxNKfyZ8qN6p1GO7SR2wVdovrfyIr0K/WlgorMmA?=
 =?iso-8859-1?Q?AQnT67ODZqHTTC++oYNxrKvj71mKGfrmisdauOWZ+WBeegDRwngKmTWdqJ?=
 =?iso-8859-1?Q?DbXghT6FGii0wshIAl/emzTU3BQz/sA6mZCxUm+mUxqB8dGs9gusMZenLq?=
 =?iso-8859-1?Q?gfmY3coEhmVYhUotNqUOBqa4Si87u48rizSui7bs0G8FR5AUI75kR0jNRc?=
 =?iso-8859-1?Q?6SMyK20oyaT6uI5LhbKXohsMZWYN4G0nS0cM1xpxNC9reqaRsJb4Q8z4KW?=
 =?iso-8859-1?Q?PTjMLVYylHh8By7qC3w1Rn6A6YTViKC57820jSpUSqWas6ElZ4yB1FzdUJ?=
 =?iso-8859-1?Q?1SVckWksUwd4lDfqPwjGjjSruy4eI0ebErTbGoWECEkjCV4qROkRBahDAJ?=
 =?iso-8859-1?Q?Q6bAaSp7nIkxiJh1cWsyjsH/KFPBgCf9SkuL0K79wkOcghlYoPHHHg/Qsy?=
 =?iso-8859-1?Q?vUjzROkAEJh1alALzp6f3IvRyvEGNWB9wPsiHSZZaQztuXOhUGrcd9OFyD?=
 =?iso-8859-1?Q?PkL26Zz0JGRBb9WWdPqyBDwYM0FyBPydqF7cCVlTujn8uDSI+274CNKi39?=
 =?iso-8859-1?Q?L5H74JoH2PLsEtPURfXmQBhYgdFWINlsARccSglHkbM8nAtFEej46DN43Q?=
 =?iso-8859-1?Q?u6xKcaP5pvTvx9l/hOU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ccc402-9a0f-47e1-0160-08dbd6e29374
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 11:48:02.9802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mZyG0+SH+3uTNr2Lj7GODgl/ztkK6yCcMjnhj2IQGqRGMZDja9sIbkxZnglc5XDFrlAQtW1eD96rOTzhdiDYR4QnBlAywLDP/BTA2Dmn7YY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6905
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-10-24 at 12:26:23 +0300, Ilpo Järvinen wrote:
>Perf related variables pea_llc_miss, pe_read, and pe_fd are globals in
>cache.c.
>
>Convert them to locals for better scoping and make pea_llc_miss simpler
>by renaming it to pea. Make close(pe_fd) handling easier to understand
>by doing it inside cat_val().
>
>Make also sizeof()s use safer way determine the right struct.

"use safer way determine" -> "use safer way to determine"?

>
>Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
Kind regards
Maciej Wieczór-Retman
