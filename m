Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6143411D55E
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2019 19:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730334AbfLLSY6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Dec 2019 13:24:58 -0500
Received: from mail.skyhub.de ([5.9.137.197]:45940 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730387AbfLLSY6 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Dec 2019 13:24:58 -0500
Received: from zn.tnic (p200300EC2F0A5A0010289BED6992E3B4.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:5a00:1028:9bed:6992:e3b4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0F9D91EC0D00;
        Thu, 12 Dec 2019 19:24:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1576175096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2TIUuWa9aevx3nEsXKaaJadXZODvPPCYg3qJs/3YyTc=;
        b=RUPwEtc2CyutYOTrS9uUbw0IzlfZzeDWyGpy0WBgpf3SauLu0oZsdtWZ3BZQsU2nKP7gGj
        5/E6w07e/8PMng4lFhpGy3IG+UdEDJzSUlUV+xwqgXfC9rCs1iaXMv0tJjXB5yIIkPKYm/
        5k0uPzwn4ZqpQ4gImaqfM5EdnwounOs=
Date:   Thu, 12 Dec 2019 19:24:55 +0100
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
        Len Brown <lenb@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: Re: [PATCH v4 10/19] x86/cpu: Detect VMX features on Intel, Centaur
 and Zhaoxin CPUs
Message-ID: <20191212182455.GH4991@zn.tnic>
References: <20191128014016.4389-1-sean.j.christopherson@intel.com>
 <20191128014016.4389-11-sean.j.christopherson@intel.com>
 <20191212113838.GD4991@zn.tnic>
 <20191212175511.GG3163@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191212175511.GG3163@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 12, 2019 at 09:55:11AM -0800, Sean Christopherson wrote:
> The reasoning behind using vanilla rdmsr() on PROC and PIN controls is that
> those MSRs should exist on any CPU that supports VMX, i.e. we want the WARN.
> 
> The alternative would be to use rdmsr_safe() for everything and then
> explicitly disable VMX if a fault on PROC or PIN occurs, but that circles
> us back to the handling a fault on rdmsr(MSR_IA32_FEAT_CTL), i.e. is it
> really worth gracefully handling a fault that should never occur?

No but pls put a comment above it explaining why we're doing rdmsr()
only with those two MSRs.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
