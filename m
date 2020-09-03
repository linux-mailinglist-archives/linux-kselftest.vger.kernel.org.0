Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A091A25C364
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Sep 2020 16:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbgICOuc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Sep 2020 10:50:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:58808 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729221AbgICOua (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Sep 2020 10:50:30 -0400
IronPort-SDR: 6Sz4wc/NfUDnUKmYLIKE3ehT6FTSAK8RQN8MaQmqjtIT7BnyqH6lAczhzd/iKRcXq4DjjBpPZu
 ACJx+DChaFqw==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="145321772"
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; 
   d="scan'208";a="145321772"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 07:50:29 -0700
IronPort-SDR: BwfK41eGLvTp+sj057B+tx268htgpgChICs9sUe69HpeljkYMvFuz5O4Phxc8mh3C6kWui8ZDp
 jglQq2nL/hvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; 
   d="scan'208";a="375890461"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 03 Sep 2020 07:50:29 -0700
Received: from abityuts-desk1.ger.corp.intel.com (abityuts-desk1.ger.corp.intel.com [10.237.72.186])
        by linux.intel.com (Postfix) with ESMTP id 586515807B5;
        Thu,  3 Sep 2020 07:50:26 -0700 (PDT)
Message-ID: <9c5156274a86573ad592e6e431f3cbee8135b736.camel@gmail.com>
Subject: Re: [RFC v4 1/1] selftests/cpuidle: Add support for cpuidle latency
 measurement
From:   Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To:     Pratik Sampat <psampat@linux.ibm.com>, rjw@rjwysocki.net,
        daniel.lezcano@linaro.org, srivatsa@csail.mit.edu,
        shuah@kernel.org, npiggin@gmail.com, ego@linux.vnet.ibm.com,
        svaidy@linux.ibm.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        pratik.r.sampat@gmail.com
Date:   Thu, 03 Sep 2020 17:50:25 +0300
In-Reply-To: <fa616fed-66be-bcad-83b8-b1173a3a444f@linux.ibm.com>
References: <20200902114506.45809-1-psampat@linux.ibm.com>
         <20200902114506.45809-2-psampat@linux.ibm.com>
         <b59481655c29d081eea4f34c00166517738000e5.camel@gmail.com>
         <fa616fed-66be-bcad-83b8-b1173a3a444f@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 2020-09-03 at 17:30 +0530, Pratik Sampat wrote:
> I certainly did not know about that the Intel architecture being aware
> of timers and pre-wakes the CPUs which makes the timer experiment
> observations void.

Well, things depend on platform, it is really "void", it is just
different and it measures an optimized case. The result may be smaller
observed latency. And things depend on the platform.

> However, we are also collecting a baseline measurement wherein we run
> the same test on a 100% busy CPU and the measurement of latency from
> that could be considered to the kernel-userspace overhead.
> The rest of the measurements would be considered keeping this baseline
> in mind.

Yes, this should give the idea of the overhead, but still, at least for
many Intel platforms I would not be comfortable using the resulting
number (measured latency - baseline) for a cpuidle driver, because
there are just too many variables there. I am not sure I could assume
the baseline measured this way is an invariant - it could be noticeably
different depending on whether you use C-states or not.

> > At least on Intel platforms, this will mean that the IPI method won't
> > cover deep C-states like, say, PC6, because one CPU is busy. Again, not
> > saying this is not interesting, just pointing out the limitation.
> 
> That's a valid point. We have similar deep idle states in POWER too.
> The idea here is that this test should be run on an already idle
> system, of course there will be kernel jitters along the way
> which can cause little skewness in observations across some CPUs but I
> believe the observations overall should be stable.

If baseline and cpuidle latency are numbers of same order of magnitude,
and you are measuring in a controlled lab system, may be yes. But if
baseline is, say, in milliseconds, and you are measuring a 10
microseconds C-state, then probably no.

> Another solution to this could be using isolcpus, but that just
> increases the complexity all the more.
> If you have any suggestions of any other way that could guarantee
> idleness that would be great.

Well, I did not try to guarantee idleness. I just use timers and
external device (the network card), so no CPUs needs to be busy and the
system can enter deep C-states. Then I just look at median, 99%-th
percentile, etc.

But by all means IPI is also a very interesting experiment. Just covers
a different usage scenario.

When I started experimenting in this area, one of my main early
takeaways was realization that C-state latency really depends on the
event source.

HTH,
Artem.

