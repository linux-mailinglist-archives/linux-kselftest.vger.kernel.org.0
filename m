Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E53474C7D7
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Jul 2023 21:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjGIT1H (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 9 Jul 2023 15:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGIT1G (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 9 Jul 2023 15:27:06 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DB2106;
        Sun,  9 Jul 2023 12:27:03 -0700 (PDT)
X-QQ-mid: bizesmtp83t1688930813tn0i8p93
Received: from linux-lab-host.localdomain ( [116.30.131.119])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 10 Jul 2023 03:26:52 +0800 (CST)
X-QQ-SSF: 01200000002000D0W000B00A0000000
X-QQ-FEAT: vrqOr+ppv0sryXf2k6SnOdQCp8VRyo8lgbZFpTqlzQlwYnf8cQLvIdc86100n
        rQ0WsB5yWAND7wsEMpim3/Km0k1MKBmkrgSZ2vYfIWBIgbXqvIcYULu2Sra7JR3dIILJUs2
        fNC7IUzjj8fw36PDe7Os+0d/pQbT+cocqgZh9deIhOJtUn8oUotNmToikrpTjEmrDORNOXY
        c8yHyl+uHS0Lb5iELbRVHJ65JnhZsjfDnbLxNJ+nc/uimL2R6FvvKWhqju+V/R2T70R3mqI
        YNovpkJ8z7/SqyDASdDadxQ1x5hV5i9G+ZQ62dLsXfdcWxnujh6i5Z8rFP+86g9NVSYuD52
        NkLUuowfX7mCMDhzxtEVoc/DDQOtxpcs75XB1bLkAns6cpmOUKEHy5rQDlFZw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8702714192543244913
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v1 4/5] selftests/nolibc: report: extrude the test status line
Date:   Mon, 10 Jul 2023 03:26:52 +0800
Message-Id: <20230709192652.97668-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230709085453.GB9321@1wt.eu>
References: <20230709085453.GB9321@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy

> On Thu, Jul 06, 2023 at 05:11:17PM +0800, Zhangjin Wu wrote:
> > two newlines are added around the test summary line to extrude the test
> > status.
> 
> But then we're back to making it annoying to check, having to figure
> if we need to grep -A or grep -B etc. With grep 'status:' we would get
> a synthetic status and the counters together. Why do you think it's
> not convenient ? Or am I the only one considering it useful to just
> run grep "status:" on all output files and figure a global status at
> once ?

Sorry, Willy, my commit message may mislead you a little.

The newlines are added around the whole test summary line (with the
status info), not only around the 'status info' ;-)

An example is added in our cover-letter (use '%3d' instead of '%03d'
here):

    ...
                                                 <-- newline here -->
    138 test(s): 135 passed,   2 skipped,   1 failed => status: failure
                                                 <-- newline here -->
    See all results in /labs/linux-lab/src/linux-stable/tools/testing/selftests/nolibc/run.out

Or:

    ...
                                                 <-- newline here -->
    137 test(s): 134 passed,   3 skipped,   0 failed => status: warning
                                                 <-- newline here -->
    See all results in /labs/linux-lab/src/linux-stable/tools/testing/selftests/nolibc/run.out

It is not for status grep, it is for developers to easily see the whole
summary line at a glance (I should add this in the commit message),
especially when we run tests for lots of architectures one by one
automatically, during the tests running, these newlines may help us to
see the status at a glance.

And further, if not consider pure-text, the colors may be more helpful,
for example, red for failed/failure, yellow for skipped/warning, green
for passed/success, for example:

    $ echo | awk 'END{printf("138 test(s): \033[32m135\033[0m passed, \033[33m  2\033[0m skipped, \033[31m  1\033[0m failed => status: \033[31mfailure\033[0m\n");}'
    138 test(s): 135 passed,   2 skipped,   1 failed => status: failure

But as we can see, the color control code is not readable and it may
break the simple "status: failure" grep, we should use something like
"status: .*failure" ;-)

It is possible to filter out the color info in the last run.out and only
reserve the colors info in the console.

    $ cat run.tmp.out | sed 's/\x1b\[[0-9;]*m//g' | col -bp > run.out

As a summary, the "status info grep" you proposed is very helpful to
summarize all of the tests after the testing finish, I do like it:

    $ grep "status: " /path/to/all/run.out
    138 test(s): 135 passed,   2 skipped,   1 failed => status: failure
    137 test(s): 134 passed,   3 skipped,   0 failed => status: warning

And these newlines (and even further with colors) are added to help
developers to see what happens during the tests running at a glance.

Thanks,
Zhangjin

> 
> Willy
