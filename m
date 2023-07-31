Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF563768B95
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 08:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjGaGKy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 02:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjGaGKx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 02:10:53 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10379F;
        Sun, 30 Jul 2023 23:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1690783850; bh=xEaK7X7r8I5u3UQSXDmC6BF34nY8b/y65ds+fBS5qww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RT8ha0DEQktf3OrZoXdFzUVQSDGeoWSSSRLRtWjyISauqqJzu+EKvGN7cLGSWe2CX
         8BxSFyfZbn+ePOVo8kqi5qU3DkGcstEz+w1cODcYWx+eX6zjfazoD7bx2Ttf5M3Ts3
         jvwgVtYH7kltY8WTA8+lgABNDczORsju9kupPJt4=
Date:   Mon, 31 Jul 2023 08:10:50 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Yuan Tan <tanyuan@tinylab.org>
Cc:     w@1wt.eu, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 2/2] selftests/nolibc: add testcase for pipe
Message-ID: <a4899657-7d7b-4786-8903-8f51e438535d@t-8ch.de>
References: <cover.1690733545.git.tanyuan@tinylab.org>
 <9221753abe0509ef5cbb474a31873012e0e40706.1690733545.git.tanyuan@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9221753abe0509ef5cbb474a31873012e0e40706.1690733545.git.tanyuan@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-07-31 13:51:00+0800, Yuan Tan wrote:
> Add a testcase of pipe that child process sends message to parent
> process.

Thinking about it some more:

What's the advantage of going via a child process?
The pipe should work the same within the same process.

> Here we use memcmp() to avoid the output buffer issue.

This sentence is meaningless without the background from v1.
You can drop it.

> Suggested-by: Thomas Weißschuh <thomas@t-8ch.de>
> Suggested-by: Willy Tarreau <w@1wt.eu>
> Link: https://lore.kernel.org/all/c5de2d13-3752-4e1b-90d9-f58cca99c702@t-8ch.de/
> Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
> ---
>  tools/testing/selftests/nolibc/nolibc-test.c | 35 ++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> index 03b1d30f5507..2653ab8d5124 100644
> --- a/tools/testing/selftests/nolibc/nolibc-test.c
> +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> @@ -767,6 +767,41 @@ int test_mmap_munmap(void)
>  	return ret;
>  }
>  
> +int test_pipe(void)

Should be static and actually get called :-)

> +{
> +	const char *const msg = "hello, nolibc";
> +	int pipefd[2];
> +	char buf[32];
> +	pid_t pid;
> +	ssize_t len;
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
> +		close(pipefd[1]);
> +		exit(EXIT_SUCCESS);
> +
> +	default:
> +		close(pipefd[1]);
> +		len = read(pipefd[0], buf, sizeof(buf));
> +		close(pipefd[0]);
> +		waitpid(pid, NULL, 0);
> +
> +		if (len != strlen(msg))
> +			return 1;
> +		return !!memcmp(buf, msg, len);
> +	}
> +}
> +
>  
>  /* Run syscall tests between IDs <min> and <max>.
>   * Return 0 on success, non-zero on failure.
> -- 
> 2.34.1
> 
