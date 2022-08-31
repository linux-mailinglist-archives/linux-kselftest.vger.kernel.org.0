Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F055A83BD
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Aug 2022 18:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbiHaQ5i (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Aug 2022 12:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbiHaQ5G (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Aug 2022 12:57:06 -0400
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25FFDC09B;
        Wed, 31 Aug 2022 09:57:03 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4MHqvY1yKsz9xHfD;
        Thu,  1 Sep 2022 00:51:37 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwBX0lxfkg9jJXIRAA--.5993S9;
        Wed, 31 Aug 2022 17:56:35 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        dhowells@redhat.com, jarkko@kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, shuah@kernel.org
Cc:     bpf@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        deso@posteo.net, memxor@gmail.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v15 07/12] bpf: Add bpf_verify_pkcs7_signature() kfunc
Date:   Wed, 31 Aug 2022 18:54:40 +0200
Message-Id: <20220831165445.1071641-8-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220831165445.1071641-1-roberto.sassu@huaweicloud.com>
References: <20220831165445.1071641-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwBX0lxfkg9jJXIRAA--.5993S9
X-Coremail-Antispam: 1UD129KBjvJXoWxAr1xZw47AFykZFWfGFyrCrg_yoW5uF18pF
        W0grsa9rykJr1ftFyfAa1fuF1Fkw4vqw17G3ZFy3s3uFnYgw17Z3WxtF4UW3sYkry8JrZF
        vrWIqr1akr13WaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
        80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
        c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4
        kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
        5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZV
        WrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY
        1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
        AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26F4UJVW0obIYCTnIWIevJa73UjIFyTuY
        vjxUxrcTDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgABBF1jj357FQAAsm
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
index 7a7023704ac2..8e2c026b0a58 100644
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

