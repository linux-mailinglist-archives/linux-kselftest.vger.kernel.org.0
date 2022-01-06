Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64D2C486E08
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jan 2022 00:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245700AbiAFXsp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Jan 2022 18:48:45 -0500
Received: from mga11.intel.com ([192.55.52.93]:33185 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245659AbiAFXsp (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Jan 2022 18:48:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641512925; x=1673048925;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mZ1oO9XnSst6a5Q5+GAvBywla18vpaQpaFVJbaP1jws=;
  b=UvP5Nl8Jf0o57azqGpKrWLQcpqJjh1j5QstrvXqZ+PJ3odWAwgBEkoTa
   Cohk3Gv57xu0q+UQATi+AUEVEYnTG3S8dpz2vbqabBwTRLy1+Jg3qFrY/
   n3ynHbSvpdVf8FYi312eTmc8LLH3o7NvdqwpghcXZi3RC/aoMLqW8Ck3S
   C0AO1bXD/XA5OVroAFiZ/yQ3kqkPBwy2haogLIeIoKM6bkJ5g4ZabJV+i
   IFxBh068C1xS1Hft6SFkuwYbxffvBySaMW9lLedwyt49VU7XKu+xJHw4I
   wacDoHS6sLd8mCncylmyf4BWC+HkfA8W1SpnF3QvmSgpzH8CZxAVbcw7/
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="240315900"
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="240315900"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 15:48:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="763670386"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 06 Jan 2022 15:48:44 -0800
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 6 Jan 2022 15:48:44 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 6 Jan 2022 15:48:44 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 6 Jan 2022 15:48:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXO1jATAmmMCq/LLo84MSVAr26RPKNowxUug2E6JaKbdSNx6xPblGRqyEKNRdDREIqfOs336A0NS+hP1sTbqKzdD9dgU1Z1xT65u6JpWjFxAsXzZIJ+mdb/rzxf3Son2Cx8sYCwZxZ/hLKzIptio//hKWp0NOrUn6JHt8M0JxDvILEZhjoWETm7xkz3ZMi2r45y8iX7ztQyiJ556xqn9CYaGaHmVUbbEwUW+ultY0hCjZJuC72ctynYcXxplg6bOKWJoPKWNmPoIszJA9TZBn74y8Kjb6MFmdHSPQYepehitQ09PduxuUBpJeVaVHGc0eh7sxFoM8G9Oqsb0YDTdfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qODXxIRYTrHlVupF6f+A02Wtp11qg1OiUp4O/573cLk=;
 b=DdgxSsIPzwz5hOb7ZqoPbz+0ScXChadybU6l/isk79uOqJt86euXcB9tBM8qLPpqGdmmDNQ7IFicgy1RyYqMF3be9STWj5ukVHdYusGE79QaKU9NbdDiY2kYB7uCq8J2riW5Q0jlMTlJAWbOyDnZ750ML1OoOrQ5KB/KIyxpQQEdLO8i4JmiawyV8qBSBjjHl1MjnWJvvjk4lkiWrQVNhzyGYkh/vi7adfQO+Cx/aZ2D+VYDHU1V0IHHOllJ1F8ULFWR4NSUvf2tJmJ9D2fy2Z6cKpodpGh3mgiwGkdW6j6gfyq/OEUD6e5R4dbJrQ0BpvTeb85g1gWH3oXxHTPJrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN9PR11MB5548.namprd11.prod.outlook.com (2603:10b6:408:105::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Thu, 6 Jan
 2022 23:48:42 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0%6]) with mapi id 15.20.4867.010; Thu, 6 Jan 2022
 23:48:42 +0000
Message-ID: <dfd74b29-b68e-588a-b8f5-5ca7ff216819@intel.com>
Date:   Thu, 6 Jan 2022 15:48:39 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.0
Subject: Re: [PATCH v2 2/5] selftests/resctrl: Make resctrl_tests run using
 kselftest framework
Content-Language: en-US
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20211213100154.180599-1-tan.shaopeng@jp.fujitsu.com>
 <20211213100154.180599-3-tan.shaopeng@jp.fujitsu.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20211213100154.180599-3-tan.shaopeng@jp.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR1201CA0015.namprd12.prod.outlook.com
 (2603:10b6:301:4a::25) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17d5312e-8ea9-4d91-ffd3-08d9d16f1202
X-MS-TrafficTypeDiagnostic: BN9PR11MB5548:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN9PR11MB5548C1A71DD539645258E766F84C9@BN9PR11MB5548.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:193;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JmUHSco7106oSl3QSz6tUx6P596hMDy4sKz4enL6w/qk6K/G0j/ybROqpeIq2XYcdAXTRERfSnhTKpQCp7SDAZoHpR+Bi16Wt7AdKw/ThGzslsc/tSw7mRKq5JHfc6FLjZyFPXwCissbgDwhynEY79Irjh07DAqGVKXc2lGNe8+JaL/Xflrd+0hsjEpz7NeiXrAdcXp6JAYx8h7QkjCcop8AiBK7wa7yxd2V2frATRGep3mcUS22J+uiti2b3Ypb9JmexVPP/Hn/GJ4HDC1F9/215gzHEmOo3FjFkVCO3koXjOP716P3N0jAjkzRG8ByXVy27MoJz3mrj9L99oKEkS5OMHCRf0WyIPh/Fm5Z4KCGIroeQ9xRvAWv1bXPnnFLdPhwiQtfrmzpj94qLephVfDJP+LJkPDMHnqDo2S7DBM7BbTIS7lWogXn2b0DFfym4QsjeSvL9dP8AF5eyhNOifjWgpJ0NV37gigGfmI9YiXSjJrbP3KkK/a/R+DNVk2xzVTqRXOiwUQwhwh7QmDYFClLe6JkHpJHfVLGO0c63+qREyA66d8tjpqBxfArJp2DaTFoX4VnIPGrpecemzTp0HitAU2w0ai/x3oKXIQym187tW8RBa9JkrsEFhb0vMofTjlvzUsNPdjG0fjc455tBiQFMNPcOpMFAj11wgjZtFAX/C5aXD0imw2PpQc438oHfun/1y0lJ/BWLCgiX2I7AZUcLuQW4YLZJ9WY0Pw/POvRP2vaUTx8qDs0Afuqeui8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6512007)(508600001)(6506007)(66476007)(53546011)(186003)(66556008)(38100700002)(31696002)(31686004)(83380400001)(6486002)(26005)(8676002)(66946007)(2616005)(316002)(44832011)(5660300002)(86362001)(82960400001)(110136005)(4326008)(36756003)(2906002)(8936002)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1RscnBURTBvK2I1Mm1OOW5aTzQreWJOZTlFNHp2VXRGZFhTSHhHeWZuZFpE?=
 =?utf-8?B?WC9BNHhRUmk0SkJHWG11VTdqWDBBMWYvY0tkQVk1UFVubit6S08zOXlOUTg1?=
 =?utf-8?B?TC9Rd0hQK0l6NlpMYmFPVkhibmorQVgra3NnTWZhRCttYWpIWEdnNFd3dDV3?=
 =?utf-8?B?TDdvVENvUWdnamdQckNDbDBkT253VXRBOXRyb0VUTDFTUlBkM2ZQajFHM2Rv?=
 =?utf-8?B?M1VHWGVZUzFBQzByNFhvVDQ1RWFQWTF2a21lN3BVTCtZdG52VnJ6dnRZRXdC?=
 =?utf-8?B?eHZlT2F4SDdjVWdJelhleHJaS2xYblF5UFpLamJuZ25BcExJa2Q1MHNHRFVC?=
 =?utf-8?B?c1ZpYlUrZVE1bkFkTnhPUjR3SCtzNWJ6Z2Zid2g0MFl5NEhmRUdDOXBXVEJu?=
 =?utf-8?B?RkVhWnRsTG5XaFo3K2VxYXBwYmdwVnRKbWlNUDJRL0wrU0xQZ0Jna1QxNjh5?=
 =?utf-8?B?OUczREs4MThjbDMwdTdpSms0QUVCZEtndzZrQi9RTWMwem91eEg5bFBGa1VX?=
 =?utf-8?B?ZHd2bW5XT1A3UkR2NlpRYXBDeGphOVYyVmFwY2ZxSFB3d3V6TFAxdGVwTmx4?=
 =?utf-8?B?TzZlS3A1bkQ2bkVIZ2hqOGRiQnM5TzBsMFpBTktHZkpSVEVjc1J2Z2JlL3Bj?=
 =?utf-8?B?akkyQ2lhM2ZDSm1IbHhpTHNQblFNUmp0dmlJQTBTakMrb0tacFBmRkYweHFn?=
 =?utf-8?B?ek96UitEUXBVcDducS9EeWtIRGRtNGFlcWRySGRZV3ZLWFpRL21IMWVEN1A3?=
 =?utf-8?B?OUtwOHFaRjN0TmIwQkd5bmoybEhkak5DZ1pjcmlXc0RDMG5FYW42dDRrRUVu?=
 =?utf-8?B?d1JZUHdUcFZiUnl4WGh4aGl4ZVVlMXdkaFExN2xxZFBUdVJFKzFKVFMwMGJm?=
 =?utf-8?B?SUdFYXB6eDNPcXVNaEhDVnU0blVXL3hTOGZnRHphY3B4UU1wcTNyM3lPY1ZP?=
 =?utf-8?B?eC9kTFFnVU9wYkY5ZG5mZy9HaGJLSFh2NlFYenk1YkE1TVRka3pXSk55NUx2?=
 =?utf-8?B?SDRuM2txRVZSVkdRNGc3N2pwNUZFSE1SNjJySWxIb2RMMm1yc05SejA1bE9L?=
 =?utf-8?B?dnZVbWVma2duRWRnM3Zkdm8zbWRtUFRaSTN6bFVnZW9yeG5sTkFuKzZWbXFT?=
 =?utf-8?B?WXZRMHdtaDVKd0ZabTBkM1hzR3dJNDcxMnlic3U4YlZyak8vNWFWMjJwV1Uz?=
 =?utf-8?B?K2J3UkZDQ2RHaEJEclZtMkVEcFY1UUs2Tkt0L1NOVzJyeGoxbkNDN3F1RHZD?=
 =?utf-8?B?QU5EYWtPdmNFYWZsZWRKWGJYditrOHMzL1htMEVQTDRYRG9qN0JCb1ZMTkt3?=
 =?utf-8?B?Sm9sU3hFUVltZWh5OGlEazVHMjdxcFM1amptRkFFREIzZ1FuVUd6WnNFUlZ3?=
 =?utf-8?B?c0t2ck44VUEvZzVWSCtsL0xKRm5ESHVDZmhFdEdoUyt2aVF2MTJ5anhtdnVv?=
 =?utf-8?B?UzBmai84RW1TbmZ5UUc0d0lMQUJzUDI1VzI3Ym1SRlZCTDZtNjkzN1pSSUtw?=
 =?utf-8?B?N2ovcHRLZmo1Vk84UGx0MUJIYWI3WksrOU9kNFJCYWJJWE9ibldodWJXL1R2?=
 =?utf-8?B?cys2ZnYwTWltRllnV1p1R2p3NFA3WmFzUkJFRUpiRlpVTnJ5VlVkUEZUbkNh?=
 =?utf-8?B?UlRPbDZSNFJBTlBNOFlnRnE4MHBPZGN1QVlnUEkza0NKSllzN1paa2p4SEts?=
 =?utf-8?B?bmxObFUyZmJGN0k4MVhQZFIvNWhsRnBJMGx5NUdzMnJEbjN1US9RWnNaMHUv?=
 =?utf-8?B?UDk0SjNTaGZ4MitDSTExZzNncXhRK01zUkd6V01SODdEMEZpSlFTZ1FqZFFp?=
 =?utf-8?B?VXkwYnFYUnFYbEpwZ0U1K01qeENOUE9vZXZxcTA4cm9ZbVA1K3U2eVYwN09r?=
 =?utf-8?B?VmtoL01QSlRZbXFWWS9lc0o3S2drTzlBOVh5UmZpNE1RcFY1a0V6OStoY3ZK?=
 =?utf-8?B?SDhVUEJzR2hSWGVacTdtSk5YTTJXczFBdEZmdCt5ZDBwKzR2VlplMFlqZUtF?=
 =?utf-8?B?RE5peDRiR3pLdlR0eElOQnRyOG1QT25kb2p4WHpScmhNa3RpMWhvL3dCTFVH?=
 =?utf-8?B?dUVjM0g1WXdHTlVRRk9VYVhjN1NJUmhzeVpZM3htaXhFN2FBY1o4UlhuU2Za?=
 =?utf-8?B?OTJscHREcDlsK213ZEdLWTBHenJVNG5HamdDN3FSNWNlSUt1ZXFMOFJZS29G?=
 =?utf-8?B?MGJUT2daRlozTExrMWRjVXY4K3BqTVJsb1g1VlpMSjhFVmNubGhIVEhiazho?=
 =?utf-8?Q?yb+wGsgKIc85iuqWVgdMS3w0J940mLKW8U3H3O3KvE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d5312e-8ea9-4d91-ffd3-08d9d16f1202
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 23:48:42.6209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1sYxEDCCswjRXf92ks1K/BB50XRhpHY2Wv9V6kk9iIaOGisBSp4qDncK8+ICKzjizBzqoSAAGOz6fA3Uph01plrlHVYDWKKacMIQKNTNRKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5548
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shaopeng Tan,

On 12/13/2021 2:01 AM, Shaopeng Tan wrote:
> This commit enables resctrl_tests to be built/run in kselftest framework.

(This commit)

> Build/run resctrl_tests by building/running all tests of kselftest, or by using
> the "TARGETS" variable on the make command line to specify resctrl_tests.

Please review the feedback I provided to your first version. I do not
see the changelog improvements that describe how a user may use the
kselftest framework to run the resctrl tests nor the requested information
on how existing workflows are impacted. Going back through my previous review
feedback to ensure that all is addressed is very time consuming and causes
considerable delay when needing to review newer versions. 

tools/testing/selftests/resctrl/README should be updated also

> This commit modified the Makefile of kernel kselftest set and
> the Makefile of resctrl_tests.

This is clear from the diffstat. You could elaborate why the changes were
needed instead and do so without the "This commit" usage.

> 
> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
>  tools/testing/selftests/Makefile         |  1 +
>  tools/testing/selftests/resctrl/Makefile | 20 ++++++--------------
>  2 files changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index c852eb40c4f7..7df397c6893c 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -51,6 +51,7 @@ TARGETS += proc
>  TARGETS += pstore
>  TARGETS += ptrace
>  TARGETS += openat2
> +TARGETS += resctrl
>  TARGETS += rlimits
>  TARGETS += rseq
>  TARGETS += rtc
> diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
> index 6bcee2ec91a9..c9e8540fc594 100644
> --- a/tools/testing/selftests/resctrl/Makefile
> +++ b/tools/testing/selftests/resctrl/Makefile
> @@ -1,17 +1,9 @@
> -CC = $(CROSS_COMPILE)gcc
> -CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2
> -SRCS=$(wildcard *.c)
> -OBJS=$(SRCS:.c=.o)
> +CFLAGS += -g -Wall -O2 -D_FORTIFY_SOURCE=2
>  
> -all: resctrl_tests
> +TEST_GEN_PROGS := resctrl_tests
> +EXTRA_SOURCES := $(wildcard *.c)

Why is the meaning of "EXTRA_SOURCES" (i.e. what is "extra"?) and
why is "SRCS" no longer sufficient?

>  
> -$(OBJS): $(SRCS)
> -	$(CC) $(CFLAGS) -c $(SRCS)
> +all: $(TEST_GEN_PROGS)
>  
> -resctrl_tests: $(OBJS)
> -	$(CC) $(CFLAGS) -o $@ $^
> -
> -.PHONY: clean
> -
> -clean:
> -	$(RM) $(OBJS) resctrl_tests
> +$(TEST_GEN_PROGS): $(EXTRA_SOURCES)
> +include ../lib.mk

Reinette
