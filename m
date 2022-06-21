Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36F6553DAC
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jun 2022 23:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356577AbiFUV0V (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Jun 2022 17:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356431AbiFUVZw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Jun 2022 17:25:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696BB30F65;
        Tue, 21 Jun 2022 14:21:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0932B615A8;
        Tue, 21 Jun 2022 21:21:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97576C3411D;
        Tue, 21 Jun 2022 21:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655846506;
        bh=3+kfBJXx7bJFsPBrjotmt2oV78Cw71odr1QKUuLojLM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KJJq2VgXa+HRfEWPrWr6wGrH+KLybyVRS3X29halPEF+fdhKVk8eCcIC1pamlw2sM
         R7Ne+cBgx1qbNzTgtw/0YL/UXvWWoZ9rCiMRMJw/NClyPi246FStSKOJGjnXDc4E1j
         dddHKRbdgP9qUfv0z9TMDiwhwyBkeOde5OInh55dqd2NGigPUr7cyQvb2y/eRlHDO0
         RAdQsQFa2q919yDxwUBFh1m5A7bj7nAcSeBmR9sNYLvW7oSb2dnwbdHv5qW9eb9Nfv
         GDCS+aR9vhdSJXEdTUNn5tQp5gliSo3ze80cISGnWcjJKNdPq/B9gnCy5T3DDcMz+4
         xaMaVDqas3dvg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Matlack <dmatlack@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>, shuah@kernel.org,
        bgardon@google.com, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH MANUALSEL 5.17 3/3] KVM: selftests: Restrict test region to 48-bit physical addresses when using nested
Date:   Tue, 21 Jun 2022 17:21:39 -0400
Message-Id: <20220621212139.251808-3-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220621212139.251808-1-sashal@kernel.org>
References: <20220621212139.251808-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: David Matlack <dmatlack@google.com>

[ Upstream commit e0f3f46e42064a51573914766897b4ab95d943e3 ]

The selftests nested code only supports 4-level paging at the moment.
This means it cannot map nested guest physical addresses with more than
48 bits. Allow perf_test_util nested mode to work on hosts with more
than 48 physical addresses by restricting the guest test region to
48-bits.

While here, opportunistically fix an off-by-one error when dealing with
vm_get_max_gfn(). perf_test_util.c was treating this as the maximum
number of GFNs, rather than the maximum allowed GFN. This didn't result
in any correctness issues, but it did end up shifting the test region
down slightly when using huge pages.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Message-Id: <20220520233249.3776001-12-dmatlack@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../testing/selftests/kvm/lib/perf_test_util.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/perf_test_util.c b/tools/testing/selftests/kvm/lib/perf_test_util.c
index 722df3a28791..ddd68ba0c99f 100644
--- a/tools/testing/selftests/kvm/lib/perf_test_util.c
+++ b/tools/testing/selftests/kvm/lib/perf_test_util.c
@@ -110,6 +110,7 @@ struct kvm_vm *perf_test_create_vm(enum vm_guest_mode mode, int vcpus,
 	struct kvm_vm *vm;
 	uint64_t guest_num_pages;
 	uint64_t backing_src_pagesz = get_backing_src_pagesz(backing_src);
+	uint64_t region_end_gfn;
 	int i;
 
 	pr_info("Testing guest mode: %s\n", vm_guest_mode_string(mode));
@@ -144,18 +145,29 @@ struct kvm_vm *perf_test_create_vm(enum vm_guest_mode mode, int vcpus,
 
 	pta->vm = vm;
 
+	/* Put the test region at the top guest physical memory. */
+	region_end_gfn = vm_get_max_gfn(vm) + 1;
+
+#ifdef __x86_64__
+	/*
+	 * When running vCPUs in L2, restrict the test region to 48 bits to
+	 * avoid needing 5-level page tables to identity map L2.
+	 */
+	if (pta->nested)
+		region_end_gfn = min(region_end_gfn, (1UL << 48) / pta->guest_page_size);
+#endif
 	/*
 	 * If there should be more memory in the guest test region than there
 	 * can be pages in the guest, it will definitely cause problems.
 	 */
-	TEST_ASSERT(guest_num_pages < vm_get_max_gfn(vm),
+	TEST_ASSERT(guest_num_pages < region_end_gfn,
 		    "Requested more guest memory than address space allows.\n"
 		    "    guest pages: %" PRIx64 " max gfn: %" PRIx64
 		    " vcpus: %d wss: %" PRIx64 "]\n",
-		    guest_num_pages, vm_get_max_gfn(vm), vcpus,
+		    guest_num_pages, region_end_gfn - 1, vcpus,
 		    vcpu_memory_bytes);
 
-	pta->gpa = (vm_get_max_gfn(vm) - guest_num_pages) * pta->guest_page_size;
+	pta->gpa = (region_end_gfn - guest_num_pages) * pta->guest_page_size;
 	pta->gpa = align_down(pta->gpa, backing_src_pagesz);
 #ifdef __s390x__
 	/* Align to 1M (segment size) */
-- 
2.35.1

