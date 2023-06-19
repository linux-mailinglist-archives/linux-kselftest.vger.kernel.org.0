Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B6F734BE1
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jun 2023 08:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjFSGwu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Jun 2023 02:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjFSGwt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Jun 2023 02:52:49 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F6313D;
        Sun, 18 Jun 2023 23:52:47 -0700 (PDT)
X-QQ-mid: bizesmtp90t1687157554t1cra7mz
Received: from linux-lab-host.localdomain ( [116.30.126.60])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 19 Jun 2023 14:52:33 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: znfcQSa1hKZ+NGpj3oD46dIA48fe5ZoaCtfXnjdgTtVrivNDEHeffwS9NNGjG
        t5B31cuxF/A7gM2Ih3CbXVlpH7UbdETPcQhNC1ycItKmtVm1oKQWXs4GTJkiSGgHgMOmlSS
        pNI0yQ0WeMraVLa+62zph4fBy4F3FSlco3tYkO7MH0tVAx0V6f5wmr4pNkrMj4v6LNlVss+
        0HXtNYaedqpkLqAfxjcWxMoBhfyeNegcuzhN32YDApzcS6eJqed+0OIMgvdgCOcIHiX5lYq
        TvgQXE8SOeX37vbCwnYNmOcgJyIyeLXAp3xXJdFnDmE/gNUZb8RGyV4CM49VsERrCOaz/b4
        ShgxfKy1tCGdKRvm0GMzScfysOmbw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5458119425882349837
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v2 0/3] selftests/nolibc: improve test report support
Date:   Mon, 19 Jun 2023 14:52:31 +0800
Message-Id: <cover.1687156559.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy

Here is the v2 of our old patchset about test report [1].

The trailing '\r' fixup has been merged, so, here only resend the left
parts with an additional patch to restore the failed tests print.

This patchset is rebased on the dev.2023.06.14a	branch of linux-rcu [2].

Tests have passed for 'x86 run':

    138 test(s) passed, 0 skipped, 0 failed.
    See all results in /labs/linux-lab/src/linux-stable/tools/testing/selftests/nolibc/run.out

Also did 'run-user' for x86, mips and arm64.

Changes from v1 -> v2:

1. selftests/nolibc: add a standalone test report macro

  As Willy pointed out, the old method with additional test-report
  target not work in 'make -j'.

  A new macro is added to share the same report logic among the
  run-user, run and rerun targets, the path to test log file is 

2. selftests/nolibc: always print the path to test log file

  Always print the path to test log file, but move it to a new line to
  avoid annoying people when the test pass without any failures.

3. selftests/nolibc: restore the failed tests print

  Restore printing of the failed tests to avoid manually opening
  the test log file when there are really failues.

Best regards,
Zhangjin
---
[1]: https://lore.kernel.org/lkml/cover.1685936428.git.falcon@tinylab.org/
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/

Zhangjin Wu (3):
  selftests/nolibc: add a standalone test report macro
  selftests/nolibc: always print the path to test log file
  selftests/nolibc: restore the failed tests print

 tools/testing/selftests/nolibc/Makefile | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

-- 
2.25.1

