Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA542D3438
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Dec 2020 21:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730249AbgLHUdb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Dec 2020 15:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgLHUdb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Dec 2020 15:33:31 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2790CC061794
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Dec 2020 12:32:51 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id m9so13251972pgb.4
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Dec 2020 12:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=X3jaTUl9GBo4a8qnhQEMvznUX5ksekBuFBQfWILQ+U8=;
        b=MrliCpl8hL4cJC8PERAnNSwTdw6bXwTTXhAZ/M5/h7klwCksqQ6Ag35pmFF1pxUlTT
         XQJ2QeciTt9iZFcybbCPAOWut3Mp8EWvFsTGWzCkPREPRSEXjTcA9xchQcRSUroN+CzI
         STLPmTE4Xc+a36i7ap+UAK8ndr2qoM5aj8iRgtNJTv+tP+4ZPmBW2xu6Te336JZ4a2j2
         R/JIVw0N8rxTDFu4L1TXxBTxtO3OKCOlmkdkzthu3wt3BV2FKt3XlanBn5ef8C49Pfir
         HsVPP3dqRjfjkctYO0dzupgCnDP7/I4WqvNmoHHCqeUQrfK/uOodQ4oUU7C243b1Grn9
         2naA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=X3jaTUl9GBo4a8qnhQEMvznUX5ksekBuFBQfWILQ+U8=;
        b=P0BltqK1fJN/vtfYY7MLwb+/Y2P6vhiFMOzOdTfyMGn5QAkWt5JDj2IO3Q8MO5sEdK
         Wedog1sxGPbXNsfL+NdyJggkofoYB9/EgbJ2BdA5n5sRN3ZtyKSQRkrMiMNEgoBAA1Sc
         EhwLol78+5OW0cjrVbXAcw7d+5xl20M97ZOATnmXy2Th6MHBJ9ofLHZ4dVPCa+9ioVHa
         tqo9LchTZlHT8nFqnx3q5kLJpbI4dEWbEIRncPmPAqz6e/cox1kjH0y3IjDCEdVXpUez
         A8hFDBZbMaDm5SuAsWVMxaJ8merSaKzFvsUZAXs9H3miXDgWICcnipMuxdJGwjRIWk88
         czqA==
X-Gm-Message-State: AOAM533eJPVA3J3n4FTNkMzvmNykQDreCFf4d290wjfvLndkIRlGkcic
        YZELwQCagFJCIsaTp6rERgNK/A==
X-Google-Smtp-Source: ABdhPJxYJCnYuntUM3RTj5G4uZ8JcqXRsmHjDtNdlCetqy79aa/LEq/fJzELfZLm7dPA5RZVrqzYYQ==
X-Received: by 2002:a17:90b:a04:: with SMTP id gg4mr6017057pjb.8.1607459570651;
        Tue, 08 Dec 2020 12:32:50 -0800 (PST)
Received: from ?IPv6:2600:1010:b020:7dd:51f8:22c8:74de:21e0? ([2600:1010:b020:7dd:51f8:22c8:74de:21e0])
        by smtp.gmail.com with ESMTPSA id a17sm15902499pga.56.2020.12.08.12.32.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 12:32:49 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 1/3] KVM: x86: implement KVM_{GET|SET}_TSC_STATE
Date:   Tue, 8 Dec 2020 12:32:48 -0800
Message-Id: <301491B7-DEB6-41ED-B8FD-657B864696CF@amacapital.net>
References: <87h7ow2j91.fsf@nanos.tec.linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
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
In-Reply-To: <87h7ow2j91.fsf@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
X-Mailer: iPhone Mail (18B121)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


> On Dec 8, 2020, at 11:25 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
> =EF=BB=BFOn Tue, Dec 08 2020 at 09:43, Andy Lutomirski wrote:
>> On Tue, Dec 8, 2020 at 6:23 AM Marcelo Tosatti <mtosatti@redhat.com> wrot=
e:
>> It looks like it tries to accomplish the right goal, but in a rather
>> roundabout way.  The host knows how to convert from TSC to
>> CLOCK_REALTIME, and ptp_kvm.c exposes this data to the guest.  But,
>> rather than just making the guest use the same CLOCK_REALTIME data as
>> the host, ptp_kvm.c seems to expose information to usermode that a
>> user daemon could use to attempt (with some degree of error?) to use
>> to make the guest kernel track CLOCK_REALTIME.  This seems inefficient
>> and dubiously accurate.
>>=20
>> My feature request is for this to be fully automatic and completely
>> coherent.  I would like for a host user program and a guest user
>> program to be able to share memory, run concurrently, and use the
>> shared memory to exchange CLOCK_REALTIME values without ever observing
>> the clock going backwards.  This ought to be doable.  Ideally the
>> result should even be usable for Spanner-style synchronization
>> assuming the host clock is good enough.  Also, this whole thing should
>> work without needing to periodically wake the guest to remain
>> synchronized.  If the guest sleeps for two minutes (full nohz-idle, no
>> guest activity at all), the host makes a small REALTIME frequency
>> adjustment, and then the guest runs user code that reads
>> CLOCK_REALTIME, the guest clock should still be fully synchronized
>> with the host.  I don't think that ptp_kvm.c-style synchronization can
>> do this.
>=20
> One issue here is that guests might want to run their own NTP/PTP. One
> reason to do that is that some people prefer the leap second smearing
> NTP servers.=20

I would hope that using this part would be optional on the guest=E2=80=99s p=
art. Guests should be able to use just the CLOCK_MONOTONIC_RAW part or fanci=
er stuff at their option.

(Hmm, it would, in principle, be possible for a guest to use the host=E2=80=99=
s TAI but still smear leap seconds. Even without virt, smearing could be a p=
er-timens option.)

>=20
>> tglx etc, I think that doing this really really nicely might involve
>> promoting something like the current vDSO data structures to ABI -- a
>> straightforward-ish implementation would be for the KVM host to export
>> its vvar clock data to the guest and for the guest to use it, possibly
>> with an offset applied.  The offset could work a lot like timens works
>> today.
>=20
> Works nicely if the guest TSC is not scaled. But that means that on
> migration the raw TSC usage in the guest is borked because the new host
> might have a different TSC frequency.
>=20
> If you use TSC scaling then the conversion needs to take TSC scaling
> into account which needs some thought. And the guest would need to read
> the host conversion from 'vdso data' and the scaling from the next page
> (per guest) and then still has to support timens. Doable but adds extra
> overhead on every time read operation.

Is the issue that scaling would result in a different guest vs host frequenc=
y?  Perhaps we could limit each physical machine to exactly two modes: unsca=
led (use TSC ticks, convert in software) and scaled to nanoseconds (CLOCK_MO=
NOTONIC_RAW is RDTSC + possible offset).  Then the host could produce its da=
ta structures in exactly those two formats and export them as appropriate.=20=


>=20
> If you want to avoid that you are back to the point where you need to
> chase all guest data when the host NTP/PTP adjusts the host side.
> Chasing and updating all this stuff in the tick was the reason why I was
> fighting the idea of clock realtime in namespaces.

I think that, if we can arrange for a small, bounded number of pages generat=
ed by the host, then this problem isn=E2=80=99t so bad.

Hmm, leap second smearing is just a different linear mapping. I=E2=80=99m no=
t sure how leap second smearing should interact with timens, but it seems to=
 be that the host should be able to produce four data pages (scaled vs unsca=
led and smeared vs unsmeared) and one per-guest/timens offset page (where of=
fset applies to MONOTONIC and MONOTONIC_RAW only) and cover all bases.  Or d=
o people actually want to offset their TAI and/or REALTIME, and what would t=
hat even mean if the offset crosses a leap second?

(I haven=E2=80=99t though about the interaction of any of this with ART.)
