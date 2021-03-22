Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F03345282
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Mar 2021 23:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhCVWo5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Mar 2021 18:44:57 -0400
Received: from mga09.intel.com ([134.134.136.24]:14973 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229639AbhCVWor (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Mar 2021 18:44:47 -0400
IronPort-SDR: 3XVnfYDZQ/siAJEUhSG2SPDz5ZYwXlecDBlAHHrpIi0qDlSYjR8dbQs7aau3XWGjID99ntvjyM
 ZryPIg430LvQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="190456249"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="190456249"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 15:44:46 -0700
IronPort-SDR: Cs90cP332n3ZwIZ+y9pl7057fKYog23Iah6j7pRk3RlXtypyIKmOoS8gd8Dobj3vdvqWv+XFt4
 NCdy85z+Y8mQ==
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="408012774"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 15:44:46 -0700
Date:   Mon, 22 Mar 2021 15:44:46 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH V4 06/10] x86/fault: Adjust WARN_ON for PKey fault
Message-ID: <20210322224446.GQ3014244@iweiny-DESK2.sc.intel.com>
References: <20210322053020.2287058-1-ira.weiny@intel.com>
 <20210322053020.2287058-7-ira.weiny@intel.com>
 <YFjAV44u7i9t1TDL@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFjAV44u7i9t1TDL@google.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 22, 2021 at 09:05:43AM -0700, Sean Christopherson wrote:
> On Sun, Mar 21, 2021, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > PKey faults may now happen on kernel mappings if the feature is enabled.
> > Remove the warning in the fault path if PKS is enabled.
> 
> When/why can they happen?  I read through all the changelogs, as well as the
> cover letters for v1 and the RFC, and didn't see any explicit statement about
> why pkey faults on supervisor accesses are now "legal".

Ok, I have to admit I did not think about documenting this detail...  I'll
update the commit message a bit more.

Prior to this series pkeys were only supported on user page mappings.
Therefore seeing a X86_PF_PK error in this path was completely unexpected and
warranted the extra WARN_ON to indicate that something went very wrong.

> Explaining what happens
> later in the page fault handler would also be helpful, e.g. is the flag simply
> ignored?

Ok I'll do this.  But the behavior does not change.  The fault is unhandled and
results in an Ooops.  The only difference is that if PKS is enabled and
configured on a kernel mapping the oops is to be expected.

> Does it lead directly to OOPS?

Yes, the series concludes with it being an ooops unless the test code is
running.  The behavior does not change from before.  I'll more clearly document
that...

> 
> Documenting what happens on a PKS #PF in the API patch would be nice to have, too.

Ok, yes, good idea.

> 
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > ---
> >  arch/x86/mm/fault.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> > index a73347e2cdfc..731ec90ed413 100644
> > --- a/arch/x86/mm/fault.c
> > +++ b/arch/x86/mm/fault.c
> > @@ -1141,11 +1141,12 @@ do_kern_addr_fault(struct pt_regs *regs, unsigned long hw_error_code,
> >  		   unsigned long address)
> >  {
> >  	/*
> > -	 * Protection keys exceptions only happen on user pages.  We
> > -	 * have no user pages in the kernel portion of the address
> > -	 * space, so do not expect them here.
> > +	 * PF_PK is expected on kernel addresses when supervisor pkeys are
> 
> "is expected" can be misinterpreted as "PF is expected on all kernel addresses...".

Yes the commit message was more clear by using 'may'.

> 
> This ties in with the lack of an explanation in the changelog.
> 
> > +	 * enabled.
> 
> It'd be helpful to spell out "Protection keys exceptions" so that random readers
> don't need to search for PF_PK to understand what's up.  Maybe even use it as an
> opportunity to introduce "pkeys", e.g.
> 
> 	/* Protection keys (pkeys) exceptions are ... */

Fair enough.  Will do.  I've changed this to:

        /*
         * X86_PF_PK (Protection key exceptions) may occur on kernel addresses
         * when PKS (PKeys Supervisor) are enabled.
         *
         * If PKS is not enabled an exception should only happen on user pages.
         * Because, we have no user pages in the kernel portion of the address
         * space something must have gone very wrong and we should WARN.
         */

> 
> >  	 */
> > -	WARN_ON_ONCE(hw_error_code & X86_PF_PK);
> > +	if (!cpu_feature_enabled(X86_FEATURE_PKS))
> > +		WARN_ON_ONCE(hw_error_code & X86_PF_PK);
> 
> Does this generate the same code if the whole thing is thrown in the WARN?  E.g.
> 
> 	WARN_ON_ONCE(!cpu_feature_enabled(X86_FEATURE_PKS) &&
> 		     (hw_error_code & X86_PF_PK));

I don't know in the general case.  But if CONFIG_BUG=n this would be better.

I've changed it.

Thanks!
Ira
