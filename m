Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 603EC10EFCC
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2019 20:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbfLBTGf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Dec 2019 14:06:35 -0500
Received: from mga03.intel.com ([134.134.136.65]:53014 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727580AbfLBTGf (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Dec 2019 14:06:35 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Dec 2019 11:06:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,270,1571727600"; 
   d="scan'208";a="213149061"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by orsmga003.jf.intel.com with ESMTP; 02 Dec 2019 11:06:33 -0800
Date:   Mon, 2 Dec 2019 11:06:33 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, Thomas Gleixner <tglx@linutronix.de>,
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
        Len Brown <lenb@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: Re: [PATCH v4 01/19] x86/msr-index: Clean up bit defines for
 IA32_FEATURE_CONTROL MSR
Message-ID: <20191202190633.GG4063@linux.intel.com>
References: <20191128014016.4389-2-sean.j.christopherson@intel.com>
 <201912010347.7tMb4moN%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201912010347.7tMb4moN%lkp@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Dec 01, 2019 at 04:52:53AM +0800, kbuild test robot wrote:
> Hi Sean,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on tip/auto-latest]
> [also build test ERROR on next-20191129]
> [cannot apply to tip/x86/core kvm/linux-next v5.4]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Sean-Christopherson/x86-cpu-Clean-up-handling-of-VMX-features/20191128-094556
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git e445033e58108a9891abfbc0dea90b066a75e4a9
> config: x86_64-randconfig-s0-20191128 (attached as .config)
> compiler: gcc-7 (Debian 7.4.0-14) 7.4.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from arch/x86/include/asm/processor.h:22:0,
>                     from arch/x86/include/asm/cpufeature.h:5,
>                     from arch/x86/include/asm/thread_info.h:53,
>                     from include/linux/thread_info.h:38,
>                     from arch/x86/include/asm/preempt.h:7,
>                     from include/linux/preempt.h:78,
>                     from include/linux/percpu.h:6,
>                     from include/linux/cpuidle.h:14,
>                     from drivers/idle/intel_idle.c:45:
>    drivers/idle/intel_idle.c: In function 'sklh_idle_state_table_update':
> >> drivers/idle/intel_idle.c:1287:10: error: 'MSR_IA32_FEATURE_CONTROL' undeclared (first use in this function); did you mean 'MSR_MISC_FEATURE_CONTROL'?
>       rdmsrl(MSR_IA32_FEATURE_CONTROL, msr);
>              ^

Argh, flat out missed this when doing search and replace.

>    arch/x86/include/asm/msr.h:279:28: note: in definition of macro 'rdmsrl'
>      ((val) = native_read_msr((msr)))
>                                ^~~
>    drivers/idle/intel_idle.c:1287:10: note: each undeclared identifier is reported only once for each function it appears in
>       rdmsrl(MSR_IA32_FEATURE_CONTROL, msr);
>              ^
>    arch/x86/include/asm/msr.h:279:28: note: in definition of macro 'rdmsrl'
>      ((val) = native_read_msr((msr)))
>                                ^~~
> 
> vim +1287 drivers/idle/intel_idle.c
