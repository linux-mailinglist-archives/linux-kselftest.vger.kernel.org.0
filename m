Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFFB7460AB
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jul 2023 18:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjGCQY0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Jul 2023 12:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjGCQYZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Jul 2023 12:24:25 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652FDAD;
        Mon,  3 Jul 2023 09:24:23 -0700 (PDT)
X-QQ-mid: bizesmtp67t1688401452tgj7f4a7
Received: from linux-lab-host.localdomain ( [119.123.131.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 04 Jul 2023 00:24:11 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: D2GZf6M6C/hH0l4kCU7hMc924/RcPhXPmkWT1yB3BBWKtKAO0pLuY5DdbvH8x
        Pv6apJoufyBtte0bfkRP9t12DoJyQY9PCs+ZHTw5Rd3de6p8fo95noBbHdaNC+rxtjil1js
        XJo7NOnn8bYy4BBHXfOEJM780LruGVWDSVaULv3Ir99bPmPYqFkozTmi7/e9wcvwjSZA9qu
        ogt2VX5hNGs5aKP+A0RqmKfZWPevp/Gdda3PecuhZ2WYupuFH8ZhZqJuol0vZcxt7BlvRva
        s7X5h72shMJuatJATryiItOnMgCsz0WKm4h+VlrH1yvNt9I9pLTUfAJ637d5IQPZyZ7hwaE
        hszDOjMisWMRDwV1Tk=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6504902335280427982
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v2 0/3] selftests/nolibc: improve test report support
Date:   Tue,  4 Jul 2023 00:24:10 +0800
Message-Id: <20230703162410.502173-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230702164358.GB16233@1wt.eu>
References: <20230702164358.GB16233@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> Hi Zhangjin,
> 
> On Mon, Jun 19, 2023 at 02:52:31PM +0800, Zhangjin Wu wrote:
> > Hi, Willy
> > 
> > Here is the v2 of our old patchset about test report [1].
> > 
> > The trailing '\r' fixup has been merged, so, here only resend the left
> > parts with an additional patch to restore the failed tests print.
> > 
> > This patchset is rebased on the dev.2023.06.14a	branch of linux-rcu [2].
> > 
> > Tests have passed for 'x86 run':
> > 
> >     138 test(s) passed, 0 skipped, 0 failed.
> >     See all results in /labs/linux-lab/src/linux-stable/tools/testing/selftests/nolibc/run.out
> (...)
> > 2. selftests/nolibc: always print the path to test log file
> > 
> >   Always print the path to test log file, but move it to a new line to
> >   avoid annoying people when the test pass without any failures.
> 
> I'm still really missing the (s+f > 0) test I added which was a time saver
> for me, because I could trivially check in the output reports which ones
> were totally OK and which ones required attention. Sure I could also start
> to grep for "passed," | grep -v " 0 skipped, 0 failed" but that's quite a
> pain, really.
> 
> I'm going to merge your series anyway otherwise we'll continue to bikeshed
> for many weeks and I know how annoying it is to keep unmerged series. But
> I would like that we find a solution that satisfies everyone.
> 
> Maybe one possibility would be to add a "status" at the end of the line
> that emits "success", "warning", "failure" depending on the highest level
> reached like this:
> 
>       138 test(s) passed, 0 skipped, 0 failed => status: success
>       136 test(s) passed, 2 skipped, 0 failed => status: warning
>       136 test(s) passed, 1 skipped, 1 failed => status: failure
> 
> This way it's easy to grep -v "status: success" or grep "status: failure"
> to instantly get the corresponding details and also grep for them from
> multiple files.

Ok, it will be a further step, based on your new awk script, it is not
that hard.

This should work:

    REPORT  ?= awk '/\[OK\][\r]*$$/{p++} /\[FAIL\][\r]*$$/{f++;print} /\[SKIPPED\][\r]*$$/{s++} \
                END{ printf("\n%d test(s): %d passed, %d skipped, %d failed => status: ", p+s+f, p, s, f); \
                if (f) printf("failure\n"); else if (s) printf("warning\n"); else printf("success\n");; \
                printf("\nSee all results in %s\n", ARGV[1]); }'

It reports something like this:

    ...
    Total number of errors: 0
    Exiting with status 0

    143 test(s): 140 passed, 3 skipped, 0 failed => status: warning

    See all results in /labs/linux-lab/src/linux-stable/tools/testing/selftests/nolibc/build/x86/run.out

Two newlines are added around the summary line, so, it is not crowded as
before. If this is ok, will send a new patch on your new branch.

Thanks very much.

Best regards,
Zhangjin

> 
> Thanks!
> Willy
