Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59022714A18
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 May 2023 15:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjE2NRQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 May 2023 09:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjE2NRN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 May 2023 09:17:13 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFAC10C;
        Mon, 29 May 2023 06:16:37 -0700 (PDT)
X-QQ-mid: bizesmtp79t1685366138tuh7hwm2
Received: from linux-lab-host.localdomain ( [119.123.130.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 29 May 2023 21:15:37 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: Bt6VvACH2lxPDSqLKk8oIpBVhB33MD55CoUCVpzQ9ygXQNimNUvEkUlPf0ILF
        XgQDDzZu334LYd4VWLUHTb6l5t44PodGFC44Sj9m29ix6L3usWzz7F1hY5HpmH/TZAJFAhv
        webS86/IrzS4fW/ZYl6eR/LRpVClD+cdFOF190p35yX6rNGT6tEYUg3B+mMLG8fewYgR0NM
        6iVECGjzITrPvUjBPEK7TB2sibfaEs5093+0IqA7CHieBb4Y02XfJXtetvVxZ5XuGsZfwMi
        NzBDvh64IRFpTUsY4fjqEncEl/hqCw6A+guWHJc0Bs3QLOGrPJDU7o4E83ypK7S3XIkXUBW
        TdnU7W4QhefRz/kSCAIksuSE/RqIy/bo/jXAITzMZrdgTr4sqPvuuYIJi2wIw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1046913872741626693
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: Re: [PATCH v2 3/7] selftests/nolibc: fix up compile warning with glibc on x86_64
Date:   Mon, 29 May 2023 21:15:36 +0800
Message-Id: <20230529131536.80183-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230529130449.GA2813@1wt.eu>
References: <20230529130449.GA2813@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> On Mon, May 29, 2023 at 09:00:01PM +0800, Zhangjin Wu wrote:
> > Compiling nolibc-test.c with gcc on x86_64 got such warning:
> > 
> > tools/testing/selftests/nolibc/nolibc-test.c: In function 'expect_eq':
> > tools/testing/selftests/nolibc/nolibc-test.c:177:24: warning: format '%lld' expects argument of type 'long long int', but argument 2 has type 'uint64_t' {aka 'long unsigned int'} [-Wformat=]
> >   177 |  llen += printf(" = %lld ", expr);
> >       |                     ~~~^    ~~~~
> >       |                        |    |
> >       |                        |    uint64_t {aka long unsigned int}
> >       |                        long long int
> >       |                     %ld
> > 
> > It because that glibc defines uint64_t as "unsigned long int" when word
> > size (means sizeof(long)) is 64bit (see include/bits/types.h), but
> > nolibc directly use the 64bit "unsigned long long" (see
> > tools/include/nolibc/stdint.h), which is simpler, seems kernel uses it
> > too (include/uapi/asm-generic/int-ll64.h).
> > 
> > It is able to do like glibc, defining __WORDSIZE for all of platforms
> > and using "unsigned long int" to define uint64_t when __WORDSIZE is
> > 64bits, but here uses a simpler solution: nolibc always requires %lld to
> > match "unsigned long long", for others, only require %lld when word size
> > is 32bit.
> > 
> > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > ---
> >  tools/testing/selftests/nolibc/nolibc-test.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> > index d417ca5d976f..7f9b716fd9b1 100644
> > --- a/tools/testing/selftests/nolibc/nolibc-test.c
> > +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> > @@ -174,7 +174,11 @@ static int expect_eq(uint64_t expr, int llen, uint64_t val)
> >  {
> >  	int ret = !(expr == val);
> >  
> > +#if __SIZEOF_LONG__ == 4 || defined(NOLIBC)
> >  	llen += printf(" = %lld ", expr);
> > +#else
> > +	llen += printf(" = %ld ", expr);
> > +#endif
> >  	pad_spc(llen, 64, ret ? "[FAIL]\n" : " [OK]\n");
> >  	return ret;
> >  }
> 
> Please don't proceed like this. There's much easier to do here for a printf,
> just cast the expression to the type printf expects:
> 
> -  	llen += printf(" = %lld ", expr);
> +  	llen += printf(" = %lld ", (long long)expr);

Yes, this conversion is better, my method make things more complex ;-)

Thanks,
Zhangjin

> 
> Willy
