Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832237437AF
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Jun 2023 10:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjF3Ip3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Jun 2023 04:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjF3Ip2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Jun 2023 04:45:28 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67241194;
        Fri, 30 Jun 2023 01:45:27 -0700 (PDT)
Date:   Fri, 30 Jun 2023 10:45:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1688114725; bh=vytjrpkLDpehIHma/uXDpeJc92hkL4ssmlqiBLvV1AQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B9d1LsZSeUT1TFfjiHwswSnUqQYzhc8GBdBrJ4V+pRfX+O2CJ5IkEsTDiO6TAd5gH
         X5Sx12JfQ2r01aE92gJ9cZfgmgNLSQ2Ye23tdwFugTRZqS27I3R0eGbvnKDuHgNxwi
         3Dmnah1blcbl4Snzk28Ac2aZLD15vyZBJDIg8VNk=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     w@1wt.eu, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 13/15] selftests/nolibc: rename chroot_exe to
 chroot_tmpfile
Message-ID: <8665cddc-0ac8-497c-848e-aaa42398bf24@t-8ch.de>
References: <cover.1688078604.git.falcon@tinylab.org>
 <a38a6057866b597e5f931de550f2a6f24404ecdf.1688078605.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a38a6057866b597e5f931de550f2a6f24404ecdf.1688078605.git.falcon@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-06-30 08:00:28+0800, Zhangjin Wu wrote:
> For CONFIG_PROC_FS=n, let's use tmpfs and create a tmp file for
> chroot_exe test.
> 
> Since chroot_exe is mainly testing the not directory case (ENOTDIR), so,
> rename it to chroot_tmpfile may be better.
> 
> Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> ---
>  tools/testing/selftests/nolibc/nolibc-test.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> index 1002e0267515..2e9eaa7efa6e 100644
> --- a/tools/testing/selftests/nolibc/nolibc-test.c
> +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> @@ -682,6 +682,8 @@ int run_syscall(int min, int max)
>  	int ret = 0;
>  	void *p1, *p2;
>  	int has_gettid = 1;
> +	const char *tmpfile = get_tmpfile("/tmp/dummy");
> +	int has_tmpfile = tmpfile != NULL;
>  
>  	/* <proc> indicates whether or not /proc is mounted */
>  	proc = stat("/proc", &stat_buf) == 0;
> @@ -720,7 +722,7 @@ int run_syscall(int min, int max)
>  		CASE_TEST(chown_self);        EXPECT_SYSER(proc, chown("/proc/self", 0, 0), -1, EPERM); break;
>  		CASE_TEST(chroot_root);       EXPECT_SYSZR(euid0, chroot("/")); break;
>  		CASE_TEST(chroot_blah);       EXPECT_SYSER(1, chroot("/proc/self/blah"), -1, ENOENT); break;
> -		CASE_TEST(chroot_exe);        EXPECT_SYSER(proc, chroot("/proc/self/exe"), -1, ENOTDIR); break;
> +		CASE_TEST(chroot_tmpfile);    EXPECT_SYSER(has_tmpfile, chroot(tmpfile), -1, ENOTDIR); break;

get_tempfile() looks really weird.
Given that the nolibc implementation of chroot() is the most trivial
imaginable in my opinion we can keep the current "chroot_exe" that is
using procfs.

>  		CASE_TEST(close_m1);          EXPECT_SYSER(1, close(-1), -1, EBADF); break;
>  		CASE_TEST(close_dup);         EXPECT_SYSZR(1, close(dup(0))); break;
>  		CASE_TEST(dup_0);             tmp = dup(0);  EXPECT_SYSNE(1, tmp, -1); close(tmp); break;
> -- 
> 2.25.1
> 
