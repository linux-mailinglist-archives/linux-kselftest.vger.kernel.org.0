Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E5477BED7
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Aug 2023 19:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjHNRXA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Aug 2023 13:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjHNRWz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Aug 2023 13:22:55 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6C710C1;
        Mon, 14 Aug 2023 10:22:53 -0700 (PDT)
X-QQ-mid: bizesmtp91t1692033755tkim2wmr
Received: from linux-lab-host.localdomain ( [116.30.128.116])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 15 Aug 2023 01:22:34 +0800 (CST)
X-QQ-SSF: 01200000000000E0Y000000A0000000
X-QQ-FEAT: vqhsT3OOnzR9LD9Gd1HPzic9UXiyfWbi6XYBGvCn5B7s21lPPnFfU0hrCl7Wh
        5Ezczu//vm9r7Gu49K9JEAVCQZoBrIlQ41AJEqhisxTGNOuwhI0g3b+/WqhyPgBUNdpAWd8
        zx/J190zV9UrAruxwe9UtUptv8RDRd8vuW819KCnlC712lE1P/054TzIXPy0VntY3p54fcQ
        x+rlVbgVUYwiqm/TfCO9TLHKu8Kh4B/LOmnAqW4Z0Rdrp9eBAI374MEfW105P5WPQcLNDyR
        zAAkXMzotrDLQM+QXs5YbS2odJ2Ru9P/5UU3h0iuxZzx2cl/22sExXDYHITwQuawo8LFIFZ
        Bw7zW7M70dIJlOyu5o=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3663684764056122485
From:   Zhangjin Wu <falcon@tinylab.org>
To:     falcon@tinylab.org
Cc:     arnd@arndb.de, david.laight@aculab.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        thomas@t-8ch.de, w@1wt.eu
Subject: Re: [PATCH v5] tools/nolibc: fix up size inflate regression
Date:   Tue, 15 Aug 2023 01:22:33 +0800
Message-Id: <20230814172233.225944-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230814104226.7094-1-falcon@tinylab.org>
References: <20230814104226.7094-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy

> [...]
> > > 
> > >     /* __systry2() is used to select one of two provided low level syscalls */
> > >     #define __systry2(a, sys_a, sys_b) \
> > >     	((NOLIBC__NR_##a != NOLIBC__NR_NOSYS) ? (sys_a) : (sys_b))
> > 
> > But this supposes that all of them are manually defined as you did above.
> > I'd rather implement an ugly is_numeric() macro based on argument
> > resolution. I've done it once in another project, I don't remember
> > precisely where it is but I vaguely remember that it used to check
> > that the string resolution of the argument gave a letter (when it
> > does not exist) or a digit (when it does). I can look into that later
> > if needed. But please avoid extra macro definitions as much as possible,
> > they're a real pain to handle in the code. There's no error when one is
> > missing or has a typo, it's difficult to follow them and they don't
> > appear in the debugger.
> >
> 
> Yeah, your reply inspired me to look into the IS_ENABLED() from
> ../include/linux/kconfig.h macro again, there was a __is_defined() there, let's
> throw away the ugly sysnr.h. I thought of IS_ENABLED() was only for y/n/m
> before, but it does return 0 when the macro is not defined, it uses the same
> trick in syscall() to calculate the number of arguments, if the macro is not
> defined, then, 0 "argument".
>

The above trick is only for ""#define something 1" ;-)

BR,
Zhangjin
