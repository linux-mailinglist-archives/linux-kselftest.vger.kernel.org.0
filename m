Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD78558702F
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Aug 2022 20:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbiHASIY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Aug 2022 14:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbiHASIX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Aug 2022 14:08:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0016CEE
        for <linux-kselftest@vger.kernel.org>; Mon,  1 Aug 2022 11:08:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6FEDB81603
        for <linux-kselftest@vger.kernel.org>; Mon,  1 Aug 2022 18:08:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B685C433D6;
        Mon,  1 Aug 2022 18:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659377300;
        bh=KyYnITY8Gy/1lftcCw62z7m2B++CJ70hc7QOOKzF4c4=;
        h=From:To:Cc:Subject:Date:From;
        b=iTRkoUN7GiZ2ILFVq5YTJV+T7SPACeUW+yrjkG8T/czfx0DLMXklBZXH/TlIfS3Uz
         i/kRIgXjhw0x3Cn6jHfUKS1f5+3qQ+T7/9T9uiBx56XKIjd/plkwJsbnk+nHltIuXg
         QwG2gMjgYcC3aYg/oDe6yfNP8mKSi/c7g2sTqy/M6Fr69HVKc5bh/SfWoBDRTcXoiH
         GlrqGpVdczQhM0GCi7I/U/MoY1fhrlczgrYsOhOqAqjGmiypomo42IjGbhRe8oskKU
         RsDeB7ICz1iFehVNrD8fWZnItP9LxLyZIxHPjwJlwPDWw2ukLIBWsCNv/W+7aHgd06
         FE7+Kn8tKC2kg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH] kselftest/arm64: Fix validatation of EXTRA_CONTEXT signal data
Date:   Mon,  1 Aug 2022 19:08:00 +0100
Message-Id: <20220801180800.1091997-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1701; i=broonie@kernel.org; h=from:subject; bh=KyYnITY8Gy/1lftcCw62z7m2B++CJ70hc7QOOKzF4c4=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBi6BZ/tp0ZRcwgFMjjS2DEQEI0pbdsELBpFRcCjFqr CcCCBheJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYugWfwAKCRAk1otyXVSH0IG+B/ 48r7sAfFAFJyUAu4aR3HTI5WfnysQBSqclrWQ8W3F0pP+bJ6wVZtG6nf5Aw8PK+MpnlpUYSMRVb0gU FyVhAt78laT6OhQwxD6sEIUS7jLkttWCt9ctQyRXAcEtKUHCMATkT7zyQTFCUgnIMdCBrczbh6jN1X VhUGrsMarzbtv7my0mFpS7n5r6b4o/cZkKY+Ou5W/ICiSYONpsWvsgF2O1fUuR6qsMbx5Ityo84vFF IqOnp5HyuMAlmxFDzmQM4O5hU9NyxTM5G6Dniy5BkYnGHeq2jRJGrzQgZ0HlOBq4ekuhlP/CjqqtB1 zWTvjqZuhXFP2dEZQwGe+wBCLNdVBa
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

When arm64 signal context data overflows the base struct sigcontext it gets
placed in an extra buffer pointed to by a record of type EXTRA_CONTEXT in
the base struct sigcontext which is required to be the last record in the
base struct sigframe. The current validation code attempts to check this
by using GET_RESV_NEXT_HEAD() to step forward from the current record to
the next but that is a macro which assumes it is being provided with a
struct _aarch64_ctx and uses the size there to skip forward to the next
record. Instead validate_extra_context() passes it a struct extra_context
which has a separate size field. This compiles but results in us trying
to validate a terminator in completely the wrong place, at best failing
validation and at worst just segfaulting. Fix this by passing the struct
_aarch64_ctx we meant to into the macro.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/signal/testcases/testcases.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/signal/testcases/testcases.c b/tools/testing/selftests/arm64/signal/testcases/testcases.c
index 84c36bee4d82..d98828cb542b 100644
--- a/tools/testing/selftests/arm64/signal/testcases/testcases.c
+++ b/tools/testing/selftests/arm64/signal/testcases/testcases.c
@@ -33,7 +33,7 @@ bool validate_extra_context(struct extra_context *extra, char **err)
 		return false;
 
 	fprintf(stderr, "Validating EXTRA...\n");
-	term = GET_RESV_NEXT_HEAD(extra);
+	term = GET_RESV_NEXT_HEAD(&extra->head);
 	if (!term || term->magic || term->size) {
 		*err = "Missing terminator after EXTRA context";
 		return false;
-- 
2.30.2

