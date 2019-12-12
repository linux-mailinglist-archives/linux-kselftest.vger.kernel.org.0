Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A383911D498
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2019 18:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbfLLRzO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Dec 2019 12:55:14 -0500
Received: from mga07.intel.com ([134.134.136.100]:38099 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729771AbfLLRzO (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Dec 2019 12:55:14 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 09:55:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,306,1571727600"; 
   d="scan'208";a="245819700"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by fmsmga002.fm.intel.com with ESMTP; 12 Dec 2019 09:55:11 -0800
Date:   Thu, 12 Dec 2019 09:55:11 -0800
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
        Len Brown <lenb@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: Re: [PATCH v4 10/19] x86/cpu: Detect VMX features on Intel, Centaur
 and Zhaoxin CPUs
Message-ID: <20191212175511.GG3163@linux.intel.com>
References: <20191128014016.4389-1-sean.j.christopherson@intel.com>
 <20191128014016.4389-11-sean.j.christopherson@intel.com>
 <20191212113838.GD4991@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212113838.GD4991@zn.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 12, 2019 at 12:38:38PM +0100, Borislav Petkov wrote:
> On Wed, Nov 27, 2019 at 05:40:07PM -0800, Sean Christopherson wrote:
> > +static void init_vmx_capabilities(struct cpuinfo_x86 *c)
> > +{
> > +	u32 supported, funcs, ept, vpid, ign;
> > +
> > +	BUILD_BUG_ON(NVMXINTS != NR_VMX_FEATURE_WORDS);
> > +
> > +	/*
> > +	 * The high bits contain the allowed-1 settings, i.e. features that can
> > +	 * be turned on.  The low bits contain the allowed-0 settings, i.e.
> > +	 * features that can be turned off.  Ignore the allowed-0 settings,
> > +	 * if a feature can be turned on then it's supported.
> > +	 */
> > +	rdmsr(MSR_IA32_VMX_PROCBASED_CTLS, ign, supported);
> > +	c->vmx_capability[PRIMARY_PROC_CTLS] = supported;
> > +
> > +	rdmsr_safe(MSR_IA32_VMX_PROCBASED_CTLS2, &ign, &supported);
> > +	c->vmx_capability[SECONDARY_PROC_CTLS] = supported;
> > +
> > +	rdmsr(MSR_IA32_VMX_PINBASED_CTLS, ign, supported);
> > +	rdmsr_safe(MSR_IA32_VMX_VMFUNC, &ign, &funcs);
> > +
> > +	/*
> > +	 * Except for EPT+VPID, which enumerates support for both in a single
> > +	 * MSR, low for EPT, high for VPID.
> > +	 */
> > +	rdmsr_safe(MSR_IA32_VMX_EPT_VPID_CAP, &ept, &vpid);
> 
> Right, so this is a garden variety of rdmsr() and rdmsr_safe() and
> the safe variant's retval needs to be checked, strictly speaking. It
> probably doesn't matter here since you'll get 0s if it fails, which
> means feature not supported, so all good.
> 
> But I guess you can still use rdmsr_safe() everywhere just so it doesn't
> cause head scratching in the future, when one looks at that code.

The reasoning behind using vanilla rdmsr() on PROC and PIN controls is that
those MSRs should exist on any CPU that supports VMX, i.e. we want the WARN.

The alternative would be to use rdmsr_safe() for everything and then
explicitly disable VMX if a fault on PROC or PIN occurs, but that circles
us back to the handling a fault on rdmsr(MSR_IA32_FEAT_CTL), i.e. is it
really worth gracefully handling a fault that should never occur?

> 
> > +#endif /* CONFIG_X86_VMX_FEATURE_NAMES */
> >  
> >  #undef pr_fmt
> >  #define pr_fmt(fmt)	"x86/cpu: " fmt
> > @@ -50,5 +116,9 @@ void init_ia32_feat_ctl(struct cpuinfo_x86 *c)
> >  		pr_err_once("VMX (%s TXT) disabled by BIOS\n",
> >  			    tboot ? "inside" : "outside");
> >  		clear_cpu_cap(c, X86_FEATURE_VMX);
> > +	} else {
> > +#ifdef CONFIG_X86_VMX_FEATURE_NAMES
> > +		init_vmx_capabilities(c);
> > +#endif
> 
> Can't say that I'm happy about all that ifdeffery but I guess we need
> to perpetuate this since X86_FEATURE_NAMES is there for embedded. In
> practice, probably no one disables it...

Ya, systemd wasn't happy when I tried booting without X86_FEATURE_NAMES.
