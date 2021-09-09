Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFFA404623
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Sep 2021 09:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352624AbhIIH16 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Sep 2021 03:27:58 -0400
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net ([165.227.154.27]:45222
        "HELO zg8tmty1ljiyny4xntqumjca.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1352644AbhIIH15 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Sep 2021 03:27:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id; bh=l7LuoSO3cuCI59wQT6VhqxA3MY6wab/zAIpmw9ndC8o=; b=l
        MR2G8j6UbksSBJzP1EfsqF6JHHHavsYc3yrkKVoQBlA/FiC6XAM54/0AltLNBI5V
        kxAsBfRi65aTGLpQPj/BY2BOifD39TBd+HQZrsjFzdm5+zvkMz35gUL7cgMXpDgv
        OoE1+RZip40ceo4fZ7dLElw+Qgq6lWh8NXjL5eD7Xg=
Received: from localhost.localdomain (unknown [10.162.185.151])
        by app1 (Coremail) with SMTP id XAUFCgCX+GXNtjlh574+AA--.2228S3;
        Thu, 09 Sep 2021 15:25:27 +0800 (CST)
From:   Xiyu Yang <xiyuyang19@fudan.edu.cn>
To:     Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Cc:     yuanxzhang@fudan.edu.cn, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>
Subject: [PATCH v2] kunit: fix reference count leak in kfree_at_end
Date:   Thu,  9 Sep 2021 15:24:36 +0800
Message-Id: <1631172276-82914-1-git-send-email-xiyuyang19@fudan.edu.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: XAUFCgCX+GXNtjlh574+AA--.2228S3
X-Coremail-Antispam: 1UD129KBjvdXoWruryDtr1rArWxGFyDGw4fGrg_yoWkWrcEkF
        4xuFn2vr97AF4jgw4UKr45AF4IkF4UJF95W3ZagFZ3Ka4jqr9rtr9xurn5WFW3WF43Cr9x
        X39xGr4xAw1IvjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbIAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_GcCE
        3s1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
        1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
        w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
        vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v
        4I1lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
        0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
        AVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
        CY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
        uYvjfUOlksUUUUU
X-CM-SenderInfo: irzsiiysuqikmy6i3vldqovvfxof0/
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The reference counting issue happens in the normal path of
kfree_at_end(). When kunit_alloc_and_get_resource() is invoked, the
function forgets to handle the returned resource object, whose refcount
increased inside, causing a refcount leak.

Fix this issue by calling kunit_alloc_resource() instead of
kunit_alloc_and_get_resource().

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
---
 lib/kunit/executor_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
index cdbe54b16501..c2dcfb1f6e97 100644
--- a/lib/kunit/executor_test.c
+++ b/lib/kunit/executor_test.c
@@ -116,7 +116,7 @@ static void kfree_at_end(struct kunit *test, const void *to_free)
 	/* kfree() handles NULL already, but avoid allocating a no-op cleanup. */
 	if (IS_ERR_OR_NULL(to_free))
 		return;
-	kunit_alloc_and_get_resource(test, NULL, kfree_res_free, GFP_KERNEL,
+	kunit_alloc_resource(test, NULL, kfree_res_free, GFP_KERNEL,
 				     (void *)to_free);
 }
 
-- 
2.7.4

