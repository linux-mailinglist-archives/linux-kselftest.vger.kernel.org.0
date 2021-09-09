Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873204044F8
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Sep 2021 07:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350726AbhIIF3p (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Sep 2021 01:29:45 -0400
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net ([165.227.154.27]:50691
        "HELO zg8tmty1ljiyny4xntqumjca.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S230449AbhIIF3p (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Sep 2021 01:29:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id; bh=9JPa++8Fpv6wmMh9TaDlgej6CEF5c1q0a7YprztrmA8=; b=J
        BjmvB/hGNF1Dl57R0AZASJlnVRFbck5I8ZfmH2c+JMUE3PaLaSN5cyzI7+swmor+
        vuIVxnM02VidDNiQ7doXb1U6xzCIi9pF0PZjOgHmnhDG0NUT0W0E7IgytEj6j3+H
        x3U7xLyo/qujYyRjECoTnIDp6zwbC1hzap751ISwx0=
Received: from localhost.localdomain (unknown [10.162.127.118])
        by app1 (Coremail) with SMTP id XAUFCgA3mGV0mzlh+N89AA--.2107S3;
        Thu, 09 Sep 2021 13:28:20 +0800 (CST)
From:   Xiyu Yang <xiyuyang19@fudan.edu.cn>
To:     Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Cc:     yuanxzhang@fudan.edu.cn, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>
Subject: [PATCH] kunit: fix reference count leak in kfree_at_end
Date:   Thu,  9 Sep 2021 13:28:16 +0800
Message-Id: <1631165296-81082-1-git-send-email-xiyuyang19@fudan.edu.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: XAUFCgA3mGV0mzlh+N89AA--.2107S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uF13ur1xAw4kZrykuFy5CFg_yoW8Jw1fpF
        4xGFy29a4YyF1xG395Ar48XF1xCa1xtr1S9rZ2g39a9anxJryYy3Z0vFWjgrW5XryxAF4a
        yFyvvr48CF4DCFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
        JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
        rcIFxwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
        IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
        6r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2
        IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E
        87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
        IFyTuYvjfUOlksUUUUU
X-CM-SenderInfo: irzsiiysuqikmy6i3vldqovvfxof0/
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The reference counting issue happens in the normal path of
kfree_at_end(). When kunit_alloc_and_get_resource() is invoked, the
function forgets to handle the returned resource object, whose refcount
increased inside, causing a refcount leak.

Fix this issue by calling kunit_put_resource() at the end of function.

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
---
 lib/kunit/executor_test.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
index cdbe54b16501..3af30abad826 100644
--- a/lib/kunit/executor_test.c
+++ b/lib/kunit/executor_test.c
@@ -113,11 +113,13 @@ static void kfree_res_free(struct kunit_resource *res)
  */
 static void kfree_at_end(struct kunit *test, const void *to_free)
 {
+	struct kunit_resource *res;
 	/* kfree() handles NULL already, but avoid allocating a no-op cleanup. */
 	if (IS_ERR_OR_NULL(to_free))
 		return;
-	kunit_alloc_and_get_resource(test, NULL, kfree_res_free, GFP_KERNEL,
+	res = kunit_alloc_and_get_resource(test, NULL, kfree_res_free, GFP_KERNEL,
 				     (void *)to_free);
+	kunit_put_resource(res);
 }
 
 static struct kunit_suite *alloc_fake_suite(struct kunit *test,
-- 
2.7.4

