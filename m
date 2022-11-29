Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87BD63B63C
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Nov 2022 01:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234279AbiK2AEY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Nov 2022 19:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234805AbiK2AEX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Nov 2022 19:04:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8059C1AD92
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Nov 2022 16:04:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28C2961511
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Nov 2022 00:04:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D4DC4347C;
        Tue, 29 Nov 2022 00:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669680261;
        bh=NDM4IpK1Mj0AGBGcu4ocxuGv8IyHd9RxuVw91kBfjLo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R02H6km0mIoxwI3OT9rRXqBt7YZygebWS1uPDvA/Vl4sZ469lqyNpPWBzQ4IVdwr6
         uup7bY4f8q/AYVGlFWd0e3AqzN0D95wCdW4mlbXVWhI79bDgmk9PHQNWs+sZQmrX9B
         Y/2PFGskzzWo1cb2ZxHLeSh4r4WAUKdfd6wGP1XPfRshq9FZMtRHq95NOJR2x+9bWH
         3opLYBZkBL1XKceV8I9EefYD0ENW82LPPVevCjmTYEIcXoOlNO3NkRhbhvoVsbkToU
         c4Afhx7cobUf2lyjOLVGGecAC8l3kq0aT6yTmMsO/m1WBMLh3BPBQUBl+KF6GWPANe
         VYop4bY57tu/Q==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 1/3] kselftest/arm64: Hold fp-stress children until they're all spawned
Date:   Tue, 29 Nov 2022 00:03:53 +0000
Message-Id: <20221129000355.812425-2-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221129000355.812425-1-broonie@kernel.org>
References: <20221129000355.812425-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3511; i=broonie@kernel.org; h=from:subject; bh=NDM4IpK1Mj0AGBGcu4ocxuGv8IyHd9RxuVw91kBfjLo=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjhUxoJLgwylCPMbz6VfJBPb5ktw1QGE8a0BHY8MTS duAFTMqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY4VMaAAKCRAk1otyXVSH0Ie6B/ 90SBqTu2fvepPiFTNRyZ8WWrDfM+sKbHwoKfxCPK0/YklTnACBRzPY5aUoHrPfLKqiPLBShlL1wlyN D/hr32ZBjIPocjNKUVJLm+kqUn0YHp3hxANSJDadS8EVnjqehWnnmq7gvzeVVlsKwmFnwGs50SsBfr 62q2T3FiwfKiQhktVuVpwym5cb8WwmLJiC8ya6+Z8ID1rVZGJPZKQ0HXZ98NKhv/fTYXz0k5UEA8w7 HENfjH1jp2k0rlJxpkd/PSZYg+N6A7rkNDT2WPd8d/cM7MmLYP7nBHxa35NaIp/Mhdocd1s9oWQljN bpLu3qDxHQoFD4GNXEtWup5rt8Groi
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

At present fp-stress has a bit of a thundering herd problem since the
children it spawns start running immediately, meaning that they can start
starving the parent process of CPU before it has even started all the
children. This is much more severe on virtual platforms since they tend to
support far more SVE and SME vector lengths, be slower in general and for
some have issues with performance when simulating multiple CPUs.

We can mitigate this problem by having all the child processes block before
starting the test program, meaning that we at least have all the child
processes started before we start heavily using CPU. We still have the same
load issues while waiting for the actual stress test programs to start up
and produce output but they're at least all ready to go before that kicks
in, resulting in substantial reductions in overall runtime on some of the
severely affected systems. One test was showing about 20% improvement.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/fp-stress.c | 41 +++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/fp/fp-stress.c b/tools/testing/selftests/arm64/fp/fp-stress.c
index 4e62a9199f97..9a3a621cc958 100644
--- a/tools/testing/selftests/arm64/fp/fp-stress.c
+++ b/tools/testing/selftests/arm64/fp/fp-stress.c
@@ -44,6 +44,8 @@ static bool terminate;
 
 static void drain_output(bool flush);
 
+static int startup_pipe[2];
+
 static int num_processors(void)
 {
 	long nproc = sysconf(_SC_NPROCESSORS_CONF);
@@ -81,13 +83,37 @@ static void child_start(struct child_data *child, const char *program)
 			exit(EXIT_FAILURE);
 		}
 
+		/*
+		 * Duplicate the read side of the startup pipe to
+		 * FD 3 so we can close everything else.
+		 */
+		ret = dup2(startup_pipe[0], 3);
+		if (ret == -1) {
+			fprintf(stderr, "dup2() %d\n", errno);
+			exit(EXIT_FAILURE);
+		}
+
 		/*
 		 * Very dumb mechanism to clean open FDs other than
 		 * stdio. We don't want O_CLOEXEC for the pipes...
 		 */
-		for (i = 3; i < 8192; i++)
+		for (i = 4; i < 8192; i++)
 			close(i);
 
+		/*
+		 * Read from the startup pipe, there should be no data
+		 * and we should block until it is closed.  We just
+		 * carry on on error since this isn't super critical.
+		 */
+		ret = read(3, &i, sizeof(i));
+		if (ret < 0)
+			fprintf(stderr, "read(startp pipe) failed: %s (%d)\n",
+				strerror(errno), errno);
+		if (ret > 0)
+			fprintf(stderr, "%d bytes of data on startup pipe\n",
+				ret);
+		close(3);
+
 		ret = execl(program, program, NULL);
 		fprintf(stderr, "execl(%s) failed: %d (%s)\n",
 			program, errno, strerror(errno));
@@ -465,6 +491,12 @@ int main(int argc, char **argv)
 				   strerror(errno), ret);
 	epoll_fd = ret;
 
+	/* Create a pipe which children will block on before execing */
+	ret = pipe(startup_pipe);
+	if (ret != 0)
+		ksft_exit_fail_msg("Failed to create startup pipe: %s (%d)\n",
+				   strerror(errno), errno);
+
 	/* Get signal handers ready before we start any children */
 	memset(&sa, 0, sizeof(sa));
 	sa.sa_sigaction = handle_exit_signal;
@@ -497,6 +529,13 @@ int main(int argc, char **argv)
 		}
 	}
 
+	/*
+	 * All children started, close the startup pipe and let them
+	 * run.
+	 */
+	close(startup_pipe[0]);
+	close(startup_pipe[1]);
+
 	for (;;) {
 		/* Did we get a signal asking us to exit? */
 		if (terminate)
-- 
2.30.2

