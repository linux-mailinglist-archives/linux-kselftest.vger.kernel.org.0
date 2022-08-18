Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED893598800
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Aug 2022 17:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344536AbiHRPwq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Aug 2022 11:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344460AbiHRPvX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Aug 2022 11:51:23 -0400
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11D3C12F5;
        Thu, 18 Aug 2022 08:51:17 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4M7pfl73rVz9v7Qw;
        Thu, 18 Aug 2022 23:27:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwB3MhqAW_5ilLIyAA--.42520S2;
        Thu, 18 Aug 2022 16:32:28 +0100 (CET)
From:   roberto.sassu@huaweicloud.com
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
Subject: [PATCH v12 05/10] bpf: Add bpf_lookup_*_key() and bpf_key_put() kfuncs
Date:   Thu, 18 Aug 2022 17:29:24 +0200
Message-Id: <20220818152929.402605-6-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220818152929.402605-1-roberto.sassu@huaweicloud.com>
References: <20220818152929.402605-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwB3MhqAW_5ilLIyAA--.42520S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKFyUCw15Zr4kuF47ZF18Krg_yoWxWFyxpF
        WSkFyFkrWDGFy7Jrn7Cw47Za4a93Wv9ry7Ka47G3savrnaqr97Gws7XF4Ygwn8Crs7ury3
        tF42gw45uryUJrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1j6r18M7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x
        0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02
        F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4I
        kC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lw4CE
        c2x0rVAKj4xxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
        8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
        XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x
        0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAF
        wI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UKg4fUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAIBF1jj4IWVAABs9
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Add the bpf_lookup_user_key(), bpf_lookup_system_key() and bpf_key_put()
kfuncs, to respectively search a key with a given key handle serial number
and flags, obtain a key from a pre-determined ID defined in
include/linux/verification.h, and cleanup.

Introduce system_keyring_id_check() to validate the keyring ID parameter of
bpf_lookup_system_key().

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/bpf.h          |   6 ++
 include/linux/verification.h |   8 +++
 kernel/trace/bpf_trace.c     | 135 +++++++++++++++++++++++++++++++++++
 3 files changed, 149 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a82f8c559ae2..d415e5e97551 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2573,4 +2573,10 @@ static inline void bpf_cgroup_atype_get(u32 attach_btf_id, int cgroup_atype) {}
 static inline void bpf_cgroup_atype_put(int cgroup_atype) {}
 #endif /* CONFIG_BPF_LSM */
 
+#ifdef CONFIG_KEYS
+struct bpf_key {
+	struct key *key;
+	bool has_ref;
+};
+#endif /* CONFIG_KEYS */
 #endif /* _LINUX_BPF_H */
diff --git a/include/linux/verification.h b/include/linux/verification.h
index a655923335ae..f34e50ebcf60 100644
--- a/include/linux/verification.h
+++ b/include/linux/verification.h
@@ -17,6 +17,14 @@
 #define VERIFY_USE_SECONDARY_KEYRING ((struct key *)1UL)
 #define VERIFY_USE_PLATFORM_KEYRING  ((struct key *)2UL)
 
+static inline int system_keyring_id_check(u64 id)
+{
+	if (id > (unsigned long)VERIFY_USE_PLATFORM_KEYRING)
+		return -EINVAL;
+
+	return 0;
+}
+
 /*
  * The use to which an asymmetric key is being put.
  */
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 68e5cdd24cef..dfea85c7f4f0 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -20,6 +20,8 @@
 #include <linux/fprobe.h>
 #include <linux/bsearch.h>
 #include <linux/sort.h>
+#include <linux/key.h>
+#include <linux/verification.h>
 
 #include <net/bpf_sk_storage.h>
 
@@ -1181,6 +1183,139 @@ static const struct bpf_func_proto bpf_get_func_arg_cnt_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 };
 
+#ifdef CONFIG_KEYS
+__diag_push();
+__diag_ignore_all("-Wmissing-prototypes",
+		  "kfuncs which will be used in BPF programs");
+
+/**
+ * bpf_lookup_user_key - lookup a key by its serial
+ * @serial: key handle serial number
+ * @flags: lookup-specific flags
+ *
+ * Search a key with a given *serial* and the provided *flags*.
+ * If found, increment the reference count of the key by one, and
+ * return it in the bpf_key structure.
+ *
+ * The bpf_key structure must be passed to bpf_key_put() when done
+ * with it, so that the key reference count is decremented and the
+ * bpf_key structure is freed.
+ *
+ * Permission checks are deferred to the time the key is used by
+ * one of the available key-specific kfuncs.
+ *
+ * Set *flags* with KEY_LOOKUP_CREATE, to attempt creating a requested
+ * special keyring (e.g. session keyring), if it doesn't yet exist.
+ * Set *flags* with KEY_LOOKUP_PARTIAL, to lookup a key without waiting
+ * for the key construction, and to retrieve uninstantiated keys (keys
+ * without data attached to them).
+ *
+ * Return: a bpf_key pointer with a valid key pointer if the key is found, a
+ *         NULL pointer otherwise.
+ */
+struct bpf_key *bpf_lookup_user_key(u32 serial, u64 flags)
+{
+	key_ref_t key_ref;
+	struct bpf_key *bkey;
+
+	if (key_lookup_flags_check(flags) < 0)
+		return NULL;
+
+	/*
+	 * Permission check is deferred until the key is used, as the
+	 * intent of the caller is unknown here.
+	 */
+	key_ref = lookup_user_key(serial, flags, KEY_DEFER_PERM_CHECK);
+	if (IS_ERR(key_ref))
+		return NULL;
+
+	bkey = kmalloc(sizeof(*bkey), GFP_ATOMIC);
+	if (!bkey) {
+		key_put(key_ref_to_ptr(key_ref));
+		return NULL;
+	}
+
+	bkey->key = key_ref_to_ptr(key_ref);
+	bkey->has_ref = true;
+
+	return bkey;
+}
+
+/**
+ * bpf_lookup_system_key - lookup a key by a system-defined ID
+ * @id: key ID
+ *
+ * Obtain a bpf_key structure with a key pointer set to the passed key ID.
+ * The key pointer is marked as invalid, to prevent bpf_key_put() from
+ * attempting to decrement the key reference count on that pointer. The key
+ * pointer set in such way is currently understood only by
+ * verify_pkcs7_signature().
+ *
+ * Set *id* to one of the values defined in include/linux/verification.h:
+ * 0 for the primary keyring (immutable keyring of system keys);
+ * VERIFY_USE_SECONDARY_KEYRING for both the primary and secondary keyring
+ * (where keys can be added only if they are vouched for by existing keys
+ * in those keyrings); VERIFY_USE_PLATFORM_KEYRING for the platform
+ * keyring (primarily used by the integrity subsystem to verify a kexec'ed
+ * kerned image and, possibly, the initramfs signature).
+ *
+ * Return: a bpf_key pointer with an invalid key pointer set from the
+ *         pre-determined ID on success, a NULL pointer otherwise
+ */
+struct bpf_key *bpf_lookup_system_key(u64 id)
+{
+	struct bpf_key *bkey;
+
+	if (system_keyring_id_check(id) < 0)
+		return NULL;
+
+	bkey = kmalloc(sizeof(*bkey), GFP_ATOMIC);
+	if (!bkey)
+		return NULL;
+
+	bkey->key = (struct key *)(unsigned long)id;
+	bkey->has_ref = false;
+
+	return bkey;
+}
+
+/**
+ * bpf_key_put - decrement key reference count if key is valid and free bpf_key
+ * @bkey: bpf_key structure
+ *
+ * Decrement the reference count of the key inside *bkey*, if the pointer
+ * is valid, and free *bkey*.
+ */
+void bpf_key_put(struct bpf_key *bkey)
+{
+	if (bkey->has_ref)
+		key_put(bkey->key);
+
+	kfree(bkey);
+}
+
+__diag_pop();
+
+BTF_SET8_START(key_sig_kfunc_set)
+BTF_ID_FLAGS(func, bpf_lookup_user_key, KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_lookup_system_key, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_key_put, KF_RELEASE)
+BTF_SET8_END(key_sig_kfunc_set)
+
+static const struct btf_kfunc_id_set bpf_key_sig_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set = &key_sig_kfunc_set,
+};
+
+static int __init bpf_key_sig_kfuncs_init(void)
+{
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
+					 &bpf_key_sig_kfunc_set);
+}
+
+late_initcall(bpf_key_sig_kfuncs_init);
+#endif /* CONFIG_KEYS */
+
 static const struct bpf_func_proto *
 bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
-- 
2.25.1

