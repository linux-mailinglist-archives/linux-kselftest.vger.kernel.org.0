Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18D6758857
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 00:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjGRWRE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 18:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjGRWRE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 18:17:04 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6D4BD;
        Tue, 18 Jul 2023 15:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1689718620; bh=9o6xwsclpvFRStSI4IySi+Wcd4hI4rzU25xBqK8PGkM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zy65i0G1zBw5/p4P++nEF9PbS7Su1WBbJ1MX9hEBe5bzr0PAp2655sINBkcKzundv
         /o0nC4BmTXMwg67VkbWt3v8GPBZOgGJO1Aji+2PUw+OmOHxHR+3HoSDFKGE+b+MOa3
         17scXfFlEO5OT5o13oz+uuchp942bUsi5FI+7tU0=
Date:   Wed, 19 Jul 2023 00:17:00 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     w@1wt.eu, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 3/8] selftests/nolibc: select_null: fix up for big
 endian powerpc64
Message-ID: <be205fbd-31c2-4066-bfb1-65b9d0cb57c2@t-8ch.de>
References: <cover.1689713175.git.falcon@tinylab.org>
 <56e91281fde98fb3b2e34986d96870d76ebc3238.1689713175.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56e91281fde98fb3b2e34986d96870d76ebc3238.1689713175.git.falcon@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As this would be a generic bugfix it should be at the front of the
series, but...

On 2023-07-19 05:13:01+0800, Zhangjin Wu wrote:
> The following error reported while running nolibc-test on the big endian
> 64-bit PowerPC kernel compiled with powerpc64le-linux-gnu-gcc in Ubuntu
> 20.04.
> 
>     56 select_nullinit[1]: illegal instruction (4) at 100042a8 nip 100042a8 lr 100042a8 code 1 in init[10000000+10000]
>     init[1]: code: 7c6307b4 7c234840 4081f580 7c6300d0 907d0000 3860ffff 4bfff570 3ca2fffe
>     init[1]: code: 38800038 38a5d547 7fc3f378 4bffcd65 <1000038c> 38c10060 38a00000 38800000
> 
> Let's explicitly initialize all of the timeval members to zero.
> 
> Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> ---
>  tools/testing/selftests/nolibc/nolibc-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> index 03b1d30f5507..ec2c7774522e 100644
> --- a/tools/testing/selftests/nolibc/nolibc-test.c
> +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> @@ -858,7 +858,7 @@ int run_syscall(int min, int max)
>  		CASE_TEST(read_badf);         EXPECT_SYSER(1, read(-1, &tmp, 1), -1, EBADF); break;
>  		CASE_TEST(rmdir_blah);        EXPECT_SYSER(1, rmdir("/blah"), -1, ENOENT); break;
>  		CASE_TEST(sched_yield);       EXPECT_SYSZR(1, sched_yield()); break;
> -		CASE_TEST(select_null);       EXPECT_SYSZR(1, ({ struct timeval tv = { 0 }; select(0, NULL, NULL, NULL, &tv); })); break;
> +		CASE_TEST(select_null);       EXPECT_SYSZR(1, ({ struct timeval tv = { 0, 0 }; select(0, NULL, NULL, NULL, &tv); })); break;

This doesn't really make sense.
Firstly, "{ 0 }" zeroes the whole structure.

Also the warning talks about "illegal instruction" while this structure
is data and should never be executed as code.

Is this failure reproducible?
Maybe the error is actually in the syscall wrapper?
I'll also take a look tomorrow.

>  		CASE_TEST(select_stdout);     EXPECT_SYSNE(1, ({ fd_set fds; FD_ZERO(&fds); FD_SET(1, &fds); select(2, NULL, &fds, NULL, NULL); }), -1); break;
>  		CASE_TEST(select_fault);      EXPECT_SYSER(1, select(1, (void *)1, NULL, NULL, 0), -1, EFAULT); break;
>  		CASE_TEST(stat_blah);         EXPECT_SYSER(1, stat("/proc/self/blah", &stat_buf), -1, ENOENT); break;
> -- 
> 2.25.1
> 
