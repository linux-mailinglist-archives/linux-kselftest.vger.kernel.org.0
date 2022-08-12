Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26FB3590F34
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Aug 2022 12:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238426AbiHLKUD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Aug 2022 06:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237236AbiHLKT7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Aug 2022 06:19:59 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F00AB4C6;
        Fri, 12 Aug 2022 03:19:58 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M4036015Jz688p4;
        Fri, 12 Aug 2022 18:17:06 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 12 Aug 2022 12:19:54 +0200
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
        Roberto Sassu <roberto.sassu@huawei.com>,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH v11 2/9] btf: Handle dynamic pointer parameter in kfuncs
Date:   Fri, 12 Aug 2022 12:18:55 +0200
Message-ID: <20220812101902.2846182-3-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812101902.2846182-1-roberto.sassu@huawei.com>
References: <20220812101902.2846182-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
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

Allow the bpf_dynptr_kern parameter to be specified in kfuncs. Also, ensure
that the dynamic pointer is valid and initialized.

Cc: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/bpf_verifier.h |  3 +++
 kernel/bpf/btf.c             | 22 ++++++++++++++++++++++
 kernel/bpf/verifier.c        |  4 ++--
 3 files changed, 27 insertions(+), 2 deletions(-)

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
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index e49b3b6d48ad..86e63f2ee5da 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -195,6 +195,10 @@
 	     i < btf_type_vlen(struct_type);					\
 	     i++, member++)
 
+#define stringify_struct(x)			\
+	({ BUILD_BUG_ON(sizeof(struct x) < 0);	\
+	   __stringify(x); })
+
 DEFINE_IDR(btf_idr);
 DEFINE_SPINLOCK(btf_idr_lock);
 
@@ -6362,15 +6366,20 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 
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
@@ -6378,6 +6387,19 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
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

