Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E35576AA89
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 10:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjHAIHz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 04:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbjHAIHy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 04:07:54 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB9D911D;
        Tue,  1 Aug 2023 01:07:51 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 37187ScL031011;
        Tue, 1 Aug 2023 10:07:28 +0200
Date:   Tue, 1 Aug 2023 10:07:28 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yuan Tan <tanyuan@tinylab.org>,
        Zhangjin Wu <falcon@tinylab.org>
Subject: Re: [PATCH v2 07/10] selftests/nolibc: avoid unused arguments
 warnings
Message-ID: <ZMi9QAIh4/0GGh5h@1wt.eu>
References: <20230801-nolibc-warnings-v2-0-1ba5ca57bd9b@weissschuh.net>
 <20230801-nolibc-warnings-v2-7-1ba5ca57bd9b@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230801-nolibc-warnings-v2-7-1ba5ca57bd9b@weissschuh.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 01, 2023 at 07:30:14AM +0200, Thomas Weiﬂschuh wrote:
> This warnings will be enabled later so avoid triggering it.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  tools/testing/selftests/nolibc/nolibc-test.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> index 53a3773c7790..cb17cccd0bc7 100644
> --- a/tools/testing/selftests/nolibc/nolibc-test.c
> +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> @@ -1089,7 +1089,8 @@ static int smash_stack(void)
>  	return 1;
>  }
>  
> -static int run_protection(int min, int max)
> +static int run_protection(int __attribute__((unused)) min,
> +			  int __attribute__((unused)) max)

This one is used to silence -Wunused-parameter I guess. It's one of
the rare warnings that I find totally useless in field, because it's
simply against the principle of using function pointers with different
functions having the same interface but different implementations. As
your code evolves you end up with unused on absolutely *all* of the
arguments of *all* such functions, which makes them a real pain to add
and tends to encourage poor practices such as excessive code reuse just
by laziness or boredom. BTW it's one of those that are already disabled
in the kernel and we could very well do the same here.

Willy
