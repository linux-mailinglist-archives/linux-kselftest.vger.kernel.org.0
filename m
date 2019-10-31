Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC6AEB01E
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2019 13:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfJaMXE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Oct 2019 08:23:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:48312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbfJaMXE (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Oct 2019 08:23:04 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E9A72080F;
        Thu, 31 Oct 2019 12:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572524583;
        bh=JURjpmxetvsFOsFwN5zPI4BUWALVpxZ2zOeUZ4BCQI8=;
        h=From:To:Cc:Subject:Date:From;
        b=sWBESPhcw98jOKhToxqz930+eCYlziKf1oSXeJrbu+PpuLVCBUsiSMrEpcoX+iyGl
         qCdYH4uGF+p1FzOaeLfv1owqH9Om7DT06N8p+UW1v/vzTgMiypTmYO2f4DKudOoxkK
         C9s9eidjmiegerczuMZGfUGRgNQnVq1TySmSlPzg=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        jaswinder.singh@linaro.org, mhiramat@kernel.org,
        Jun Takahashi <takahashi.jun_s@aa.socionext.com>,
        Kees Cook <keescook@chromium.org>
Subject: [BUGFIX PATCH] selftests: breakpoints: Fix a typo of function name
Date:   Thu, 31 Oct 2019 21:23:00 +0900
Message-Id: <157252457993.20908.6741530756091861014.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Since commit 5821ba969511 ("selftests: Add test plan API to kselftest.h
and adjust callers") accidentally introduced 'a' typo in the front of
run_test() function, breakpoint_test_arm64.c became not able to be
compiled.

Remove the 'a' from arun_test().

Fixes: 5821ba969511 ("selftests: Add test plan API to kselftest.h and adjust callers")
Reported-by: Jun Takahashi <takahashi.jun_s@aa.socionext.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
---
 .../selftests/breakpoints/breakpoint_test_arm64.c  |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c b/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
index 58ed5eeab709..ad41ea69001b 100644
--- a/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
+++ b/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
@@ -109,7 +109,7 @@ static bool set_watchpoint(pid_t pid, int size, int wp)
 	return false;
 }
 
-static bool arun_test(int wr_size, int wp_size, int wr, int wp)
+static bool run_test(int wr_size, int wp_size, int wr, int wp)
 {
 	int status;
 	siginfo_t siginfo;

