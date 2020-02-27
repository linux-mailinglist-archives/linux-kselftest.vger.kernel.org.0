Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA43F171E8E
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2020 15:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388046AbgB0OHO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Feb 2020 09:07:14 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:8241 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388040AbgB0OHN (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Feb 2020 09:07:13 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48SvcZ3tKZz9txk3;
        Thu, 27 Feb 2020 15:07:10 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=PTRZzFHd; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id JGy_piGfSqVj; Thu, 27 Feb 2020 15:07:10 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48SvcZ2KVgz9txjq;
        Thu, 27 Feb 2020 15:07:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1582812430; bh=pMdxfkWt8aeiCYoGO1Ki4yn2nRsWDCLP+OmE1BowToE=;
        h=From:Subject:To:Cc:Date:From;
        b=PTRZzFHdhDZWMdiWgTpcj8Qnhkf2sblpBy9Y5aCk/LF4KJid8g5BjCA4AHnG7Pagc
         UkhApWrXZS0x9dxmlyG84glSG1R3Tj6tFUAXdDYiSbGH2wjYvc2Gd85T331OQiyBid
         uIkrQlDgQpcOlJamJBZFVv0yiZ+rWyinEmeUpc94=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 22B5B8B799;
        Thu, 27 Feb 2020 15:07:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id bau3KNBNhPle; Thu, 27 Feb 2020 15:07:11 +0100 (CET)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A06BF8B877;
        Thu, 27 Feb 2020 15:07:10 +0100 (CET)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 6AEB865403; Thu, 27 Feb 2020 14:07:10 +0000 (UTC)
Message-Id: <e4ba4f716599d1d66c8bc60489f4b05764ea8470.1582812034.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] selftest/lkdtm: Use local .gitignore
To:     Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Date:   Thu, 27 Feb 2020 14:07:10 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Commit 68ca0fd272da ("selftest/lkdtm: Don't pollute 'git status'")
introduced patterns for git to ignore files generated in
tools/testing/selftests/lkdtm/

Use local .gitignore file instead of using the root one.

Fixes: 68ca0fd272da ("selftest/lkdtm: Don't pollute 'git status'")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 .gitignore                               | 4 ----
 tools/testing/selftests/lkdtm/.gitignore | 2 ++
 2 files changed, 2 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/lkdtm/.gitignore

diff --git a/.gitignore b/.gitignore
index bb05dce58f8e..b849a72d69d5 100644
--- a/.gitignore
+++ b/.gitignore
@@ -100,10 +100,6 @@ modules.order
 /include/ksym/
 /arch/*/include/generated/
 
-# Generated lkdtm tests
-/tools/testing/selftests/lkdtm/*.sh
-!/tools/testing/selftests/lkdtm/run.sh
-
 # stgit generated dirs
 patches-*
 
diff --git a/tools/testing/selftests/lkdtm/.gitignore b/tools/testing/selftests/lkdtm/.gitignore
new file mode 100644
index 000000000000..f26212605b6b
--- /dev/null
+++ b/tools/testing/selftests/lkdtm/.gitignore
@@ -0,0 +1,2 @@
+*.sh
+!run.sh
-- 
2.25.0

