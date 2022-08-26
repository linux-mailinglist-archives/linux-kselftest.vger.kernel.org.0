Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B795A23E4
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Aug 2022 11:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240510AbiHZJN0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Aug 2022 05:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233000AbiHZJNZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Aug 2022 05:13:25 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A285DCD78F;
        Fri, 26 Aug 2022 02:13:23 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4MDYrv5GwNz9v7Gy;
        Fri, 26 Aug 2022 17:07:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwCnXxeKjghjdBVRAA--.23684S2;
        Fri, 26 Aug 2022 10:12:54 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        corbet@lwn.net, dhowells@redhat.com, jarkko@kernel.org,
        rostedt@goodmis.org, mingo@redhat.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, shuah@kernel.org
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        deso@posteo.net, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v14 04/10] KEYS: Move KEY_LOOKUP_ to include/linux/key.h and add flags check function
Date:   Fri, 26 Aug 2022 11:12:28 +0200
Message-Id: <20220826091228.1701185-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <acae432697e854748d9a44c732ec8cab807d9d46.camel@huaweicloud.com>
References: <acae432697e854748d9a44c732ec8cab807d9d46.camel@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwCnXxeKjghjdBVRAA--.23684S2
X-Coremail-Antispam: 1UD129KBjvJXoW7urW3JFWUGryftw1rWr4fuFg_yoW8uF1kpF
        yUCa4rKry8GFy2g3s3GFsIya1ag3yfGr17AFZIgwn0vF9ag3y8Jrn7GF43GF15urWruFy2
        qr42ga15uw1UA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
        IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
        87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IUbHa0PUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAQBF1jj4JQwgAFsx
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

In preparation for the patch that introduces the bpf_lookup_user_key() eBPF
kfunc, move KEY_LOOKUP_ definitions to include/linux/key.h, to be able to
validate the kfunc parameters.

Also, introduce key_lookup_flags_valid() to check if the caller set in the
argument only defined flags. Introduce it directly in include/linux/key.h,
to reduce the risk that the check is not in sync with currently defined
flags.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: KP Singh <kpsingh@kernel.org>
---
 include/linux/key.h      | 16 ++++++++++++++++
 security/keys/internal.h |  2 --
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/linux/key.h b/include/linux/key.h
index 7febc4881363..e679dbf0c940 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -88,6 +88,22 @@ enum key_need_perm {
 	KEY_DEFER_PERM_CHECK,	/* Special: permission check is deferred */
 };
 
+#define KEY_LOOKUP_CREATE	0x01
+#define KEY_LOOKUP_PARTIAL	0x02
+
+/**
+ * key_lookup_flags_valid - detect if provided key lookup flags are valid
+ * @flags: key lookup flags.
+ *
+ * Verify whether or not the caller set in the argument only defined flags.
+ *
+ * Return: true if flags are valid, false if not.
+ */
+static inline bool key_lookup_flags_valid(u64 flags)
+{
+	return !(flags & ~(KEY_LOOKUP_CREATE | KEY_LOOKUP_PARTIAL));
+}
+
 struct seq_file;
 struct user_struct;
 struct signal_struct;
diff --git a/security/keys/internal.h b/security/keys/internal.h
index 9b9cf3b6fcbb..3c1e7122076b 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -165,8 +165,6 @@ extern struct key *request_key_and_link(struct key_type *type,
 
 extern bool lookup_user_key_possessed(const struct key *key,
 				      const struct key_match_data *match_data);
-#define KEY_LOOKUP_CREATE	0x01
-#define KEY_LOOKUP_PARTIAL	0x02
 
 extern long join_session_keyring(const char *name);
 extern void key_change_session_keyring(struct callback_head *twork);
-- 
2.25.1

