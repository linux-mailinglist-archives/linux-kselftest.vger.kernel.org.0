Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720E8770E05
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Aug 2023 08:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjHEGLS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 5 Aug 2023 02:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjHEGLR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 5 Aug 2023 02:11:17 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5764ED0;
        Fri,  4 Aug 2023 23:11:14 -0700 (PDT)
X-QQ-mid: bizesmtp64t1691215864tag61k2f
Received: from linux-lab-host.localdomain ( [116.30.131.233])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 05 Aug 2023 14:11:03 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: 8bAiRczmfHQKjO9A1xPL3JmyacwtRyy73Jl2Cs1iUKjm25LcZFMQudKWkiaFZ
        IJp6L5sal0Hp/oWyQxR9EDHA7nZqiySF6iI+A1CEN2Mvq5wOX9HcrkPaPf3s3Y+lLO53rJB
        GoHB/YNUR4z3ZoZwFyb+DBA0qFedj960y2VB4wKFb8wxuumbnMNxx7HUQeCoZYSSOP37w6s
        6dpqY28Jy+95HnUtTTsrUK7xI7eR6EBjUU5kkj1DFpVnUWb5AtGE3TLazK7nXJYLafcIUdU
        DQOGQ6mJamimV6zPoW6Fmi7LkGH5R291K6g9wInj2w+XHDyAD8lUMUK2QRk5GTMf+m0ypYj
        fhWumx98lefPMNh4s/GKxwRAHpp1UvJmvW5QlIeJofvXWHB+Z67I5SVJc8V7w==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17493183823704717070
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v2 1/3] selftests/nolibc: allow report with existing test log
Date:   Sat,  5 Aug 2023 14:11:02 +0800
Message-Id: <307eb92fa4c9b774d48732a1de34076d826d40eb.1691215074.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1691215074.git.falcon@tinylab.org>
References: <cover.1691215074.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

After the tests finish, it is valuable to report and summarize with
existing test log.

This avoid rerun or run the tests again when not necessary.

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 16cc33db54e3..51fef5e6a152 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -225,6 +225,10 @@ rerun:
 	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
 	$(Q)$(REPORT) $(CURDIR)/run.out
 
+# report with existing test log
+report:
+	$(Q)$(REPORT) $(CURDIR)/run.out
+
 clean:
 	$(call QUIET_CLEAN, sysroot)
 	$(Q)rm -rf sysroot
-- 
2.25.1

