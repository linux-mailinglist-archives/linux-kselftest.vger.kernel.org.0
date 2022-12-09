Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDF6647BBC
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Dec 2022 02:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbiLIBye (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Dec 2022 20:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiLIByF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Dec 2022 20:54:05 -0500
Received: from out-149.mta0.migadu.com (out-149.mta0.migadu.com [91.218.175.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54481B1051
        for <linux-kselftest@vger.kernel.org>; Thu,  8 Dec 2022 17:53:48 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <andrew.jones@linux.dev>,
        Peter Gonda <pgonda@google.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        Ricardo Koller <ricarkol@google.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/7] KVM: selftests: Avoid infinite loop if ucall_alloc() fails
Date:   Fri,  9 Dec 2022 01:53:06 +0000
Message-Id: <20221209015307.1781352-8-oliver.upton@linux.dev>
In-Reply-To: <20221209015307.1781352-1-oliver.upton@linux.dev>
References: <20221209015307.1781352-1-oliver.upton@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Guest assertions depend on successfully allocating a ucall structure. As
such, the use of guest assertions when ucall_alloc() fails simply leads
to an infinite loop in guest code.

Use GUEST_UCALL_NONE() to indicate failure instead. Though not
technically necessary, use a goto to have a single callsite and an
associated comment about why assertions don't work here. It isn't
perfect, at least the poor developer gets some signal out of the
guest...

Fixes: 426729b2cf2e ("KVM: selftests: Add ucall pool based implementation")
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 tools/testing/selftests/kvm/lib/ucall_common.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/ucall_common.c b/tools/testing/selftests/kvm/lib/ucall_common.c
index 0cc0971ce60e..e8370da3de24 100644
--- a/tools/testing/selftests/kvm/lib/ucall_common.c
+++ b/tools/testing/selftests/kvm/lib/ucall_common.c
@@ -41,7 +41,8 @@ static struct ucall *ucall_alloc(void)
 	struct ucall *uc;
 	int i;
 
-	GUEST_ASSERT(ucall_pool);
+	if (!ucall_pool)
+		goto out;
 
 	for (i = 0; i < KVM_MAX_VCPUS; ++i) {
 		if (!test_and_set_bit(i, ucall_pool->in_use)) {
@@ -51,7 +52,14 @@ static struct ucall *ucall_alloc(void)
 		}
 	}
 
-	GUEST_ASSERT(0);
+out:
+	/*
+	 * If the guest cannot grab a ucall structure from the pool then the
+	 * only option to get out to userspace is a bare ucall. This is probably
+	 * a good time to mention that guest assertions depend on ucalls with
+	 * arguments too.
+	 */
+	GUEST_UCALL_NONE();
 	return NULL;
 }
 
-- 
2.39.0.rc1.256.g54fd8350bd-goog

