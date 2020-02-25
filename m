Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC4016F3F8
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2020 00:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbgBYXyh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Feb 2020 18:54:37 -0500
Received: from mga06.intel.com ([134.134.136.31]:56759 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729090AbgBYXyh (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Feb 2020 18:54:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2020 15:54:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,486,1574150400"; 
   d="scan'208";a="230279712"
Received: from jekeller-mobl1.amr.corp.intel.com (HELO [134.134.177.78]) ([134.134.177.78])
  by fmsmga007.fm.intel.com with ESMTP; 25 Feb 2020 15:54:34 -0800
Subject: Re: [PATCH v5 13/19] x86/cpufeatures: Add flag to track whether MSR
 IA32_FEAT_CTL is configured
To:     Sean Christopherson <sean.j.christopherson@intel.com>
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
References: <20191221044513.21680-14-sean.j.christopherson@intel.com>
 <e741196d-52aa-0f5e-8f1e-a37ddf2e5025@intel.com>
 <20200225221234.GL9245@linux.intel.com>
 <1eaf6fbe-0adb-5074-3bc4-1e8327e0cdb3@intel.com>
 <20200225232900.GO9245@linux.intel.com>
From:   Jacob Keller <jacob.e.keller@intel.com>
Organization: Intel Corporation
Message-ID: <5434303a-0742-3811-fd14-6445d296c0f0@intel.com>
Date:   Tue, 25 Feb 2020 15:54:34 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200225232900.GO9245@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/25/2020 3:29 PM, Sean Christopherson wrote:
> On Tue, Feb 25, 2020 at 02:52:32PM -0800, Jacob Keller wrote:
>> On 2/25/2020 2:12 PM, Sean Christopherson wrote:
>>> On Tue, Feb 25, 2020 at 01:49:13PM -0800, Jacob Keller wrote:
>>>> Hi Sean,
>>>>
>>>> I suspect something is wrong and the features are enabled even though
>>>> the BIOS has it disabled, leading to later failure because of this.
>>>
>>> Hrm.  On the failing kernel, what are the values of MSR 0x3a for all CPUs,
>>> i.e. what's the output of 'sudo rdmsr -a 0x3a'?
>>>
>>
>> On the old (fedora 30) kernel, every cpu reports as '1'.
>>
>> I can't easily test the failing kernel because it crashes during boot.
> 
> No need, your BIOS is likely locking the MSR, I doubt the value is any
> different when running the new kernel.
> 
> Does reverting commit a4d0b2fdbcf7 ("KVM: VMX: Use VMX feature flag to
> query BIOS enabling") resolve the issue?
> 
> Is the failing kernel an (umodified) upstream kernel?  A stable kernel?
> Or something else?  Assuming it's an unmodified upstream kernel, can you
> send your .config?  I've tried all the obvious Kconfig combinations but
> haven't been able to reproduce the problem.  Staring at the code hasn't
> yielded any revelations either.
> 

I reverted the suggested commit and added some prints:

[   26.056398] X86_FEATURE_MSR_IA32_FEAT_CTL is enabled
[   26.062426] X86_FEATURE_VMX is enabled
[   26.066923] kvm: disabled by bios

So the old code flow is finding KVM to be disabled, but both features
are set...

The code that sets this is run first:

> Feb 25 15:46:05 jbrandeb-saw1 kernel: x86/cpu: FEAT_CTL_LOCKED is set
> Feb 25 15:46:05 jbrandeb-saw1 kernel: x86/cpu: FEAT_CTL_VMX_ENABLED_INSIDE_SMX is unset
> Feb 25 15:46:05 jbrandeb-saw1 kernel: x86/cpu: FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX is unset
> Feb 25 15:46:05 jbrandeb-saw1 kernel: x86/cpu: MSR locked by bios
> Feb 25 15:46:05 jbrandeb-saw1 kernel: x86/cpu: VMX (outside TXT) disabled by BIOS
> Feb 25 15:46:05 jbrandeb-saw1 kernel: x86/cpu: disabling X86_FEATURE_VMX

But somehow... it is still set later...

So there's something weird going on. Maybe "boot_cpu_has" in the
vmx_disabled_by_bios is wrong? Hmm.
