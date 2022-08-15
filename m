Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD973592FFE
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Aug 2022 15:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242386AbiHONdT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Aug 2022 09:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242943AbiHONc7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Aug 2022 09:32:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675C917053
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Aug 2022 06:32:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0626460DE6
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Aug 2022 13:32:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B06C433D6;
        Mon, 15 Aug 2022 13:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660570377;
        bh=hGKsg3UedEP/7h/cGhmdjQQzBHXgVmuy3ZE9b+PwvgU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rIZ1SY1RdpKJ0DLPv9m6oTD5kmQYmtn2ugfXlPR5e6tfKz8oECgxtSwG2DS+w/s9G
         CLUJ4ShzCqsJ4mTOdzCxyy/pSlMMGZu+iwwBeJrFSZlJntMc9zbKcuAs41Y/4EPwzJ
         O5ucTnsygL3tP6ct4zpr1dmL/AsM9sle6A5+nahVCtYaN0/t+5f6s7osST7uWGwUOu
         A9Jy/411fzkQTT+Qu8bXKrM5pek4G+Mw7H+DFx74WE13PblwRdOSOegXhme2T9uhDH
         D95EB5Gi9aGKh6KAGCL8aXcb4nO3RzS3xoMCCgmr28EL+zDW2F0jarTPsyF2+sOzkM
         KI1cxny/9MGxw==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 05/10] kselftest/arm64: Remove unneeded protype for validate_extra_context()
Date:   Mon, 15 Aug 2022 14:32:31 +0100
Message-Id: <20220815133236.235464-6-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220815133236.235464-1-broonie@kernel.org>
References: <20220815133236.235464-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=910; i=broonie@kernel.org; h=from:subject; bh=hGKsg3UedEP/7h/cGhmdjQQzBHXgVmuy3ZE9b+PwvgU=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBi+krvTVYAh3LqfmHJ9Va/vprJOKc1AViua+o3JGuY nPMRrWeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYvpK7wAKCRAk1otyXVSH0KkNB/ 948vMXy+SZFbs/vZ4UcjevsoMS69CB4X/6NIolxFs4hx5B43ydt+ov+jQseN/QKcEMaAEmmvgXXdpv 1kw9xK7Ib0Qis5czJTeK3ys0y4mZjNOUPFQmVsHw+J40x9eHn6bmdqWyEQARO7WLpKjOJe9TMbLDKl fSFrNfv8LMZhNOUpTf6pZ5BD7mSIdj4M5ZvNvuoB0fpjEoVt5ZmCr3CfaWSHSeDQv0NPXV0Iiroor9 2mfPZ54Xu0NTK/ilLn5fb6UXHfOJ5WnCfYVnJVjKLow8C9ODC2EKN3Kkn29JSSp3In9KcaKYMKEAx7 y7qO/uZAmZYexBaicOtztwqE+vOni9
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

