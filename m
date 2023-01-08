Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0221566159C
	for <lists+linux-kselftest@lfdr.de>; Sun,  8 Jan 2023 14:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjAHN7T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 8 Jan 2023 08:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbjAHN7P (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 8 Jan 2023 08:59:15 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D04DEAE;
        Sun,  8 Jan 2023 05:59:14 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.183.184])
        by gnuweeb.org (Postfix) with ESMTPSA id 891B67E61F;
        Sun,  8 Jan 2023 13:59:11 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1673186354;
        bh=XNGtWJcW+7/4kkcyC8FDH4yTsKXskMlGZGvdbnPIy3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oxNAKQVNygzLoyt7Hcj0jN9JFo/3A9AsqC53rbU8qAK9HqQF65sZLh6GJEEjvE9hT
         cf/wYaORP2wt6YDwdhBdpz2fqz+ooC3VKyhDqhum4YWNCS0S8PKb5mv9zrV6qqlxKv
         6lbHY6H8Z80loPHFK2TwgTTuzoZW6aIGbzZQQ98RkkPn/fY7S3NR/G731de9zelVP9
         qTCUTwGKEYKvHtyj+JjaH7vIGIGQ5pALtYjDoDLNA22qoAq5mmej4Gafj4WRlI1hRN
         R1HFWSqbXKDDE2ct+B3DMaeRi+aGHA3oBKsuymPDsYv4szUFG6mC+E/n8k2xWEwck1
         aahwjC5xSm/jg==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Shuah Khan <shuah@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Gilang Fachrezy <gilang4321@gmail.com>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>
Subject: [PATCH v3 1/5] nolibc/sys: Implement `sigaction(2)` function
Date:   Sun,  8 Jan 2023 20:59:00 +0700
Message-Id: <20230108135904.851762-2-ammar.faizi@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230108135904.851762-1-ammar.faizi@intel.com>
References: <20230108135904.851762-1-ammar.faizi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Ammar Faizi <ammarfaizi2@gnuweeb.org>

This commit adds the initial implementation of nolibc `sigaction()`
function. Currently, this implementation is only available on the
x86-64 arch.

`sigaction()` needs an architecture-dependent "signal trampoline"
function that invokes __rt_sigreturn syscall to resume the process
after a signal gets handled.

The "signal trampoline" function is called `__restore_rt` in this
implementation. The naming `__restore_rt` is important for GDB. It also
has to be given a special optimization attribute "omit-frame-pointer"
to prevent the compiler from creating a stack frame that makes the
`%rsp` value no longer points to the `struct rt_sigframe` that the
kernel constructed.

Link: https://lore.kernel.org/lkml/20221228133513.GA7457@1wt.eu
Suggested-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---

Side note:
This has been tested on x86-64 arch and `__restore_rt` generates the
correct code. The `__restore_rt` codegen correctness on other
architectures need to be evaluated as well. If it can't generate the
correct code, it has to be written in inline Assembly.

 tools/include/nolibc/sys.h | 72 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index acf7cf438010..7d594155e77f 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -1047,6 +1047,78 @@ pid_t setsid(void)
 	return ret;
 }
 
+typedef void (*sighandler_t)(int sig);
+
+/*
+ * int sigaction(int signum, const struct sigaction *act, struct sigaction *oldact);
+ */
+
+static __attribute__((unused))
+int sys_sigaction(int signum, const struct sigaction *act,
+		  struct sigaction *oldact)
+{
+	return my_syscall4(__NR_rt_sigaction, signum, act, oldact,
+			   sizeof(sigset_t));
+}
+
+__attribute__((weak,unused,noreturn,optimize("omit-frame-pointer"),section(".text.__restore_rt")))
+void __restore_rt(void)
+{
+	my_syscall0(__NR_rt_sigreturn);
+	__builtin_unreachable();
+}
+
+static __attribute__((unused))
+int sigaction(int signum, const struct sigaction *act, struct sigaction *oldact)
+{
+	struct sigaction act2 = *act;
+	int ret;
+
+	/*
+	 * On Linux x86-64, libc's sigaction() always sets the
+	 * @act->sa_restorer when the caller passes a NULL.
+	 *
+	 * @act->sa_restorer is an arch-specific function used
+	 * as a "signal trampoline".
+	 *
+	 * @act->sa_handler is a signal handler provided by the
+	 * user.
+	 *
+	 * When the handled signal is caught, the %rip jumps to
+	 * @act->sa_handler with user stack already set by the
+	 * kernel as below:
+	 *
+	 *         |--------------------|
+	 * %rsp -> |  act->sa_restorer  | (return address)
+	 *         |--------------------|
+	 *         | struct rt_sigframe | (process context info)
+	 *         |                    |
+	 *         |                    |
+	 *          ....................
+	 *
+	 * Once this signal handler executes the "ret" instruction,
+	 * the %rip jumps to @act->sa_restorer. The sa_restorer
+	 * function has to invoke the __rt_sigreturn syscall with
+	 * %rsp pointing to the `struct rt_sigframe` that the kernel
+	 * constructed previously to resume the process.
+	 *
+	 * `struct rt_sigframe` contains the registers' value before
+	 * the signal is caught.
+	 *
+	 */
+	if (!act2.sa_restorer) {
+		act2.sa_flags |= SA_RESTORER;
+		act2.sa_restorer = __restore_rt;
+	}
+
+	ret = sys_sigaction(signum, &act2, oldact);
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
+
 
 /*
  * int stat(const char *path, struct stat *buf);
-- 
Ammar Faizi

