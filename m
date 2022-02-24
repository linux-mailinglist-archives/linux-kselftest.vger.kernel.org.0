Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13EB94C23C9
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Feb 2022 06:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbiBXF7F (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Feb 2022 00:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiBXF7E (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Feb 2022 00:59:04 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D06B265BC5
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Feb 2022 21:58:34 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id l9so373772pls.6
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Feb 2022 21:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zAnejYzjMLOw9nDkVzejCfKZ6oBBZ5wn5KiXGCpLjMA=;
        b=ngRxHm3L+/PjW4guu4lIB7R2vAimLs2Yef4Disoe//YgHKnOK/FKD3M2CdZYJjFwjP
         NPHCFYPZT/Le825KrJuJWI1EwYb4+M1mQ+NIf96KxpVqDlL8bEZx6LB+mKGvJwFkFKVF
         RqzsPe4Myj0OCUQeY0I7JxpBX8A3GUqjWv/yQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zAnejYzjMLOw9nDkVzejCfKZ6oBBZ5wn5KiXGCpLjMA=;
        b=p8hyM4DLdLl/CArwuOoCrAqVvnTPU4O4xcPVoMrxGqnf9MyEXk6wpJH1N33JVI1Bnt
         exaCPkwvZ2WHsxQWrQhK0KBgpBUlB2XiJmVlxgPPsYs8bZNd9fWXBIBBp/rIb+qWNs7Y
         PemMO8V2W98MMs/eWBUQhrcqbx21PSjUOBWETipZABFN1lM8Z0RKH5fU4enMN7PI5Azd
         HgMKu9CjC9vZ7EGNvkaGVrVq+9CfW1BL33zlITp33nD/q4tGDrggludOC5Kt5inkmjQD
         q+zLiXzzv8D1LgYHLZ0nLFwXrA5o91GVWnH8Fr1vJFNTNSVF9uVNL4eab1L60nDBfvyP
         +uOQ==
X-Gm-Message-State: AOAM530ixgtTNchDpa+3dRaIC5b47kKdyRXLJoMWAGU4oLGN2BNt7qYE
        wlgEzKiotdsiF3NEEiv7MxySJEmJrwmf+g==
X-Google-Smtp-Source: ABdhPJyJ9xUurNYX2PkzlWyR0k1G5n6hF4pFLyT3YuG8dMdiPW/0Tc4RSx6Lns8rrrPi2W3XrglbrQ==
X-Received: by 2002:a17:90b:17c3:b0:1b8:cda0:bc08 with SMTP id me3-20020a17090b17c300b001b8cda0bc08mr12981731pjb.72.1645682313918;
        Wed, 23 Feb 2022 21:58:33 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d5-20020a17090acd0500b001b9c05b075dsm4840603pju.44.2022.02.23.21.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 21:58:33 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jeff Dike <jdike@addtoit.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        David Gow <davidgow@google.com>, linux-um@lists.infradead.org,
        linux-kbuild@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2] um: Allow builds with Clang
Date:   Wed, 23 Feb 2022 21:58:31 -0800
Message-Id: <20220224055831.1854786-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3199; h=from:subject; bh=ORjKUvuElRuveNhaPtG55IXvBNRDQtztW8DXNHkaB6o=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiFx6H2Rp6e7Ak5NdBJtPWHhMi31ltuCxXU+/l480f UATwZt2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYhcehwAKCRCJcvTf3G3AJkQlD/ 4pCZ2mWoBuXFc2QpaBO0O3ONucPC8rUors6QDfZuMU1xAyl8Spj1bUbGEnl1BMT5VYBXBygi5tQqJK DtecMG/4Sy9fGup2xayFUu2DX8O9RHBeV71eroXdeYg2dh0+O1sb5iwXZVbLj3OV6HOGoUkiWDpms3 U6ogMwfe5Mb9GXwSncSK76Cbp9bXnSvRMJTzmxfGJlZ4dGpkRY8a6kMKlxwog8W7wzlM2+BK4MG+D9 s/waoLXueOywfOD63bJDfqHimMj18NbCinyQiTwiqjTFEEEXwjzZ8jlC9jBhfXHbje6Uyn7DNGEiBi 2TmbgbA1Mq09IHEtbQ33ExSsNJl/mcONkTiYEsofTtkCA7KwkLz0yu1RW0SMwanMSq5tL3pzMRmR4c uPEB1vUFm3b6VqDmrsFIEfRmBE8WDEYmaklgv8vxRBlXeu/BPeb4HJAO0Hmuy/jTPwoSr4B7vTlNKD Mux7qGTGcGgOwnFxQ3diqxvi4PnN/UW+6atTfzH2wTVYhNFxQNez0tiMEmAwGP2tJ+2J76UstlpRXY r8V1oopSzb18Qq11SBU53h3tIDPq2gNIvfPmmPOh6MtOjsp7EMCJ9Wk3vcfkHZusGFcxjRJPgJnbBx sC5IKds+n1EERQpguuWcbRt3p5W3K1zvBvcpJQ0aHrutERV3LkYlfSmzO1TA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add x86-64 target for Clang+um and update user-offsets.c to use
Clang-friendly assembly, similar to the fix from commit cf0c3e68aa81
("kbuild: fix asm-offset generation to work with clang").

This lets me run KUnit tests with Clang:

$ ./tools/testing/kunit/kunit.py config --make_options LLVM=1
...
$ ./tools/testing/kunit/kunit.py run --make_options LLVM=1
...

Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: David Gow <davidgow@google.com>
Cc: linux-um@lists.infradead.org
Cc: linux-kbuild@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: kunit-dev@googlegroups.com
Cc: llvm@lists.linux.dev
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/lkml/Yg2YubZxvYvx7%2Fnm@dev-arch.archlinux-ax161/
Tested-by: David Gow <davidgow@google.com>
Link: https://lore.kernel.org/lkml/CABVgOSk=oFxsbSbQE-v65VwR2+mXeGXDDjzq8t7FShwjJ3+kUg@mail.gmail.com/
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v1: https://lore.kernel.org/lkml/20220217002843.2312603-1-keescook@chromium.org/
v2:
 - tweak commit log phrasing and alphabetize targets (nathan)
 - fix a missing implicit fallthrough under 32-bit builds
 - add review tags
---
 arch/um/os-Linux/execvp.c  | 1 +
 arch/x86/um/user-offsets.c | 4 ++--
 scripts/Makefile.clang     | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/um/os-Linux/execvp.c b/arch/um/os-Linux/execvp.c
index 84a0777c2a45..c09a5fd5e225 100644
--- a/arch/um/os-Linux/execvp.c
+++ b/arch/um/os-Linux/execvp.c
@@ -93,6 +93,7 @@ int execvp_noalloc(char *buf, const char *file, char *const argv[])
 					   up finding no executable we can use, we want to diagnose
 					   that we did find one but were denied access.  */
 					got_eacces = 1;
+					break;
 				case ENOENT:
 				case ESTALE:
 				case ENOTDIR:
diff --git a/arch/x86/um/user-offsets.c b/arch/x86/um/user-offsets.c
index bae61554abcc..d9071827b515 100644
--- a/arch/x86/um/user-offsets.c
+++ b/arch/x86/um/user-offsets.c
@@ -10,10 +10,10 @@
 #include <asm/types.h>
 
 #define DEFINE(sym, val) \
-	asm volatile("\n->" #sym " %0 " #val : : "i" (val))
+	asm volatile("\n.ascii \"->" #sym " %0 " #val "\"": : "i" (val))
 
 #define DEFINE_LONGS(sym, val) \
-	asm volatile("\n->" #sym " %0 " #val : : "i" (val/sizeof(unsigned long)))
+	asm volatile("\n.ascii \"->" #sym " %0 " #val "\"": : "i" (val/sizeof(unsigned long)))
 
 void foo(void)
 {
diff --git a/scripts/Makefile.clang b/scripts/Makefile.clang
index 51fc23e2e9e5..6e49344c6db2 100644
--- a/scripts/Makefile.clang
+++ b/scripts/Makefile.clang
@@ -9,6 +9,7 @@ CLANG_TARGET_FLAGS_mips		:= mipsel-linux-gnu
 CLANG_TARGET_FLAGS_powerpc	:= powerpc64le-linux-gnu
 CLANG_TARGET_FLAGS_riscv	:= riscv64-linux-gnu
 CLANG_TARGET_FLAGS_s390		:= s390x-linux-gnu
+CLANG_TARGET_FLAGS_um		:= x86_64-linux-gnu
 CLANG_TARGET_FLAGS_x86		:= x86_64-linux-gnu
 CLANG_TARGET_FLAGS		:= $(CLANG_TARGET_FLAGS_$(SRCARCH))
 
-- 
2.30.2

