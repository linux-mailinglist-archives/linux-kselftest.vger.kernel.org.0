Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E5F590F4D
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Aug 2022 12:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238474AbiHLKVb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Aug 2022 06:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238814AbiHLKVS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Aug 2022 06:21:18 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3456C135;
        Fri, 12 Aug 2022 03:21:17 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M407n40cTz67bjw;
        Fri, 12 Aug 2022 18:21:09 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 12 Aug 2022 12:21:14 +0200
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
Subject: [PATCH v11 6/9] bpf: Add bpf_verify_pkcs7_signature() kfunc
Date:   Fri, 12 Aug 2022 12:18:59 +0200
Message-ID: <20220812101902.2846182-7-roberto.sassu@huawei.com>
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
Acked-by: KP Singh <kpsingh@kernel.org>
---
 kernel/trace/bpf_trace.c | 45 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index dfea85c7f4f0..b1fb985ba1b3 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1294,12 +1294,57 @@ void bpf_key_put(struct bpf_key *bkey)
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
+int bpf_verify_pkcs7_signature(struct bpf_dynptr_kern *data_ptr,
+			       struct bpf_dynptr_kern *sig_ptr,
+			       struct bpf_key *trusted_keyring)
+{
+	int ret;
+
+	if (trusted_keyring->has_ref) {
+		/*
+		 * Do the permission check deferred in bpf_lookup_user_key().
+		 * See bpf_lookup_user_key() for more details.
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
 
 BTF_SET8_START(key_sig_kfunc_set)
 BTF_ID_FLAGS(func, bpf_lookup_user_key, KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_lookup_system_key, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_key_put, KF_RELEASE)
+#ifdef CONFIG_SYSTEM_DATA_VERIFICATION
+BTF_ID_FLAGS(func, bpf_verify_pkcs7_signature, KF_SLEEPABLE)
+#endif
 BTF_SET8_END(key_sig_kfunc_set)
 
 static const struct btf_kfunc_id_set bpf_key_sig_kfunc_set = {
-- 
2.25.1

