Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318D576A987
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 08:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjHAGwa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 02:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjHAGw3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 02:52:29 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E607BF;
        Mon, 31 Jul 2023 23:52:28 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 3716qJIH030318;
        Tue, 1 Aug 2023 08:52:19 +0200
Date:   Tue, 1 Aug 2023 08:52:19 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yuan Tan <tanyuan@tinylab.org>,
        Zhangjin Wu <falcon@tinylab.org>
Subject: Re: [PATCH v2 06/10] selftests/nolibc: make functions static if
 possible
Message-ID: <ZMiro1pwVvAzNel5@1wt.eu>
References: <20230801-nolibc-warnings-v2-0-1ba5ca57bd9b@weissschuh.net>
 <20230801-nolibc-warnings-v2-6-1ba5ca57bd9b@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230801-nolibc-warnings-v2-6-1ba5ca57bd9b@weissschuh.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 01, 2023 at 07:30:13AM +0200, Thomas Weißschuh wrote:
> diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> index 1555759bb164..53a3773c7790 100644
> --- a/tools/testing/selftests/nolibc/nolibc-test.c
> +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> @@ -80,7 +80,7 @@ char *itoa(int i)
>  /* returns the error name (e.g. "ENOENT") for common errors, "SUCCESS" for 0,
>   * or the decimal value for less common ones.
>   */
> -const char *errorname(int err)
> +static const char *errorname(int err)
>  {
>  	switch (err) {
>  	case 0: return "SUCCESS";

OK for this one, even desired for such a use case.

> @@ -593,7 +593,7 @@ int expect_strne(const char *expr, int llen, const char *cmp)
>  #define CASE_TEST(name) \
>  	case __LINE__: llen += printf("%d %s", test, #name);
>  
> -int run_startup(int min, int max)
> +static int run_startup(int min, int max)
>  {
>  	int test;
>  	int ret = 0;
> @@ -640,7 +640,7 @@ int run_startup(int min, int max)
>  
>  
>  /* used by some syscall tests below */
> -int test_getdents64(const char *dir)
> +static int test_getdents64(const char *dir)
>  {
>  	char buffer[4096];
>  	int fd, ret;
> @@ -734,7 +734,7 @@ static int test_stat_timestamps(void)
>  	return 0;
>  }
>  
> -int test_mmap_munmap(void)
> +static int test_mmap_munmap(void)
>  {
>  	int ret, fd, i;
>  	void *mem;
> @@ -796,7 +796,7 @@ int test_mmap_munmap(void)
>  /* Run syscall tests between IDs <min> and <max>.
>   * Return 0 on success, non-zero on failure.
>   */
> -int run_syscall(int min, int max)
> +static int run_syscall(int min, int max)
>  {
>  	struct timeval tv;
>  	struct timezone tz;
> @@ -907,7 +907,7 @@ int run_syscall(int min, int max)
>  	return ret;
>  }
>  
> -int run_stdlib(int min, int max)
> +static int run_stdlib(int min, int max)
>  {
>  	int test;
>  	int ret = 0;
> @@ -1141,7 +1141,7 @@ static int run_protection(int min, int max)
>  }
>  
>  /* prepare what needs to be prepared for pid 1 (stdio, /dev, /proc, etc) */
> -int prepare(void)
> +static int prepare(void)
>  {
>  	struct stat stat_buf;
>  
> @@ -1208,7 +1208,7 @@ static const struct test test_names[] = {
>  	{ 0 }
>  };
 
For these ones it will prevent gcc from putting breakpoints there, which
is counter-productive.

> -int is_setting_valid(char *test)
> +static int is_setting_valid(char *test)
>  {
>  	int idx, len, test_len, valid = 0;
>  	char delimiter;

OK for this one.

Willy
