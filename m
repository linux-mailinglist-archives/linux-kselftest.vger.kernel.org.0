Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8B27D9F85
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Oct 2023 20:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346273AbjJ0SJv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Oct 2023 14:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346270AbjJ0SJu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Oct 2023 14:09:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6594FAC;
        Fri, 27 Oct 2023 11:09:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C04221424;
        Fri, 27 Oct 2023 11:10:29 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2A533F64C;
        Fri, 27 Oct 2023 11:09:45 -0700 (PDT)
From:   Joey Gouly <joey.gouly@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        broonie@kernel.org, catalin.marinas@arm.com,
        dave.hansen@linux.intel.com, joey.gouly@arm.com, maz@kernel.org,
        oliver.upton@linux.dev, shuah@kernel.org, will@kernel.org,
        kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v2 18/24] kselftest/arm64: move get_header()
Date:   Fri, 27 Oct 2023 19:08:44 +0100
Message-Id: <20231027180850.1068089-19-joey.gouly@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231027180850.1068089-1-joey.gouly@arm.com>
References: <20231027180850.1068089-1-joey.gouly@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Put this function in the header so that it can be used by other tests, without
needing to link to testcases.c.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 .../arm64/signal/testcases/testcases.c        | 23 -----------------
 .../arm64/signal/testcases/testcases.h        | 25 +++++++++++++++++--
 2 files changed, 23 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/arm64/signal/testcases/testcases.c b/tools/testing/selftests/arm64/signal/testcases/testcases.c
index 9f580b55b388..fe950b6bca6b 100644
--- a/tools/testing/selftests/arm64/signal/testcases/testcases.c
+++ b/tools/testing/selftests/arm64/signal/testcases/testcases.c
@@ -6,29 +6,6 @@
 
 #include "testcases.h"
 
-struct _aarch64_ctx *get_header(struct _aarch64_ctx *head, uint32_t magic,
-				size_t resv_sz, size_t *offset)
-{
-	size_t offs = 0;
-	struct _aarch64_ctx *found = NULL;
-
-	if (!head || resv_sz < HDR_SZ)
-		return found;
-
-	while (offs <= resv_sz - HDR_SZ &&
-	       head->magic != magic && head->magic) {
-		offs += head->size;
-		head = GET_RESV_NEXT_HEAD(head);
-	}
-	if (head->magic == magic) {
-		found = head;
-		if (offset)
-			*offset = offs;
-	}
-
-	return found;
-}
-
 bool validate_extra_context(struct extra_context *extra, char **err,
 			    void **extra_data, size_t *extra_size)
 {
diff --git a/tools/testing/selftests/arm64/signal/testcases/testcases.h b/tools/testing/selftests/arm64/signal/testcases/testcases.h
index a08ab0d6207a..d33154c9a4bd 100644
--- a/tools/testing/selftests/arm64/signal/testcases/testcases.h
+++ b/tools/testing/selftests/arm64/signal/testcases/testcases.h
@@ -87,8 +87,29 @@ struct fake_sigframe {
 
 bool validate_reserved(ucontext_t *uc, size_t resv_sz, char **err);
 
-struct _aarch64_ctx *get_header(struct _aarch64_ctx *head, uint32_t magic,
-				size_t resv_sz, size_t *offset);
+static inline struct _aarch64_ctx *get_header(struct _aarch64_ctx *head, uint32_t magic,
+				size_t resv_sz, size_t *offset)
+{
+	size_t offs = 0;
+	struct _aarch64_ctx *found = NULL;
+
+	if (!head || resv_sz < HDR_SZ)
+		return found;
+
+	while (offs <= resv_sz - HDR_SZ &&
+	       head->magic != magic && head->magic) {
+		offs += head->size;
+		head = GET_RESV_NEXT_HEAD(head);
+	}
+	if (head->magic == magic) {
+		found = head;
+		if (offset)
+			*offset = offs;
+	}
+
+	return found;
+}
+
 
 static inline struct _aarch64_ctx *get_terminator(struct _aarch64_ctx *head,
 						  size_t resv_sz,
-- 
2.25.1

