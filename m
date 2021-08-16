Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60193EDEFC
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Aug 2021 23:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbhHPVF5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Aug 2021 17:05:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:55966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233299AbhHPVF4 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Aug 2021 17:05:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC7D560F4B;
        Mon, 16 Aug 2021 21:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629147924;
        bh=YECMRvuBjdXXRO58Ismj0qtg5s620EfrgfGRIaZYQzg=;
        h=From:To:Cc:Subject:Date:From;
        b=rloCNbgvPQ69kZoLQcePdQoG3caMoXN0hsOId53e/kvMIHQF8WCIlVCWSMy2YCUKi
         w7EgFfqCjG2wf6EiZmKBMu60nNyfNCSvigQR21vz+werufq3yark81qrJ1bIY0GPEy
         zct1GPAMAAiFvZhyFoFGXWU3dGTfwDMMshOz4iDcOouKnI2MlABkuEkl65CGiEPkBw
         JcqPjrBvVJ5591GBlxSgSfh3joTlBHV32mOJ9yHcb6X3fweXN1s0Sn6lBk79YYmnFg
         Mox+2hjR6DHvhIcNFjOywrVswOc7k+1daB82aJiuCi5dlM9z8pZHkJkElPhi2za955
         Tdp3mtPe+Xy8A==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] selftests: Use -fno-integrated-as instead of -no-integrated-as
Date:   Mon, 16 Aug 2021 14:04:19 -0700
Message-Id: <20210816210418.59294-1-nathan@kernel.org>
X-Mailer: git-send-email 2.33.0.rc2
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

-no-integrated-as is considered the legacy flag since clang 3.5 so move
-fno-integrated-as in case clang ever decides to remove the legacy flag.

Link: https://releases.llvm.org/3.5.0/tools/clang/docs/ReleaseNotes.html#new-compiler-flags
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 tools/testing/selftests/rseq/Makefile  | 2 +-
 tools/testing/selftests/sched/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
index 2af9d39a9716..32f503c13c61 100644
--- a/tools/testing/selftests/rseq/Makefile
+++ b/tools/testing/selftests/rseq/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+ OR MIT
 
 ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
-CLANG_FLAGS += -no-integrated-as
+CLANG_FLAGS += -fno-integrated-as
 endif
 
 CFLAGS += -O2 -Wall -g -I./ -I../../../../usr/include/ -L$(OUTPUT) -Wl,-rpath=./ \
diff --git a/tools/testing/selftests/sched/Makefile b/tools/testing/selftests/sched/Makefile
index 10c72f14fea9..d84a19363a62 100644
--- a/tools/testing/selftests/sched/Makefile
+++ b/tools/testing/selftests/sched/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 
 ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
-CLANG_FLAGS += -no-integrated-as
+CLANG_FLAGS += -fno-integrated-as
 endif
 
 CFLAGS += -O2 -Wall -g -I./ -I../../../../usr/include/  -Wl,-rpath=./ \

base-commit: 7c60610d476766e128cc4284bb6349732cbd6606
-- 
2.33.0.rc2

