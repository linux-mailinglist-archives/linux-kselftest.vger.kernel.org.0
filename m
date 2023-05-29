Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6F57149D9
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 May 2023 15:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjE2NFm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 May 2023 09:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjE2NFR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 May 2023 09:05:17 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 02B4BD8;
        Mon, 29 May 2023 06:05:13 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 34TD4ndg002822;
        Mon, 29 May 2023 15:04:49 +0200
Date:   Mon, 29 May 2023 15:04:49 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: Re: [PATCH v2 3/7] selftests/nolibc: fix up compile warning with
 glibc on x86_64
Message-ID: <20230529130449.GA2813@1wt.eu>
References: <cover.1685362482.git.falcon@tinylab.org>
 <aeb48b9cf6fc4674f7560166f22c7dc87d02302d.1685362482.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeb48b9cf6fc4674f7560166f22c7dc87d02302d.1685362482.git.falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, May 29, 2023 at 09:00:01PM +0800, Zhangjin Wu wrote:
> Compiling nolibc-test.c with gcc on x86_64 got such warning:
> 
> tools/testing/selftests/nolibc/nolibc-test.c: In function 'expect_eq':
> tools/testing/selftests/nolibc/nolibc-test.c:177:24: warning: format '%lld' expects argument of type 'long long int', but argument 2 has type 'uint64_t' {aka 'long unsigned int'} [-Wformat=]
>   177 |  llen += printf(" = %lld ", expr);
>       |                     ~~~^    ~~~~
>       |                        |    |
>       |                        |    uint64_t {aka long unsigned int}
>       |                        long long int
>       |                     %ld
> 
> It because that glibc defines uint64_t as "unsigned long int" when word
> size (means sizeof(long)) is 64bit (see include/bits/types.h), but
> nolibc directly use the 64bit "unsigned long long" (see
> tools/include/nolibc/stdint.h), which is simpler, seems kernel uses it
> too (include/uapi/asm-generic/int-ll64.h).
> 
> It is able to do like glibc, defining __WORDSIZE for all of platforms
> and using "unsigned long int" to define uint64_t when __WORDSIZE is
> 64bits, but here uses a simpler solution: nolibc always requires %lld to
> match "unsigned long long", for others, only require %lld when word size
> is 32bit.
> 
> Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> ---
>  tools/testing/selftests/nolibc/nolibc-test.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> index d417ca5d976f..7f9b716fd9b1 100644
> --- a/tools/testing/selftests/nolibc/nolibc-test.c
> +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> @@ -174,7 +174,11 @@ static int expect_eq(uint64_t expr, int llen, uint64_t val)
>  {
>  	int ret = !(expr == val);
>  
> +#if __SIZEOF_LONG__ == 4 || defined(NOLIBC)
>  	llen += printf(" = %lld ", expr);
> +#else
> +	llen += printf(" = %ld ", expr);
> +#endif
>  	pad_spc(llen, 64, ret ? "[FAIL]\n" : " [OK]\n");
>  	return ret;
>  }

Please don't proceed like this. There's much easier to do here for a printf,
just cast the expression to the type printf expects:

-  	llen += printf(" = %lld ", expr);
+  	llen += printf(" = %lld ", (long long)expr);

Willy
