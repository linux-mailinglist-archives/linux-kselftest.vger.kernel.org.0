Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD67F2DDD98
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Dec 2020 05:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732037AbgLREFv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Dec 2020 23:05:51 -0500
Received: from mga01.intel.com ([192.55.52.88]:50611 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbgLREFv (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Dec 2020 23:05:51 -0500
IronPort-SDR: +Vxzu50+9Acaorum5Si1d0lAYaQ3N4DQnaEAtiA3lGP86piOurtx4rVBJAPI+gtzK70qrNnsEa
 waC/LfErMccg==
X-IronPort-AV: E=McAfee;i="6000,8403,9838"; a="193782108"
X-IronPort-AV: E=Sophos;i="5.78,429,1599548400"; 
   d="scan'208";a="193782108"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2020 20:05:10 -0800
IronPort-SDR: H7Ptrfhyn4Q0/MQ290Py5RH1IOQkdFP9uA3u+tCGsO9MgVxuu6W0YKL6rjeHqs7mJDR3X8q6uC
 hP2pWdLfD4iQ==
X-IronPort-AV: E=Sophos;i="5.78,429,1599548400"; 
   d="scan'208";a="353728334"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2020 20:05:10 -0800
Date:   Thu, 17 Dec 2020 20:05:09 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V3 10/10] x86/pks: Add PKS test code
Message-ID: <20201218040509.GD1563847@iweiny-DESK2.sc.intel.com>
References: <20201106232908.364581-1-ira.weiny@intel.com>
 <20201106232908.364581-11-ira.weiny@intel.com>
 <570ead2a-ff41-e730-d61d-0f59c67b1903@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <570ead2a-ff41-e730-d61d-0f59c67b1903@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 17, 2020 at 12:55:39PM -0800, Dave Hansen wrote:
> On 11/6/20 3:29 PM, ira.weiny@intel.com wrote:
> > +		/* Arm for context switch test */
> > +		write(fd, "1", 1);
> > +
> > +		/* Context switch out... */
> > +		sleep(4);
> > +
> > +		/* Check msr restored */
> > +		write(fd, "2", 1);
> 
> These are always tricky.  What you ideally want here is:
> 
> 1. Switch away from this task to a non-PKS task, or
> 2. Switch from this task to a PKS-using task, but one which has a
>    different PKS value

Or both...

> 
> then, switch back to this task and make sure PKS maintained its value.
> 
> *But*, there's no absolute guarantee that another task will run.  It
> would not be totally unreasonable to have the kernel just sit in a loop
> without context switching here if no other tasks can run.
> 
> The only way you *know* there is a context switch is by having two tasks
> bound to the same logical CPU and make sure they run one after another.

Ah...  We do that.

...
+       CPU_ZERO(&cpuset);
+       CPU_SET(0, &cpuset);
+       /* Two processes run on CPU 0 so that they go through context switch.  */
+       sched_setaffinity(getpid(), sizeof(cpu_set_t), &cpuset);
...

I think this should be ensuring that both the parent and the child are
running on CPU 0.  At least according to the man page they should be.

<man>
	A child created via fork(2) inherits its parent's CPU affinity mask.
</man>

Perhaps a better method would be to synchronize the 2 threads more to ensure
that we are really running at the 'same time' and forcing the context switch.

>  This just gets itself into a state where it *CAN* context switch and
> prays that one will happen.

Not sure what you mean by 'This'?  Do you mean that running on the same CPU
will sometimes not force a context switch?  Or do you mean that the sleeps
could be badly timed and the 2 threads could run 1 after the other on the same
CPU?  The latter is AFAICT the most likely case.

> 
> You can also run a bunch of these in parallel bound to a single CPU.
> That would also give you higher levels of assurance that *some* context
> switch happens at sleep().

I think more cycles is a good idea for sure.  But I'm more comfortable with
forcing the test to be more synchronized so that it is actually running in the
order we think/want it to be.

> 
> One critical thing with these tests is to sabotage the kernel and then
> run them and make *sure* they fail.  Basically, if you screw up, do they
> actually work to catch it?

I'll try and come up with a more stressful test.

Ira
