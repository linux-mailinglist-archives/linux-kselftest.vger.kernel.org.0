Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17969721E96
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jun 2023 08:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjFEGz3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 02:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjFEGz2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 02:55:28 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF592E9;
        Sun,  4 Jun 2023 23:55:20 -0700 (PDT)
X-QQ-mid: bizesmtp75t1685948110tj3ia4jc
Received: from linux-lab-host.localdomain ( [61.141.77.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 05 Jun 2023 14:55:09 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: L0h5767YwF7UouhZzhBXRX0J562z4mUQF/JwTWKNazvGipvhUulKq4xIkj7LR
        rGYqbiKejXCJRm9OO38WToeR8vgorbsgvCzKbe7x3dLf3w8/Pbt6Oca5ph0NXLYk3m18W5q
        HQhS4qt73pq0qu21Ii7nuvMT4ePnsvJ9oLnofCcL43Wfi0slj9dT5cBidHaA340DOM83Xpx
        XJ4T1DcJO1d7KEcrnhFLcMuowaEEJTEZvz8KGw4CBuHCRaAQ4x6n/kBZzFqscvr8Qf9Ac8T
        4DkWW6a+7pbxpCd3aumbhdiA40RpcUJODeQsfbUDUKFnNscJqL3k21Xm5rUt6ycUp6d+Eik
        yWJrsR6bAdss3QbnejPFsBdI3sJm9CjUV48Lh8u9A251MTegrBxyPdKPVzUXehTL+Ec6zPS
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14854381511492938161
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: Re: [PATCH 1/4] selftests/nolibc: add a test-report target
Date:   Mon,  5 Jun 2023 14:54:59 +0800
Message-Id: <20230605065459.153001-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZH1iDne+PiyZmIIB@1wt.eu>
References: <ZH1iDne+PiyZmIIB@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> On Mon, Jun 05, 2023 at 11:48:52AM +0800, Zhangjin Wu wrote:
> > A standalone test-report target is added to let the run, run-user and
> > rerun targets share them.
> > 
> > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > ---
> >  tools/testing/selftests/nolibc/Makefile | 26 ++++++++++++-------------
> >  1 file changed, 13 insertions(+), 13 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> > index be4159837494..8149ace2938a 100644
> > --- a/tools/testing/selftests/nolibc/Makefile
> > +++ b/tools/testing/selftests/nolibc/Makefile
> > @@ -127,14 +127,18 @@ nolibc-test: nolibc-test.c sysroot/$(ARCH)/include
> >  libc-test: nolibc-test.c
> >  	$(QUIET_CC)$(CC) -o $@ $<
> >  
> > -# qemu user-land test
> > -run-user: nolibc-test
> > -	$(Q)qemu-$(QEMU_ARCH) ./nolibc-test > "$(CURDIR)/run.out" || :
> > +test-report:
> >  	$(Q)awk '/\[OK\]$$/{p++} /\[FAIL\]$$/{f++} /\[SKIPPED\]$$/{s++} \
> >  	         END{ printf("%d test(s) passed, %d skipped, %d failed.", p, s, f); \
> >  	         if (s+f > 0) printf(" See all results in %s\n", ARGV[1]); else print; }' \
> >  	         $(CURDIR)/run.out
> >  
> > +# qemu user-land test
> > +_run-user: nolibc-test
> > +	$(Q)qemu-$(QEMU_ARCH) ./nolibc-test > "$(CURDIR)/run.out" || :
> > +
> > +run-user: _run-user test-report
> > +
> 
> This will not reliably work, there's no ordering here, nothing guarantees
> that test-report will run *after* _run-user (e.g. make -j). Another
> approach is needed if you want to factor this, but in general creating
> sequences in makefiles is difficult and often more painful than having
> 3 times the same 3 lines.
>

Ok, thanks, what about this?

    # LOG_REPORT: report the test results
    LOG_REPORT   := awk '/\[OK\][\r]*$$/{p++} /\[FAIL\][\r]*$$/{f++} /\[SKIPPED\][\r]*$$/{s++} \
	                 END{ printf("%d test(s) passed, %d skipped, %d failed.", p, s, f); \
	                 printf(" See all results in %s\n", ARGV[1]); }'

    run-user: nolibc-test
	$(Q)qemu-$(QEMU_ARCH) ./nolibc-test > "$(CURDIR)/run.out" || :
	$(Q)$(LOG_REPORT) $(CURDIR)/run.out

    run: kernel
	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
	$(Q)$(LOG_REPORT) $(CURDIR)/run.out

    rerun:
	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
	$(Q)$(LOG_REPORT) $(CURDIR)/run.out

Or we directly add a standalone test report script? something like
tools/testing/selftests/nolibc/report.sh

    #!/bin/sh
    #
    # report.sh -- report the test results of nolibc-test
    #
    
    LOG_FILE=$1
    [ ! -f "$LOG_FILE" ] && echo "Usage: $0 /path/to/run.out"
    
    awk '
        /\[OK\][\r]*$$/{ p++ }
        /\[FAIL\][\r]*$$/{ f++ }
        /\[SKIPPED\][\r]*$$/{ s++ }
    
        END {
            printf("%d test(s) passed, %d skipped, %d failed.", p, s, f);
            printf(" See all results in %s\n", ARGV[1]);
        }' $LOG_FILE

And use it like this:

    LOG_REPORT           = $(CURDIR)/report.sh

Best regards,
Zhangjin

> Willy
