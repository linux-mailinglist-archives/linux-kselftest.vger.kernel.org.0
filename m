Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDE3617F16
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Nov 2022 15:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbiKCOPE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Nov 2022 10:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiKCOPD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Nov 2022 10:15:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39221631A
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Nov 2022 07:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667484842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=odaUvMDXgvSntdOJJknK7kUP+2tj3J/gbKRqneFbKT4=;
        b=czZ8fr/Am9tT2+A2r3j+VP6TBND5lswaAN/Nhwd9dn+2Ih54d2fc3EkJIPKxma2GF0J+lr
        xqzts/8kEJk18QyJugtw3FPp6k3m1hdE374HcGb+ifcGWxn3t8yH9iiUM8muqGIxGTt/6w
        UC7fQcuJN/5kSqsx4OtHu/Dpoe7NhUc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-581-R5hAamjFMQKXtliSrCsTJA-1; Thu, 03 Nov 2022 10:13:57 -0400
X-MC-Unique: R5hAamjFMQKXtliSrCsTJA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C2D4E1C087AB;
        Thu,  3 Nov 2022 14:13:55 +0000 (UTC)
Received: from amdlaptop.tlv.redhat.com (dhcp-4-238.tlv.redhat.com [10.35.4.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2B52140C6EC3;
        Thu,  3 Nov 2022 14:13:52 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Chenyi Qiang <chenyi.qiang@intel.com>,
        Yang Zhong <yang.zhong@intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Colton Lewis <coltonlewis@google.com>,
        Borislav Petkov <bp@alien8.de>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Jim Mattson <jmattson@google.com>,
        linux-kselftest@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Wei Wang <wei.w.wang@intel.com>,
        David Matlack <dmatlack@google.com>
Subject: [PATCH v2 0/9] nSVM: Security and correctness fixes
Date:   Thu,  3 Nov 2022 16:13:42 +0200
Message-Id: <20221103141351.50662-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Recently while trying to fix some unit tests I found a CVE in SVM nested co=
de.=0D
=0D
In 'shutdown_interception' vmexit handler we call kvm_vcpu_reset.=0D
=0D
However if running nested and L1 doesn't intercept shutdown, we will still =
end=0D
up running this function and trigger a bug in it.=0D
=0D
The bug is that this function resets the 'vcpu->arch.hflags' without proper=
ly=0D
leaving the nested state, which leaves the vCPU in inconsistent state, whic=
h=0D
later triggers a kernel panic in SVM code.=0D
=0D
The same bug can likely be triggered by sending INIT via local apic to a vC=
PU=0D
which runs a nested guest.=0D
=0D
On VMX we are lucky that the issue can't happen because VMX always intercep=
ts=0D
triple faults, thus triple fault in L2 will always be redirected to L1.=0D
Plus the 'handle_triple_fault' of VMX doesn't reset the vCPU.=0D
=0D
INIT IPI can't happen on VMX either because INIT events are masked while in=
=0D
VMX mode.=0D
=0D
First 4 patches in this series address the above issue, and are=0D
already posted on the list with title,=0D
('nSVM: fix L0 crash if L2 has shutdown condtion which L1 doesn't intercept=
')=0D
I addressed the review feedback and also added a unit test to hit this issu=
e.=0D
=0D
In addition to these patches I noticed that KVM doesn't honour SHUTDOWN int=
ercept bit=0D
of L1 on SVM, and I included a fix to do so - its only for correctness=0D
as a normal hypervisor should always intercept SHUTDOWN.=0D
A unit test on the other hand might want to not do so.=0D
I also extendted the triple_fault_test selftest to hit this issue.=0D
=0D
Finaly I found another security issue, I found a way to=0D
trigger a kernel non rate limited printk on SVM from the guest, and=0D
last patch in the series fixes that.=0D
=0D
A unit test I posted to kvm-unit-tests project hits this issue, so=0D
no selftest was added.=0D
=0D
Best regards,=0D
	Maxim Levitsky=0D
=0D
Maxim Levitsky (9):=0D
  KVM: x86: nSVM: leave nested mode on vCPU free=0D
  KVM: x86: nSVM: harden svm_free_nested against freeing vmcb02 while=0D
    still in use=0D
  KVM: x86: add kvm_leave_nested=0D
  KVM: x86: forcibly leave nested mode on vCPU reset=0D
  KVM: selftests: move idt_entry to header=0D
  kvm: selftests: add svm nested shutdown test=0D
  KVM: x86: allow L1 to not intercept triple fault=0D
  KVM: selftests: add svm part to triple_fault_test=0D
  KVM: x86: remove exit_int_info warning in svm_handle_exit=0D
=0D
 arch/x86/kvm/svm/nested.c                     | 12 ++-=0D
 arch/x86/kvm/svm/svm.c                        | 10 +--=0D
 arch/x86/kvm/vmx/nested.c                     |  4 +-=0D
 arch/x86/kvm/x86.c                            | 29 ++++++--=0D
 tools/testing/selftests/kvm/.gitignore        |  1 +=0D
 tools/testing/selftests/kvm/Makefile          |  1 +=0D
 .../selftests/kvm/include/x86_64/processor.h  | 13 ++++=0D
 .../selftests/kvm/lib/x86_64/processor.c      | 13 ----=0D
 .../kvm/x86_64/svm_nested_shutdown_test.c     | 67 +++++++++++++++++=0D
 .../kvm/x86_64/triple_fault_event_test.c      | 73 ++++++++++++++-----=0D
 10 files changed, 172 insertions(+), 51 deletions(-)=0D
 create mode 100644 tools/testing/selftests/kvm/x86_64/svm_nested_shutdown_=
test.c=0D
=0D
-- =0D
2.34.3=0D
=0D

