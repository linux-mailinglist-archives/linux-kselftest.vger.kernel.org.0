Return-Path: <linux-kselftest+bounces-7699-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDC58A147D
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 14:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9001286C34
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 12:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7339614EC4C;
	Thu, 11 Apr 2024 12:24:53 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48ADA14BF8B;
	Thu, 11 Apr 2024 12:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712838293; cv=none; b=b3f9DRT8sLmvyF3FiDPzBS57v/CSYbE5b2ixU3jwKX0VN+Q/MboulBLihLVG58kTuV2/BuZHUAMkWth+xm11jItYsRggRvJYtsPvVBYD3CfE3UHsd6MpilVPLuiEGax1bUEiXvkxhMEQiH/dEZIE62YkxVcDGrqllWRtEBguq0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712838293; c=relaxed/simple;
	bh=0Loqr7mjhwCTCl5of1gic0g0Zq6+4+vzm+j1nx9fR4E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h8tfIflEik0wCEPoIue0EFvzYZ5khuhzL9tUh4lZPkhNWOZPzET+Pm0QmsewBu3xTkMvKES1cMDN/oNlkd41KKjjRUmeEzTqOlhrYs4xB4n0NfZY5oLAme8QBF3KqMwr7d0tqUrhlytWJygaUqfdVv4tvUtGg6ugBKn4XEfRmxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VFf5d1Gv4z4f3mJL;
	Thu, 11 Apr 2024 20:24:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D55981A017D;
	Thu, 11 Apr 2024 20:24:45 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP4 (Coremail) with SMTP id gCh0CgA3h2mJ1hdmZ5R_Jw--.23051S4;
	Thu, 11 Apr 2024 20:24:45 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Brendan Jackman <jackmanb@chromium.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Khadija Kamran <kamrankhadijadj@gmail.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	John Johansen <john.johansen@canonical.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf-next v3 02/11] bpf, lsm: Add helper to read lsm hook return value range
Date: Thu, 11 Apr 2024 20:27:43 +0800
Message-Id: <20240411122752.2873562-3-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240411122752.2873562-1-xukuohai@huaweicloud.com>
References: <20240411122752.2873562-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA3h2mJ1hdmZ5R_Jw--.23051S4
X-Coremail-Antispam: 1UD129KBjvJXoWxCF45uFy8AF1xGryxZFWxCrg_yoW5Kr45pF
	sxAF45ArZ8Aa1agF13AF4rA3W3XF1vqw4UJFy7Gry2ya1Svw1kXa1DGrn8tr93WrWqkw13
	CF4jg3yfC347ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1sa9DUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

Add helper to read lsm hook return value range. The following patch
will use this information to verify lsm hook return values in bpf
verifier.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 include/linux/bpf_lsm.h |  8 ++++++
 kernel/bpf/bpf_lsm.c    | 54 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
index 1de7ece5d36d..e51c042abf43 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -9,6 +9,7 @@
 
 #include <linux/sched.h>
 #include <linux/bpf.h>
+#include <linux/bpf_verifier.h>
 #include <linux/lsm_hooks.h>
 
 #ifdef CONFIG_BPF_LSM
@@ -45,6 +46,8 @@ void bpf_inode_storage_free(struct inode *inode);
 
 void bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog, bpf_func_t *bpf_func);
 
+int bpf_lsm_get_retval_range(const struct bpf_prog *prog,
+			      struct bpf_retval_range *range);
 #else /* !CONFIG_BPF_LSM */
 
 static inline bool bpf_lsm_is_sleepable_hook(u32 btf_id)
@@ -78,6 +81,11 @@ static inline void bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog,
 {
 }
 
+static inline int bpf_lsm_get_retval_range(const struct bpf_prog *prog,
+					   struct bpf_retval_range *range)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_BPF_LSM */
 
 #endif /* _LINUX_BPF_LSM_H */
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index ee9d1a795334..4e1a4a333000 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -11,7 +11,6 @@
 #include <linux/lsm_hooks.h>
 #include <linux/bpf_lsm.h>
 #include <linux/kallsyms.h>
-#include <linux/bpf_verifier.h>
 #include <net/bpf_sk_storage.h>
 #include <linux/bpf_local_storage.h>
 #include <linux/btf_ids.h>
@@ -40,6 +39,29 @@ noinline RET bpf_lsm_##NAME(__VA_ARGS__)	\
 #undef LSM_RET_INT
 #undef LSM_RET_VOID
 
+struct lsm_retval_desc {
+	unsigned long func_addr;
+	int minval;
+	int maxval;
+};
+
+#define LSM_RET_INT(defval, min, max) min, max
+
+#define LSM_HOOK_RETVAL_int(NAME, ...) \
+{ (unsigned long)&bpf_lsm_##NAME, __VA_ARGS__ },
+
+#define LSM_HOOK_RETVAL_void(NAME, ...)
+
+#define LSM_HOOK(RET, RET_DESCRIPTION, NAME, ...) \
+LSM_HOOK_RETVAL_##RET(NAME, RET_DESCRIPTION)
+
+static struct lsm_retval_desc lsm_retvalues[]  = {
+#include <linux/lsm_hook_defs.h>
+};
+#undef LSM_HOOK
+#undef LSM_RET_INT
+#undef LSM_RET_VOID
+
 #define LSM_HOOK(RET, DEFAULT, NAME, ...) BTF_ID(func, bpf_lsm_##NAME)
 BTF_SET_START(bpf_lsm_hooks)
 #include <linux/lsm_hook_defs.h>
@@ -399,3 +421,33 @@ const struct bpf_verifier_ops lsm_verifier_ops = {
 	.get_func_proto = bpf_lsm_func_proto,
 	.is_valid_access = btf_ctx_access,
 };
+
+static struct lsm_retval_desc *find_retval_desc(const char *func_name)
+{
+	unsigned long addr;
+	struct lsm_retval_desc *desc;
+
+	addr = kallsyms_lookup_name(func_name);
+	for (unsigned int i = 0U; i < ARRAY_SIZE(lsm_retvalues); i++) {
+		desc = &lsm_retvalues[i];
+		if (addr == desc->func_addr)
+			return desc;
+	}
+
+	return NULL;
+}
+
+int bpf_lsm_get_retval_range(const struct bpf_prog *prog,
+			      struct bpf_retval_range *retval_range)
+{
+	struct lsm_retval_desc *desc;
+
+	desc = find_retval_desc(prog->aux->attach_func_name);
+	if (desc == NULL)
+		return -ENODEV;
+
+	retval_range->minval = desc->minval;
+	retval_range->maxval = desc->maxval;
+
+	return 0;
+}
-- 
2.30.2


