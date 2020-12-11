Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7842D6C40
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Dec 2020 01:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389998AbgLKAFM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Dec 2020 19:05:12 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59118 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389478AbgLKAEd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Dec 2020 19:04:33 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607645028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gKnbSWvo8xgTWID+gjefEKKndhjtzYov0drs0ofkV50=;
        b=UgL/pVRQVx6CwCqI/WGkF/Mp3fuDuGQXlfnEMqs9tAdeD1zA2jL+UNbySvoyUOUhqj391I
        dvrrru3OXdKZbXN8hnFkG/lPNvuMpVNPmyIC9MRWshE0EmeTJzHmoVLJa4FbStrMSsmRBY
        TJhUbXPHpTpFRcIBA87MGLlFhyqAYyV65PgpjefcWWAmHsFW8/Ub8FkbYBSI0p4GGfJZsC
        S/B+8VX1osg6+PJ9KI5x6jCHclWqt8nh6LQIlDnsrImlfUxqItyIiRwsPy0OlBZvQu39jE
        9oE/SbkSpKNaiR3oNTwdCQki9hEtB3XrWLgo6gJen0fob30LKEx75cVogkz70A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607645028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gKnbSWvo8xgTWID+gjefEKKndhjtzYov0drs0ofkV50=;
        b=hrZAtY96p4hQAVs/6ikH5XoTRunFp/9Y1K0KGacfOMgUsJ3TCVL0dXSGKVDsS8n56160U7
        a0S0FM1PUR58cVCA==
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Maxim Levitsky <mlevitsk@redhat.com>,
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
In-Reply-To: <D4FDC64D-C632-42CF-A4F1-A9584C94AFD9@amacapital.net>
References: <87v9d9i9dt.fsf@nanos.tec.linutronix.de> <D4FDC64D-C632-42CF-A4F1-A9584C94AFD9@amacapital.net>
Date:   Fri, 11 Dec 2020 01:03:47 +0100
Message-ID: <87lfe5i4yk.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 10 2020 at 15:19, Andy Lutomirski wrote:
>> On Dec 10, 2020, at 2:28 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> Can we please focus on real problems instead of making up new ones?
>>=20
>> Correctness of time is a real problem despite the believe of virt folks
>> that it can be ignored or duct taped to death.
>>=20
> I=E2=80=99m fine with this as long as it=E2=80=99s intentional. If we say=
 =E2=80=9Cguest
> timekeeping across host suspend is correct because we notify the
> guest=E2=80=9D, then we have a hole. But if we say =E2=80=9Cthe host will=
 try to
> notify the guest, and if the guest is out to lunch then the host
> reserves the right to suspend without waiting, and the guest should
> deal with this=E2=80=9D, then okay.

Yes of course this would be intentional and documented behaviour, which
is an infinite improvement over the current situation.

Thanks,

        tglx
