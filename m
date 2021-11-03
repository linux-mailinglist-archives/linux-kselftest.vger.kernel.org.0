Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B59E443EF4
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Nov 2021 10:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbhKCJHz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Nov 2021 05:07:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:35797 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231278AbhKCJHu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Nov 2021 05:07:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635930314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HNIClEriatvmMl3INQ2uHlDTK9i+KyCSVvF1TrYVckw=;
        b=Y0jWwbQRxh4S2Q+VtfJsXCMesEwdGpO0JZAbSHNXzLDFwZ9X/RvGcTPbVsv9xe3Vr00O/v
        PuJsfXtzSPjQiFBk7ZKwZ650OLiCxKxbLzpcy84YWUHEkU47c59e9SV3HQBYzInepdyVtE
        Tq5SCwW4c7HRU0m9K+sSlcBHRJ5s3G8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-EzMAlgcBMS2J4iItP14udA-1; Wed, 03 Nov 2021 05:05:11 -0400
X-MC-Unique: EzMAlgcBMS2J4iItP14udA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 265DA87180F;
        Wed,  3 Nov 2021 09:05:08 +0000 (UTC)
Received: from starship (unknown [10.40.194.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CECEB5D9D3;
        Wed,  3 Nov 2021 09:05:00 +0000 (UTC)
Message-ID: <e508be0ecda6db330d83b954f4e4d1ad12c08c64.camel@redhat.com>
Subject: Re: [PATCH v3 6/6] KVM: selftests: test KVM_GUESTDBG_BLOCKIRQ
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
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
Date:   Wed, 03 Nov 2021 11:04:59 +0200
In-Reply-To: <YYGHPyhFRHHQsX6a@google.com>
References: <20210811122927.900604-1-mlevitsk@redhat.com>
         <20210811122927.900604-7-mlevitsk@redhat.com>
         <137f2dcc-75d2-9d71-e259-dd66d43ad377@redhat.com>
         <87sfwfkhk5.fsf@vitty.brq.redhat.com>
         <b48210a35b3bc6d63beeb33c19b609b3014191dd.camel@redhat.com>
         <YYB2l9bzFhKzobZB@google.com> <87k0hqkf6p.fsf@vitty.brq.redhat.com>
         <YYFe4LKXiuV+DyZh@google.com> <87fsseo7iu.fsf@vitty.brq.redhat.com>
         <YYGHPyhFRHHQsX6a@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 2021-11-02 at 18:45 +0000, Sean Christopherson wrote:
> On Tue, Nov 02, 2021, Vitaly Kuznetsov wrote:
> > Sean Christopherson <seanjc@google.com> writes:
> > > But that mess is a red herring, the test fails with the same signature with APICv=1
> > > if the STI is replaced by PUSHF+BTS+POPFD (to avoid the STI shadow).  We all missed
> > > this key detail from Vitaly's report:
> > > 
> > > SINGLE_STEP[1]: exit 8 exception 1 rip 0x402a25 (should be 0x402a27) dr6 0xffff4ff0 (should be 0xffff4ff0)
> > >                 ^^^^^^
> > > 
> > > Exit '8' is KVM_EXIT_SHUTDOWN, i.e. the arrival of the IRQ hosed the guest because
> > > the test doesn't invoke vm_init_descriptor_tables() to install event handlers.
> > > The "exception 1" shows up because the run page isn't sanitized by the test, i.e.
> > > it's stale data that happens to match.
> > > 
> > > So I would fully expect this test to fail with AVIC=1.  The problem is that
> > > KVM_GUESTDBG_BLOCKIRQ does absolutely nothing to handle APICv interrupts.  And
> > > even if KVM does something to fudge that behavior in the emulated local APIC, the
> > > test will then fail miserably virtual IPIs (currently AVIC only).
> > 
> > FWIW, the test doesn't seem to fail on my AMD EPYC system even with "avic=1" ...
Its because AVIC is inhibited for many reasons. In this test x2apic is used,
and having x2apic in CPUID inhibits AVIC.

> 
> Huh.  Assuming the IRQ is pending in the vIRR and KVM didn't screw up elsewhere,
> that seems like a CPU AVIC bug.  #DBs have priority over IRQs, but single-step
> #DBs are trap-like and KVM (hopefully) isn't injecting a #DB, so a pending IRQ
> should be taken on the current instruction in the guest when executing VMRUN with
> guest.EFLAGS.IF=1,TF=1 since there will be a one-instruction delay before the
> single-step #DB kicks in.
> 
We could inhibit AVIC/APICv when KVM_GUESTDBG_BLOCKIRQ is in use, I'll send patch for
this soon.

Thanks a lot for finding out what is going on!

Best regards,	Maxim Levitsky

