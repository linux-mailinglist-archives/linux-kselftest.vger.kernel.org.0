Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD83F5000B3
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Apr 2022 23:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236490AbiDMVNS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Apr 2022 17:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239048AbiDMVNM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Apr 2022 17:13:12 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B213A5C1;
        Wed, 13 Apr 2022 14:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649884250; x=1681420250;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9T2ihn0LMBJKrJXn0LFSLOwtWvN2vfg/tBsS0Rgq/6U=;
  b=el0nJr5oMVqA2ndrxZ9Hv0wwje74mlHALldMLLToG3kUn7Ul/vcv3v2l
   dpmXnHdILy6qm2dlCZjJOjp9P6uNRRUkUf6DCSYRirrg4AGxByf68NWbJ
   4AL4HP8ZFawsXw3J7wkchOtAInIMfcubwkyIPs+8ZxJsD7+VlYqelZmpa
   2uAkqnWX8CkzHBygGJA6jIDaAEA6irMp9KkH+KJiuLKbmsrqNbttMgHXv
   RSTRLc0e+RzzSqX5Jq5/hJoM64ku7VN+dWCgFswwSJZ1ngg+zSPsx0eea
   1d25HNRNN6r0Gj+QL6DSJkX5P6+cYRIb8Y+peuMCM+fCQf9RTKlP+p3+X
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="262526970"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="262526970"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 14:10:47 -0700
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="725054346"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 14:10:47 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     dave.hansen@linux.intel.com, jarkko@kernel.org, tglx@linutronix.de,
        bp@alien8.de, luto@kernel.org, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     seanjc@google.com, kai.huang@intel.com, cathy.zhang@intel.com,
        cedric.xing@intel.com, haitao.huang@intel.com,
        mark.shanahan@intel.com, vijay.dhanraj@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 31/31] selftests/sgx: Page removal stress test
Date:   Wed, 13 Apr 2022 14:10:31 -0700
Message-Id: <51e5952805fb5faadcdcd6fa69d3a2b492ba4750.1649878359.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1649878359.git.reinette.chatre@intel.com>
References: <cover.1649878359.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Create enclave with additional heap that consumes all physical SGX
memory and then remove it.

Depending on the available SGX memory this test could take a
significant time to run (several minutes) as it (1) creates the
enclave, (2) changes the type of every page to be trimmed,
(3) enters the enclave once per page to run EACCEPT, before
(4) the pages are finally removed.

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V3:
- Add Jarkko's Acked-by tag.
- Rename SGX_IOC_ENCLAVE_MODIFY_TYPE to
  SGX_IOC_ENCLAVE_MODIFY_TYPES. (Jarkko)
- User provides just page type to SGX_IOC_ENCLAVE_MODIFY_TYPES ioctl(),
  replacing secinfo. (Jarkko)
- Let the SKIP() call involving SGX_IOC_ENCLAVE_MODIFY_TYPES span
  two lines to address checkpatch.pl warning triggered by new longer
  name.

Changes since V2:
- Rename struct sgx_enclave_modt -> struct sgx_enclave_modify_type

Changes since V1:
- Exit test completely on first failure of EACCEPT of a removed page. Since
  this is an oversubscribed test the number of pages on which this is
  attempted can be significant and in case of failure the per-page
  error logging would overwhelm the system.
- Update test to call renamed ioctl() (SGX_IOC_PAGE_MODT ->
  SGX_IOC_ENCLAVE_MODIFY_TYPE) and provide secinfo as parameter (Jarkko).
- Fixup definitions to be reverse xmas tree.
- Update test to reflect page removal ioctl() and struct name change:
  SGX_IOC_PAGE_REMOVE->SGX_IOC_ENCLAVE_REMOVE_PAGES,
  struct sgx_page_remove -> struct sgx_enclave_remove_pages (Jarkko).
- Ensure test is skipped when SGX2 not supported by kernel.
- Cleanup comments.

 tools/testing/selftests/sgx/main.c | 120 +++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index d49fce1a8df9..7ad88117f3f7 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -378,7 +378,127 @@ TEST_F(enclave, unclobbered_vdso_oversubscribed)
 	EXPECT_EQ(get_op.value, MAGIC);
 	EXPECT_EEXIT(&self->run);
 	EXPECT_EQ(self->run.user_data, 0);
+}
+
+TEST_F_TIMEOUT(enclave, unclobbered_vdso_oversubscribed_remove, 900)
+{
+	struct sgx_enclave_remove_pages remove_ioc;
+	struct sgx_enclave_modify_type modt_ioc;
+	struct encl_op_get_from_buf get_op;
+	struct encl_op_eaccept eaccept_op;
+	struct encl_op_put_to_buf put_op;
+	struct encl_segment *heap;
+	unsigned long total_mem;
+	int ret, errno_save;
+	unsigned long addr;
+	unsigned long i;
+
+	/*
+	 * Create enclave with additional heap that is as big as all
+	 * available physical SGX memory.
+	 */
+	total_mem = get_total_epc_mem();
+	ASSERT_NE(total_mem, 0);
+	TH_LOG("Creating an enclave with %lu bytes heap may take a while ...",
+	       total_mem);
+	ASSERT_TRUE(setup_test_encl(total_mem, &self->encl, _metadata));
+
+	/*
+	 * Hardware (SGX2) and kernel support is needed for this test. Start
+	 * with check that test has a chance of succeeding.
+	 */
+	memset(&modt_ioc, 0, sizeof(modt_ioc));
+	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_MODIFY_TYPES, &modt_ioc);
+
+	if (ret == -1) {
+		if (errno == ENOTTY)
+			SKIP(return,
+			     "Kernel does not support SGX_IOC_ENCLAVE_MODIFY_TYPES ioctl()");
+		else if (errno == ENODEV)
+			SKIP(return, "System does not support SGX2");
+	}
+
+	/*
+	 * Invalid parameters were provided during sanity check,
+	 * expect command to fail.
+	 */
+	EXPECT_EQ(ret, -1);
+
+	/* SGX2 is supported by kernel and hardware, test can proceed. */
+	memset(&self->run, 0, sizeof(self->run));
+	self->run.tcs = self->encl.encl_base;
+
+	heap = &self->encl.segment_tbl[self->encl.nr_segments - 1];
+
+	put_op.header.type = ENCL_OP_PUT_TO_BUFFER;
+	put_op.value = MAGIC;
+
+	EXPECT_EQ(ENCL_CALL(&put_op, &self->run, false), 0);
+
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.user_data, 0);
+
+	get_op.header.type = ENCL_OP_GET_FROM_BUFFER;
+	get_op.value = 0;
+
+	EXPECT_EQ(ENCL_CALL(&get_op, &self->run, false), 0);
+
+	EXPECT_EQ(get_op.value, MAGIC);
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.user_data, 0);
 
+	/* Trim entire heap. */
+	memset(&modt_ioc, 0, sizeof(modt_ioc));
+
+	modt_ioc.offset = heap->offset;
+	modt_ioc.length = heap->size;
+	modt_ioc.page_type = SGX_PAGE_TYPE_TRIM;
+
+	TH_LOG("Changing type of %zd bytes to trimmed may take a while ...",
+	       heap->size);
+	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_MODIFY_TYPES, &modt_ioc);
+	errno_save = ret == -1 ? errno : 0;
+
+	EXPECT_EQ(ret, 0);
+	EXPECT_EQ(errno_save, 0);
+	EXPECT_EQ(modt_ioc.result, 0);
+	EXPECT_EQ(modt_ioc.count, heap->size);
+
+	/* EACCEPT all removed pages. */
+	addr = self->encl.encl_base + heap->offset;
+
+	eaccept_op.flags = SGX_SECINFO_TRIM | SGX_SECINFO_MODIFIED;
+	eaccept_op.header.type = ENCL_OP_EACCEPT;
+
+	TH_LOG("Entering enclave to run EACCEPT for each page of %zd bytes may take a while ...",
+	       heap->size);
+	for (i = 0; i < heap->size; i += 4096) {
+		eaccept_op.epc_addr = addr + i;
+		eaccept_op.ret = 0;
+
+		EXPECT_EQ(ENCL_CALL(&eaccept_op, &self->run, true), 0);
+
+		EXPECT_EQ(self->run.exception_vector, 0);
+		EXPECT_EQ(self->run.exception_error_code, 0);
+		EXPECT_EQ(self->run.exception_addr, 0);
+		ASSERT_EQ(eaccept_op.ret, 0);
+		ASSERT_EQ(self->run.function, EEXIT);
+	}
+
+	/* Complete page removal. */
+	memset(&remove_ioc, 0, sizeof(remove_ioc));
+
+	remove_ioc.offset = heap->offset;
+	remove_ioc.length = heap->size;
+
+	TH_LOG("Removing %zd bytes from enclave may take a while ...",
+	       heap->size);
+	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_REMOVE_PAGES, &remove_ioc);
+	errno_save = ret == -1 ? errno : 0;
+
+	EXPECT_EQ(ret, 0);
+	EXPECT_EQ(errno_save, 0);
+	EXPECT_EQ(remove_ioc.count, heap->size);
 }
 
 TEST_F(enclave, clobbered_vdso)
-- 
2.25.1

