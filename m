Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32CD738F5A
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Jun 2023 20:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjFUS6v (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jun 2023 14:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjFUS6u (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jun 2023 14:58:50 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A1CB4;
        Wed, 21 Jun 2023 11:58:49 -0700 (PDT)
Date:   Wed, 21 Jun 2023 20:58:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1687373926; bh=4nYEAteqZDwoEERcJ/4r/81UZbr+SxIo+24Al6wvXxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qghO2PUkRp7vDv3aBumGSh+IPZJOjqAfAKG4Q6YdGCUdtm6tIqLtT3y0Wr4VoVlUD
         eMqrP1ZeqSRVtntpyIycI8Vt6cXp8gyxJRV7Ykm/utqmw5sPpcL8rdPT6kALm3KG1M
         55TdI+CCWrZWhM2Ur0Jrr6zPTbq6EqvMUKWGDiyo=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     w@1wt.eu, david.laight@aculab.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 10/10] selftests/nolibc: add mmap and munmap test cases
Message-ID: <bff82ea6-610b-4471-a28b-6c76c28604a6@t-8ch.de>
References: <cover.1687187451.git.falcon@tinylab.org>
 <9c46f648cd8c784405afed565bed120f0a2f239e.1687187451.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c46f648cd8c784405afed565bed120f0a2f239e.1687187451.git.falcon@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-06-19 23:55:41+0800, Zhangjin Wu wrote:
> Three mmap/munmap related test cases are added:
> 
> - mmap(NULL, 0, PROT_READ, MAP_PRIVATE, 0, 0), MAP_FAILED, EINVAL)
> 
>   The length argument must be greater than 0, otherwise, fail with -EINVAL.
> 
> - munmap((void *)-1, 4*1024), -1, EINVAL)
> 
>   Invalid (void *)-1 address fail with -EINVAL.
> 
> - test_mmap_munmap(4*1024)
> 
>   It finds a init file, mmap() it and then munmap().
> 
> Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> ---
>  tools/testing/selftests/nolibc/nolibc-test.c | 31 ++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> index 80ab29e2887c..f7c0ca72cb28 100644
> --- a/tools/testing/selftests/nolibc/nolibc-test.c
> +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> @@ -592,6 +592,34 @@ static int test_stat_timestamps(void)
>  	return 0;
>  }
>  
> +int test_mmap_munmap(int size)
> +{
> +	char init_files[5][20] = {"/init", "/sbin/init", "/etc/init", "/bin/init", "/bin/sh"};

Why not /proc/1/exe or even /proc/self/exe?

I know your other series tries to remove the procfs dependency, but
we're not there yet :-).

Also does it make sense to pass a size parameter?
Why not use either PAGE_SIZE or the real size of the binary from
fstat().

> +	int ret, fd, i;
> +	void *mem;
> +
> +	for (i = 0; i < 5; i++) {
> +		ret = fd = open(init_files[i], O_RDONLY);
> +		if (ret < 0)
> +			continue;
> +		else
> +			break;
> +	}
> +	if (ret < 0)
> +		return ret;
> +
> +	mem = mmap(NULL, size, PROT_READ, MAP_SHARED, fd, 0);
> +	if (mem == MAP_FAILED)
> +		return -1;
> +
> +	ret = munmap(mem, size);
> +	if (ret < 0)
> +		return ret;
> +
> +	return close(fd);
> +}
> +
> +
>  /* Run syscall tests between IDs <min> and <max>.
>   * Return 0 on success, non-zero on failure.
>   */
> @@ -666,6 +694,9 @@ int run_syscall(int min, int max)
>  		CASE_TEST(lseek_m1);          EXPECT_SYSER(1, lseek(-1, 0, SEEK_SET), -1, EBADF); break;
>  		CASE_TEST(lseek_0);           EXPECT_SYSER(1, lseek(0, 0, SEEK_SET), -1, ESPIPE); break;
>  		CASE_TEST(mkdir_root);        EXPECT_SYSER(1, mkdir("/", 0755), -1, EEXIST); break;
> +		CASE_TEST(mmap_bad);          EXPECT_PTRER(1, mmap(NULL, 0, PROT_READ, MAP_PRIVATE, 0, 0), MAP_FAILED, EINVAL); break;
> +		CASE_TEST(munmap_bad);        EXPECT_SYSER(1, munmap((void *)-1, 0), -1, EINVAL); break;
> +		CASE_TEST(mmap_good);         EXPECT_SYSZR(1, test_mmap_munmap(4*1024)); break;
>  		CASE_TEST(open_tty);          EXPECT_SYSNE(1, tmp = open("/dev/null", 0), -1); if (tmp != -1) close(tmp); break;
>  		CASE_TEST(open_blah);         EXPECT_SYSER(1, tmp = open("/proc/self/blah", 0), -1, ENOENT); if (tmp != -1) close(tmp); break;
>  		CASE_TEST(poll_null);         EXPECT_SYSZR(1, poll(NULL, 0, 0)); break;
> -- 
> 2.25.1
> 
