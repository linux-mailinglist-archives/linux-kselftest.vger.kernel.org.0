Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E72C11CF5A
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2019 15:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbfLLOIG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Dec 2019 09:08:06 -0500
Received: from mail.skyhub.de ([5.9.137.197]:34760 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729529AbfLLOIE (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Dec 2019 09:08:04 -0500
Received: from zn.tnic (p200300EC2F0A5A0074DA66A3488432B7.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:5a00:74da:66a3:4884:32b7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DD9531EC0CF2;
        Thu, 12 Dec 2019 15:08:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1576159682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=NsGklImh4vHVCyOymFTYnrXanEPRgUlIlWs7cbNiu6U=;
        b=iN08be9/huQMl+iEiScV/paCVRtsQQsrwRQWEmnmeKWF4TaYjWL7tcPT5X+/ES58fRlVVr
        kVIPZMR1e7Ps9ywEugeQgXrEl7h2CEDePKINMyshMRNHt9sa+VGG79bGrKQmN89cCwLwTn
        R7BunpK0TFmEoQOUB8O2Au8IIAXvGhQ=
Date:   Thu, 12 Dec 2019 15:07:55 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
Subject: Re: [PATCH v4 00/19] x86/cpu: Clean up handling of VMX features
Message-ID: <20191212140755.GF4991@zn.tnic>
References: <20191128014016.4389-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191128014016.4389-1-sean.j.christopherson@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 27, 2019 at 05:39:57PM -0800, Sean Christopherson wrote:
> Clean up a handful of interrelated warts in the kernel's handling of VMX:
> 
>   - Enable VMX in IA32_FEATURE_CONTROL during boot instead of on-demand
>     during KVM load to avoid future contention over IA32_FEATURE_CONTROL.
> 
>   - Rework VMX feature reporting so that it is accurate and up-to-date,
>     now and in the future.
> 
>   - Consolidate code across CPUs that support VMX.

Ok, this is shaping up slowly to be upstream-ready, AFAICT.

How are we merging the next revision, after the minor things have been
taken care of? Through tip?

Paolo?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
