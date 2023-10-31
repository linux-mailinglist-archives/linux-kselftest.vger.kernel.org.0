Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B506A7DC72F
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Oct 2023 08:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343606AbjJaHYQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Oct 2023 03:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343598AbjJaHYP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Oct 2023 03:24:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DA78F;
        Tue, 31 Oct 2023 00:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698737052; x=1730273052;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=NA4Z+HXyxVnSMiUeJ0z1kK2c8T0Wx5IYIBWB2a8Q0RM=;
  b=lolZT6q2PoG83E/B9FwSmMsmNf/lImT636iKdvMbLUHKyCpn7P/SdFcR
   uFTYD/PSlLErcnM/vbQ5OfPcLiNOA4QZkpBgk3567w5VLVb+3qEjxfgfo
   5Se8h5YVBpQA/CRxNIduzoMhitsAKBqENGvCb8Fx2KYzjzcc/XvDDwIc9
   ds6PPlxxL/V/lPWW2263UVSaw0enapm4Hnqfz0doZCnNTCsc7dvlqyZQp
   oh596GAccHWP8bcRIYGA/tXeEDtbBWvaOKF6ZFxbKgKUQJrrs9zFvS3Bf
   LzgQES91MizwtSbF9U8R0J1dYmKqZumhMZfIDbEPTDM/eTbAmqSAPuyMo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="387112497"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="387112497"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 00:24:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="764154367"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="764154367"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Oct 2023 00:24:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 31 Oct 2023 00:24:12 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 31 Oct 2023 00:24:12 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 31 Oct 2023 00:24:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ChyJtqXLRSEn2jtfIl/PczgwBvon0xhSyo/KYRb3J74av+bIYaRAR20xRZEXp/wynnaSjl6XCMppiaHGMor35CjhtE1vjlJWCBOgFondChiG7eqCheg8aF/yeE9FEkqoGupCqfs5ViazGUSehkvQ+p+xmu7ZXtX9RT/3AEKu3++3sZVcGgLCq4vIcZYMQ2LQyfUvxNW7qVPyxA1igJmvm6j1P2fqVerNSv3mhLIlD098MjIwsSIs94+QG9hDfj2oKQs5cUvr//mDBwZMaCdKUvbeJ4bAKdh7Ooa8YZQ/qrBShmKMIREDetf7SJobheyU+KJryGGU2qMZctubW3lSLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FLOCo3AaBBvpgAuku8reYzQGtBPiDUNPHjqwoi0PF+M=;
 b=Tfbv3xjmQfvff4qG5SLOClcKNmMoDeQq6h2lZ1NpY6fHxXNzspTN2fD9h3IRXo9B/MnXW6ajI+pzWdc593PkLCTmDs9Ks5a8mPK7Ab2vUUIMU0S53zzWJD4GhhFtjmZUCY0cKFo+FeW/WQbhMslGvUi6JG/0sArKbN9S4q10uJZUrzE2h47VVrklHF/JU8k7PnL6vi5LNd9Fa/l3A5jL34hIpVH+KP4K1PcwTelcVZKJb0QvfMEIzfwIvs7xIkp2o/dBltSw7+dRn1881aNIowm92X6Mh196u0495vaSTIxDufcFnHSRhdnG5LhDHLbFIG71FXJwFMCAgf250AbRPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by CH3PR11MB8343.namprd11.prod.outlook.com (2603:10b6:610:180::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Tue, 31 Oct
 2023 07:24:08 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::f4b7:72ae:86f6:450a]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::f4b7:72ae:86f6:450a%4]) with mapi id 15.20.6954.019; Tue, 31 Oct 2023
 07:24:08 +0000
Date:   Tue, 31 Oct 2023 08:24:04 +0100
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
CC:     <linux-kselftest@vger.kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 16/24] selftests/resctrl: Rewrite Cache Allocation
 Technology (CAT) test
Message-ID: <o4tsktjvcey7wjb6pkrp7fp7v3m2sgqqhsuzgsdyigypr2tlxa@me4fl5mjrhig>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
 <20231024092634.7122-17-ilpo.jarvinen@linux.intel.com>
 <kq6qds2hgcg3vlgokgyr4lukm7weuj3thvl7p2panfmk72ovpy@nshm6iva5wfr>
 <fb5e1a50-ba7-1ee8-8bf2-bb8b64b27b1@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb5e1a50-ba7-1ee8-8bf2-bb8b64b27b1@linux.intel.com>
X-ClientProxiedBy: FR4P281CA0281.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::14) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|CH3PR11MB8343:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f0c2cc8-2fe5-46b0-fe18-08dbd9e25f05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X/b9BTDwRnfQB8qI1zxwYv62av9HoGqqQGN2D5F2dYJ09HmBxjGxHproQd/mWzu+ZiPNFLWS0GlS3glHIqvrX6yzru7PZMS/ozEKbDuMMsVuiPga4eM6+tOFMMZKPZm31gVav42kO5n/edg1xV5yxMLS/hz8jAPwjaVQ1HOJ6JCct5qy9/7tvnq99p1iEAsaDuSJA/bpVB0Wg1eaoFwFw0Amm+qF5Irt5oNICu0LoEGz+MvANaHK+L3zAr2SdEHLzFoAF9x9H1cO1pHv+8AYXcOkwODvyMDog7I4TlEMRN1JFCoZSAtr50tydIxF7ET8gUMYe4S160fzFPExC7bChI+pXXH9egEVVDPByP1vNDndb2E8f2Foub6sRtDqliV8OJwnpGXWVYyyzdoRh+N/L9VJePG1L55Fekb+B0aWfF7yFVr/UjpNmCaYVlXGVkFONtFJYis/9StfBy5U8YaPRgCeCl+bxCtWdDFz46j2pdZf2nssQkaUjkage9YFhY6Tcr8PlKfEubnilkl+oT1x/BS+QCg8ppqzXKkJsrB9iDFt0Bwar3oFrmZf+4Dochbs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(39860400002)(396003)(346002)(376002)(366004)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(9686003)(83380400001)(26005)(5660300002)(66574015)(38100700002)(316002)(66946007)(54906003)(66556008)(66476007)(6916009)(4326008)(8936002)(8676002)(6666004)(53546011)(6506007)(6512007)(2906002)(6486002)(41300700001)(4001150100001)(478600001)(33716001)(86362001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?W7ZYVhy7EV67P9EplVjtauzm+jWR5KDNIHVqV1q/wWwAa90QjjkfpTlnMF?=
 =?iso-8859-1?Q?VQSqfAD6CFs5e3Ki9mUsaQyJHyB5M7v4pSh4IwTADSV+fjFqx/yRuK2ZU6?=
 =?iso-8859-1?Q?NjAn3f5V/fnIslcK+6YinAdjh0tlYmORmt25GXX7R3OuZIeLvv39NduE6P?=
 =?iso-8859-1?Q?fuvkeynDsoSNrZyyBELMt0KDblUOJdcWR2+ahfbkxtlkqNxIONnb95hIWb?=
 =?iso-8859-1?Q?Mei9o5KXXR1Y8yRnzbSzYzWsIh9CQLO0k526fqQw/8TsVvFf4lVbxVU2Sg?=
 =?iso-8859-1?Q?lVVnvAkR0whTrmr7ApKohfHnmIR7BfNrgntJDORDihuhDQDKG/iblCWmZm?=
 =?iso-8859-1?Q?IAOiBmqqZmCSHmTjVz30KHEx+8IDG0tDR7wmhFcphHA10h5X1ZBiigN8p9?=
 =?iso-8859-1?Q?5WGdR+kfQKFzemgJU0Cent32189Gcb+J3Jdod/HuyUnPJeEKqD5IdP+jXT?=
 =?iso-8859-1?Q?rvXcFcNuW8v2wdB3CwNh/EFhFi3MmmVXVjPQd35XPQDMwcAN+nfzIZ1oYu?=
 =?iso-8859-1?Q?RS9Aed5C1SCdAOOCAXL0kskJ9SwFRoNLQkxPZNDt9l4mKYZwH9P3ECNWQ9?=
 =?iso-8859-1?Q?/KQyXZJkUGxuzChCmO2EWc6lAvpa+XYkT37SsR53CbY0TCJiodau3jnIKx?=
 =?iso-8859-1?Q?/TdvKtTTydBkH0tR7HdKwGMIade5vEj9bKXqCKNOAn8fnm3iBjTdzAXWpb?=
 =?iso-8859-1?Q?3JYz3gKR/oq+ClI6Q8RbberRJL0HpYp07EhnEVqdmeFvbxzNUseXodAGUS?=
 =?iso-8859-1?Q?Jaf0UQ/uBRhi//p7AuSTpjac8OaZ4k/PeMzhFNdxN1T7vx6H25DJcGmaDr?=
 =?iso-8859-1?Q?P8+UStCJBWTdOA25uAry5ILO59au2PCOhs+D7zj1Y3jsmjRwAwvqfTn3p8?=
 =?iso-8859-1?Q?ewPSMlNxNkRU95XszGbfZ7LROyXltM0j09gVL01Ik7c8pnVDqn61C6h6gi?=
 =?iso-8859-1?Q?hMax7Us8pwohTYQRmccxXAxBjWPfXsiqq1/Mm+yBG0pgkz45NBS+HcfN9e?=
 =?iso-8859-1?Q?xY90FMVlnx1p0cGWxGikMVvuy1eB0RkYGOu4YIg/NxAoMVSQi0ten0hbMj?=
 =?iso-8859-1?Q?GSt86GNZkXpfb2JDoGcb2oqEWdxzF4y01OhM+xC6wWMy4FOObRjO1TIOlF?=
 =?iso-8859-1?Q?W5IGC3kzM7/le1u4ZkJUPLaQAjFQrZ5SU9Nk3NPRKy0ZrnsgGAYt8o0//1?=
 =?iso-8859-1?Q?mHVkoYAfXa7A1RjezVIo8llg+SwrjS8wAcg+bxU1dT1JbxM+T1TGXTG0zH?=
 =?iso-8859-1?Q?G0T7G5zgyEuQmbgNohTXVPnTCBiqIaeHqQnH0d2hwRe2uT8Fkavc1um9QX?=
 =?iso-8859-1?Q?m3tDHO5Ql62nq7uoKOvvQEVhQ01PhE73z3BF/sU3v27+I4rVYc79aVyTy8?=
 =?iso-8859-1?Q?N8YwVYCkfXode+AGJF1M8/S3eEdtgn4epovVZ+NOjKiPeEoqPWkYORp42Y?=
 =?iso-8859-1?Q?xiwQ+g4Zn5UfUs65OUhAgHEvMLwnrZGhFPX7qflr8aAHKp3dh8McpJBEfj?=
 =?iso-8859-1?Q?IdoxfVM6enCtnmTFWYfWZJXf24spkhpsWFu84Y4O1ZmyfINviuG3jQCOQa?=
 =?iso-8859-1?Q?3UjtzBH4OB7xxOMP/6tlZMjLF4kYfQNaPSxOH71Tpg4Vxr7uq4dyq/asYp?=
 =?iso-8859-1?Q?kYnhG15w3Nw89t+cFQH4BOkY2fW1zknfqLSEuIq12wvyans4C+rujalTKm?=
 =?iso-8859-1?Q?Q/QMiTpJaAn+BYVDpvY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f0c2cc8-2fe5-46b0-fe18-08dbd9e25f05
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 07:24:08.4932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SMCGmFVriiMaTzYC3rZPUBNTaZ/YWVh1KQAB187YhmlSKiJT0JH/flYz8p/ahN/zsEmr8lsvF2ad12FQCyIhP1nQy/d3s3O6lqpDsROrYDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8343
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-10-27 at 15:32:58 +0300, Ilpo Järvinen wrote:
>On Fri, 27 Oct 2023, Maciej Wieczór-Retman wrote:
>> On 2023-10-24 at 12:26:26 +0300, Ilpo Järvinen wrote:
>> >-	ksft_print_msg("%s Check cache miss rate within %lu%%\n",
>> >-		       ret ? "Fail:" : "Pass:", max_diff_percent);
>> >+		ksft_print_msg("%s Check cache miss rate changed more than %.1f%%\n",
>> >+			       ret ? "Fail:" : "Pass:", (float)min_diff_percent);
>> 
>> Shouldn't "Fail" and "Pass" be flipped in the ternary operator? Or the condition
>> sign above "<" should be ">"?
>
>I must not touch ret ? "Fail:" : "Pass:" logic, it's the correct way 
>around. If I'd touch it, it'd break what the calling code assumes about 
>the return value.
>
>(More explanation below).
>
>> Now it looks like if (avg_diff * 100) is smaller than the min_diff_percent the
>> test is supposed to fail but the text suggests it's the other way around.
>>
>> I also ran this selftest and that's the output:
>> 
>> # Pass: Check cache miss rate changed more than 3.0%
>> # Percent diff=45.8
>> # Number of bits: 4
>> # Average LLC val: 322489
>> # Cache span (lines): 294912
>> # Pass: Check cache miss rate changed more than 2.0%
>> # Percent diff=38.0
>> # Number of bits: 3
>> # Average LLC val: 445005
>> # Cache span (lines): 221184
>> # Pass: Check cache miss rate changed more than 1.0%
>> # Percent diff=27.2
>> # Number of bits: 2
>> # Average LLC val: 566145
>> # Cache span (lines): 147456
>> # Pass: Check cache miss rate changed more than 0.0%
>> # Percent diff=18.3
>> # Number of bits: 1
>> # Average LLC val: 669657
>> # Cache span (lines): 73728
>> ok 1 CAT: test
>> 
>> The diff percentages are much larger than the thresholds they're supposed to
>> be within and the test is passed.
>
>No, the whole test logic is changed dramatically by this patch and 
>failure logic is reverse now because of it. Note how I also altered these 
>things:
>
>- MAX_DIFF_PERCENT -> MIN_DIFF_PERCENT_PER_BIT
>- max_diff_percent -> min_diff_percent
>- "cache miss rate within" -> "cache miss rate changed more than"
>
>The new CAT test measures the # of cache misses (or in case of L2 CAT 
>test, LLC accesses which is used as a proxy for L2 misses). Then it takes 
>one bit away from the allocation mask and repeats the measurement.
>
>If the # of LLC misses changes more than min_diff_precent when the 
>number of bits in the allocation was changed, it is a strong indicator CAT 
>is working like it should. Based on your numbers above, I'm extremely 
>confident CAT works as expected!
>
>I know for a fact that when the selftest is bound to a wrong resource id 
>(which actually occurs on broadwell's with CoD enabled without one of the 
>later patches in this series), this test is guaranteed to fail 100%, 
>there's no noticeable difference measured in LLC misses in that case.

Thanks for explaining. Looking at it again the patch makes sense and seems very
coherent.

-- 
Kind regards
Maciej Wieczór-Retman
