Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD5F5F5963
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Oct 2022 19:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbiJERwG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Oct 2022 13:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJERwF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Oct 2022 13:52:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2ADA277E8B;
        Wed,  5 Oct 2022 10:52:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B114106F;
        Wed,  5 Oct 2022 10:52:10 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DB74A3F67D;
        Wed,  5 Oct 2022 10:52:02 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     brendan.higgins@linux.dev, davidgow@google.com,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        mark.rutland@arm.com
Subject: [PATCH] kunit: log numbers in decimal and hex
Date:   Wed,  5 Oct 2022 18:51:49 +0100
Message-Id: <20221005175149.611068-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When KUNIT_EXPECT_EQ() or KUNIT_ASSERT_EQ() log a failure, they log the
two values being compared, with numerical values logged in decimal.

In some cases, decimal output is painful to consume, and hexadecimal
output would be more helpful. For example, this is the case for tests
I'm currently developing for the arm64 insn encoding/decoding code,
where comparing two 32-bit instruction opcodes results in output such
as:

|  # test_insn_add_shifted_reg: EXPECTATION FAILED at arch/arm64/lib/test_insn.c:2791
|  Expected obj_insn == gen_insn, but
|      obj_insn == 2332164128
|      gen_insn == 1258422304

To make this easier to consume, this patch logs the values in both
decimal and hexadecimal:

|  # test_insn_add_shifted_reg: EXPECTATION FAILED at arch/arm64/lib/test_insn.c:2791
|  Expected obj_insn == gen_insn, but
|      obj_insn == 2332164128 (0x8b020020)
|      gen_insn == 1258422304 (0x4b020020)

As can be seen from the example, having hexadecimal makes it
significantly easier for a human to spot which specific bits are
incorrect.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: linux-kselftest@vger.kernel.org
Cc: kunit-dev@googlegroups.com
---
 lib/kunit/assert.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
index d00d6d181ee8..24dec5b48722 100644
--- a/lib/kunit/assert.c
+++ b/lib/kunit/assert.c
@@ -127,13 +127,15 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
 			  binary_assert->text->right_text);
 	if (!is_literal(stream->test, binary_assert->text->left_text,
 			binary_assert->left_value, stream->gfp))
-		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld\n",
+		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld (0x%llx)\n",
 				  binary_assert->text->left_text,
+				  binary_assert->left_value,
 				  binary_assert->left_value);
 	if (!is_literal(stream->test, binary_assert->text->right_text,
 			binary_assert->right_value, stream->gfp))
-		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld",
+		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld (0x%llx)",
 				  binary_assert->text->right_text,
+				  binary_assert->right_value,
 				  binary_assert->right_value);
 	kunit_assert_print_msg(message, stream);
 }
-- 
2.30.2

