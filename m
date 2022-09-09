Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054D35B3726
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Sep 2022 14:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbiIIMJM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Sep 2022 08:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiIIMJF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Sep 2022 08:09:05 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0093FD23C;
        Fri,  9 Sep 2022 05:08:52 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4MPF4f3NjYz9xHvM;
        Fri,  9 Sep 2022 20:03:14 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwC3rpKVLBtj1uszAA--.31607S4;
        Fri, 09 Sep 2022 13:08:24 +0100 (CET)
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
Subject: [PATCH v17 02/12] bpf: Move dynptr type check to is_dynptr_type_expected()
Date:   Fri,  9 Sep 2022 14:07:26 +0200
Message-Id: <20220909120736.1027040-3-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220909120736.1027040-1-roberto.sassu@huaweicloud.com>
References: <20220909120736.1027040-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwC3rpKVLBtj1uszAA--.31607S4
X-Coremail-Antispam: 1UD129KBjvJXoWxWryxKryktry5trW5JryrJFb_yoWrZF13pF
        s7u39FqrWvyF42vw1ftF4kArZ8KFy8WrW5CFZ5A340yFyxZr98ZF15Kw1xXrn5KFykCw43
        Aw10vay5Aw1UJFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
        w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
        0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1sa9DUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAKBF1jj37rZgABsP
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

Move dynptr type check to is_dynptr_type_expected() from
is_dynptr_reg_valid_init(), so that callers can better determine the cause
of a negative result (dynamic pointer not valid/initialized, dynamic
pointer of the wrong type). It will be useful for example for BTF, to
restrict which dynamic pointer types can be passed to kfuncs, as initially
only the local type will be supported.

Also, splitting makes the code more readable, since checking the dynamic
pointer type is not necessarily related to validity and initialization.

Split the validity/initialization and dynamic pointer type check also in
the verifier, and adjust the expected error message in the test (a test for
an unexpected dynptr type passed to a helper cannot be added due to missing
suitable helpers, but this case has been tested manually).

Cc: Joanne Koong <joannelkoong@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c                         | 35 ++++++++++++++-----
 .../testing/selftests/bpf/prog_tests/dynptr.c |  2 +-
 2 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c0f175ac187a..9564526ee579 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -779,8 +779,8 @@ static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_
 	return true;
 }
 
-static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
-				     enum bpf_arg_type arg_type)
+static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env,
+				     struct bpf_reg_state *reg)
 {
 	struct bpf_func_state *state = func(env, reg);
 	int spi = get_spi(reg->off);
@@ -796,11 +796,24 @@ static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env, struct bpf_re
 			return false;
 	}
 
+	return true;
+}
+
+static bool is_dynptr_type_expected(struct bpf_verifier_env *env,
+				    struct bpf_reg_state *reg,
+				    enum bpf_arg_type arg_type)
+{
+	struct bpf_func_state *state = func(env, reg);
+	enum bpf_dynptr_type dynptr_type;
+	int spi = get_spi(reg->off);
+
 	/* ARG_PTR_TO_DYNPTR takes any type of dynptr */
 	if (arg_type == ARG_PTR_TO_DYNPTR)
 		return true;
 
-	return state->stack[spi].spilled_ptr.dynptr.type == arg_to_dynptr_type(arg_type);
+	dynptr_type = arg_to_dynptr_type(arg_type);
+
+	return state->stack[spi].spilled_ptr.dynptr.type == dynptr_type;
 }
 
 /* The reg state of a pointer or a bounded scalar was saved when
@@ -6069,21 +6082,27 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			}
 
 			meta->uninit_dynptr_regno = regno;
-		} else if (!is_dynptr_reg_valid_init(env, reg, arg_type)) {
+		} else if (!is_dynptr_reg_valid_init(env, reg)) {
+			verbose(env,
+				"Expected an initialized dynptr as arg #%d\n",
+				arg + 1);
+			return -EINVAL;
+		} else if (!is_dynptr_type_expected(env, reg, arg_type)) {
 			const char *err_extra = "";
 
 			switch (arg_type & DYNPTR_TYPE_FLAG_MASK) {
 			case DYNPTR_TYPE_LOCAL:
-				err_extra = "local ";
+				err_extra = "local";
 				break;
 			case DYNPTR_TYPE_RINGBUF:
-				err_extra = "ringbuf ";
+				err_extra = "ringbuf";
 				break;
 			default:
+				err_extra = "<unknown>";
 				break;
 			}
-
-			verbose(env, "Expected an initialized %sdynptr as arg #%d\n",
+			verbose(env,
+				"Expected a dynptr of type %s as arg #%d\n",
 				err_extra, arg + 1);
 			return -EINVAL;
 		}
diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/testing/selftests/bpf/prog_tests/dynptr.c
index bcf80b9f7c27..8fc4e6c02bfd 100644
--- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
@@ -30,7 +30,7 @@ static struct {
 	{"invalid_helper2", "Expected an initialized dynptr as arg #3"},
 	{"invalid_write1", "Expected an initialized dynptr as arg #1"},
 	{"invalid_write2", "Expected an initialized dynptr as arg #3"},
-	{"invalid_write3", "Expected an initialized ringbuf dynptr as arg #1"},
+	{"invalid_write3", "Expected an initialized dynptr as arg #1"},
 	{"invalid_write4", "arg 1 is an unacquired reference"},
 	{"invalid_read1", "invalid read from stack"},
 	{"invalid_read2", "cannot pass in dynptr at an offset"},
-- 
2.25.1

