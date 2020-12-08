Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A042D3169
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Dec 2020 18:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730839AbgLHRop (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Dec 2020 12:44:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:37618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730826AbgLHRoo (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Dec 2020 12:44:44 -0500
X-Gm-Message-State: AOAM531zK3YQBMfe8jXvuxM0fSAU73Vod0DpXWYWYRfZZWds/8YjX9hM
        p1MGjwN1AIrxQL+oFGGpky+6mEJ7jRyeJK6d+imr5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607449443;
        bh=qOJEF76l9wC8yLqJEJDwkrt5AGUmhLvlKmfUMREz+ko=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dAb3IRJqoR06BqD0je5AQGVNbWRVArv9rH+FjDpIwFKjqgIMLfwl4f+JxmubOQ1ec
         r2sacEDyxFlxt1DswVi3PMaLtJIViE4p/ms42Wkx/s8lEWFq7ygu+3ZqKscDuw3dj2
         5HU8rwwVDrqA+9IoVaSyg1rD9F5rudJ2gxnwWmba2JOJGnGnTyoVUWLobdHUegrRKg
         jlS4FXaRPC336p6hlLiHZ3yFgrVpRsIUR1u46UPrks0cVH6y9S+HornA802V/dk19l
         aWkrR6Sjz/hrvgcNmOFefXAevz82mMJMcA1u0DinCF6ntbu6BisQn4c6CKHqohU2qj
         3gllIJr1YdRuQ==
X-Google-Smtp-Source: ABdhPJxx38F+AYzAUbFPiyi/arpdYMpWh2pcmMLnvFDFDjtyr8BqYrmCqo4vk1YSkwXojlzdjAdLKo7OSbBpcW6fBRw=
X-Received: by 2002:a1c:1d85:: with SMTP id d127mr4943071wmd.49.1607449442016;
 Tue, 08 Dec 2020 09:44:02 -0800 (PST)
MIME-Version: 1.0
References: <636fecc20b0143128b484f159ff795ff65d05b82.camel@redhat.com>
 <885C1725-B479-47F6-B08D-A7181637A80A@amacapital.net> <20201207231127.GB27492@fuller.cnet>
In-Reply-To: <20201207231127.GB27492@fuller.cnet>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 8 Dec 2020 09:43:50 -0800
X-Gmail-Original-Message-ID: <CALCETrX7F3EgshyTfsNZy8R=NzyQNOY6JAULfiuOCxc1Fz8mPQ@mail.gmail.com>
Message-ID: <CALCETrX7F3EgshyTfsNZy8R=NzyQNOY6JAULfiuOCxc1Fz8mPQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] KVM: x86: implement KVM_{GET|SET}_TSC_STATE
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 8, 2020 at 6:23 AM Marcelo Tosatti <mtosatti@redhat.com> wrote:
>
> On Mon, Dec 07, 2020 at 10:04:45AM -0800, Andy Lutomirski wrote:
> >
> >
> > I do have a feature request, though: IMO it would be quite nifty if the=
 new kvmclock structure could also expose NTP corrections. In other words, =
if you could expose enough info to calculate CLOCK_MONOTONIC_RAW, CLOCK_MON=
OTONIC, and CLOCK_REALTIME, then we could have paravirt NTP.
>
> Hi Andy,
>
> Any reason why drivers/ptp/ptp_kvm.c does not work for you?
>

It looks like it tries to accomplish the right goal, but in a rather
roundabout way.  The host knows how to convert from TSC to
CLOCK_REALTIME, and ptp_kvm.c exposes this data to the guest.  But,
rather than just making the guest use the same CLOCK_REALTIME data as
the host, ptp_kvm.c seems to expose information to usermode that a
user daemon could use to attempt (with some degree of error?) to use
to make the guest kernel track CLOCK_REALTIME.  This seems inefficient
and dubiously accurate.

My feature request is for this to be fully automatic and completely
coherent.  I would like for a host user program and a guest user
program to be able to share memory, run concurrently, and use the
shared memory to exchange CLOCK_REALTIME values without ever observing
the clock going backwards.  This ought to be doable.  Ideally the
result should even be usable for Spanner-style synchronization
assuming the host clock is good enough.  Also, this whole thing should
work without needing to periodically wake the guest to remain
synchronized.  If the guest sleeps for two minutes (full nohz-idle, no
guest activity at all), the host makes a small REALTIME frequency
adjustment, and then the guest runs user code that reads
CLOCK_REALTIME, the guest clock should still be fully synchronized
with the host.  I don't think that ptp_kvm.c-style synchronization can
do this.

tglx etc, I think that doing this really really nicely might involve
promoting something like the current vDSO data structures to ABI -- a
straightforward-ish implementation would be for the KVM host to export
its vvar clock data to the guest and for the guest to use it, possibly
with an offset applied.  The offset could work a lot like timens works
today.

--Andy
