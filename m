Return-Path: <linux-kselftest+bounces-2628-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AADB82393A
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jan 2024 00:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA71D1F25F06
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jan 2024 23:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EAE1F93C;
	Wed,  3 Jan 2024 23:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="ORXW7+FD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1ydONiDv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE4D1F60B;
	Wed,  3 Jan 2024 23:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailnew.west.internal (Postfix) with ESMTP id 33B312B0020B;
	Wed,  3 Jan 2024 18:32:22 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 03 Jan 2024 18:32:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1704324741; x=
	1704331941; bh=e1zzbqCtNji+Aum6AoMU4JtJ0ZJakVaP1wCJJC7nMGs=; b=O
	RXW7+FDgFXUaHM0BxCUi54PHTCSYIPWztgOAGUck6UHl+qGHfaYP+QVC5C0PU8EU
	6SF5okPVHiwbXZgv4yv73p7OyMBnggKiTnI2Qf1ugiVAK/2CWFe5AGLWyLKrJ2ei
	QnvJQhVFM1X0M3Q+4aaBA6WEX3a/i5cyP3zEtDrQ97CWge2xEyaJL2GXW1jcrGFu
	J1tjPdQm7Pp+t29YSbHLg2NymsA+o4bJUlI0ikCxF/eFIrbK6nTD7Yk8J6JMZPhT
	XmeSp+WCq7+Tbil/qzZKW/68BkXlwmS4vibimU26IAQ3FdBIaHPf257jaP3gEIlA
	T6Gm39fDzkMqkF7MmT2eA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1704324741; x=
	1704331941; bh=e1zzbqCtNji+Aum6AoMU4JtJ0ZJakVaP1wCJJC7nMGs=; b=1
	ydONiDvKxPAVNKdHHJXzlJHpzUouWfZ2W4ucuxgocYoCD35JZPg2ZMCAzuc8OJzm
	QIGoFDl+SL+RWR9jmBQBUJwSIMZz+ms1uZEgos8OPKH23KCJPFW7kOzPi5Bi5jhp
	l46z66PCGRabuQKKELqfMuKL7KzeElxUofal7ZsxLmcRJTDVPkRWN3R55J2+znRf
	PDEJRo3trte4AlY43sc9LTqlbNBesaWHZwe5XO9/5srA2nIIxi+vqaN31mkxnjKd
	eUp2L+zLUC07fvmV4OvsxQA+wZvNVUSx0PlVkCmdkN0duaAdsHJdRY8XAqBY8Gm1
	5tIApW8PE4QtX2L7YZA1g==
X-ME-Sender: <xms:g-6VZQZYy9lZc_yJWRHNDkL9Bnf7FLhpanJqwUXdBjkaz2VOWmp9WA>
    <xme:g-6VZbb6Jw7CTIn4P01bXzfbp8pUPb3nYiyuxP6HR418yaoyC6IaKCfGgIFS7yaGe
    qKpVnDFB6EDR0E6bQ>
X-ME-Received: <xmr:g-6VZa-bbd3TuoO9ILwrFIP7huOzCeFRevJC-ftq9nOBYGZQuexSuybEUBHVkdC4sAWAFedx84DZiG_Uo9I0lcGA4jTDVvf5LwvygiDBIfVzXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdegiedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdljedtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertder
    tddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepgfefgfegjefhudeikedvueetffelieefuedvhfehjeeljeej
    kefgffeghfdttdetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:g-6VZarvwU0qj1dOWKtA660ZvoTyect4_fvfzyi2h1uRxi1R72AwjQ>
    <xmx:g-6VZbqL4fHPQNOP9znfqNPSiNhEXgXo4TLwpac4wlHU2qEdjxlCoA>
    <xmx:g-6VZYQ28DwQRaBuAJNS9uIOTQYrjbgEvWYlQU2vP7bq4QKpWnQ0ow>
    <xmx:he6VZYX3u2jVlVVpOeIkliTupPCBqQ-9CV-ZAHG-aTjOTr-41ofdX8snFCo>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jan 2024 18:32:15 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: benjamin.tissoires@redhat.com,
	hawk@kernel.org,
	edumazet@google.com,
	alexandre.torgue@foss.st.com,
	ebiggers@kernel.org,
	tj@kernel.org,
	rostedt@goodmis.org,
	shuah@kernel.org,
	martin.lau@linux.dev,
	ast@kernel.org,
	fw@strlen.de,
	kuba@kernel.org,
	pablo@netfilter.org,
	jikos@kernel.org,
	john.fastabend@gmail.com,
	mcoquelin.stm32@gmail.com,
	mhiramat@kernel.org,
	yonghong.song@linux.dev,
	Herbert Xu <herbert@gondor.apana.org.au>,
	dsahern@kernel.org,
	hannes@cmpxchg.org,
	lizefan.x@bytedance.com,
	pabeni@redhat.com,
	steffen.klassert@secunet.com,
	daniel@iogearbox.net,
	tytso@mit.edu,
	andrii@kernel.org,
	davem@davemloft.net,
	kadlec@netfilter.org,
	song@kernel.org,
	alexei.starovoitov@gmail.com,
	olsajiri@gmail.com,
	quentin@isovalent.com,
	alan.maguire@oracle.com,
	memxor@gmail.com
Cc: kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	mathieu.desnoyers@efficios.com,
	mykolal@fb.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	fsverity@lists.linux.dev,
	bpf@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	linux-kselftest@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH bpf-next 2/2] bpf: treewide: Annotate BPF kfuncs in BTF
Date: Wed,  3 Jan 2024 16:31:56 -0700
Message-ID: <68d5598e5708dfe3370406cd5c946565ca4b50f1.1704324602.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1704324602.git.dxu@dxuuu.xyz>
References: <cover.1704324602.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit marks kfuncs as such inside the .BTF_ids section. The upshot
of these annotations is that we'll be able to automatically generate
kfunc prototypes for downstream users. The process is as follows:

1. In source, tag kfunc BTF_SET8 sets with BTF_SET8_KFUNC flag
2. During build, pahole injects into BTF a "bpf_kfunc" BTF_DECL_TAG for
   each function inside BTF_SET8_KFUNC sets
3. At runtime, vmlinux or module BTF is made available in sysfs
4. At runtime, bpftool (or similar) can look at provided BTF and
   generate appropriate prototypes for functions with "bpf_kfunc" tag

To ensure future kfunc are similarly tagged, we add a WARN_ON() inside
kfunc registration so developers will notice issues duringn development.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 drivers/hid/bpf/hid_bpf_dispatch.c                    | 4 ++--
 fs/verity/measure.c                                   | 2 +-
 include/linux/btf_ids.h                               | 3 +++
 kernel/bpf/btf.c                                      | 3 +++
 kernel/bpf/cpumask.c                                  | 2 +-
 kernel/bpf/helpers.c                                  | 4 ++--
 kernel/bpf/map_iter.c                                 | 2 +-
 kernel/cgroup/rstat.c                                 | 2 +-
 kernel/trace/bpf_trace.c                              | 4 ++--
 net/bpf/test_run.c                                    | 4 ++--
 net/core/filter.c                                     | 8 ++++----
 net/core/xdp.c                                        | 2 +-
 net/ipv4/bpf_tcp_ca.c                                 | 2 +-
 net/ipv4/fou_bpf.c                                    | 2 +-
 net/ipv4/tcp_bbr.c                                    | 2 +-
 net/ipv4/tcp_cubic.c                                  | 2 +-
 net/ipv4/tcp_dctcp.c                                  | 2 +-
 net/netfilter/nf_conntrack_bpf.c                      | 2 +-
 net/netfilter/nf_nat_bpf.c                            | 2 +-
 net/xfrm/xfrm_interface_bpf.c                         | 2 +-
 net/xfrm/xfrm_state_bpf.c                             | 2 +-
 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c | 2 +-
 22 files changed, 33 insertions(+), 27 deletions(-)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index d9ef45fcaeab..e277b74e8831 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -172,7 +172,7 @@ hid_bpf_get_data(struct hid_bpf_ctx *ctx, unsigned int offset, const size_t rdwr
  * The following set contains all functions we agree BPF programs
  * can use.
  */
-BTF_SET8_START(hid_bpf_kfunc_ids)
+BTF_SET8_START(hid_bpf_kfunc_ids, BTF_SET8_KFUNC)
 BTF_ID_FLAGS(func, hid_bpf_get_data, KF_RET_NULL)
 BTF_SET8_END(hid_bpf_kfunc_ids)
 
@@ -440,7 +440,7 @@ static const struct btf_kfunc_id_set hid_bpf_fmodret_set = {
 };
 
 /* for syscall HID-BPF */
-BTF_SET8_START(hid_bpf_syscall_kfunc_ids)
+BTF_SET8_START(hid_bpf_syscall_kfunc_ids, BTF_SET8_KFUNC)
 BTF_ID_FLAGS(func, hid_bpf_attach_prog)
 BTF_ID_FLAGS(func, hid_bpf_allocate_context, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, hid_bpf_release_context, KF_RELEASE)
diff --git a/fs/verity/measure.c b/fs/verity/measure.c
index bf7a5f4cccaf..7e6c4ad9f8ce 100644
--- a/fs/verity/measure.c
+++ b/fs/verity/measure.c
@@ -159,7 +159,7 @@ __bpf_kfunc int bpf_get_fsverity_digest(struct file *file, struct bpf_dynptr_ker
 
 __bpf_kfunc_end_defs();
 
-BTF_SET8_START(fsverity_set_ids)
+BTF_SET8_START(fsverity_set_ids, BTF_SET8_KFUNC)
 BTF_ID_FLAGS(func, bpf_get_fsverity_digest, KF_TRUSTED_ARGS)
 BTF_SET8_END(fsverity_set_ids)
 
diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index 88f914579fa1..771e29762a2d 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -8,6 +8,9 @@ struct btf_id_set {
 	u32 ids[];
 };
 
+/* This flag implies BTF_SET8 holds kfunc(s) */
+#define BTF_SET8_KFUNC		(1 << 0)
+
 struct btf_id_set8 {
 	u32 cnt;
 	u32 flags;
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 51e8b4bee0c8..b8ba00a4179f 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7769,6 +7769,9 @@ static int __register_btf_kfunc_id_set(enum btf_kfunc_hook hook,
 	struct btf *btf;
 	int ret, i;
 
+	/* All kfuncs need to be tagged as such in BTF */
+	WARN_ON(!(kset->set->flags & BTF_SET8_KFUNC));
+
 	btf = btf_get_module_btf(kset->owner);
 	if (!btf) {
 		if (!kset->owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) {
diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
index 2e73533a3811..4155c479cc2f 100644
--- a/kernel/bpf/cpumask.c
+++ b/kernel/bpf/cpumask.c
@@ -424,7 +424,7 @@ __bpf_kfunc u32 bpf_cpumask_weight(const struct cpumask *cpumask)
 
 __bpf_kfunc_end_defs();
 
-BTF_SET8_START(cpumask_kfunc_btf_ids)
+BTF_SET8_START(cpumask_kfunc_btf_ids, BTF_SET8_KFUNC)
 BTF_ID_FLAGS(func, bpf_cpumask_create, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_cpumask_release, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_cpumask_acquire, KF_ACQUIRE | KF_TRUSTED_ARGS)
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index be72824f32b2..c4c2a3bd36f6 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2543,7 +2543,7 @@ __bpf_kfunc void bpf_throw(u64 cookie)
 
 __bpf_kfunc_end_defs();
 
-BTF_SET8_START(generic_btf_ids)
+BTF_SET8_START(generic_btf_ids, BTF_SET8_KFUNC)
 #ifdef CONFIG_KEXEC_CORE
 BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
 #endif
@@ -2588,7 +2588,7 @@ BTF_ID(struct, cgroup)
 BTF_ID(func, bpf_cgroup_release_dtor)
 #endif
 
-BTF_SET8_START(common_btf_ids)
+BTF_SET8_START(common_btf_ids, BTF_SET8_KFUNC)
 BTF_ID_FLAGS(func, bpf_cast_to_kern_ctx)
 BTF_ID_FLAGS(func, bpf_rdonly_cast)
 BTF_ID_FLAGS(func, bpf_rcu_read_lock)
diff --git a/kernel/bpf/map_iter.c b/kernel/bpf/map_iter.c
index 6abd7c5df4b3..225c70e88cb7 100644
--- a/kernel/bpf/map_iter.c
+++ b/kernel/bpf/map_iter.c
@@ -213,7 +213,7 @@ __bpf_kfunc s64 bpf_map_sum_elem_count(const struct bpf_map *map)
 
 __bpf_kfunc_end_defs();
 
-BTF_SET8_START(bpf_map_iter_kfunc_ids)
+BTF_SET8_START(bpf_map_iter_kfunc_ids, BTF_SET8_KFUNC)
 BTF_ID_FLAGS(func, bpf_map_sum_elem_count, KF_TRUSTED_ARGS)
 BTF_SET8_END(bpf_map_iter_kfunc_ids)
 
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index c0adb7254b45..732df57b7c1d 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -520,7 +520,7 @@ void cgroup_base_stat_cputime_show(struct seq_file *seq)
 }
 
 /* Add bpf kfuncs for cgroup_rstat_updated() and cgroup_rstat_flush() */
-BTF_SET8_START(bpf_rstat_kfunc_ids)
+BTF_SET8_START(bpf_rstat_kfunc_ids, BTF_SET8_KFUNC)
 BTF_ID_FLAGS(func, cgroup_rstat_updated)
 BTF_ID_FLAGS(func, cgroup_rstat_flush, KF_SLEEPABLE)
 BTF_SET8_END(bpf_rstat_kfunc_ids)
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 7ac6c52b25eb..bf1ef600e4d2 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1412,7 +1412,7 @@ __bpf_kfunc int bpf_verify_pkcs7_signature(struct bpf_dynptr_kern *data_ptr,
 
 __bpf_kfunc_end_defs();
 
-BTF_SET8_START(key_sig_kfunc_set)
+BTF_SET8_START(key_sig_kfunc_set, BTF_SET8_KFUNC)
 BTF_ID_FLAGS(func, bpf_lookup_user_key, KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_lookup_system_key, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_key_put, KF_RELEASE)
@@ -1475,7 +1475,7 @@ __bpf_kfunc int bpf_get_file_xattr(struct file *file, const char *name__str,
 
 __bpf_kfunc_end_defs();
 
-BTF_SET8_START(fs_kfunc_set_ids)
+BTF_SET8_START(fs_kfunc_set_ids, BTF_SET8_KFUNC)
 BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
 BTF_SET8_END(fs_kfunc_set_ids)
 
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index dfd919374017..18b91612931d 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -617,7 +617,7 @@ CFI_NOSEAL(bpf_kfunc_call_memb_release_dtor);
 
 __bpf_kfunc_end_defs();
 
-BTF_SET8_START(bpf_test_modify_return_ids)
+BTF_SET8_START(bpf_test_modify_return_ids, BTF_SET8_KFUNC)
 BTF_ID_FLAGS(func, bpf_modify_return_test)
 BTF_ID_FLAGS(func, bpf_modify_return_test2)
 BTF_ID_FLAGS(func, bpf_fentry_test1, KF_SLEEPABLE)
@@ -628,7 +628,7 @@ static const struct btf_kfunc_id_set bpf_test_modify_return_set = {
 	.set   = &bpf_test_modify_return_ids,
 };
 
-BTF_SET8_START(test_sk_check_kfunc_ids)
+BTF_SET8_START(test_sk_check_kfunc_ids, BTF_SET8_KFUNC)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_release, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_kfunc_call_memb_release, KF_RELEASE)
 BTF_SET8_END(test_sk_check_kfunc_ids)
diff --git a/net/core/filter.c b/net/core/filter.c
index 24061f29c9dd..f278a3976f61 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11853,15 +11853,15 @@ int bpf_dynptr_from_skb_rdonly(struct sk_buff *skb, u64 flags,
 	return 0;
 }
 
-BTF_SET8_START(bpf_kfunc_check_set_skb)
+BTF_SET8_START(bpf_kfunc_check_set_skb, BTF_SET8_KFUNC)
 BTF_ID_FLAGS(func, bpf_dynptr_from_skb)
 BTF_SET8_END(bpf_kfunc_check_set_skb)
 
-BTF_SET8_START(bpf_kfunc_check_set_xdp)
+BTF_SET8_START(bpf_kfunc_check_set_xdp, BTF_SET8_KFUNC)
 BTF_ID_FLAGS(func, bpf_dynptr_from_xdp)
 BTF_SET8_END(bpf_kfunc_check_set_xdp)
 
-BTF_SET8_START(bpf_kfunc_check_set_sock_addr)
+BTF_SET8_START(bpf_kfunc_check_set_sock_addr, BTF_SET8_KFUNC)
 BTF_ID_FLAGS(func, bpf_sock_addr_set_sun_path)
 BTF_SET8_END(bpf_kfunc_check_set_sock_addr)
 
@@ -11936,7 +11936,7 @@ __bpf_kfunc int bpf_sock_destroy(struct sock_common *sock)
 
 __bpf_kfunc_end_defs();
 
-BTF_SET8_START(bpf_sk_iter_kfunc_ids)
+BTF_SET8_START(bpf_sk_iter_kfunc_ids, BTF_SET8_KFUNC)
 BTF_ID_FLAGS(func, bpf_sock_destroy, KF_TRUSTED_ARGS)
 BTF_SET8_END(bpf_sk_iter_kfunc_ids)
 
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 4869c1c2d8f3..84a01fb26f41 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -771,7 +771,7 @@ __bpf_kfunc int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
 
 __bpf_kfunc_end_defs();
 
-BTF_SET8_START(xdp_metadata_kfunc_ids)
+BTF_SET8_START(xdp_metadata_kfunc_ids, BTF_SET8_KFUNC)
 #define XDP_METADATA_KFUNC(_, __, name, ___) BTF_ID_FLAGS(func, name, KF_TRUSTED_ARGS)
 XDP_METADATA_KFUNC_xxx
 #undef XDP_METADATA_KFUNC
diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index ae8b15e6896f..096918e9f93f 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -195,7 +195,7 @@ bpf_tcp_ca_get_func_proto(enum bpf_func_id func_id,
 	}
 }
 
-BTF_SET8_START(bpf_tcp_ca_check_kfunc_ids)
+BTF_SET8_START(bpf_tcp_ca_check_kfunc_ids, BTF_SET8_KFUNC)
 BTF_ID_FLAGS(func, tcp_reno_ssthresh)
 BTF_ID_FLAGS(func, tcp_reno_cong_avoid)
 BTF_ID_FLAGS(func, tcp_reno_undo_cwnd)
diff --git a/net/ipv4/fou_bpf.c b/net/ipv4/fou_bpf.c
index 4da03bf45c9b..e527be123f79 100644
--- a/net/ipv4/fou_bpf.c
+++ b/net/ipv4/fou_bpf.c
@@ -100,7 +100,7 @@ __bpf_kfunc int bpf_skb_get_fou_encap(struct __sk_buff *skb_ctx,
 
 __bpf_kfunc_end_defs();
 
-BTF_SET8_START(fou_kfunc_set)
+BTF_SET8_START(fou_kfunc_set, BTF_SET8_KFUNC)
 BTF_ID_FLAGS(func, bpf_skb_set_fou_encap)
 BTF_ID_FLAGS(func, bpf_skb_get_fou_encap)
 BTF_SET8_END(fou_kfunc_set)
diff --git a/net/ipv4/tcp_bbr.c b/net/ipv4/tcp_bbr.c
index 22358032dd48..dbf904312292 100644
--- a/net/ipv4/tcp_bbr.c
+++ b/net/ipv4/tcp_bbr.c
@@ -1155,7 +1155,7 @@ static struct tcp_congestion_ops tcp_bbr_cong_ops __read_mostly = {
 	.set_state	= bbr_set_state,
 };
 
-BTF_SET8_START(tcp_bbr_check_kfunc_ids)
+BTF_SET8_START(tcp_bbr_check_kfunc_ids, BTF_SET8_KFUNC)
 #ifdef CONFIG_X86
 #ifdef CONFIG_DYNAMIC_FTRACE
 BTF_ID_FLAGS(func, bbr_init)
diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
index 0fd78ecb67e7..b10bbc1cbc14 100644
--- a/net/ipv4/tcp_cubic.c
+++ b/net/ipv4/tcp_cubic.c
@@ -485,7 +485,7 @@ static struct tcp_congestion_ops cubictcp __read_mostly = {
 	.name		= "cubic",
 };
 
-BTF_SET8_START(tcp_cubic_check_kfunc_ids)
+BTF_SET8_START(tcp_cubic_check_kfunc_ids, BTF_SET8_KFUNC)
 #ifdef CONFIG_X86
 #ifdef CONFIG_DYNAMIC_FTRACE
 BTF_ID_FLAGS(func, cubictcp_init)
diff --git a/net/ipv4/tcp_dctcp.c b/net/ipv4/tcp_dctcp.c
index bb23bb5b387a..2d2a8ba3e19e 100644
--- a/net/ipv4/tcp_dctcp.c
+++ b/net/ipv4/tcp_dctcp.c
@@ -260,7 +260,7 @@ static struct tcp_congestion_ops dctcp_reno __read_mostly = {
 	.name		= "dctcp-reno",
 };
 
-BTF_SET8_START(tcp_dctcp_check_kfunc_ids)
+BTF_SET8_START(tcp_dctcp_check_kfunc_ids, BTF_SET8_KFUNC)
 #ifdef CONFIG_X86
 #ifdef CONFIG_DYNAMIC_FTRACE
 BTF_ID_FLAGS(func, dctcp_init)
diff --git a/net/netfilter/nf_conntrack_bpf.c b/net/netfilter/nf_conntrack_bpf.c
index 475358ec8212..329b3f2a68d0 100644
--- a/net/netfilter/nf_conntrack_bpf.c
+++ b/net/netfilter/nf_conntrack_bpf.c
@@ -467,7 +467,7 @@ __bpf_kfunc int bpf_ct_change_status(struct nf_conn *nfct, u32 status)
 
 __bpf_kfunc_end_defs();
 
-BTF_SET8_START(nf_ct_kfunc_set)
+BTF_SET8_START(nf_ct_kfunc_set, BTF_SET8_KFUNC)
 BTF_ID_FLAGS(func, bpf_xdp_ct_alloc, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_xdp_ct_lookup, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_skb_ct_alloc, KF_ACQUIRE | KF_RET_NULL)
diff --git a/net/netfilter/nf_nat_bpf.c b/net/netfilter/nf_nat_bpf.c
index 6e3b2f58855f..22237dda59df 100644
--- a/net/netfilter/nf_nat_bpf.c
+++ b/net/netfilter/nf_nat_bpf.c
@@ -54,7 +54,7 @@ __bpf_kfunc int bpf_ct_set_nat_info(struct nf_conn___init *nfct,
 
 __bpf_kfunc_end_defs();
 
-BTF_SET8_START(nf_nat_kfunc_set)
+BTF_SET8_START(nf_nat_kfunc_set, BTF_SET8_KFUNC)
 BTF_ID_FLAGS(func, bpf_ct_set_nat_info, KF_TRUSTED_ARGS)
 BTF_SET8_END(nf_nat_kfunc_set)
 
diff --git a/net/xfrm/xfrm_interface_bpf.c b/net/xfrm/xfrm_interface_bpf.c
index 7d5e920141e9..484cc727a253 100644
--- a/net/xfrm/xfrm_interface_bpf.c
+++ b/net/xfrm/xfrm_interface_bpf.c
@@ -93,7 +93,7 @@ __bpf_kfunc int bpf_skb_set_xfrm_info(struct __sk_buff *skb_ctx, const struct bp
 
 __bpf_kfunc_end_defs();
 
-BTF_SET8_START(xfrm_ifc_kfunc_set)
+BTF_SET8_START(xfrm_ifc_kfunc_set, BTF_SET8_KFUNC)
 BTF_ID_FLAGS(func, bpf_skb_get_xfrm_info)
 BTF_ID_FLAGS(func, bpf_skb_set_xfrm_info)
 BTF_SET8_END(xfrm_ifc_kfunc_set)
diff --git a/net/xfrm/xfrm_state_bpf.c b/net/xfrm/xfrm_state_bpf.c
index 9e20d4a377f7..d22276b003b4 100644
--- a/net/xfrm/xfrm_state_bpf.c
+++ b/net/xfrm/xfrm_state_bpf.c
@@ -117,7 +117,7 @@ __bpf_kfunc void bpf_xdp_xfrm_state_release(struct xfrm_state *x)
 
 __bpf_kfunc_end_defs();
 
-BTF_SET8_START(xfrm_state_kfunc_set)
+BTF_SET8_START(xfrm_state_kfunc_set, BTF_SET8_KFUNC)
 BTF_ID_FLAGS(func, bpf_xdp_get_xfrm_state, KF_RET_NULL | KF_ACQUIRE)
 BTF_ID_FLAGS(func, bpf_xdp_xfrm_state_release, KF_RELEASE)
 BTF_SET8_END(xfrm_state_kfunc_set)
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 91907b321f91..32972334cd50 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -341,7 +341,7 @@ static struct bin_attribute bin_attr_bpf_testmod_file __ro_after_init = {
 	.write = bpf_testmod_test_write,
 };
 
-BTF_SET8_START(bpf_testmod_common_kfunc_ids)
+BTF_SET8_START(bpf_testmod_common_kfunc_ids, BTF_SET8_KFUNC)
 BTF_ID_FLAGS(func, bpf_iter_testmod_seq_new, KF_ITER_NEW)
 BTF_ID_FLAGS(func, bpf_iter_testmod_seq_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_testmod_seq_destroy, KF_ITER_DESTROY)
-- 
2.42.1


