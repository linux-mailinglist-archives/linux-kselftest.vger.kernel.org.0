Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6025AC357
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Sep 2022 09:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbiIDHyb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 4 Sep 2022 03:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbiIDHya (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 4 Sep 2022 03:54:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771A7193;
        Sun,  4 Sep 2022 00:54:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C832460F18;
        Sun,  4 Sep 2022 07:54:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D77ECC433C1;
        Sun,  4 Sep 2022 07:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662278059;
        bh=Ipe58/5YZNyUeQdly6LVo6U7DHg6Ja0YMjrUuYpntAk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lXE/ehUmblqhU/cGF4yxECnxWFhtfvbzeDa0DJmgTuuWX0fAlsaTTal3Hmh5l2Tre
         t8yfLLTZgYbw24v1K+QWlXBgypCYoVZgDchv7sOxqF9dhoQMQ7/yU6EnCRWSJqUSX1
         3jkTsZUp2L0oIBWszohc0AnS87xqU3dI+Fm4xAVGI7YFzEWcVeBMlpwMLqtZwTeuIO
         r8dwYZXcRN3TausJri8JHC2puvCxerm9kGRFJRuztmBVlrXpkaM2qR7DFyluOM9J9A
         3HOuWBPUb++gAzmhLabEW8MQ9ggXrTTyPrJmMDcnsYrsxxRirnMDMVSFgZ3H+JkwrF
         FhUfgIiRDWaRQ==
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
Subject: [PATCH 3/5] selftests/sgx: Use encl->encl_size in sigstruct.c
Date:   Sun,  4 Sep 2022 10:53:56 +0300
Message-Id: <20220904075358.7727-4-jarkko@kernel.org>
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

The final enclave address range (referred as ELRANGE in Intel SDM)
calculation is a reminiscent of signing tool being a separate command-line
utility, and sigstruct being produced during the compilation. Given that
nowadays the sigstruct is calculated on-fly, use the readily calculated
encl->encl_size instead, in order to remove duplicate code.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 tools/testing/selftests/sgx/load.c      | 5 +++--
 tools/testing/selftests/sgx/main.h      | 1 -
 tools/testing/selftests/sgx/sigstruct.c | 8 ++------
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/sgx/load.c b/tools/testing/selftests/sgx/load.c
index 94bdeac1cf04..3b4e2422fb09 100644
--- a/tools/testing/selftests/sgx/load.c
+++ b/tools/testing/selftests/sgx/load.c
@@ -174,6 +174,7 @@ uint64_t encl_get_entry(struct encl *encl, const char *symbol)
 bool encl_load(const char *path, struct encl *encl, unsigned long heap_size)
 {
 	const char device_path[] = "/dev/sgx_enclave";
+	unsigned long contents_size;
 	struct encl_segment *seg;
 	Elf64_Phdr *phdr_tbl;
 	off_t src_offset;
@@ -298,9 +299,9 @@ bool encl_load(const char *path, struct encl *encl, unsigned long heap_size)
 	if (seg->src == MAP_FAILED)
 		goto err;
 
-	encl->src_size = encl->segment_tbl[j].offset + encl->segment_tbl[j].size;
+	contents_size = encl->segment_tbl[j].offset + encl->segment_tbl[j].size;
 
-	for (encl->encl_size = 4096; encl->encl_size < encl->src_size; )
+	for (encl->encl_size = 4096; encl->encl_size < contents_size; )
 		encl->encl_size <<= 1;
 
 	return true;
diff --git a/tools/testing/selftests/sgx/main.h b/tools/testing/selftests/sgx/main.h
index 82b33f8db048..9c1bc0d9b43c 100644
--- a/tools/testing/selftests/sgx/main.h
+++ b/tools/testing/selftests/sgx/main.h
@@ -20,7 +20,6 @@ struct encl {
 	void *bin;
 	off_t bin_size;
 	void *src;
-	size_t src_size;
 	size_t encl_size;
 	off_t encl_base;
 	unsigned int nr_segments;
diff --git a/tools/testing/selftests/sgx/sigstruct.c b/tools/testing/selftests/sgx/sigstruct.c
index a07896a46364..9a40c7966eda 100644
--- a/tools/testing/selftests/sgx/sigstruct.c
+++ b/tools/testing/selftests/sgx/sigstruct.c
@@ -218,13 +218,9 @@ struct mrecreate {
 } __attribute__((__packed__));
 
 
-static bool mrenclave_ecreate(EVP_MD_CTX *ctx, uint64_t blob_size)
+static bool mrenclave_ecreate(EVP_MD_CTX *ctx, uint64_t encl_size)
 {
 	struct mrecreate mrecreate;
-	uint64_t encl_size;
-
-	for (encl_size = 0x1000; encl_size < blob_size; )
-		encl_size <<= 1;
 
 	memset(&mrecreate, 0, sizeof(mrecreate));
 	mrecreate.tag = MRECREATE;
@@ -349,7 +345,7 @@ bool encl_measure(struct encl *encl)
 	if (!ctx)
 		goto err;
 
-	if (!mrenclave_ecreate(ctx, encl->src_size))
+	if (!mrenclave_ecreate(ctx, encl->encl_size))
 		goto err;
 
 	for (i = 0; i < encl->nr_segments; i++) {
-- 
2.37.2

