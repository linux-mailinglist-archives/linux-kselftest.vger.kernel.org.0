Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7275592FFB
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Aug 2022 15:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242144AbiHONdR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Aug 2022 09:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242903AbiHONcz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Aug 2022 09:32:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8515E17A81
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Aug 2022 06:32:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0F8460EC3
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Aug 2022 13:32:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C69BEC4347C;
        Mon, 15 Aug 2022 13:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660570373;
        bh=V8kvWQdcoruSY2BGzEtAHoX5MY2BJ0by5Hd6bThqyO8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NVugO1vpq0HMhuJ8QUVqpORukDWjKyBNZ2e0cgDIWQewa5E2x7zlWjGiB6Wj1mAev
         rJRsH6QnhBjOLZdNgvV5S3kOEB/l+BLrToNeeTVF0IRs37vX/9HBB4q1n12mTn95C1
         bYYunsTgmnwrdRQn14eyVKbrK1bFKookvjXVVlWAuKRNO62MefIa9e7sWTCfraUoJg
         R5cjy7MD9tynnwRzOCRXbYaXO0f3yezxRoYZq0C6lJKgjSykzeEM1vwRjijsC9KdVu
         0vtUUW/0DB8Wms/FBzpWFPAW/5NPSRHYVL2nTvRrABc6sDkEgK3DfQnEuTCFUW+tts
         bXXCnUCV18Vwg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 03/10] kselftest/arm64: Fix validatation termination record after EXTRA_CONTEXT
Date:   Mon, 15 Aug 2022 14:32:29 +0100
Message-Id: <20220815133236.235464-4-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220815133236.235464-1-broonie@kernel.org>
References: <20220815133236.235464-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1709; i=broonie@kernel.org; h=from:subject; bh=V8kvWQdcoruSY2BGzEtAHoX5MY2BJ0by5Hd6bThqyO8=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBi+krty0PRjapkJNbtLYlRyJSLUtCtMGiZLxJxN4VR arsmbjWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYvpK7QAKCRAk1otyXVSH0NDGB/ 9vuputIr6mJBEKGUyk5ew6yyBBXsTobWtkXQDKomUAs9UM3E9xoaJd7n3ggnmmwhLFebTZvXAmtQgw UzLdjKNn+f/Fu53kdq9Y6NjohI9FreeH5tezAERQkBlWTvQkLjGDC7SA5Kp3tRxjltlvsmykIo7DE2 QgKfhMLcvinVekKkI1gWuGYPOGbBWzGkcG1CZWuP8qOwlxtrOTPX5/j3f9r8wp2igEFr0f6U+IYLzR vNqKLLEd4FkbTu4riPUjhmMjJJ9UC3SRKqd14UDR7TT4Lz2QcIPEN/ipX0AtYjXZol+IItJS67bCQ5 WKVHHD41wkjJhj/Bw8E9edmSa4LBTO
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

When arm64 signal context data overflows the base struct sigcontext it gets
placed in an extra buffer pointed to by a record of type EXTRA_CONTEXT in
the base struct sigcontext which is required to be the last record in the
base struct sigframe. The current validation code attempts to check this
by using GET_RESV_NEXT_HEAD() to step forward from the current record to
the next but that is a macro which assumes it is being provided with a
struct _aarch64_ctx and uses the size there to skip forward to the next
record. Instead validate_extra_context() passes it a struct extra_context
which has a separate size field. This compiles but results in us trying
to validate a termination record in completely the wrong place, at best
failing validation and at worst just segfaulting. Fix this by passing
the struct _aarch64_ctx we meant to into the macro.

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

