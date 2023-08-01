Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105A576AA95
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 10:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjHAINQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 04:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbjHAINP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 04:13:15 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8BF1AD;
        Tue,  1 Aug 2023 01:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1690877590;
        bh=esGqvtLIc/39Ft0f6sn11uAKH+osBvRuKhErQx0NxoA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c5LMd1LkJswCc+UixF/lEMrEFz+sW3ugNt+5eZf4XqX915aLYI3DV1ZdcnHuyDfJX
         NmFDFrijFV64K+GQl7nC7sCkMiMSu8Wr/+DTEp38O1JQW8CYJTKClFoIgcVigWwb2r
         ih6aSnQcdHyGgZgnsAHs+HU4Q5yI9OkJ5exemdNo=
Date:   Tue, 1 Aug 2023 10:13:10 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yuan Tan <tanyuan@tinylab.org>,
        Zhangjin Wu <falcon@tinylab.org>
Subject: Re: [PATCH v2 07/10] selftests/nolibc: avoid unused arguments
 warnings
Message-ID: <6d67a8ed-8cb6-4ab7-8db0-68269981f8df@t-8ch.de>
References: <20230801-nolibc-warnings-v2-0-1ba5ca57bd9b@weissschuh.net>
 <20230801-nolibc-warnings-v2-7-1ba5ca57bd9b@weissschuh.net>
 <ZMi9QAIh4/0GGh5h@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZMi9QAIh4/0GGh5h@1wt.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-08-01 10:07:28+0200, Willy Tarreau wrote:
> On Tue, Aug 01, 2023 at 07:30:14AM +0200, Thomas Weißschuh wrote:
> > This warnings will be enabled later so avoid triggering it.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> >  tools/testing/selftests/nolibc/nolibc-test.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> > index 53a3773c7790..cb17cccd0bc7 100644
> > --- a/tools/testing/selftests/nolibc/nolibc-test.c
> > +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> > @@ -1089,7 +1089,8 @@ static int smash_stack(void)
> >  	return 1;
> >  }
> >  
> > -static int run_protection(int min, int max)
> > +static int run_protection(int __attribute__((unused)) min,
> > +			  int __attribute__((unused)) max)
> 
> This one is used to silence -Wunused-parameter I guess.

Yep.

> It's one of
> the rare warnings that I find totally useless in field, because it's
> simply against the principle of using function pointers with different
> functions having the same interface but different implementations. As
> your code evolves you end up with unused on absolutely *all* of the
> arguments of *all* such functions, which makes them a real pain to add
> and tends to encourage poor practices such as excessive code reuse just
> by laziness or boredom. BTW it's one of those that are already disabled
> in the kernel and we could very well do the same here.

It's indeed unfortunate.

As long as we don't have too many of them I would prefer to keep the
explicit annotations. While they are ugly we then can still reap the
positive aspects of the warning.

This is where -std=c89 bites us. With extensions (or C2X) we could also
just leave off the argument name to mark it as unused:
    run_protection(int, int)
