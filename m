Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E523B63CADD
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Nov 2022 23:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbiK2V7h (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Nov 2022 16:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237115AbiK2V7f (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Nov 2022 16:59:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50236F377
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Nov 2022 13:59:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81AB061958
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Nov 2022 21:59:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FDF6C433B5;
        Tue, 29 Nov 2022 21:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669759173;
        bh=R3+mZLjzV/gcr5knY0VrHVoRWwAETPfnU+ZHglXcR8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rsFEnqzsZf7ADxCr27zUv8YXqBWKKo9hbsV1qqzkTtaZgvrLJyQqtRcs6Z74njr5v
         v/E2gvfA0GcYpintGiR1W3ftzKxrZcEWlVDq4RnjsBQ802QWySEc7PfwdL8vUYnDXw
         J9go+4PjqTezo7ZByRenSPHRvJf9OfOd7dytLZYnH3QV8yN7FRFmBq6A6U2ftci76e
         yA0dt2PfP0rqakOAAwTAxtTO50jRx3kgtwahQu7yFMGcT5cEKCVj18Aq+Oi4OGTSvw
         FRVaavrKcttiMk/Pv3yV53tLzoFIn2f5CJMB224A1zGf9mSqr5nyjEp39NVPOdPQra
         bltzRwGGRGtCA==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 1/3] kselftest/arm64: Hold fp-stress children until they're all spawned
Date:   Tue, 29 Nov 2022 21:59:23 +0000
Message-Id: <20221129215926.442895-2-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221129215926.442895-1-broonie@kernel.org>
References: <20221129215926.442895-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3511; i=broonie@kernel.org; h=from:subject; bh=R3+mZLjzV/gcr5knY0VrHVoRWwAETPfnU+ZHglXcR8Q=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjhoC7GO8Mr1R0x1UQagteYI0RHQ2q1qlM8tari4MH UrIcutGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY4aAuwAKCRAk1otyXVSH0HDVB/ 4v4wEC8zW6w45wRu1bJWOKqLbOYWUhqVlia8PI7FvzUnGhePb5qrm7nYfVWGQ/pFIEHa/GMUAumr1i c7rGg0fp6fGmTSneIrGKxOdJufZNbdV5BeoiNKp6MGsAvibaOICtPJYmLsMofsdcZAdh2FKkEUMd2Z Y4bWBAZEG8kUWiig7gizDTUmvGglaXt75MkEqG1a6r6p0jW5MooTHfoaYRNpj1JkTfTGpXwTyJvcc8 Sk8NAJSSN9LVfDr+5rWfyeZXxEBCeeSH1d6doYcIs5oFZkU22SzWAMcsIi8Du3lD1zVvnwmwB9zoUL jm+vkTvX+BN+pc+WpUzdUK/XC7hL6m
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
index 69ca4a5f7e6e..7c04f5001648 100644
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
@@ -467,6 +493,12 @@ int main(int argc, char **argv)
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
@@ -499,6 +531,13 @@ int main(int argc, char **argv)
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

