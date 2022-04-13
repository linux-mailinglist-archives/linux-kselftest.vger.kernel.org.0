Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D00A5000CB
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Apr 2022 23:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238834AbiDMVNs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Apr 2022 17:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239044AbiDMVNM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Apr 2022 17:13:12 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A25C4839E;
        Wed, 13 Apr 2022 14:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649884250; x=1681420250;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wXIKJ/gA7dbxe/ScZO2F8hK1bnpCh/Mcj1zKIqtRlSk=;
  b=BNKelsz+PkPiDWSv6MBXzD6orJD0Rsic6p/oZxWBFxecCfpNewBTfAWV
   cJumh46WxitxGO1DMQkPmZBK0gOeivPneJ7fTBZziy4kH8+/D0aC8Hk0T
   wxuVERW7IQYBleUbPQwlRYFDOrcw6aPqKoWgjlIYHlLmNoCDHjfbyCt3g
   fWFIhcNZoUIDuEuCU5DX/Nlko1dCWnUZQhZNq+0Mmd4NQoyGt+wu/BGDm
   dS62fy4ibGO9ae7b/UWSQbDSNOqgpKiua/qAabArUBGWD6RzpHNxd2ECn
   CVq+DWo7PGiW3mzqbfl5nNoJL/+t5IARI8Debg9lk1JXCwB15J3H2HU9R
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="262526965"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="262526965"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 14:10:47 -0700
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="725054342"
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
Subject: [PATCH V4 30/31] selftests/sgx: Test reclaiming of untouched page
Date:   Wed, 13 Apr 2022 14:10:30 -0700
Message-Id: <4236f10ec1e7254af4e1964e4d17bf5ed0e4b356.1649878359.git.reinette.chatre@intel.com>
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
(1) the user requests changing the page type to PT_TRIM via the
    SGX_IOC_ENCLAVE_MODIFY_TYPES ioctl()
(2) on success the ENCLU[EACCEPT] instruction is run from within
    the enclave to accept the page removal
(3) the user initiates the actual removal of the page via the
    SGX_IOC_ENCLAVE_REMOVE_PAGES ioctl().

Remove a page that has never been accessed. This means that when the
first ioctl() requesting page removal arrives, there will be no page
table entry, yet a valid page table entry needs to exist for the
ENCLU[EACCEPT] function to succeed. In this test it is verified that
a page table entry can still be installed for a page that is in the
process of being removed.

Suggested-by: Haitao Huang <haitao.huang@intel.com>
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
- Ensure test is skipped when SGX2 not supported by kernel.

 tools/testing/selftests/sgx/main.c | 80 ++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index ba1c6c4b5ff2..d49fce1a8df9 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -1790,4 +1790,84 @@ TEST_F(enclave, remove_added_page_invalid_access_after_eaccept)
 	EXPECT_EQ(self->run.exception_addr, data_start);
 }
 
+TEST_F(enclave, remove_untouched_page)
+{
+	struct sgx_enclave_remove_pages remove_ioc;
+	struct sgx_enclave_modify_type modt_ioc;
+	struct encl_op_eaccept eaccept_op;
+	unsigned long data_start;
+	int ret, errno_save;
+
+	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
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
+	data_start = self->encl.encl_base +
+			 encl_get_data_offset(&self->encl) + PAGE_SIZE;
+
+	memset(&modt_ioc, 0, sizeof(modt_ioc));
+
+	modt_ioc.offset = encl_get_data_offset(&self->encl) + PAGE_SIZE;
+	modt_ioc.length = PAGE_SIZE;
+	modt_ioc.page_type = SGX_PAGE_TYPE_TRIM;
+	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_MODIFY_TYPES, &modt_ioc);
+	errno_save = ret == -1 ? errno : 0;
+
+	EXPECT_EQ(ret, 0);
+	EXPECT_EQ(errno_save, 0);
+	EXPECT_EQ(modt_ioc.result, 0);
+	EXPECT_EQ(modt_ioc.count, 4096);
+
+	/*
+	 * Enter enclave via TCS #1 and approve page removal by sending
+	 * EACCEPT for removed page.
+	 */
+
+	eaccept_op.epc_addr = data_start;
+	eaccept_op.flags = SGX_SECINFO_TRIM | SGX_SECINFO_MODIFIED;
+	eaccept_op.ret = 0;
+	eaccept_op.header.type = ENCL_OP_EACCEPT;
+
+	EXPECT_EQ(ENCL_CALL(&eaccept_op, &self->run, true), 0);
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.exception_vector, 0);
+	EXPECT_EQ(self->run.exception_error_code, 0);
+	EXPECT_EQ(self->run.exception_addr, 0);
+	EXPECT_EQ(eaccept_op.ret, 0);
+
+	memset(&remove_ioc, 0, sizeof(remove_ioc));
+
+	remove_ioc.offset = encl_get_data_offset(&self->encl) + PAGE_SIZE;
+	remove_ioc.length = PAGE_SIZE;
+	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_REMOVE_PAGES, &remove_ioc);
+	errno_save = ret == -1 ? errno : 0;
+
+	EXPECT_EQ(ret, 0);
+	EXPECT_EQ(errno_save, 0);
+	EXPECT_EQ(remove_ioc.count, 4096);
+}
+
 TEST_HARNESS_MAIN
-- 
2.25.1

