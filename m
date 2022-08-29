Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFA55A5105
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Aug 2022 18:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiH2QHu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Aug 2022 12:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiH2QHt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Aug 2022 12:07:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DC0861C3
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Aug 2022 09:07:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA47460FBD
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Aug 2022 16:07:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE5EC433C1;
        Mon, 29 Aug 2022 16:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661789265;
        bh=hGKsg3UedEP/7h/cGhmdjQQzBHXgVmuy3ZE9b+PwvgU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cG8y9ZP/ctPcRs6IpxJ29mQvIrilumQUnrX8dgcXlJp5z8kCZ8n4LhH/XsQvjcFrz
         Zg8h0m7fIYT/cOdP4zs3Z5f98yKMTiY/la3KZuIIEKUCeVa5+mfRC/aFBEyJvXancT
         Z0aiYk/bnCi7t8MV4bUMrRFkiylvHo+rcKwy85cWmw3Vi0eD7Jw8hBfVC+/kKucqLm
         qka2y7OzU3FikFZ8Tskq05iqsRGJFhqCf0kULolP2BXgE1LTFIDlsyHZwh1ffJVz7j
         7ul6qWCHenqEGhkfw+pEawPnSubjzKRLsB8DzeWhA9k+tlFm/rCGdEbxwvF0HTFMZs
         gWdKGdz9I8Rvw==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 05/10] kselftest/arm64: Remove unneeded protype for validate_extra_context()
Date:   Mon, 29 Aug 2022 17:06:58 +0100
Message-Id: <20220829160703.874492-6-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220829160703.874492-1-broonie@kernel.org>
References: <20220829160703.874492-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=910; i=broonie@kernel.org; h=from:subject; bh=hGKsg3UedEP/7h/cGhmdjQQzBHXgVmuy3ZE9b+PwvgU=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjDOQhTVYAh3LqfmHJ9Va/vprJOKc1AViua+o3JGuY nPMRrWeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYwzkIQAKCRAk1otyXVSH0H9AB/ 4+Cd0LY+UXoElrGl9Xq1ympSQ13xAJAWdbmTu2y8VgVAyDi67xW5sdHdf+KCqvLl50WZwfwcw1VaoR gCMyyj2ZEbnNNPvlqeZeE+8Aw/20x8GlfD0LpYL92sUE2MNXYXbBd/NIzd4fPMizr3ZJvtrsy6v/wd 7Kw1x5+ZkR5Ymrdrm5zcF5+bPWd+oNs+sbdPf960kkcuJvjILcF+9Msp7z5plBKJQe3Fbbzterko/A 3Z6py2rEtxcZO0ljyt+m7UYfs4LAzcDxz5opYNF0jMxQwW1zOZPmb89aEn51+dWe422/Kq+kswqyKo i7FJdMDvec5vbzpQgsHQtCF+wJDVif
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

Nothing outside testcases.c should need to use validate_extra_context(),
remove the prototype to ensure nothing does.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/signal/testcases/testcases.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/arm64/signal/testcases/testcases.h b/tools/testing/selftests/arm64/signal/testcases/testcases.h
index 49f1d5de7b5b..b39f538c7be1 100644
--- a/tools/testing/selftests/arm64/signal/testcases/testcases.h
+++ b/tools/testing/selftests/arm64/signal/testcases/testcases.h
@@ -79,8 +79,6 @@ struct fake_sigframe {
 
 bool validate_reserved(ucontext_t *uc, size_t resv_sz, char **err);
 
-bool validate_extra_context(struct extra_context *extra, char **err);
-
 struct _aarch64_ctx *get_header(struct _aarch64_ctx *head, uint32_t magic,
 				size_t resv_sz, size_t *offset);
 
-- 
2.30.2

