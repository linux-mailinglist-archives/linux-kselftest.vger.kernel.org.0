Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB6B2D2FA8
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Dec 2020 17:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgLHQ1n (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Dec 2020 11:27:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49409 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729003AbgLHQ1m (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Dec 2020 11:27:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607444776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s+R+jRzAFwicuadN4vog+Ca45tK3uOJpXnQFZKOAyJg=;
        b=foELgZQqjkiHBw/NS9pd1xg/1Af+dkOzmv8aPPIhVWtsnrY1YnQ+lbl2Lpd1AMOKY8kSpa
        VPCkgbfIL5pJaxLdd7URGzITmV1mINjFA1WHvtdm7hZpDzSV1WklB6ZxxywHId4SLZ01mU
        kG4S6UjjLEDrN/pxuEu5P1gWmngvKwY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-gybUFmcCPDiqhM78McKTdQ-1; Tue, 08 Dec 2020 11:26:12 -0500
X-MC-Unique: gybUFmcCPDiqhM78McKTdQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E7C8814703;
        Tue,  8 Dec 2020 16:25:46 +0000 (UTC)
Received: from starship (unknown [10.35.206.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 776EF27CAC;
        Tue,  8 Dec 2020 16:25:27 +0000 (UTC)
Message-ID: <6f64558a029574444da417754786f711c2fec407.camel@redhat.com>
Subject: Re: [PATCH v2 1/3] KVM: x86: implement KVM_{GET|SET}_TSC_STATE
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marcelo Tosatti <mtosatti@redhat.com>
Cc:     kvm@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Oliver Upton <oupton@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Date:   Tue, 08 Dec 2020 18:25:13 +0200
In-Reply-To: <87sg8g2sn4.fsf@nanos.tec.linutronix.de>
References: <20201203171118.372391-1-mlevitsk@redhat.com>
         <20201203171118.372391-2-mlevitsk@redhat.com>
         <20201207232920.GD27492@fuller.cnet>
         <05aaabedd4aac7d3bce81d338988108885a19d29.camel@redhat.com>
         <87sg8g2sn4.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 2020-12-08 at 17:02 +0100, Thomas Gleixner wrote:
> On Tue, Dec 08 2020 at 16:50, Maxim Levitsky wrote:
> > On Mon, 2020-12-07 at 20:29 -0300, Marcelo Tosatti wrote:
> > > > +This ioctl allows to reconstruct the guest's IA32_TSC and TSC_ADJUST value
> > > > +from the state obtained in the past by KVM_GET_TSC_STATE on the same vCPU.
> > > > +
> > > > +If 'KVM_TSC_STATE_TIMESTAMP_VALID' is set in flags,
> > > > +KVM will adjust the guest TSC value by the time that passed since the moment
> > > > +CLOCK_REALTIME timestamp was saved in the struct and current value of
> > > > +CLOCK_REALTIME, and set the guest's TSC to the new value.
> > > 
> > > This introduces the wraparound bug in Linux timekeeping, doesnt it?
> 
> Which bug?
> 
> > It does.
> > Could you prepare a reproducer for this bug so I get a better idea about
> > what are you talking about?
> > 
> > I assume you need very long (like days worth) jump to trigger this bug
> > and for such case we can either work around it in qemu / kernel 
> > or fix it in the guest kernel and I strongly prefer the latter.
> > 
> > Thomas, what do you think about it?
> 
> For one I have no idea which bug you are talking about and if the bug is
> caused by the VMM then why would you "fix" it in the guest kernel.

The "bug" is that if VMM moves a hardware time counter (tsc or anything else) 
forward by large enough value in one go, 
then the guest kernel will supposingly have an overflow in the time code.
I don't consider this to be a buggy VMM behavior, but rather a kernel
bug that should be fixed (if this bug actually exists)
 
Purely in theory this can even happen on real hardware if for example SMM handler
blocks a CPU from running for a long duration, or hardware debugging
interface does, or some other hardware transparent sleep mechanism kicks in
and blocks a CPU from running.
(We do handle this gracefully for S3/S4)

> 
> Aside of that I think I made it pretty clear what the right thing to do
> is.

This is orthogonal to this issue of the 'bug'. 
Here we are not talking about per-vcpu TSC offsets, something that I said 
that I do agree with you that it would be very nice to get rid of.
 
We are talking about the fact that TSC can jump forward by arbitrary large
value if the migration took arbitrary amount of time, which 
(assuming that the bug is real) can crash the guest kernel.

This will happen even if we use per VM global tsc offset.

So what do you think?

Best regards,
	Maxim Levitsky

> 
> Thanks,
> 
>         tglx
> 


