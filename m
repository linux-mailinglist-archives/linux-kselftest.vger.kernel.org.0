Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F26750094
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jul 2023 10:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbjGLIAJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jul 2023 04:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjGLIAI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jul 2023 04:00:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C38B10FA
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jul 2023 00:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689148757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NFh1fy7H4rVXbuwjJ23VCR8o/98dOivY4sK9jDopnVk=;
        b=Ckana5Z16nOhjF7I8MuCDit4GN1McL3zAc6mX7a2FAOLrvQ1D+Nd6dESK5an78LZSYFdt2
        lnfbbkPl8HD3fmZusAcze5ji6yGN9p+z2qX7BFipBMUBa7MVU3b2GNbde4FpUhmTZT8i3L
        AbwwsvHZNW/CSWv2UOkXy3k8jVy1tG0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-13-qQFCFb3RP5OIbUN2ltDXLg-1; Wed, 12 Jul 2023 03:59:14 -0400
X-MC-Unique: qQFCFb3RP5OIbUN2ltDXLg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 29A548EBBA1;
        Wed, 12 Jul 2023 07:59:14 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 97B90492C13;
        Wed, 12 Jul 2023 07:59:12 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     linux-kselftest@vger.kernel.org,
        David Matlack <dmatlack@google.com>
Subject: [PATCH 0/4] Use TAP in some more x86 KVM selftests
Date:   Wed, 12 Jul 2023 09:59:06 +0200
Message-Id: <20230712075910.22480-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Here's a follow-up from my RFC series last year:

 https://lore.kernel.org/lkml/20221004093131.40392-1-thuth@redhat.com/T/

Basic idea of this series is now to use the kselftest_harness.h
framework to get TAP output in the tests, so that it is easier
for the user to see what is going on, and e.g. to be able to
detect whether a certain test is part of the test binary or not
(which is useful when tests get extended in the course of time).

Thomas Huth (4):
  KVM: selftests: Rename the ASSERT_EQ macro
  KVM: selftests: x86: Use TAP interface in the sync_regs test
  KVM: selftests: x86: Use TAP interface in the fix_hypercall test
  KVM: selftests: x86: Use TAP interface in the userspace_msr_exit test

 .../selftests/kvm/aarch64/aarch32_id_regs.c   |   8 +-
 .../selftests/kvm/aarch64/page_fault_test.c   |  10 +-
 .../testing/selftests/kvm/include/test_util.h |   4 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    |   2 +-
 .../selftests/kvm/max_guest_memory_test.c     |   2 +-
 tools/testing/selftests/kvm/s390x/cmma_test.c |  62 +++++-----
 tools/testing/selftests/kvm/s390x/memop.c     |   6 +-
 tools/testing/selftests/kvm/s390x/tprot.c     |   4 +-
 .../x86_64/dirty_log_page_splitting_test.c    |  18 +--
 .../x86_64/exit_on_emulation_failure_test.c   |   2 +-
 .../selftests/kvm/x86_64/fix_hypercall_test.c |  16 ++-
 .../kvm/x86_64/nested_exceptions_test.c       |  12 +-
 .../kvm/x86_64/recalc_apic_map_test.c         |   6 +-
 .../selftests/kvm/x86_64/sync_regs_test.c     | 113 +++++++++++++++---
 .../selftests/kvm/x86_64/tsc_msrs_test.c      |  32 ++---
 .../kvm/x86_64/userspace_msr_exit_test.c      |  19 +--
 .../vmx_exception_with_invalid_guest_state.c  |   2 +-
 .../selftests/kvm/x86_64/vmx_pmu_caps_test.c  |   3 +-
 .../selftests/kvm/x86_64/xapic_state_test.c   |   8 +-
 .../selftests/kvm/x86_64/xen_vmcall_test.c    |  20 ++--
 20 files changed, 218 insertions(+), 131 deletions(-)

-- 
2.39.3

