Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B94FF107772
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2019 19:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfKVSgv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Nov 2019 13:36:51 -0500
Received: from mail.skyhub.de ([5.9.137.197]:43416 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfKVSgv (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Nov 2019 13:36:51 -0500
Received: from zn.tnic (p200300EC2F0E9700A48BABEEDD6DAF21.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:9700:a48b:abee:dd6d:af21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9553A1EC0D10;
        Fri, 22 Nov 2019 19:36:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1574447810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=HMSU9Xydk8abl1JlFkFtJ/93zWBcyPUfQJWiMtpcCDE=;
        b=NS48qkmTy9utcj/PJjvFgh/ujJyq/dIHELfhgCKZQqYLU/9kHXwsisAhYv9pfsV/hx5w1f
        uc0Gq4BJu1pvUWwe3YD6RSc4EITTrLqn5xR+e6IgzWTAcQ/9vy/A6k0dbDVGarIRnQ5nc9
        KVwMKAjJyHy3oi5F+kCVCDEi4kqAiRA=
Date:   Fri, 22 Nov 2019 19:36:41 +0100
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
Subject: Re: [PATCH v3 12/19] x86/vmx: Introduce VMX_FEATURES_*
Message-ID: <20191122183641.GJ6289@zn.tnic>
References: <20191119031240.7779-1-sean.j.christopherson@intel.com>
 <20191119031240.7779-13-sean.j.christopherson@intel.com>
 <20191121165250.GK6540@zn.tnic>
 <20191121215017.GC16617@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191121215017.GC16617@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 21, 2019 at 01:50:17PM -0800, Sean Christopherson wrote:
> I actually don't want to use cpu_has() for the VMX features, which is
> why I put these in a separate array (one of the future patches).
>  
> The motivation is purely for /proc/cpuinfo.  Currently there is no sane
> way for a user to query the capabilities of their platform.  The issue
> comes up on a fairly regular basis, e.g. when trying to find a platform
> to test a new feature or to debug an issue that has a hardware dependency.
> 
> Lack of reporting is especially annoying when the end user isn't familiar
> with VMX, e.g. the format of the MSRs is non-standard, existence of some
> MSRs is reported by bits in other MSRs, several features from KVM's point
> of view are actually enumerated as 3+ separate features by hardware, etc...
> 
> Punting to a userspace utility isn't a viable option because all of the
> capabilities are reported via MSRs.

Ok, this justification was missing in the commit message, please add the
gist of it so that it is clear why we're doing it. And yes, I agree that
having a single concentrated place for feature bits which you otherwise
have to painstakingly extract from a bunch of MSRs make sense.

> As for why I want to keep these out of cpu_has()... VMX has a concept of
> features being fixed "on", e.g. early CPUs don't allow disabling off CR3
> interception.  A cpu_has() approach doesn't work well since it loses the
> information regarding which bits are fixed-1.  KVM also has several module
> params that can be used to disable use of features, i.e. we don't want
> cpu_has() for VMX features because the KVM-specific variables need to be
> the canonical reference.

Well, you can use the cpu_has() machinery for stuff like that too - we
can clear bits there too: clear_cpu_cap() - and since clearing those
bits are only for /proc/cpuinfo reporting, it's not like anything would
break if that flag is gone. Just saying, in case you want to use the
machinery for that.

And that would avoid some of the duplication of having KVM-specific
variables *and* VMX_FEATURE_* flags, where latter are not really
toggleable but only for /proc/cpuinfo. Especially if you wanna enforce
"developers to define a VMX_FEATURE flag when adding support for a new
hardware feature."

> Alternatively, what about adding "vmx flags" but keeping the existing
> synthetic flags?  That'd mean having duplicates for tpr_shadow, vnmi, ept,
> flexpriority, vpi and ept_ad.  On the plus side, we'd cap the pollution of
> "flags" at those six features.

Yap, this is how you avoid ABI breakage. Makes sense to me.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
