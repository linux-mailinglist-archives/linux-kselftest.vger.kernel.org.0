Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0725A50AA
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Aug 2022 17:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiH2Puz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Aug 2022 11:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiH2Puy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Aug 2022 11:50:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CAA89922
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Aug 2022 08:50:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 061E0B81109
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Aug 2022 15:50:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B22FC433C1;
        Mon, 29 Aug 2022 15:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661788250;
        bh=4SS1HhiCCSG9y1tYIhTUgiCAE3c544P3f86asq/gm0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WLN6EaqzhIik23Ovn7oYm5ym7YxKZjz+YRtjMvW1FKK3JBvHnRpjxV7IRyqv2ssev
         w4xMff3CKgLr1QymEFRRReW4zzKGNCYMI2U5GBsN3RvUll2hM8rV4Tl5Y4kaK16NRN
         4tZM2DkW+qRl+QeLFlLx/v1Ro6pr4eYPWW4Eidyg8r2ndCR736GJzysoVdJUmWQAZ2
         nP83y1yrtQZJqh0gi/mzEOsBnQs/juiNpl2emFhHlsRsXDcoBDVaribolkSQhTJFrQ
         kCuoyYWI+Nge/QcnL0a4iQS2puuBgday4l5FXvsGFDbDekjY0eagbHip+q+go1MkIz
         LxOS25ehUwFMg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v4 2/4] arm64/ptrace: Document extension of NT_ARM_TLS to cover TPIDR2_EL0
Date:   Mon, 29 Aug 2022 16:49:19 +0100
Message-Id: <20220829154921.837871-3-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220829154921.837871-1-broonie@kernel.org>
References: <20220829154921.837871-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1023; i=broonie@kernel.org; h=from:subject; bh=4SS1HhiCCSG9y1tYIhTUgiCAE3c544P3f86asq/gm0U=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjDN/+G54LoL/yWs5q4ClkhlcssbMavyJEG2YIqqRj 7oMMUOKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYwzf/gAKCRAk1otyXVSH0PdaB/ 9wHEw8feBFk/t5VuOhnmODXTg+U9Xl+CXUtR2wbnNLcjXRyk2mDXsiqjsGDf1DUTv4x35H6XPCodYg cC5wSppufKLnTWBSWedRAoBaN1NP/X5Gn5Dw1hpFkgkWkDG83GO1n2NjpQNP84U7FzJXjreen3g1aO 98KpO62ipyzRBT0MzheD1ET3tb2Ern53eH6u1u2iJrXs7LfxiXuu799yKzdrUukoNdUE171mKeemIQ XiA+DZcBy3jYQEWrNySKkh4pfuJbgtxe2YWXUUQ3n5uW9lRld4cAD+K112Sw61IIdOyA4Zi9arPmUH 8ZcOepee1rgL3eBKLLOr2CuMnauQqM
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

In order to allow debuggers to discover lazily saved SME state we need
to provide access to TPIDR2_EL0, we will extend the existing NT_ARM_TLS
used for TPIDR to also include TPIDR2_EL0 as the second register in the
regset.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/arm64/sme.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/arm64/sme.rst b/Documentation/arm64/sme.rst
index 937147f58cc5..16d2db4c2e2e 100644
--- a/Documentation/arm64/sme.rst
+++ b/Documentation/arm64/sme.rst
@@ -331,6 +331,9 @@ The regset data starts with struct user_za_header, containing:
   been read if a PTRACE_GETREGSET of NT_ARM_ZA were executed for each thread
   when the coredump was generated.
 
+* The NT_ARM_TLS note will be extended to two registers, the second register
+  will contain TPIDR2_EL0 on systems that support SME and will be read as
+  zero with writes ignored otherwise.
 
 9.  System runtime configuration
 --------------------------------
-- 
2.30.2

