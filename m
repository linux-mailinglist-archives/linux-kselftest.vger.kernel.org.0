Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6CD5105C3E
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2019 22:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfKUVuV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Nov 2019 16:50:21 -0500
Received: from mga01.intel.com ([192.55.52.88]:31428 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbfKUVuV (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Nov 2019 16:50:21 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2019 13:50:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,227,1571727600"; 
   d="scan'208";a="205283769"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by fmsmga007.fm.intel.com with ESMTP; 21 Nov 2019 13:50:17 -0800
Date:   Thu, 21 Nov 2019 13:50:17 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Tony Luck <tony.luck@intel.com>,
        Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: Re: [PATCH v3 12/19] x86/vmx: Introduce VMX_FEATURES_*
Message-ID: <20191121215017.GC16617@linux.intel.com>
References: <20191119031240.7779-1-sean.j.christopherson@intel.com>
 <20191119031240.7779-13-sean.j.christopherson@intel.com>
 <20191121165250.GK6540@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121165250.GK6540@zn.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 21, 2019 at 05:52:58PM +0100, Borislav Petkov wrote:
> On Mon, Nov 18, 2019 at 07:12:33PM -0800, Sean Christopherson wrote:
> > Define separate VMX_FEATURE flags to set the stage for enumerating VMX
> > capabilities outside of the cpu_has() framework, and for adding
> > functional usage of VMX_FEATURE_* to help ensure the features reported
> > via /proc/cpuinfo is up to date with respect to kernel recognition of
> > VMX capabilities.
> 
> That's all fine and good but who's going to use those feature bits?
> Or are we reporting them just for the sake of it? Because if only
> that, then it is not worth the effort. Sure, I don't mind extending
> the framework so that you can use cpu_has() for VMX features but the
> /proc/cpuinfo angle is not clear to me.

I actually don't want to use cpu_has() for the VMX features, which is
why I put these in a separate array (one of the future patches).
 
The motivation is purely for /proc/cpuinfo.  Currently there is no sane
way for a user to query the capabilities of their platform.  The issue
comes up on a fairly regular basis, e.g. when trying to find a platform
to test a new feature or to debug an issue that has a hardware dependency.

Lack of reporting is especially annoying when the end user isn't familiar
with VMX, e.g. the format of the MSRs is non-standard, existence of some
MSRs is reported by bits in other MSRs, several features from KVM's point
of view are actually enumerated as 3+ separate features by hardware, etc...

Punting to a userspace utility isn't a viable option because all of the
capabilities are reported via MSRs.

As for why I want to keep these out of cpu_has()... VMX has a concept of
features being fixed "on", e.g. early CPUs don't allow disabling off CR3
interception.  A cpu_has() approach doesn't work well since it loses the
information regarding which bits are fixed-1.  KVM also has several module
params that can be used to disable use of features, i.e. we don't want
cpu_has() for VMX features because the KVM-specific variables need to be
the canonical reference.

> Especially since you're hiding most of them with the "" prepended in the
> define comment.
> 
> > +/* Pin-Based VM-Execution Controls, EPT/VPID, APIC and VM-Functions, word 0 */
> > +#define VMX_FEATURE_INTR_EXITING	( 0*32+  0) /* "" VM-Exit on vectored interrupts */
> > +#define VMX_FEATURE_NMI_EXITING		( 0*32+  3) /* "" VM-Exit on NMIs */
> > +#define VMX_FEATURE_VIRTUAL_NMIS	( 0*32+  5) /* "vnmi" NMI virtualization */
> > +#define VMX_FEATURE_PREEMPTION_TIMER	( 0*32+  6) /* VMX Preemption Timer */
> 
> You really wanna have "preemption_timer" in /proc/cpuinfo? That should
> at least say vmx-something, if it should be visible there at all.

Originally I wanted these to go in a completely separate line in
/proc/cpuinfo, e.g. "vmx flags".  That's what I submitted in v1, but then
found out it'd break the ABI due to handful of VMX features being
enumerated in "flags" via synthetic cpufeature bits.

Paolo suggested dropping the "vmx flags" approach as an easy solution, and
I obviously didn't update the names to prepend vmx_.  Preprending vmx_
would be somewhat annoying because changing the names of the synthetic
flags would also break the ABI...

Alternatively, what about adding "vmx flags" but keeping the existing
synthetic flags?  That'd mean having duplicates for tpr_shadow, vnmi, ept,
flexpriority, vpi and ept_ad.  On the plus side, we'd cap the pollution of
"flags" at those six features.
 
> > +#define VMX_FEATURE_POSTED_INTR		( 0*32+  7) /* Posted Interrupts */
> 
> Same here.
> 
> In general, the questions stand for all those feature bits which will be
> visible in /proc/cpuinfo.
> 
> 1. Which to show and why?
> 
> 2. Who's going to use them?
> 
> 3. If show and dumping them together with the other feature flags, have
> their name be proper (vmx-prefixed etc).
> 
> > +/* EPT/VPID features, scattered to bits 16-23 */
> > +#define VMX_FEATURE_INVVPID	        ( 0*32+ 16) /* INVVPID is supported */
> > +#define VMX_FEATURE_EPT_EXECUTE_ONLY	( 0*32+ 17) /* "ept_x_only" EPT entries can be execute only */
> > +#define VMX_FEATURE_EPT_AD      	( 0*32+ 18) /* EPT Accessed/Dirty bits */
> > +#define VMX_FEATURE_EPT_1GB      	( 0*32+ 19) /* 1GB EPT pages */
> 			      ^^^^^^^^^^^^
> 
> There are some spaces that need to be converted to tabs here.

Doh.
