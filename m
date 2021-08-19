Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 781883F1017
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Aug 2021 03:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235558AbhHSBut convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Aug 2021 21:50:49 -0400
Received: from mga05.intel.com ([192.55.52.43]:23880 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235567AbhHSBuq (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Aug 2021 21:50:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10080"; a="302052299"
X-IronPort-AV: E=Sophos;i="5.84,333,1620716400"; 
   d="scan'208";a="302052299"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2021 18:50:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,333,1620716400"; 
   d="scan'208";a="489106654"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga008.fm.intel.com with ESMTP; 18 Aug 2021 18:50:09 -0700
Received: from shsmsx601.ccr.corp.intel.com (10.109.6.141) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 18 Aug 2021 18:50:08 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX601.ccr.corp.intel.com (10.109.6.141) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Thu, 19 Aug 2021 09:50:06 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.2242.010;
 Thu, 19 Aug 2021 09:50:06 +0800
From:   "Ma, XinjianX" <xinjianx.ma@intel.com>
To:     Alexey Gladkov <legion@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
CC:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        lkp <lkp@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "christian.brauner@ubuntu.com" <christian.brauner@ubuntu.com>,
        "containers@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>,
        "jannh@google.com" <jannh@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Subject: RE: [PATCH v11 5/9] Reimplement RLIMIT_MSGQUEUE on top of ucounts
Thread-Topic: [PATCH v11 5/9] Reimplement RLIMIT_MSGQUEUE on top of ucounts
Thread-Index: AQHXkxd6jQPRg5rF3UWHcji9NSI54at32Gt6gADgWICAAVhdsA==
Date:   Thu, 19 Aug 2021 01:50:06 +0000
Message-ID: <54046232de974a3687e4af6366c8ba18@intel.com>
References: <d650b7794e264d5f8aa107644cc9784f@intel.com>
 <87a6lgysxp.fsf@disp2133> <20210818131117.x7omzb2wkjq7le3s@example.org>
In-Reply-To: <20210818131117.x7omzb2wkjq7le3s@example.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.5.1.3
dlp-reaction: no-action
x-originating-ip: [10.108.32.68]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> -----Original Message-----
> From: Alexey Gladkov <legion@kernel.org>
> Sent: Wednesday, August 18, 2021 9:11 PM
> To: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Ma, XinjianX <xinjianx.ma@intel.com>; linux-kselftest@vger.kernel.org;
> lkp <lkp@intel.com>; akpm@linux-foundation.org; axboe@kernel.dk;
> christian.brauner@ubuntu.com; containers@lists.linux-foundation.org;
> jannh@google.com; keescook@chromium.org; kernel-
> hardening@lists.openwall.com; linux-kernel@vger.kernel.org; linux-
> mm@kvack.org; oleg@redhat.com; torvalds@linux-foundation.org
> Subject: Re: [PATCH v11 5/9] Reimplement RLIMIT_MSGQUEUE on top of
> ucounts
> 
> On Tue, Aug 17, 2021 at 10:47:14AM -0500, Eric W. Biederman wrote:
> > "Ma, XinjianX" <xinjianx.ma@intel.com> writes:
> >
> > > Hi Alexey,
> > >
> > > When lkp team run kernel selftests, we found after these series of
> > > patches, testcase mqueue: mq_perf_tests in kselftest failed with
> following message.
> >
> > Which kernel was this run against?
> >
> > Where can the mq_perf_tests that you ran and had problems with be
> found?
> >
> > During your run were you using user namespaces as part of your test
> > environment?
> >
> > The error message too many files corresponds to the error code EMFILES
> > which is the error code that is returned when the rlimit is reached.
> >
> > One possibility is that your test environment was run in a user
> > namespace and so you wound up limited by rlimit of the user who
> > created the user namespace at the point of user namespace creation.
> >
> > At this point if you can give us enough information to look into this
> > and attempt to reproduce it that would be appreciated.
> 
> I was able to reproduce it on master without using user namespace.
> I suspect that the maximum value is not assigned here [1]:
> 
> set_rlimit_ucount_max(&init_user_ns, UCOUNT_RLIMIT_MSGQUEUE,
> task_rlimit(&init_task, RLIMIT_MSGQUEUE));
> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kerne
> l/fork.c#n832
Thank you for confirming the issue. And will you plan to fix this issue?
If it's your plan, kindly add following tag as appropriate
Reported-by: kernel test robot <xinjianx.ma@intel.com>


> 
> > > If you confirm and fix the issue, kindly add following tag as
> > > appropriate
> > > Reported-by: kernel test robot lkp@intel.com
> > >
> > > ```
> > > # selftests: mqueue: mq_perf_tests
> > > #
> > > # Initial system state:
> > > #       Using queue path:                       /mq_perf_tests
> > > #       RLIMIT_MSGQUEUE(soft):                  819200
> > > #       RLIMIT_MSGQUEUE(hard):                  819200
> > > #       Maximum Message Size:                   8192
> > > #       Maximum Queue Size:                     10
> > > #       Nice value:                             0
> > > #
> > > # Adjusted system state for testing:
> > > #       RLIMIT_MSGQUEUE(soft):                  (unlimited)
> > > #       RLIMIT_MSGQUEUE(hard):                  (unlimited)
> > > #       Maximum Message Size:                   16777216
> > > #       Maximum Queue Size:                     65530
> > > #       Nice value:                             -20
> > > #       Continuous mode:                        (disabled)
> > > #       CPUs to pin:                            3
> > > # ./mq_perf_tests: mq_open() at 296: Too many open files not ok 2
> > > selftests: mqueue: mq_perf_tests # exit=1
> > > ```
> > >
> > > Test env:
> > > rootfs: debian-10
> > > gcc version: 9
> > >
> > > ------
> > > Thanks
> > > Ma Xinjian
> >
> > Eric
> >
> 
> --
> Rgrds, legion

