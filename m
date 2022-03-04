Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F524CD15D
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Mar 2022 10:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239203AbiCDJjr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Mar 2022 04:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239482AbiCDJiP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Mar 2022 04:38:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F511188866;
        Fri,  4 Mar 2022 01:37:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36DF361631;
        Fri,  4 Mar 2022 09:37:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF8AC340E9;
        Fri,  4 Mar 2022 09:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646386646;
        bh=aIzJHGwj+yln2PhjXzljUtzwNIdyaPfY7nITk1Afxqs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JQh3v4tUjpAxef8z5y1WxmygZooW4sjfZeL8qfNB6v5IH4bmNcLFov0uwBsEKy8Rz
         7VBMirY6dBExhGIKE0BEaGVmB5NOT8BPhpocwxpr3ROwMyuAPRJs8dv7nbznkfsrOG
         qD1tzan3gvZkv0C7P8yS7wlG8SseHiEGX3XTrrBIYx/rYGixwnWBvzx8OSkZpA2Sw9
         gc+wBOyExARsFj29t20VBFYi5eFMy0VgSYnBGAhHLL2BzvNrdZMlLkn8PMtkVm6Pcc
         YldnfnZtuPVsXE+CP6Mt+c2MLlL3br+6Q9uDvPSYSey853eXD4DTuysEFa/dsEoLWT
         0p3plXLREBRpw==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.org
Cc:     Nathaniel McCallum <nathaniel@profian.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC PATCH v2.1 26/30] selftests/sgx: Test faulty enclave behavior
Date:   Fri,  4 Mar 2022 11:35:20 +0200
Message-Id: <20220304093524.397485-26-jarkko@kernel.org>
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
first the user requests changing the page type to SGX_PAGE_TYPE_TRIM
via an ioctl(), on success the ENCLU[EACCEPT] instruction needs to be
run from within the enclave to accept the page removal, finally the
user requests page removal to be completed via an ioctl(). Only after
acceptance (ENCLU[EACCEPT]) from within the enclave can the kernel
remove the page from a running enclave.

Test the behavior when the user's request to change the page type
succeeds, but the ENCLU[EACCEPT] instruction is not run before the
ioctl() requesting page removal is run. This should not be permitted.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 tools/testing/selftests/sgx/main.c | 116 +++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index f9872c6746a3..82902dab96bc 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -1453,4 +1453,120 @@ TEST_F(enclave, tcs_create)
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
+	struct encl_op_put_to_addr put_addr_op;
+	struct sgx_enclave_modt modt_ioc;
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
+	memset(&modt_ioc, 0, sizeof(modt_ioc));
+	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_MODIFY_TYPE, &modt_ioc);
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
+	/* Start page removal by requesting change of page type to PT_TRIM */
+	memset(&modt_ioc, 0, sizeof(modt_ioc));
+	memset(&secinfo, 0, sizeof(secinfo));
+
+	secinfo.flags = SGX_PAGE_TYPE_TRIM << 8;
+	modt_ioc.offset = encl_get_data_offset(&self->encl) + PAGE_SIZE;
+	modt_ioc.length = PAGE_SIZE;
+	modt_ioc.secinfo = (unsigned long)&secinfo;
+
+	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_MODIFY_TYPE, &modt_ioc);
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
2.35.1

