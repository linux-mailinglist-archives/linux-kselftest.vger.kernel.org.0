Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28255AC351
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Sep 2022 09:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbiIDHyS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 4 Sep 2022 03:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiIDHyR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 4 Sep 2022 03:54:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE694B4A3;
        Sun,  4 Sep 2022 00:54:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2ACB9B80D41;
        Sun,  4 Sep 2022 07:54:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81BD9C433D6;
        Sun,  4 Sep 2022 07:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662278052;
        bh=YqXxpCQTGQ725ygdhhyFAkQ+r1LluYvSD8o8glO4Ny4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cKC1DVH4BTZaoeBnTnq2W7Rv3snfIyVTlJNMnwRDIxoW7xaK3k9+Jp4CaMvSxOpOF
         PsC59MGt2T9mvOUT7fvI/McUaW2JOcCiztS3xgKO0+q0w8VhAP71MWU73wPf8A9QkQ
         HnxUOLgcNbAMr/5OqUl7NtTlUtiLp7Pq8qGsDOTId1gxLHnHv4o7TLZxINYQ6Odejd
         EJOfYZmNxjhk5+UhlalrCN0UleVy155zXhW2CMs2KR5WDP3pJY+nKghlXR8I5YSjsD
         OLUnHBEqM3+15y81zYR3hRidAfjTghpGmM+GLnIJojt+BlYFTJqgpNCQYgu4T3D6MC
         yDuR9Z503IhbA==
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
Subject: [PATCH 1/5] selftests/sgx: Retry the ioctl()'s returned with EAGAIN
Date:   Sun,  4 Sep 2022 10:53:54 +0300
Message-Id: <20220904075358.7727-2-jarkko@kernel.org>
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

From: Haitao Huang <haitao.huang@linux.intel.com>

For EMODT and EREMOVE ioctl()'s with a large range, kernel
may not finish in one shot and return EAGAIN error code
and count of bytes of EPC pages on that operations are
finished successfully.

Change the unclobbered_vdso_oversubscribed_remove test
to rerun the ioctl()'s in a loop, updating offset and length
using the byte count returned in each iteration.

Fixes: 6507cce561b4 ("selftests/sgx: Page removal stress test")
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v3:
* Added a fixes tag. The bug is in v6.0 patches.
* Added my tested-by (the bug reproduced in my NUC often).
v2:
* Changed branching in EAGAIN condition so that else branch
  is not required.
* Addressed Reinette's feedback:
---
 tools/testing/selftests/sgx/main.c | 42 ++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index 9820b3809c69..59cca806eda1 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -390,6 +390,7 @@ TEST_F_TIMEOUT(enclave, unclobbered_vdso_oversubscribed_remove, 900)
 	struct encl_segment *heap;
 	unsigned long total_mem;
 	int ret, errno_save;
+	unsigned long count;
 	unsigned long addr;
 	unsigned long i;
 
@@ -453,16 +454,30 @@ TEST_F_TIMEOUT(enclave, unclobbered_vdso_oversubscribed_remove, 900)
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
@@ -490,15 +505,26 @@ TEST_F_TIMEOUT(enclave, unclobbered_vdso_oversubscribed_remove, 900)
 
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

