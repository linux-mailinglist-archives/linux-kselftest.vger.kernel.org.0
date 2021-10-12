Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1B01429EFF
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Oct 2021 09:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbhJLHyH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Oct 2021 03:54:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24233 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234413AbhJLHyG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Oct 2021 03:54:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634025124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DawGZtwoY4tpG7sttmX7k/wQ7T3bzhJ2Z3tfnHYSP0M=;
        b=LW2Vl66sAYVl6I709ZWr8LTim4cGB1USntli0VLkEBm7PzlbEDk5LuugsHHYz7yc4j7gm1
        tcayZ4KXVnF5+A3hQ+QE8lZ0Bd+DXlCObeDYK0OvR2gfdvx8SGXEglYCWp5b0UVOVsguTK
        RXjFH/5EqNXqXZfThcsJy9Ixl5gUsCI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-sczdr6Q8ODGw-l3VY02DGQ-1; Tue, 12 Oct 2021 03:51:37 -0400
X-MC-Unique: sczdr6Q8ODGw-l3VY02DGQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7BA419057A8;
        Tue, 12 Oct 2021 07:51:34 +0000 (UTC)
Received: from starship (unknown [10.35.206.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5FDAA60BE5;
        Tue, 12 Oct 2021 07:51:08 +0000 (UTC)
Message-ID: <8f4be85e44f5997e24d534423b9d9b4dbcaa5d84.camel@redhat.com>
Subject: Re: [PATCH 07/14] KVM: x86: SVM: add warning for CVE-2021-3656
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Xiaoyao Li <xiaoyao.li@intel.com>, kvm@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Borislav Petkov <bp@alien8.de>, Bandan Das <bsd@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Ingo Molnar <mingo@redhat.com>,
        Wei Huang <wei.huang2@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jim Mattson <jmattson@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Wanpeng Li <wanpengli@tencent.com>
Date:   Tue, 12 Oct 2021 10:51:07 +0300
In-Reply-To: <4c04106a-fd8e-fb54-799f-06331a3e65b9@intel.com>
References: <20210914154825.104886-1-mlevitsk@redhat.com>
         <20210914154825.104886-8-mlevitsk@redhat.com>
         <4c04106a-fd8e-fb54-799f-06331a3e65b9@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 2021-10-12 at 01:30 +0800, Xiaoyao Li wrote:
> On 9/14/2021 11:48 PM, Maxim Levitsky wrote:
> > Just in case, add a warning ensuring that on guest entry,
> > either both VMLOAD and VMSAVE intercept is enabled or
> > vVMLOAD/VMSAVE is enabled.
> > 
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >   arch/x86/kvm/svm/svm.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> > 
> > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > index 861ac9f74331..deeebd05f682 100644
> > --- a/arch/x86/kvm/svm/svm.c
> > +++ b/arch/x86/kvm/svm/svm.c
> > @@ -3784,6 +3784,12 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu)
> >   
> >   	WARN_ON_ONCE(kvm_apicv_activated(vcpu->kvm) != kvm_vcpu_apicv_active(vcpu));
> >   
> > +	/* Check that CVE-2021-3656 can't happen again */
> > +	if (!svm_is_intercept(svm, INTERCEPT_VMSAVE) ||
> > +	    !svm_is_intercept(svm, INTERCEPT_VMSAVE))
> 
> either one needs to be INTERCEPT_VMLOAD, right?

Oops! Of course.

Best regards,
	Maxim Levitsky
> 
> > +		WARN_ON(!(svm->vmcb->control.virt_ext &
> > +			  VIRTUAL_VMLOAD_VMSAVE_ENABLE_MASK));
> > +
> >   	sync_lapic_to_cr8(vcpu);
> >   
> >   	if (unlikely(svm->asid != svm->vmcb->control.asid)) {
> > 


