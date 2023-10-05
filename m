Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3927BA1DA
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Oct 2023 17:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjJEPBN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Oct 2023 11:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjJEO7p (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Oct 2023 10:59:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384F499D5
        for <linux-kselftest@vger.kernel.org>; Thu,  5 Oct 2023 07:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696516724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Dv/Tj9QdaUN/Br120dwAsxWiHl/rp7FzLwgEPtUXlX4=;
        b=GVac4B7acrHxw1YkUFH3e7DEaeDJdjw/AD43y+b8QlU8DT35Uxl5zUvsv1pIwHMDJoKsJV
        NVnlKZIrNsh9yg3nFUeTynwB6Kc81TuX6r/JKPUlHUwez2YL996oNytOZ56fg4dcJMwrdk
        VSKaXxyacFSlKRmDhn8d8C41S8dha2E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-487-JabyE1AROsuedgPQHMod8A-1; Thu, 05 Oct 2023 10:38:42 -0400
X-MC-Unique: JabyE1AROsuedgPQHMod8A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4DDC8803498;
        Thu,  5 Oct 2023 14:38:42 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8C9F940C6EA8;
        Thu,  5 Oct 2023 14:38:40 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v2 0/7] Use TAP in some more x86 KVM selftests
Date:   Thu,  5 Oct 2023 16:38:32 +0200
Message-ID: <20231005143839.365297-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Here's a follow-up from my RFC series last year:

 https://lore.kernel.org/lkml/20221004093131.40392-1-thuth@redhat.com/T/

and from v1 earlier this year:

 https://lore.kernel.org/kvm/20230712075910.22480-1-thuth@redhat.com/

Basic idea of this series is now to use the kselftest_harness.h
framework to get TAP output in the tests, so that it is easier
for the user to see what is going on, and e.g. to be able to
detect whether a certain test is part of the test binary or not
(which is useful when tests get extended in the course of time).

v2:
- Dropped the "Rename the ASSERT_EQ macro" patch (already merged)
- Split the fixes in the sync_regs_test into separate patches
  (see the first two patches)
- Introduce the KVM_ONE_VCPU_TEST_SUITE() macro as suggested
  by Sean (see third patch) and use it in the following patches
- Add a new patch to convert vmx_pmu_caps_test.c, too

Thomas Huth (7):
  KVM: selftests: x86: sync_regs_test: Use vcpu_run() where appropriate
  KVM: selftests: x86: sync_regs_test: Get regs structure before
    modifying it
  KVM: selftests: Add a macro to define a test with one vcpu
  KVM: selftests: x86: Use TAP interface in the sync_regs test
  KVM: selftests: x86: Use TAP interface in the fix_hypercall test
  KVM: selftests: x86: Use TAP interface in the vmx_pmu_caps test
  KVM: selftests: x86: Use TAP interface in the userspace_msr_exit test

 .../selftests/kvm/include/kvm_test_harness.h  |  35 +++++
 .../selftests/kvm/x86_64/fix_hypercall_test.c |  27 ++--
 .../selftests/kvm/x86_64/sync_regs_test.c     | 121 +++++++++++++-----
 .../kvm/x86_64/userspace_msr_exit_test.c      |  19 +--
 .../selftests/kvm/x86_64/vmx_pmu_caps_test.c  |  50 ++------
 5 files changed, 160 insertions(+), 92 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/kvm_test_harness.h

-- 
2.41.0

