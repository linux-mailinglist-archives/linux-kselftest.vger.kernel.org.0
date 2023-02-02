Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BA4688564
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Feb 2023 18:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjBBRbF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Feb 2023 12:31:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbjBBRbC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Feb 2023 12:31:02 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FFF74A44
        for <linux-kselftest@vger.kernel.org>; Thu,  2 Feb 2023 09:31:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 34561CE2BC0
        for <linux-kselftest@vger.kernel.org>; Thu,  2 Feb 2023 17:30:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D86B4C4339B;
        Thu,  2 Feb 2023 17:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675359057;
        bh=HBlP0wcnp/+JrNDOEhaP33s+WQfaCxZo9WTl7vVK7vg=;
        h=From:Date:Subject:To:Cc:From;
        b=q2ljD1kxocQF/nl4qMrqmUi5Hc9qmASoXVpFRoNOzD+Tl7hGwquzamPTpIqb7SoVk
         a0K1HG8N566jqMI6R5Q301wn/eCP2nYkfU5sIHho1nwvLkqmbTylgdDRbuP1ODM67Z
         4HTicBl+LqGXdoLNaH9guKEZr5dmnJV/q5CMHsPFPFt7FzF+wYJgYOBxv6DcF8HcMf
         ZpBPEBAOmR/N3h4z6areRi+stnGmLr1YgVZzqFY53DQ7NSxK2GqbDYUFLysDeW0iTM
         pJcDUZNa6tMAt5VcMAS+7erH6mEBSTkel3fHlvBVu5fMEXbf+IyOqbCcmnWeq3rrKU
         01ofeb+WMqklQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 02 Feb 2023 17:30:44 +0000
Subject: [PATCH] kselftest/arm64: Copy whole EXTRA context
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230201-arm64-kselftest-full-extra-v1-1-93741f32dd29@kernel.org>
X-B4-Tracking: v=1; b=H4sIAEPz22MC/x2NQQrCMBAAv1L27EISQxW/Ih42dWNDYyq7UQulf
 zf1OHOYWUFZEitcuhWEP0nTXBrYQwfDSOXBmO6NwRl3NM5YJHn2HiflHCtrxfjOGXmpQmh7H4j
 4dPbWQQsEUsYgVIZxT3xnmXb9Eo5p+T+vt237AZpBU/aDAAAA
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1940; i=broonie@kernel.org;
 h=from:subject:message-id; bh=HBlP0wcnp/+JrNDOEhaP33s+WQfaCxZo9WTl7vVK7vg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBj2/NO09R3EZtPvx1OVlcd9Lywq7oOw4x7HUpuEEsm
 asqnSX+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY9vzTgAKCRAk1otyXVSH0E+8B/
 49tVnF1MloBear5LimWYzTtIPaYaCMCP9QE0KbtJBuctWpxeCcipK1etooDkmj3vZmu4c3ssW1EUq4
 B70rWrBPiiAL06SHh0m7nGyHqUtpuECAg18NLRPaHZvtTg+a7olqfQP1PJWR2PGHNbjYtztDxFoa1d
 HyKlYZAw6nQpZqrVVQ2lW7stNxmm+VLcKeqc8HbO3EDvOc547CafJX8Tzz0UBCYvw9j0w2xYF/1PUz
 xV0jyUUUUxhmsfwIzWSiH2W+7XFxPrU17D0AMMPCiyJi4iW1FwUe66h3+Q2H/7cpjZhpiy80YdHCFj
 UQji4H4kz3vQlZK2C6HEbS9tMz76z0
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When copying the EXTRA context our calculation of the amount of data we
need to copy is incorrect, we only calculate the amount of data needed
within uc_mcontext.__reserved, not taking account of the fixed portion
of the context. Add in the offset of the reserved data so that we copy
everything we should.

This will only cause test failures in cases where the last context in the
EXTRA context is smaller than the missing data since we don't currently
validate any of the register data and all the buffers we copy into are
statically allocated so default to zero meaning that if we walk beyond the
end of what we copied we'll encounter what looks like a context with magic
and length both 0 which is a valid terminator record.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/signal/test_signals_utils.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/arm64/signal/test_signals_utils.c b/tools/testing/selftests/arm64/signal/test_signals_utils.c
index 308e229e58ab..746a4f70f082 100644
--- a/tools/testing/selftests/arm64/signal/test_signals_utils.c
+++ b/tools/testing/selftests/arm64/signal/test_signals_utils.c
@@ -192,8 +192,10 @@ static bool handle_signal_copyctx(struct tdescr *td,
 		 * in the copy, this was previously validated in
 		 * ASSERT_GOOD_CONTEXT().
 		 */
-		to_copy = offset + sizeof(struct extra_context) + 16 +
-			extra->size;
+		to_copy = __builtin_offsetof(ucontext_t,
+					     uc_mcontext.__reserved);
+		to_copy += offset + sizeof(struct extra_context) + 16;
+		to_copy += extra->size;
 		copied_extra = (struct extra_context *)&(td->live_uc->uc_mcontext.__reserved[offset]);
 	} else {
 		copied_extra = NULL;

---
base-commit: b7bfaa761d760e72a969d116517eaa12e404c262
change-id: 20230201-arm64-kselftest-full-extra-164baae78412

Best regards,
-- 
Mark Brown <broonie@kernel.org>

