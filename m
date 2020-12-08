Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F652D312A
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Dec 2020 18:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbgLHReg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Dec 2020 12:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgLHReg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Dec 2020 12:34:36 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8473CC0613D6
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Dec 2020 09:33:55 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id q75so3097746wme.2
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Dec 2020 09:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=prv6QXAjwXmx7X2n72Rz/QqUHHpEtIXIiLJUnnkHbR0=;
        b=uXqAktZWSUW4BB2xkW70Q7Y0knpgm8Ya3oLIOqAeMxBdX54aZro6l5hGEy2/ScF132
         B4SjN5eepkt1FLiQE+gKv+yD+8A0BJMTRqluag6GgEWseNrnd5oy7frSgWgbBKzZN3YS
         UExoJ9ya1dr2M+wcvHfV5D/VDXcMvrNRViSjYDvslwVRFof4M0we9OhGSjTDU3qYEkEb
         cPHh2qGP1VzyITFEQOLU/1TzrEoYiLxWW+sDzX4PYOCtptCHXTVEP+M9D/Unbbdc3OU9
         H53L6HylG34y/iCr9QrcYx9B98atOECoJXVt16Ecdt2tZsI1ffQ6Rut6doKOioTiHWem
         7VMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=prv6QXAjwXmx7X2n72Rz/QqUHHpEtIXIiLJUnnkHbR0=;
        b=LS7ReZengErET9VDcgJ1ikcwiWAc2Twss6xh7kq71OsiOvph5sqc8a/VzYNn5a6TVk
         UHhT5nRebm2W3U73xT2NjzM4vV7V77DNSUaJ7qKsiqwohYcy2ddso4V9P//RLgjmIzR6
         11+PtsAqEvHgNGo3nHXR3oiPnUDml0l1bBsGrkrxjMwXS1Fn3jic8i7rj4KLN1f70C5L
         ZYKqqXPWjXyF4hqwkVe7wIbtAw1W8XZ5mcuWe5wpdHMvDCw8/dcWxtdkzmfegk/qyqp2
         k/dk+ORe2ur/vNoNbigseaOh2E4x28fe3q9OYRK+r3q4R4Pw5oTSYRbv0FRzR2DpfEdr
         LAVA==
X-Gm-Message-State: AOAM530+lKXFOPKY4RjUaEA7jze6Sm7fDdTXjOJ3HCiu741h2RoEmKMV
        iYDnAo0OSY0eKG0ZdmrsemQD6q5rWYAQbQEaoSTkmA==
X-Google-Smtp-Source: ABdhPJykbWJPG5N03i1GYewP/i/cBTHGqhNOfixMnBo6i2tP7QSuJaYZ1nvtJPsrNciqblBV72wkgDt1t7DOWW7riNI=
X-Received: by 2002:a1c:7e87:: with SMTP id z129mr4741631wmc.176.1607448834084;
 Tue, 08 Dec 2020 09:33:54 -0800 (PST)
MIME-Version: 1.0
References: <20201203171118.372391-1-mlevitsk@redhat.com> <20201203171118.372391-2-mlevitsk@redhat.com>
 <20201207232920.GD27492@fuller.cnet> <05aaabedd4aac7d3bce81d338988108885a19d29.camel@redhat.com>
 <87sg8g2sn4.fsf@nanos.tec.linutronix.de> <6f64558a029574444da417754786f711c2fec407.camel@redhat.com>
In-Reply-To: <6f64558a029574444da417754786f711c2fec407.camel@redhat.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Tue, 8 Dec 2020 09:33:41 -0800
Message-ID: <CALCETrWKSdro=0YkaamU-RXpa+2sPzBKct4SPi1SmgL2yS62AQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] KVM: x86: implement KVM_{GET|SET}_TSC_STATE
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 8, 2020 at 8:26 AM Maxim Levitsky <mlevitsk@redhat.com> wrote:
>
> On Tue, 2020-12-08 at 17:02 +0100, Thomas Gleixner wrote:
> > On Tue, Dec 08 2020 at 16:50, Maxim Levitsky wrote:
> > > On Mon, 2020-12-07 at 20:29 -0300, Marcelo Tosatti wrote:
> > > > > +This ioctl allows to reconstruct the guest's IA32_TSC and TSC_ADJUST value
> > > > > +from the state obtained in the past by KVM_GET_TSC_STATE on the same vCPU.
> > > > > +
> > > > > +If 'KVM_TSC_STATE_TIMESTAMP_VALID' is set in flags,
> > > > > +KVM will adjust the guest TSC value by the time that passed since the moment
> > > > > +CLOCK_REALTIME timestamp was saved in the struct and current value of
> > > > > +CLOCK_REALTIME, and set the guest's TSC to the new value.
> > > >
> > > > This introduces the wraparound bug in Linux timekeeping, doesnt it?
> >
> > Which bug?
> >
> > > It does.
> > > Could you prepare a reproducer for this bug so I get a better idea about
> > > what are you talking about?
> > >
> > > I assume you need very long (like days worth) jump to trigger this bug
> > > and for such case we can either work around it in qemu / kernel
> > > or fix it in the guest kernel and I strongly prefer the latter.
> > >
> > > Thomas, what do you think about it?
> >
> > For one I have no idea which bug you are talking about and if the bug is
> > caused by the VMM then why would you "fix" it in the guest kernel.
>
> The "bug" is that if VMM moves a hardware time counter (tsc or anything else)
> forward by large enough value in one go,
> then the guest kernel will supposingly have an overflow in the time code.
> I don't consider this to be a buggy VMM behavior, but rather a kernel
> bug that should be fixed (if this bug actually exists)
>
> Purely in theory this can even happen on real hardware if for example SMM handler
> blocks a CPU from running for a long duration, or hardware debugging
> interface does, or some other hardware transparent sleep mechanism kicks in
> and blocks a CPU from running.
> (We do handle this gracefully for S3/S4)

IIRC we introduced mul_u64_u32_shift() for roughly this reason,but we
don't seem to be using it in the relevant code paths.  We should be
able to use the same basic math with wider intermediates to allow very
large intervals between updates.
