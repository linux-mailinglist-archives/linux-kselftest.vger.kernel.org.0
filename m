Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86ACA108C83
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2019 12:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfKYLDs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Nov 2019 06:03:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:35398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727278AbfKYLDs (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Nov 2019 06:03:48 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C79E32064B;
        Mon, 25 Nov 2019 11:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574679827;
        bh=SOT5ZFxPv+2om65CDItvSOpiG90G77QO9zjRpy0Q/Lk=;
        h=From:To:Cc:Subject:Date:From;
        b=nPx47EmPBYy7o82pEWET+QADNGXcDg0mCrAmS9Q31srgCS/uOKYZSruuW5BovnyzG
         aKsQlhSVNxX1gQWuxuYUmJrmPdbfDGs/w06JfYC3xAhgzqWZAj1r/V7lnviyay8DsZ
         mNsIHRNq3sqhSqYp61H7hpDEgr9qn6juXg+1rRP4=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        jaswinder.singh@linaro.org
Subject: [BUGFIX PATCH] selftests/x86: Check the availablity of sys/syscall.h
Date:   Mon, 25 Nov 2019 20:03:44 +0900
Message-Id: <157467982420.24866.4375165389279465782.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Since single_step_syscall.c depends on sys/syscall.h and
its include, asm/unistd.h, we should check the availability
of those headers.
Without this fix, if gcc-multilib is not installed but
libc6-dev-i386 is installed, kselftest tries to build 32bit
binary and failed with following error message.

In file included from single_step_syscall.c:18:
/usr/include/sys/syscall.h:24:10: fatal error: asm/unistd.h: No such file or directory
 #include <asm/unistd.h>
          ^~~~~~~~~~~~~~
compilation terminated.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 .../testing/selftests/x86/trivial_32bit_program.c  |    1 +
 .../testing/selftests/x86/trivial_64bit_program.c  |    1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/testing/selftests/x86/trivial_32bit_program.c b/tools/testing/selftests/x86/trivial_32bit_program.c
index aa1f58c2f71c..6b455eda24f7 100644
--- a/tools/testing/selftests/x86/trivial_32bit_program.c
+++ b/tools/testing/selftests/x86/trivial_32bit_program.c
@@ -8,6 +8,7 @@
 # error wrong architecture
 #endif
 
+#include <sys/syscall.h>
 #include <stdio.h>
 
 int main()
diff --git a/tools/testing/selftests/x86/trivial_64bit_program.c b/tools/testing/selftests/x86/trivial_64bit_program.c
index 39f4b84fbf15..07ae86df18ff 100644
--- a/tools/testing/selftests/x86/trivial_64bit_program.c
+++ b/tools/testing/selftests/x86/trivial_64bit_program.c
@@ -8,6 +8,7 @@
 # error wrong architecture
 #endif
 
+#include <sys/syscall.h>
 #include <stdio.h>
 
 int main()

