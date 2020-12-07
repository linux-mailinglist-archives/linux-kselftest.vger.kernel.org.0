Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A91052D168B
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Dec 2020 17:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725814AbgLGQjT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Dec 2020 11:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgLGQjT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Dec 2020 11:39:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBD2C061749;
        Mon,  7 Dec 2020 08:38:38 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607359117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7l+UILr+JWHc8AnnfIEx57njnbogruA/YdmfJ48nOWQ=;
        b=QEWCmfVg9WQzZxZMjjUfHb5J5LLN4FF5IbRC778foF8tzrzme+wn/5z/gtWeGMRX3M/d0V
        06fmWGoVGLJrU4SCAa2kQbzP6hoZvrOYOtVOTrch/w4572yosLo3+qcAmdLs/oFrdj9nX0
        jvC0TiIEdN9b5Igp1mw/hR3D5TRAdcobKVaUHdK54ZCgFEDZrdUC4VHat/caLcAPxr4SKK
        Xt9scgAfUS3OTX9eRkTA+s8gB/tbxwxlzMtVTaDc+rs2hBI3G4kFp66JX0CaBioW8PxE5A
        4jFVRqBZ4ohR1Mix2mfhqLCPPhtZ0qBiwbAoydPgyNmAIrhJFHysMKhY+1EgRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607359117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7l+UILr+JWHc8AnnfIEx57njnbogruA/YdmfJ48nOWQ=;
        b=Jl8yYrpCp9vwJobQHJttjXxAiqDTAdR0IBiu1qjmf4qFl/smdAMHpC8SOO7ort40g7LE1V
        YkLLDTF8x0m0JmCw==
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "open list\:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer\:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Oliver Upton <oupton@google.com>,
        "open list\:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] KVM: x86: implement KVM_{GET|SET}_TSC_STATE
In-Reply-To: <1dbbeefc7c76c259b55582468ccd3aab35a6de60.camel@redhat.com>
References: <20201203171118.372391-1-mlevitsk@redhat.com> <20201203171118.372391-2-mlevitsk@redhat.com> <87a6uq9abf.fsf@nanos.tec.linutronix.de> <1dbbeefc7c76c259b55582468ccd3aab35a6de60.camel@redhat.com>
Date:   Mon, 07 Dec 2020 17:38:36 +0100
Message-ID: <87a6up606r.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Dec 07 2020 at 14:16, Maxim Levitsky wrote:
> On Sun, 2020-12-06 at 17:19 +0100, Thomas Gleixner wrote:
>> From a timekeeping POV and the guests expectation of TSC this is
>> fundamentally wrong:
>> 
>>       tscguest = scaled(hosttsc) + offset
>> 
>> The TSC has to be viewed systemwide and not per CPU. It's systemwide
>> used for timekeeping and for that to work it has to be synchronized. 
>> 
>> Why would this be different on virt? Just because it's virt or what? 
>> 
>> Migration is a guest wide thing and you're not migrating single vCPUs.
>> 
>> This hackery just papers over he underlying design fail that KVM looks
>> at the TSC per vCPU which is the root cause and that needs to be fixed.
>
> I don't disagree with you.
> As far as I know the main reasons that kvm tracks TSC per guest are
>
> 1. cases when host tsc is not stable 
> (hopefully rare now, and I don't mind making
> the new API just refuse to work when this is detected, and revert to old way
> of doing things).

That's a trainwreck to begin with and I really would just not support it
for anything new which aims to be more precise and correct.  TSC has
become pretty reliable over the years.

> 2. (theoretical) ability of the guest to introduce per core tsc offfset
> by either using TSC_ADJUST (for which I got recently an idea to stop
> advertising this feature to the guest), or writing TSC directly which
> is allowed by Intel's PRM:

For anything halfways modern the write to TSC is reflected in TSC_ADJUST
which means you get the precise offset.

The general principle still applies from a system POV.

     TSC base (systemwide view) - The sane case

     TSC CPU  = TSC base + TSC_ADJUST

The guest TSC base is a per guest constant offset to the host TSC.

     TSC guest base = TSC host base + guest base offset

If the guest want's this different per vCPU by writing to the MSR or to
TSC_ADJUST then you still can have a per vCPU offset in TSC_ADJUST which
is the offset to the TSC base of the guest.

    TSC guest CPU = TSC guest base + CPU TSC_ADJUST

==>

    TSC guest CPU = TSC host base + guest base offset + CPU TSC_ADJUST

The normal and sane case is just TSC_ADJUST == 0.

It's very cleanly decomposable.

Thanks,

        tglx
