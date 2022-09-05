Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E555AD4F5
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Sep 2022 16:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238464AbiIEOf4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Sep 2022 10:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238468AbiIEOfX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Sep 2022 10:35:23 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DFA240A5;
        Mon,  5 Sep 2022 07:34:53 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4MLrW20H6Vz9v7HC;
        Mon,  5 Sep 2022 22:29:18 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwBX0ly8CBZjNGwkAA--.20252S5;
        Mon, 05 Sep 2022 15:34:23 +0100 (CET)
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
        Roberto Sassu <roberto.sassu@huawei.com>,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH v16 03/12] btf: Allow dynamic pointer parameters in kfuncs
Date:   Mon,  5 Sep 2022 16:33:09 +0200
Message-Id: <20220905143318.1592015-4-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220905143318.1592015-1-roberto.sassu@huaweicloud.com>
References: <20220905143318.1592015-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwBX0ly8CBZjNGwkAA--.20252S5
X-Coremail-Antispam: 1UD129KBjvJXoWxKrWDAF1fKw1DKr4DKrykKrg_yoW7ZFWkpF
        1fC3s2vr4kJr4xuwnrAF45ArW5Kay0q347CrWrC34FyF17XryDXF15Kry8Z3sakrWkC3W7
        Ar10grW5ua4xArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
        WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
        bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x
        0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
        7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcV
        C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY
        6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
        CY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAkuxUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAGBF1jj36ijAAAsh
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

Allow dynamic pointers (struct bpf_dynptr_kern *) to be specified as
parameters in kfuncs. Also, ensure that dynamic pointers passed as argument
are valid and initialized, are a pointer to the stack, and of the type
local. More dynamic pointer types can be supported in the future.

To properly detect whether a parameter is of the desired type, introduce
the stringify_struct() macro to compare the returned structure name with
the desired name. In addition, protect against structure renames, by
halting the build with BUILD_BUG_ON(), so that developers have to revisit
the code.

To check if a dynamic pointer passed to the kfunc is valid and initialized,
and if its type is local, export the existing functions
is_dynptr_reg_valid_init() and is_dynptr_type_expected().

Cc: Joanne Koong <joannelkoong@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/bpf_verifier.h |  5 +++++
 include/linux/btf.h          |  9 +++++++++
 kernel/bpf/btf.c             | 33 +++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c        | 10 +++++-----
 4 files changed, 52 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 1fdddbf3546b..dd58dfccd025 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -571,6 +571,11 @@ int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state
 			     u32 regno);
 int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 		   u32 regno, u32 mem_size);
+bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env,
+			      struct bpf_reg_state *reg);
+bool is_dynptr_type_expected(struct bpf_verifier_env *env,
+			     struct bpf_reg_state *reg,
+			     enum bpf_arg_type arg_type);
 
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
index e49b3b6d48ad..4266bff5fada 100644
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
+				 * Also permit initialized local dynamic pointers.
 				 */
 				if (!btf_type_is_scalar(ref_t) &&
 				    !__btf_type_is_scalar_struct(log, btf, ref_t, 0) &&
+				    !arg_dynptr &&
 				    (arg_mem_size ? !btf_type_is_void(ref_t) : 1)) {
 					bpf_log(log,
 						"arg#%d pointer type %s %s must point to %sscalar, or struct with scalar\n",
@@ -6378,6 +6383,34 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 					return -EINVAL;
 				}
 
+				if (arg_dynptr) {
+					if (reg->type != PTR_TO_STACK) {
+						bpf_log(log, "arg#%d pointer type %s %s not to stack\n",
+							i, btf_type_str(ref_t),
+							ref_tname);
+						return -EINVAL;
+					}
+
+					if (!is_dynptr_reg_valid_init(env, reg)) {
+						bpf_log(log,
+							"arg#%d pointer type %s %s must be valid and initialized\n",
+							i, btf_type_str(ref_t),
+							ref_tname);
+						return -EINVAL;
+					}
+
+					if (!is_dynptr_type_expected(env, reg,
+							ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL)) {
+						bpf_log(log,
+							"arg#%d pointer type %s %s points to unsupported dynamic pointer type\n",
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
index 10b3c0a81d09..8f02729074c6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -779,8 +779,8 @@ static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_
 	return true;
 }
 
-static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env,
-				     struct bpf_reg_state *reg)
+bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env,
+			      struct bpf_reg_state *reg)
 {
 	struct bpf_func_state *state = func(env, reg);
 	int spi = get_spi(reg->off);
@@ -799,9 +799,9 @@ static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env,
 	return true;
 }
 
-static bool is_dynptr_type_expected(struct bpf_verifier_env *env,
-				    struct bpf_reg_state *reg,
-				    enum bpf_arg_type arg_type)
+bool is_dynptr_type_expected(struct bpf_verifier_env *env,
+			     struct bpf_reg_state *reg,
+			     enum bpf_arg_type arg_type)
 {
 	struct bpf_func_state *state = func(env, reg);
 	enum bpf_dynptr_type dynptr_type;
-- 
2.25.1

