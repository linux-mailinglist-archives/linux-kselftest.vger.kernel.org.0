Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E36590F47
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Aug 2022 12:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238435AbiHLKV3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Aug 2022 06:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238811AbiHLKVR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Aug 2022 06:21:17 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3564C6C125;
        Fri, 12 Aug 2022 03:21:16 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M407m092Bz67Xgw;
        Fri, 12 Aug 2022 18:21:08 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 12 Aug 2022 12:21:12 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <haoluo@google.com>, <jolsa@kernel.org>, <mykolal@fb.com>,
        <corbet@lwn.net>, <dhowells@redhat.com>, <jarkko@kernel.org>,
        <rostedt@goodmis.org>, <mingo@redhat.com>, <paul@paul-moore.com>,
        <jmorris@namei.org>, <serge@hallyn.com>, <shuah@kernel.org>
CC:     <bpf@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <keyrings@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v11 5/9] bpf: Add bpf_lookup_*_key() and bpf_key_put() kfuncs
Date:   Fri, 12 Aug 2022 12:18:58 +0200
Message-ID: <20220812101902.2846182-6-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812101902.2846182-1-roberto.sassu@huawei.com>
References: <20220812101902.2846182-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

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

