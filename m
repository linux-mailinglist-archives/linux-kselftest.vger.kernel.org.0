Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6317253B7
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jun 2023 07:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbjFGFwR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jun 2023 01:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbjFGFwQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jun 2023 01:52:16 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60C483;
        Tue,  6 Jun 2023 22:52:13 -0700 (PDT)
X-QQ-mid: bizesmtp70t1686117122tlw2aohn
Received: from linux-lab-host.localdomain ( [61.141.77.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 07 Jun 2023 13:52:00 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: 7L1V3dHhUFNwsCYRlWfHiijmi2tXCINUn3YioqGbuOxs/CPWofUR/InpqT49J
        9b0cchLC0VK3ORkZ/8q/onk4NKY4mNzZCJaxDJu+EyFMxF5re0ekuIoPMp5wFYl6tYBVEj8
        X+myOvogX1rqOB7aF76W6Mzr6O6jCfib+BpInN/83g+1nYuplhKIlCAzTuIphJG7c2RBfZq
        12wdO26wIO08Y5LDCswdjH0U/5OKBpmqob3d6XTTI4dW1JtPmxwC96SQ20EdkaxHaVXruKx
        nbF3H8KOyLwDs0GnIMlOFRpgQCNHFYDVt3wftQILgXQzRAHpOwlzSayojXwFnaYeVo9xapm
        78TRVoBIoJKAKQHPl7ejgG6RYWjp66ZUDiOvSCPrese08cpbFHlp1Yt+mOqVAV1qfC7P8Ye
        F+VzuWsvtfA=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18357036349121096708
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: Re: [PATCH 1/4] selftests/nolibc: add a test-report target
Date:   Wed,  7 Jun 2023 13:52:00 +0800
Message-Id: <20230607055200.667447-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230605065459.153001-1-falcon@tinylab.org>
References: <20230605065459.153001-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy

> > On Mon, Jun 05, 2023 at 11:48:52AM +0800, Zhangjin Wu wrote:
> > > A standalone test-report target is added to let the run, run-user and
> > > rerun targets share them.
> > > 
> > > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > > ---
> > >  tools/testing/selftests/nolibc/Makefile | 26 ++++++++++++-------------
> > >  1 file changed, 13 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> > > index be4159837494..8149ace2938a 100644
> > > --- a/tools/testing/selftests/nolibc/Makefile
> > > +++ b/tools/testing/selftests/nolibc/Makefile
> > > @@ -127,14 +127,18 @@ nolibc-test: nolibc-test.c sysroot/$(ARCH)/include
> > >  libc-test: nolibc-test.c
> > >  	$(QUIET_CC)$(CC) -o $@ $<
> > >  
> > > -# qemu user-land test
> > > -run-user: nolibc-test
> > > -	$(Q)qemu-$(QEMU_ARCH) ./nolibc-test > "$(CURDIR)/run.out" || :
> > > +test-report:
> > >  	$(Q)awk '/\[OK\]$$/{p++} /\[FAIL\]$$/{f++} /\[SKIPPED\]$$/{s++} \
> > >  	         END{ printf("%d test(s) passed, %d skipped, %d failed.", p, s, f); \
> > >  	         if (s+f > 0) printf(" See all results in %s\n", ARGV[1]); else print; }' \
> > >  	         $(CURDIR)/run.out
> > >  
> > > +# qemu user-land test
> > > +_run-user: nolibc-test
> > > +	$(Q)qemu-$(QEMU_ARCH) ./nolibc-test > "$(CURDIR)/run.out" || :
> > > +
> > > +run-user: _run-user test-report
> > > +
> > 
> > This will not reliably work, there's no ordering here, nothing guarantees
> > that test-report will run *after* _run-user (e.g. make -j). Another
> > approach is needed if you want to factor this, but in general creating
> > sequences in makefiles is difficult and often more painful than having
> > 3 times the same 3 lines.
> >
> 
> Ok, thanks, what about this?
> 
>     # LOG_REPORT: report the test results
>     LOG_REPORT   := awk '/\[OK\][\r]*$$/{p++} /\[FAIL\][\r]*$$/{f++} /\[SKIPPED\][\r]*$$/{s++} \
> 	                 END{ printf("%d test(s) passed, %d skipped, %d failed.", p, s, f); \
> 	                 printf(" See all results in %s\n", ARGV[1]); }'
> 
>     run-user: nolibc-test
> 	$(Q)qemu-$(QEMU_ARCH) ./nolibc-test > "$(CURDIR)/run.out" || :
> 	$(Q)$(LOG_REPORT) $(CURDIR)/run.out
> 
>     run: kernel
> 	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
> 	$(Q)$(LOG_REPORT) $(CURDIR)/run.out
> 
>     rerun:
> 	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
> 	$(Q)$(LOG_REPORT) $(CURDIR)/run.out
> 
> Or we directly add a standalone test report script? something like
> tools/testing/selftests/nolibc/report.sh
> 
>     #!/bin/sh
>     #
>     # report.sh -- report the test results of nolibc-test
>     #
>     
>     LOG_FILE=$1
>     [ ! -f "$LOG_FILE" ] && echo "Usage: $0 /path/to/run.out"
>     
>     awk '
>         /\[OK\][\r]*$$/{ p++ }
>         /\[FAIL\][\r]*$$/{ f++ }
>         /\[SKIPPED\][\r]*$$/{ s++ }
>     
>         END {
>             printf("%d test(s) passed, %d skipped, %d failed.", p, s, f);
>             printf(" See all results in %s\n", ARGV[1]);
>         }' $LOG_FILE
> 
> And use it like this:
> 
>     LOG_REPORT           = $(CURDIR)/report.sh
>

I plan to renew this patchset, which one of the above methods do you
prefer?

For the always print statement:

    printf(" See all results in %s\n", ARGV[1]); }'

I will paste the reason why I need it, as mentioned in [1], if you still
need a clean test report, I will give up this change ;-)

Thanks,
Zhangjin
---
[1]: https://lore.kernel.org/linux-riscv/20230605070508.153407-1-falcon@tinylab.org/ 

> Best regards,
> Zhangjin
>
> > Willy
