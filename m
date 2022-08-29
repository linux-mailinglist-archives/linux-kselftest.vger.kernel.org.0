Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CD75A5103
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Aug 2022 18:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiH2QHj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Aug 2022 12:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiH2QHg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Aug 2022 12:07:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317E885FD0
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Aug 2022 09:07:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D226DB8111B
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Aug 2022 16:07:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27AEEC43470;
        Mon, 29 Aug 2022 16:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661789252;
        bh=V8kvWQdcoruSY2BGzEtAHoX5MY2BJ0by5Hd6bThqyO8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JtbUMolVkiz4eiZU0Gy+BakCXKEEjuIsRg7LciRTgofT3hrH/SuWPktaEWjqQ115h
         5TlgL6nu+OnNaJ3jntyVbRygGEsgZdt8eRa+/+TryPxTfyvfR8rpIZHY1kO5Ht+TYl
         QExbA8tELV3ItzxT6V8uBhSwPUTUp3MhGQU/G+LX8Jcz/zfkgC/HA7rR4pMUrJdrTM
         3ENeohXkn7i3mEEk2eDUl9qLs3Wgyy/WMrvZ6z+MMhKOKDwKh0S+yNG7P4z+Orlbcl
         pYueaeF0Criw3V9T3dZhpUeQ+2HwhLOBFkb6JM1COGQQHWjG9LsTb4C4U+mVAlbJqy
         ZcfnfdO2vCtBw==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 03/10] kselftest/arm64: Fix validatation termination record after EXTRA_CONTEXT
Date:   Mon, 29 Aug 2022 17:06:56 +0100
Message-Id: <20220829160703.874492-4-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220829160703.874492-1-broonie@kernel.org>
References: <20220829160703.874492-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1709; i=broonie@kernel.org; h=from:subject; bh=V8kvWQdcoruSY2BGzEtAHoX5MY2BJ0by5Hd6bThqyO8=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjDOQgy0PRjapkJNbtLYlRyJSLUtCtMGiZLxJxN4VR arsmbjWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYwzkIAAKCRAk1otyXVSH0EFgB/ 9prONbldDZNnLJh4GtRqxxwOysyXe5W3UIZVRpEbuREle7Dl4SKFZgKGZeL7bAuNv7zdpDPzlmid+x XW7v6wtGv1Woeh7G/T/Pl/Umpqw4/5WB24e0DTcrKkSenHAJfIr6RKNMJrFLGcijPtCYbmznfZaF74 U8DtqQKNz9KkWU6tuIf30kLS44FwtsKzuZ69rnfq4ilcoOQONLS0IMT8vYl118N1b6FNO6/SoWiPFn 2yVVdxpU345hScfomI05lQvKLaSUyGP/4LvwtfQjg1kBVUsw23yWkpjqB05KDqEUmgOz15esjLD+w/ opsdzmrFBKz3tJaXf793GXqdmNo/aX
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

