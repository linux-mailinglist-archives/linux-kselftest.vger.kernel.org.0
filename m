Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2CEC11D458
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2019 18:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729977AbfLLRoA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Dec 2019 12:44:00 -0500
Received: from mga18.intel.com ([134.134.136.126]:32104 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730235AbfLLRn6 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Dec 2019 12:43:58 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 09:43:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,306,1571727600"; 
   d="scan'208";a="216367838"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by orsmga003.jf.intel.com with ESMTP; 12 Dec 2019 09:43:57 -0800
Date:   Thu, 12 Dec 2019 09:43:57 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Liran Alon <liran.alon@oracle.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
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
Subject: Re: [PATCH v4 11/19] x86/cpu: Print VMX flags in /proc/cpuinfo using
 VMX_FEATURES_*
Message-ID: <20191212174357.GE3163@linux.intel.com>
References: <20191128014016.4389-1-sean.j.christopherson@intel.com>
 <20191128014016.4389-12-sean.j.christopherson@intel.com>
 <20191212122646.GE4991@zn.tnic>
 <d0b21e7e-69f5-09f9-3e1c-14d49fa42b9f@redhat.com>
 <4A24DE75-4E68-4EC6-B3F3-4ACB0EE82BF0@oracle.com>
 <17c6569e-d0af-539c-6d63-f4c07367d8d1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17c6569e-d0af-539c-6d63-f4c07367d8d1@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 12, 2019 at 04:57:10PM +0100, Paolo Bonzini wrote:
> On 12/12/19 16:52, Liran Alon wrote:
> >>> virt_apic_accesses	-> vapic
> >> apicv
> > Frankly, I dislike APICv terminology. I prefer to enumerate the
> > various VMX features which are collectively called APICv by KVM. 
> > APICv currently represents in KVM terminology the combination of
> > APIC-register virtualization, virtual-interrupt-delivery and
> > posted-interrupts (See cpu_has_vmx_apicv()).
> > 
> > In fact, the coupling of “enable_apicv” module parameter have made me
> > multiple times to need to disable entire APICv features when there
> > for example was only a bug in posted-interrupts.
> > 
> > Even you got confused as virtualize-apic-access is not part of KVM’s
> > APICv terminology but rather it’s enablement depend on
> > flexpriority_enabled (See cpu_need_virtualize_apic_accesses()). i.e.
> > It can be used for faster intercept handling of accesses to guest
> > xAPIC MMIO page.
> 
> Right, I got confused with APIC-register virtualization.  Virtualize
> APIC accesses is another one I wouldn't bother putting in /proc/cpuinfo,
> since it's usually present together with flexpriority.

Key word being "usually".  My intent in printing out partially redundant
flags was to help users debug/understand why the combined feature isn't
supported.  E.g. userspace can already easily (relatively speaking) query
flexpriority support via /sys/module/kvm_intel/parameters/flexpriority.
But if that comes back "N", the user has no way to determine exactly why
flexpriority is disabled.
