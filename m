Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAEC54B00B
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jun 2022 14:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356613AbiFNML1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Jun 2022 08:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356732AbiFNMK5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Jun 2022 08:10:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBE649F18
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Jun 2022 05:10:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 082BC614E1
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Jun 2022 12:10:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6236AC3411B;
        Tue, 14 Jun 2022 12:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655208649;
        bh=jTXh3pg4r4JVSPJpbdDULL6F7vPm8P/wgppadxIppv4=;
        h=From:To:Cc:Subject:Date:From;
        b=lQ6rNjh9sWcQuw6Xj4AZw+WYMmSRgmq44lvHB2GXnxisrMNrh2Z8P5wy3LBsr1+df
         Xi/5UwoK+TE9tB6N7TtxwrX43pMkMFxgvr73ytkRqyRvRLYfSX2gLz6P483FrZzJZk
         0vWMokdCXJgYFSIzhNSOoNVT7QGSDJgCwTjpvk6CDF1Tmr2lzBHh++JA+yD0PZgpfe
         C+UZbHFNlNENYeQbqa/FPYfd6mAc5WDzAzYcWtwuMqrWyWPYDx7GR15C2sxJYOQ8Ra
         nCK5DLVb2ezvZw9f24zqe2V6pybBYUmPl/OLKaj7XMY1jkl71HPBJP/NAai1NzOh+n
         oV+mwgJAV7t8w==
From:   Mark Brown <broonie@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH] selftests: Fix clang cross compilation
Date:   Tue, 14 Jun 2022 13:10:45 +0100
Message-Id: <20220614121045.1046475-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2057; h=from:subject; bh=jTXh3pg4r4JVSPJpbdDULL6F7vPm8P/wgppadxIppv4=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiqHoJiDw/PQsxnk/EsY6VXaDvetNtAP7zUGUZQJWb kRgSECqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYqh6CQAKCRAk1otyXVSH0DFdB/ 4uZ+mRNhmfLgebVAML6egW4p4iOvf7UcXJDpxbP6Z38LBFn6WxgdNIye4P5u68hZp4tU9ahNAkDIVv 4+2brWHYM2HAXTP/Ki+HSL6+VdCeTjZNSH5OGTfzZcHUt9BSsMcj61Jr3SOyyPXxdw4b9+wf1XKEsl 8bN8kLqVf9g27heyAqwTp6nyYCsVH7t7HinPhzH4a4JaLWBTAhlUXg+x+BWagEONTQD5iMcODdRFbB UVCz50dYvCNXX4BzlE1g1LKoclqq1G1oqwgCBw3B8fzohCnV4SM7hGNWJIkFqqG9/v7NUV0ZtpUkzZ oV3RRmnrOdVh6IKi5mjIkuTSTmJ5lf
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Unlike GCC clang uses a single compiler image to support multiple target
architectures meaning that we can't simply rely on CROSS_COMPILE to select
the output architecture. Instead we must pass --target to the compiler to
tell it what to output, kselftest was not doing this so cross compilation
of kselftest using clang resulted in kselftest being built for the host
architecture.

More work is required to fix tests using custom rules but this gets the
bulk of things building.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/lib.mk | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 2a2d240cdc1b..1a5cc3cd97ec 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -7,10 +7,31 @@ else ifneq ($(filter -%,$(LLVM)),)
 LLVM_SUFFIX := $(LLVM)
 endif
 
-CC := $(LLVM_PREFIX)clang$(LLVM_SUFFIX)
+CLANG_TARGET_FLAGS_arm          := arm-linux-gnueabi
+CLANG_TARGET_FLAGS_arm64        := aarch64-linux-gnu
+CLANG_TARGET_FLAGS_hexagon      := hexagon-linux-musl
+CLANG_TARGET_FLAGS_m68k         := m68k-linux-gnu
+CLANG_TARGET_FLAGS_mips         := mipsel-linux-gnu
+CLANG_TARGET_FLAGS_powerpc      := powerpc64le-linux-gnu
+CLANG_TARGET_FLAGS_riscv        := riscv64-linux-gnu
+CLANG_TARGET_FLAGS_s390         := s390x-linux-gnu
+CLANG_TARGET_FLAGS_x86          := x86_64-linux-gnu
+CLANG_TARGET_FLAGS              := $(CLANG_TARGET_FLAGS_$(ARCH))
+
+ifeq ($(CROSS_COMPILE),)
+ifeq ($(CLANG_TARGET_FLAGS),)
+$(error Specify CROSS_COMPILE or add '--target=' option to lib.mk
+else
+CLANG_FLAGS     += --target=$(CLANG_TARGET_FLAGS)
+endif # CLANG_TARGET_FLAGS
+else
+CLANG_FLAGS     += --target=$(notdir $(CROSS_COMPILE:%-=%))
+endif # CROSS_COMPILE
+
+CC := $(LLVM_PREFIX)clang$(LLVM_SUFFIX) $(CLANG_FLAGS) -fintegrated-as
 else
 CC := $(CROSS_COMPILE)gcc
-endif
+endif # LLVM
 
 ifeq (0,$(MAKELEVEL))
     ifeq ($(OUTPUT),)
-- 
2.30.2

