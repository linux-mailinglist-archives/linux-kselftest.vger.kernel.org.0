Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5BF64CD142
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Mar 2022 10:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238673AbiCDJid (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Mar 2022 04:38:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239496AbiCDJiU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Mar 2022 04:38:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C6D29E;
        Fri,  4 Mar 2022 01:37:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BB9261877;
        Fri,  4 Mar 2022 09:37:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02113C340E9;
        Fri,  4 Mar 2022 09:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646386649;
        bh=P/OJmtSq2qgp09CPF849ERLEp/5T8UMZOOvgPKHQ7dw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z9Aw/O1EticJQGwzNRLpqxvpWEBmbFKbQkPGGIdr+HHWuYsTZ4O3p9C+yAXM6xuX2
         JLlVz+rE488neNnd4pGzD3YFdsgBGrak6PdpuVZLrEKbtCnxeAzYmUIP5dRRNc0eAL
         IxAJeZYNAIP/hUwVXwyySfB6xf+bZUlirEpd6tlDRvFWKocnd4hMQys6YtcVIKN2X3
         SBROaJHDcmcuWa2TU9dD4b6BQyRJPd99/92un7Aiq0tqi833bOED+ehycyYQIavycM
         Rjqu/e0NaszWtHHrHklyWIKL+5Int+l1e6kTWFo11G5TYWdQF78Nfoq1g7e/jRVhlz
         btqWfybZ5lxKA==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.org
Cc:     Nathaniel McCallum <nathaniel@profian.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC PATCH v2.1 27/30] selftests/sgx: Test invalid access to removed enclave page
Date:   Fri,  4 Mar 2022 11:35:21 +0200
Message-Id: <20220304093524.397485-27-jarkko@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304093524.397485-1-jarkko@kernel.org>
References: <20220304093524.397485-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Reinette Chatre <reinette.chatre@intel.com>

Removing a page from an initialized enclave involves three steps:
(1) the user requests changing the page type to SGX_PAGE_TYPE_TRIM
via the SGX_IOC_ENCLAVE_MODIFY_TYPE  ioctl(), (2) on success the
ENCLU[EACCEPT] instruction is run from within the enclave to accept
the page removal, (3) the user initiates the actual removal of the
page via the SGX_IOC_ENCLAVE_REMOVE_PAGES ioctl().

Test two possible invalid accesses during the page removal flow:
* Test the behavior when a request to remove the page by changing its
  type to SGX_PAGE_TYPE_TRIM completes successfully but instead of
  executing ENCLU[EACCEPT] from within the enclave the enclave attempts
  to read from the page. Even though the page is accessible from the
  page table entries its type is SGX_PAGE_TYPE_TRIM and thus not
  accessible according to SGX. The expected behavior is a page fault
  with the SGX flag set in the error code.
* Test the behavior when the page type is changed successfully and
  ENCLU[EACCEPT] was run from within the enclave. The final ioctl(),
  SGX_IOC_ENCLAVE_REMOVE_PAGES, is omitted and replaced with an
  attempt to access the page. Even though the page is accessible
  from the page table entries its type is SGX_PAGE_TYPE_TRIM and
  thus not accessible according to SGX.  The expected behavior is
  a page fault with the SGX flag set in the error code.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 tools/testing/selftests/sgx/main.c | 247 +++++++++++++++++++++++++++++
 1 file changed, 247 insertions(+)

diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index 82902dab96bc..d132e7d32454 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -1569,4 +1569,251 @@ TEST_F(enclave, remove_added_page_no_eaccept)
 	EXPECT_EQ(remove_ioc.count, 0);
 }
 
+/*
+ * Request enclave page removal but instead of correctly following with
+ * EACCEPT a read attempt to page is made from within the enclave.
+ */
+TEST_F(enclave, remove_added_page_invalid_access)
+{
+	struct encl_op_get_from_addr get_addr_op;
+	struct encl_op_put_to_addr put_addr_op;
+	struct sgx_enclave_modt ioc;
+	struct sgx_secinfo secinfo;
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
+	memset(&ioc, 0, sizeof(ioc));
+	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_MODIFY_TYPE, &ioc);
+
+	if (ret == -1) {
+		if (errno == ENOTTY)
+			SKIP(return, "Kernel does not support SGX_IOC_ENCLAVE_MODIFY_TYPE ioctl()");
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
+	/* Start page removal by requesting change of page type to PT_TRIM. */
+	memset(&ioc, 0, sizeof(ioc));
+	memset(&secinfo, 0, sizeof(secinfo));
+
+	secinfo.flags = SGX_PAGE_TYPE_TRIM << 8;
+	ioc.offset = encl_get_data_offset(&self->encl) + PAGE_SIZE;
+	ioc.length = PAGE_SIZE;
+	ioc.secinfo = (unsigned long)&secinfo;
+
+	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_MODIFY_TYPE, &ioc);
+	errno_save = ret == -1 ? errno : 0;
+
+	EXPECT_EQ(ret, 0);
+	EXPECT_EQ(errno_save, 0);
+	EXPECT_EQ(ioc.result, 0);
+	EXPECT_EQ(ioc.count, 4096);
+
+	/*
+	 * Read from page that was just removed.
+	 */
+	get_addr_op.value = 0;
+
+	EXPECT_EQ(ENCL_CALL(&get_addr_op, &self->run, true), 0);
+
+	/*
+	 * From kernel perspective the page is present but according to SGX the
+	 * page should not be accessible so a #PF with SGX bit set is
+	 * expected.
+	 */
+
+	EXPECT_EQ(self->run.function, ERESUME);
+	EXPECT_EQ(self->run.exception_vector, 14);
+	EXPECT_EQ(self->run.exception_error_code, 0x8005);
+	EXPECT_EQ(self->run.exception_addr, data_start);
+}
+
+/*
+ * Request enclave page removal and correctly follow with
+ * EACCEPT but do not follow with removal ioctl() but instead a read attempt
+ * to removed page is made from within the enclave.
+ */
+TEST_F(enclave, remove_added_page_invalid_access_after_eaccept)
+{
+	struct encl_op_get_from_addr get_addr_op;
+	struct encl_op_put_to_addr put_addr_op;
+	struct encl_op_eaccept eaccept_op;
+	struct sgx_enclave_modt ioc;
+	struct sgx_secinfo secinfo;
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
+	memset(&ioc, 0, sizeof(ioc));
+	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_MODIFY_TYPE, &ioc);
+
+	if (ret == -1) {
+		if (errno == ENOTTY)
+			SKIP(return, "Kernel does not support SGX_IOC_ENCLAVE_MODIFY_TYPE ioctl()");
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
+	/* Start page removal by requesting change of page type to PT_TRIM. */
+	memset(&ioc, 0, sizeof(ioc));
+	memset(&secinfo, 0, sizeof(secinfo));
+
+	secinfo.flags = SGX_PAGE_TYPE_TRIM << 8;
+	ioc.offset = encl_get_data_offset(&self->encl) + PAGE_SIZE;
+	ioc.length = PAGE_SIZE;
+	ioc.secinfo = (unsigned long)&secinfo;
+
+	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_MODIFY_TYPE, &ioc);
+	errno_save = ret == -1 ? errno : 0;
+
+	EXPECT_EQ(ret, 0);
+	EXPECT_EQ(errno_save, 0);
+	EXPECT_EQ(ioc.result, 0);
+	EXPECT_EQ(ioc.count, 4096);
+
+	eaccept_op.epc_addr = (unsigned long)data_start;
+	eaccept_op.ret = 0;
+	eaccept_op.flags = SGX_SECINFO_TRIM | SGX_SECINFO_MODIFIED;
+	eaccept_op.header.type = ENCL_OP_EACCEPT;
+
+	EXPECT_EQ(ENCL_CALL(&eaccept_op, &self->run, true), 0);
+
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.exception_vector, 0);
+	EXPECT_EQ(self->run.exception_error_code, 0);
+	EXPECT_EQ(self->run.exception_addr, 0);
+	EXPECT_EQ(eaccept_op.ret, 0);
+
+	/* Skip ioctl() to remove page. */
+
+	/*
+	 * Read from page that was just removed.
+	 */
+	get_addr_op.value = 0;
+
+	EXPECT_EQ(ENCL_CALL(&get_addr_op, &self->run, true), 0);
+
+	/*
+	 * From kernel perspective the page is present but according to SGX the
+	 * page should not be accessible so a #PF with SGX bit set is
+	 * expected.
+	 */
+
+	EXPECT_EQ(self->run.function, ERESUME);
+	EXPECT_EQ(self->run.exception_vector, 14);
+	EXPECT_EQ(self->run.exception_error_code, 0x8005);
+	EXPECT_EQ(self->run.exception_addr, data_start);
+}
+
 TEST_HARNESS_MAIN
-- 
2.35.1

