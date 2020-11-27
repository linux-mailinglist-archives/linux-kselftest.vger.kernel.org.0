Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C60C2C5EE8
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Nov 2020 04:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392325AbgK0DRJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Nov 2020 22:17:09 -0500
Received: from mail.loongson.cn ([114.242.206.163]:42082 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388759AbgK0DRI (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Nov 2020 22:17:08 -0500
Received: from bogon.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx_9Kqb8Bf+EsXAA--.52755S2;
        Fri, 27 Nov 2020 11:16:58 +0800 (CST)
From:   Xingxing Su <suxingxing@loongson.cn>
To:     Christian Brauner <christian@brauner.io>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2] selftests/clone3: Fix build error
Date:   Fri, 27 Nov 2020 11:16:57 +0800
Message-Id: <1606447017-10640-1-git-send-email-suxingxing@loongson.cn>
X-Mailer: git-send-email 2.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Dx_9Kqb8Bf+EsXAA--.52755S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XFW3ur18ury8WryDZF1xGrg_yoWkAFXEkw
        srKrn7u390va1kZr4SqFZ5Jryvyw4agrs8JF1YqF43Ja4DA3Z8G3WDXr1DAa18WwsIvryS
        vFs5uF1fAr4jkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb2kYjsxI4VWkKwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkIecxEwVAFwVW8GwCF04k2
        0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
        AIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
        x4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU5_xhJUUUUU==
X-CM-SenderInfo: pvx0x0xj0l0wo6or00hjvr0hdfq/1tbiAQANC13QvMr+VAAHsR
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When compiling the selftests with the -std=gnu99 option the build can
fail with.

Following build error:

  test_core.c: In function ‘test_cgcore_destroy’:
  test_core.c:87:2: error: ‘for’ loop initial declarations are only
  allowed in C99 mode
    for (int i = 0; i < 10; i++) {
    ^
  test_core.c:87:2: note: use option -std=c99 or -std=gnu99 to compile

Add -std=gnu99 to the clone3 selftest Makefile to fix this.

Signed-off-by: Xingxing Su <suxingxing@loongson.cn>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 tools/testing/selftests/clone3/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/clone3/Makefile b/tools/testing/selftests/clone3/Makefile
index ef7564c..88354a8 100644
--- a/tools/testing/selftests/clone3/Makefile
+++ b/tools/testing/selftests/clone3/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-CFLAGS += -g -I../../../../usr/include/
+CFLAGS += -g -std=gnu99 -I../../../../usr/include/ 
 LDLIBS += -lcap
 
 TEST_GEN_PROGS := clone3 clone3_clear_sighand clone3_set_tid \
-- 
1.8.3.1

