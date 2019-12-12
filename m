Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B094511D476
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2019 18:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbfLLRsG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Dec 2019 12:48:06 -0500
Received: from mga03.intel.com ([134.134.136.65]:48925 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729771AbfLLRsF (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Dec 2019 12:48:05 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 09:48:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,306,1571727600"; 
   d="scan'208";a="245817844"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by fmsmga002.fm.intel.com with ESMTP; 12 Dec 2019 09:48:01 -0800
Date:   Thu, 12 Dec 2019 09:48:01 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
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
        Len Brown <lenb@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: Re: [PATCH v4 01/19] x86/msr-index: Clean up bit defines for
 IA32_FEATURE_CONTROL MSR
Message-ID: <20191212174801.GF3163@linux.intel.com>
References: <20191128014016.4389-2-sean.j.christopherson@intel.com>
 <201912010347.7tMb4moN%lkp@intel.com>
 <20191202190633.GG4063@linux.intel.com>
 <20191212092509.GB4991@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212092509.GB4991@zn.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 12, 2019 at 10:25:09AM +0100, Borislav Petkov wrote:
> On Mon, Dec 02, 2019 at 11:06:33AM -0800, Sean Christopherson wrote:
> > Argh, flat out missed this when doing search and replace.
> 
> There are more. What always works reliably for me is git grep:
> 
> $ git grep MSR_IA32_FEATURE_CONTROL
> drivers/idle/intel_idle.c:1287:         rdmsrl(MSR_IA32_FEATURE_CONTROL, msr);
> tools/arch/x86/include/asm/msr-index.h:561:#define MSR_IA32_FEATURE_CONTROL        0x0000003a
> tools/power/x86/turbostat/turbostat.c:4502:     if (!get_msr(base_cpu, MSR_IA32_FEATURE_CONTROL, &msr))
> tools/power/x86/turbostat/turbostat.c:4503:             fprintf(outf, "cpu%d: MSR_IA32_FEATURE_CONTROL: 0x%08llx (%sLocked %s)\n",
> tools/testing/selftests/kvm/include/x86_64/processor.h:771:#define MSR_IA32_FEATURE_CONTROL        0x0000003a
> tools/testing/selftests/kvm/lib/x86_64/vmx.c:162:       feature_control = rdmsr(MSR_IA32_FEATURE_CONTROL);
> tools/testing/selftests/kvm/lib/x86_64/vmx.c:164:               wrmsr(MSR_IA32_FEATURE_CONTROL, feature_control | required);
> 
> those additional ones won't break the build but it is perhaps worth
> unifying them all since we're at it, anyway.

I caught all the tools updates and addressed them in patch 03/19, "tools
arch x86: Sync msr-index.h from kernel sources".  Do you want those changes
folded into the rename itself? 
