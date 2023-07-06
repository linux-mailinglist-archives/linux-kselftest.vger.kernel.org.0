Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EB57497DB
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jul 2023 11:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjGFJCo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Jul 2023 05:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjGFJCn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Jul 2023 05:02:43 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8981BCC;
        Thu,  6 Jul 2023 02:02:41 -0700 (PDT)
X-QQ-mid: bizesmtp65t1688634149tsira3pq
Received: from linux-lab-host.localdomain ( [116.30.131.119])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 06 Jul 2023 17:02:28 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000D0000000
X-QQ-FEAT: ao4JQgu0M38y3uc6KtEbwrTWlrO+JT1upUbsZHhrCMGP5IRqZlq2musuDEDOF
        knS5fdAapJJpTmEZKXV/TSSRXaaGoxYx1lQPgrpQ+sxaF2kyOxd25t0DyhlcT9IBzOTJT/J
        5I8bfVfxFfNqxAwWw95jQiGoP5jMugZhO8gQAziZ5g+ItUzT7A3hH66DSswmeL7NYpHXjV7
        c3F5OMrhxRf+9EVQUgZdsgQ/0aChsIZzHh6uitt3Le4PGIohRhOCY0d+x61GHeGm76wYSkM
        siLRXuC001czUyNLOKC8E9wNJL5gfC5uI4p0roCmmvNAMFcCyjZgQToykvBbCoF7c4MEOeF
        lpVPPEzrrGq/iKIAbIeJ8B4xXb9Yw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15438509616964618945
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v1 0/5] selftests/nolibc: report: print test status
Date:   Thu,  6 Jul 2023 17:02:26 +0800
Message-Id: <cover.1688633188.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy

As you suggested, the 'status: [success|warning|failure]' info is added
to the summary line, with additional newlines around this line to
extrude the status info. at the same time, the total tests is printed,
the passed, skipped and failed values are aligned with '%03d'.

This patchset is based on 20230705-nolibc-series2 of nolibc repo[1].

The test result looks like:

    ...

    138 test(s): 135 passed, 002 skipped, 001 failed => status: failure

    See all results in /labs/linux-lab/src/linux-stable/tools/testing/selftests/nolibc/run.out

Or:

    ...

    137 test(s): 134 passed, 003 skipped, 000 failed => status: warning

    See all results in /labs/linux-lab/src/linux-stable/tools/testing/selftests/nolibc/run.out

Best regards,
Zhangjin
---
[1]: https://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git

Zhangjin Wu (5):
  selftests/nolibc: report: print a summarized test status
  selftests/nolibc: report: print total tests
  selftests/nolibc: report: align passed, skipped and failed
  selftests/nolibc: report: extrude the test status line
  selftests/nolibc: report: add newline before test failures

 tools/testing/selftests/nolibc/Makefile | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

-- 
2.25.1

