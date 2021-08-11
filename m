Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF263E9274
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Aug 2021 15:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbhHKNXl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Aug 2021 09:23:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34294 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230381AbhHKNXV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Aug 2021 09:23:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628688156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E8j3Usu6TPeDlqdG02ig6iok7ibfK10nrJnXjIHPT7g=;
        b=UwE9OGMtsKLEp8kWC454xNWJHrVV94j5IMetQ4LYUoO9Y02lKtYGWX0mlr+9ii9G1rZSsy
        JKk0clXHHKSgfEMkYlCpD927/0XnExvBRnYAFTa73stg3Ud9zeBFIadFTJzJBLnC5CRSi1
        j2DuG2sEab14Y2aoIiBCiF4RBWT2nJ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-c8uzCiM8MpWpL-j_94rFmw-1; Wed, 11 Aug 2021 09:22:32 -0400
X-MC-Unique: c8uzCiM8MpWpL-j_94rFmw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D97D9802922;
        Wed, 11 Aug 2021 13:22:29 +0000 (UTC)
Received: from starship (unknown [10.35.206.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2A2AC226E0;
        Wed, 11 Aug 2021 13:22:23 +0000 (UTC)
Message-ID: <bb7568d08ea7d3598d71db7631d56b9f288d3f32.camel@redhat.com>
Subject: Re: [PATCH v3 0/6] KVM: my debug patch queue
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc:     Kieran Bingham <kbingham@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Andrew Jones <drjones@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
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
Date:   Wed, 11 Aug 2021 16:22:23 +0300
In-Reply-To: <1646763f-9f92-bb67-f358-9b17c8000b12@redhat.com>
References: <20210811122927.900604-1-mlevitsk@redhat.com>
         <1646763f-9f92-bb67-f358-9b17c8000b12@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2021-08-11 at 15:10 +0200, Paolo Bonzini wrote:
> On 11/08/21 14:29, Maxim Levitsky wrote:
> > Hi!
> > 
> > I would like to publish two debug features which were needed for other stuff
> > I work on.
> > 
> > One is the reworked lx-symbols script which now actually works on at least
> > gdb 9.1 (gdb 9.2 was reported to fail to load the debug symbols from the kernel
> > for some reason, not related to this patch) and upstream qemu.
> > 
> > The other feature is the ability to trap all guest exceptions (on SVM for now)
> > and see them in kvmtrace prior to potential merge to double/triple fault.
> > 
> > This can be very useful and I already had to manually patch KVM a few
> > times for this.
> > I will, once time permits, implement this feature on Intel as well.
> > 
> > V2:
> > 
> >   * Some more refactoring and workarounds for lx-symbols script
> > 
> >   * added KVM_GUESTDBG_BLOCKIRQ flag to enable 'block interrupts on
> >     single step' together with KVM_CAP_SET_GUEST_DEBUG2 capability
> >     to indicate which guest debug flags are supported.
> > 
> >     This is a replacement for unconditional block of interrupts on single
> >     step that was done in previous version of this patch set.
> >     Patches to qemu to use that feature will be sent soon.
> > 
> >   * Reworked the the 'intercept all exceptions for debug' feature according
> >     to the review feedback:
> > 
> >     - renamed the parameter that enables the feature and
> >       moved it to common kvm module.
> >       (only SVM part is currently implemented though)
> > 
> >     - disable the feature for SEV guests as was suggested during the review
> >     - made the vmexit table const again, as was suggested in the review as well.
> > 
> > V3:
> >   * Modified a selftest to cover the KVM_GUESTDBG_BLOCKIRQ
> >   * Rebased on kvm/queue
> > 
> > Best regards,
> >          Maxim Levitsky
> > 
> > Maxim Levitsky (6):
> >    KVM: SVM: split svm_handle_invalid_exit
> >    KVM: x86: add force_intercept_exceptions_mask
> >    KVM: SVM: implement force_intercept_exceptions_mask
> >    scripts/gdb: rework lx-symbols gdb script
> >    KVM: x86: implement KVM_GUESTDBG_BLOCKIRQ
> >    KVM: selftests: test KVM_GUESTDBG_BLOCKIRQ
> > 
> >   Documentation/virt/kvm/api.rst                |   1 +
> >   arch/x86/include/asm/kvm_host.h               |   5 +-
> >   arch/x86/include/uapi/asm/kvm.h               |   1 +
> >   arch/x86/kvm/svm/svm.c                        |  87 +++++++-
> >   arch/x86/kvm/svm/svm.h                        |   6 +-
> >   arch/x86/kvm/x86.c                            |  12 +-
> >   arch/x86/kvm/x86.h                            |   2 +
> >   kernel/module.c                               |   8 +-
> >   scripts/gdb/linux/symbols.py                  | 203 ++++++++++++------
> >   .../testing/selftests/kvm/x86_64/debug_regs.c |  24 ++-
> >   10 files changed, 266 insertions(+), 83 deletions(-)
> > 
> 
> Queued 1-5-6.
> 
> For patches 2 and 3, please add VMX support too.
> 
> For patch 4, it's not KVM :) so please submit it separately.

Thanks!

I will do this!


Best regards,
	Maxim Levitsky

> 
> Paolo
> 


