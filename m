Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9CA1050D5
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2019 11:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfKUKpp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Nov 2019 05:45:45 -0500
Received: from mga14.intel.com ([192.55.52.115]:47098 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfKUKpo (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Nov 2019 05:45:44 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2019 02:45:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,224,1571727600"; 
   d="scan'208";a="408473585"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.162])
  by fmsmga006.fm.intel.com with ESMTP; 21 Nov 2019 02:45:38 -0800
Date:   Thu, 21 Nov 2019 12:45:38 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
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
        linux-kselftest@vger.kernel.org, Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v3 05/19] x86/mce: WARN once if IA32_FEATURE_CONTROL MSR
 is left unlocked
Message-ID: <20191121104538.GD20907@linux.intel.com>
References: <20191119031240.7779-1-sean.j.christopherson@intel.com>
 <20191119031240.7779-6-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119031240.7779-6-sean.j.christopherson@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 18, 2019 at 07:12:26PM -0800, Sean Christopherson wrote:
> WARN if the IA32_FEATURE_CONTROL MSR is somehow left unlocked now that
> CPU initialization unconditionally locks the MSR.
> 
> Reviewed-by: Borislav Petkov <bp@suse.de>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kernel/cpu/mce/intel.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
> index 3e5b29acd301..5abc55a67fce 100644
> --- a/arch/x86/kernel/cpu/mce/intel.c
> +++ b/arch/x86/kernel/cpu/mce/intel.c
> @@ -119,11 +119,10 @@ static bool lmce_supported(void)
>  	 * generate a #GP fault.
>  	 */
>  	rdmsrl(MSR_IA32_FEATURE_CONTROL, tmp);
> -	if ((tmp & (FEAT_CTL_LOCKED | FEAT_CTL_LMCE_ENABLED)) ==
> -		   (FEAT_CTL_LOCKED | FEAT_CTL_LMCE_ENABLED))
> -		return true;

I'd add a prepending comment:

/*
 * FEAT_CTL_LOCKED should have been always set either by
 * BIOS before handover to the kernel or init_feature_control_msr().
 */

> +	if (WARN_ON_ONCE(!(tmp & FEAT_CTL_LOCKED)))
> +		return false;
>  
> -	return false;
> +	return tmp & FEAT_CTL_LMCE_ENABLED;
>  }
>  
>  bool mce_intel_cmci_poll(void)
> -- 
> 2.24.0
> 

/Jarkko
