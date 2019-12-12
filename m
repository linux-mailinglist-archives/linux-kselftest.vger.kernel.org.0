Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7EC11D5A4
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2019 19:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730452AbfLLSco (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Dec 2019 13:32:44 -0500
Received: from mail.skyhub.de ([5.9.137.197]:47250 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730211AbfLLSco (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Dec 2019 13:32:44 -0500
Received: from zn.tnic (p200300EC2F0A5A0010289BED6992E3B4.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:5a00:1028:9bed:6992:e3b4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 62E201EC01AD;
        Thu, 12 Dec 2019 19:32:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1576175562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1vhjna/rh+rVgKI+zkzgMfp5mWRrD9pxqEOzOJXpA4Y=;
        b=kzsW8/3fnaWojTpWx+xOZuFE5jkvWcgtWb0zHWdGQvHha8Z3n16k6oLdIOkrt3LZWH/mbE
        40RXHatBBtsZbAG2t/5SMWP8ndSe6ntSi7+6wLxah6GSy4g0pqbbHSZpsh98GMHiVzGYvm
        Z5LGh7kWizRyKULfw1bLYt/9PqDVdYU=
Date:   Thu, 12 Dec 2019 19:32:41 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Liran Alon <liran.alon@oracle.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
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
Message-ID: <20191212183241.GI4991@zn.tnic>
References: <20191128014016.4389-1-sean.j.christopherson@intel.com>
 <20191128014016.4389-12-sean.j.christopherson@intel.com>
 <20191212122646.GE4991@zn.tnic>
 <d0b21e7e-69f5-09f9-3e1c-14d49fa42b9f@redhat.com>
 <4A24DE75-4E68-4EC6-B3F3-4ACB0EE82BF0@oracle.com>
 <17c6569e-d0af-539c-6d63-f4c07367d8d1@redhat.com>
 <20191212174357.GE3163@linux.intel.com>
 <52dd758d-a590-52a6-4248-22d6852b75cd@redhat.com>
 <DA429131-7A4C-4B74-A020-6CE7622ED2F8@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DA429131-7A4C-4B74-A020-6CE7622ED2F8@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 12, 2019 at 07:52:55PM +0200, Liran Alon wrote:
> Why should CPU VMX features be treated differently than standard CPUID
> deduced features? CPU SVM features are also present in /proc/cpuinfo
> today (Because they are deduced from CPUID leafs). So it should be
> similar.

Well, VMX features are not CPUID bits apparently because <reasons>. And
Intel hw folk will give you a bunch, I bet. So Sean needs to do all this
dancing to get them to be more usable to other kernel code.

SVM feature bits are proper CPUID bits and this is what the cpufeatures
glue does - mirro CPUID bits, mainly.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
