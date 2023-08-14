Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0DF177AF72
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Aug 2023 04:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjHNCRr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 13 Aug 2023 22:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjHNCRe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 13 Aug 2023 22:17:34 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A2F18E;
        Sun, 13 Aug 2023 19:17:32 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RPJ2G4ln2z4f3mJl;
        Mon, 14 Aug 2023 10:17:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgD31Ke4jtlk5G6lAg--.6563S2;
        Mon, 14 Aug 2023 10:17:29 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     brendan.higgins@linux.dev, davidgow@google.com,
        dlatypov@google.com, skhan@linuxfoundation.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Cc:     shikemeng@huaweicloud.com
Subject: [PATCH] kunit: replace KUNIT_TRIGGER_STATIC_STUB macro with KUNIT_STATIC_STUB_REDIRECT
Date:   Mon, 14 Aug 2023 18:17:32 +0800
Message-Id: <20230814101732.3733165-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD31Ke4jtlk5G6lAg--.6563S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr48uF13Zr4ktw4xurWruFg_yoW8uFyxpa
        s3CFykur15JFs2kFyxZFW8tr1ak3yxJrWjyr43Ww4fuay8Wr4fJa1DKrWrK3yUW3ykXa98
        Z3sxtry5Ka1DArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2ocxC64kIII
        0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
        wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
        x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
        64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
        1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAq
        YI8I648v4I1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AK
        xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
        TRNgAwUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        MAY_BE_FORGED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

We mix up KUNIT_TRIGGER_STATIC_STUB and KUNIT_STATIC_STUB_REDIRECT in
static_stub header. Just correct KUNIT_TRIGGER_STATIC_STUB to
KUNIT_STATIC_STUB_REDIRECT which is documented.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Fixes: e047c5eaa763 ("kunit: Expose 'static stub' API to redirect functions")
Reviewed-by: David Gow <davidgow@google.com>

---
v1->v2:
-Fix typo
-Add Fixes tag.
-Collect RVB from David
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

