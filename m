Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B626B6618
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 Mar 2023 14:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjCLNHZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 12 Mar 2023 09:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjCLNHX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 12 Mar 2023 09:07:23 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 946AC28840;
        Sun, 12 Mar 2023 06:07:22 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 32CD7G9i002236;
        Sun, 12 Mar 2023 14:07:16 +0100
Date:   Sun, 12 Mar 2023 14:07:16 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC 5/5] tools/nolibc: tests: add test for
 -fstack-protector
Message-ID: <ZA3OhLBmUz3fui+f@1wt.eu>
References: <20230223-nolibc-stackprotector-v1-0-3e74d81b3f21@weissschuh.net>
 <20230223-nolibc-stackprotector-v1-5-3e74d81b3f21@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230223-nolibc-stackprotector-v1-5-3e74d81b3f21@weissschuh.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Mar 07, 2023 at 10:22:34PM +0000, Thomas Weiﬂschuh wrote:
> Test the previously introduce stack protector functionality in nolibc.

s/introduce/introduced/

(I can adjust it myself when merging to avoid a respin if you want).

> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  tools/testing/selftests/nolibc/nolibc-test.c | 74 +++++++++++++++++++++++++++-
>  1 file changed, 72 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> index fb2d4872fac9..4990b2750279 100644
> --- a/tools/testing/selftests/nolibc/nolibc-test.c
> +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> @@ -45,6 +45,7 @@ char **environ;
>  struct test {
>  	const char *name;              // test name
>  	int (*func)(int min, int max); // handler
> +	char skip_by_default;         // don't run by default

Just a tiny detail but that comment is misaligned by one char on the left.

>  };
>  
>  #ifndef _NOLIBC_STDLIB_H
> @@ -667,6 +668,70 @@ int run_stdlib(int min, int max)
>  	return ret;
>  }
>  
> +#if defined(__clang__)
> +__attribute__((optnone))
> +#elif defined(__GNUC__)
> +__attribute__((optimize("O0")))
> +#endif
> +static int run_smash_stack(int min, int max)
> +{
> +	char buf[100];
> +
> +	for (size_t i = 0; i < 200; i++)
> +		buf[i] = 15;

If the goal is to make it easy to spot in a crash dump, I suggest
that you use a readable ASCII letter that's easy to recognize. 0xF
will usually not be printed in hex dumps, making it less evident
when scrolling quickly. For example I often use 'P' when poisoning
memory but you get the idea.

> +int run_stackprotector(int min, int max)
> +{
> +	int llen = 0;
> +
> +	llen += printf("0 ");
> +
> +#if !defined(NOLIBC_STACKPROTECTOR)
> +	llen += printf("stack smashing detection not supported");
> +	pad_spc(llen, 64, "[SKIPPED]\n");
> +	return 0;
> +#endif

Shouldn't the whole function be enclosed instead ? I know it's more of
a matter of taste, but avoiding to build and link it for archs that
will not use it may be better.

> +
> +	pid_t pid = fork();

Please avoid variable declarations after statements, for me these
are really horrible to deal with when editing the code later, because
instead of having to look up only the beginning of each containing
block (i.e. in O(log(N))) you have to visually parse every single line
(i.e. O(N)).

> +	switch (pid) {
> +	case -1:
> +		llen += printf("fork()");
> +		pad_spc(llen, 64, "[FAIL]\n");
> +		return 1;
> +
> +	case 0:
> +		close(STDOUT_FILENO);
> +		close(STDERR_FILENO);
> +
> +		char *const argv[] = {
> +			"/proc/self/exe",
> +			"_smash_stack",
> +			NULL,
> +		};

Same here.

> +		execve("/proc/self/exe", argv, NULL);
> +		return 1;
> +
> +	default: {
> +		int status;

And here by moving "status" upper in the function you can even
get rid of the braces.

> +		pid = waitpid(pid, &status, 0);
> +
> +		if (pid == -1 || !WIFSIGNALED(status) || WTERMSIG(status) != SIGABRT) {
> +			llen += printf("waitpid()");
> +			pad_spc(llen, 64, "[FAIL]\n");
> +			return 1;
> +		}
> +		llen += printf("stack smashing detected");
> +		pad_spc(llen, 64, " [OK]\n");
> +		return 0;
> +	}
> +	}
> +}
> +
>  /* prepare what needs to be prepared for pid 1 (stdio, /dev, /proc, etc) */
>  int prepare(void)
>  {
> @@ -719,8 +784,11 @@ int prepare(void)
>  /* This is the definition of known test names, with their functions */
>  static const struct test test_names[] = {
>  	/* add new tests here */
> -	{ .name = "syscall",   .func = run_syscall  },
> -	{ .name = "stdlib",    .func = run_stdlib   },
> +	{ .name = "syscall",        .func = run_syscall         },
> +	{ .name = "stdlib",         .func = run_stdlib          },
> +	{ .name = "stackprotector", .func = run_stackprotector, },
> +	{ .name = "_smash_stack",   .func = run_smash_stack,

I think it would be better to keep the number of categories low
and probably you should add just one called "protection" or so,
and implement your various tests in it as is done for other
categories. The goal is to help developers quickly spot and select
the few activities they're interested in at a given moment. 

Thanks,
Willy
