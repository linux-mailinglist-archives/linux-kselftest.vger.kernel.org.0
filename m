Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A714CD144
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Mar 2022 10:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239041AbiCDJid (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Mar 2022 04:38:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239498AbiCDJiW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Mar 2022 04:38:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A41D6307;
        Fri,  4 Mar 2022 01:37:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D065B827BA;
        Fri,  4 Mar 2022 09:37:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0433C340E9;
        Fri,  4 Mar 2022 09:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646386652;
        bh=QDrlH98Rvn7aiIWnpq1NYHRbjZtBxbAwfJUBHydqywA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CZen6xqmWpID9qhxI5EqVHZO90J75n49D9qsARt7tLylfHEDkrFhS9H9ZCDVsGBMO
         Xaa7Xth70Fdq4eD03ZqTdVb1nnoALqmPmfoEcGNjvvZony633pUM2R/lUVweRpWpoG
         r9DXtLG9cWJ6bkfUyXbqWqgWL/TN+AShHtIMlNwcD7prbEf7PIr/aOJwwRDOMUHBmY
         OEHCK3T88WLxq/3P7kJuHrZ+AcQ6/mJnPGPTFfiaTczCco9Dy35B2XsaQQeWbA+DPt
         LkP4dWjyM/DKhRf+1Z6ZyoT0AVksO178rez3U7NVWEf+CHjPpRT2qirK+7ZWXBjuyu
         JsGfvrHs+uzOw==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.org
Cc:     Nathaniel McCallum <nathaniel@profian.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Haitao Huang <haitao.huang@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC PATCH v2.1 28/30] selftests/sgx: Test reclaiming of untouched page
Date:   Fri,  4 Mar 2022 11:35:22 +0200
Message-Id: <20220304093524.397485-28-jarkko@kernel.org>
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
(1) the user requests changing the page type to PT_TRIM via the
    SGX_IOC_ENCLAVE_MODIFY_TYPE ioctl()
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
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 tools/testing/selftests/sgx/main.c | 82 ++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index d132e7d32454..c691a4864db8 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -1816,4 +1816,86 @@ TEST_F(enclave, remove_added_page_invalid_access_after_eaccept)
 	EXPECT_EQ(self->run.exception_addr, data_start);
 }
 
+TEST_F(enclave, remove_untouched_page)
+{
+	struct sgx_enclave_remove_pages remove_ioc;
+	struct encl_op_eaccept eaccept_op;
+	struct sgx_enclave_modt modt_ioc;
+	struct sgx_secinfo secinfo;
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
+	/* SGX2 is supported by kernel and hardware, test can proceed. */
+	memset(&self->run, 0, sizeof(self->run));
+	self->run.tcs = self->encl.encl_base;
+
+	data_start = self->encl.encl_base +
+			 encl_get_data_offset(&self->encl) + PAGE_SIZE;
+
+	memset(&modt_ioc, 0, sizeof(modt_ioc));
+	memset(&secinfo, 0, sizeof(secinfo));
+
+	secinfo.flags = SGX_PAGE_TYPE_TRIM << 8;
+	modt_ioc.offset = encl_get_data_offset(&self->encl) + PAGE_SIZE;
+	modt_ioc.length = PAGE_SIZE;
+	modt_ioc.secinfo = (unsigned long)&secinfo;
+	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_MODIFY_TYPE, &modt_ioc);
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
2.35.1

