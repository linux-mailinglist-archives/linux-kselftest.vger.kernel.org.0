Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1B278D0FF
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Aug 2023 02:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240475AbjH3ATv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Aug 2023 20:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239650AbjH3AT2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Aug 2023 20:19:28 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3B4CC2;
        Tue, 29 Aug 2023 17:19:24 -0700 (PDT)
X-QQ-mid: bizesmtp69t1693354749tb8gq4a3
Received: from linux-lab-host.localdomain ( [116.30.128.193])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 30 Aug 2023 08:19:08 +0800 (CST)
X-QQ-SSF: 01200000000000E0Y000000A0000000
X-QQ-FEAT: eSZ1CZgv+JAb43YTsBht9nBLTJXakZf6pgIevFZYF5gwzXowFXWdBl91vSn1i
        llAknDaveprWC/0A+UrYAA9dUcmdXsaeEDKGSmpbAn1hBHPkllX1G7wlwGgZ93I7JB+jUTy
        Tk8i5wKmaPhtbX1LhrH4c+QQawyZ61WDAb+33U+MfkCGa9h86nfGEtWj2/1CwJDR+wcYJku
        MfomlPhdwDkIiAfLTBuyn++DXx2+jYUWkMtfLOXMfwn6aeac2G9apcshcL3Q9xswksVRACs
        ECpvo9q4Zy39lVaSrqGDoLHmx7Y4iN6ftuMjmCO1tPlptn4GR6aAq6TcH/VsuMtZ56h5eZo
        cR4xmOvY1sC955u7g2HHt5bEdtB+t1euizuB0YhYosByx5uoh+u1/RmL9jh/A==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6397908649122061680
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, david.laight@aculab.com, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tanyuan@tinylab.org, thomas@t-8ch.de
Subject: Re: [RFC] tools/nolibc: replace duplicated -ENOSYS return with single -ENOSYS return
Date:   Wed, 30 Aug 2023 08:19:07 +0800
Message-Id: <20230830001907.67499-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZO2QWPYpo1fdXjX+@1wt.eu>
References: <ZO2QWPYpo1fdXjX+@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Thomas, Willy and David

> Hi all,
> 
> On Sun, Aug 27, 2023 at 11:17:19AM +0200, Thomas Weißschuh wrote:
> > To be honest I don't see a problem with the current aproach.
> > It is very obvious what is going on, the same pattern is used by other
> > projects and the "overhead" is very small.
> > 
> > 
> > It seems the macros will only work for simple cases which only test the
> > availability of a single syscall number.
> >

Good news, as I just replied [1] and as the test [2] shows, the
__stringify() based __is_nr_defined() macro (proposed in this RFC
thread) can test syscall definition for us, and the __stringify() and
__nrtoi() macro (Derive from David's NR_toi() work [3],[4]) based
__get_nr() macro can get the syscall number constant, both of them are
compiling stage cost and the compiling is not slow for all of the
current supported architectures, no size cost no runtime cost and even
help us to get smaller binary ;-)

[1]: https://lore.kernel.org/lkml/20230829233912.63097-1-falcon@tinylab.org/
[2]: https://godbolt.org/z/a7hxWj83E
[3]: https://lore.kernel.org/lkml/6819b8e273dc44e18f14be148549b828@AcuMS.aculab.com/
[4]: https://godbolt.org/z/rear4c1hj

> > Of these we currently only have:
> > gettimeofday(), lseek(), statx(), wait4()
> > 
> > So in it's current form we save 4 * 4 = 16 lines of code.
> > The proposed solution introduces 14 + 2 (empty) = 16 lines of new code,
> > and a bunch of mental overhead.
> >

Yes, as also suggested by Willy, the old proposed method redefined
NOLIBC__NR_* macros for every __NR_* and it must be avoided, and now,
the __is_nr_defined() and __get_nr() macros will simply avoid defining
new NOLIBC__NR_* for exisitng __NR_*, they can be used to test and get
the existing __NR_* directly.

In my local repo, we have saved 500+ lines ;-)

    $ git show nolibc/next:tools/include/nolibc/sys.h | wc -l
    1190
    $ cat tools/include/nolibc/sys.h | wc -l
    690

Including all of the -ENOSYS and #ifdef's:

    $ git grep -r ENOSYS nolibc/next:tools/include/nolibc/sys.h | wc -l
    17
    $ git grep -Er "#ifdef|#el|#endif" nolibc/next:tools/include/nolibc/sys.h | wc -l
    77

> > In case multiple underlying syscalls can be used these take different
> > arguments which a simple macro won't be able to encode sanely.
> 
> I totally agree, I would prefer all this to be manageable by humans with
> no preprocessor brain implant as much as possible as well.
>

Yeah, for the sys_* definitions, it is ok for us to use explicit arguments
intead of the '...'/__VA_ARGS__ to avoid losing some arguments sometimes, let's
do it in the RFC patchset but it should come after the tinyconfig patchset.

BTW, Willy, when will you prepare the branch for v6.7 developmlent? ;-)

Thanks,
Zhangjin

> Thanks,
> Willy
