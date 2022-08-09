Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0D658D9D7
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Aug 2022 15:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244213AbiHINtk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Aug 2022 09:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244351AbiHINsB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Aug 2022 09:48:01 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D63193C9;
        Tue,  9 Aug 2022 06:48:00 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M2Dph5fjRz687XH;
        Tue,  9 Aug 2022 21:45:16 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 9 Aug 2022 15:47:57 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <haoluo@google.com>, <jolsa@kernel.org>, <corbet@lwn.net>,
        <dhowells@redhat.com>, <jarkko@kernel.org>, <rostedt@goodmis.org>,
        <mingo@redhat.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
        <serge@hallyn.com>, <shuah@kernel.org>
CC:     <bpf@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <keyrings@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v9 07/10] bpf: Add bpf_verify_pkcs7_signature() kfunc
Date:   Tue, 9 Aug 2022 15:46:00 +0200
Message-ID: <20220809134603.1769279-8-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220809134603.1769279-1-roberto.sassu@huawei.com>
References: <20220809134603.1769279-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
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

Add the bpf_verify_pkcs7_signature() kfunc, to give eBPF security modules
the ability to check the validity of a signature against supplied data, by
using user-provided or system-provided keys as trust anchor.

The new kfunc makes it possible to enforce mandatory policies, as eBPF
programs might be allowed to make security decisions only based on data
sources the system administrator approves.

The caller should provide the data to be verified and the signature as eBPF
dynamic pointers (to minimize the number of parameters) and a bpf_key
structure containing a reference to the keyring with keys trusted for
signature verification, obtained from bpf_lookup_user_key() or
bpf_lookup_system_key().

For bpf_key structures obtained from the former lookup function,
bpf_verify_pkcs7_signature() completes the permission check deferred by
that function by calling key_validate(). key_task_permission() is already
called by the PKCS#7 code.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 kernel/trace/bpf_trace.c | 56 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 33ca4cfe6e26..79ba8c96735a 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -21,6 +21,7 @@
 #include <linux/bsearch.h>
 #include <linux/sort.h>
 #include <linux/key.h>
+#include <linux/verification.h>
 
 #include <net/bpf_sk_storage.h>
 
@@ -1290,6 +1291,47 @@ noinline __weak void bpf_key_put(struct bpf_key *bkey)
 	kfree(bkey);
 }
 
+#ifdef CONFIG_SYSTEM_DATA_VERIFICATION
+/**
+ * bpf_verify_pkcs7_signature - verify a PKCS#7 signature
+ * @data_ptr: data to verify
+ * @sig_ptr: signature of the data
+ * @trusted_keyring: keyring with keys trusted for signature verification
+ *
+ * Verify the PKCS#7 signature *sig_ptr* against the supplied *data_ptr*
+ * with keys in a keyring referenced by *trusted_keyring*.
+ *
+ * Return: 0 on success, a negative value on error.
+ */
+noinline __weak int bpf_verify_pkcs7_signature(struct bpf_dynptr_kern *data_ptr,
+					       struct bpf_dynptr_kern *sig_ptr,
+					       struct bpf_key *trusted_keyring)
+{
+	int ret;
+
+	if (trusted_keyring->valid_ptr) {
+		/*
+		 * Do the permission check deferred in bpf_lookup_user_key().
+		 *
+		 * A call to key_task_permission() here would be redundant, as
+		 * it is already done by keyring_search() called by
+		 * find_asymmetric_key().
+		 */
+		ret = key_validate(trusted_keyring->key);
+		if (ret < 0)
+			return ret;
+	}
+
+	return verify_pkcs7_signature(data_ptr->data,
+				      bpf_dynptr_get_size(data_ptr),
+				      sig_ptr->data,
+				      bpf_dynptr_get_size(sig_ptr),
+				      trusted_keyring->key,
+				      VERIFYING_UNSPECIFIED_SIGNATURE, NULL,
+				      NULL);
+}
+#endif /* CONFIG_SYSTEM_DATA_VERIFICATION */
+
 __diag_pop();
 
 BTF_SET8_START(key_kfunc_set)
@@ -1303,11 +1345,25 @@ static const struct btf_kfunc_id_set bpf_key_kfunc_set = {
 	.owner = THIS_MODULE,
 	.set = &key_kfunc_set,
 };
+
+#ifdef CONFIG_SYSTEM_DATA_VERIFICATION
+BTF_SET8_START(verify_sig_kfunc_set)
+BTF_ID_FLAGS(func, bpf_verify_pkcs7_signature, KF_SLEEPABLE)
+BTF_SET8_END(verify_sig_kfunc_set)
+
+static const struct btf_kfunc_id_set bpf_verify_sig_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set = &verify_sig_kfunc_set,
+};
+#endif /* CONFIG_SYSTEM_DATA_VERIFICATION */
 #endif /* CONFIG_KEYS */
 
 const struct btf_kfunc_id_set *kfunc_sets[] = {
 #ifdef CONFIG_KEYS
 	&bpf_key_kfunc_set,
+#ifdef CONFIG_SYSTEM_DATA_VERIFICATION
+	&bpf_verify_sig_kfunc_set,
+#endif /* CONFIG_SYSTEM_DATA_VERIFICATION */
 #endif /* CONFIG_KEYS */
 };
 
-- 
2.25.1

