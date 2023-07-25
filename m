Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574E2760E73
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 11:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbjGYJV1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 05:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbjGYJVD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 05:21:03 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6301BCF;
        Tue, 25 Jul 2023 02:20:30 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4R9BMX3KQ9z4f3xbF;
        Tue, 25 Jul 2023 17:20:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgA3n7LXk79kz98TOw--.50512S2;
        Tue, 25 Jul 2023 17:20:25 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     brendan.higgins@linux.dev, davidgow@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Cc:     shikemeng@huaweicloud.com
Subject: [PATCH] kunit: replace KUNIT_TRIGGER_STATIC_STUB maro with KUNIT_STATIC_STUB_REDIRECT
Date:   Wed, 26 Jul 2023 01:20:51 +0800
Message-Id: <20230725172051.2142641-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgA3n7LXk79kz98TOw--.50512S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr48uF13Zr1xAw4UWr47XFb_yoW8Zr1xpa
        s3CFykur1UJFs29FyxZFWktr1ak3y8JrWjyr43Ww4fuFW8Wr4xJa1DKrWrKw4UG3ykXa98
        Z3sxtry5Ka1kArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvF14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2ocxC64kIII
        0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
        wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
        x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
        64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
        1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAq
        YI8I648v4I1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AK
        xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
        TRCApnUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        KHOP_HELO_FCRDNS,MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

We mix up KUNIT_TRIGGER_STATIC_STUB and KUNIT_STATIC_STUB_REDIRECT in
static_stub header. Just correct KUNIT_TRIGGER_STATIC_STUB to
KUNIT_STATIC_STUB_REDIRECT which is documented.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 include/kunit/static_stub.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/kunit/static_stub.h b/include/kunit/static_stub.h
index 9b80150a5d62..85315c80b303 100644
--- a/include/kunit/static_stub.h
+++ b/include/kunit/static_stub.h
@@ -11,7 +11,7 @@
 #if !IS_ENABLED(CONFIG_KUNIT)
 
 /* If CONFIG_KUNIT is not enabled, these stubs quietly disappear. */
-#define KUNIT_TRIGGER_STATIC_STUB(real_fn_name, args...) do {} while (0)
+#define KUNIT_STATIC_STUB_REDIRECT(real_fn_name, args...) do {} while (0)
 
 #else
 
@@ -30,7 +30,7 @@
  * This is a function prologue which is used to allow calls to the current
  * function to be redirected by a KUnit test. KUnit tests can call
  * kunit_activate_static_stub() to pass a replacement function in. The
- * replacement function will be called by KUNIT_TRIGGER_STATIC_STUB(), which
+ * replacement function will be called by KUNIT_STATIC_STUB_REDIRECT(), which
  * will then return from the function. If the caller is not in a KUnit context,
  * the function will continue execution as normal.
  *
@@ -87,7 +87,7 @@ void __kunit_activate_static_stub(struct kunit *test,
  * When activated, calls to real_fn_addr from within this test (even if called
  * indirectly) will instead call replacement_addr. The function pointed to by
  * real_fn_addr must begin with the static stub prologue in
- * KUNIT_TRIGGER_STATIC_STUB() for this to work. real_fn_addr and
+ * KUNIT_STATIC_STUB_REDIRECT() for this to work. real_fn_addr and
  * replacement_addr must have the same type.
  *
  * The redirection can be disabled again with kunit_deactivate_static_stub().
-- 
2.30.0

