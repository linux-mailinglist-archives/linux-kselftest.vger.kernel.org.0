Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B0D59A451
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Aug 2022 20:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350368AbiHSRBd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Aug 2022 13:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354564AbiHSRA1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Aug 2022 13:00:27 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E429133A62;
        Fri, 19 Aug 2022 09:21:12 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660926070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5hkt6s+kNeBeIfkMLCBhtmNEE4XpaiKh/lt918dPnd0=;
        b=kmyW5NALJA/IWF7+aNqifmKM6VmbO+VGRyI/MIPPXjd+bLP4ePxgJ183oed0sF7O2Lb6ly
        l5z7FG+AO5zZVOL30StU6yxtit8hfukRfFjfeIIc8R4pS4AvVtpcPpf+ztLKq0g65toIEI
        JF8kPoVkWCToADVBuyrfQbKrO6ZKcMo=
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Reiji Watanabe <reijiw@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] KVM: selftests: Update top-of-file comment in psci_test
Date:   Fri, 19 Aug 2022 16:21:00 +0000
Message-Id: <20220819162100.213854-1-oliver.upton@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix the comment to accurately describe the test and recently added
SYSTEM_SUSPEND test case.

What was once psci_cpu_on_test was renamed and extended to squeeze in a
test case for PSCI SYSTEM_SUSPEND. Nonetheless, the author of those
changes (whoever they may be...) failed to update the file comment to
reflect what had changed.

Reported-by: Reiji Watanabe <reijiw@google.com>
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---

Forgetting the name of the darned UAPI event. Tsk tsk.

 tools/testing/selftests/kvm/aarch64/psci_test.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/psci_test.c b/tools/testing/selftests/kvm/aarch64/psci_test.c
index f7621f6e938e..e0b9e81a3e09 100644
--- a/tools/testing/selftests/kvm/aarch64/psci_test.c
+++ b/tools/testing/selftests/kvm/aarch64/psci_test.c
@@ -1,12 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * psci_cpu_on_test - Test that the observable state of a vCPU targeted by the
- * CPU_ON PSCI call matches what the caller requested.
+ * psci_test - Tests relating to KVM's PSCI implementation.
  *
  * Copyright (c) 2021 Google LLC.
  *
- * This is a regression test for a race between KVM servicing the PSCI call and
- * userspace reading the vCPUs registers.
+ * This test includes:
+ *  - A regression test for a race between KVM servicing the PSCI CPU_ON call
+ *    and userspace reading the targeted vCPU's registers.
+ *  - A test for KVM's handling of PSCI SYSTEM_SUSPEND and the associated
+ *    KVM_SYSTEM_EVENT_SUSPEND UAPI.
  */
 
 #define _GNU_SOURCE

base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
-- 
2.37.1.595.g718a3a8f04-goog

