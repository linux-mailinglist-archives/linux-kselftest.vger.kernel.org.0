Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B64EF7486
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2019 14:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfKKNHc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Nov 2019 08:07:32 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:48675 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfKKNHc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Nov 2019 08:07:32 -0500
Received: from p54ac5540.dip0.t-ipconnect.de ([84.172.85.64] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iU9Pk-0002a2-Cn; Mon, 11 Nov 2019 13:07:28 +0000
Date:   Mon, 11 Nov 2019 14:07:27 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Adrian Reber <areber@redhat.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] selftests: add tests for clone3()
Message-ID: <20191111130726.ccr6c663r6bre67x@wittgenstein>
References: <20191108185629.309414-1-areber@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191108185629.309414-1-areber@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 08, 2019 at 07:56:29PM +0100, Adrian Reber wrote:
> +static void test_clone3(uint64_t flags, size_t size, int expected,
> +		       enum test_mode test_mode)
> +{
> +	int ret;
> +
> +	ksft_print_msg(
> +		"[%d] Trying clone3() with flags %#" PRIx64 " (size %zu)\n",
> +		getpid(), flags, size);
> +	ret = call_clone3(flags, size, test_mode);
> +	ksft_print_msg("[%d] clone3() with flags says: %d expected %d\n",
> +			getpid(), ret, expected);
> +	if (ret != expected)
> +		ksft_test_result_fail(
> +			"[%d] Result (%d) is different than expected (%d)\n",
> +			getpid(), ret, expected);
> +	else
> +		ksft_test_result_pass(
> +			"[%d] Result (%d) matches expectation (%d)\n",
> +			getpid(), ret, expected);
> +}
> +int main(int argc, char *argv[])

Nit: missing \n between } and int main().
I'll just fix that up myself.

> +	/*
> +	 * Do a clone3() with sizeof(struct clone_args) + 8
> +	 * and all members set to 0. This resets exit_signal and wait()
> +	 * will not get a result.

That comment is not true and now also misleading since you now pass
_WALL to waitpid() above. I'll just remove it when applying.

> +	 */
> +	test_clone3(0, sizeof(struct clone_args) + 8, 0, CLONE3_ARGS_ALL_0);
> +
> +	/* Do a clone3() with > page size */
> +	test_clone3(0, getpagesize() + 8, -E2BIG, CLONE3_ARGS_NO_TEST);
> +
> +	/* Do a clone3() with CLONE3_ARGS_SIZE_V0 in a new PID NS. */
> +	if (uid == 0)
> +		test_clone3(CLONE_NEWPID, CLONE3_ARGS_SIZE_V0, 0,
> +				CLONE3_ARGS_NO_TEST);
> +	else
> +		ksft_test_result_skip("Skipping clone3() with CLONE_NEWPID\n");
> +
> +	/* Do a clone3() with CLONE3_ARGS_SIZE_V0 - 8 in a new PID NS */
> +	test_clone3(CLONE_NEWPID, CLONE3_ARGS_SIZE_V0 - 8, -EINVAL,
> +			CLONE3_ARGS_NO_TEST);
> +
> +	/* Do a clone3() with sizeof(struct clone_args) + 8 in a new PID NS */
> +	if (uid == 0)
> +		test_clone3(CLONE_NEWPID, sizeof(struct clone_args) + 8, 0,
> +				CLONE3_ARGS_NO_TEST);

So there's a missing test condition here, no? I've just realized you're
passing in sizeof(struct clone_args) + 8 which hits the first excess
space 64 bit value which is 0. That's good and the reason why this test
passes.
But I don't see any test for sizoef(struct clone_args_extended) or at
least sizeof(struct clone_args) + 16 such that you actually hit the
second 64 bit integer which is initialized to 1 and thus clone3() should
fail with -E2BIG.If I haven't overlooked this test, can you please add
it? It's quite important since it's a different codepath than the
sizeof(PAGE_SIZE) + 8 codepath.

Thanks!
Christian
