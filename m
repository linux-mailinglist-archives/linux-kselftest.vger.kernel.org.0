Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F27602D3531
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Dec 2020 22:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbgLHV0d (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Dec 2020 16:26:33 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41382 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgLHV0c (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Dec 2020 16:26:32 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607462750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rf13uxdJMX6X2A2KphFC2fFuIHsEuOIYeDTKo8orZ4s=;
        b=eRM4DOkk2Xj3oAxXP3PYRU6jMGCOEBcO8WzVoJNWlY3L1nrKrXTFHeuDcmSTUTob0l8EDa
        mUdmBPkKNt5v8qQLxgR5AZX9uaCh0FzZGMqzYa1F3QovnnmcoIbD2a6CHIZPJBmLTbjqaN
        /FSnIc0NhPoupqLO5KoSPEpAWP8ViB6PblHu+IU6DGo0G4SHWdJQHUYNacReW+Lk1U8hQF
        vjdVvwZJi5MhXP3vw/mJ9Hl7rHVhcnSZlghhIcDv4TSglIwI/fDeomKkM/z64fKrpIw1LZ
        lSs9xWBKk23DRJI0/NwcD79Ml3hyqRzKDxloq1SOTWufiPJxiMu9MNFb6kJpNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607462750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rf13uxdJMX6X2A2KphFC2fFuIHsEuOIYeDTKo8orZ4s=;
        b=3zCq5WdAdssMHnE/fHhnu7Isq6zwpsJ3AcjW//MgpuVNUKB5QEOdX/iSBQDxlp3ccVWW8k
        WMhuftppJflw9RAw==
To:     Andy Lutomirski <luto@amacapital.net>,
        Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
In-Reply-To: <CALCETrWKSdro=0YkaamU-RXpa+2sPzBKct4SPi1SmgL2yS62AQ@mail.gmail.com>
References: <20201203171118.372391-1-mlevitsk@redhat.com> <20201203171118.372391-2-mlevitsk@redhat.com> <20201207232920.GD27492@fuller.cnet> <05aaabedd4aac7d3bce81d338988108885a19d29.camel@redhat.com> <87sg8g2sn4.fsf@nanos.tec.linutronix.de> <6f64558a029574444da417754786f711c2fec407.camel@redhat.com> <CALCETrWKSdro=0YkaamU-RXpa+2sPzBKct4SPi1SmgL2yS62AQ@mail.gmail.com>
Date:   Tue, 08 Dec 2020 22:25:49 +0100
Message-ID: <878sa82dnm.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 08 2020 at 09:33, Andy Lutomirski wrote:
> On Tue, Dec 8, 2020 at 8:26 AM Maxim Levitsky <mlevitsk@redhat.com> wrote:
>
> IIRC we introduced mul_u64_u32_shift() for roughly this reason,but we
> don't seem to be using it in the relevant code paths.  We should be
> able to use the same basic math with wider intermediates to allow very
> large intervals between updates.

That's 128 bit math and _NO_ we are not going there for various
reasons.

Hint1: There is a world outside of x8664 and TSC.
Hint2: Even on x8664 and TSC it comes with performance overhead

Thanks,

        tglx
