Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA201725FCF
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jun 2023 14:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235708AbjFGMqR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jun 2023 08:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbjFGMqQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jun 2023 08:46:16 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7FDC6E6B;
        Wed,  7 Jun 2023 05:46:14 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 357Cjhfj003458;
        Wed, 7 Jun 2023 14:45:43 +0200
Date:   Wed, 7 Jun 2023 14:45:43 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: Re: [PATCH 1/4] selftests/nolibc: add a test-report target
Message-ID: <ZIB792FtG6ibOudp@1wt.eu>
References: <20230605065459.153001-1-falcon@tinylab.org>
 <20230607055200.667447-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607055200.667447-1-falcon@tinylab.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Zhangjin,

On Wed, Jun 07, 2023 at 01:52:00PM +0800, Zhangjin Wu wrote:
> Hi, Willy
> 
> > > On Mon, Jun 05, 2023 at 11:48:52AM +0800, Zhangjin Wu wrote:
> > > > A standalone test-report target is added to let the run, run-user and
> > > > rerun targets share them.
> > > > 
> > > > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > > > ---
> > > >  tools/testing/selftests/nolibc/Makefile | 26 ++++++++++++-------------
> > > >  1 file changed, 13 insertions(+), 13 deletions(-)
> > > > 
> > > > diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> > > > index be4159837494..8149ace2938a 100644
> > > > --- a/tools/testing/selftests/nolibc/Makefile
> > > > +++ b/tools/testing/selftests/nolibc/Makefile
> > > > @@ -127,14 +127,18 @@ nolibc-test: nolibc-test.c sysroot/$(ARCH)/include
> > > >  libc-test: nolibc-test.c
> > > >  	$(QUIET_CC)$(CC) -o $@ $<
> > > >  
> > > > -# qemu user-land test
> > > > -run-user: nolibc-test
> > > > -	$(Q)qemu-$(QEMU_ARCH) ./nolibc-test > "$(CURDIR)/run.out" || :
> > > > +test-report:
> > > >  	$(Q)awk '/\[OK\]$$/{p++} /\[FAIL\]$$/{f++} /\[SKIPPED\]$$/{s++} \
> > > >  	         END{ printf("%d test(s) passed, %d skipped, %d failed.", p, s, f); \
> > > >  	         if (s+f > 0) printf(" See all results in %s\n", ARGV[1]); else print; }' \
> > > >  	         $(CURDIR)/run.out
> > > >  
> > > > +# qemu user-land test
> > > > +_run-user: nolibc-test
> > > > +	$(Q)qemu-$(QEMU_ARCH) ./nolibc-test > "$(CURDIR)/run.out" || :
> > > > +
> > > > +run-user: _run-user test-report
> > > > +
> > > 
> > > This will not reliably work, there's no ordering here, nothing guarantees
> > > that test-report will run *after* _run-user (e.g. make -j). Another
> > > approach is needed if you want to factor this, but in general creating
> > > sequences in makefiles is difficult and often more painful than having
> > > 3 times the same 3 lines.
> > >
> > 
> > Ok, thanks, what about this?
> > 
> >     # LOG_REPORT: report the test results
> >     LOG_REPORT   := awk '/\[OK\][\r]*$$/{p++} /\[FAIL\][\r]*$$/{f++} /\[SKIPPED\][\r]*$$/{s++} \
> > 	                 END{ printf("%d test(s) passed, %d skipped, %d failed.", p, s, f); \
> > 	                 printf(" See all results in %s\n", ARGV[1]); }'
> > 
> >     run-user: nolibc-test
> > 	$(Q)qemu-$(QEMU_ARCH) ./nolibc-test > "$(CURDIR)/run.out" || :
> > 	$(Q)$(LOG_REPORT) $(CURDIR)/run.out
> > 
> >     run: kernel
> > 	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
> > 	$(Q)$(LOG_REPORT) $(CURDIR)/run.out
> > 
> >     rerun:
> > 	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
> > 	$(Q)$(LOG_REPORT) $(CURDIR)/run.out
> > 
> > Or we directly add a standalone test report script? something like
> > tools/testing/selftests/nolibc/report.sh
> > 
> >     #!/bin/sh
> >     #
> >     # report.sh -- report the test results of nolibc-test
> >     #
> >     
> >     LOG_FILE=$1
> >     [ ! -f "$LOG_FILE" ] && echo "Usage: $0 /path/to/run.out"
> >     
> >     awk '
> >         /\[OK\][\r]*$$/{ p++ }
> >         /\[FAIL\][\r]*$$/{ f++ }
> >         /\[SKIPPED\][\r]*$$/{ s++ }
> >     
> >         END {
> >             printf("%d test(s) passed, %d skipped, %d failed.", p, s, f);
> >             printf(" See all results in %s\n", ARGV[1]);
> >         }' $LOG_FILE
> > 
> > And use it like this:
> > 
> >     LOG_REPORT           = $(CURDIR)/report.sh
> >
> 
> I plan to renew this patchset, which one of the above methods do you
> prefer?

IFF it needs to be done I prefer the macro in the Makefile to avoid
depending on external scripts that are useless outside of the makefile.
BUT, my point remains that I adopted this so that I could quickly and
visually check that everything was OK. I'm fine with any other method
but I do not want to have to carefully read all these lines to make
sure I'm not mixing a "8" with a "0" (I'm mentioning this one because
it's exactly the one I had when I decided to add the extra values).
For example if you prepend "FAILURE: ", "WARNING: ", "SUCCESS: " in
front of these lines to summarize them depending on the highest level
encountered (success, skipped, failed), then I'm fine because it's
easy to check that all lines show the same word.

> For the always print statement:
> 
>     printf(" See all results in %s\n", ARGV[1]); }'

Then please put it on its own line without the leading space, this
will be even more readable.

> I will paste the reason why I need it, as mentioned in [1], if you still
> need a clean test report, I will give up this change ;-)

No worries, I don't want to be annoying if you need something, but I
don't want to be annoyed by changes either :-)

thanks,
Willy
