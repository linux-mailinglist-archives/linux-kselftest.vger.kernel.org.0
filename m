Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2E65A8487
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Aug 2022 19:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbiHaRjC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Aug 2022 13:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbiHaRjA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Aug 2022 13:39:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12734D2B35;
        Wed, 31 Aug 2022 10:38:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0CBC61B2D;
        Wed, 31 Aug 2022 17:38:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B713AC433D6;
        Wed, 31 Aug 2022 17:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661967535;
        bh=D4Glj29cxfnVnFmKHs1c6BviC0rnND3GsRwXno+BkJg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KX/srS6ckLaWAZMBkZejP8bz4OBnd1u5xiKsDL7QqFNsw3GTqDygqyYVX9/9beCrC
         8KiteNhCWiq63Q018cVHSu6QiOnF5M4FM+vuDEGfEr8A7zDUb9/f/7I9ShxxpnURY1
         3Km7rAteVli4YiCLFkRDMQctQ8iEupdlpivbFWbbG/jqLJFUnkV1+kw7fSiSyR0hPz
         saaNXzPNtiz50xQl1wuXR1ATI7SbvJBmKLFwTWNl0nGTAiTH6NrQyHRRnq6EpTVXzc
         2Ze03wpM3qFQOLgqAGJ9jmmWdynRCziWZe2uUEJxEVmcMakZ0QW2gdKSni9xW4oSJv
         RW3tBTl2Fx23Q==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.org
Cc:     Haitao Huang <haitao.huang@linux.intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 5/6] selftests/sgx: retry the ioctls returned with EAGAIN
Date:   Wed, 31 Aug 2022 20:38:28 +0300
Message-Id: <20220831173829.126661-6-jarkko@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220831173829.126661-1-jarkko@kernel.org>
References: <20220831173829.126661-1-jarkko@kernel.org>
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

From: Haitao Huang <haitao.huang@linux.intel.com>

For EMODT and EREMOVE ioctls with a large range, kernel
may not finish in one shot and return EAGAIN error code
and count of bytes of EPC pages on that operations are
finished successfully.

Change the unclobbered_vdso_oversubscribed_remove test
to rerun the ioctls in a loop, updating offset and length
using the byte count returned in each iteration.

Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v2:
* Changed branching in EAGAIN condition so that else branch
  is not required.
* Addressed Reinette's feedback:
  https://lore.kernel.org/linux-sgx/5d19be91-3aef-5cbe-6063-3ff3dbd5572b@intel.com/
---
 tools/testing/selftests/sgx/main.c | 42 ++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index c5aa9f323745..f42941da3bbe 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -395,6 +395,7 @@ TEST_F_TIMEOUT(enclave, unclobbered_vdso_oversubscribed_remove, 900)
 	struct encl_segment *heap;
 	unsigned long total_mem;
 	int ret, errno_save;
+	unsigned long count;
 	unsigned long addr;
 	unsigned long i;
 
@@ -458,16 +459,30 @@ TEST_F_TIMEOUT(enclave, unclobbered_vdso_oversubscribed_remove, 900)
 	modt_ioc.offset = heap->offset;
 	modt_ioc.length = heap->size;
 	modt_ioc.page_type = SGX_PAGE_TYPE_TRIM;
-
+	count = 0;
 	TH_LOG("Changing type of %zd bytes to trimmed may take a while ...",
 	       heap->size);
-	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_MODIFY_TYPES, &modt_ioc);
-	errno_save = ret == -1 ? errno : 0;
+	do {
+		ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_MODIFY_TYPES, &modt_ioc);
+
+		errno_save = ret == -1 ? errno : 0;
+		if (errno_save != EAGAIN)
+			break;
+
+		EXPECT_EQ(modt_ioc.result, 0);
+
+		count += modt_ioc.count;
+		modt_ioc.offset += modt_ioc.count;
+		modt_ioc.length -= modt_ioc.count;
+		modt_ioc.result = 0;
+		modt_ioc.count = 0;
+	} while (modt_ioc.length != 0);
 
 	EXPECT_EQ(ret, 0);
 	EXPECT_EQ(errno_save, 0);
 	EXPECT_EQ(modt_ioc.result, 0);
-	EXPECT_EQ(modt_ioc.count, heap->size);
+	count += modt_ioc.count;
+	EXPECT_EQ(count, heap->size);
 
 	/* EACCEPT all removed pages. */
 	addr = self->encl.encl_base + heap->offset;
@@ -495,15 +510,26 @@ TEST_F_TIMEOUT(enclave, unclobbered_vdso_oversubscribed_remove, 900)
 
 	remove_ioc.offset = heap->offset;
 	remove_ioc.length = heap->size;
-
+	count = 0;
 	TH_LOG("Removing %zd bytes from enclave may take a while ...",
 	       heap->size);
-	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_REMOVE_PAGES, &remove_ioc);
-	errno_save = ret == -1 ? errno : 0;
+	do {
+		ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_REMOVE_PAGES, &remove_ioc);
+
+		errno_save = ret == -1 ? errno : 0;
+		if (errno_save != EAGAIN)
+			break;
+
+		count += remove_ioc.count;
+		remove_ioc.offset += remove_ioc.count;
+		remove_ioc.length -= remove_ioc.count;
+		remove_ioc.count = 0;
+	} while (remove_ioc.length != 0);
 
 	EXPECT_EQ(ret, 0);
 	EXPECT_EQ(errno_save, 0);
-	EXPECT_EQ(remove_ioc.count, heap->size);
+	count += remove_ioc.count;
+	EXPECT_EQ(count, heap->size);
 }
 
 TEST_F(enclave, clobbered_vdso)
-- 
2.37.2

