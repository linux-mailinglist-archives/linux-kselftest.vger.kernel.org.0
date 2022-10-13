Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630615FD8F5
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Oct 2022 14:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiJMMNo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Oct 2022 08:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiJMMNn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Oct 2022 08:13:43 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0544DFAA6D
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Oct 2022 05:13:42 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id il7-20020a17090b164700b0020d1029ceaaso3210725pjb.8
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Oct 2022 05:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9d+vaj1FTruzdJSiSw/Zn2gxH71jsLWJ5ZYfpHyYTxs=;
        b=UsDG2XB62PQ5XB1xZvpayV/A2gNWj251NrNGJ2niovIws3Ap89Cvi7ppbdpGsT4XAn
         CsM9Po61g6KKpq7h49ImCJ5MTMgfn5YW0CvaA0Vhut0JPl6mviCTUHbglLXkoThv2vSM
         sRbxqwQdqWWS9bJG53eRRPDADSJ3RUuVknwCPym09OFJOx0F/6d/gpEyqISDQacUaKHT
         J0P/QQqbRAgCnp/lvcQRrgr2KTNZR8dCIIPi979minW2qiTICJzZUHVrlxSuQ0XZEnxm
         1t4ThURbWcoxPjL7R3iWy0XxFXBwAp4NXfCgoKYC4+NLs9nJ/uH0hnop1MDcBUXtFNPM
         UwXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9d+vaj1FTruzdJSiSw/Zn2gxH71jsLWJ5ZYfpHyYTxs=;
        b=oez8VwqxUFC1gYU7n923mA2Xcemy576bAf2u3qLTPP9c62kR5lP3gTbC/OoPYj+25Q
         FE86JWAZ13XHBAOkqJb/n398yBU/I8CTahXIu6WD+nu+3uNfdEijEtducn2++SEYxh4b
         GWkgKpk4/Mv5ozVJB7YLqEygQFt4xwsDbUf6fm9Oo6i63QE3N6Hmy8AqJ3+rMksdXZrs
         clOa8RCYvKGhrNbVEY0EQor3N8y/JdJoFk8SefTvPa0hib6pOPUpkMub9rNFrNCrlwcp
         M/wJX3hG5QOTpmy2cypCeZL2gaTrNQne4fFoiKsGfgqngd2Esq8V8VVwAaOeretIj/pD
         iC3Q==
X-Gm-Message-State: ACrzQf1+qIeAWnOyFEtVzvSgV23lBT2LGBsBCJ8qiU4LG1M8ufY3BRNI
        0UPSJyqkP+7MpYSu+1lNXdUC583kPN/kafpE
X-Google-Smtp-Source: AMsMyM5HqKeLUwJMedyOvgE6UGTKF9wwH11VsWQ9kDOnJ8QAa/T6/q9l51uL4YUH7Cp/Lb+wWiTfvq500YGo5tjM
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:aa7:9614:0:b0:562:b07b:ad62 with SMTP
 id q20-20020aa79614000000b00562b07bad62mr35572057pfg.79.1665663221460; Thu,
 13 Oct 2022 05:13:41 -0700 (PDT)
Date:   Thu, 13 Oct 2022 12:13:15 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221013121319.994170-1-vannapurve@google.com>
Subject: [V3 PATCH 0/4] Minor improvements to the selftest setup logic
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This series is posted in context of the discussion at:
https://lore.kernel.org/lkml/Ywa9T+jKUpaHLu%2Fl@google.com/

Changes in v3:
* Original series is split into two and this v3 version contains the
  improvements to selftest and VM setup.
  * Planning to upload the second series to execute hypercall
    instruction according to cpu type separately.
* Addressed comments from David and Sean.

link to v2:
https://lore.kernel.org/all/20220915000448.1674802-1-vannapurve@google.com/

Changes in v2:
* Addressed comments from Andrew and David
  * Common function with constructor attribute used to setup initial state
  * Changes are split in more logical granules as per feedback

Major changes:
1) Move common startup logic to a single function in kvm_util.c
2) Introduce following APIs:
	kvm_selftest_arch_init: to perform arch specific common startup.
	kvm_arch_vm_post_create: to update the guest memory state to convey
		common information to guests.
3) For x86, capture cpu type at startup and pass on the cpu type to
guest after guest elf is loaded.

Vishal Annapurve (4):
  KVM: selftests: move common startup logic to kvm_util.c
  KVM: selftests: Add arch specific initialization
  KVM: selftests: Add arch specific post vm creation hook
  KVM: selftests: x86: Precompute the cpu type

 .../selftests/kvm/aarch64/arch_timer.c        |  3 ---
 .../selftests/kvm/aarch64/hypercalls.c        |  2 --
 .../testing/selftests/kvm/aarch64/vgic_irq.c  |  3 ---
 .../selftests/kvm/include/kvm_util_base.h     |  9 ++++++++
 .../selftests/kvm/lib/aarch64/processor.c     | 18 ++++++++--------
 tools/testing/selftests/kvm/lib/kvm_util.c    | 21 ++++++++++++++++---
 .../selftests/kvm/lib/x86_64/processor.c      | 16 ++++++++++++--
 .../testing/selftests/kvm/memslot_perf_test.c |  3 ---
 tools/testing/selftests/kvm/rseq_test.c       |  3 ---
 tools/testing/selftests/kvm/s390x/memop.c     |  2 --
 tools/testing/selftests/kvm/s390x/resets.c    |  2 --
 .../selftests/kvm/s390x/sync_regs_test.c      |  3 ---
 .../selftests/kvm/set_memory_region_test.c    |  3 ---
 .../kvm/x86_64/cr4_cpuid_sync_test.c          |  3 ---
 .../kvm/x86_64/emulator_error_test.c          |  3 ---
 .../selftests/kvm/x86_64/hyperv_cpuid.c       |  3 ---
 .../selftests/kvm/x86_64/platform_info_test.c |  3 ---
 .../kvm/x86_64/pmu_event_filter_test.c        |  3 ---
 .../selftests/kvm/x86_64/set_sregs_test.c     |  3 ---
 .../kvm/x86_64/svm_nested_soft_inject_test.c  |  3 ---
 .../selftests/kvm/x86_64/sync_regs_test.c     |  3 ---
 .../selftests/kvm/x86_64/userspace_io_test.c  |  3 ---
 .../kvm/x86_64/userspace_msr_exit_test.c      |  3 ---
 23 files changed, 50 insertions(+), 68 deletions(-)

-- 
2.38.0.rc1.362.ged0d419d3c-goog

