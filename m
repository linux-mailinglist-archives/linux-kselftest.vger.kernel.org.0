Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD6158742F
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Aug 2022 01:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbiHAXAh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Aug 2022 19:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235495AbiHAXAb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Aug 2022 19:00:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FEC63DC
        for <linux-kselftest@vger.kernel.org>; Mon,  1 Aug 2022 16:00:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 259E1B81890
        for <linux-kselftest@vger.kernel.org>; Mon,  1 Aug 2022 23:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 130B9C433C1;
        Mon,  1 Aug 2022 23:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659394823;
        bh=f46da727UMwp0qF4GcIudvoi5bEzKDylM74tYNSaYaw=;
        h=From:To:Cc:Subject:Date:From;
        b=lzFJLe6SfQlbp+QzbH+DwVe1DXddJrfbWsEiBzhyNS7mkvZ1pqKjj6X2qy+LjATc5
         eO/fky+onC420a2dNI/lzxJRJn8lDRWlaftgUtRQemv/q6+L/6+vGkHRlHDMoCtbQQ
         Fof2nRIlZu6iOEbKfozTnxrUySQ5P93WZavwe+Ley4MF36ahgt/pV+Cg8xXkE5zIaR
         vqfSmHL1FYHqrtCxu0CqoN+DTqhzhRohWFT5jV7Ltgc3FMfMK4DTbiWgz91WRYm5Q7
         lw59QOUrFqeMwKBerbYUplfMBcg90dDH120p3xVn54anY90Q2+oukxbYMdOU8oxiGY
         2LRrOJRHMns5w==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH] kselftest/arm64: Fix validation of EXTRA_CONTEXT signal contexts
Date:   Mon,  1 Aug 2022 23:59:26 +0100
Message-Id: <20220801225926.3694639-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1431; i=broonie@kernel.org; h=from:subject; bh=f46da727UMwp0qF4GcIudvoi5bEzKDylM74tYNSaYaw=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBi6FrO0U5z46d6gsZbaAcnAjate44USWKZeXRxsoj+ Dr5jWn6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYuhazgAKCRAk1otyXVSH0LGFB/ oCGGw9A8Gm1C202pWD36qa1jWj4jgxLXkFUwWKAGmYJwFSoTZTmdG26nsITuTuuxZtvWTEB3h4sKWb Ky+XRHPZV3uTl5mgPnUrgEwyq2beDZ0vNEkOvynRNDmp+mEO9P2OBuUpcphi+ui0WI16CzyojJ2QTj qjRYHvpu5/ePL+G6GCfxqx3OlZovYZtvxL0deTMjoyu9H/A9tOYC9ZfG5OTqTGiqNWSFxSBZjxrgzn vZ5rf/7brk6X8SZJ7+Gd9sEnm5ryRybm2NmDMobnA9xDMeVqIt6te4GbP9NobQ2Aop9JMjHBweS2k6 uZ5VSFE+rxS96rJ7j1fG8a3q1ynFGZ
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently in validate_extra_context() we assert both that the extra data
pointed to by the EXTRA_CONTEXT is 16 byte aligned and that it immediately
follows the struct _aarch64_ctx providing the terminator for the linked
list of contexts in the signal frame. Since struct _aarch64_ctx is an 8
byte structure which must be 16 byte aligned these cannot both be true. As
documented in sigcontext.h and implemented by the kernel the extra data
should be at the next 16 byte aligned address after the terminator so fix
the validation to match.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/signal/testcases/testcases.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/signal/testcases/testcases.c b/tools/testing/selftests/arm64/signal/testcases/testcases.c
index b2cce9afaaf3..0b3c9b4b1d39 100644
--- a/tools/testing/selftests/arm64/signal/testcases/testcases.c
+++ b/tools/testing/selftests/arm64/signal/testcases/testcases.c
@@ -42,7 +42,7 @@ bool validate_extra_context(struct extra_context *extra, char **err)
 		*err = "Extra DATAP misaligned";
 	else if (extra->size & 0x0fUL)
 		*err = "Extra SIZE misaligned";
-	else if (extra->datap != (uint64_t)term + sizeof(*term))
+	else if (extra->datap != (uint64_t)term + 0x10UL)
 		*err = "Extra DATAP misplaced (not contiguous)";
 	if (*err)
 		return false;
-- 
2.30.2

