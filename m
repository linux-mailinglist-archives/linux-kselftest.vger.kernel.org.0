Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9016688F89
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Feb 2023 07:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjBCGM1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Feb 2023 01:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbjBCGM0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Feb 2023 01:12:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DDE8BDFB
        for <linux-kselftest@vger.kernel.org>; Thu,  2 Feb 2023 22:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675404651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Kg33H3/wUydkKVCKyNEhJogbcog6B4rvz4IVVy4bwwA=;
        b=jHeSz/Bv8I5wHdCkfy4agO5e0/GFEtB3OyrlXfz6sRVs9Q5IaatkRrfhVgBAReXiqDu34y
        +PFfMqpBbR88MjJ8wWRrggqsD2sVgzQydy6gibcZyTYUsIZCiacIS764d+f8lu0dhLdh0I
        CYawZwAbBaBi9sONldtbTwpRg1w3sqs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-335-pNHOeXd8MCuw1ZjvvZCBSQ-1; Fri, 03 Feb 2023 01:10:47 -0500
X-MC-Unique: pNHOeXd8MCuw1ZjvvZCBSQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AA85185A588;
        Fri,  3 Feb 2023 06:10:46 +0000 (UTC)
Received: from q.redhat.com (unknown [10.66.61.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F387E2026FFB;
        Fri,  3 Feb 2023 06:10:40 +0000 (UTC)
From:   shahuang@redhat.com
To:     kvm@vger.kernel.org
Cc:     Shaoqin Huang <shahuang@redhat.com>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:KERNEL VIRTUAL
        MACHINE FOR ARM64 (KVM/arm64)),
        kvmarm@lists.linux.dev (open list:KERNEL VIRTUAL MACHINE FOR ARM64
        (KVM/arm64)),
        kvmarm@lists.cs.columbia.edu (moderated list:KERNEL VIRTUAL MACHINE FOR
        ARM64 (KVM/arm64)),
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] KVM: selftests: Remove redundant setbuf()
Date:   Fri,  3 Feb 2023 14:10:36 +0800
Message-Id: <20230203061038.277655-1-shahuang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Shaoqin Huang <shahuang@redhat.com>

Since setbuf(stdout, NULL) has been called in kvm_util.c with
__attribute((constructor)). Selftests no need to setup it in their own
code.

Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
---
 tools/testing/selftests/kvm/aarch64/page_fault_test.c          | 2 --
 .../selftests/kvm/x86_64/exit_on_emulation_failure_test.c      | 3 ---
 2 files changed, 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/page_fault_test.c b/tools/testing/selftests/kvm/aarch64/page_fault_test.c
index beb944fa6fd4..513b20bec3c2 100644
--- a/tools/testing/selftests/kvm/aarch64/page_fault_test.c
+++ b/tools/testing/selftests/kvm/aarch64/page_fault_test.c
@@ -1093,8 +1093,6 @@ int main(int argc, char *argv[])
 	enum vm_mem_backing_src_type src_type;
 	int opt;
 
-	setbuf(stdout, NULL);
-
 	src_type = DEFAULT_VM_MEM_SRC;
 
 	while ((opt = getopt(argc, argv, "hm:s:")) != -1) {
diff --git a/tools/testing/selftests/kvm/x86_64/exit_on_emulation_failure_test.c b/tools/testing/selftests/kvm/x86_64/exit_on_emulation_failure_test.c
index 37c61f712fd5..e334844d6e1d 100644
--- a/tools/testing/selftests/kvm/x86_64/exit_on_emulation_failure_test.c
+++ b/tools/testing/selftests/kvm/x86_64/exit_on_emulation_failure_test.c
@@ -26,9 +26,6 @@ int main(int argc, char *argv[])
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 
-	/* Tell stdout not to buffer its content */
-	setbuf(stdout, NULL);
-
 	TEST_REQUIRE(kvm_has_cap(KVM_CAP_EXIT_ON_EMULATION_FAILURE));
 
 	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
-- 
2.39.0

