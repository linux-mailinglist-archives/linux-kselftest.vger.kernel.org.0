Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10F241709E9
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2020 21:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbgBZUlN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Feb 2020 15:41:13 -0500
Received: from mga06.intel.com ([134.134.136.31]:5071 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727350AbgBZUlN (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Feb 2020 15:41:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 12:41:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,489,1574150400"; 
   d="scan'208";a="350475837"
Received: from jekeller-mobl1.amr.corp.intel.com (HELO [134.134.177.84]) ([134.134.177.84])
  by fmsmga001.fm.intel.com with ESMTP; 26 Feb 2020 12:41:10 -0800
Subject: Re: [PATCH v5 13/19] x86/cpufeatures: Add flag to track whether MSR
 IA32_FEAT_CTL is configured
From:   Jacob Keller <jacob.e.keller@intel.com>
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
 <5434303a-0742-3811-fd14-6445d296c0f0@intel.com>
 <20200226004258.GP9245@linux.intel.com>
 <a9c4b363-1569-f03e-6155-a869dd186ced@intel.com>
Organization: Intel Corporation
Message-ID: <df215c4c-82f0-5b15-57c3-d304fd94ff3b@intel.com>
Date:   Wed, 26 Feb 2020 12:41:09 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <a9c4b363-1569-f03e-6155-a869dd186ced@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/25/2020 4:58 PM, Jacob Keller wrote:
> On 2/25/2020 4:42 PM, Sean Christopherson wrote>> So there's something
> weird going on. Maybe "boot_cpu_has" in the
>>> vmx_disabled_by_bios is wrong? Hmm.
>>
>> Hmm, perhaps a bug somewhere else is overwriting the cpufeatures bit for
>> X86_FEATURE_VMX.  Let me see if I can reproduce from net-next.
>>
> 
> If you have any further suggestions for debugging, I'm happy to help try
> to figure this out. To my eyes, it looks like somehow bits get reset...
> It's definitely not clear to me how this happens.
> 
> There is the get_cpu_caps call.. but that seems to correctly call
> apply_forced_caps at the end.
> 
> That's all I have time for today.
> 
> Thanks,
> Jake
> 

Hi,

I kept digging into this, and I added a further print to the get_cpu_cap
function.

It looks like get_cpu_cap is being called again *after*
init_ia32_feat_ctl...

Digging further, I discovered this appears to be the call in setup_pku,
which would only be enabled for systems which have X86_FEATURE_PKU
enabled and supported. It's quite likely that test systems may not have
had this feature, hence why it went undetected till now.

Because of the extra get_cpu_cap call, the capabilities are reset. Since
we never use setup_clear_cpu_cap or pass NULL to clear_cpu_cap, the code
that sets the global cpu_caps_cleared bits is not run.

It's not clear to me what the best fix for this is.

Perhaps init_ia32_feat_ctl should be something run during
early_identify_cpu, since it's really checking global status (rdmsr),
and not per-CPU status. And then it could directly operate to call
setup_clear_cpu_cap, which would properly clear the bit globally,
ensuring that apply_forced_caps kicks in?

Or this needs to somehow be run *after* setup_pku? But that doesn't feel
very robust.

Thanks,
Jake
