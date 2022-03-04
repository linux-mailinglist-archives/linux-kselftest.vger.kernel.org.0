Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D774CD13D
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Mar 2022 10:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238035AbiCDJi2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Mar 2022 04:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239426AbiCDJiJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Mar 2022 04:38:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B863198D34;
        Fri,  4 Mar 2022 01:37:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 57149B827BA;
        Fri,  4 Mar 2022 09:36:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDAC1C340E9;
        Fri,  4 Mar 2022 09:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646386618;
        bh=Lz/rYuzi5eg/KbwEMeUWk0lPaFgp/JfWvLR1ugCb1u8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ADPQIIzPgR/VVYVR80TeGtzjmuXp3nSCOfr862rIX5NRbGSCA/OXoGJGz16iC1mLF
         fYp4VbvZUJ3+d5HJEy90eJsI2dn+XDiGe6PkY5Sd4vxv1VMswsZfmufJlJXGWnw7pH
         P7S0ycPFlMy1lUR489WeIPMIvsPYrVKheHXA2KvO4Do2+f3E9nILiiYc5r2N45MQ+r
         TvLiXLWY7SMzSN+y/ZzvCmsvUh2yCt0n0wk1mGhp7R/MxTXo2nZln2cEJIoamU0+mZ
         21offXAhnvvC/vSxiQW8AG+F72l1YYEU32z9PQflzIfMZ4hRW11rKNLeeMn4XLuUXf
         gVIMSvGM1Aw3w==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.org
Cc:     Nathaniel McCallum <nathaniel@profian.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC PATCH v2.1 16/30] selftests/sgx: Add test for TCS page permission changes
Date:   Fri,  4 Mar 2022 11:35:10 +0200
Message-Id: <20220304093524.397485-16-jarkko@kernel.org>
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

Kernel should not allow permission changes on TCS pages. Add test to
confirm this behavior.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 tools/testing/selftests/sgx/main.c | 74 ++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index aec3355d2ace..ea5f2e064687 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -121,6 +121,24 @@ static Elf64_Sym *vdso_symtab_get(struct vdso_symtab *symtab, const char *name)
 	return NULL;
 }
 
+/*
+ * Return the offset in the enclave where the TCS segment can be found.
+ * The first RW segment loaded is the TCS.
+ */
+static off_t encl_get_tcs_offset(struct encl *encl)
+{
+	int i;
+
+	for (i = 0; i < encl->nr_segments; i++) {
+		struct encl_segment *seg = &encl->segment_tbl[i];
+
+		if (i == 0 && seg->prot == (PROT_READ | PROT_WRITE))
+			return seg->offset;
+	}
+
+	return -1;
+}
+
 /*
  * Return the offset in the enclave where the data segment can be found.
  * The first RW segment loaded is the TCS, skip that to get info on the
@@ -567,6 +585,62 @@ TEST_F(enclave, pte_permissions)
 	EXPECT_EQ(self->run.exception_addr, 0);
 }
 
+/*
+ * Modifying permissions of TCS page should not be possible.
+ */
+TEST_F(enclave, tcs_permissions)
+{
+	struct sgx_enclave_restrict_perm ioc;
+	struct sgx_secinfo secinfo;
+	int ret, errno_save;
+
+	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
+
+	memset(&self->run, 0, sizeof(self->run));
+	self->run.tcs = self->encl.encl_base;
+
+	memset(&ioc, 0, sizeof(ioc));
+	memset(&secinfo, 0, sizeof(secinfo));
+
+	/*
+	 * Ensure kernel supports needed ioctl() and system supports needed
+	 * commands.
+	 */
+
+	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS, &ioc);
+	errno_save = ret == -1 ? errno : 0;
+
+	/*
+	 * Invalid parameters were provided during sanity check,
+	 * expect command to fail.
+	 */
+	ASSERT_EQ(ret, -1);
+
+	/* ret == -1 */
+	if (errno_save == ENOTTY)
+		SKIP(return,
+		     "Kernel does not support SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS ioctl()");
+	else if (errno_save == ENODEV)
+		SKIP(return, "System does not support SGX2");
+
+	/*
+	 * Attempt to make TCS page read-only. This is not allowed and
+	 * should be prevented by the kernel.
+	 */
+	secinfo.flags = PROT_READ;
+	ioc.offset = encl_get_tcs_offset(&self->encl);
+	ioc.length = PAGE_SIZE;
+	ioc.secinfo = (unsigned long)&secinfo;
+
+	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS, &ioc);
+	errno_save = ret == -1 ? errno : 0;
+
+	EXPECT_EQ(ret, -1);
+	EXPECT_EQ(errno_save, EINVAL);
+	EXPECT_EQ(ioc.result, 0);
+	EXPECT_EQ(ioc.count, 0);
+}
+
 /*
  * Enclave page permission test.
  *
-- 
2.35.1

