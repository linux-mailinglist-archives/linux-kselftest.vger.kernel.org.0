Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68C512D64AC
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Dec 2020 19:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392797AbgLJSOQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Dec 2020 13:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392495AbgLJSOG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Dec 2020 13:14:06 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2798C061794
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Dec 2020 10:13:25 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id y16so7778771ljk.1
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Dec 2020 10:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=et/f3RjbZyuZ9JQ6heD+AHbTOUp1bUm1tRV1afS0ffo=;
        b=v19m+I06m7joT/AcjLb0tMF6lAJ5V8z+FKPko5snmNCFHTPv3bdEHyAb+gPnz4se2R
         +INSchsHDnXs6CHDwyr1OX9D7lgsQLp0+HpPcFPNqyTm2K0h1yTcKG2yEcdN7vKYkDxZ
         /r5QdIJlQZDG0tU68JwmcZR5S+hOa0hDvt1zdO/fcLCeGHukWpFmaF2PxrCHxWjHeiE0
         gaBxJ0NFtD5oc7137LS/skmzqx28uL8EH24BWt9F/nsw2pVhq6uhRBMeYbwhLkauiQ4g
         kiZ0QTjeICTynLVhctWqyARIy3ebvmQcwkfwaIqdz4p+gTYl4zTCqUoRiuFb3GKZl3vD
         QPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=et/f3RjbZyuZ9JQ6heD+AHbTOUp1bUm1tRV1afS0ffo=;
        b=ExOTYyqmfI/qByHVfe64v593HQN8ICKWhgpZuQmJYw+RDhbttw8YplMOXILNFgMNhs
         MS+9gNg5GM9AIk3tVQbxk4fUUmDJT8xi08knt7HdA2gq3inTZhPO2/VKqfcNmzeI+BmQ
         CTZAK1hJLD0AkXtBu28sjVtFyQEn8rRFZnXY0pZwHWnk/kp+G6fCXckRx0wlBCB6B/aH
         lv5u4FupF6zhoTG+qpnBwipYyElgvuBgbcdSXAMSnFwc1G7p0XxCNOs5LDlkfR5AmZJI
         cK76ib6Jd8yGgihinHBOWSY8vVfsLcj4qXWpmw71fj4AgD+QWc92dEYZLc/PgNovYJGM
         eINw==
X-Gm-Message-State: AOAM53061AQmm7I9fq0VtR64bolINcn5Agqqe12NKdmiTRbRunfz0E0R
        1mMxbyN6mZ6otbY4fq7qsCQZs/jNUZGThTQy7R58sw==
X-Google-Smtp-Source: ABdhPJz6mHpgMVqJUnrdAcxtrWUH9N8Z8HVVDmP+wLkbZLA/HDgRzT6WQeKWJ0VSyM8PZFXMwJ9fVjlXIYWpFEccPKQ=
X-Received: by 2002:a2e:961a:: with SMTP id v26mr3699249ljh.314.1607624003934;
 Thu, 10 Dec 2020 10:13:23 -0800 (PST)
MIME-Version: 1.0
References: <9389c1198da174bcc9483d6ebf535405aa8bdb45.camel@redhat.com>
 <E4F263BE-6CAA-4152-8818-187D34D8D0FD@amacapital.net> <CAOQ_QshW0UvwSS3TUCK5PxkLQhHTqDNXNeMxwVDyf+DXc23fXQ@mail.gmail.com>
 <eb0cbfaa-251a-810b-3c12-4ee63d082bc8@redhat.com>
In-Reply-To: <eb0cbfaa-251a-810b-3c12-4ee63d082bc8@redhat.com>
From:   Oliver Upton <oupton@google.com>
Date:   Thu, 10 Dec 2020 12:13:12 -0600
Message-ID: <CAOQ_QsggH=RaPbiOTGjDviKUCa0r4YgJjLsP7ghUGbcVtr2YJQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] KVM: x86: implement KVM_{GET|SET}_TSC_STATE
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Maxim Levitsky <mlevitsk@redhat.com>,
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
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 10, 2020 at 12:05 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 10/12/20 18:59, Oliver Upton wrote:
> > However, I don't believe we can assume the guest's TSCs to be synchronized,
> > even if sane guests will never touch them. In this case, I think a per-vCPU
> > ioctl is still warranted, allowing userspace to get at the guest CPU adjust
> > component of Thomas' equation below (paraphrased):
> >
> >          TSC guest CPU = host tsc base + guest base offset + guest CPU adjust
>
> Right now that would be:
>
> - KVM_GET_TSC_STATE (vm) returns host tsc base + guest base offset (plus
> the associated time)
>
> - KVM_GET_MSR *without* KVM_X86_QUIRK_TSC_HOST_ACCESS for guest CPU adjust
>
> and the corresponding SET ioctls.  What am *I* missing?
>
> > Alternatively, a write from userspace to the guest's IA32_TSC_ADJUST with
> > KVM_X86_QUIRK_TSC_HOST_ACCESS could have the same effect, but that seems to be
> > problematic for a couple reasons. First, depending on the guest's CPUID the
> > TSC_ADJUST MSR may not even be available, meaning that the guest could've used
> > IA32_TSC to adjust the TSC (eww).
>
> Indeed, the host should always be able to read/write IA32_TSC and
> IA32_TSC_ADJUST.

So long as it is guaranteed that guest manipulations of IA32_TSC are
reflected in IA32_TSC_ADJUST even if it isn't in the guest's CPUID,
then this seems OK. I think having clear documentation on this subject
is also necessary, as we're going to rely on the combination of
KVM_{GET,SET}_TSC_STATE, disabling KVM_X86_QUIRK_TSC_HOST_ACCESS, and
userspace reading/writing a possibly hidden MSR to pull this off
right.

--
Thanks,
Oliver

> Thanks,
>
> Paolo
>
> > Second, userspace replaying writes to IA32_TSC
> > (in the case IA32_TSC_ADJUST doesn't exist for the guest) seems_very_
> > unlikely to work given all the magic handling that KVM does for
> > writes to it.
> >
> > Is this roughly where we are or have I entirely missed the mark?:-)
>
