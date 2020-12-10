Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF5C2D6451
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Dec 2020 19:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388530AbgLJSBk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Dec 2020 13:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387836AbgLJSAi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Dec 2020 13:00:38 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59604C0613D6
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Dec 2020 09:59:58 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id w13so9513615lfd.5
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Dec 2020 09:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kSOS9gHQJjTmsLc8VDbsSjiQ/RzzRfDOewkmFTUJ9nA=;
        b=Kxt/6OhE59pWJyW2ZQr+9XDZkp9Lg5lk3YGJO2hJ/iMzIxwVGXbRe6+uZji2XV3W/6
         eaZlazRL4VCSMtd5bCHaSiHFvhZFJBDxSs6SSiruVbIZYzcIAnUiMaAhfFENp10Ys8rs
         LjFaiY0iC6HeaQFkJ4mf7nA/zu3dmnvoamfeeJa+RcsInZBTN5wLmSVgw1rzUasRBvfi
         eUzcIJimD7Juvsz0GA8cIAsVJ9sz982+E2YR0g58eknOW6uIW4OR4RdzfsvvoX0Wd57B
         e69CJZtwFwqhXCTquurJTyEvnFGG7ok6Th2zMcMS51lKz76lCTzrHi2cXfd/6WtCyGGJ
         v8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kSOS9gHQJjTmsLc8VDbsSjiQ/RzzRfDOewkmFTUJ9nA=;
        b=ZRArihec1sJL7TtCHAK4WtFJymbeO77R2F+VIGrFWDescns9yADrUsC3k+SEMgpB9+
         mwnBzOFv79S/ghaRUv/gcfIHUkkZdAaA2yzC6sQ5qncgLeRUoMReH33zvqSm+hGo7A09
         AEEu6JGnw7xaxCZY0tbXSIK+jrBrB/iJCkkVOdH72U2AElwlZB+EXsRbiTplVcr7znkC
         dPkZBce6EiJMHWeZkmQqYQFNHFblz73s4oNKPDGm2spbMV/L5xLHIlpveJ6C+Zc3Pl4O
         maMwRulTt9WjDm57cW7GGZGLV8EOA6hS++yNA9jwFE0vgT9c3A6XzKH2L5mQvRW9bX/E
         h1nQ==
X-Gm-Message-State: AOAM5310vw80kDvQttKWCy2QtTd3IbAvJ7PdZweJ/Knr4PAsoXEl6ThZ
        ZAqq74VzOtR9RelZTVcrVTXTUNa954Bz1y6BsaZzqw==
X-Google-Smtp-Source: ABdhPJyC+V/aSG0layoljUptKcm8GaCP6ReUaXdlOAMHzGjDdVVWdZ/1X7eeSfQThNFvCdMJG0M4dBbsRPsBSBWk3Yg=
X-Received: by 2002:ac2:4c8e:: with SMTP id d14mr2983701lfl.411.1607623196388;
 Thu, 10 Dec 2020 09:59:56 -0800 (PST)
MIME-Version: 1.0
References: <9389c1198da174bcc9483d6ebf535405aa8bdb45.camel@redhat.com> <E4F263BE-6CAA-4152-8818-187D34D8D0FD@amacapital.net>
In-Reply-To: <E4F263BE-6CAA-4152-8818-187D34D8D0FD@amacapital.net>
From:   Oliver Upton <oupton@google.com>
Date:   Thu, 10 Dec 2020 11:59:44 -0600
Message-ID: <CAOQ_QshW0UvwSS3TUCK5PxkLQhHTqDNXNeMxwVDyf+DXc23fXQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] KVM: x86: implement KVM_{GET|SET}_TSC_STATE
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
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
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 10, 2020 at 9:16 AM Andy Lutomirski <luto@amacapital.net> wrote=
:
>
>
>
> > On Dec 10, 2020, at 6:52 AM, Maxim Levitsky <mlevitsk@redhat.com> wrote=
:
> >
> > =EF=BB=BFOn Thu, 2020-12-10 at 12:48 +0100, Paolo Bonzini wrote:
> >>> On 08/12/20 22:20, Thomas Gleixner wrote:
> >>> So now life migration comes a long time after timekeeping had set the
> >>> limits and just because it's virt it expects that everything works an=
d it
> >>> just can ignore these limits.
> >>>
> >>> TBH. That's not any different than SMM or hard/firmware taking the
> >>> machine out for lunch. It's exactly the same: It's broken.
> >>
> >> I agree.  If *live* migration stops the VM for 200 seconds, it's broke=
n.
> >>
> >> Sure, there's the case of snapshotting the VM over the weekend.  My
> >> favorite solution would be to just put it in S3 before doing that.  *D=
o
> >> what bare metal does* and you can't go that wrong.
> >
> > Note though that qemu has a couple of issues with s3, and it is disable=
d
> > by default in libvirt.
> > I would be very happy to work on improving this if there is a need for =
that.
>
> There=E2=80=99s also the case where someone has a VM running on a laptop =
and someone closes the lid. The host QEMU might not have a chance to convin=
ce the guest to enter S3.
>
> >
> >
> >>
> >> In general it's userspace policy whether to keep the TSC value the sam=
e
> >> across live migration.  There's pros and cons to both approaches, so K=
VM
> >> should provide the functionality to keep the TSC running (which the
> >> guest will see as a very long, but not extreme SMI), and this is what
> >> this series does.  Maxim will change it to operate per-VM.  Thanks
> >> Thomas, Oliver and everyone else for the input.

So, to be clear, this per-VM ioctl will work something like the following:

static u64 kvm_read_tsc_base(struct kvm *kvm, u64 host_tsc)
{
        return kvm_scale_tsc(kvm, host_tsc) + kvm->host_tsc_offset;
}

case KVM_GET_TSC_BASE:
        struct kvm_tsc_base base =3D {
                .flags =3D KVM_TSC_BASE_TIMESTAMP_VALID;
        };
        u64 host_tsc;

        kvm_get_walltime(&base.nsec, &host_tsc);
        base.tsc =3D kvm_read_tsc_base(kvm, host_tsc);

        copy_to_user(...);

[...]

case KVM_SET_TSC_BASE:
        struct kvm_tsc_base base;
        u64 host_tsc, nsec;
        s64 delta =3D 0;

        copy_from_user(...);

        kvm_get_walltime(&nsec, &host_tsc);
        delta +=3D base.tsc - kvm_read_tsc_base(kvm, host_tsc);

        if (base.flags & KVM_TSC_BASE_TIMESTAMP_VALID) {
                u64 delta_nsec =3D nsec - base.nsec;

                if (delta_nsec > 0)
                        delta +=3D nsec_to_cycles(kvm, diff);
                else
                        delta -=3D nsec_to_cycles(kvm, -diff);
        }

        kvm->host_tsc_offset +=3D delta;
        /* plumb host_tsc_offset through to each vcpu */

However, I don't believe we can assume the guest's TSCs to be synchronized,
even if sane guests will never touch them. In this case, I think a per-vCPU
ioctl is still warranted, allowing userspace to get at the guest CPU adjust
component of Thomas' equation below (paraphrased):

        TSC guest CPU =3D host tsc base + guest base offset + guest CPU adj=
ust

Alternatively, a write from userspace to the guest's IA32_TSC_ADJUST with
KVM_X86_QUIRK_TSC_HOST_ACCESS could have the same effect, but that seems to=
 be
problematic for a couple reasons. First, depending on the guest's CPUID the
TSC_ADJUST MSR may not even be available, meaning that the guest could've u=
sed
IA32_TSC to adjust the TSC (eww). Second, userspace replaying writes to IA3=
2_TSC
(in the case IA32_TSC_ADJUST doesn't exist for the guest) seems _very_
unlikely to work given all the magic handling that KVM does for
writes to it.

Is this roughly where we are or have I entirely missed the mark? :-)

--
Thanks,
Oliver

> >
> > I agree with that.
> >
> > I still think though that we should have a discussion on feasibility
> > of making the kernel time code deal with large *forward* tsc jumps
> > without crashing.
> >
> > If that is indeed hard to do, or will cause performance issues,
> > then I agree that we might indeed inform the guest of time jumps instea=
d.
> >
>
> Tglx, even without fancy shared host/guest timekeeping, count the guest k=
ernel manage to update its timekeeping if the host sent the guest an interr=
upt or NMI on all CPUs synchronously on resume?
>
> Alternatively, if we had the explicit =E2=80=9Cmax TSC value that makes s=
ense right now=E2=80=9D in the timekeeping data, the guest would reliably n=
otice the large jump and could at least do something intelligent about it i=
nstead of overflowing its internal calculation.
