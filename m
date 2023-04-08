Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6E56DB8B1
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Apr 2023 06:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjDHEAq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 8 Apr 2023 00:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjDHEAo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 8 Apr 2023 00:00:44 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091E6E04F;
        Fri,  7 Apr 2023 21:00:43 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5144a9c11c7so239398a12.2;
        Fri, 07 Apr 2023 21:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680926442; x=1683518442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=unH+fWcNwVMc4/m+QY2lOb5+1jkFSiaecoJbQLZexkQ=;
        b=TKnbOTcLocqQ2UusYfn6Us8cVF34l4WBWuqok/u51/uyL5BjN18WSeC6z+i/CeU489
         DX3GrxfgC2wthiNYrfVLCqwJ44fKODT5/VkP25mnxbKMemJTlSr1OgBv/Kwn/23N3hmQ
         BB7qv2JJmIpVXP3+oMRT+dgWFPSYsICbUmTpXk6kj9zlR8HrBxrRvXxACj0XA+uBYLdA
         W9QCbhsap7oAHz9ntW+41a6K26o7tHylHPWRktn6gyTa+ate0PjjhR/pwlIea4cZ7z1N
         O8pO66rEMhlVah1kPHPmPPqWc3SJ9e/x5+MY81Fk5V9N1ZLtcP8kCevvGjrAmuNapC0V
         HaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680926442; x=1683518442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=unH+fWcNwVMc4/m+QY2lOb5+1jkFSiaecoJbQLZexkQ=;
        b=QG2O99L0ibv8/Hz8IWqPFrQCEb4aLAzw/vbfIRCGBLRnmNPn/vQVzzFdt30eJOxAxy
         tiV5+xpOY+TCz3J5r24QvRBCV6SBDsAsSFBvCvFZz0BxhrkXSG86vBnJ/rRRC5jgYMe3
         5zthqSREG5Akc6CgA9vgPKdGp62385xJ+E/s2SueSJYgbbZlhMfnLNjZKmNvbpoBL8P4
         l7E6Jz9qEFdGBFweLzMWj51Lg3MDsdsx8nHNKpuWpxo5U5zmJiOvf81lI642NbZpYJif
         WlPFR4O9LHhmOLWTIpSuS+0yWVS9h10S9fHkgS+5Y+WpXayo/eq4a3Ezd8QOAOvrmlkG
         nJcw==
X-Gm-Message-State: AAQBX9fm3O/WdLxXN8cadSu5rnh+40uIUkjM7WNPT8dNsF2RetOIGZx+
        5btKvzE2AeoYgZcEWqzDJZo=
X-Google-Smtp-Source: AKy350b5GtmYLXAIhhFklYnJXBu5LgydaeEDK4ky0aUKG6RmVXG+EpiWnUIX86ANdpXUiuyBwu+HKA==
X-Received: by 2002:aa7:96d3:0:b0:627:e577:4331 with SMTP id h19-20020aa796d3000000b00627e5774331mr4408583pfq.1.1680926442520;
        Fri, 07 Apr 2023 21:00:42 -0700 (PDT)
Received: from wheely.local0.net ([203.59.189.25])
        by smtp.gmail.com with ESMTPSA id o12-20020a056a001bcc00b006328ee1e56csm263872pfw.2.2023.04.07.21.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 21:00:41 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>, Shuah Khan <shuah@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 2/4] KVM: selftests: Add aligned guest physical page allocator
Date:   Sat,  8 Apr 2023 14:00:18 +1000
Message-Id: <20230408040020.868929-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230408040020.868929-1-npiggin@gmail.com>
References: <20230408040020.868929-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

powerpc will require this to allocate MMU tables in guest memory that
are aligned and larger than the base page size.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 .../selftests/kvm/include/kvm_util_base.h     |  2 +
 tools/testing/selftests/kvm/lib/kvm_util.c    | 44 ++++++++++++-------
 2 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 16425da16861..8a27bd4111ff 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -679,6 +679,8 @@ const char *exit_reason_str(unsigned int exit_reason);
 
 vm_paddr_t vm_phy_page_alloc(struct kvm_vm *vm, vm_paddr_t paddr_min,
 			     uint32_t memslot);
+vm_paddr_t vm_phy_pages_alloc_align(struct kvm_vm *vm, size_t num, size_t align,
+			      vm_paddr_t paddr_min, uint32_t memslot);
 vm_paddr_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
 			      vm_paddr_t paddr_min, uint32_t memslot);
 vm_paddr_t vm_alloc_page_table(struct kvm_vm *vm);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 8ec20ac33de0..4f15bbbb8f5e 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1898,6 +1898,7 @@ const char *exit_reason_str(unsigned int exit_reason)
  * Input Args:
  *   vm - Virtual Machine
  *   num - number of pages
+ *   align - pages alignment
  *   paddr_min - Physical address minimum
  *   memslot - Memory region to allocate page from
  *
@@ -1911,7 +1912,7 @@ const char *exit_reason_str(unsigned int exit_reason)
  * and their base address is returned. A TEST_ASSERT failure occurs if
  * not enough pages are available at or above paddr_min.
  */
-vm_paddr_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
+vm_paddr_t vm_phy_pages_alloc_align(struct kvm_vm *vm, size_t num, size_t align,
 			      vm_paddr_t paddr_min, uint32_t memslot)
 {
 	struct userspace_mem_region *region;
@@ -1925,24 +1926,27 @@ vm_paddr_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
 		paddr_min, vm->page_size);
 
 	region = memslot2region(vm, memslot);
-	base = pg = paddr_min >> vm->page_shift;
-
-	do {
-		for (; pg < base + num; ++pg) {
-			if (!sparsebit_is_set(region->unused_phy_pages, pg)) {
-				base = pg = sparsebit_next_set(region->unused_phy_pages, pg);
-				break;
+	base = paddr_min >> vm->page_shift;
+
+again:
+	base = (base + align - 1) & ~(align - 1);
+	for (pg = base; pg < base + num; ++pg) {
+		if (!sparsebit_is_set(region->unused_phy_pages, pg)) {
+			base = sparsebit_next_set(region->unused_phy_pages, pg);
+			if (!base) {
+				fprintf(stderr, "No guest physical pages "
+					"available, paddr_min: 0x%lx "
+					"page_size: 0x%x memslot: %u "
+					"num_pages: %lu align: %lu\n",
+					paddr_min, vm->page_size, memslot,
+					num, align);
+				fputs("---- vm dump ----\n", stderr);
+				vm_dump(stderr, vm, 2);
+				TEST_ASSERT(false, "false");
+				abort();
 			}
+			goto again;
 		}
-	} while (pg && pg != base + num);
-
-	if (pg == 0) {
-		fprintf(stderr, "No guest physical page available, "
-			"paddr_min: 0x%lx page_size: 0x%x memslot: %u\n",
-			paddr_min, vm->page_size, memslot);
-		fputs("---- vm dump ----\n", stderr);
-		vm_dump(stderr, vm, 2);
-		abort();
 	}
 
 	for (pg = base; pg < base + num; ++pg)
@@ -1951,6 +1955,12 @@ vm_paddr_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
 	return base * vm->page_size;
 }
 
+vm_paddr_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
+			      vm_paddr_t paddr_min, uint32_t memslot)
+{
+	return vm_phy_pages_alloc_align(vm, num, 1, paddr_min, memslot);
+}
+
 vm_paddr_t vm_phy_page_alloc(struct kvm_vm *vm, vm_paddr_t paddr_min,
 			     uint32_t memslot)
 {
-- 
2.40.0

