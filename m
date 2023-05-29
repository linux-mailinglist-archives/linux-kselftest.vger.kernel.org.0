Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64627149E3
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 May 2023 15:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjE2NJ3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 May 2023 09:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjE2NJ2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 May 2023 09:09:28 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B5291;
        Mon, 29 May 2023 06:09:26 -0700 (PDT)
X-QQ-mid: bizesmtp84t1685365756twqe4148
Received: from linux-lab-host.localdomain ( [119.123.130.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 29 May 2023 21:09:15 +0800 (CST)
X-QQ-SSF: 00200000000000D0V000000A0000000
X-QQ-FEAT: c42nD1GNGymYSx9zxbwKVxV026O2dZWRFqYx6VQqJt6skveeHg/nZbB/cHuZH
        yNePeKtpfxiGhlrCiFRwsT41pB2wFLQqVPZ421ScXWSPm8WuUHiCwKQ49QH9580QgRZllK6
        kAaElYyTFvBbXqR/lhLnOXSQU22pnZim6le3759YqTcbbL+WXrujyuMlMXr+Cv7uv5MfKF6
        nBKBBATqyNtj0st9oDj0zF6U8qzqutCKNead501b7xS5i8jYxBc+F1Kmsrh2H/3f4IEt1us
        tqatwCDcOYeFimS8rExKu652H6GDc/H/Xf8uMN37CFoDjdnnuyNoXEv2T9EAudaLLCF3+PA
        QCv95hQ/2kQXzkSSYDxg3fBIEf3ZGyBGoPJieoMnz2Vcro6q28=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16574069139898678745
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: [PATCH v2 7/7] tools/nolibc: open: fix up compile warning for arm
Date:   Mon, 29 May 2023 21:09:09 +0800
Message-Id: <63248d72857cd6e40f997b0893e865faeab2d40e.1685362482.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685362482.git.falcon@tinylab.org>
References: <cover.1685362482.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

    In function ‘open’:
    nolibc/sysroot/arm/include/sys.h:919:23: warning: ‘mode_t’ {aka ‘short unsigned int’} is promoted to ‘int’ when passed through ‘...’
      919 |   mode = va_arg(args, mode_t);
          |                       ^
    nolibc/sysroot/arm/include/sys.h:919:23: note: (so you should pass ‘int’ not ‘mode_t’ {aka ‘short unsigned int’} to ‘va_arg’)
    nolibc/sysroot/arm/include/sys.h:919:23: note: if this code is reached, the program will abort

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/sys.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 1d6f33f58629..154194056962 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -862,7 +862,7 @@ int open(const char *path, int flags, ...)
 		va_list args;
 
 		va_start(args, flags);
-		mode = va_arg(args, mode_t);
+		mode = va_arg(args, int);
 		va_end(args);
 	}
 
-- 
2.25.1

