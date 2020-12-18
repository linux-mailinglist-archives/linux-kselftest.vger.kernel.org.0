Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C242DDDA7
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Dec 2020 05:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgLREKy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Dec 2020 23:10:54 -0500
Received: from mga04.intel.com ([192.55.52.120]:1629 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726798AbgLREKy (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Dec 2020 23:10:54 -0500
IronPort-SDR: vlHx6bbjJjI+grb7aJxu/u1uz2PzT+WnFFSp0BezImIwRft+pCRxk1H3qu3y8PHJzP0A9drZfm
 RexXxJL6Zh3A==
X-IronPort-AV: E=McAfee;i="6000,8403,9838"; a="172810701"
X-IronPort-AV: E=Sophos;i="5.78,429,1599548400"; 
   d="scan'208";a="172810701"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2020 20:10:13 -0800
IronPort-SDR: A8u2UZH5a9Ii6dfZcq04bAX2OwOham5rhmAyowRSRBJduIiiyn3HqDkqgXP4Y95DSUsg50PLbn
 q5u/5uck4oEw==
X-IronPort-AV: E=Sophos;i="5.78,429,1599548400"; 
   d="scan'208";a="338679461"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2020 20:10:12 -0800
Date:   Thu, 17 Dec 2020 20:10:12 -0800
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
Subject: Re: [NEEDS-REVIEW] [PATCH V3 04/10] x86/pks: Preserve the PKRS MSR
 on context switch
Message-ID: <20201218041012.GC2506510@iweiny-DESK2.sc.intel.com>
References: <20201106232908.364581-1-ira.weiny@intel.com>
 <20201106232908.364581-5-ira.weiny@intel.com>
 <ff685068-6821-ca35-7fa8-732a66cbf266@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff685068-6821-ca35-7fa8-732a66cbf266@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 17, 2020 at 12:41:50PM -0800, Dave Hansen wrote:
> On 11/6/20 3:29 PM, ira.weiny@intel.com wrote:
> >  void disable_TSC(void)
> > @@ -644,6 +668,8 @@ void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p)
> >  
> >  	if ((tifp ^ tifn) & _TIF_SLD)
> >  		switch_to_sld(tifn);
> > +
> > +	pks_sched_in();
> >  }
> 
> Does the selftest for this ever actually schedule()?

At this point I'm not sure.  This code has been in since the beginning.  So its
seen a lot of soak time.

> 
> I see it talking about context switching, but I don't immediately see
> how it would.

We were trying to force parent and child to run on the same CPU.  I suspect
something is wrong in the timing of that test.

Ira
