Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2832D869C
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Dec 2020 14:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407403AbgLLNEL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 12 Dec 2020 08:04:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394867AbgLLNEF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 12 Dec 2020 08:04:05 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A410CC0613CF;
        Sat, 12 Dec 2020 05:03:24 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607778202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dm0h1kETERLgrH3MYccPKguhl9RAaSD+kQ67+0pK7gQ=;
        b=Ym3dRr/Y+Sb79nbnelKOQlClJALoto3behsFcq1miJktOuA0kzzOVdVcS7UUx0se15/m/t
        wdvP10HVpZpXTGthQrL3UhPTwRqNWAjn3RI4/3+an4yBMaR5kBF9P6VaMjj8XIkiXn6CFe
        kYm6Bd7x/KzQqV8DBtfRgy1lz3PD4DI8Dma4mTgIbJWMUVwdzyqU86OpLKN2f3MULD3jyc
        ZyXN1Vw7dfr6kisWY7hBvz9bCCZG2bZCD099FWS6Uyl3E75nsk3JBisz0hBcGPOkerunbi
        zcEFOeB63/oY/6EuQ2uDCwdts6e87L0ImP/iZ8wdf90bvd4x3Z4TJuMmmEPSWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607778202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dm0h1kETERLgrH3MYccPKguhl9RAaSD+kQ67+0pK7gQ=;
        b=limZ6dagZ2Cmsj35YZ/sv7F5dIwrMyk02ULK2mEBjFv3NwSiZb0GC8oYw4z+0SXtD+K7jO
        /ZCrQTiJ9XcpZVAA==
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org,
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
In-Reply-To: <d9063c37-a965-d5cf-e923-c0c9f6ddc044@redhat.com>
References: <05aaabedd4aac7d3bce81d338988108885a19d29.camel@redhat.com> <87sg8g2sn4.fsf@nanos.tec.linutronix.de> <20201208181107.GA31442@fuller.cnet> <875z5c2db8.fsf@nanos.tec.linutronix.de> <20201209163434.GA22851@fuller.cnet> <87r1nyzogg.fsf@nanos.tec.linutronix.de> <20201210152618.GB23951@fuller.cnet> <87zh2lib8l.fsf@nanos.tec.linutronix.de> <20201211002703.GA47016@fuller.cnet> <87v9d8h3lx.fsf@nanos.tec.linutronix.de> <20201211141822.GA67764@fuller.cnet> <87k0togikr.fsf@nanos.tec.linutronix.de> <d9063c37-a965-d5cf-e923-c0c9f6ddc044@redhat.com>
Date:   Sat, 12 Dec 2020 14:03:22 +0100
Message-ID: <87lfe3fa79.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Dec 11 2020 at 22:59, Paolo Bonzini wrote:
> On 11/12/20 22:04, Thomas Gleixner wrote:
> The nanosecond and TSC times are sent as part of the paused-VM state at 
> the very end of the live migration process.
>
> So it's still true that the time advances during live migration 
> brownout; 0.1 seconds is just the final part of the live migration 
> process.  But for _live_ migration there is no need to design things 
> according to "people are happy if their clock is off by 0.1 seconds 
> only".

The problem is not the 0.1 second jump of the TSC. That's just a minor
nuisance. The problem is the incorrectness of CLOCK_REALTIME after this
operation which is far larger than 0.1s and this needs to be fixed.

> Again, save-to-disk, reverse debugging and the like are a different
> story, which is why KVM should delegate policy to userspace (while
> documenting how to do it right).

One ready to use option would be suspend to idle. It's fast and readily
available including all the notifications and kernel side handling of
time and whatever.

Thanks,

        tglx
