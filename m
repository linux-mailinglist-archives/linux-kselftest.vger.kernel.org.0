Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF97766039
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 01:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjG0X1H (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 19:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbjG0X1F (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 19:27:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A862D40
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jul 2023 16:27:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62E9561F89
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jul 2023 23:27:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E1BC433C7;
        Thu, 27 Jul 2023 23:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690500423;
        bh=3Twxt+ztmPtVD0NHowFG7vKtvYRRWttH91DBpHBezI0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=ZewPS2cTsNisFWlRk/n/RKJhsrj9H3CELspdWuitrGRnprnemAQxNUSQXdescoYYG
         jKRJlkTsK+EJjc+EnyVmoyMCUdPouf+Y6I36UAwUyy+xO5nnGFmP4AtIkgk6pjGhwK
         +5TSOInCLFslFOfSzycjHN750UwrZHmjqa0S5Yjaw6bXdPldwogORaOMsI5zvWydNn
         +qQNSZugsczBIOczeOtC2Nqz1X6osFou49tdFWb/YblxaWJedI7sHntQo0kB+7Iy4I
         sDQPpIZ3a/iWrb0xvF6qydxKgmFBDEej0l6x+VQ/8TWrfxUNhOG1Um13FlFsZdBYld
         pzJPh/3jCBjEw==
From:   Mark Brown <broonie@kernel.org>
Date:   Fri, 28 Jul 2023 00:26:15 +0100
Subject: [PATCH v4 4/6] kselftest/arm64: Make the tools/include headers
 available
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230728-arm64-signal-memcpy-fix-v4-4-0c1290db5d46@kernel.org>
References: <20230728-arm64-signal-memcpy-fix-v4-0-0c1290db5d46@kernel.org>
In-Reply-To: <20230728-arm64-signal-memcpy-fix-v4-0-0c1290db5d46@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=679; i=broonie@kernel.org;
 h=from:subject:message-id; bh=3Twxt+ztmPtVD0NHowFG7vKtvYRRWttH91DBpHBezI0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkwv08T3Xmn3L+KDEN17Ziv1NJDSuu1hCzTrzS5/3j
 8N2YXtOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZML9PAAKCRAk1otyXVSH0CiJB/
 9ZvL1M+upvI8SckwQ3t7MnnK28cyuCGBUjdWIBKplPv1nlemi4c/pqZfO6zlTC5YASi3j02mMbST3e
 eKVB54k497BtzlMyMf4ey3HzQbBKKU+GRBrBzY3WdaZ+M7XZRCSlS04GSM+CKu4pqkB6Or4LQ1Su6l
 kMVBEsMXvXwSqeRuYvi0fM+rW6/5VUzPiYbG2k9pzN7eE0TEi4hA2cWXbf8T3tStrldONWLT0M6Q9y
 i8uiiYoBpfktwjLuI2k+uwa7uqggY5WrErTY7CPIedU62xatcELrugd7kx3AjlrVDKSnfduMszGPB/
 hfUqp5TCNNwTtyHjZGPyOeow9ReB0R
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Make the generic tools/include headers available to the arm64 selftests so
we can reduce some duplication.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/arm64/Makefile b/tools/testing/selftests/arm64/Makefile
index ace8b67fb22d..28b93cab8c0d 100644
--- a/tools/testing/selftests/arm64/Makefile
+++ b/tools/testing/selftests/arm64/Makefile
@@ -19,6 +19,8 @@ CFLAGS += -I$(top_srcdir)/tools/testing/selftests/
 
 CFLAGS += $(KHDR_INCLUDES)
 
+CFLAGS += -I$(top_srcdir)/tools/include
+
 export CFLAGS
 export top_srcdir
 

-- 
2.30.2

