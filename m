Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF7962A43B
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Nov 2022 22:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbiKOViw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Nov 2022 16:38:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238641AbiKOViv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Nov 2022 16:38:51 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB99D120
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Nov 2022 13:38:50 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id c7-20020a170903234700b0018729febd96so12131361plh.19
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Nov 2022 13:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=svCMw+RaLDOYb1vqpYARG5pCSZevHShYbQvFoMbmBJQ=;
        b=pwMbojnsCf9knVk3mY2LzdmP9u4GdT5s825DJV9W8WItQzHCXB3AZYTBakzggIR2zx
         fNvtuTxYjykqA+Pw8MHuptNCqrR6sq43OfbBXFaslxfpCcz8ndxe8JmqzrV5XFX+XFWZ
         OwGjjWsZcD1D1mQ4E6bA8GUpJS6jOFtYJLuA+NMzcL2DhUR8S+Ox9DRWhDmJLz1Ljqvl
         j6w3T6PkAnd/sHMQlaswetwTJpoWzMY8+RwG4CKFS40vMzbxkK+UguvSwdkfTHbEjWtc
         +BdbaZliRcFhWKsmaGoSULZdWrKF/v3TXb+kbAwlowS002KNmUVqjZMXP+JmVbncMQh7
         iriA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=svCMw+RaLDOYb1vqpYARG5pCSZevHShYbQvFoMbmBJQ=;
        b=vdSdgx3WwsWI05qabmx1mOtH6RVCar1XoXC2798/g/dgYlRpaxfXasSR67QDhC/mIi
         h6P4+Y+qwLxhAtNqxPKp6WbRm4UxXap1k+IFTgIeNHklTUSCvGiA4IvTFccSJle6IMTf
         Gvyalf/SVyvHxa6bA6k2vyxJYwFQHaboDGvoZ4lZj6CpdqGqZWTuHXIR2QYK4iRnnVNv
         EKbegTOU9NK6ycRUrgiENJRnqqeHG+qSrsIZjG/DLLxQ7o6/yY75siYrrpSM8G4ReLEU
         mNLJvXPcejy0L/LzIcm4k9hLXWfGWKLaTzT6TGLdPOAcLk65uMbh6Q3KLNapl8nSCW86
         wZcA==
X-Gm-Message-State: ANoB5pkP5st2ynmslImRWYrdYZwb38XnT+NcZvP+DknFfE7asMvHSxuj
        3i3qN3/fr3pgWS37jXKFnyBB06V/1EDsQpwc
X-Google-Smtp-Source: AA0mqf6BP7srN54MyQo4D89SWDafzg4ksV4X4roYb3TAZUxWy47LFnZoHuAXkW20HFnCXSwLIUQDQ7WD3fGoV6I2
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a17:902:cec2:b0:17f:8a20:d9b5 with SMTP
 id d2-20020a170902cec200b0017f8a20d9b5mr5918630plg.76.1668548329463; Tue, 15
 Nov 2022 13:38:49 -0800 (PST)
Date:   Tue, 15 Nov 2022 21:38:42 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221115213845.3348210-1-vannapurve@google.com>
Subject: [V4 PATCH 0/3] Minor improvements to the selftest setup logic
From:   Vishal Annapurve <vannapurve@google.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, shuah@kernel.org, bgardon@google.com,
        seanjc@google.com, oupton@google.com, peterx@redhat.com,
        vkuznets@redhat.com, dmatlack@google.com, pgonda@google.com,
        andrew.jones@linux.dev, Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This series is posted in context of the discussion at:
https://lore.kernel.org/lkml/Ywa9T+jKUpaHLu%2Fl@google.com/

Major changes:
1) Move common startup logic to a single function in kvm_util.c
2) Introduce following APIs:
	kvm_selftest_arch_init: to perform arch specific common startup.
	kvm_arch_vm_post_create: to perform arch specific common setup
		after VM creation.

Changelog
=========
v4:
* Removed the patch to precompute cpu type, will be introduced as part of
  a separate series in future.
v3:
* Original series is split into two and this v3 version contains the
  improvements to selftest and VM setup.
  * Planning to upload the second series to execute hypercall
    instruction according to cpu type separately.
* Addressed comments from David and Sean.
link to v3:
https://lore.kernel.org/lkml/20221013121319.994170-1-vannapurve@google.com/
v2:
* Addressed comments from Andrew and David
  * Common function with constructor attribute used to setup initial state
  * Changes are split in more logical granules as per feedback
link to v2:
https://lore.kernel.org/all/20220915000448.1674802-1-vannapurve@google.com/

Vishal Annapurve (3):
  KVM: selftests: move common startup logic to kvm_util.c
  KVM: selftests: Add arch specific initialization
  KVM: selftests: Add arch specific post vm creation hook

 .../selftests/kvm/aarch64/arch_timer.c        |  3 ---
 .../selftests/kvm/aarch64/hypercalls.c        |  2 --
 .../testing/selftests/kvm/aarch64/vgic_irq.c  |  3 ---
 .../selftests/kvm/include/kvm_util_base.h     |  9 ++++++++
 .../selftests/kvm/lib/aarch64/processor.c     | 18 ++++++++--------
 tools/testing/selftests/kvm/lib/kvm_util.c    | 21 ++++++++++++++++---
 .../selftests/kvm/lib/x86_64/processor.c      |  6 ++++++
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
 23 files changed, 42 insertions(+), 66 deletions(-)

-- 
2.38.1.431.g37b22c650d-goog

