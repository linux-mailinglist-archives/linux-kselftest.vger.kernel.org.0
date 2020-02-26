Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDD3D170A0A
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2020 21:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbgBZU5r (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Feb 2020 15:57:47 -0500
Received: from mga01.intel.com ([192.55.52.88]:49510 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727387AbgBZU5q (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Feb 2020 15:57:46 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 12:57:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,489,1574150400"; 
   d="scan'208";a="410756910"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by orsmga005.jf.intel.com with ESMTP; 26 Feb 2020 12:57:45 -0800
Date:   Wed, 26 Feb 2020 12:57:45 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     TonyWWang-oc@zhaoxin.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, bp@alien8.de, bp@suse.de,
        hpa@zytor.com, jacob.jun.pan@linux.intel.com,
        jarkko.sakkinen@linux.intel.com, jmattson@google.com,
        jolsa@redhat.com, joro@8bytes.org, kvm@vger.kernel.org,
        lenb@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-pm@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com,
        namhyung@kernel.org, pbonzini@redhat.com, peterz@infradead.org,
        rkrcmar@redhat.com, shuah@kernel.org, tglx@linutronix.de,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org
Subject: Re: [PATCH v5 13/19] x86/cpufeatures: Add flag to track whether MSR
 IA32_FEAT_CTL is configured
Message-ID: <20200226205745.GQ9940@linux.intel.com>
References: <20191221044513.21680-14-sean.j.christopherson@intel.com>
 <e741196d-52aa-0f5e-8f1e-a37ddf2e5025@intel.com>
 <20200225221234.GL9245@linux.intel.com>
 <1eaf6fbe-0adb-5074-3bc4-1e8327e0cdb3@intel.com>
 <20200225232900.GO9245@linux.intel.com>
 <5434303a-0742-3811-fd14-6445d296c0f0@intel.com>
 <20200226004258.GP9245@linux.intel.com>
 <a9c4b363-1569-f03e-6155-a869dd186ced@intel.com>
 <df215c4c-82f0-5b15-57c3-d304fd94ff3b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df215c4c-82f0-5b15-57c3-d304fd94ff3b@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Feb 26, 2020 at 12:41:09PM -0800, Jacob Keller wrote:
> On 2/25/2020 4:58 PM, Jacob Keller wrote:
> > On 2/25/2020 4:42 PM, Sean Christopherson wrote>> So there's something
> > weird going on. Maybe "boot_cpu_has" in the
> >>> vmx_disabled_by_bios is wrong? Hmm.
> >>
> >> Hmm, perhaps a bug somewhere else is overwriting the cpufeatures bit for
> >> X86_FEATURE_VMX.  Let me see if I can reproduce from net-next.
> >>
> > 
> > If you have any further suggestions for debugging, I'm happy to help try
> > to figure this out. To my eyes, it looks like somehow bits get reset...
> > It's definitely not clear to me how this happens.
> > 
> > There is the get_cpu_caps call.. but that seems to correctly call
> > apply_forced_caps at the end.
> > 
> > That's all I have time for today.
> > 
> > Thanks,
> > Jake
> > 
> 
> Hi,
> 
> I kept digging into this, and I added a further print to the get_cpu_cap
> function.
> 
> It looks like get_cpu_cap is being called again *after*
> init_ia32_feat_ctl...
> 
> Digging further, I discovered this appears to be the call in setup_pku,
> which would only be enabled for systems which have X86_FEATURE_PKU
> enabled and supported. It's quite likely that test systems may not have
> had this feature, hence why it went undetected till now.

Ya, probably not a whole lot of folks with Icelake silicon and VMX disabled
in BIOS.  I'll see if I can reproduce on my ICX system, that would make
testing a fix a little easier.
 
> Because of the extra get_cpu_cap call, the capabilities are reset. Since
> we never use setup_clear_cpu_cap or pass NULL to clear_cpu_cap, the code
> that sets the global cpu_caps_cleared bits is not run.
> 
> It's not clear to me what the best fix for this is.
> 
> Perhaps init_ia32_feat_ctl should be something run during
> early_identify_cpu, since it's really checking global status (rdmsr),
> and not per-CPU status. And then it could directly operate to call
> setup_clear_cpu_cap, which would properly clear the bit globally,
> ensuring that apply_forced_caps kicks in?
> 
> Or this needs to somehow be run *after* setup_pku? But that doesn't feel
> very robust.

Bummer.  Using clear_cpu_cap() instead of setup_clear_cpu_cap() was me
being fancy and trying to allow KVM to identify the case where VMX is
available and configured on some CPUs but not all.  I'll work on a fix.
