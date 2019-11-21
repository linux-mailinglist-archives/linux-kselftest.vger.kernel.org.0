Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE2BF105C7E
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2019 23:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfKUWMg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Nov 2019 17:12:36 -0500
Received: from mga03.intel.com ([134.134.136.65]:47756 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbfKUWMg (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Nov 2019 17:12:36 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2019 14:12:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,227,1571727600"; 
   d="scan'208";a="205292088"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by fmsmga007.fm.intel.com with ESMTP; 21 Nov 2019 14:12:34 -0800
Date:   Thu, 21 Nov 2019 14:12:34 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 04/19] x86/intel: Initialize IA32_FEATURE_CONTROL MSR
 at boot
Message-ID: <20191121221234.GE16617@linux.intel.com>
References: <20191119031240.7779-1-sean.j.christopherson@intel.com>
 <20191119031240.7779-5-sean.j.christopherson@intel.com>
 <20191121103925.GB20907@linux.intel.com>
 <20191121104145.GC20907@linux.intel.com>
 <20191121110533.GD6540@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121110533.GD6540@zn.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 21, 2019 at 12:05:33PM +0100, Borislav Petkov wrote:
> On Thu, Nov 21, 2019 at 12:41:45PM +0200, Jarkko Sakkinen wrote:
> > On Thu, Nov 21, 2019 at 12:39:25PM +0200, Jarkko Sakkinen wrote:
> > > > +void init_feature_control_msr(struct cpuinfo_x86 *c)
> > 
> > I'd also use here shorter init_feat_ctl_msr(). It has one call site
> > but shorter name is more convenient when playing with tracing tools.
> 
> Yeah, and since we're shortening all to feat_ctl, let's do:
> 
> mv arch/x86/kernel/cpu/feature_control.c arch/x86/kernel/cpu/feat_ctl.c

Any objection to keeping the MSR name as MSR_IA32_FEATURE_CONTOL?  I'd like
to have some anchor back to the name used in the SDM.

Any opinions/thoughts on the name of the Kconfig?  Currently it's
X86_FEATURE_CONTROL_MSR, which gets a bit long with CONFIG_ on the front.
I also overlooked that we have MSR_MISC_FEATURE_CONTROL, so having IA32 in
the Kconfig would probably be a good idea.  X86_IA32 is rather redundant,
so maybe IA32_FEAT_CTL or IA32_FEATURE_CONTROL?
