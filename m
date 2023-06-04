Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8058F7214D1
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Jun 2023 07:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjFDFdn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 4 Jun 2023 01:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjFDFdm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 4 Jun 2023 01:33:42 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9B3CE;
        Sat,  3 Jun 2023 22:33:36 -0700 (PDT)
X-QQ-mid: bizesmtp83t1685856800t6hsp1hm
Received: from linux-lab-host.localdomain ( [61.141.77.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 04 Jun 2023 13:33:19 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: d1972br3SUxKhQs1ZN+1eZz5TyaxPW6VlL+DPYe/HQljaUpBS3ieDCvjI2Kp9
        2AyxX93pBGpl0L+rqRaO7q1KtZauN1SsCeYRWjeLZ35mn9OkC0FEAZFCyMLg+fHS4y7KhRk
        xJO/Ri0VtJnFgiDeeVYCglGWaWHMQgpEKJut1S3nAm6aswPIcMuxy18ssPBBwR6l3pWkQnC
        vgrgqEzqRML8kjhXl5GetHcUcjz1JguABoILnGic6ziWloi2cfwIVpEQblUR4gwVYLVR8Xd
        u1XDHBFOOJv1acYFPZ8VOCAg1apHaCxPZdfGMLbkljxdDGevI90Y6D7vvzehr3PgoYYWx/+
        GdlyHCBLyAnXOkIFegBEM/GQlOP2w==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3802795509129627829
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: [PATCH 0/4] tools/nolibc: add two new syscall helpers
Date:   Sun,  4 Jun 2023 13:33:09 +0800
Message-Id: <cover.1685856497.git.falcon@tinylab.org>
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

When I worked on adding new syscalls and the related library routines,
I have seen most of the library routines share the same syscall call and
return logic, this patchset adds two macros to simplify and shrink them.

All of them have been tested on arm, aarch64, rv32 and rv64, no new
regressions found.

If this is ok, I will rebase the new syscalls and library routines on
this patchset.

Best regards,
Zhangjin
---

Zhangjin Wu (4):
  tools/nolibc: unistd.h: add __syscall() and __syscall_ret() helpers
  tools/nolibc: unistd.h: apply __syscall_ret() helper
  tools/nolibc: sys.h: apply __syscall_ret() helper
  tools/nolibc: sys.h: apply __syscall() helper

 tools/include/nolibc/sys.h    | 369 ++++++----------------------------
 tools/include/nolibc/unistd.h |  12 +-
 2 files changed, 65 insertions(+), 316 deletions(-)

-- 
2.25.1

