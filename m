Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0A75A5108
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Aug 2022 18:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiH2QIB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Aug 2022 12:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiH2QIA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Aug 2022 12:08:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E417085FD0
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Aug 2022 09:07:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A22A6B81117
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Aug 2022 16:07:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB25FC433C1;
        Mon, 29 Aug 2022 16:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661789277;
        bh=/WFb/N5O8AgUjIFzL8VcJC649OnWoCnCH7PCPPopE9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SMqZkA0CCFkexegb313WYj1l5N9R2f1OENbYP+SuA2LFKo8hljsbe8Nfk0hvMEo5r
         0eS1xsxiCCQGk2aquJQ3bloJfHSHN/DJK3KuxwFn1qYCxl04v8oQc1RWiZV8jmbWR6
         MmBgSXJEdQh+IGAZ6MUKkqU5B/LguCPnSKpw29+jbD64E0aqTe0enVq3c7ggNIxIi3
         B0RHlMZYkB9Exv8RDhoWfhaogWFEVGhafklv0Rmc3RxvLVRxkSnkhgo3gSoz9qUNPM
         d/MJznUVOe73tHr4/K2HnTNTNXBDMQHJ9gHplZ8Yik3PrkVtDce+SWM2EeuXym8Vf5
         B7DzQtlUQOW2A==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 07/10] kselftest/arm64: Validate contents of EXTRA_CONTEXT blocks
Date:   Mon, 29 Aug 2022 17:07:00 +0100
Message-Id: <20220829160703.874492-8-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220829160703.874492-1-broonie@kernel.org>
References: <20220829160703.874492-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2567; i=broonie@kernel.org; h=from:subject; bh=/WFb/N5O8AgUjIFzL8VcJC649OnWoCnCH7PCPPopE9s=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjDOQkyKH9XTGK6DuYhZ+zZkKmkU3wcSyOtiyMcOTO t5F2Yu+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYwzkJAAKCRAk1otyXVSH0LixB/ 4uNsX9qNsUs5jRW7TeGC9um/kxH9XKg56Jd7hvcSPaNJPteO8vxXLZP9ixSzgLi8aXkBic+pEGzjLX U9LtDhV3RL53oITzoIpSqVjTdsink2qH2Ayutai0ytDHT4S3e78WFhWE0K3gCc9Bu4Lo9yjGeXuXvI 49iBARXujpiZ7BIRHzpOW+abzz1uTtR4fyxIzCMaN3yIcTFwPYoT3mxVOjiKKOipu6JCXtg+UkKoAC DAGLg/d0ex8NmpGnWvzN8OMH6oaVMHPO1wDI3AmXtbqd1h6H49+wt3aG6G5Ojzp/8zg65QBWpey3Wj 31oQEsDdAJ4QQDLXcUwsH03p0FnrBU
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

