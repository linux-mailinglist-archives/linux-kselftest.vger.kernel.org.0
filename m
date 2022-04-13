Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575F65000EA
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Apr 2022 23:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbiDMVNn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Apr 2022 17:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239063AbiDMVNO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Apr 2022 17:13:14 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFBA44A33;
        Wed, 13 Apr 2022 14:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649884252; x=1681420252;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=epB1aG/sEyJn/Mu/pNc9eKBvOCXfd2g6sfPiwEKOgEY=;
  b=a70RsCAyYMq48Tjgy4Qe9ANg6N7UengUBj+gPT11avcSAZozb/Ylm2zq
   doPSv+AzYOtSY+uYM8TaHnDAQqFaVwZJPdIYqWXHFv1N/KNsRTZqfTjWT
   F2WdE79OdwqgTvvnzQmib/V7c4k6abMiBrRlNTs9h2O4Al2K5CyL38U1D
   JqZ5IbDtiafrwtKniDlCc4xkN8PM/MypKF2nty9FQ7wLa55cxjY8yhPIX
   B7eZMe290MfKesIr0jRxeti66aygApoPZ0BWKad8IpniUzoE7fLNsQ/rB
   b9zC5tE8MnNV7bkj1UVg2UlaHMTjZ7KQAUvc+2s7NB8aHHnyi7Ew2pKgG
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="323219072"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="323219072"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 14:10:46 -0700
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="725054329"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 14:10:46 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     dave.hansen@linux.intel.com, jarkko@kernel.org, tglx@linutronix.de,
        bp@alien8.de, luto@kernel.org, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     seanjc@google.com, kai.huang@intel.com, cathy.zhang@intel.com,
        cedric.xing@intel.com, haitao.huang@intel.com,
        mark.shanahan@intel.com, vijay.dhanraj@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 28/31] selftests/sgx: Test faulty enclave behavior
Date:   Wed, 13 Apr 2022 14:10:28 -0700
Message-Id: <8ba0555325ff7bb9bf58b618161e9425bb075a81.1649878359.git.reinette.chatre@intel.com>
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

Removing a page from an initialized enclave involves three steps:
first the user requests changing the page type to SGX_PAGE_TYPE_TRIM
via an ioctl(), on success the ENCLU[EACCEPT] instruction needs to be
run from within the enclave to accept the page removal, finally the
user requests page removal to be completed via an ioctl(). Only after
acceptance (ENCLU[EACCEPT]) from within the enclave can the kernel
remove the page from a running enclave.

Test the behavior when the user's request to change the page type
succeeds, but the ENCLU[EACCEPT] instruction is not run before the
ioctl() requesting page removal is run. This should not be permitted.

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
- Update to support ioctl() name change (SGX_IOC_PAGE_MODT ->
  SGX_IOC_ENCLAVE_MODIFY_TYPE) and provide secinfo as parameter instead
  of just page type (Jarkko).
- Update test to reflect page removal ioctl() and struct name change:
  SGX_IOC_PAGE_REMOVE->SGX_IOC_ENCLAVE_REMOVE_PAGES,
  struct sgx_page_remove -> struct sgx_enclave_remove_pages (Jarkko).
- Use ioctl() instead of ioctl in text (Dave).

 tools/testing/selftests/sgx/main.c | 114 +++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index a3f22b15a4f8..fc72b04ce2a8 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -1433,4 +1433,118 @@ TEST_F(enclave, tcs_create)
 	munmap(addr, 3 * PAGE_SIZE);
 }
 
+/*
+ * Ensure sane behavior if user requests page removal, does not run
+ * EACCEPT from within enclave but still attempts to finalize page removal
+ * with the SGX_IOC_ENCLAVE_REMOVE_PAGES ioctl(). The latter should fail
+ * because the removal was not EACCEPTed from within the enclave.
+ */
+TEST_F(enclave, remove_added_page_no_eaccept)
+{
+	struct sgx_enclave_remove_pages remove_ioc;
+	struct encl_op_get_from_addr get_addr_op;
+	struct sgx_enclave_modify_type modt_ioc;
+	struct encl_op_put_to_addr put_addr_op;
+	unsigned long data_start;
+	int ret, errno_save;
+
+	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
+
+	memset(&self->run, 0, sizeof(self->run));
+	self->run.tcs = self->encl.encl_base;
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
+	/*
+	 * Page that will be removed is the second data page in the .data
+	 * segment. This forms part of the local encl_buffer within the
+	 * enclave.
+	 */
+	data_start = self->encl.encl_base +
+		     encl_get_data_offset(&self->encl) + PAGE_SIZE;
+
+	/*
+	 * Sanity check that page at @data_start is writable before
+	 * removing it.
+	 *
+	 * Start by writing MAGIC to test page.
+	 */
+	put_addr_op.value = MAGIC;
+	put_addr_op.addr = data_start;
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
+	 * Read memory that was just written to, confirming that data
+	 * previously written (MAGIC) is present.
+	 */
+	get_addr_op.value = 0;
+	get_addr_op.addr = data_start;
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
+	/* Start page removal by requesting change of page type to PT_TRIM */
+	memset(&modt_ioc, 0, sizeof(modt_ioc));
+
+	modt_ioc.offset = encl_get_data_offset(&self->encl) + PAGE_SIZE;
+	modt_ioc.length = PAGE_SIZE;
+	modt_ioc.page_type = SGX_PAGE_TYPE_TRIM;
+
+	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_MODIFY_TYPES, &modt_ioc);
+	errno_save = ret == -1 ? errno : 0;
+
+	EXPECT_EQ(ret, 0);
+	EXPECT_EQ(errno_save, 0);
+	EXPECT_EQ(modt_ioc.result, 0);
+	EXPECT_EQ(modt_ioc.count, 4096);
+
+	/* Skip EACCEPT */
+
+	/* Send final ioctl() to complete page removal */
+	memset(&remove_ioc, 0, sizeof(remove_ioc));
+
+	remove_ioc.offset = encl_get_data_offset(&self->encl) + PAGE_SIZE;
+	remove_ioc.length = PAGE_SIZE;
+
+	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_REMOVE_PAGES, &remove_ioc);
+	errno_save = ret == -1 ? errno : 0;
+
+	/* Operation not permitted since EACCEPT was omitted. */
+	EXPECT_EQ(ret, -1);
+	EXPECT_EQ(errno_save, EPERM);
+	EXPECT_EQ(remove_ioc.count, 0);
+}
+
 TEST_HARNESS_MAIN
-- 
2.25.1

