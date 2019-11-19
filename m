Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81CB01022B7
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2019 12:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbfKSLPP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Nov 2019 06:15:15 -0500
Received: from mail.skyhub.de ([5.9.137.197]:50036 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbfKSLPO (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Nov 2019 06:15:14 -0500
Received: from zn.tnic (p200300EC2F0EDC00DDCC46785D6B318A.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:dc00:ddcc:4678:5d6b:318a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ED7521EC0CAF;
        Tue, 19 Nov 2019 12:15:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1574162113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=G8bIPI7eMqwT4OGw64KYwiD4+/Nz3AJ6bpqyvoHxzGE=;
        b=TCAKKh4JmkRfTPQI9eYekH1jkcNRfLWs2H7MPLEUB7wha5+Lq494+gA97L1SeLaGW53dkj
        7lYAoRjzC4VBvHeUtDK5doEfPxgW2MvVKPiGQpKSb83sxjMbFd2mMgulnY9OmgO7vGuqPs
        5EISsFBde5P8qseJj7C9XA9+xybjNJw=
Date:   Tue, 19 Nov 2019 12:15:08 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
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
Subject: Re: [PATCH v3 01/19] x86/msr-index: Clean up bit defines for
 IA32_FEATURE_CONTROL MSR
Message-ID: <20191119111445.GB27787@zn.tnic>
References: <20191119031240.7779-1-sean.j.christopherson@intel.com>
 <20191119031240.7779-2-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191119031240.7779-2-sean.j.christopherson@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 18, 2019 at 07:12:22PM -0800, Sean Christopherson wrote:
> As pointed out by Boris, the defines for bits in IA32_FEATURE_CONTROL
> are quite a mouthful, especially the VMX bits which must differentiate
> between enabling VMX inside and outside SMX (TXT) operation.  Rename the
> bit defines to abbreviate FEATURE_CONTROL as FEAT_CTL so that they're a
> little friendlier on the eyes.  Keep the full name for the MSR itself to
> help even the most obtuse reader decipher the abbreviation, and to match
> the name used by the Intel SDM.
> 
> Opportunistically fix a few other annoyances with the defines:
> 
>   - Relocate the bit defines so that they immediately follow the MSR
>     define, e.g. aren't mistaken as belonging to MISC_FEATURE_CONTROL.
>   - Add whitespace around the block of feature control defines to make
>     it clear that FEAT_CTL is indeed short for FEATURE_CONTROL.
>   - Use BIT() instead of manually encoding the bit shift.
>   - Use "VMX" instead of "VMXON" to match the SDM.
>   - Append "_ENABLED" to the LMCE bit to be consistent with the verbiage
>     used for all other feature control bits.  (LCME is an acronym for
>     Local Machine Check Exception, i.e. LMCE_ENABLED is not redundant).

Sure but SDM calls it LMCE_ON. What is our current decision on sticking
to SDM bit names? I guess we don't...

But above you say "to match the SDM"...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
