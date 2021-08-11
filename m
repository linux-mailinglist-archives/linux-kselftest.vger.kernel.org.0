Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38FE93E9106
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Aug 2021 14:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbhHKMaR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Aug 2021 08:30:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57164 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238173AbhHKMaC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Aug 2021 08:30:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628684978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=QO0nSAu92MP8RiEuIhgxVdsQv6XTTqKChhiysXgjNsE=;
        b=gj8otU2dLuXZvf6euOpCiu0ImD0cCPUEQABI0Uxf3w5Wk+9GAa5DjUjE3ZhKN+gHM7RA0M
        CPbM5GQ8rEHrOtVZrospJooqBylsmYOL87DP+TCZkixpXaFTmmuBuSwraqzVH3TvtaAttL
        dsz+NsxznsQjmBZVNSNc0Hwxs99ycUM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-9kiyAvy9M6275xO6WjeebA-1; Wed, 11 Aug 2021 08:29:37 -0400
X-MC-Unique: 9kiyAvy9M6275xO6WjeebA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D075F593A8;
        Wed, 11 Aug 2021 12:29:34 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.35.206.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C6C3D5D9C6;
        Wed, 11 Aug 2021 12:29:28 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Kieran Bingham <kbingham@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Andrew Jones <drjones@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        Johannes Berg <johannes.berg@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jessica Yu <jeyu@kernel.org>,
        Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Yang Weijiang <weijiang.yang@intel.com>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 0/6] KVM: my debug patch queue
Date:   Wed, 11 Aug 2021 15:29:21 +0300
Message-Id: <20210811122927.900604-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi!=0D
=0D
I would like to publish two debug features which were needed for other stuf=
f=0D
I work on.=0D
=0D
One is the reworked lx-symbols script which now actually works on at least=
=0D
gdb 9.1 (gdb 9.2 was reported to fail to load the debug symbols from the ke=
rnel=0D
for some reason, not related to this patch) and upstream qemu.=0D
=0D
The other feature is the ability to trap all guest exceptions (on SVM for n=
ow)=0D
and see them in kvmtrace prior to potential merge to double/triple fault.=0D
=0D
This can be very useful and I already had to manually patch KVM a few=0D
times for this.=0D
I will, once time permits, implement this feature on Intel as well.=0D
=0D
V2:=0D
=0D
 * Some more refactoring and workarounds for lx-symbols script=0D
=0D
 * added KVM_GUESTDBG_BLOCKIRQ flag to enable 'block interrupts on=0D
   single step' together with KVM_CAP_SET_GUEST_DEBUG2 capability=0D
   to indicate which guest debug flags are supported.=0D
=0D
   This is a replacement for unconditional block of interrupts on single=0D
   step that was done in previous version of this patch set.=0D
   Patches to qemu to use that feature will be sent soon.=0D
=0D
 * Reworked the the 'intercept all exceptions for debug' feature according=
=0D
   to the review feedback:=0D
=0D
   - renamed the parameter that enables the feature and=0D
     moved it to common kvm module.=0D
     (only SVM part is currently implemented though)=0D
=0D
   - disable the feature for SEV guests as was suggested during the review=
=0D
   - made the vmexit table const again, as was suggested in the review as w=
ell.=0D
=0D
V3:=0D
 * Modified a selftest to cover the KVM_GUESTDBG_BLOCKIRQ=0D
 * Rebased on kvm/queue=0D
=0D
Best regards,=0D
        Maxim Levitsky=0D
=0D
Maxim Levitsky (6):=0D
  KVM: SVM: split svm_handle_invalid_exit=0D
  KVM: x86: add force_intercept_exceptions_mask=0D
  KVM: SVM: implement force_intercept_exceptions_mask=0D
  scripts/gdb: rework lx-symbols gdb script=0D
  KVM: x86: implement KVM_GUESTDBG_BLOCKIRQ=0D
  KVM: selftests: test KVM_GUESTDBG_BLOCKIRQ=0D
=0D
 Documentation/virt/kvm/api.rst                |   1 +=0D
 arch/x86/include/asm/kvm_host.h               |   5 +-=0D
 arch/x86/include/uapi/asm/kvm.h               |   1 +=0D
 arch/x86/kvm/svm/svm.c                        |  87 +++++++-=0D
 arch/x86/kvm/svm/svm.h                        |   6 +-=0D
 arch/x86/kvm/x86.c                            |  12 +-=0D
 arch/x86/kvm/x86.h                            |   2 +=0D
 kernel/module.c                               |   8 +-=0D
 scripts/gdb/linux/symbols.py                  | 203 ++++++++++++------=0D
 .../testing/selftests/kvm/x86_64/debug_regs.c |  24 ++-=0D
 10 files changed, 266 insertions(+), 83 deletions(-)=0D
=0D
-- =0D
2.26.3=0D
=0D

