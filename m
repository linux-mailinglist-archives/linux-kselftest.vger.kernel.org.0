Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8C77C399
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2019 15:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbfGaNca (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Jul 2019 09:32:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34540 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729538AbfGaNca (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Jul 2019 09:32:30 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 61BEC308FC4E;
        Wed, 31 Jul 2019 13:32:29 +0000 (UTC)
Received: from thuth.com (dhcp-200-228.str.redhat.com [10.33.200.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8A7C460852;
        Wed, 31 Jul 2019 13:32:27 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     kvm@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>, Andrew Jones <drjones@redhat.com>
Subject: [PATCH v2 3/3] KVM: selftests: Enable dirty_log_test on s390x
Date:   Wed, 31 Jul 2019 15:32:16 +0200
Message-Id: <20190731133216.5620-4-thuth@redhat.com>
In-Reply-To: <20190731133216.5620-1-thuth@redhat.com>
References: <20190731133216.5620-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 31 Jul 2019 13:32:29 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

To run the dirty_log_test on s390x, we have to make sure that we
access the dirty log bitmap with little endian byte ordering and
we have to properly align the memslot of the guest.
Also all dirty bits of a segment are set once on s390x when one
of the pages of a segment are written to for the first time, so
we have to make sure that we touch all pages during the first
iteration to keep the test in sync here.
DEFAULT_GUEST_TEST_MEM needs an adjustment, too. On some s390x
distributions, the ELF binary is linked to address 0x80000000,
so we have to avoid that our test region overlaps into this area.
0xc0000000 seems to be a good alternative that should work on x86
and aarch64, too.

Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tools/testing/selftests/kvm/Makefile         |  1 +
 tools/testing/selftests/kvm/dirty_log_test.c | 59 +++++++++++++++++---
 2 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 75ea1ecbf85a..1b48a94b4350 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -33,6 +33,7 @@ TEST_GEN_PROGS_aarch64 += dirty_log_test
 TEST_GEN_PROGS_aarch64 += kvm_create_max_vcpus
 
 TEST_GEN_PROGS_s390x += s390x/sync_regs_test
+TEST_GEN_PROGS_s390x += dirty_log_test
 TEST_GEN_PROGS_s390x += kvm_create_max_vcpus
 
 TEST_GEN_PROGS += $(TEST_GEN_PROGS_$(UNAME_M))
diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 5d5ae1be4984..dc3346e090f5 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -26,8 +26,8 @@
 /* The memory slot index to track dirty pages */
 #define TEST_MEM_SLOT_INDEX		1
 
-/* Default guest test memory offset, 1G */
-#define DEFAULT_GUEST_TEST_MEM		0x40000000
+/* Default guest test virtual memory offset */
+#define DEFAULT_GUEST_TEST_MEM		0xc0000000
 
 /* How many pages to dirty for each guest loop */
 #define TEST_PAGES_PER_LOOP		1024
@@ -38,6 +38,27 @@
 /* Interval for each host loop (ms) */
 #define TEST_HOST_LOOP_INTERVAL		10UL
 
+/* Dirty bitmaps are always little endian, so we need to swap on big endian */
+#if defined(__s390x__)
+# define BITOP_LE_SWIZZLE	((BITS_PER_LONG-1) & ~0x7)
+# define test_bit_le(nr, addr) \
+	test_bit((nr) ^ BITOP_LE_SWIZZLE, addr)
+# define set_bit_le(nr, addr) \
+	set_bit((nr) ^ BITOP_LE_SWIZZLE, addr)
+# define clear_bit_le(nr, addr) \
+	clear_bit((nr) ^ BITOP_LE_SWIZZLE, addr)
+# define test_and_set_bit_le(nr, addr) \
+	test_and_set_bit((nr) ^ BITOP_LE_SWIZZLE, addr)
+# define test_and_clear_bit_le(nr, addr) \
+	test_and_clear_bit((nr) ^ BITOP_LE_SWIZZLE, addr)
+#else
+# define test_bit_le		test_bit
+# define set_bit_le		set_bit
+# define clear_bit_le		clear_bit
+# define test_and_set_bit_le	test_and_set_bit
+# define test_and_clear_bit_le	test_and_clear_bit
+#endif
+
 /*
  * Guest/Host shared variables. Ensure addr_gva2hva() and/or
  * sync_global_to/from_guest() are used when accessing from
@@ -69,11 +90,23 @@ static uint64_t guest_test_virt_mem = DEFAULT_GUEST_TEST_MEM;
  */
 static void guest_code(void)
 {
+	uint64_t addr;
 	int i;
 
+	/*
+	 * On s390x, all pages of a 1M segment are initially marked as dirty
+	 * when a page of the segment is written to for the very first time.
+	 * To compensate this specialty in this test, we need to touch all
+	 * pages during the first iteration.
+	 */
+	for (i = 0; i < guest_num_pages; i++) {
+		addr = guest_test_virt_mem + i * guest_page_size;
+		*(uint64_t *)addr = READ_ONCE(iteration);
+	}
+
 	while (true) {
 		for (i = 0; i < TEST_PAGES_PER_LOOP; i++) {
-			uint64_t addr = guest_test_virt_mem;
+			addr = guest_test_virt_mem;
 			addr += (READ_ONCE(random_array[i]) % guest_num_pages)
 				* guest_page_size;
 			addr &= ~(host_page_size - 1);
@@ -158,15 +191,15 @@ static void vm_dirty_log_verify(unsigned long *bmap)
 		value_ptr = host_test_mem + page * host_page_size;
 
 		/* If this is a special page that we were tracking... */
-		if (test_and_clear_bit(page, host_bmap_track)) {
+		if (test_and_clear_bit_le(page, host_bmap_track)) {
 			host_track_next_count++;
-			TEST_ASSERT(test_bit(page, bmap),
+			TEST_ASSERT(test_bit_le(page, bmap),
 				    "Page %"PRIu64" should have its dirty bit "
 				    "set in this iteration but it is missing",
 				    page);
 		}
 
-		if (test_bit(page, bmap)) {
+		if (test_bit_le(page, bmap)) {
 			host_dirty_count++;
 			/*
 			 * If the bit is set, the value written onto
@@ -209,7 +242,7 @@ static void vm_dirty_log_verify(unsigned long *bmap)
 				 * should report its dirtyness in the
 				 * next run
 				 */
-				set_bit(page, host_bmap_track);
+				set_bit_le(page, host_bmap_track);
 			}
 		}
 	}
@@ -293,6 +326,10 @@ static void run_test(enum vm_guest_mode mode, unsigned long iterations,
 	 * case where the size is not aligned to 64 pages.
 	 */
 	guest_num_pages = (1ul << (30 - guest_page_shift)) + 16;
+#ifdef __s390x__
+	/* Round up to multiple of 1M (segment size) */
+	guest_num_pages = (guest_num_pages + 0xff) & ~0xffUL;
+#endif
 	host_page_size = getpagesize();
 	host_num_pages = (guest_num_pages * guest_page_size) / host_page_size +
 			 !!((guest_num_pages * guest_page_size) % host_page_size);
@@ -304,6 +341,11 @@ static void run_test(enum vm_guest_mode mode, unsigned long iterations,
 		guest_test_phys_mem = phys_offset;
 	}
 
+#ifdef __s390x__
+	/* Align to 1M (segment size) */
+	guest_test_phys_mem &= ~((1 << 20) - 1);
+#endif
+
 	DEBUG("guest physical test memory offset: 0x%lx\n", guest_test_phys_mem);
 
 	bmap = bitmap_alloc(host_num_pages);
@@ -454,6 +496,9 @@ int main(int argc, char *argv[])
 		vm_guest_mode_params_init(VM_MODE_P48V48_64K, true, true);
 	}
 #endif
+#ifdef __s390x__
+	vm_guest_mode_params_init(VM_MODE_P40V48_4K, true, true);
+#endif
 
 	while ((opt = getopt(argc, argv, "hi:I:p:m:")) != -1) {
 		switch (opt) {
-- 
2.21.0

