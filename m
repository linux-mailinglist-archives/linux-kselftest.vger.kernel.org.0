Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D26624B38
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Nov 2022 21:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiKJUJs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Nov 2022 15:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiKJUJq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Nov 2022 15:09:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067692F382;
        Thu, 10 Nov 2022 12:09:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC829B821E3;
        Thu, 10 Nov 2022 20:09:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F2D0C433C1;
        Thu, 10 Nov 2022 20:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668110982;
        bh=pSFInq4N4Bpw1KNnil1myJW1oupVm04I6GvyJ1r4M90=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZcRPHU5APr+eHfnFXysOgIHlqisvwx7xeSA+5tA0lqSek+E48B4aV6SQAlcs0pCJA
         NnU/H79xbc/Gy1kZYW7sdTDbh90GhkkpROQBxNf0sk3MxSLrmqRmCoYEFEDbLaQNOd
         x9qfjievWDnXssIKGrd6SFbBhsvsL6po7k9DuNmOR5yi7UfRMbawI9lpLkFA49RcXg
         mvSwCqPn+ahcGthFzjbeA+Ax7Ag/8d63rulA8xBN2hgCdw9Ex7gYX9nLZVzX3/YziR
         c0NgmJW2jnOpPzXjaGSBQleiT6VqNJvBtfkaVRJCWlqkhCLw1BZRtgvjYGRjXxdHAT
         Wa/QORdRpcl6g==
From:   SeongJae Park <sj@kernel.org>
To:     Rong Tao <rtoax@foxmail.com>
Cc:     sj@kernel.org, Rong Tao <rongtao@cestc.cn>,
        Shuah Khan <shuah@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yuanchu Xie <yuanchu@google.com>
Subject: Re: [PATCH] selftests/damon: Fix unnecessary compilation warnings
Date:   Thu, 10 Nov 2022 20:09:39 +0000
Message-Id: <20221110200939.101886-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <tencent_CF837EA1B8AC81CB7715E85797510D441E07@qq.com>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Cc-ing Yuanchu Xie.

Hi Rong,

On Thu, 10 Nov 2022 21:34:18 +0800 Rong Tao <rtoax@foxmail.com> wrote:

> From: Rong Tao <rongtao@cestc.cn>
> 
> When testing overflow and overread, there is no need to keep unnecessary
> compilation warnings, we should simply ignore them.
> 
> How to reproduce the problem:
> 
> $ make -C tools/testing/selftests/
> gcc     huge_count_read_write.c  -o /home/sd/Git/linux/tools/testing/selftests/damon/huge_count_read_write

'checkpatch.pl' complains:

    WARNING: use relative pathname instead of absolute in changelog text
    #20:
    gcc     huge_count_read_write.c  -o /home/sd/Git/linux/tools/testing/selftests/damon/huge_count_read_write

Also, could we add four spaces indent for code snippet/command outputs like
above?

> huge_count_read_write.c: In function ‘write_read_with_huge_count’:
> huge_count_read_write.c:23:9: warning: ‘write’ reading 4294967295 bytes from a region of size 1 [-Wstringop-overread]
>    23 |         write(filedesc, "", 0xfffffffful);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from huge_count_read_write.c:8:
> /usr/include/unistd.h:378:16: note: in a call to function ‘write’ declared with attribute ‘access (read_only, 2, 3)’
>   378 | extern ssize_t write (int __fd, const void *__buf, size_t __n) __wur
>       |                ^~~~~
> huge_count_read_write.c:25:15: warning: ‘read’ writing 4294967295 bytes into a region of size 25 overflows the destination [-Wstringop-overflow=]
>    25 |         ret = read(filedesc, buf, 0xfffffffful);
>       |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> huge_count_read_write.c:14:14: note: destination object ‘buf’ of size 25
>    14 |         char buf[25];
>       |              ^~~
> In file included from huge_count_read_write.c:8:
> /usr/include/unistd.h:371:16: note: in a call to function ‘read’ declared with attribute ‘access (write_only, 2, 3)’
>   371 | extern ssize_t read (int __fd, void *__buf, size_t __nbytes) __wur
>       |                ^~~~
> 
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
>  tools/testing/selftests/damon/huge_count_read_write.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tools/testing/selftests/damon/huge_count_read_write.c b/tools/testing/selftests/damon/huge_count_read_write.c
> index ad7a6b4cf338..8fbe276870e7 100644
> --- a/tools/testing/selftests/damon/huge_count_read_write.c
> +++ b/tools/testing/selftests/damon/huge_count_read_write.c
> @@ -8,6 +8,11 @@
>  #include <unistd.h>
>  #include <stdio.h>
>  
> +#pragma GCC diagnostic push
> +/* Ignore read(2) overflow and write(2) overread compile warnings */
> +#pragma GCC diagnostic ignored "-Wstringop-overread"
> +#pragma GCC diagnostic ignored "-Wstringop-overflow"
> +

Thank you for sending this patch!

However, there was a similar patch from Yuanchu[1], and this causes another
warning for old gcc[2] that I use (9.4.0), like below.

    gcc -Wno-stringop-overread -Wno-stringop-overflow    huge_count_read_write.c  -o /home/sjpark/linux/tools/testing/selftests/damon/huge_count_read_write
    huge_count_read_write.c:13:32: warning: unknown option after ‘#pragma GCC diagnostic’ kind [-Wpragmas]
       13 | #pragma GCC diagnostic ignored "-Wstringop-overread"
          |                                ^~~~~~~~~~~~~~~~~~~~~
    cc1: warning: unrecognized command line option ‘-Wno-stringop-overread’

As mentioned as a reply to Yuanchu's patch, I'd slightly prefer making it
silent for both new and old compilers than this approach, but no strong opinion
from my side.  Yuanchu and Shuah, do you have some opinion?

[1] https://lore.kernel.org/lkml/CAJj2-QE4ee=N9wYXVQc6gyZYC3zgAsWVwWJ7DMaS2B9q2WqBHw@mail.gmail.com/
[2] https://lore.kernel.org/lkml/20220504184537.130085-1-sj@kernel.org/
[3] https://lore.kernel.org/lkml/20220517160417.1096-1-sj@kernel.org/


Thanks,
SJ

>  void write_read_with_huge_count(char *file)
>  {
>  	int filedesc = open(file, O_RDWR);
> @@ -27,6 +32,8 @@ void write_read_with_huge_count(char *file)
>  	close(filedesc);
>  }
>  
> +#pragma GCC diagnostic pop
> +
>  int main(int argc, char *argv[])
>  {
>  	if (argc != 2) {
> -- 
> 2.31.1
> 
> 
