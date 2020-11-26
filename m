Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 807FF2C4F2A
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Nov 2020 08:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388291AbgKZHM0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Nov 2020 02:12:26 -0500
Received: from mail.loongson.cn ([114.242.206.163]:47450 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388278AbgKZHM0 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Nov 2020 02:12:26 -0500
Received: from bogon.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxitBOVb9fSuMWAA--.37576S2;
        Thu, 26 Nov 2020 15:12:15 +0800 (CST)
From:   Xingxing Su <suxingxing@loongson.cn>
To:     Christian Brauner <christian@brauner.io>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/clone3: Add gun99 to compile in Makefile.
Date:   Thu, 26 Nov 2020 15:12:14 +0800
Message-Id: <1606374734-12639-1-git-send-email-suxingxing@loongson.cn>
X-Mailer: git-send-email 2.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9AxitBOVb9fSuMWAA--.37576S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr45Gr4rJr4DXr4DJF4xZwb_yoWDJrcEkw
        s3Kws7urZYva1kZw4avFZ5Gr1vyw4a9rs8AF4YqF43Ja4qy3Z8G3WDXr1DAa18WrsIvryS
        vFs5uF13Jr4jkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb7AYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
        w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMc
        vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY02Avz4vE14v_GF4l42xK82IY
        c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0x
        vE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8X_-PUUUUU==
X-CM-SenderInfo: pvx0x0xj0l0wo6or00hjvr0hdfq/1tbiAQAMC13QvMrvhAABsX
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

CFLAGS add -std=gnu99.

Fllowing build error:

test_core.c: In function ‘test_cgcore_destroy’:
test_core.c:87:2: error: ‘for’ loop initial declarations are only
allowed in C99 mode
  for (int i = 0; i < 10; i++) {
  ^
test_core.c:87:2: note: use option -std=c99 or -std=gnu99 to compile
your code

Signed-off-by: Xingxing Su <suxingxing@loongson.cn>
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

