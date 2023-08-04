Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9487708F6
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Aug 2023 21:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjHDTXG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Aug 2023 15:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjHDTXE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Aug 2023 15:23:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E861BE;
        Fri,  4 Aug 2023 12:23:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40E086211E;
        Fri,  4 Aug 2023 19:23:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17DE8C433C7;
        Fri,  4 Aug 2023 19:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691176981;
        bh=XOri76sJpkz03uX4PCxdz17la0oq/zwN78Dx+ZuWn6E=;
        h=From:Date:Subject:To:Cc:From;
        b=cknJ4MVW9GsFmnvCz3QefAmehTF3taU0s4Xel4PtbztuLCO5PdCcUmK7JKxJxgsOa
         upoLQVjMQzBMc1rhOK74sD/XW62yXiZ9hmxlTsBwr1byTn1f6S97GTXBLdx71fb+5f
         +21Qi/KS5pjHu/j3hbyuthyGMv2a/OXaCBUMt2cA8uDLZigXY6GZSLAauGA4bYwFts
         VHD1XriK9QT0qZsBV8HUflipU5/Mxymp3wCvWiOZPUitwGlpo8ds5xxATieNfl/Xdj
         BUUGHGmb0AZuiASPLSj/Fia9EpH66s+vgVPtrDLl408o+QlzNOP44zeEaB9hE436cw
         6q0aXxoRJMaKA==
From:   Mark Brown <broonie@kernel.org>
Date:   Fri, 04 Aug 2023 20:22:11 +0100
Subject: [PATCH] selftests/rseq: Fix build with undefined __weak
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230804-kselftest-rseq-build-v1-1-015830b66aa9@kernel.org>
X-B4-Tracking: v=1; b=H4sIAOJPzWQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDCwMT3ezi1Jy0ktTiEt2i4tRC3aTSzJwUXcsUU2NzSxOjJMOUVCWg1oK
 i1LTMCrCx0bG1tQB6lBNIZgAAAA==
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Aaron Lewis <aaronlewis@google.com>, stable@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-034f2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2410; i=broonie@kernel.org;
 h=from:subject:message-id; bh=XOri76sJpkz03uX4PCxdz17la0oq/zwN78Dx+ZuWn6E=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkzVASILAQQzthU6vaozHnSSJrqoeklAkR7/lneg1V
 6U6HkuWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZM1QEgAKCRAk1otyXVSH0K8uB/
 9fP4U1ure2KD6wbesdwvU7rvh7aeJT6lOCKZlUp4ZxY/AkPXdFeUZIpMLptqk7UQn7aFHJT2+flbJ2
 pYnATX/W1banTs6c7waPruBz9cVg5cJJW7nYa3MCY3ErHm4uluhA9il3c/yQ1iZEJrg9twyiYEyoNi
 m1bGgzcNzXrJqgj5hYEwdOMbkCSDDSpw1H+drp6UZtJoS1+3jRbjhIDNdf9hqgKaymqslePKekFqld
 5gnqhQ5dwDx7xE59L3b1BRC8B/L7U8zPPOcPl8D/WjbRQyRsa8QN8pTuuooCjplNsx6AzyEg9PAF6q
 KjqCB5hxFqh8Rf4U05Ioerdz5N1Z7t
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Commit 3bcbc20942db ("selftests/rseq: Play nice with binaries statically
linked against glibc 2.35+") which is now in Linus' tree introduced uses
of __weak but did nothing to ensure that a definition is provided for it
resulting in build failures for the rseq tests:

rseq.c:41:1: error: unknown type name '__weak'
__weak ptrdiff_t __rseq_offset;
^
rseq.c:41:17: error: expected ';' after top level declarator
__weak ptrdiff_t __rseq_offset;
                ^
                ;
rseq.c:42:1: error: unknown type name '__weak'
__weak unsigned int __rseq_size;
^
rseq.c:43:1: error: unknown type name '__weak'
__weak unsigned int __rseq_flags;

Fix this by using the definition from tools/include compiler.h.

Fixes: 3bcbc20942db ("selftests/rseq: Play nice with binaries statically linked against glibc 2.35+")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
It'd be good if the KVM testing could include builds of the rseq
selftests, the KVM tests pull in code from rseq but not the build system
which has resulted in multiple failures like this.
---
 tools/testing/selftests/rseq/Makefile | 4 +++-
 tools/testing/selftests/rseq/rseq.c   | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
index b357ba24af06..7a957c7d459a 100644
--- a/tools/testing/selftests/rseq/Makefile
+++ b/tools/testing/selftests/rseq/Makefile
@@ -4,8 +4,10 @@ ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
 CLANG_FLAGS += -no-integrated-as
 endif
 
+top_srcdir = ../../../..
+
 CFLAGS += -O2 -Wall -g -I./ $(KHDR_INCLUDES) -L$(OUTPUT) -Wl,-rpath=./ \
-	  $(CLANG_FLAGS)
+	  $(CLANG_FLAGS) -I$(top_srcdir)/tools/include
 LDLIBS += -lpthread -ldl
 
 # Own dependencies because we only want to build against 1st prerequisite, but
diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index a723da253244..96e812bdf8a4 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -31,6 +31,8 @@
 #include <sys/auxv.h>
 #include <linux/auxvec.h>
 
+#include <linux/compiler.h>
+
 #include "../kselftest.h"
 #include "rseq.h"
 

---
base-commit: 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4
change-id: 20230804-kselftest-rseq-build-9d537942b1de

Best regards,
-- 
Mark Brown <broonie@kernel.org>

