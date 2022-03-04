Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B64B4CD147
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Mar 2022 10:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239053AbiCDJig (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Mar 2022 04:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237257AbiCDJi1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Mar 2022 04:38:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C707DF9B;
        Fri,  4 Mar 2022 01:37:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 958986197E;
        Fri,  4 Mar 2022 09:37:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B90BC340E9;
        Fri,  4 Mar 2022 09:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646386657;
        bh=Kn/vNsiev7dahB6veyuVCK/X3UuJrkBSEBZH8/QcHss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D2hqedJIoyAa4chosW/kLeSuLOSzMFN9P2rdCHR/4xGMzaIsUzXjZeT+kg0+vO0Io
         aJWhVzPOE3hL7sLBokq3marXLOeDXrLL4VvKkB7TLAp3hJTOhbH0WPOT8KsaRg1AaL
         heUzMgELvfhW8AKBS8zq1R53/ZlyTz7T/+jw+VIyoWuEPgMpf6XDvVD2p2qdOU+V3T
         rJfo4A/zakEHRIHBzgejlbyU6b9vkKQNuakShc+weJ1O3ZPGG8iYYgZbVseTt8CiPX
         llopNikgYr7wjdY7hGLBpv8wqJM/26szI67po4e58HjY7bmU9KW+cXXSkmhflwsAv4
         9CpLwnU/vjqoA==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.org
Cc:     Nathaniel McCallum <nathaniel@profian.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC PATCH v2.1 30/30] selftests/sgx: Page removal stress test
Date:   Fri,  4 Mar 2022 11:35:24 +0200
Message-Id: <20220304093524.397485-30-jarkko@kernel.org>
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

Create enclave with additional heap that consumes all physical SGX
memory and then remove it.

Depending on the available SGX memory this test could take a
significant time to run (several minutes) as it (1) creates the
enclave, (2) changes the type of every page to be trimmed,
(3) enters the enclave once per page to run EACCEPT, before
(4) the pages are finally removed.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 tools/testing/selftests/sgx/main.c | 122 +++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index c691a4864db8..5c4faf6d5640 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -378,7 +378,129 @@ TEST_F(enclave, unclobbered_vdso_oversubscribed)
 	EXPECT_EQ(get_op.value, MAGIC);
 	EXPECT_EEXIT(&self->run);
 	EXPECT_EQ(self->run.user_data, 0);
+}
+
+TEST_F_TIMEOUT(enclave, unclobbered_vdso_oversubscribed_remove, 900)
+{
+	struct sgx_enclave_remove_pages remove_ioc;
+	struct encl_op_get_from_buf get_op;
+	struct encl_op_eaccept eaccept_op;
+	struct encl_op_put_to_buf put_op;
+	struct sgx_enclave_modt modt_ioc;
+	struct sgx_secinfo secinfo;
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
+
+	/* Trim entire heap. */
+	memset(&modt_ioc, 0, sizeof(modt_ioc));
+	memset(&secinfo, 0, sizeof(secinfo));
+
+	secinfo.flags = SGX_PAGE_TYPE_TRIM << 8;
+	modt_ioc.offset = heap->offset;
+	modt_ioc.length = heap->size;
+	modt_ioc.secinfo = (unsigned long)&secinfo;
+
+	TH_LOG("Changing type of %zd bytes to trimmed may take a while ...",
+	       heap->size);
+	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_MODIFY_TYPE, &modt_ioc);
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
2.35.1

