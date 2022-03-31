Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB17C4EE395
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Mar 2022 23:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242133AbiCaV6w (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Mar 2022 17:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242162AbiCaV6t (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Mar 2022 17:58:49 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04542467D6;
        Thu, 31 Mar 2022 14:56:56 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id d5so1518695lfj.9;
        Thu, 31 Mar 2022 14:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C5/V3Ppw/qitPursR+7CAkeFCCgQmdXdvGMRe0ZnPWU=;
        b=e1FFrPkG1ZIU2AnelJMZJj26kfEzrzR5n811c5f5YJue2DqnotZS7FtJ4wIuEDJj48
         nX9VHMGo+Nb9F5OzpYx2GZ5mmUmz6YOCPx6ms//qFi3D5PLCAGdSry589Q1lr1wtc5Xr
         A1vLmhtsrSYo0k0QTOShbXCE0PqeKdtJKEAE7nmhdbeBOy60FjRMOAvMTs81PvFMT4dX
         cobkI6Al2+i6DkCHhSDYA5Ec884E+ld7PvoMIXWdDyFrYI0xCZRU2y6ATzWjeEXvEaDx
         YJOa35UeitLPhclE2stlTQHTZl5lLtWQcgl4BiTRl0S+V+OoWVsS8yigFCfr+ecg0TYX
         I7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C5/V3Ppw/qitPursR+7CAkeFCCgQmdXdvGMRe0ZnPWU=;
        b=56ApMGmOxTEJEI88u0g1dCNXjkItFGXwq+uD7+XWpohQndgZJaIiwq3N2xWUCAZaB1
         wGuvs8dT4mUYwzwA7aDM/5dP5n8lZdW9X48pPRD8tpHtCGf3kdZUcn53fTl1vhVtIrLI
         IX+QuwpDqc/RHG1NmDtkFTXKmv6/MuQMM86Gu0M5LWU8BA6Km1HFbAk3VMVf/37mSUZ5
         vT63noQAqMdA8gGLKQAvi5pTUEDDhlEg60zpRwX7D91DMI9mTUSEby/RMDfT5At9gcSQ
         SgpGREJHc8k+IR140sUcQILXUOI/UGN5EQx0c5B9b8KZzXfD82ou6p74pMOoAJNXZJeG
         Zp6g==
X-Gm-Message-State: AOAM530br40S7x5QnZF0PptPonumCbH0zsKPQJInPkmIejvr/r2AMVez
        902pbTtGJG2epO0QWF4Jw5k=
X-Google-Smtp-Source: ABdhPJzy4Bqt3mhcetavw7lWOhsd6LFjmLJaxselo/aO+36hXhoXXJBjdmcJCVeE8bZDC8IkH3JXTQ==
X-Received: by 2002:a05:6512:2214:b0:44a:348a:d72 with SMTP id h20-20020a056512221400b0044a348a0d72mr12190683lfu.416.1648763815000;
        Thu, 31 Mar 2022 14:56:55 -0700 (PDT)
Received: from noname.. ([2a02:2698:8c2a:31b:6d9:f5ff:fecb:a8ab])
        by smtp.googlemail.com with ESMTPSA id u2-20020a2e9f02000000b0024af5f27771sm38800ljk.32.2022.03.31.14.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 14:56:54 -0700 (PDT)
From:   Grigory Vasilyev <h0tc0d3@gmail.com>
Cc:     Grigory Vasilyev <h0tc0d3@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yury Norov <yury.norov@gmail.com>, Yonghong Song <yhs@fb.com>,
        Adrian Ratiu <adrian.ratiu@collabora.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] Fix kernel build with LLVM=1
Date:   Fri,  1 Apr 2022 00:56:58 +0300
Message-Id: <20220331215659.3800-1-h0tc0d3@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The wrong logic is using 1 as a suffix instead of -1.
So the build script tries to find clang1 file instead of clang.

GEN     Makefile
HOSTCC  scripts/basic/fixdep
/bin/sh: line 1: clang1: command not found
make[2]: *** [/build/linux/scripts/Makefile.host:95: scripts/basic/fixdep] Error 127
make[1]: *** [/build/linux/Makefile:564: scripts_basic] Error 2
make: *** [Makefile:219: __sub-make] Error 2

Fixes: b8321ed4a40c("Merge tag 'kbuild-v5.18-v2'")

Signed-off-by: Grigory Vasilyev <h0tc0d3@gmail.com>
Reported-by: Grigory Vasilyev <h0tc0d3@gmail.com>
---
 Makefile                       | 4 ++--
 tools/scripts/Makefile.include | 4 ++--
 tools/testing/selftests/lib.mk | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 18ecb49f1af6..efca890d4ea3 100644
--- a/Makefile
+++ b/Makefile
@@ -426,8 +426,8 @@ HOST_LFS_LIBS := $(shell getconf LFS_LIBS 2>/dev/null)
 ifneq ($(LLVM),)
 ifneq ($(filter %/,$(LLVM)),)
 LLVM_PREFIX := $(LLVM)
-else ifneq ($(filter -%,$(LLVM)),)
-LLVM_SUFFIX := $(LLVM)
+else ifneq (,$(findstring -, $(LLVM)))
+LLVM_SUFFIX := $(filter -%, $(LLVM))
 endif
 
 HOSTCC	= $(LLVM_PREFIX)clang$(LLVM_SUFFIX)
diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
index 0efb8f2b33ce..c7a56d7f0bad 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -54,8 +54,8 @@ endef
 ifneq ($(LLVM),)
 ifneq ($(filter %/,$(LLVM)),)
 LLVM_PREFIX := $(LLVM)
-else ifneq ($(filter -%,$(LLVM)),)
-LLVM_SUFFIX := $(LLVM)
+else ifneq (,$(findstring -, $(LLVM)))
+LLVM_SUFFIX := $(filter -%, $(LLVM))
 endif
 
 $(call allow-override,CC,$(LLVM_PREFIX)clang$(LLVM_SUFFIX))
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 2a2d240cdc1b..42af066cf39e 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -3,8 +3,8 @@
 ifneq ($(LLVM),)
 ifneq ($(filter %/,$(LLVM)),)
 LLVM_PREFIX := $(LLVM)
-else ifneq ($(filter -%,$(LLVM)),)
-LLVM_SUFFIX := $(LLVM)
+else ifneq (,$(findstring -, $(LLVM)))
+LLVM_SUFFIX := $(filter -%, $(LLVM))
 endif
 
 CC := $(LLVM_PREFIX)clang$(LLVM_SUFFIX)
-- 
2.35.1

