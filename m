Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03539592FFF
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Aug 2022 15:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242444AbiHONdW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Aug 2022 09:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243003AbiHONdF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Aug 2022 09:33:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F33417053
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Aug 2022 06:33:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BBC36B80EBB
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Aug 2022 13:33:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE32C43140;
        Mon, 15 Aug 2022 13:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660570381;
        bh=/WFb/N5O8AgUjIFzL8VcJC649OnWoCnCH7PCPPopE9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iPL8OkTAmKG1hGzqzcIKGuqDDwu3BQ+IGbCnpSb3UyimTJfzkdA0IYDA48lA3ztA1
         9/7NZs6zY+VrZThMBc5al4rny7NAqlQ3J142viRHEK5f+afFggnkMBAqabhVJ5BYCR
         i83Z7R9+zGNCAKJpFYw4yk9ftn0ZX6hTeqwppNinIkvx3c4wBw7xndTNxAZJDg9YSo
         Av1TZoDTM4Gdg8o0JsyH4pEgaEuOGIQoVqwBStQM6/Gs4lzAft5oUMEROtzbkbURh3
         8IFrdC/sb5KmbDoYG/Laj/gTB6q+iHL1zvcmuzgAY6gp0m/UU1iYc4O/xBX23QaIlr
         4qR2us7bV8g+g==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 07/10] kselftest/arm64: Validate contents of EXTRA_CONTEXT blocks
Date:   Mon, 15 Aug 2022 14:32:33 +0100
Message-Id: <20220815133236.235464-8-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220815133236.235464-1-broonie@kernel.org>
References: <20220815133236.235464-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2567; i=broonie@kernel.org; h=from:subject; bh=/WFb/N5O8AgUjIFzL8VcJC649OnWoCnCH7PCPPopE9s=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBi+krxyKH9XTGK6DuYhZ+zZkKmkU3wcSyOtiyMcOTO t5F2Yu+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYvpK8QAKCRAk1otyXVSH0EbBB/ 9Y0tPy0Lm2REqQMvTlkO2i1hqRvqNXjkwjzVEeR9J98ZoAY2r3OKtcnTpXbRAMiugk55R/lwsxeDkC 2zrTXRuBQ3cYyx0S8nImhejdkKTIHGASa8BSZE2rkm/9Y2e9rCOyFPf+pHN5ySFV8BlSVQAeWDqkkj iHYyO5ZW9qslJ+Z0FiIGaeAN56QCgWO7ZG60R6+K+68PjlXTKDhSAhHUDZJcmhVNsJ4vOGWua6vkGj ze2QdjiTaZItRfi2jCPU8oG9rYD5BI9Tsq5vZYOjU6JC44dTGLVrNFC8n6QBMsIO3iKmnu8Mgwjr2o lPg59aDZfiiamWm0K/x+pF6Ij7mxVK
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
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

Currently in validate_reserved() we check the basic form and contents of
an EXTRA_CONTEXT block but do not actually validate anything inside the
data block it provides. Extend the validation to do so, when we get to the
terminator for the main data block reset and start walking the extra data
block instead.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../arm64/signal/testcases/testcases.c        | 25 ++++++++++++++++---
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/arm64/signal/testcases/testcases.c b/tools/testing/selftests/arm64/signal/testcases/testcases.c
index 0b3c9b4b1d39..e1c625b20ac4 100644
--- a/tools/testing/selftests/arm64/signal/testcases/testcases.c
+++ b/tools/testing/selftests/arm64/signal/testcases/testcases.c
@@ -25,7 +25,8 @@ struct _aarch64_ctx *get_header(struct _aarch64_ctx *head, uint32_t magic,
 	return found;
 }
 
-bool validate_extra_context(struct extra_context *extra, char **err)
+bool validate_extra_context(struct extra_context *extra, char **err,
+			    void **extra_data, size_t *extra_size)
 {
 	struct _aarch64_ctx *term;
 
@@ -47,6 +48,9 @@ bool validate_extra_context(struct extra_context *extra, char **err)
 	if (*err)
 		return false;
 
+	*extra_data = (void *)extra->datap;
+	*extra_size = extra->size;
+
 	return true;
 }
 
@@ -111,6 +115,8 @@ bool validate_reserved(ucontext_t *uc, size_t resv_sz, char **err)
 	struct za_context *za = NULL;
 	struct _aarch64_ctx *head =
 		(struct _aarch64_ctx *)uc->uc_mcontext.__reserved;
+	void *extra_data = NULL;
+	size_t extra_sz = 0;
 
 	if (!err)
 		return false;
@@ -125,10 +131,20 @@ bool validate_reserved(ucontext_t *uc, size_t resv_sz, char **err)
 
 		switch (head->magic) {
 		case 0:
-			if (head->size)
+			if (head->size) {
 				*err = "Bad size for terminator";
-			else
+			} else if (extra_data) {
+				/* End of main data, walking the extra data */
+				head = extra_data;
+				resv_sz = extra_sz;
+				offs = 0;
+
+				extra_data = NULL;
+				extra_sz = 0;
+				continue;
+			} else {
 				terminated = true;
+			}
 			break;
 		case FPSIMD_MAGIC:
 			if (flags & FPSIMD_CTX)
@@ -196,7 +212,8 @@ bool validate_reserved(ucontext_t *uc, size_t resv_sz, char **err)
 		}
 
 		if (new_flags & EXTRA_CTX)
-			if (!validate_extra_context(extra, err))
+			if (!validate_extra_context(extra, err,
+						    &extra_data, &extra_sz))
 				return false;
 		if (new_flags & SVE_CTX)
 			if (!validate_sve_context(sve, err))
-- 
2.30.2

