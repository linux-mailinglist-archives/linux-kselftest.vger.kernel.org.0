Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A1E77989F
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Aug 2023 22:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbjHKUd5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Aug 2023 16:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjHKUd5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Aug 2023 16:33:57 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B747618B;
        Fri, 11 Aug 2023 13:33:55 -0700 (PDT)
X-QQ-mid: bizesmtp88t1691786030ts4c8dvh
Received: from linux-lab-host.localdomain ( [116.30.128.116])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 12 Aug 2023 04:33:49 +0800 (CST)
X-QQ-SSF: 01200000002000E0X000B00A0000000
X-QQ-FEAT: +ynUkgUhZJl3WY6C5uvcvVVodeorT98CN4gBSPLs8ljQvf3SUgVweUZ5odeml
        jBoWGtzPGyigtk2lzzaV7dxp7YDXE01eLeKimDced/7TqZeA5MPIXnVYtl7X7Yc70WHEHT9
        oiSr6ElMCxKbjQupSBxnAp0jY7+jQL64ADS4h8g7YttibF5eRAxDTxOjNZ03RheQ4nQMqR8
        iR+6GG/xBozmKozu0CMuk7+4aKKhj0kESIDRfcuAJvIj9N1bs/IAwLvaW4MgfaEK9A4Ouw1
        4wVjmg/GcO2mePQLGWdPVuVl5m7ZWm40EqkqpNtpDUN4gxHz1aic0MilaOmfiMI6zIAPYaw
        Ulfngh8zC1LMBSK6aVyEIiEPKyJOzYI8ugrt/qxlFQdSQXIgydbsCeo5vnZ/I9Q+HVqUkUV
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17079127722739655232
From:   Zhangjin Wu <falcon@tinylab.org>
To:     falcon@tinylab.org, w@1wt.eu
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tanyuan@tinylab.org, thomas@t-8ch.de
Subject: [PATCH v2 6/7] selftests/nolibc: import cc-cross-prefix macro
Date:   Sat, 12 Aug 2023 04:33:48 +0800
Message-Id: <ed99c37b653b909348a7e99e5fc51cf676008002.1691783604.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1691783604.git.falcon@tinylab.org>
References: <cover.1691783604.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

cc-cross-prefix is required to return first <prefix> where a <prefix>gcc
is found in PATH, this allows to customize more than one cross compiler.

Since scripts/Makefile.compiler provides cc-option too, let's use it
instead of tools/build/Build.include.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 9a787fdf9842..7687988c780b 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for nolibc tests
-# We need this for the "cc-option" macro.
-include ../../../build/Build.include
+# We need this for the "cc-option" and "cc-cross-prefix" macros.
+include ../../../../scripts/Makefile.compiler
 
 # we're in ".../tools/testing/selftests/nolibc"
 ifeq ($(srctree),)
-- 
2.25.1

