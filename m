Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABFC37B1251
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Sep 2023 08:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjI1GHA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Sep 2023 02:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjI1GG7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Sep 2023 02:06:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D8899;
        Wed, 27 Sep 2023 23:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695881217; x=1727417217;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=M7wn6LXMmoSpzSb3GzjxCu7+xb86xCRFUDpq1irD7rc=;
  b=bOAgbbJbP/R9EOTLC9LoVf4OY9VxTtRxjhLl0dzHEykt+S/kEg46lAoJ
   CuHmrh3pEsi+iuAqe5a7gl3oy0BIR4ZosLkVNSijMtg9y5hnz5td70bfv
   eNdcItAZmkJsrvZBsLSZkjwUKs0fsIvWyn8Bsuhn9/ANUDkpXDiT+RCKG
   4FudVZkkJmUZYoE4XvKO4reLOk7HmfT6nDL1WQw9OXkbAJAlneVo/oYrD
   NrZW5j2IWaRVqNHsdj65ZDKkXN6m52MwvAa5ZuB49lsiRTAwXenwLGcC4
   bJeKz7MHbyGZ+yNOhl+9+0WKESCJcVdd3knOu6PMQ5ZbyYwEPN3fu4Xs8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="468276554"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="468276554"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 23:06:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="815128296"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="815128296"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Sep 2023 23:06:55 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 23:06:56 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 27 Sep 2023 23:06:56 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 27 Sep 2023 23:06:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BkUUZHLsyYFakmlq4tYDL+ZzrZE62U6BmZ1PUHCpdtS4gGRwE06TTLfLtYv/EAUJglQWYZ1HtkVuwooVvv1YnH6mWccA7q1QuUKu49ntnMs/H9Mf03N4KOy4h6kVGm4yQ3eqlchYb3ZNmTAnnm8DOBYuP/bZZhMoRX2rvp6YGw3SAbVlt9AM0NZW91emxpcqxE5XSbJL0h5BlOR6PIusaKNHNTSBq+uOu+MKXPpbg9OFqqVSH4S7YgoozZo++mi78FAhVJDNQUO4txIwUihbDaQIum0ig4AdStcQbP7X6n3hSsNAjzsfsyRdb9tW5LG2P2Sh+2NGXXa/C9oODicUMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JnI5ZNPBi4uOllgdg01XOULPVD5yKSvAcI8l/PsaqsE=;
 b=eCgwn/luV/nAuIOR2CO97T/JxVvCyMSQRsD2xB8ZzqikEgRYETNOHlQ9KVuZy8ciyx8glYCMStwodRnaX3DGrsuX2wYZTXiv+4UNpOw8PB6CpKBZNaCqzo9u+8Ze08Mrg3wv7K+JR9E79LeWgO0jXK+NqTDZIO2oU173tE9s3iAqWm7FQ/5QK7Y2nxDFmeXzC+y488nnHC+6Q/0TXSn1GsegxyYLBOnfDXY+/YRfxvEnGePviKPICEmeZ9qFTNI81ysEzL/Mbi4/nsSMMeUNjsia8lqpkLVZsIRn45iub+KGHSelZL1uwOWgywAzPbuSyfL9/9aTjxFOp8KHHE0GIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by CH3PR11MB7389.namprd11.prod.outlook.com (2603:10b6:610:14d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 28 Sep
 2023 06:06:54 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::fd1b:a3b7:11a6:4bc3]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::fd1b:a3b7:11a6:4bc3%5]) with mapi id 15.20.6838.024; Thu, 28 Sep 2023
 06:06:54 +0000
Date:   Thu, 28 Sep 2023 08:06:47 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
CC:     <shuah@kernel.org>, <fenghua.yu@intel.com>,
        <ilpo.jarvinen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v4 0/2] selftests/resctrl: Bug fix and optimization
Message-ID: <kisdkc4pa4fbmkhartsmwbg2lhxl2co3ude7bzrbpubn6r3a5a@xtki2amirkhx>
References: <cover.1695369120.git.maciej.wieczor-retman@intel.com>
 <ec0a63fc-081a-a4bf-8ebf-d501b1d44cc0@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ec0a63fc-081a-a4bf-8ebf-d501b1d44cc0@intel.com>
X-ClientProxiedBy: FR2P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::17) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|CH3PR11MB7389:EE_
X-MS-Office365-Filtering-Correlation-Id: e1fc7a3b-98ef-416a-87dd-08dbbfe91bff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cbJqLj7r5J05IcjJvTgiB9qt9/GW4MmSOZPqMebbZuyCbcs0b5sDNIxqdw/U9q5MeJHLyKbX9bpmIs2J65alG6S68Fij9yZOqF2qmRRXx06MBtkYme918TCwSK3jLzxRoOC5UjrychKdAvuf01QOvICf+oK4eTrWl7nX45l3XC6ZXXqbeo4Dvuy8eb5kSzuV39sQlWhSFwM1pl0bEcBpMUSbf92v/+5dv9c2IegVRpRFJc18jPEe9aOZcN0vN/gNJdDerTOmDJ7vdSX9abrc+nTNwVck7ZHw6qP94xDnPRBmTAIyUK/r65t4M7hk8xCPZzqXY1i6826AnTsRQR6Mc0CZtUqP1o6PjHi8GQAbSsHXahCRTD2jkmsSy6jWrFNs31q4rkaxB4hogrNiSGYthWnmiX4iTj7VJCmRe+WfQmXv0IVbAg7zq4YlUFha7jMDQsLE8dexQUKqvFeAKdyPr8JwRPV1efy2cjeIxNq5dN8kghrqs5A60KLPrR+t/CaoDr9A6rWCIg+CjOAwfl5IaQeZOAvAGfN1OR5eWu8/uLBay/5u3O7VviwgcZHPoqCb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(366004)(39860400002)(346002)(396003)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(316002)(6506007)(6486002)(53546011)(8676002)(6666004)(38100700002)(6512007)(82960400001)(86362001)(9686003)(26005)(33716001)(6636002)(4326008)(6862004)(478600001)(66476007)(5660300002)(66946007)(66556008)(2906002)(41300700001)(8936002)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?nI9rFmJTOX5+tT/F/PkH4RkE1sve5n2vx4nuk8+SjUc9935MgjqrI93qHF?=
 =?iso-8859-1?Q?YpmAju+MNJlXb1PCHBwDBP6T4xq3SSvtmXCv0YU1/j9EtRTViu4Saj1eNn?=
 =?iso-8859-1?Q?RbLDmHDp3secKMmfRVFgD1eHR1NNdWwoFgC0HsnX2rAAt1tZ4s7Xsx8Oy6?=
 =?iso-8859-1?Q?rJQsPBM0vNKcg5wyKNStpc8+EJ7wOeKZI1ckghoJrn8e9/heqjBto90ToK?=
 =?iso-8859-1?Q?9ZsDME6Tzq6SWA99EVBgkP/kZmuyFKPIs4f8Cx+KuEM9n6aIljpiPVcD6W?=
 =?iso-8859-1?Q?XN7Q6mLI35X3VvQxNIzzVBdhv0NpYvhjz+2w2D+ZadVErF9daSEykxc5EP?=
 =?iso-8859-1?Q?p7EdZ+cetsACzlfame1mwACglSsqvsSJLa7NwiawCK1VfW9JIAGHbLFBj+?=
 =?iso-8859-1?Q?PV/P6MZ/oG1LDkFwHM/uUGljkkS/hlqggY59NjEghFudZWfiSAzqolU0Kz?=
 =?iso-8859-1?Q?IX/t/ybaQnQXdA3Dpd1QU+ZRJarPdPax5i+NpEVPJz1lbizHRmbVtLnfep?=
 =?iso-8859-1?Q?GkmQ4NCy3FWCYGTXDQfU3m+vnpKeMewFLh4gcIS0LZNzPiqsPdXtqBn6NU?=
 =?iso-8859-1?Q?wGo5LVOsAgDCb4o2TkCZY/mqDWDqAheO64vukbZwdX2xFPKkGUpJfphcoM?=
 =?iso-8859-1?Q?pjheF8K1lFXzZxjtsv+bqRAUT99nZBxnh6yRB7VF63gDUdmQQma0WPOAWR?=
 =?iso-8859-1?Q?OwPlQkLpkmRsTemAQRs1/2f159o296CS9VSPEkEUGMHjvx9cKiz8onzGxz?=
 =?iso-8859-1?Q?ewie0GNyr00bp2R2or8PH+4RXg/1cpd8wDwCpWd6Xwrrm1LeAp8pWKVU9H?=
 =?iso-8859-1?Q?cWJFvxqMVbMA6cjCEHSqA6bqMtIBsBuWYANyKwTAX+JnJvASdO6athwlGB?=
 =?iso-8859-1?Q?aZrQbZOQ7Vzs/S72ANWcuo7zo1qUQuESkRYTV/0v0rQD71zY0SJJSIQaaj?=
 =?iso-8859-1?Q?/f2eAPSYL3lWOZ9XxTAqodZIh7v/RmVS6xe/QlOm2ysMOSgXphAeKxr7U6?=
 =?iso-8859-1?Q?Z6AaOsweKPV9E6hRhMcknTR7wDLDL6lfW6l4j9P9wRah8rqlVPmzP1Ox6O?=
 =?iso-8859-1?Q?hu1bbijSkNFtfn7dj91pc1MQ2uWItctHp6JqpiMsAE+ubZJTiBwAMGYgaP?=
 =?iso-8859-1?Q?RfhX9hEGp6FfjqpttHzhPfcWGo3amj+IU56DKWe90XLpCso8cKDu9afMM8?=
 =?iso-8859-1?Q?HRL002gRh8GfPAlk1klsrhuB1ECWJq7Z+IlWfH9x+iE4FMlDNpN6iz011T?=
 =?iso-8859-1?Q?7p5lVDzShRnvR/fxJItgQ16//IkhfzXKy8XRSi2tUgiRtzqJ17NQTuIz4n?=
 =?iso-8859-1?Q?F4E9RaTAXk6MZY2mb3QplTx10d0+iejFHkFF6SBOvN+bBAce6CNRlZm1Vr?=
 =?iso-8859-1?Q?VEt2m/2reDDaTzE5H45eGclJ7nzHfIMJycGLy8cwmW29VroAydJQRX87RX?=
 =?iso-8859-1?Q?drSPFf0Ib/uLG/xCu7wWF4qgzfuavH1HAbkOlnjCPeQH67YQlN50n/dHrf?=
 =?iso-8859-1?Q?6Ou98F6orx5Bk6o9qMf/Kbj9viOE/aYzxs7JpHXNwqSJRXTjMUpA+xPGKt?=
 =?iso-8859-1?Q?fWS3qpCVRN2qQkQCSlaBQQo78CedyHwjdsWq4hxXCrIwu/9taqEMKnJ98E?=
 =?iso-8859-1?Q?I4uJJTeyFc5WnETQHqKZUB9SgMXApr4ycIyNQRU18N27c5rH/RYq12YXNB?=
 =?iso-8859-1?Q?6Tr87s2/L+mQWhJ2Vs8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e1fc7a3b-98ef-416a-87dd-08dbbfe91bff
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 06:06:52.6281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3tlU3jJF29M0cp1PR83it6MOfGfemoh9Y85LkY3CO5bQzQZ159WHZUBqArX2jmvYsOAKD3JXi0xr39AvQEJe5/QGSlUcOjX2152wFcgUc94=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7389
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Thanks for catching these, I'll remember to do that the next time.

On 2023-09-27 at 15:16:18 -0700, Reinette Chatre wrote:
>Hi Maciej,
>
>On 9/22/2023 1:09 AM, Maciej Wieczor-Retman wrote:
>> The resctrlfs.c file defines functions that interact with the resctrl FS
>> while resctrl_val.c file defines functions that perform measurements on
>> the cache. Run_benchmark() fits logically into the second file before
>> resctrl_val() function that uses it.
>
>nitpick ... if there are comments in one patch of the series please consider
>if it applies to other places in the series.
>
>> 
>> Move run_benchmark() from resctrlfs.c to resctrl_val.c and remove
>> redundant part of the kernel-doc comment. Make run_benchmark() static
>> and remove it from the header file.
>> 
>> Patch series is based on [1] which is based on [2] which are based on
>> ksefltest next branch.
>
>ksefltest -> kselftest
>
>Reinette

-- 
Kind regards
Maciej Wieczór-Retman
