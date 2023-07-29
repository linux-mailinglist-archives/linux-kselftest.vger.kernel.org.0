Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817AB76827F
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Jul 2023 00:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjG2WR2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 29 Jul 2023 18:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjG2WR1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 29 Jul 2023 18:17:27 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230292680;
        Sat, 29 Jul 2023 15:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1690669045; bh=5Md0jFhp2sJ0pGrekHfnvbdPswv4yRGYROCpxcISNyw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D+rotqYIOPAJoFdGZggWRqAG9l01ggLPuvwPy11NOFoJk+hXdP+fwCOb0p3cNAxX+
         FA0rexChmizxYdpmH1T2YaehEleUxF/OLU6YOFr8AH9fuYb6UBmdNwa3MZ7oHRLW4o
         kCXkazNJeOFhBYgViHX9ygsRzCq/JdfpCfkyVuk8=
Date:   Sun, 30 Jul 2023 00:17:24 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Yuan Tan <tanyuan@tinylab.org>
Cc:     w@1wt.eu, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests/nolibc: add testcase for pipe.
Message-ID: <27bd9bc1-e7a5-4a81-91c9-2642feabb7ce@t-8ch.de>
References: <cover.1690307717.git.tanyuan@tinylab.org>
 <160ddef0313e11085ee906144d6d9678b8156171.1690307717.git.tanyuan@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160ddef0313e11085ee906144d6d9678b8156171.1690307717.git.tanyuan@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-07-25 14:01:30-0400, Yuan Tan wrote:
> Add a testcase of pipe that child process sends message to parent process.
> 
> Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
> ---
>  tools/testing/selftests/nolibc/nolibc-test.c | 34 ++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> index 03b1d30f5507..43ba2884fd1e 100644
> --- a/tools/testing/selftests/nolibc/nolibc-test.c
> +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> @@ -767,6 +767,39 @@ int test_mmap_munmap(void)
>  	return ret;
>  }
>  
> +int test_pipe(void)
> +{
> +	int pipefd[2];
> +	char buf[32];
> +	pid_t pid;
> +	char *msg = "hello, nolibc";

const char * const

> +
> +	if (pipe(pipefd) == -1)
> +		return 1;
> +
> +	pid = fork();
> +
> +	switch (pid) {
> +	case -1:
> +		return 1;
> +
> +	case 0:
> +		close(pipefd[0]);
> +		write(pipefd[1], msg, strlen(msg));

Isn't this missing to write trailing the 0 byte?
Also check the return value.

> +		close(pipefd[1]);

Do we need to close the pipefds? The process is exiting anyways.

> +		exit(EXIT_SUCCESS);
> +
> +	default:
> +		close(pipefd[1]);
> +		read(pipefd[0], buf, 32);

Use sizeof(buf). Check return value == strlen(msg).

> +		close(pipefd[0]);
> +		wait(NULL);

waitpid(pid, NULL, 0);

> +
> +		if (strcmp(buf, msg))
> +			return 1;
> +		return 0;

return !!strcmp(buf, msg);

> +	}
> +}
>  
>  /* Run syscall tests between IDs <min> and <max>.
>   * Return 0 on success, non-zero on failure.
> @@ -851,6 +884,7 @@ int run_syscall(int min, int max)
>  		CASE_TEST(mmap_munmap_good);  EXPECT_SYSZR(1, test_mmap_munmap()); break;
>  		CASE_TEST(open_tty);          EXPECT_SYSNE(1, tmp = open("/dev/null", 0), -1); if (tmp != -1) close(tmp); break;
>  		CASE_TEST(open_blah);         EXPECT_SYSER(1, tmp = open("/proc/self/blah", 0), -1, ENOENT); if (tmp != -1) close(tmp); break;
> +		CASE_TEST(pipe);              EXPECT_SYSZR(1, test_pipe()); break;
>  		CASE_TEST(poll_null);         EXPECT_SYSZR(1, poll(NULL, 0, 0)); break;
>  		CASE_TEST(poll_stdout);       EXPECT_SYSNE(1, ({ struct pollfd fds = { 1, POLLOUT, 0}; poll(&fds, 1, 0); }), -1); break;
>  		CASE_TEST(poll_fault);        EXPECT_SYSER(1, poll((void *)1, 1, 0), -1, EFAULT); break;
> -- 
> 2.39.2
> 
