Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1390C721CA5
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jun 2023 05:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbjFEDr5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 4 Jun 2023 23:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjFEDr4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 4 Jun 2023 23:47:56 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47166B8;
        Sun,  4 Jun 2023 20:47:54 -0700 (PDT)
X-QQ-mid: bizesmtp63t1685936864tb85kr9l
Received: from linux-lab-host.localdomain ( [61.141.77.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 05 Jun 2023 11:47:43 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: eSZ1CZgv+JAkiW0WLlTVnyFb8aBGqFeHrro9ClP0k1VxgozEONHr/tXivy85R
        HUv28Cvp7643DzPRmHEbPpzEwOQV9Z9tBBtKCDbOb29+KGVRSn9wfzT+gCDCsJ5Ih3huCBW
        eEXSb4BCadz2oEgqMRw/29I7mphtLJAZwfWNRUtz6vk49DieJSejoLiAe6Rdu6PHvI7TDS0
        Ut3aA5ew8QyHGRi3xcrBqzFBEH+4adLWIvbkW21EobAH41lzogm1YU02S8f4ZEjtYGT4prL
        OlY3upYzrhDgsptlTj6MUL3uglgEemz4vPVwQJx+38zfDoLw1/S+yUC3UzGVask8ee4M3GO
        eXBBI94Yz87Ebt8CGw+eDSOxBsfXA==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7225117020602651360
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: [PATCH 0/4] selftests/nolibc: fix up and improve test report
Date:   Mon,  5 Jun 2023 11:47:41 +0800
Message-Id: <cover.1685936428.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy

Thanks very much for your merge of the v3 generic part1 of rv32, just
tested your latest 20230604-nolibc-rv32+stkp6 branch, everything work
well except a trivial test report regression on the 'run' target.

Besides the fixup, a standalone test-report target added to share them
among run, run-user and re-run and allow independent test report check
via direct 'make test-report'.

Best regards,
Zhangjin
---

Zhangjin Wu (4):
  selftests/nolibc: add a test-report target
  selftests/nolibc: allow run test-report directly
  selftests/nolibc: always print the log file
  selftests/nolibc: fix up test-report for run target

 tools/testing/selftests/nolibc/Makefile | 30 ++++++++++++-------------
 1 file changed, 15 insertions(+), 15 deletions(-)

-- 
2.25.1

