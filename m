Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B401E2D170E
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Dec 2020 18:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbgLGRBp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Dec 2020 12:01:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44030 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726890AbgLGRBp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Dec 2020 12:01:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607360418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SV/hIsDwJYVX6YU/tL2dTTOcKgpjOzj0CM+MQSPzMH4=;
        b=gfyM+TiN/EZiJ/KTA6z0vr2fIW5+SFgzI5ATe/S7dKsw/Z4loeo0BkS9vDrMDPuLItSelx
        0nyPA1/Ap2f7s/4+E/SH0smoG3U7QrXsnUJo73ONamgq6gJoA2tss8T5/Tx6CEIAPzyVvp
        yhBmyuVksVR5h2wH4v1bBn7Crv2Qi5M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-18tooxLWMoi3xlNtL3C4cQ-1; Mon, 07 Dec 2020 12:00:17 -0500
X-MC-Unique: 18tooxLWMoi3xlNtL3C4cQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C4BD100E421;
        Mon,  7 Dec 2020 17:00:13 +0000 (UTC)
Received: from starship (unknown [10.35.206.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA79B60BD8;
        Mon,  7 Dec 2020 17:00:02 +0000 (UTC)
Message-ID: <636fecc20b0143128b484f159ff795ff65d05b82.camel@redhat.com>
Subject: Re: [PATCH v2 1/3] KVM: x86: implement KVM_{GET|SET}_TSC_STATE
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     kvm@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Oliver Upton <oupton@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Date:   Mon, 07 Dec 2020 19:00:01 +0200
In-Reply-To: <905DFDCE-71A5-4711-A31B-9FCFEA2CFC52@amacapital.net>
References: <87a6up606r.fsf@nanos.tec.linutronix.de>
         <905DFDCE-71A5-4711-A31B-9FCFEA2CFC52@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 2020-12-07 at 08:53 -0800, Andy Lutomirski wrote:
> > On Dec 7, 2020, at 8:38 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > 
> > ﻿On Mon, Dec 07 2020 at 14:16, Maxim Levitsky wrote:
> > > > On Sun, 2020-12-06 at 17:19 +0100, Thomas Gleixner wrote:
> > > > From a timekeeping POV and the guests expectation of TSC this is
> > > > fundamentally wrong:
> > > > 
> > > >      tscguest = scaled(hosttsc) + offset
> > > > 
> > > > The TSC has to be viewed systemwide and not per CPU. It's systemwide
> > > > used for timekeeping and for that to work it has to be synchronized. 
> > > > 
> > > > Why would this be different on virt? Just because it's virt or what? 
> > > > 
> > > > Migration is a guest wide thing and you're not migrating single vCPUs.
> > > > 
> > > > This hackery just papers over he underlying design fail that KVM looks
> > > > at the TSC per vCPU which is the root cause and that needs to be fixed.
> > > 
> > > I don't disagree with you.
> > > As far as I know the main reasons that kvm tracks TSC per guest are
> > > 
> > > 1. cases when host tsc is not stable 
> > > (hopefully rare now, and I don't mind making
> > > the new API just refuse to work when this is detected, and revert to old way
> > > of doing things).
> > 
> > That's a trainwreck to begin with and I really would just not support it
> > for anything new which aims to be more precise and correct.  TSC has
> > become pretty reliable over the years.
> > 
> > > 2. (theoretical) ability of the guest to introduce per core tsc offfset
> > > by either using TSC_ADJUST (for which I got recently an idea to stop
> > > advertising this feature to the guest), or writing TSC directly which
> > > is allowed by Intel's PRM:
> > 
> > For anything halfways modern the write to TSC is reflected in TSC_ADJUST
> > which means you get the precise offset.
> > 
> > The general principle still applies from a system POV.
> > 
> >     TSC base (systemwide view) - The sane case
> > 
> >     TSC CPU  = TSC base + TSC_ADJUST
> > 
> > The guest TSC base is a per guest constant offset to the host TSC.
> > 
> >     TSC guest base = TSC host base + guest base offset
> > 
> > If the guest want's this different per vCPU by writing to the MSR or to
> > TSC_ADJUST then you still can have a per vCPU offset in TSC_ADJUST which
> > is the offset to the TSC base of the guest.
> 
> How about, if the guest wants to write TSC_ADJUST, it can turn off all paravirt features and keep both pieces?
> 

This is one of the things I had in mind recently.

Even better, we can stop advertising TSC_ADJUST in CPUID to the guest 
and forbid it from writing it at all.

And if the guest insists and writes to the TSC itself, 
then indeed let it keep both pieces (or invoke some failback code).
 
I have nothing against this solution.


Best regards,
	Maxim Levitsky


