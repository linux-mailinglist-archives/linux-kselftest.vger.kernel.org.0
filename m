Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2985A5104
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Aug 2022 18:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiH2QHp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Aug 2022 12:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiH2QHo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Aug 2022 12:07:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FCF85FD0
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Aug 2022 09:07:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D1DD8B81118
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Aug 2022 16:07:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2F8C433D7;
        Mon, 29 Aug 2022 16:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661789259;
        bh=OEluHX2rINw79r1ixw5NAaWYr6eeAln8ZyuAwVaM4PU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LiJ/hTIl4lOl3Yvc1JCHm05fhIGyj/MSjoFGXLWeAWaJRyXnKyMhMyc5D80C3fq8w
         DxEtbeHA4GfYxiTYlp4oNXBCjFx3t8UsFG0IHmOzDTBK7jRzcI8Bh2QMSAa7h+mHbn
         tE/1TaOXb5dzcyLRAOd18sp+JaX0HF44cW4OhCy486ND+e5rslCHeAubNTaD700SYz
         E7npn0Itky3iiGpmWmGshWTblMkhi8e4/zg33NhOCPqU7zme3fE3evSrgO/RqQiGR/
         NGUPNjqXjI+QhcI7TCkjkMm19t9r0/4jQdZ87M+y8Y0ejVEHGDSzGy8crm6zCc73Ir
         kRa+9ZYQQieMQ==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 04/10] kselftest/arm64: Fix validation of EXTRA_CONTEXT signal context location
Date:   Mon, 29 Aug 2022 17:06:57 +0100
Message-Id: <20220829160703.874492-5-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220829160703.874492-1-broonie@kernel.org>
References: <20220829160703.874492-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1431; i=broonie@kernel.org; h=from:subject; bh=OEluHX2rINw79r1ixw5NAaWYr6eeAln8ZyuAwVaM4PU=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjDOQh53ACy+qtRh8Sc/w53mW6y7ChJCJBs5P7thFO wOL9vv+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYwzkIQAKCRAk1otyXVSH0CQlB/ oCOs07QltSZ2zCRtD/6CXoh9aJ05Kfs8LhaSqg9SyLGTwqglp+UP13urM+/1mL1FAHdisje1GHs6mn rIgrHOYL4HW4vZ0B7fS+mH1pKKRnDsj3THUdx8brr+cERfp3zxhNhjX9WzkeSZWlz2u5/nBUkUM0qD pwFsARjnkkqdP8aBTrm4xKwqEq/zSUvuaPGBD8CY5X3Y1WuE7r0M7/MfsHGow9BXeWzsx/9VNDUIxG Q/HxAUp6nsmX8BidDgI22lDdnqSN63ArGcDdEo50kAsCzYrI7yi0PeSatVEPZCuLzCYcyPfXTj31bJ OQ/WduM0jvQ85lp0rNFHyTYbpJxQKc
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
index d98828cb542b..16dc916939f9 100644
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

