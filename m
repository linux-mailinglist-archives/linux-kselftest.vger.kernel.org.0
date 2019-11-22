Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD3B107239
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2019 13:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfKVMet (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Nov 2019 07:34:49 -0500
Received: from mail.skyhub.de ([5.9.137.197]:45752 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726985AbfKVMes (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Nov 2019 07:34:48 -0500
Received: from zn.tnic (p200300EC2F0E9700A4FB1BDEE3C09F73.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:9700:a4fb:1bde:e3c0:9f73])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D2DD01EC0D07;
        Fri, 22 Nov 2019 13:34:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1574426087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=dij5MNPx/IwHCLqmKnuYF4M7pmGAodazP5F2XXl3Cs8=;
        b=XGeQmD4UYTJDu20ffLIR31lLxhKYQGLyFnCyFmhO65BmnOS8AQpTG2pF6I6ftZbm5sUj+p
        L+C+VxtDHyXeUZhM1Hzp2OTMT8xd9gZ1Cd/fihs3BuPUt73v76ydlnIBy1LZ5UZDdBYXw9
        KmqHHh11jj2sDKm7WTl8uMy/ui/YgGM=
Date:   Fri, 22 Nov 2019 13:34:40 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 04/19] x86/intel: Initialize IA32_FEATURE_CONTROL MSR
 at boot
Message-ID: <20191122123433.GH6289@zn.tnic>
References: <20191119031240.7779-1-sean.j.christopherson@intel.com>
 <20191119031240.7779-5-sean.j.christopherson@intel.com>
 <20191121103925.GB20907@linux.intel.com>
 <20191121104145.GC20907@linux.intel.com>
 <20191121110533.GD6540@zn.tnic>
 <20191121221234.GE16617@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191121221234.GE16617@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 21, 2019 at 02:12:34PM -0800, Sean Christopherson wrote:
> Any objection to keeping the MSR name as MSR_IA32_FEATURE_CONTOL?  I'd like
> to have some anchor back to the name used in the SDM.
> 
> Any opinions/thoughts on the name of the Kconfig?  Currently it's
> X86_FEATURE_CONTROL_MSR, which gets a bit long with CONFIG_ on the front.
> I also overlooked that we have MSR_MISC_FEATURE_CONTROL, so having IA32 in
> the Kconfig would probably be a good idea.  X86_IA32 is rather redundant,
> so maybe IA32_FEAT_CTL or IA32_FEATURE_CONTROL?

Well, what I'd do is since we have MSR_MISC_FEATURE_CONTROL too, I'd
call all code and defines pertaining to the 0x3a MSR

<bla>_IA32_FEAT_CTL

I.e.,

CONFIG_IA32_FEAT_CTL,
MSR_IA32_FEAT_CTL,
...

and leave a comment over the MSR definition containing the SDM name.

This way, you have a clear distinction between the IA32 and the MISC
feature control.

But this is just me and I realize we're pretty much deep inside the bike
shed. :)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
