Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0B6D2D6B06
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Dec 2020 00:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394160AbgLJWbV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Dec 2020 17:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405146AbgLJW3A (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Dec 2020 17:29:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277ACC0613CF;
        Thu, 10 Dec 2020 14:28:20 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607639295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5JXJwtEkjhQ2j1nMo0rZ0tKIkox0eioh2DmsOZzS29k=;
        b=K5XohMhBOgVh/+BhSecz9sGmDkaKhH1kIY4hAnFw8WZsbemLNcOLwUcZyuRRs76h2IKwGP
        nXPwMApeFnAdIbshcAUreyO+LOaPo4bqxOZIKYIHwQpJMaKkiD8zR+/QNf8cZLwFo8rXQH
        EGoU2UF1CuRZuWKrzxnbb1krHN5w0LLJURFOS9QELofDgOUNhDst12fWxFvDITFqTGGqbf
        TD2BXjf1rcUT7B83dUk7JN3fTMu1wO5dDjeLGhPgoiCXpuFe1x8XMty6UGRpnShs34m1g1
        OACbDwSQjbRPDrnCd+pf7erHCVnS8hwUszf2BlUfKVRp4AhOLDX9IK8FNNBLMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607639295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5JXJwtEkjhQ2j1nMo0rZ0tKIkox0eioh2DmsOZzS29k=;
        b=wosRE4ov71xbZGCc2alIw/KDqCUomK8F5wQDNSFm0uS5ZC0uucMj4H4Y3r2oE/i/eVxQXv
        rpSewJInNFfbbtCA==
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "open list\:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
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
In-Reply-To: <CALCETrXXH5GoaSZwSPy-JFxJ6iMMCj0A=yFFPuyutBh+1imCsQ@mail.gmail.com>
References: <9389c1198da174bcc9483d6ebf535405aa8bdb45.camel@redhat.com> <E4F263BE-6CAA-4152-8818-187D34D8D0FD@amacapital.net> <87360djqve.fsf@nanos.tec.linutronix.de> <CALCETrXXH5GoaSZwSPy-JFxJ6iMMCj0A=yFFPuyutBh+1imCsQ@mail.gmail.com>
Date:   Thu, 10 Dec 2020 23:28:14 +0100
Message-ID: <87v9d9i9dt.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 10 2020 at 14:01, Andy Lutomirski wrote:
> On Thu, Dec 10, 2020 at 1:25 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>> I'm still convinced that a notification about 'we take a nap' will be
>> more robust, less complex and more trivial to backport.
>
> What do you have in mind?  Suppose the host kernel sends the guest an
> interrupt on all vCPUs saying "I'm about to take a nap".  What happens
> if the guest is busy with IRQs off for a little bit?  Does the host
> guarantee the guest a certain about of time to try to get the
> interrupt delivered before allowing the host to enter S3?  How about
> if the host wants to reboot for a security fix -- how long is a guest
> allowed to delay the process?
>
> I'm sure this can all be made to work 99% of time, but I'm a bit
> concerned about that last 1%.

Seriously?

If the guest has interrupts disabled for ages, i.e. it went for out for
lunch on its own, then surely the hypervisor can just pull the plug and
wreckage it. It's like you hit the reset button or pull the powerplug of
the machine which is not responding anymore.

Reboot waits already today for guests to shut down/hibernate/supsend or
whatever they are supposed to do. systemd sits there and waits for
minutes until it decides to kill them. Just crash a guest kernel and
forget to reset or force power off the guest before you reboot the
host. Twiddle thumbs for a while and watch the incomprehensible time
display.

If your security fix reboot is so urgent that it can't wait then just
pull the plug and be done with it, i.e. kill the guest which makes it
start from a known state which is a gazillion times better than bringing
it into a state which it can't handle anymore.

Again, that's not any different than hitting the reset button on the
host or pulling and reinserting the host powerplug which you would do
anyway in an emergency case.

Can we please focus on real problems instead of making up new ones?

Correctness of time is a real problem despite the believe of virt folks
that it can be ignored or duct taped to death.

Thanks,

        tglx
