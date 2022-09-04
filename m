Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC645AC359
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Sep 2022 09:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbiIDHyn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 4 Sep 2022 03:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233475AbiIDHyi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 4 Sep 2022 03:54:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E506E9D;
        Sun,  4 Sep 2022 00:54:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5F7BB80D40;
        Sun,  4 Sep 2022 07:54:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A959C433D6;
        Sun,  4 Sep 2022 07:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662278065;
        bh=p8nRIS1VrAoUS4zMXarXOQjOtJK7KmJJS5AMfEf7Tvw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Am9a/fGIVt5XpsrJ88ITQxscCDuU9W5L/afh81HCzzkZq6pVhoM7uMF3eSOwD1wo+
         UkcurNU7ETWh+ANGhS1lRLQrB6Ftu5D+qUCKMahzdtHI7pTE44xFGXfgg13iwUEAuw
         zJE3CJ3MoWTdl58CbQJwqpcarWznxwR3eQy91qn7zH+QyexcxCEbyT9U3H45zsz59m
         8DUwDnYHOT55ja9RSrg+dpZ/xPBMOwPhO7vQq7fXWc2wylIuH3c9zUZP0IOVkc0Lya
         OuzCLOvCQOk+e5hqMlRWX2z6mrfh1zzUVKRxoOSXKabAxIl9SmIFK69rv7a1Dwzs7U
         twtjAKN2C80Zg==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.org
Cc:     Haitao Huang <haitao.huang@linux.intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 5/5] selftests/sgx: Add SGX selftest augment_via_eaccept_long
Date:   Sun,  4 Sep 2022 10:53:58 +0300
Message-Id: <20220904075358.7727-6-jarkko@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220904075358.7727-1-jarkko@kernel.org>
References: <20220904075358.7727-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Vijay Dhanraj <vijay.dhanraj@intel.com>

Add a new test case which is same as augment_via_eaccept but adds a
larger number of EPC pages to stress test EAUG via EACCEPT.

Signed-off-by: Vijay Dhanraj <vijay.dhanraj@intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v7:
- Contains now only the test case. Support for dynamic heap is
  prepared in prepending patches.

v6:
- Address Reinette's feedback:
  https://lore.kernel.org/linux-sgx/Yw6%2FiTzSdSw%2FY%2FVO@kernel.org/

v5:
- Add the klog dump and sysctl option to the commit message.

v4:
- Explain expectations for dirty_page_list in the function header, instead
  of an inline comment.
- Improve commit message to explain the conditions better.
- Return the number of pages left dirty to ksgxd() and print warning after
  the 2nd call, if there are any.

v3:
- Remove WARN_ON().
- Tuned comments and the commit message a bit.

v2:
- Replaced WARN_ON() with optional pr_info() inside
  __sgx_sanitize_pages().
- Rewrote the commit message.
- Added the fixes tag.
---
 tools/testing/selftests/sgx/main.c | 112 ++++++++++++++++++++++++++++-
 1 file changed, 111 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index 4feffe7cd8fb..48976bb7bd79 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -23,8 +23,15 @@
 
 static const size_t ENCL_HEAP_SIZE_DEFAULT = PAGE_SIZE;
 static const size_t ENCL_DYNAMIC_SIZE_DEFAULT = PAGE_SIZE;
+/*
+ * The size was chosen based on a bug report:
+ * Message-ID: <DM8PR11MB55912A7F47A84EC9913A6352F6999@DM8PR11MB5591.namprd11.prod.outlook.com>
+ */
+static const size_t ENCL_DYNAMIC_SIZE_LONG = 8L * 1024L * 1024L * 1024L;
+static const unsigned long TIMEOUT_DEFAULT = 900;
 static const uint64_t MAGIC = 0x1122334455667788ULL;
 static const uint64_t MAGIC2 = 0x8877665544332211ULL;
+
 vdso_sgx_enter_enclave_t vdso_sgx_enter_enclave;
 
 /*
@@ -388,7 +395,7 @@ TEST_F(enclave, unclobbered_vdso_oversubscribed)
 	EXPECT_EQ(self->run.user_data, 0);
 }
 
-TEST_F_TIMEOUT(enclave, unclobbered_vdso_oversubscribed_remove, 900)
+TEST_F_TIMEOUT(enclave, unclobbered_vdso_oversubscribed_remove, TIMEOUT_DEFAULT)
 {
 	struct sgx_enclave_remove_pages remove_ioc;
 	struct sgx_enclave_modify_types modt_ioc;
@@ -1248,6 +1255,109 @@ TEST_F(enclave, augment_via_eaccept)
 	munmap(addr, PAGE_SIZE);
 }
 
+/*
+ * Test for the addition of large number of pages to an initialized enclave via
+ * a pre-emptive run of EACCEPT on every page to be added.
+ */
+TEST_F_TIMEOUT(enclave, augment_via_eaccept_long, TIMEOUT_DEFAULT)
+{
+	struct encl_op_get_from_addr get_addr_op;
+	struct encl_op_put_to_addr put_addr_op;
+	struct encl_op_eaccept eaccept_op;
+	size_t total_size = 0;
+	unsigned long i;
+	void *addr;
+
+	if (!sgx2_supported())
+		SKIP(return, "SGX2 not supported");
+
+	ASSERT_TRUE(setup_test_encl_dynamic(ENCL_HEAP_SIZE_DEFAULT,
+					    ENCL_DYNAMIC_SIZE_LONG,
+					    &self->encl, _metadata));
+
+	memset(&self->run, 0, sizeof(self->run));
+	self->run.tcs = self->encl.encl_base;
+
+	for (i = 0; i < self->encl.nr_segments; i++) {
+		struct encl_segment *seg = &self->encl.segment_tbl[i];
+
+		total_size += seg->size;
+	}
+
+	/*
+	 * mmap() every page at end of existing enclave to be used for
+	 * EDMM.
+	 */
+	addr = mmap((void *)self->encl.encl_base + total_size, ENCL_DYNAMIC_SIZE_LONG,
+		    PROT_READ | PROT_WRITE | PROT_EXEC, MAP_SHARED | MAP_FIXED,
+		    self->encl.fd, 0);
+	EXPECT_NE(addr, MAP_FAILED);
+
+	self->run.exception_vector = 0;
+	self->run.exception_error_code = 0;
+	self->run.exception_addr = 0;
+
+	/*
+	 * Run EACCEPT on every page to trigger the #PF->EAUG->EACCEPT(again
+	 * without a #PF). All should be transparent to userspace.
+	 */
+	eaccept_op.flags = SGX_SECINFO_R | SGX_SECINFO_W | SGX_SECINFO_REG | SGX_SECINFO_PENDING;
+	eaccept_op.ret = 0;
+	eaccept_op.header.type = ENCL_OP_EACCEPT;
+
+	for (i = 0; i < ENCL_DYNAMIC_SIZE_LONG; i += 4096) {
+		eaccept_op.epc_addr = (uint64_t)(addr + i);
+
+		EXPECT_EQ(ENCL_CALL(&eaccept_op, &self->run, true), 0);
+		if (self->run.exception_vector == 14 &&
+		    self->run.exception_error_code == 4 &&
+		    self->run.exception_addr == self->encl.encl_base) {
+			munmap(addr, ENCL_DYNAMIC_SIZE_LONG);
+			SKIP(return, "Kernel does not support adding pages to initialized enclave");
+		}
+
+		EXPECT_EQ(self->run.exception_vector, 0);
+		EXPECT_EQ(self->run.exception_error_code, 0);
+		EXPECT_EQ(self->run.exception_addr, 0);
+		ASSERT_EQ(eaccept_op.ret, 0);
+		ASSERT_EQ(self->run.function, EEXIT);
+	}
+
+	/*
+	 * Pool of pages were successfully added to enclave. Perform sanity
+	 * check on first page of the pool only to ensure data can be written
+	 * to and read from a dynamically added enclave page.
+	 */
+	put_addr_op.value = MAGIC;
+	put_addr_op.addr = (unsigned long)addr;
+	put_addr_op.header.type = ENCL_OP_PUT_TO_ADDRESS;
+
+	EXPECT_EQ(ENCL_CALL(&put_addr_op, &self->run, true), 0);
+
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.exception_vector, 0);
+	EXPECT_EQ(self->run.exception_error_code, 0);
+	EXPECT_EQ(self->run.exception_addr, 0);
+
+	/*
+	 * Read memory from newly added page that was just written to,
+	 * confirming that data previously written (MAGIC) is present.
+	 */
+	get_addr_op.value = 0;
+	get_addr_op.addr = (unsigned long)addr;
+	get_addr_op.header.type = ENCL_OP_GET_FROM_ADDRESS;
+
+	EXPECT_EQ(ENCL_CALL(&get_addr_op, &self->run, true), 0);
+
+	EXPECT_EQ(get_addr_op.value, MAGIC);
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.exception_vector, 0);
+	EXPECT_EQ(self->run.exception_error_code, 0);
+	EXPECT_EQ(self->run.exception_addr, 0);
+
+	munmap(addr, ENCL_DYNAMIC_SIZE_LONG);
+}
+
 /*
  * SGX2 page type modification test in two phases:
  * Phase 1:
-- 
2.37.2

