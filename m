Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6301C60CC67
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Oct 2022 14:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbiJYMuL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Oct 2022 08:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbiJYMtq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Oct 2022 08:49:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0B71956E9
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Oct 2022 05:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666702071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=YKqk8JFJPFyZT4uxuIdJDMrDXX3QslvogL56oEpKGVE=;
        b=aGdtZjrwKLeHD5AYaBwW9VrYi5FU3ehFhs2g1OUfJx4yz+7uc3zwXrDzp1uTnZgeH8OSf5
        ABWLPUzszUsAuhc+naPz2BeLVbMlUkfVce78edgE1RuUOYr7XihK9mdD3jvpOGLruNqa6V
        NXHzQHlBHHaJfAQnmzYHQBJwWUUkMwU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-191-nkgboKVhNQ6gqyX7rFkv3A-1; Tue, 25 Oct 2022 08:47:47 -0400
X-MC-Unique: nkgboKVhNQ6gqyX7rFkv3A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C9F0857AA0;
        Tue, 25 Oct 2022 12:47:46 +0000 (UTC)
Received: from amdlaptop.tlv.redhat.com (dhcp-4-238.tlv.redhat.com [10.35.4.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BD31E40C6EC6;
        Tue, 25 Oct 2022 12:47:42 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Yang Zhong <yang.zhong@intel.com>, x86@kernel.org,
        Jim Mattson <jmattson@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Shuah Khan <shuah@kernel.org>,
        Guang Zeng <guang.zeng@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kselftest@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Wei Wang <wei.w.wang@intel.com>,
        Borislav Petkov <bp@alien8.de>
Subject: [PATCH RESEND v4 00/23] SMM emulation and interrupt shadow fixes
Date:   Tue, 25 Oct 2022 15:47:18 +0300
Message-Id: <20221025124741.228045-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch series is a result of long debug work to find out why=0D
sometimes guests with win11 secure boot=0D
were failing during boot.=0D
=0D
During writing a unit test I found another bug, turns out=0D
that on rsm emulation, if the rsm instruction was done in real=0D
or 32 bit mode, KVM would truncate the restored RIP to 32 bit.=0D
=0D
I also refactored the way we write SMRAM so it is easier=0D
now to understand what is going on.=0D
=0D
The main bug in this series which I fixed is that we=0D
allowed #SMI to happen during the STI interrupt shadow,=0D
and we did nothing to both reset it on #SMI handler=0D
entry and restore it on RSM.=0D
=0D
V4:=0D
=0D
 - rebased on top of patch series from Paolo which=0D
   allows smm support to be disabled by Kconfig option.=0D
=0D
 - addressed review feedback.=0D
=0D
I included these patches in the series for reference.=0D
=0D
Best regards,=0D
	Maxim Levitsky=0D
=0D
Maxim Levitsky (15):=0D
  bug: introduce ASSERT_STRUCT_OFFSET=0D
  KVM: x86: emulator: em_sysexit should update ctxt->mode=0D
  KVM: x86: emulator: introduce emulator_recalc_and_set_mode=0D
  KVM: x86: emulator: update the emulation mode after rsm=0D
  KVM: x86: emulator: update the emulation mode after CR0 write=0D
  KVM: x86: smm: number of GPRs in the SMRAM image depends on the image=0D
    format=0D
  KVM: x86: smm: check for failures on smm entry=0D
  KVM: x86: smm: add structs for KVM's smram layout=0D
  KVM: x86: smm: use smram structs in the common code=0D
  KVM: x86: smm: use smram struct for 32 bit smram load/restore=0D
  KVM: x86: smm: use smram struct for 64 bit smram load/restore=0D
  KVM: svm: drop explicit return value of kvm_vcpu_map=0D
  KVM: x86: SVM: use smram structs=0D
  KVM: x86: SVM: don't save SVM state to SMRAM when VM is not long mode=0D
    capable=0D
  KVM: x86: smm: preserve interrupt shadow in SMRAM=0D
=0D
Paolo Bonzini (8):=0D
  KVM: x86: start moving SMM-related functions to new files=0D
  KVM: x86: move SMM entry to a new file=0D
  KVM: x86: move SMM exit to a new file=0D
  KVM: x86: do not go through ctxt->ops when emulating rsm=0D
  KVM: allow compiling out SMM support=0D
  KVM: x86: compile out vendor-specific code if SMM is disabled=0D
  KVM: x86: remove SMRAM address space if SMM is not supported=0D
  KVM: x86: do not define KVM_REQ_SMI if SMM disabled=0D
=0D
 arch/x86/include/asm/kvm-x86-ops.h            |   2 +=0D
 arch/x86/include/asm/kvm_host.h               |  29 +-=0D
 arch/x86/kvm/Kconfig                          |  11 +=0D
 arch/x86/kvm/Makefile                         |   1 +=0D
 arch/x86/kvm/emulate.c                        | 458 +++----------=0D
 arch/x86/kvm/kvm_cache_regs.h                 |   5 -=0D
 arch/x86/kvm/kvm_emulate.h                    |  47 +-=0D
 arch/x86/kvm/lapic.c                          |  14 +-=0D
 arch/x86/kvm/lapic.h                          |   7 +-=0D
 arch/x86/kvm/mmu/mmu.c                        |   1 +=0D
 arch/x86/kvm/smm.c                            | 637 ++++++++++++++++++=0D
 arch/x86/kvm/smm.h                            | 160 +++++=0D
 arch/x86/kvm/svm/nested.c                     |   3 +=0D
 arch/x86/kvm/svm/svm.c                        |  43 +-=0D
 arch/x86/kvm/vmx/nested.c                     |   1 +=0D
 arch/x86/kvm/vmx/vmcs12.h                     |   5 +-=0D
 arch/x86/kvm/vmx/vmx.c                        |  11 +-=0D
 arch/x86/kvm/x86.c                            | 353 +---------=0D
 include/linux/build_bug.h                     |   9 +=0D
 tools/testing/selftests/kvm/x86_64/smm_test.c |   2 +=0D
 20 files changed, 1031 insertions(+), 768 deletions(-)=0D
 create mode 100644 arch/x86/kvm/smm.c=0D
 create mode 100644 arch/x86/kvm/smm.h=0D
=0D
-- =0D
2.34.3=0D
=0D

