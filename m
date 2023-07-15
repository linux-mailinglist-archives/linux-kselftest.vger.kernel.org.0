Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DD67547E1
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jul 2023 11:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbjGOJXp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 15 Jul 2023 05:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjGOJXh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 15 Jul 2023 05:23:37 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC103AB1;
        Sat, 15 Jul 2023 02:23:15 -0700 (PDT)
X-QQ-mid: bizesmtp89t1689412983tno1gxiu
Received: from linux-lab-host.localdomain ( [119.123.131.162])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 15 Jul 2023 17:23:01 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: q+EIYT+FhZrAovjZxRoSnSnHnPax2IuslwuJRGRN5fECtY6fP4y4nhEUwUr/c
        0bUAu3pmDk1aSDl4lKKLg/ti7sgCj9P1l9zM7AlbSwJ9g1kmLPDAv7iBZaL7RVeJg2OAGsd
        Q3g+9mb1+8fYLInhCmAesMAPF0dyndoVARHSEkyG5j75YuiVCHIa9ljZXUB60Kves7wTdtK
        +g9HISe8gYOHfbGwfbnntiU5x79dPmmm7PI6lMjuYKcxEXkS25r7nNeCk8rbHRUO478mvRG
        wjVA7qrK1isT0gBDvlf/mfn8sPPDY2DT1UBycINpobsCb8RB2Y6zCCwoTlA7/Wla4DEo35o
        x50tunzZrYf50+kTeFX2f8Q7jx9zg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5920392168960088624
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, w@1wt.eu
Subject: Re: [PATCH v3 02/11] tools/nolibc: add new crt.h with _start_c
Date:   Sat, 15 Jul 2023 17:23:01 +0800
Message-Id: <20230715092301.339180-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <34b21ba5-7b59-4b3b-9ed6-ef9a3a5e06f7@t-8ch.de>
References: <34b21ba5-7b59-4b3b-9ed6-ef9a3a5e06f7@t-8ch.de>
MIME-Version: 1.0
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

> On 2023-07-14 17:47:23+0800, Zhangjin Wu wrote:
> > > On 2023-07-14 13:58:13+0800, Zhangjin Wu wrote:
> 
> > [..]
> 
> > > I was also not able to reproduce the issue.
> > >
> > 
> > Thanks very much for your 'reproduce' result, It is so weird, just
> > rechecked the toolchain, 13.1.0 from https://mirrors.edge.kernel.org/ is
> > ok, gcc 9, gcc 10.3 not work.
> > 
> > But even in the page of 13.1.0 [1], we still see this line:
> > 
> >     Most optimizations are completely disabled at -O0 or if an -O level is not set on the command line, even if individual optimization flags are specified.
> > 
> > Not sure if "individual optimization flags" also means the optimize()
> > flags in gcc attributes. or the doc is not updated yet?
> > 
> > And further found gcc 11.1.0 is ok, gcc 10.4 still not work, so, gcc
> > 11.1.0 may changed something to let the "individual optimization flags"
> > work with -O0.
> > 
> > We may need to at least document this issue in some files, -O0 is not such a
> > frequently-used option, not sure if we still need -O0 work with the older gcc <
> > 11.1.0 ;-)
> 
> It seems we can avoid the issue by enforcing optimizations for _start:
> 
> diff --git a/tools/include/nolibc/arch-x86_64.h b/tools/include/nolibc/arch-x86_64.h
> index f5614a67f05a..b9d8b8861dc4 100644
> --- a/tools/include/nolibc/arch-x86_64.h
> +++ b/tools/include/nolibc/arch-x86_64.h
> @@ -161,12 +161,9 @@
>   * 2) The deepest stack frame should be zero (the %rbp).
>   *
>   */
> -void __attribute__((weak, noreturn, optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
> +void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_stack_protector _start(void)
>

Great, it works and it is minimal enough ;-)

Thanks very much.

> > 
> > Willy, I'm not sure if the issues solved by the commit 7f8548589661
> > ("tools/nolibc: make compiler and assembler agree on the section around
> > _start") still exist after we using _start_c()?
> > 
> > Thomas, because we plan to move the stackprotector init to _start_c(), If using
> > pure assembly _start, we may also not need the __no_stack_protector macro too?
> 
> It would probably not needed anymore in this case.
>

Yeah, but let's reserve it as-is for we have the working
omit-frame-pointer now.

Best regards,
Zhangjin

> Thomas
