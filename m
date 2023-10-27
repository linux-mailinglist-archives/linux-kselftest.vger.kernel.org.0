Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803567D973F
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Oct 2023 14:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345735AbjJ0MIU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Oct 2023 08:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345539AbjJ0MIT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Oct 2023 08:08:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5250C0;
        Fri, 27 Oct 2023 05:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698408497; x=1729944497;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=s4qSDRxsg3g2gjEAQLG1oAgGwzl5QqU0coaB/wdT1eQ=;
  b=Ev/IopaOVGglV5jnUBAKKqvGVqZuaVdQhk8JXtrrbhu0JPfkONKtgyJo
   7VP6G2QJ1s2K/+aCXYhyVNt8tR6y4Kwve7zjT1ge6oVTq0g1TrePyubQM
   VkSJPcNPcrAv6vjRRww8hCG3Tb4wlyUvVxvl3T1EURD+VieQOBRacDDLA
   TeVXbklIYRgjhUGRynOg8Ii50FpaxzBkYyvzPqdDDN2J1pWcxx5cwkwnh
   BjDwSPedJTAIe/xschrl0MEvNnpEmnsoFJPBrKd83VONAJAUAQhT5hcPJ
   8M2/UH+F/CdJXy60iNgJSmA8dWhWOaSYXWzX+Q7KUJV2FZ2ba0q1TZa3Y
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="554869"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="554869"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 05:08:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="825325573"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="825325573"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2023 05:08:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 05:08:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 05:08:01 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 27 Oct 2023 05:08:01 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 27 Oct 2023 05:08:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QIwfjj8rXuzfWUflk02gO2Z+5l4yxks4jkD3C2tNAB1KVH9EYmr4j0YR3zfDA4elfVbqMxPwTY42JFytkEiF906F8L80C7orkBaDAyvHNStSP/11K8HZQIukUzU36YjzyQ/PPkir83zAAnphng8aEiYCYcA0smu7Jz+cExmv2W5F5K/xgD49YJv/I8usuO8Lgf5P331TODTYlhYjgVv5Tdwe6H0oHJz3JSbOdXsP+ccrNIE8gCh7BxnHnt2lUdHBxVvOFji65QG5g07brE+bFk/MIpF9ihzRCCkza4YGaTEKCF7cKL2FL1sIPJkUvdscDg2k6kAXooXEf3/L5I75Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GuMlAEy1vNxpnGqaaDsmWQ8zbgGY/XmT8/xQqM6NBG8=;
 b=MjW0qVNXjlA7hakZzEyze/9/JPt1gSf5hBSUnkl8o4Ba2kPgqZF08O6PWcCg4lAy2eqnD4YL0CDjo++Ie6kiTyl6Z+fzJAdQAVy/jEQdPQy0ndRtG5E72lH3md+kh5m5VGm6xcdVIXIUTIc5OEypuvByJO67tllkNyH0C/8dSmYXijGXciVbBYrIGnGDnTVuYxs9/ttVJh4wwO4X1lzEVoXy2VrkY7jWkPoIYp7rVTdww/djDlH6SCdLYtaLpQNvKrC5hURVd2d66oLb6Cfb09OlBW9cTjQCpxYw31WG51kZrwzBxrh0dWMguSe3ZNgjtFhDbt3sIBr/Vfglhwr6nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by DS7PR11MB6152.namprd11.prod.outlook.com (2603:10b6:8:9b::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.22; Fri, 27 Oct 2023 12:07:59 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::f4b7:72ae:86f6:450a]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::f4b7:72ae:86f6:450a%4]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 12:07:59 +0000
Date:   Fri, 27 Oct 2023 14:07:50 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
CC:     <linux-kselftest@vger.kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 17/24] selftests/resctrl: Create struct for input
 parameter
Message-ID: <sjug356qdmnz4wdhzw4v4pa5vndibo52ght2vtz7gzhk5elgem@hi5eyxepp3bl>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
 <20231024092634.7122-18-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231024092634.7122-18-ilpo.jarvinen@linux.intel.com>
X-ClientProxiedBy: WA1P291CA0018.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::25) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|DS7PR11MB6152:EE_
X-MS-Office365-Filtering-Correlation-Id: 389f2b76-7469-4b1d-d866-08dbd6e55caa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vyfm52bcSxk2ty2bBboVv5cdj7rXzEkhffM0MfF+0SxYMSX9uAiGKlNB9CncX5arcloAFRk/xZ2CFb6GbGmFND6xlUK1HCsZUW4txD/+Kq9mC3txpR0RFWGaaM2bmdp6xsa4vZbq4NGpwiEt6dtQfmvWr5C3qy3h7ECvOZ0NUvttCijVjc3AQLL8Uvxn/6f1y8oh45kDBHTeL7UOlRrCLb5BAAOqBM9ziE1FlKTp0xmPQIvyI7mtlnF/XZbXdUWJyKDEVkCstMWTWjs/fDS8Klxvd17xZo+pWMqbrJoHqGDu5kA8oPLlOSrRvWQJAFI7jHWhNcGDT/Hly4grCucnvnO+/pwEQxA6yGbaRdmUWSYifTtHpvsGlg+VAuV+Y6tgromSFzmHJXBvSt3aAPOYZEbO89NQavjI3QfPvPq6pvonadR0ntnhf2I25e5TUI9Le2uHE9qxXssVRi7d9QZN6nKofyKE0WMoBFVm0yAnSoF3zP2phjSDfGzxdqNQBZcoJ4tTN8Np230mhvk4zKuTzjwR2j77KPxZB4b+GzFS/jIhfD6kKgHqsTOd9RBdCLMg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(366004)(376002)(39860400002)(136003)(346002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(6512007)(6666004)(6506007)(53546011)(9686003)(478600001)(6486002)(82960400001)(66946007)(26005)(5660300002)(33716001)(4001150100001)(4744005)(8676002)(41300700001)(316002)(4326008)(66556008)(54906003)(8936002)(66476007)(86362001)(38100700002)(2906002)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?3FIJt/g2Eo2ee+mIFYIMyu7ae32bdHi9kKvvjOjrOD/FCX3L0IVHixryQm?=
 =?iso-8859-1?Q?5RLgfvrjiyns6h54yT0dlxCBHO51wRjOx5f66p+lWfdsAlGf7facW9xII3?=
 =?iso-8859-1?Q?iL12TTrAOevk9w0nqqPd5X1o/5DFHbMjPz3XCSAZ1EkErybEf+prv62Ja9?=
 =?iso-8859-1?Q?V/EY/xX98bw62FidRjRhWYzO8A0cvAyQ/xz3BlOC8QJiEwGSI8FeQlh3Ul?=
 =?iso-8859-1?Q?fIWD+KJ54ArzD6rqEvkrFRGovcZD0JCQiLIVY50QEYGQgNJCSbNjfjtg/s?=
 =?iso-8859-1?Q?6TsdmNWgboJDVQ8LBUUYXbgYggqYWed3MtDabqk9uny6yCykbj1VIegdcu?=
 =?iso-8859-1?Q?P27FNgx2qhcKJREha0ct9R+uI4ElG2IDicExD4hyUUJnPcV5gDAzyjl3il?=
 =?iso-8859-1?Q?A4A86N4KY1Kj8ShzlSsQMbPwaFpxu5UnbDVSgc0bjHDacFeHOJGq+wsgKt?=
 =?iso-8859-1?Q?P8NQ94VCq37n2uxRsgIwfGShuAUQQs3fQ9f7AYrvKyFtZY6ku/D6PU1WQ9?=
 =?iso-8859-1?Q?g9mjF9rRQNrdK24ElA8SlVcZbF/Myhnp84TlmnVLav1U0277GVjyB/mDG4?=
 =?iso-8859-1?Q?FBvvdAK9xaDSyOHvhTkfDgZCMnfWFAIlCaa5xy7fC5DrftkncX1X7HbgeF?=
 =?iso-8859-1?Q?79puful/+GYkYBDpAoofScoB015kLPZbeTQrAR/0lX/FozZhr6EcdVKmyZ?=
 =?iso-8859-1?Q?oyMeATg3NBUd08WIMlUfhJRl6ga2qxO+Bk41jMRy0t9YcOv6WegOWJuQkB?=
 =?iso-8859-1?Q?thChtqfMHAap4Jm4rfCU9cHjdQtCBjyDddHiJDN5O1lpIWQFX6Mb218PYN?=
 =?iso-8859-1?Q?KglHSqUy2ETTChQeCnBwl7eTURq6tfXKgyPnnP+iapi9QcGwK2TRDL0ffD?=
 =?iso-8859-1?Q?uAiw1IpxCP0g9hlu3n2ARjJOm7vD5MUNXRuPa1mDmpH5ckIvFUyY0Zuyfq?=
 =?iso-8859-1?Q?x2NqGbGMF8xMFOiIp7HuxxaDyqX/x8VJ18agzl75H6RYB8cYG4TKFicnAd?=
 =?iso-8859-1?Q?KTMvBWO602xyvLsMrJ3dCKzkQbeNW9Ch1RrDZ9eGon4XSlrSFkfqFwPgbK?=
 =?iso-8859-1?Q?R8gw1+46Q5JjgOFwzzH0xKvI6S7EPXXHlcVKkZ94WSVIt79kai1S7ELiKq?=
 =?iso-8859-1?Q?sEouZkeOilbjvCe1rw8AOnlfOv8uYPhnnECUumH83d5SjQ967HR6M461nC?=
 =?iso-8859-1?Q?0ZrGn+zeyPTF2oCeC7dOyLxknr0xTqzPV1jsoWPqACIWnFK0nFDyaVGcUR?=
 =?iso-8859-1?Q?i7rfsVAzVYC6Qn3EysEmqAtnN+dGB6hzZrMMzVecmszKiLqKpLd+GTXrz+?=
 =?iso-8859-1?Q?faFLl/Uj/O65cFBp6t2SjoCoN/GhAeTlfQTKxtW9O+l2OJG7MwxSCwokxk?=
 =?iso-8859-1?Q?2udnlOeOZI4GDeyLtShZXbSk7ZK0r28IihNZYix9T48aF83JdzPuuHJfTA?=
 =?iso-8859-1?Q?74M6jHkWmIf/EB2XYLpipXUGoAD3zOM0gLSVPWB4+YlYTQq4YqNJpF8SIa?=
 =?iso-8859-1?Q?s/8btpyEdxvqXZ9E4NgvtfzlA13HQBIGKWgH+M2XP+QVMxz44D4MAPuxNM?=
 =?iso-8859-1?Q?w9cdmR8N57pkj7yXglliYoCTE+aZfRsMaq0spGFyrS2Fl/lB8rTuTRFQJm?=
 =?iso-8859-1?Q?y7MtB5nHQjaRTtQvWXfQq5QuCYqn2v/VXP7hYM3vz9uc58COTKIao1qyaU?=
 =?iso-8859-1?Q?+w28BAOMfncqyMrQgYA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 389f2b76-7469-4b1d-d866-08dbd6e55caa
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 12:07:59.4924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cHeLPf2waZn9/MD22XqrqbqwlGMNEG86xGYx6pgrBw9UWzOaq0ZEPHpv7tsRbuqh7kGd/p4c9h9LR0EodzunPfVRwreK7u9bscW7zs+436M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6152
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-10-24 at 12:26:27 +0300, Ilpo Järvinen wrote:
>resctrl_tests reads a set of parameters and passes them individually
>for each tests. The way the parameters passed varies between tests.

"the parameters passed" -> "the parameters are passed"?

>
>Add struct input_params to hold are input parameters. It can be easily

"to hold are input parameters" -> "to hold input parameters"?

>passed to every test without varying the call signature.
>
>Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
Kind regards
Maciej Wieczór-Retman
