Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5702473D1FD
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 Jun 2023 18:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjFYQPH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 25 Jun 2023 12:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjFYQPF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 25 Jun 2023 12:15:05 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE7318E;
        Sun, 25 Jun 2023 09:15:04 -0700 (PDT)
X-QQ-mid: bizesmtp71t1687709694tuoksfxz
Received: from linux-lab-host.localdomain ( [116.30.129.193])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 26 Jun 2023 00:14:53 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: 3M0okmaRx3i2MOPnCI0DZtGYFOuu7wfpxwOZApJIBL9P6JET0xdK3TkWYCaDq
        ma+xXXNKIgM7SvfXg+wmihzPEHOJacQkejX+xsKp9znG3mfWK0KAlGIYOIWJ76861t6BE2X
        Ko59kt50r7bMB27RqUSdNnNcM3N99bI8UFDG+sfgKr6CYTw/QgS2RlZ5b3Mzvob6uY80tWx
        ufISYGlQFCsmji0qqnp5I6z+upiWdKU/Jk9plVPzzTsQpK/q/LGmHVNRBK1zIcpmdrYzuCi
        DC7sh1y9WihwxneGyHQVukRQR6g3egva+EcA/l1JukSC3ccQguTx95qM8ot8TKi6alBRTVy
        h+fyUFviFcdWz4uq1XSx+LPbjVr0CO8BzvYqPUsTmcI63JmyrE=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3414960781867070073
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v1 03/22] selftests/nolibc: allow use x86_64 toolchain for i386
Date:   Mon, 26 Jun 2023 00:14:39 +0800
Message-Id: <57f6d5abddf5b126589faedefbf25556939b093a.1687706332.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687706332.git.falcon@tinylab.org>
References: <cover.1687706332.git.falcon@tinylab.org>
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

Add extra '-m32 -Wl,-melf_i386' flags to tell x86_64 toolchains to
generate i386 executable.

This allows to use the same x86_64 toolchain for i386 architecture.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 3300b5ab7de3..f8be0de0ce0e 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -89,6 +89,7 @@ else
 Q=@
 endif
 
+CFLAGS_i386 = -m32 -Wl,-melf_i386
 CFLAGS_riscv32 = -march=rv32im -mabi=ilp32
 CFLAGS_s390 = -m64
 CFLAGS_mips = -EL
-- 
2.25.1

