Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6B221077D4
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2019 20:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfKVTJ2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Nov 2019 14:09:28 -0500
Received: from mga05.intel.com ([192.55.52.43]:37384 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbfKVTJ2 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Nov 2019 14:09:28 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Nov 2019 11:09:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,230,1571727600"; 
   d="scan'208";a="259799981"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Nov 2019 11:09:27 -0800
Date:   Fri, 22 Nov 2019 11:09:27 -0800
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
Message-ID: <20191122190927.GB31235@linux.intel.com>
References: <20191119031240.7779-1-sean.j.christopherson@intel.com>
 <20191119031240.7779-13-sean.j.christopherson@intel.com>
 <20191121165250.GK6540@zn.tnic>
 <20191121215017.GC16617@linux.intel.com>
 <20191122183641.GJ6289@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122183641.GJ6289@zn.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 22, 2019 at 07:36:41PM +0100, Borislav Petkov wrote:
> On Thu, Nov 21, 2019 at 01:50:17PM -0800, Sean Christopherson wrote:
> > As for why I want to keep these out of cpu_has()... VMX has a concept of
> > features being fixed "on", e.g. early CPUs don't allow disabling off CR3
> > interception.  A cpu_has() approach doesn't work well since it loses the
> > information regarding which bits are fixed-1.  KVM also has several module
> > params that can be used to disable use of features, i.e. we don't want
> > cpu_has() for VMX features because the KVM-specific variables need to be
> > the canonical reference.
> 
> Well, you can use the cpu_has() machinery for stuff like that too - we
> can clear bits there too: clear_cpu_cap() - and since clearing those
> bits are only for /proc/cpuinfo reporting, it's not like anything would
> break if that flag is gone. Just saying, in case you want to use the
> machinery for that.

It doesn't fit the KVM use case very well.  There is an obnoxious amount
of legacy KVM code that exists only to support old processors (10+ years
old), but that we can't get rid of because people are still actively
running KVM on old hardware.  KVM provides module params so that we can
easily test those flows on modern hardware, e.g. for certain changes I'll
reload and retest KVM 2-3 times with different settings.

In theory we could do something like recompute VMX_FEATURE_* when KVM is
loaded, but that'd be a bit ugly and there are also tenative plans to move
the relevant module params under an ioctl() so that they can be toggled on
a per-VM basis to help automate testing, and IIRC for customers running
certain legacy workloads alongside normal VMs

> And that would avoid some of the duplication of having KVM-specific
> variables *and* VMX_FEATURE_* flags, where latter are not really
> toggleable but only for /proc/cpuinfo. Especially if you wanna enforce
> "developers to define a VMX_FEATURE flag when adding support for a new
> hardware feature."
