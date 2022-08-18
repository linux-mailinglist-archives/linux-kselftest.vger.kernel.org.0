Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61DA598850
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Aug 2022 18:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245298AbiHRQGT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Aug 2022 12:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239750AbiHRQGS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Aug 2022 12:06:18 -0400
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B4DBC801;
        Thu, 18 Aug 2022 09:06:16 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4M7pcP6cZ2z9v7YZ;
        Thu, 18 Aug 2022 23:25:41 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwAX5hHpWv5iycQwAA--.23244S4;
        Thu, 18 Aug 2022 16:30:26 +0100 (CET)
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
        deso@posteo.net, Roberto Sassu <roberto.sassu@huawei.com>,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH v12 02/10] btf: Handle dynamic pointer parameter in kfuncs
Date:   Thu, 18 Aug 2022 17:29:21 +0200
Message-Id: <20220818152929.402605-3-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220818152929.402605-1-roberto.sassu@huaweicloud.com>
References: <20220818152929.402605-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwAX5hHpWv5iycQwAA--.23244S4
X-Coremail-Antispam: 1UD129KBjvJXoWxWryfCFW5Kr48Wr17Jw4fXwb_yoWrCFWxpF
        n3Cas7Zr4vyr4xuw17AF4UArW5K3W0qw12kFWrC34FkF17Xr1DXF1DKryrA3sYkrWkCw1x
        Ar1jgrW5ua48CrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUP0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1j6r18M7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
        Av7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY
        6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7M4kE6xkIj40Ew7
        xC0wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2
        Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
        Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJw
        CI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU85ku7UU
        UUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAIBF1jj34W2AAJsG
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

Allow the bpf_dynptr_kern parameter to be specified in kfuncs. Also, ensure
that the dynamic pointer is valid and initialized.

To properly detect whether a parameter is of the desired type, introduce
the stringify_struct() macro to compare the returned structure name with
the desired name. In addition, protect against structure renames, by
halting the build with BUILD_BUG_ON(), so that developers have to revisit
the code.

Cc: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/bpf_verifier.h |  3 +++
 include/linux/btf.h          |  9 +++++++++
 kernel/bpf/btf.c             | 18 ++++++++++++++++++
 kernel/bpf/verifier.c        |  4 ++--
 4 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 2e3bad8640dc..55876fbdbae2 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -560,6 +560,9 @@ int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state
 			     u32 regno);
 int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 		   u32 regno, u32 mem_size);
+bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env,
+			      struct bpf_reg_state *reg,
+			      enum bpf_arg_type arg_type);
 
 /* this lives here instead of in bpf.h because it needs to dereference tgt_prog */
 static inline u64 bpf_trampoline_compute_key(const struct bpf_prog *tgt_prog,
diff --git a/include/linux/btf.h b/include/linux/btf.h
index ad93c2d9cc1c..f546d368ac5d 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -52,6 +52,15 @@
 #define KF_SLEEPABLE    (1 << 5) /* kfunc may sleep */
 #define KF_DESTRUCTIVE  (1 << 6) /* kfunc performs destructive actions */
 
+/*
+ * Return the name of the passed struct, if exists, or halt the build if for
+ * example the structure gets renamed. In this way, developers have to revisit
+ * the code using that structure name, and update it accordingly.
+ */
+#define stringify_struct(x)			\
+	({ BUILD_BUG_ON(sizeof(struct x) < 0);	\
+	   __stringify(x); })
+
 struct btf;
 struct btf_member;
 struct btf_type;
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index e49b3b6d48ad..26cb548420af 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6362,15 +6362,20 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 
 			if (is_kfunc) {
 				bool arg_mem_size = i + 1 < nargs && is_kfunc_arg_mem_size(btf, &args[i + 1], &regs[regno + 1]);
+				bool arg_dynptr = btf_type_is_struct(ref_t) &&
+						  !strcmp(ref_tname,
+							  stringify_struct(bpf_dynptr_kern));
 
 				/* Permit pointer to mem, but only when argument
 				 * type is pointer to scalar, or struct composed
 				 * (recursively) of scalars.
 				 * When arg_mem_size is true, the pointer can be
 				 * void *.
+				 * Also permit initialized dynamic pointers.
 				 */
 				if (!btf_type_is_scalar(ref_t) &&
 				    !__btf_type_is_scalar_struct(log, btf, ref_t, 0) &&
+				    !arg_dynptr &&
 				    (arg_mem_size ? !btf_type_is_void(ref_t) : 1)) {
 					bpf_log(log,
 						"arg#%d pointer type %s %s must point to %sscalar, or struct with scalar\n",
@@ -6378,6 +6383,19 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 					return -EINVAL;
 				}
 
+				if (arg_dynptr) {
+					if (!is_dynptr_reg_valid_init(env, reg,
+							ARG_PTR_TO_DYNPTR)) {
+						bpf_log(log,
+							"arg#%d pointer type %s %s must be initialized\n",
+							i, btf_type_str(ref_t),
+							ref_tname);
+						return -EINVAL;
+					}
+
+					continue;
+				}
+
 				/* Check for mem, len pair */
 				if (arg_mem_size) {
 					if (check_kfunc_mem_size_reg(env, &regs[regno + 1], regno + 1)) {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2c1f8069f7b7..aa834e7bb296 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -779,8 +779,8 @@ static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_
 	return true;
 }
 
-static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
-				     enum bpf_arg_type arg_type)
+bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
+			      enum bpf_arg_type arg_type)
 {
 	struct bpf_func_state *state = func(env, reg);
 	int spi = get_spi(reg->off);
-- 
2.25.1

