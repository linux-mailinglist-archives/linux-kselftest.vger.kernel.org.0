Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655897D96DD
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Oct 2023 13:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjJ0Lpz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Oct 2023 07:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjJ0Lpy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Oct 2023 07:45:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F90AC;
        Fri, 27 Oct 2023 04:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698407153; x=1729943153;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=URoAcRB55D/vycQ9zSLul5xS05wreZhgBDWXYZw7v/E=;
  b=KEeAxf791ido4Rn2KrTVbhXgFmPQZBAul7FWjSzR+AqdpKZcyV/vFp8v
   7KLjy8GIyFVPE41KFPSpx5j3YNzi9d9zsmoiavCNYB4wl6qXmdjxi0w98
   wQLTpjQ4NZA1bfILYFNsdFZPntJDfwM82910Bbw7cdt8VPP7vXheiYEjQ
   ZG6eav8ZkYuAp+sqGLl6puHkb4Z9HWWJz2zy5PiLOeRHFyXkrzRfBCijx
   QR8+4nQ8gKao5uZ5uRqQBtS84tbotHy207iCL/tqRYpRQQFtzFFxPz8I6
   MyngvmyF3HkgnRmNTUH+iGfacvbKDxF/mXpn/iU94LvMfCMCGcKurhnk4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="9298996"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="9298996"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 04:45:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="763192104"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="763192104"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2023 04:45:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 04:45:43 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 27 Oct 2023 04:45:43 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 27 Oct 2023 04:45:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZUvZ/dhoIBYOIhP/zyBnnsg75IPwNGhhbndN/5uAsDpDhwW4Cy+AKYFBukXsyFQxBVr2hKVSAiIy8MAq/b/nrCdz/+bCkDbe9+4Sy8+DYebVnd5h69gDmEFll5KY9HzxpJR3WzeczH98Y+HXlKGG3In427RxQzNtryMlLOsMAvodzWU/zT7g1S/Xl4GkjmxcIQYY4qw7F3h8ZGWvD4LA/xNkhoVK3o7JGqVin1tCC5eAOWHEX+0voOHRl+cCDlZAZNpw4MD/HwYugN4QmbVC1n9615iMQkBXtVHS7MGmayzIQjV0H34uROxSkIEFz44CzfaqoFVDvQ9HRjPmqSAiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TF0FaVguIAtdd7ArcJguUVwseyLfo23E/rXNrQf8nMk=;
 b=LPHNCmVnslBHhxIKTMGnC6q81QbZkF79VABiPqcW/9sfkQbTsC+own0wXR+qEMHGihSbrs3oAeV5bDvi4uMoiAwBe4vf1WRG+hEyvg+NB2rLtyKRLTF2Bq94JdHtlJg3PBwbJZR2ijjmTX9WPhawYp/GuTeewEMToHpJFemUkNXyen8v90rnEA/cFKRK8hQCOrBNtFNJZERk+3Q91oa6MM8CgtBeGBVzYjLtVo5jmJXrhELpVzGLL2vzjyWBsQ0HXICgEqKjxkAWhZotsLUCAQOE4l/b0yIRXogCGS0Vo2wqQ5WCsX1EGMPoTjen5/K22wjOF+L16nJtoVJO4kW/EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by IA1PR11MB6348.namprd11.prod.outlook.com (2603:10b6:208:3af::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 11:45:40 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::f4b7:72ae:86f6:450a]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::f4b7:72ae:86f6:450a%4]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 11:45:39 +0000
Date:   Fri, 27 Oct 2023 13:45:35 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
CC:     <linux-kselftest@vger.kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 12/24] selftests/resctrl: Improve perf init
Message-ID: <ubpkdot6ylseamn4obcysvizi6cxzg6t6qkuwj5bq5wv7chpgm@evni57bxyib2>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
 <20231024092634.7122-13-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231024092634.7122-13-ilpo.jarvinen@linux.intel.com>
X-ClientProxiedBy: FR5P281CA0025.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::20) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|IA1PR11MB6348:EE_
X-MS-Office365-Filtering-Correlation-Id: fa2fa9ea-77a5-4a90-b5d9-08dbd6e23e2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QnRcmD0OH55cQpLR1y9boab8zyGOmRmXPuP8Azz6sTl0RLE6gk013EQy6VBnpSzOLq6sXzqOvEiTuiVojoka3O/bw2quUAo1OyzmIRsKF3o8t2YKlEEIgpYl8L9jIWcPmM1higSmcAI4ehSkEl+r2vyeDSYYSIMYn9PF2C02TcTWtMkA7LR7eBoK0of2OL8zHKe0Rp3fFnIP1ZDu/rjJ3cWKIc3Uf0dArFMk0TGqLaotzZf62mBLX5T4CqLaOrBR+vJhJrRdBDmXNp553e8W4mJ6TygLB/ztxDt2ylLpp278mu+u2zjtLARqZmE06kRz3pxPmVW4McmzlRrJdg7gNm2bf8JVoniTS0VepYMh0Q/GBcEQvyj+lN/2ROBAa36K0cljPJsgrgUQuhI7RscCovm1Htd5CimM6eaX9+2i2SO5ElQ27nqmKRUYuSYcvzeOx3oxOkgp/MxWZEZxAgEpPjd1ziU3ZP5tQh8uf/3YVNievPJvJC8yAE8+TwmREaED5LHnvWDxs6ajb/+Aq1gijlonTulO0a3Jfja1H2J2hoJNW1ozHMu7Aj+ItzQw2BNG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(26005)(33716001)(4001150100001)(38100700002)(5660300002)(41300700001)(2906002)(4744005)(86362001)(4326008)(8936002)(8676002)(6506007)(6916009)(478600001)(9686003)(82960400001)(66556008)(54906003)(66946007)(316002)(66476007)(6512007)(6486002)(53546011)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?2UXd6jCNHvVWxEHdqgmcXNo+cp9An7IYxZdMtnEKV46NjYFDGv0eHlki/0?=
 =?iso-8859-1?Q?EpYFRfZPzfzyaWESiadgOOL98eaaMTQ3v5/wk8ztO//+MCLImXbe9LhZcz?=
 =?iso-8859-1?Q?yBfRN8IgRJZBRG0+HvXSnnRdbulFE3CW4HLfUqmu4eLDSq5ufiqTLAOeSs?=
 =?iso-8859-1?Q?g54CNdoalRb0con71jcUm3d8gYphQjHD9PoyDf6ynAx9dtv04QM1bp91c/?=
 =?iso-8859-1?Q?6ikPh+H30BwpMZoeZha3bSw3J2sDa4CLzvzMfYkKOMRtxqYDlakNuvSx4I?=
 =?iso-8859-1?Q?lscg3YMrHUOQsPgX4+PK4b94VThHvliqYKywLAeZHR1Xzr7rQML4UL8gUg?=
 =?iso-8859-1?Q?odmQh2jl26s0Wq3U/szFzsVaitdVeXxzBVkupBu1giZvg6xsttI1/Uhjp4?=
 =?iso-8859-1?Q?sVgZvqAyrNDf4y9vdAiqSoqPMdu7rYUcxcRzbbOxTqJU/fEZUeHdTshllr?=
 =?iso-8859-1?Q?rVD6hMMAK6gRWf4maPdcbfbr85mkLNt1wzbu+wOo1h7I1AxkHBul4/Ta0x?=
 =?iso-8859-1?Q?qY8oFokjQnTwqYRb57fwmQwDv7WHVtoGev27ejIe1mFnAQtbJcN/JM0Yxx?=
 =?iso-8859-1?Q?7Kamo7ZG9OqI7uj/nW7jxUK0KQLRB+oqiuZSEkx/T/b3p0ph20TkwEW4YD?=
 =?iso-8859-1?Q?ZUNOJ6RwixrECUwbeENJkUGFgbckNF4AYgbETLBXJTF2rsUoxDTiHmlEWi?=
 =?iso-8859-1?Q?a2fBt6bxUsqucLVfiw7iFHwZcWPiaX5Z+6j8aXnX1R+LGh32d528vHoAAh?=
 =?iso-8859-1?Q?pjSwGPaihOiUINhBfej9/VMjkGxznw3SGngZ/lv60+i+GfafQM1CiHDLVf?=
 =?iso-8859-1?Q?LKjoM0CBytM7jopJ+yG3P40CeFJGllZrnOwFahgXMaSMnkDnYIq0aCSDFA?=
 =?iso-8859-1?Q?Gzp1sjT20WSAhGcHmT3xSmGLFDQcqPTXz1SLYpCmfEfIwT0VsSsIKehRhn?=
 =?iso-8859-1?Q?hYEeAxQqS2VkdMXtQRxjhzy/dZxG0Curr+n6fIF9EJac6DbuVlWUk3sOQ7?=
 =?iso-8859-1?Q?9lBTQZXxOx3Y7CzNGpSnd1SVUroWwiEQQE0K3hRX8V9oXSvRD0Bi7T4ise?=
 =?iso-8859-1?Q?UmJslF/hiYg6C991zJKZrNcikz+ChiWZIaswDMXnOnrV5Gl+OU6INEVuim?=
 =?iso-8859-1?Q?WEnP/eLfV6B3mFRfNnbDn0m+dM38PdQ5aMyG8l6tmnrG2krv4U/LwFPovq?=
 =?iso-8859-1?Q?QDjWUCheZhcXbnHNN+LRqTFJ6l+MATIyUye9UIDQboluejX6jsRgNFigVJ?=
 =?iso-8859-1?Q?wJ7FgIqLmXJF9iv6qzlkERNo+hunlQ07iWlut9Dw8ug5vQA9YzhYY7SUS8?=
 =?iso-8859-1?Q?inCkYFl/EZ5hI8dQXqKSRAXc2jJOnKWBjycwr5QVoGTbFllTPXWWz5zuyr?=
 =?iso-8859-1?Q?/IqqKvwl4NWD8NPgbV5sD1JWXf+m8jc+KDX2ZduR0LB3sK0nGWfC0jtdue?=
 =?iso-8859-1?Q?P+hAMKS/H0dHgC0cYmqkguu6JJCmhOBHwuYO969QaAM8h7/3Lfy5RY19h/?=
 =?iso-8859-1?Q?moLMyzxyDm7pKWlsbunCdnAvUXQZJ5K0RNElYYt2rnaAZBoQ+vmZRLedim?=
 =?iso-8859-1?Q?ku5g1aJawbmQx/YD/1iREfgCEbrq2qwlFTVfGTpXx/PqAxJhWZULQqEuDQ?=
 =?iso-8859-1?Q?FS8i5fika4e1h+PgfGF5g4x3FfBB+EbWLuibenmaaBWE8QQcXDHkfRkci2?=
 =?iso-8859-1?Q?0mruPwpKacN1dTeJzyY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fa2fa9ea-77a5-4a90-b5d9-08dbd6e23e2b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 11:45:39.8481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /un5Gti4JBNKtxP50kfdfqpR64nJ6RVFM6UtKjgepomb5T8k9v/Tes/s23tX2A2PCxBRJmGzAvRcNesVEz62NDnW6Q6GLentQINZpOviZKk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6348
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-10-24 at 12:26:22 +0300, Ilpo Järvinen wrote:
>struct perf_event_attr initialization is spread into
>perf_event_initialize() and perf_event_attr_initialize() and setting
>->config is hardcoded by the deepest level.
>
>perf_event_attr init belongs to perf_event_attr_initialize() so move it
>entirely there. Rename the other function
>perf_event_initialized_read_format().
>
>Call each init function directly from the test as they will take
>different parameters (especially tue after the perf related global

"tue" -> ""?

>variables are moved to local variables).
>
>Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
Kind regards
Maciej Wieczór-Retman
