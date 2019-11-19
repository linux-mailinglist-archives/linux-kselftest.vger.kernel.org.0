Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6764C1012C3
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2019 06:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfKSFDW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Nov 2019 00:03:22 -0500
Received: from mga14.intel.com ([192.55.52.115]:8390 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbfKSFDW (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Nov 2019 00:03:22 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 21:03:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,322,1569308400"; 
   d="scan'208";a="407626283"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by fmsmga006.fm.intel.com with ESMTP; 18 Nov 2019 21:03:17 -0800
Date:   Mon, 18 Nov 2019 21:03:17 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Kai Huang <kai.huang@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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
        linux-kselftest@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: Re: [PATCH v3 04/19] x86/intel: Initialize IA32_FEATURE_CONTROL MSR
 at boot
Message-ID: <20191119050317.GF23085@linux.intel.com>
References: <20191119031240.7779-1-sean.j.christopherson@intel.com>
 <20191119031240.7779-5-sean.j.christopherson@intel.com>
 <17a1831a3a72fb87ce2a35689e07ff517c4bdf99.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17a1831a3a72fb87ce2a35689e07ff517c4bdf99.camel@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 19, 2019 at 05:41:49PM +1300, Kai Huang wrote:
> On Mon, 2019-11-18 at 19:12 -0800, Sean Christopherson wrote:
> > +	/*
> > +	 * Enable VMX if and only if the kernel may do VMXON at some point,
> > +	 * i.e. KVM is enabled, to avoid unnecessarily adding an attack vector
> > +	 * for the kernel, e.g. using VMX to hide malicious code.
> > +	 */
> > +	if (cpu_has(c, X86_FEATURE_VMX) && IS_ENABLED(CONFIG_KVM)) {

Hmm, this should more specifically be CONFIG_KVM_INTEL.

> > +		msr |= FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX;
> > +		if (tboot_enabled())
> > +			msr |= FEAT_CTL_VMX_ENABLED_INSIDE_SMX;
> > +	}
> 
> Why not also take this chance to enable SGX? Or it will come with SGX patch
> series?

The latter.  Similar to the KVM check, this shouldn't opt in to SGX unless
the kernel is capable of using SGX.

> > +	wrmsrl(MSR_IA32_FEATURE_CONTROL, msr);
> > +}
> > diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> > index 4a900804a023..b7c6ed0b40b6 100644
> > --- a/arch/x86/kernel/cpu/intel.c
> > +++ b/arch/x86/kernel/cpu/intel.c
> > @@ -755,6 +755,8 @@ static void init_intel(struct cpuinfo_x86 *c)
> >  	/* Work around errata */
> >  	srat_detect_node(c);
> >  
> > +	init_feature_control_msr(c);
> 
> Will this compile if you disable CONFIG_X86_FEATURE_CONTROL_MSR?
> 
> Provide an empty one in cpu.h if the config is not enabled?

CONFIG_X86_FEATURE_CONTROL_MSR can't be disabled manually, it's selected
by CPU_SUP_INTEL (and by Zhaoxin/Centaur for their relevant patches).
