Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B71814435EF
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Nov 2021 19:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235171AbhKBSsA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Nov 2021 14:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbhKBSsA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Nov 2021 14:48:00 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2FBC061205
        for <linux-kselftest@vger.kernel.org>; Tue,  2 Nov 2021 11:45:24 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id k4so202649plx.8
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Nov 2021 11:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uyakuliA4UmCrR9fWLbnfsteDHRzQoVyMYaYZCZPqcE=;
        b=QSvnvvTT239D4LtMPyZZ2dGqU4aTXmfJdH/jOQDnUdbwyhUHiqjgLzUASd7YARPN5d
         PiPVaDSagyizNqCM9XYRyOlDwI2M0HKXCMaAapevrPynFPkZvaTpHYdzqo+rWPJ44Y+I
         2y6ft7C56wEnX2Yzqk7MTxWJIGTBG25ryLEpYMveBSCtJL0x7877mhZhVDe1W7Yf7vnX
         8sObXnSfkVhQLU4lnMb2I4JIwZPWEBz4aiI7KgViG5kE0EmwE6VrhD0ohArJRD96ShyH
         wk5BEi6hRi8pBukU3inc+FAW7kURXuzOQFTIDq+ijLfpK0wtFnX4wg+FZ9PKRsrTJieF
         nUWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uyakuliA4UmCrR9fWLbnfsteDHRzQoVyMYaYZCZPqcE=;
        b=y4NxzvuTVbRzYBepKgXrt6HQqLsQrUfHY4qVW2C38wbM/id8uvTsKOkA6V4MtA3DHO
         swJHE/5NLP50yRYjddzU7xDYL6d7H+ix0c6leiUoM5Is0yeFCMV6ILUX23G57fHUDqsN
         lnaJqt7NjUj4nXbz7USMjGIWD+7z4mct4vaqmgYGfIsnOIQ0c8qqIiXp06mEwQgeHaP+
         82mM0snj/VTQVpZ5FsWMwYU3mKyByOAe27ziFEM3TXu73hZOEA9kPaSRcgM3QkKviPnB
         Woq+pqsmPlAuQ27yU8XTnGN1+ZQWAnpCbJ9XlKsZtgUET0mgEu13VG9y032idqaXbhie
         5pAg==
X-Gm-Message-State: AOAM530dqhcwk1DMIRPsL8wI37WafIOul0IGhXJ40GRR/rzMx+D/dVfl
        WXKtk0zS0APVV9mEGc/xlq0GiQ==
X-Google-Smtp-Source: ABdhPJzCg5XbTMBI/qYK59iig0i/B/ZoMAl/naQ660AkVcrQ73W0GGTo3KkOkNDq9jFtVZ4hn/R2LA==
X-Received: by 2002:a17:90a:191a:: with SMTP id 26mr8974786pjg.118.1635878724218;
        Tue, 02 Nov 2021 11:45:24 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id m4sm3167803pjl.11.2021.11.02.11.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 11:45:23 -0700 (PDT)
Date:   Tue, 2 Nov 2021 18:45:19 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Kieran Bingham <kbingham@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Andrew Jones <drjones@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jessica Yu <jeyu@kernel.org>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Yang Weijiang <weijiang.yang@intel.com>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 6/6] KVM: selftests: test KVM_GUESTDBG_BLOCKIRQ
Message-ID: <YYGHPyhFRHHQsX6a@google.com>
References: <20210811122927.900604-1-mlevitsk@redhat.com>
 <20210811122927.900604-7-mlevitsk@redhat.com>
 <137f2dcc-75d2-9d71-e259-dd66d43ad377@redhat.com>
 <87sfwfkhk5.fsf@vitty.brq.redhat.com>
 <b48210a35b3bc6d63beeb33c19b609b3014191dd.camel@redhat.com>
 <YYB2l9bzFhKzobZB@google.com>
 <87k0hqkf6p.fsf@vitty.brq.redhat.com>
 <YYFe4LKXiuV+DyZh@google.com>
 <87fsseo7iu.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fsseo7iu.fsf@vitty.brq.redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 02, 2021, Vitaly Kuznetsov wrote:
> Sean Christopherson <seanjc@google.com> writes:
> > But that mess is a red herring, the test fails with the same signature with APICv=1
> > if the STI is replaced by PUSHF+BTS+POPFD (to avoid the STI shadow).  We all missed
> > this key detail from Vitaly's report:
> >
> > SINGLE_STEP[1]: exit 8 exception 1 rip 0x402a25 (should be 0x402a27) dr6 0xffff4ff0 (should be 0xffff4ff0)
> >                 ^^^^^^
> >
> > Exit '8' is KVM_EXIT_SHUTDOWN, i.e. the arrival of the IRQ hosed the guest because
> > the test doesn't invoke vm_init_descriptor_tables() to install event handlers.
> > The "exception 1" shows up because the run page isn't sanitized by the test, i.e.
> > it's stale data that happens to match.
> >
> > So I would fully expect this test to fail with AVIC=1.  The problem is that
> > KVM_GUESTDBG_BLOCKIRQ does absolutely nothing to handle APICv interrupts.  And
> > even if KVM does something to fudge that behavior in the emulated local APIC, the
> > test will then fail miserably virtual IPIs (currently AVIC only).
> 
> FWIW, the test doesn't seem to fail on my AMD EPYC system even with "avic=1" ...

Huh.  Assuming the IRQ is pending in the vIRR and KVM didn't screw up elsewhere,
that seems like a CPU AVIC bug.  #DBs have priority over IRQs, but single-step
#DBs are trap-like and KVM (hopefully) isn't injecting a #DB, so a pending IRQ
should be taken on the current instruction in the guest when executing VMRUN with
guest.EFLAGS.IF=1,TF=1 since there will be a one-instruction delay before the
single-step #DB kicks in.
