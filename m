Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521D8617E8E
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Nov 2022 14:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiKCN6k (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Nov 2022 09:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiKCN6j (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Nov 2022 09:58:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45643140E6
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Nov 2022 06:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667483865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=fUsqybhXp/D82YuS/O33LZfOTzfFB038d5lKiyOEhC8=;
        b=OODV3/lAkc4pzzBsU8BEhraCLDz3bBGlVKpW1NF2WLUOEorsMlhV9Tj5pljfJ7n2htwLIZ
        p/1SXtQH8cE0eDwXrDZ4LOY/HE0pa1c2IXCdC2NzLdJY0fVB9R7X2JHjETTGGV1rd1XkkP
        Ar7j6KSzQ/jAgx15StyGmoPRNjIfPpA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-wG8_w1AzN_-3brZ9aiF0Rw-1; Thu, 03 Nov 2022 09:57:41 -0400
X-MC-Unique: wG8_w1AzN_-3brZ9aiF0Rw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BD30A3815D2F;
        Thu,  3 Nov 2022 13:57:40 +0000 (UTC)
Received: from amdlaptop.tlv.redhat.com (dhcp-4-238.tlv.redhat.com [10.35.4.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 52F8B40C2140;
        Thu,  3 Nov 2022 13:57:37 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
        Yang Zhong <yang.zhong@intel.com>,
        Wei Wang <wei.w.wang@intel.com>,
        Colton Lewis <coltonlewis@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Jim Mattson <jmattson@google.com>,
        Chenyi Qiang <chenyi.qiang@intel.com>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Peter Xu <peterx@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH 0/9] nSVM: Security and correctness fixes
Date:   Thu,  3 Nov 2022 15:57:27 +0200
Message-Id: <20221103135736.42295-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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
 arch/x86/kvm/svm/nested.c                     | 12 +++-=0D
 arch/x86/kvm/svm/svm.c                        | 10 +--=0D
 arch/x86/kvm/vmx/nested.c                     |  4 +-=0D
 arch/x86/kvm/x86.c                            | 29 ++++++--=0D
 tools/testing/selftests/kvm/.gitignore        |  1 +=0D
 tools/testing/selftests/kvm/Makefile          |  1 +=0D
 .../selftests/kvm/include/x86_64/processor.h  | 13 ++++=0D
 .../selftests/kvm/lib/x86_64/processor.c      | 13 ----=0D
 .../kvm/x86_64/svm_nested_shutdown_test.c     | 71 +++++++++++++++++++=0D
 .../kvm/x86_64/triple_fault_event_test.c      | 71 ++++++++++++++-----=0D
 10 files changed, 174 insertions(+), 51 deletions(-)=0D
 create mode 100644 tools/testing/selftests/kvm/x86_64/svm_nested_shutdown_=
test.c=0D
=0D
-- =0D
2.34.3=0D
=0D

