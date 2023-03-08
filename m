Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACA16B0506
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 11:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjCHKxI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Mar 2023 05:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjCHKxG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Mar 2023 05:53:06 -0500
X-Greylist: delayed 632 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Mar 2023 02:53:03 PST
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB814690;
        Wed,  8 Mar 2023 02:53:02 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4PWpSr1tlTz9xqnw;
        Wed,  8 Mar 2023 18:29:00 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwAX4lhfZQhkYmZ9AQ--.21667S2;
        Wed, 08 Mar 2023 11:37:30 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     andrii@kernel.org, mykolal@fb.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        shuah@kernel.org
Cc:     bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        mattbobrowski@google.com, zohar@linux.ibm.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH] bpf: Fix IMA test
Date:   Wed,  8 Mar 2023 11:37:13 +0100
Message-Id: <20230308103713.1681200-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwAX4lhfZQhkYmZ9AQ--.21667S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWrW8GrW3ZFWfZF1fury3Jwb_yoW5AFy5pa
        93Ww1jyw1rtF1ftrsrCFy7WFZavF9rXay5Grn5A3y5Aw4UWryIga4SyF10qFs8JrWIqa1f
        ua4fKrZrWw48Aa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvSb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
        n4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
        0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8
        ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
        CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280
        aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43
        ZEXa7IU0bAw3UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAKBF1jj4ZUvAAAsT
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Commit 62622dab0a28 ("ima: return IMA digest value only when IMA_COLLECTED
flag is set") caused bpf_ima_inode_hash() to refuse to give non-fresh
digests. IMA test #3 assumed the old behavior, that bpf_ima_inode_hash()
still returned also non-fresh digests.

Correct the test by accepting both cases. If the samples returned are 1,
assume that the commit above is applied and that the returned digest is
fresh. If the samples returned are 2, assume that the commit above is not
applied, and check both the non-fresh and fresh digest.

Fixes: 62622dab0a28 ("ima: return IMA digest value only when IMA_COLLECTED flag is set")
Reported by: David Vernet <void@manifault.com>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 .../selftests/bpf/prog_tests/test_ima.c       | 29 ++++++++++++++-----
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_ima.c b/tools/testing/selftests/bpf/prog_tests/test_ima.c
index b13feceb38f..810b14981c2 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_ima.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_ima.c
@@ -70,7 +70,7 @@ void test_test_ima(void)
 	u64 bin_true_sample;
 	char cmd[256];
 
-	int err, duration = 0;
+	int err, duration = 0, fresh_digest_idx = 0;
 	struct ima *skel = NULL;
 
 	skel = ima__open_and_load();
@@ -129,7 +129,15 @@ void test_test_ima(void)
 	/*
 	 * Test #3
 	 * - Goal: confirm that bpf_ima_inode_hash() returns a non-fresh digest
-	 * - Expected result: 2 samples (/bin/true: non-fresh, fresh)
+	 * - Expected result:
+	 *   1 sample (/bin/true: fresh) if commit 62622dab0a28 applied
+	 *   2 samples (/bin/true: non-fresh, fresh) if commit 62622dab0a28 is
+	 *     not applied
+	 *
+	 * If commit 62622dab0a28 ("ima: return IMA digest value only when
+	 * IMA_COLLECTED flag is set") is applied, bpf_ima_inode_hash() refuses
+	 * to give a non-fresh digest, hence the correct result is 1 instead of
+	 * 2.
 	 */
 	test_init(skel->bss);
 
@@ -144,13 +152,18 @@ void test_test_ima(void)
 		goto close_clean;
 
 	err = ring_buffer__consume(ringbuf);
-	ASSERT_EQ(err, 2, "num_samples_or_err");
-	ASSERT_NEQ(ima_hash_from_bpf[0], 0, "ima_hash");
-	ASSERT_NEQ(ima_hash_from_bpf[1], 0, "ima_hash");
-	ASSERT_EQ(ima_hash_from_bpf[0], bin_true_sample, "sample_equal_or_err");
+	ASSERT_GE(err, 1, "num_samples_or_err");
+	if (err == 2) {
+		ASSERT_NEQ(ima_hash_from_bpf[0], 0, "ima_hash");
+		ASSERT_EQ(ima_hash_from_bpf[0], bin_true_sample,
+			  "sample_equal_or_err");
+		fresh_digest_idx = 1;
+	}
+
+	ASSERT_NEQ(ima_hash_from_bpf[fresh_digest_idx], 0, "ima_hash");
 	/* IMA refreshed the digest. */
-	ASSERT_NEQ(ima_hash_from_bpf[1], bin_true_sample,
-		   "sample_different_or_err");
+	ASSERT_NEQ(ima_hash_from_bpf[fresh_digest_idx], bin_true_sample,
+		   "sample_equal_or_err");
 
 	/*
 	 * Test #4
-- 
2.25.1

