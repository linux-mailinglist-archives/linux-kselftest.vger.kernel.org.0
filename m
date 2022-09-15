Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15D85B9163
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Sep 2022 02:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiIOAE4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Sep 2022 20:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiIOAEy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Sep 2022 20:04:54 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698B2AE68
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Sep 2022 17:04:51 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id q6-20020a17090311c600b0017266460b8fso11330108plh.4
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Sep 2022 17:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=q3GD4NwlYUx8gdey9sVlOvilOE2N0wjdZ+RZokGXIPk=;
        b=ptOjhF7RAuYFIrc21q9YMD99UfLwglHnRBYUx2py1KYcThN9CU/C4yYf28D+VvHsIJ
         DeG3/ZbIfDRAJv37U7foDlw4KVhM8Su7Bi5hzto9KpO8AymXg3jejexjVANsFbx1PuLM
         rrcjorBXqt4sbozTIc9ercFwsuauJPRUSWuf2JxjRGQwpyScZFYGeJovw3MTBBiAeP9J
         jMNHpDUeZRryQrDvfhti7EVvExFZ9R9coGQd3Uqk1s9TFDGnrrP1G50AJaU8ZRia+grF
         z9Hm3jRgpflSsg2AV9UtfIX0YZsKhW7+LPYeDe6EJpLxvHwIjiYlR+GhvPArtBtJZNnY
         ZaLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=q3GD4NwlYUx8gdey9sVlOvilOE2N0wjdZ+RZokGXIPk=;
        b=30TyZTHKT8xyWWKoP6ObNMzZUI9TPCvKR7EMB50qtlex3inSLFAt5AsksnRIu6hZ5K
         tdCGEHf6KvWJXCdoSmKq9HYvFfpH4iXm3WPUSCjM8xd9JTLzotxRNTef8NM5214NVLMg
         ft+V7oIIIdywXrxGGZ7Lsb+C20xoOSZ7i1R777Yieutt8tmC7FanZLrSMnYkx6i+q2it
         VZE6YKSDrUSaZsS/h2WgZdX/LCgf59aOFSdNaxZHM1mnJh6TzBoyk2CsT6bZyL+n+9dQ
         w6fXFq4MEldjedt+erP7thnsBdwHffaOtAXmwjTCRkUFsstWgJsYNo/fr0TUGsDS9IY8
         jVBQ==
X-Gm-Message-State: ACrzQf38H98PFwKW+j4me40+Navmxp3xKZFiE4iO1OFnBvX/CFkC51Mv
        8aVSP9HGM2nhbjnU3AKkn3tLmlTNf+sHKlgW
X-Google-Smtp-Source: AMsMyM51rYBali47oquei1QQzpoYjbSCTo1142oz9rhffNt+VP5FbcWjjAwhQozvf3hlJqGVJ1OB387FELZgYN1i
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a17:902:ab8e:b0:174:11d5:b2ec with SMTP
 id f14-20020a170902ab8e00b0017411d5b2ecmr1544268plr.18.1663200290870; Wed, 14
 Sep 2022 17:04:50 -0700 (PDT)
Date:   Thu, 15 Sep 2022 00:04:40 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220915000448.1674802-1-vannapurve@google.com>
Subject: [V2 PATCH 0/8] Execute hypercalls from guests according to cpu type
From:   Vishal Annapurve <vannapurve@google.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, shuah@kernel.org, bgardon@google.com,
        seanjc@google.com, oupton@google.com, peterx@redhat.com,
        vkuznets@redhat.com, dmatlack@google.com,
        Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This series is posted in context of the discussion at:
https://lore.kernel.org/lkml/Ywa9T+jKUpaHLu%2Fl@google.com/

Changes in v2:
* Addressed comments from Andrew and David
  * Common function with constructor attribute used to setup initial state
  * Changes are split in more logical granules as per feedback

Major changes:
1) Move common startup logic to a single function in kvm_util.c
2) Introduce following APIs:
	kvm_selftest_arch_init: to perform arch specific common startup.
	kvm_arch_post_vm_elf_load: to update the guest memory state to convey
		common information to guests.
3) For x86, capture cpu type at startup and pass on the cpu type to
guest after guest elf is loaded.
4) Execute hypercall instruction from within guest VMs according to the
cpu type. This will help prevent an extra kvm exit during hypercall
execution.

Vishal Annapurve (8):
  KVM: selftests: move common startup logic to kvm_util.c
  KVM: selftests: Add arch specific initialization
  KVM: selftests: Add arch specific post vm load setup
  KVM: selftests: x86: Precompute the result for is_{intel,amd}_cpu()
  KVM: selftests: x86: delete svm_vmcall_test
  KVM: selftests: x86: Execute cpu specific hypercall from nested guests
  Kvm: selftests: x86: Execute cpu specific vmcall instruction
  KVM: selftests: x86: xen: Execute cpu specific vmcall instruction

 tools/testing/selftests/kvm/.gitignore        |  1 -
 .../selftests/kvm/aarch64/arch_timer.c        |  3 -
 .../selftests/kvm/aarch64/hypercalls.c        |  2 -
 .../testing/selftests/kvm/aarch64/vgic_irq.c  |  3 -
 .../selftests/kvm/include/kvm_util_base.h     |  9 +++
 .../selftests/kvm/include/x86_64/processor.h  | 10 +++
 .../selftests/kvm/include/x86_64/vmx.h        |  9 ---
 .../selftests/kvm/lib/aarch64/processor.c     | 22 +++---
 tools/testing/selftests/kvm/lib/elf.c         |  2 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |  8 ++
 .../selftests/kvm/lib/riscv/processor.c       |  8 ++
 .../selftests/kvm/lib/s390x/processor.c       |  8 ++
 .../selftests/kvm/lib/x86_64/perf_test_util.c |  2 +-
 .../selftests/kvm/lib/x86_64/processor.c      | 38 +++++++++-
 .../testing/selftests/kvm/memslot_perf_test.c |  3 -
 tools/testing/selftests/kvm/rseq_test.c       |  3 -
 tools/testing/selftests/kvm/s390x/memop.c     |  2 -
 tools/testing/selftests/kvm/s390x/resets.c    |  2 -
 .../selftests/kvm/s390x/sync_regs_test.c      |  3 -
 .../selftests/kvm/set_memory_region_test.c    |  3 -
 .../kvm/x86_64/cr4_cpuid_sync_test.c          |  3 -
 .../kvm/x86_64/emulator_error_test.c          |  3 -
 .../selftests/kvm/x86_64/hyperv_cpuid.c       |  3 -
 .../selftests/kvm/x86_64/platform_info_test.c |  3 -
 .../kvm/x86_64/pmu_event_filter_test.c        |  3 -
 .../selftests/kvm/x86_64/set_sregs_test.c     |  3 -
 tools/testing/selftests/kvm/x86_64/smm_test.c |  2 +-
 .../testing/selftests/kvm/x86_64/state_test.c |  8 +-
 .../kvm/x86_64/svm_nested_soft_inject_test.c  |  3 -
 .../selftests/kvm/x86_64/svm_vmcall_test.c    | 74 -------------------
 .../selftests/kvm/x86_64/sync_regs_test.c     |  3 -
 .../selftests/kvm/x86_64/userspace_io_test.c  |  3 -
 .../kvm/x86_64/userspace_msr_exit_test.c      |  3 -
 .../kvm/x86_64/vmx_apic_access_test.c         |  2 +-
 .../selftests/kvm/x86_64/vmx_dirty_log_test.c |  2 +-
 .../kvm/x86_64/vmx_nested_tsc_scaling_test.c  |  2 +-
 .../kvm/x86_64/vmx_preemption_timer_test.c    |  2 +-
 .../kvm/x86_64/vmx_tsc_adjust_test.c          |  2 +-
 .../selftests/kvm/x86_64/xen_shinfo_test.c    | 64 ++++++----------
 .../selftests/kvm/x86_64/xen_vmcall_test.c    | 14 +++-
 40 files changed, 138 insertions(+), 205 deletions(-)
 delete mode 100644 tools/testing/selftests/kvm/x86_64/svm_vmcall_test.c

-- 
2.37.2.789.g6183377224-goog

