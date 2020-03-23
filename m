Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E81918FC6E
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Mar 2020 19:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbgCWSIP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Mar 2020 14:08:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:37938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727558AbgCWSIP (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Mar 2020 14:08:15 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AAB62072D;
        Mon, 23 Mar 2020 18:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584986894;
        bh=H1L2CejU9iakS/DTwSHIerZWRkzwEkjwxc6vOGPfR6c=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gBisDOcPBOsgl3GbhS00yy4Re04wnLc884SQMrSXTKc1pd7uYKtKsY87Ow6hPEpaF
         BKirCfa/p61Rr81c+70/0WyTqnNFpA/R6Jdgfffu1TL7WINVdaqNCCbyO1OsiJEi3+
         j68jSFhUhq1TjnGM4o3FPd+U3m6pg6X5iYlKNKoE=
Subject: Re: [PATCH v2 1/2] selftests/harness: Move test child waiting logic
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <20200313231252.64999-1-keescook@chromium.org>
 <20200313231252.64999-2-keescook@chromium.org>
From:   shuah <shuah@kernel.org>
Message-ID: <0df3a446-cbdf-ed6b-9567-b137ec2138f7@kernel.org>
Date:   Mon, 23 Mar 2020 12:08:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200313231252.64999-2-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Kees,

On 3/13/20 5:12 PM, Kees Cook wrote:
> In order to better handle timeout failures, rearrange the child waiting
> logic into a separate function. This is mostly a copy/paste with an
> indentation change. To handle pid tracking, a new field is added for
> the child pid. Also move the alarm() pairing into the function.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Sorry for the delay. I was on vacation all of last week
and totally trying to stay away from checking email.

My commit scripts falied on checkpatch warnings.

A couple of comments below:


> ---
>   tools/testing/selftests/kselftest_harness.h | 93 +++++++++++----------
>   1 file changed, 49 insertions(+), 44 deletions(-)
>  > diff --git a/tools/testing/selftests/kselftest_harness.h 
b/tools/testing/selftests/kselftest_harness.h
> index 5336b26506ab..c7b67e379219 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -635,6 +635,7 @@
>   struct __test_metadata {
>   	const char *name;
>   	void (*fn)(struct __test_metadata *);
> +	pid_t pid;	/* pid of test when being run */
>   	int termsig;
>   	int passed;
>   	int trigger; /* extra handler after the evaluation */
> @@ -695,64 +696,68 @@ static inline int __bail(int for_realz, bool no_print, __u8 step)
>   	return 0;
>   }
>   
> -void __run_test(struct __test_metadata *t)
> +void __wait_for_test(struct __test_metadata *t)
>   {
> -	pid_t child_pid;
>   	int status;
>   
> +	alarm(t->timeout);
> +	waitpid(t->pid, &status, 0);
> +	alarm(0);
> +
> +	if (WIFEXITED(status)) {
> +		t->passed = t->termsig == -1 ? !WEXITSTATUS(status) : 0;
> +		if (t->termsig != -1) {
> +			fprintf(TH_LOG_STREAM,
> +				"%s: Test exited normally "
> +				"instead of by signal (code: %d)\n",
> +				t->name,
> +				WEXITSTATUS(status));

This one isn't an error and gets printed to stderr? Except for
this one message, all other messages in this routine are indeed
errors. It makes sense to print this out to stdout instead.

> +		} else if (!t->passed) {
> +			fprintf(TH_LOG_STREAM,
> +				"%s: Test failed at step #%d\n",
> +				t->name,
> +				WEXITSTATUS(status));
> +		}
> +	} else if (WIFSIGNALED(status)) {
> +		t->passed = 0;
> +		if (WTERMSIG(status) == SIGABRT) {
> +			fprintf(TH_LOG_STREAM,
> +				"%s: Test terminated by assertion\n",
> +				t->name);
> +		} else if (WTERMSIG(status) == t->termsig) {
> +			t->passed = 1;
> +		} else {
> +			fprintf(TH_LOG_STREAM,
> +				"%s: Test terminated unexpectedly "
> +				"by signal %d\n",
> +				t->name,
> +				WTERMSIG(status));
> +		}
> +	} else {
> +		fprintf(TH_LOG_STREAM,
> +			"%s: Test ended in some other way [%u]\n",
> +			t->name,
> +			status);
> +	}
> +}
> +
> +void __run_test(struct __test_metadata *t)
> +{
>   	t->passed = 1;
>   	t->trigger = 0;
>   	printf("[ RUN      ] %s\n", t->name);
> -	alarm(t->timeout);
> -	child_pid = fork();
> -	if (child_pid < 0) {
> +	t->pid = fork();
> +	if (t->pid < 0) {
>   		printf("ERROR SPAWNING TEST CHILD\n");
>   		t->passed = 0;
> -	} else if (child_pid == 0) {
> +	} else if (t->pid == 0) {
>   		t->fn(t);
>   		/* return the step that failed or 0 */
>   		_exit(t->passed ? 0 : t->step);
>   	} else {
> -		/* TODO(wad) add timeout support. */
> -		waitpid(child_pid, &status, 0);
> -		if (WIFEXITED(status)) {
> -			t->passed = t->termsig == -1 ? !WEXITSTATUS(status) : 0;
> -			if (t->termsig != -1) {
> -				fprintf(TH_LOG_STREAM,
> -					"%s: Test exited normally "
> -					"instead of by signal (code: %d)\n",
> -					t->name,
> -					WEXITSTATUS(status));
> -			} else if (!t->passed) {
> -				fprintf(TH_LOG_STREAM,
> -					"%s: Test failed at step #%d\n",
> -					t->name,
> -					WEXITSTATUS(status));
> -			}
> -		} else if (WIFSIGNALED(status)) {
> -			t->passed = 0;
> -			if (WTERMSIG(status) == SIGABRT) {
> -				fprintf(TH_LOG_STREAM,
> -					"%s: Test terminated by assertion\n",
> -					t->name);
> -			} else if (WTERMSIG(status) == t->termsig) {
> -				t->passed = 1;
> -			} else {
> -				fprintf(TH_LOG_STREAM,
> -					"%s: Test terminated unexpectedly "
> -					"by signal %d\n",
> -					t->name,
> -					WTERMSIG(status));
> -			}
> -		} else {
> -			fprintf(TH_LOG_STREAM,
> -				"%s: Test ended in some other way [%u]\n",
> -				t->name,
> -				status);
> -		}
> +		__wait_for_test(t);
>   	}
>   	printf("[     %4s ] %s\n", (t->passed ? "OK" : "FAIL"), t->name);
> -	alarm(0);
>   }
>   
>   static int test_harness_run(int __attribute__((unused)) argc,
> 

thanks,
-- Shuah
