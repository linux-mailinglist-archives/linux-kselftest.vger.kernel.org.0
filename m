Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD7D76B0A2
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 12:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjHAKPl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 06:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbjHAKP0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 06:15:26 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020431B7;
        Tue,  1 Aug 2023 03:15:18 -0700 (PDT)
X-QQ-mid: bizesmtp73t1690884913tdh90bq6
Received: from linux-lab-host.localdomain ( [116.30.131.233])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 01 Aug 2023 18:15:12 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: zT6n3Y95oi30KINxb71iEGkZFmwk0xExAmr450WkSmrjQ6FUOfN0sBKn7EoOM
        /KDQ7euQ/5SsK+jc6T1XBJOI5kvvq6aKAm4LOI7P18kcXcdpMG4g4EwGP9phDr4bHMIgshD
        TH1JaXn1dYM926tHusvBNEJJ7iv7nOWFSTluKvsU7ec6LlV8mzLHmpIr8LHGHZrd6XLV6jH
        +lYfWHc1LLudXDjRxmyWUhQUFem0OVIUzLTmq2A7NitOG7GXOUwPIEWNBo7GDjwZCznLX1/
        mnBzVYCGwsePZdKH5owmfoWRUYUTZXuGhorv1HpDe53EiRJPIkuhDTE28F36badC3zNN0K4
        DogQfF0dGbXiQZ1mrGaAlvbXpbL7MCsdiXp45Hmxq+KSNqFuhOWwGFGwM/yCg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 546874083959870445
From:   Zhangjin Wu <falcon@tinylab.org>
To:     linux@weissschuh.net
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        tanyuan@tinylab.org, w@1wt.eu
Subject: Re: [PATCH v2 07/10] selftests/nolibc: avoid unused arguments warnings
Date:   Tue,  1 Aug 2023 18:15:08 +0800
Message-Id: <20230801101508.75571-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <6d67a8ed-8cb6-4ab7-8db0-68269981f8df@t-8ch.de>
References: <6d67a8ed-8cb6-4ab7-8db0-68269981f8df@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Thomas

> On 2023-08-01 10:07:28+0200, Willy Tarreau wrote:
> > On Tue, Aug 01, 2023 at 07:30:14AM +0200, Thomas Weißschuh wrote:
> > > This warnings will be enabled later so avoid triggering it.
> > > 
> > > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > > ---
> > >  tools/testing/selftests/nolibc/nolibc-test.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> > > index 53a3773c7790..cb17cccd0bc7 100644
> > > --- a/tools/testing/selftests/nolibc/nolibc-test.c
> > > +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> > > @@ -1089,7 +1089,8 @@ static int smash_stack(void)
> > >  	return 1;
> > >  }
> > >  
> > > -static int run_protection(int min, int max)
> > > +static int run_protection(int __attribute__((unused)) min,
> > > +			  int __attribute__((unused)) max)
> > 
> > This one is used to silence -Wunused-parameter I guess.
> 
> Yep.
> 
> > It's one of
> > the rare warnings that I find totally useless in field, because it's
> > simply against the principle of using function pointers with different
> > functions having the same interface but different implementations. As
> > your code evolves you end up with unused on absolutely *all* of the
> > arguments of *all* such functions, which makes them a real pain to add
> > and tends to encourage poor practices such as excessive code reuse just
> > by laziness or boredom. BTW it's one of those that are already disabled
> > in the kernel and we could very well do the same here.
> 
> It's indeed unfortunate.
> 
> As long as we don't have too many of them I would prefer to keep the
> explicit annotations. While they are ugly we then can still reap the
> positive aspects of the warning.
> 
> This is where -std=c89 bites us. With extensions (or C2X) we could also
> just leave off the argument name to mark it as unused:
>     run_protection(int, int)

what about further simply ignore the arguments like we did for main(void)?

Thanks,
Zhangjin
