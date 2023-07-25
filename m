Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0564F761879
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 14:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjGYMhn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 08:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbjGYMhl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 08:37:41 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7285C11A;
        Tue, 25 Jul 2023 05:37:39 -0700 (PDT)
X-QQ-mid: bizesmtp62t1690288646t6jdi2ss
Received: from linux-lab-host.localdomain ( [61.141.78.189])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 25 Jul 2023 20:37:25 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000000A0000000
X-QQ-FEAT: CR3LFp2JE4n/UXq5fwdJeBv7RRG370WMr4PjV0XGpJjDqWqFCTyP4Cv4tFGF3
        JQugoL6zG57Kn80OYBiAKbaMhyThfdKA6QevgJNq6ggmGgWdy8+03a/MJEmCF31zEptp8hr
        w9YBWEGim1io4MLiGWNB4iTuccAXqiHnhRwxpOvhHHqQU+LREhp50SOzfmWdqY4MXZZKocc
        gRtG82CpwEtnTPTrIm0DFj0bgyfWBSi8EM3YsHXwrgEQ1kt+EB2x672er+0j6uudhOdWhNi
        ujp4LSoVCdOhkmXBhD8qKp0RWZWiVaSDM1kUnYZpTsdaYGfQY9lHyamzpSNaJt9BVNCSA05
        Iq8uJ81hjmpopzlo3LGZHuFUxClK65AP3P3q1h5W0LxbmDhP7VYD2gJpzbyJIDcsMoHIPjI
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15160778282208324326
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v2 02/14] selftests/nolibc: add macros to enhance maintainability
Date:   Tue, 25 Jul 2023 20:37:25 +0800
Message-Id: <20230725123725.35508-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230722122009.GE17311@1wt.eu>
References: <20230722122009.GE17311@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy

> On Wed, Jul 19, 2023 at 09:19:10PM +0800, Zhangjin Wu wrote:
> > The kernel targets share the same kernel make operations, the same
> > .config file, the same kernel image, add MAKE_KERNEL, KERNEL_CONFIG and
> > KERNEL_IMAGE for them.
> > 
> > Many targets share the same logging related settings, let's add common
> > variables RUN_OUT, LOG_OUT and REPORT_RUN_OUT for them.
> > 
> > The qemu run/rerun targets share the same qemu system run command, add
> > QEMU_SYSTEM_RUN for them.
> > 
> > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > ---
> >  tools/testing/selftests/nolibc/Makefile | 41 ++++++++++++++++---------
> >  1 file changed, 27 insertions(+), 14 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> > index 0cd17de2062c..8c531518bb9f 100644
> > --- a/tools/testing/selftests/nolibc/Makefile
> > +++ b/tools/testing/selftests/nolibc/Makefile
> > @@ -166,45 +166,58 @@ endif
> >  libc-test: nolibc-test.c
> >  	$(QUIET_CC)$(CC) -o $@ $<
> >  
> > +# common macros for logging
> > +RUN_OUT = $(CURDIR)/run.out
> > +LOG_OUT = > "$(RUN_OUT)"
> > +REPORT_RUN_OUT = $(REPORT) "$(RUN_OUT)"
> > +
> >  # local libc-test
> >  run-libc-test: libc-test
> > -	$(Q)./libc-test > "$(CURDIR)/run.out" || :
> > -	$(Q)$(REPORT) $(CURDIR)/run.out
> > +	$(Q)./libc-test $(LOG_OUT) || :
> > +	$(Q)$(REPORT_RUN_OUT)
> 
> Sorry but I don't find that this improves maintainability, quite the
> opposite in fact. One reason is that you never visually expect that
> some shell indirection delimiters are hidden in a macro that seems
> to only convey a name. Sure there are valid use cases for this, but
> I think that here it's just adding too much abstraction and it makes
> it quite hard to unfold all of this mentally.
>

Ok, will reserve less ones as possible as we can.

- RUN_OUT is required for architecture specific output
- REPORT_RUN_OUT is not necessary, will remove it

> Please try to keep the number of macros to the minimum that needs to
> be replaced or forced by the user. Here I'm not seeing a compelling
> reason for a user to want to force LOG_OUT to something else. Also
> makefile macros are generally a pain to debug, which is another
> reason for not putting too many of them.
>
> I noticed that your next patch changes LOG_OUT to tee, it could have
> done it everywhere and wouldn't affect readability as much.
>

I have forgetten to pick an old patch to silence the running log like
this:

    ifeq ($(QUIET_RUN),1)
    LOG_OUT = > "$(RUN_OUT)"
    else
    LOG_OUT = | tee "$(RUN_OUT)"
    endif

Without QUIET_RUN, we can silence the running log with:

    $ make run LOG_OUT="> /dev/null"

It is not meaningful like QUIET_RUN, seems the QUIET_RUN is not
necessary for we have 'grep status' now, so, let's remove this RUN_OUT
too.

Thanks,
Zhangjin

> Thanks,
> Willy
