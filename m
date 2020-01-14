Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBA313A3D7
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2020 10:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgANJbn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Jan 2020 04:31:43 -0500
Received: from mail.skyhub.de ([5.9.137.197]:46818 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbgANJbn (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Jan 2020 04:31:43 -0500
Received: from zn.tnic (p200300EC2F0C7700ADC3CAC9BB95AB92.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:7700:adc3:cac9:bb95:ab92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A64AF1EC0C76;
        Tue, 14 Jan 2020 10:31:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1578994301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=oVOv19JYih/7QBdhQIDrcxH7dJf1wRTSDlsNoAXaOY4=;
        b=Op5S07B1bBe9uvsJbhwmhBQEjTQO/NCR8xUCHou3ZSrFKAX+wG5Tf6vbvL+7qyFBL/OmxC
        PHOEsU9albCCnI2LsgCfGkS94dnIF/pSH1b+TKBWi8bA+gpaWrVZWGaixC6QAc9QstNw5e
        AZNv5TI9m4WNJxduf+OlljIIB6zhMPk=
Date:   Tue, 14 Jan 2020 10:31:38 +0100
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
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: Re: [PATCH] KVM: VMX: Rename define to CPU_BASED_USE_TSC_OFFSETTING
Message-ID: <20200114093138.GB31032@zn.tnic>
References: <20191221044513.21680-1-sean.j.christopherson@intel.com>
 <20191221044513.21680-18-sean.j.christopherson@intel.com>
 <20200113183228.GO13310@zn.tnic>
 <20200113183705.GL1175@linux.intel.com>
 <20200113183823.GP13310@zn.tnic>
 <20200113184217.GA2216@linux.intel.com>
 <20200113185216.GQ13310@zn.tnic>
 <20200113201610.GE2322@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200113201610.GE2322@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 13, 2020 at 12:16:10PM -0800, Sean Christopherson wrote:
> On Mon, Jan 13, 2020 at 07:52:16PM +0100, Borislav Petkov wrote:
> > On Mon, Jan 13, 2020 at 10:42:17AM -0800, Sean Christopherson wrote:
> > > > Doesn't bother me, I could do it in a patch ontop. But your call.
> > > 
> > > No objection here.
> > 
> > Something like this:
> > 
> > ---
> > From: Borislav Petkov <bp@suse.de>
> > 
> > ... so that "offsetting" is spelled the same as the respective VMX feature
> > bit VMX_FEATURE_TSC_OFFSETTING.
> > 
> > No functional changes.
> > 
> > Signed-off-by: Borislav Petkov <bp@suse.de>
> > ---
> 
> Reviewed-and-tested-by: Sean Christopherson <sean.j.christopherson@intel.com>

Yah, so I tried to do a test-merge with linux-next to see what surprises should
I be prepared for and there's the first one:

5e3d394fdd9e ("KVM: VMX: Fix the spelling of CPU_BASED_USE_TSC_OFFSETTING")

which is already in Paolo's tree. Dropping it on my side.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
