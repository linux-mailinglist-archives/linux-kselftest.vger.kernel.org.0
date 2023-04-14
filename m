Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5926E1C9B
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Apr 2023 08:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjDNG14 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Apr 2023 02:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjDNG1z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Apr 2023 02:27:55 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892B96EBD;
        Thu, 13 Apr 2023 23:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681453651; x=1712989651;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+yritlCRkBVeILdyakQW2+iCr8HVtIe5YIhezY80uT4=;
  b=P3XhILBaYqvOTcXCjqmPV53Qbg3NvRJVrUYF+4l4MXV+kIl5I4RwOvoy
   1Kq/XzafgSG1nkoQtKwp6y+11ansZpxDrIPCDmRM+x8kGnVMD9q86XGOq
   aPR7x20f8u9C2by9vaH/ah3770j46iF3XfBPt36EVOZmqwSiC/Bk/r7V0
   VIfTVqqVd9rZovPXbBgQSpsfxuOuQiBb3H0RlfCh6uIGQYsRoBL4vFoPN
   6rf8t3pu0v7322n3R67ym4mIZNgMpUJVFmMisHHEl+bfIUOGZW6+Y97og
   Va7rY0p4nueVctZszRClKyGG+iPI+eefZPiW6ym+K34m50VKAOfM531qx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="343154689"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="343154689"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 23:26:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="689675823"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="689675823"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 13 Apr 2023 23:26:49 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 13 Apr 2023 23:26:49 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 13 Apr 2023 23:26:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 13 Apr 2023 23:26:48 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 13 Apr 2023 23:26:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VCVJ8IeO7Aq1N9PtOovpkS/7SNI5tl/QIJpu6hCJv9yVbfV7NDV06fz4L4Ny2QzplZzuNGzdRD3fm0I0jkIMgYdilhhqfTb/aeiSrs/eq3fZBt0N4DqfXzZio69P9QHGFkyRnpWc6aGvkvkQqf1Fz2gEEejT36E+hlDBA4n7VlLufbnyEogNIfaww5Gfkx9VVa8UCcx5khZNcYK1MU5EZpQ7LHChOZFZCz9HLkUuhWO1nObi++XB5z0EbUUJEktRunBbBV0vFesNWp1YdLzZMdHk7Yels/IsjwwD8NqxlnZXsJjOedNiG9M5do64mSKxYQA4P+EG2fUonpuq9q4Erw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82/UvoSyVWHtVNXXJoNoW3I58uG+OcPXeR8ieSeDook=;
 b=Djd68WIMzLbKnI97rvOdRz2HWr5aI8Ok8IZIHfYhriTFQtXOCxVoZSXJOFkXVbJAm3uSIMCxHI7s3J2lXEuzCyFmGXSRiEb2tgMxIXMZLP6U9KrCsRriEoSljqvsl8WPH5o4DYhgHrKemxpDgyQ2DWW8/CyRmwbuxbzERD780amcyt4Sk6M7c1gEPxhmqUaVCobc8S0hMNatEfvKWj7PPYmuJoVxyWY7pz+GB6KljDHbdr3Ih8tnv+UV1SHIdxOX85rHdlpScAQetbom/iOw1xPqu/0U+hIuG7Jywt9VK/QDUGKQ+nzudEPb0o9BZedL/gYeXH2WAwHxErlJ3W7VMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by IA1PR11MB8245.namprd11.prod.outlook.com (2603:10b6:208:448::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 06:26:44 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::5ac7:aae0:92aa:74f0]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::5ac7:aae0:92aa:74f0%8]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 06:26:44 +0000
Date:   Fri, 14 Apr 2023 14:23:33 +0800
From:   Yujie Liu <yujie.liu@intel.com>
To:     <jeffxu@chromium.org>
CC:     <skhan@linuxfoundation.org>, <keescook@chromium.org>,
        <akpm@linux-foundation.org>, <dmitry.torokhov@gmail.com>,
        <dverkamp@chromium.org>, <hughd@google.com>, <jeffxu@google.com>,
        <jorgelo@chromium.org>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-mm@kvack.org>,
        <jannh@google.com>, <linux-hardening@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] selftests/memfd: fix test_sysctl
Message-ID: <ZDjxZQRyhcF9V442@yujie-X299>
References: <20230414022801.2545257-1-jeffxu@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230414022801.2545257-1-jeffxu@google.com>
X-ClientProxiedBy: SG2PR04CA0215.apcprd04.prod.outlook.com
 (2603:1096:4:187::14) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|IA1PR11MB8245:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cc8f6e0-7d74-4bd9-7046-08db3cb13735
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gim2dGXGgeXKXCwNePbQWlt7CxBtt3qZxG1tNLyIbFjfSgs1E6cZPjAMDH2k9h+mpk9qtUcis0G2MO8lgqWiMirHx8bqPsg/EXqq7alo+Bj33XT90a2z+e4j+j0gqo6xRirIv0pYUqTAJHjE/Y4KiUb1BkzQdGlErZ4HsQXWe2ssMLyWM94R8YXIlp7hpM2yqSlUFbKEyA1NtuxexTZukiURZuqhdIh8Of51YuUDk5PsugE71H9h6z/Vw0XIlmkUYWrXnbtNCBKIEuV/PwXScSCUsCn/5qlW1O5Kk/3EjUgGQfMqaZe5m/3sprHzh89lNm7O1Tvax1XavMEhUF3J7lyMy0T9kTW/WOMUhzTQiF2h6WVNFrfH/yCzQteiDraST7E0CHqRdhBtL+616eIAzjjXlidktd5FLwL9qrv9lj6GiGto2XuexAJKKnNs3c7miMbkRhxdjBgiYEaZYpJBxYndh7irDV686oxEkusrWGhkjw/QRY0wZ/hiDlPVYfp3C65E1R8YhapmOiOrbUspZCV548KW2UyF4MyfA1MS4Ds=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199021)(9686003)(26005)(6512007)(6506007)(186003)(83380400001)(966005)(6486002)(6666004)(5660300002)(41300700001)(82960400001)(316002)(8676002)(8936002)(86362001)(38100700002)(478600001)(4326008)(66946007)(66476007)(66556008)(6916009)(2906002)(33716001)(44832011)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/XrciSpIqaqMCm/5HVZcma+w/fYdpXfJkV+cFFBX4hjFAjiufZ7ec/EnqkXK?=
 =?us-ascii?Q?+N8LsF0PR5AoeAUizSs5nOPsK78FHgexw63gHwjVtOPw0Yz9VNz5x+TOl/y9?=
 =?us-ascii?Q?7sFENVRh+mfmMB6TVX4qkG85irZ+tScfN1d8mnM6oGp5YKUBMg3Fvq9s6qv7?=
 =?us-ascii?Q?BF0KS99hEso6OuMr9V23GfFdMCj2JzlPkLADlkghncyQ1vsEEZ6ReiZ9IRLK?=
 =?us-ascii?Q?tWFW15YxeGZ0epIfl9A43uC1pfAJpvyrQeigNLA3JWBlXroFvioYQrdvlOTR?=
 =?us-ascii?Q?2HawvFcVua2LGXoRBaeuMGFOr+/MWcfK6NylDbk8FqlCySL5wRlFLGphXPbu?=
 =?us-ascii?Q?5ysCmQb4JRiGJrxJaE+8hEu9zAmXgo3f8775VJx4EThQTJBjr5vSoXkDXR/2?=
 =?us-ascii?Q?qVfmMneelZm36GJUi0vBtAj/fl5jpYtGZBkPokhaaJzIBH9/VbHCmbHd3oFj?=
 =?us-ascii?Q?OU248TUx4woahzfSu8wPqWF0k+MsyuZOUIgXOlUxfNTpZvN7naIwJY72Ypaq?=
 =?us-ascii?Q?L8Gvoc6ldlm4ItXhJccYBgIAqm+7031Jl9JhkBkj6pkXOoWOwFE+vuuVwKx8?=
 =?us-ascii?Q?MZ0DNB4Milui2gPQzF3eY9OGemuAb8P8tgz8nwCUr6DTNo0a101Nm6r4wPYX?=
 =?us-ascii?Q?K0bgHPCu7oNpK6E3S87SebTpECFYRO2+8fkQQNWybF8iO4T55Gw6Z33n7NmA?=
 =?us-ascii?Q?2kFMhTdqb8QBGKmRbtwbvOhu4+aHZOOe3iTm+zZ/Gv5L/kr3lBcvs5LspaCI?=
 =?us-ascii?Q?fELN6mA6MlC36wECGPhbbUCOaUX6tTABJTnW+Z73PxFCjfGjaviqtIEDbgZn?=
 =?us-ascii?Q?czLuOMf4CyhOOB5cB2sV26qjkHnbvNrDlYMu/UY8Oo9Z6I7J0U6m/tExNjoz?=
 =?us-ascii?Q?ZpaSPM+cuKCpp8PFs/ky3M93+9IyHs30MWqm2KMhgAkjq9hIXxC013/+SClj?=
 =?us-ascii?Q?rfkhlmB51G9/taVrC+bV9fpozJwdy4wuEa/93n4OK2hFQP2gXjohyi5ul7kj?=
 =?us-ascii?Q?qbE/rBNhwO4DoT3Xgq4lgKKpUXk1OGuGI13nO6xLL3bG9GM5uNZG7QB6ruUr?=
 =?us-ascii?Q?oIvXqTRdVLjUI9WREv3CI0YPgbgGJnHYeU2BKCYOOsOVi8VY/B3L9srb0ajB?=
 =?us-ascii?Q?TY78S1kRoRIrY82JduvzmAqU15fg85d3TImJKViKOHKdlrsC1BvXSy5BN0RP?=
 =?us-ascii?Q?T5RVPqlgBZ/fZQ6Vm2KGUozZXQU9bzdU32vpl4eoGdpgvTwQSwERHLtQmj9S?=
 =?us-ascii?Q?aN+OVOo9qA0XzXLegbglIBjB+FIL8K/3SFHRBJkPgCsJexVh2jvH48QkS9Ul?=
 =?us-ascii?Q?iYyOxm750vZi/X5+aFkCzhlgqHkZKVXgMDjb3v08L/6rq618HnYYrQQUsXtj?=
 =?us-ascii?Q?ZgeLIOIgknx/2mE/gI26Q6/z9d7HV4Tn9lwfHxaOcBZCGrgQN9OsDlq3pogM?=
 =?us-ascii?Q?BQAU2am4Mc88BhJN+pM8B1PlHnGyba53mgYB+cPB3cK+JHlaKUGk7AQ/7fyY?=
 =?us-ascii?Q?lTs6aLyAWfaExD1kDlfJ7ZXlAy2tyRGI6hORLzH6BFvOLc0zhrwrQWmAc4IQ?=
 =?us-ascii?Q?IhVrzFXFi/rF7r2iyc9SMmcJXmeoar8UyMFDE43T?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc8f6e0-7d74-4bd9-7046-08db3cb13735
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 06:26:44.0015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b+I5ZRZW6wBORU/MnfKhwtifEjzpZ3nYS4w155JZT6Tk6kzPUoEj652IqY2t0W2g+gBDMhLPN1awJ4hEksMXPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8245
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Apr 14, 2023 at 02:28:01AM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@google.com>
> 
> sysctl memfd_noexec is pid-namespaced, non-reservable,
> and inherent to the child process.
> Moving the inherence test from init ns to child ns, so
> init ns can keep the default value.
> 
> Signed-off-by: Jeff Xu <jeffxu@google.com>
> Reported-by: kernel test robot <yujie.liu@intel.com>
> Link: https://lore.kernel.org/oe-lkp/202303312259.441e35db-yujie.liu@intel.com

The reported issue is gone after applying this patch. Thanks.

Tested-by: Yujie Liu <yujie.liu@intel.com>

=========================================================================================
compiler/group/kconfig/rootfs/tbox_group/testcase:
  gcc-11/group-02/x86_64-rhel-8.3-kselftests/debian-12-x86_64-20220629.cgz/lkp-skl-d06/kernel-selftests

commit:
  c4f75bc8bd6b3 ("mm/memfd: add write seals when apply SEAL_EXEC to executable memfd")
  11f75a01448f1 ("selftests/memfd: add tests for MFD_NOEXEC_SEAL MFD_EXEC")
  395874d592d77 ("selftests/memfd: fix test_sysctl")

c4f75bc8bd6b3d62 11f75a01448f1b7a739e75dbd8f 395874d592d775d999d18ef9cae
---------------- --------------------------- ---------------------------
       fail:runs  %reproduction    fail:runs  %reproduction    fail:runs
           |             |             |             |             |
           :6          233%          14:20           0%            :5     kernel-selftests.memfd.run_fuse_test.sh.fail

> ---
>  tools/testing/selftests/memfd/memfd_test.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
> index ae71f15f790d..dba0e8ba002f 100644
> --- a/tools/testing/selftests/memfd/memfd_test.c
> +++ b/tools/testing/selftests/memfd/memfd_test.c
> @@ -43,6 +43,9 @@
>   */
>  static size_t mfd_def_size = MFD_DEF_SIZE;
>  static const char *memfd_str = MEMFD_STR;
> +static pid_t spawn_newpid_thread(unsigned int flags, int (*fn)(void *));
> +static int newpid_thread_fn2(void *arg);
> +static void join_newpid_thread(pid_t pid);
>  
>  static ssize_t fd2name(int fd, char *buf, size_t bufsize)
>  {
> @@ -1111,6 +1114,7 @@ static void test_noexec_seal(void)
>  static void test_sysctl_child(void)
>  {
>  	int fd;
> +	int pid;
>  
>  	printf("%s sysctl 0\n", memfd_str);
>  	sysctl_assert_write("0");
> @@ -1129,6 +1133,10 @@ static void test_sysctl_child(void)
>  			    mfd_def_size,
>  			    MFD_CLOEXEC | MFD_ALLOW_SEALING);
>  
> +	printf("%s child ns\n", memfd_str);
> +	pid = spawn_newpid_thread(CLONE_NEWPID, newpid_thread_fn2);
> +	join_newpid_thread(pid);
> +
>  	mfd_assert_mode(fd, 0666);
>  	mfd_assert_has_seals(fd, F_SEAL_EXEC);
>  	mfd_fail_chmod(fd, 0777);
> @@ -1206,12 +1214,6 @@ static void test_sysctl(void)
>  	int pid = spawn_newpid_thread(CLONE_NEWPID, newpid_thread_fn);
>  
>  	join_newpid_thread(pid);
> -
> -	printf("%s child ns\n", memfd_str);
> -	sysctl_assert_write("1");
> -
> -	pid = spawn_newpid_thread(CLONE_NEWPID, newpid_thread_fn2);
> -	join_newpid_thread(pid);
>  }
>  
>  /*
> -- 
> 2.40.0.577.gac1e443424-goog
> 
