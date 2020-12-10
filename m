Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA4A62D6BCC
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Dec 2020 00:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393738AbgLJXT5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Dec 2020 18:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394213AbgLJXTs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Dec 2020 18:19:48 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C57C06179C
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Dec 2020 15:19:08 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id r4so3610044pls.11
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Dec 2020 15:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=t0Sx/XIPvxiCKhEvsUvex+bf+zfhTcd/fmShmfRK7nw=;
        b=fjaOh7Yn+hYJHK8b6dEVuPhNwij7FJO7d/aZfC/K1QdpwgJTKXp0V6h913hQHnPx6o
         yYbrGu6+ka7woWkbFDcYMvUUHHDR/fIxCswu6wglMIGcIiBzBli84xQ8cg36gKwbyc5t
         2nxqbD26czLVWGH8jN7pIx+6fS2jBLTER8ew6wcSEwNu+E5x+vGt0GH57fY1XhuYkW5V
         Oc+/v8uaPWdlvt+litrOQfdBRp2g+oYf9Ligp4K2gE6Ymb5np5hPciKdBot6KQ+Ds1qO
         mzi1F7WndTmcM5uTIY+Al1EHnkCUmwwJhzKgLO/L2+d1xleWaOp+D4owOSoyrchqCNCf
         1PSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=t0Sx/XIPvxiCKhEvsUvex+bf+zfhTcd/fmShmfRK7nw=;
        b=Pl9C1eMHkxbI57m/7/YB896S7Y2AOeFeIz1j1/tcMUkS5KHGyUQT5fBKuY9G9m0Bcb
         kK3wsJ3i6c1YMT08Mt1z6pN1gEDiRt0FCS9auHwfTfUJElA0Y7QwBPTL29F8bVBbr2bu
         RsTuttXYUDFzXLKaG+mVHIRf46X04vHz3CrBJ6fmaN2Qxp6OsZJT3wZ9ZDAqgRNwCQoY
         3RFO4uAqzVVdo/DIxs94yD1MzWu6umB6yKTQZh7iFYVmu0dKeamaMfrYGU7apTE13m/E
         8l2tvWY/0MilqVa9hSc10NvFY5EKIx/P0Ouw1r92R7+29SgSosriXd9nJQO4QQtpfuUh
         MX2Q==
X-Gm-Message-State: AOAM5329m4esxg+1uAjzhp8HEVZcUZg4R/wGCRAnyD3M6DUnC8Y/GMCF
        LaMxl8GeegQGY2gS+NwtW+uUHQ==
X-Google-Smtp-Source: ABdhPJx3DJeFCNqncunWWmFw+Ili2CoD2aVdiDFsoUUIbbkZknoQzVq6/PQzYckr9GAm1YDO4HUuMQ==
X-Received: by 2002:a17:902:860a:b029:da:e83a:7f1f with SMTP id f10-20020a170902860ab02900dae83a7f1fmr8272152plo.60.1607642348164;
        Thu, 10 Dec 2020 15:19:08 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:d828:a6ba:337e:e413? ([2601:646:c200:1ef2:d828:a6ba:337e:e413])
        by smtp.gmail.com with ESMTPSA id z9sm7852957pji.48.2020.12.10.15.19.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 15:19:07 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 1/3] KVM: x86: implement KVM_{GET|SET}_TSC_STATE
Date:   Thu, 10 Dec 2020 15:19:05 -0800
Message-Id: <D4FDC64D-C632-42CF-A4F1-A9584C94AFD9@amacapital.net>
References: <87v9d9i9dt.fsf@nanos.tec.linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
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
        Oliver Upton <oupton@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
In-Reply-To: <87v9d9i9dt.fsf@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
X-Mailer: iPhone Mail (18B121)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


> On Dec 10, 2020, at 2:28 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
> =EF=BB=BFOn Thu, Dec 10 2020 at 14:01, Andy Lutomirski wrote:
>>> On Thu, Dec 10, 2020 at 1:25 PM Thomas Gleixner <tglx@linutronix.de> wro=
te:
>>> I'm still convinced that a notification about 'we take a nap' will be
>>> more robust, less complex and more trivial to backport.
>>=20
>> What do you have in mind?  Suppose the host kernel sends the guest an
>> interrupt on all vCPUs saying "I'm about to take a nap".  What happens
>> if the guest is busy with IRQs off for a little bit?  Does the host
>> guarantee the guest a certain about of time to try to get the
>> interrupt delivered before allowing the host to enter S3?  How about
>> if the host wants to reboot for a security fix -- how long is a guest
>> allowed to delay the process?
>>=20
>> I'm sure this can all be made to work 99% of time, but I'm a bit
>> concerned about that last 1%.
>=20
> Seriously?
>=20
> If the guest has interrupts disabled for ages, i.e. it went for out for
> lunch on its own, then surely the hypervisor can just pull the plug and
> wreckage it. It's like you hit the reset button or pull the powerplug of
> the machine which is not responding anymore.
>=20
> Reboot waits already today for guests to shut down/hibernate/supsend or
> whatever they are supposed to do. systemd sits there and waits for
> minutes until it decides to kill them. Just crash a guest kernel and
> forget to reset or force power off the guest before you reboot the
> host. Twiddle thumbs for a while and watch the incomprehensible time
> display.
>=20
> If your security fix reboot is so urgent that it can't wait then just
> pull the plug and be done with it, i.e. kill the guest which makes it
> start from a known state which is a gazillion times better than bringing
> it into a state which it can't handle anymore.
>=20
> Again, that's not any different than hitting the reset button on the
> host or pulling and reinserting the host powerplug which you would do
> anyway in an emergency case.
>=20
> Can we please focus on real problems instead of making up new ones?
>=20
> Correctness of time is a real problem despite the believe of virt folks
> that it can be ignored or duct taped to death.
>=20

I=E2=80=99m fine with this as long as it=E2=80=99s intentional. If we say =E2=
=80=9Cguest timekeeping across host suspend is correct because we notify the=
 guest=E2=80=9D, then we have a hole. But if we say =E2=80=9Cthe host will t=
ry to notify the guest, and if the guest is out to lunch then the host reser=
ves the right to suspend without waiting, and the guest should deal with thi=
s=E2=80=9D, then okay.=
