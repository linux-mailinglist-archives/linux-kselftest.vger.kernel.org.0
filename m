Return-Path: <linux-kselftest+bounces-6177-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3247F877CF2
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 10:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B173A1F22396
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 09:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22BD33CCD;
	Mon, 11 Mar 2024 09:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Apr8dFol"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254771B7E6
	for <linux-kselftest@vger.kernel.org>; Mon, 11 Mar 2024 09:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710149693; cv=none; b=FPlWXvArUCjjZIe50ZBLpi0h6eepf1XBOW6rhl666VLrvp0KWAhafg1RHtIqKXbouGXlVbrvrRFjU/4DVy6830cSln/HLcdWTGRID4nLf3yvqbMjI6YvZMQH3d7K/GnQgC7cYFeiO/j+BVP0h1/Ye479mUFQ35M0TECAEO9xr8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710149693; c=relaxed/simple;
	bh=psimS0wzeI7K4nzqHSfGPy0FHbSCjN3PwoDSpYIzP0E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qrRVaeS4GMz6BAb98gHyDjqbVcuitXfmo/L7UXQTIQSiDNo/cYqgZV3lkl5c5dbvSLYgS+JAZVIkfFwTFZKmsCfN81CP+J2xxCLwmF2iwQefgK0VYVY9LWXJ6h0tCeO/etZRV4GARPadJEtdc63u1jh6AuYOrvL1DRYI3l2xuv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Apr8dFol; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5dbf7b74402so3123251a12.0
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Mar 2024 02:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1710149691; x=1710754491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vy46p1zwEtiQYPk8lFao3bF3SRbHkbUPWpJ3i7/28CA=;
        b=Apr8dFolm9X4bDXDnfetwC2bk9YnnNdo/V6aZrag9DFa0pDXcXqt9Wqfo/pli8xBkW
         B84effd3TlVLQrLeDRkoqFxVU72KK0bIEipQl2529zf+3yRnjEfWWa3U1nXgXJEjg8Ov
         /UgP7SAxggAz9SbkP57RMoMWfjcV5MyLOpvOzusI5nxHE0PsxVMKDFNqfPOSq6zmzjXz
         nqqfSnZJs6GlzEUGf6N9kcsJFtJRjJE8axQEFDi2tvUxiyziQ98cme/Ad0lHdWL5yGwB
         zJDK9HRt4Bv93u3HhxTgeDeJ/5epKEUNJ4fLPnDHjve1+pfMKImrUeXaEgYUdgtKZ4l7
         mtGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710149691; x=1710754491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vy46p1zwEtiQYPk8lFao3bF3SRbHkbUPWpJ3i7/28CA=;
        b=oR+ffPbCUV1lmbsB93i8ujiG1kDAPuMrigTqYYZmw2csJO0xk5xn9RZKUkmoC1MXo7
         IxI9jJnJz5N2gmqr3pJI6+czJjqXVYtwhBn75QCUywhMdSDuKXQhBx+mGxwRR7+15BHH
         dhslTAK8SfFovhN3WKtMmERTPozF8a/SvttMRWiKGiTJzg+vumCtBvJshGzdQv500FtT
         M5iIwYGCiZl3U0+3/LEVahvRM1RelCXUnOAbogGy0RxXgGW930TtI8a881WOM1X/gD0P
         yD7hFTh4PLLP+PWEPulF4zEixw379tYzJFe7bH6NN8dYIZzOokeMk+VztDiKhzII3jKI
         wNWA==
X-Forwarded-Encrypted: i=1; AJvYcCUhtMrensaGWjfeH23tmiz0ARZFsn8TcRAepa5RjoUy07joArlJCNLp326v46knu+Mdp0LVVVBeAsvbqqnJWRda0jMlXXMziixEJJ9ROhye
X-Gm-Message-State: AOJu0Yzv/5YnpiqGgIb1rf8kix2FGM5iRpoif1BzYEXvmegPqKtXVuih
	k1KB+ETANYxdPV9/QTrpmx1QS+cuOuq22Q8SaYSmmHd0atimAyi/QQyZFxg91xY=
X-Google-Smtp-Source: AGHT+IFjBcGV00k1T/PRAurGJKimsKfvd3nWSQWSksUKxJJH0GZ/AViWHcHFMZ3KmKpuqEbt5SPRAA==
X-Received: by 2002:a05:6a20:96d1:b0:1a1:86e9:ef9b with SMTP id hq17-20020a056a2096d100b001a186e9ef9bmr3095077pzc.18.1710149691293;
        Mon, 11 Mar 2024 02:34:51 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902f7c900b001dcad9cbf8bsm4253365plw.239.2024.03.11.02.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 02:34:51 -0700 (PDT)
From: Menglong Dong <dongmenglong.8@bytedance.com>
To: andrii@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	quentin@isovalent.com,
	bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Menglong Dong <dongmenglong.8@bytedance.com>
Subject: [PATCH bpf-next v2 3/9] bpf: trampoline: introduce struct bpf_tramp_link_conn
Date: Mon, 11 Mar 2024 17:35:20 +0800
Message-Id: <20240311093526.1010158-4-dongmenglong.8@bytedance.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240311093526.1010158-1-dongmenglong.8@bytedance.com>
References: <20240311093526.1010158-1-dongmenglong.8@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, bpf_tramp_link is added to the hash list of tr->progs_hlist when
attaching. This means that bpf_link and trampoline is one-to-one, and is
not friendly to the multi-link trampoline that we commit in the following
patches.

Therefore, now we introduce the struct bpf_tramp_link_conn to be the
bridge between bpf_tramp_link and trampoline. And we also chang the type
of links in struct bpf_tramp_links to struct bpf_tramp_link_conn.

Signed-off-by: Menglong Dong <dongmenglong.8@bytedance.com>
---
 arch/arm64/net/bpf_jit_comp.c   |  4 ++--
 arch/riscv/net/bpf_jit_comp64.c |  4 ++--
 arch/s390/net/bpf_jit_comp.c    |  4 ++--
 arch/x86/net/bpf_jit_comp.c     |  4 ++--
 include/linux/bpf.h             | 12 +++++++---
 kernel/bpf/bpf_struct_ops.c     |  3 ++-
 kernel/bpf/syscall.c            |  3 ++-
 kernel/bpf/trampoline.c         | 42 +++++++++++++++++----------------
 net/bpf/bpf_dummy_struct_ops.c  |  1 +
 9 files changed, 44 insertions(+), 33 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index c5b461dda438..b6f7d8a6d372 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1810,14 +1810,14 @@ bool bpf_jit_supports_subprog_tailcalls(void)
 	return true;
 }
 
-static void invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_link *l,
+static void invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_link_conn *l,
 			    int args_off, int retval_off, int run_ctx_off,
 			    bool save_ret)
 {
 	__le32 *branch;
 	u64 enter_prog;
 	u64 exit_prog;
-	struct bpf_prog *p = l->link.prog;
+	struct bpf_prog *p = l->link->prog;
 	int cookie_off = offsetof(struct bpf_tramp_run_ctx, bpf_cookie);
 
 	enter_prog = (u64)bpf_trampoline_enter(p);
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index aac190085472..c147053001db 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -700,11 +700,11 @@ static void restore_args(int nregs, int args_off, struct rv_jit_context *ctx)
 	}
 }
 
-static int invoke_bpf_prog(struct bpf_tramp_link *l, int args_off, int retval_off,
+static int invoke_bpf_prog(struct bpf_tramp_link_conn *l, int args_off, int retval_off,
 			   int run_ctx_off, bool save_ret, struct rv_jit_context *ctx)
 {
 	int ret, branch_off;
-	struct bpf_prog *p = l->link.prog;
+	struct bpf_prog *p = l->link->prog;
 	int cookie_off = offsetof(struct bpf_tramp_run_ctx, bpf_cookie);
 
 	if (l->cookie) {
diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index b418333bb086..177efbc1b5ec 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -2243,12 +2243,12 @@ static void load_imm64(struct bpf_jit *jit, int dst_reg, u64 val)
 
 static int invoke_bpf_prog(struct bpf_tramp_jit *tjit,
 			   const struct btf_func_model *m,
-			   struct bpf_tramp_link *tlink, bool save_ret)
+			   struct bpf_tramp_link_conn *tlink, bool save_ret)
 {
 	struct bpf_jit *jit = &tjit->common;
 	int cookie_off = tjit->run_ctx_off +
 			 offsetof(struct bpf_tramp_run_ctx, bpf_cookie);
-	struct bpf_prog *p = tlink->link.prog;
+	struct bpf_prog *p = tlink->link->prog;
 	int patch;
 
 	/*
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index e1390d1e331b..e7f9f987770d 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2261,14 +2261,14 @@ static void restore_regs(const struct btf_func_model *m, u8 **prog,
 }
 
 static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
-			   struct bpf_tramp_link *l, int stack_size,
+			   struct bpf_tramp_link_conn *l, int stack_size,
 			   int run_ctx_off, bool save_ret,
 			   void *image, void *rw_image)
 {
 	u8 *prog = *pprog;
 	u8 *jmp_insn;
 	int ctx_cookie_off = offsetof(struct bpf_tramp_run_ctx, bpf_cookie);
-	struct bpf_prog *p = l->link.prog;
+	struct bpf_prog *p = l->link->prog;
 	u64 cookie = l->cookie;
 
 	/* mov rdi, cookie */
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 997765cdf474..2b5cd6100fc4 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -56,6 +56,7 @@ struct bpf_token;
 struct user_namespace;
 struct super_block;
 struct inode;
+struct bpf_tramp_link;
 
 extern struct idr btf_idr;
 extern spinlock_t btf_idr_lock;
@@ -1090,7 +1091,7 @@ enum {
 };
 
 struct bpf_tramp_links {
-	struct bpf_tramp_link *links[BPF_MAX_TRAMP_LINKS];
+	struct bpf_tramp_link_conn *links[BPF_MAX_TRAMP_LINKS];
 	int nr_links;
 };
 
@@ -1597,12 +1598,17 @@ struct bpf_link_ops {
 			  struct bpf_map *old_map);
 };
 
-struct bpf_tramp_link {
-	struct bpf_link link;
+struct bpf_tramp_link_conn {
+	struct bpf_link *link;
 	struct hlist_node tramp_hlist;
 	u64 cookie;
 };
 
+struct bpf_tramp_link {
+	struct bpf_link link;
+	struct bpf_tramp_link_conn conn;
+};
+
 struct bpf_shim_tramp_link {
 	struct bpf_tramp_link link;
 	struct bpf_trampoline *trampoline;
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 43356faaa057..4fbe2faa80a8 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -549,7 +549,7 @@ int bpf_struct_ops_prepare_trampoline(struct bpf_tramp_links *tlinks,
 	void *image = *_image;
 	int size;
 
-	tlinks[BPF_TRAMP_FENTRY].links[0] = link;
+	tlinks[BPF_TRAMP_FENTRY].links[0] = &link->conn;
 	tlinks[BPF_TRAMP_FENTRY].nr_links = 1;
 
 	if (model->ret_size > 0)
@@ -710,6 +710,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 			err = -ENOMEM;
 			goto reset_unlock;
 		}
+		link->conn.link = &link->link;
 		bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS,
 			      &bpf_struct_ops_link_lops, prog);
 		st_map->links[i] = &link->link;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 4f230fd1f8e4..d1cd645ef9ac 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3339,6 +3339,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 	}
 
 	link = kzalloc(sizeof(*link), GFP_USER);
+	link->link.conn.link = &link->link.link;
 	if (!link) {
 		err = -ENOMEM;
 		goto out_put_prog;
@@ -3346,7 +3347,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 	bpf_link_init(&link->link.link, BPF_LINK_TYPE_TRACING,
 		      &bpf_tracing_link_lops, prog);
 	link->attach_type = prog->expected_attach_type;
-	link->link.cookie = bpf_cookie;
+	link->link.conn.cookie = bpf_cookie;
 
 	mutex_lock(&prog->aux->dst_mutex);
 
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index d382f5ebe06c..cf9b84f785f3 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -228,9 +228,9 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
 static struct bpf_tramp_links *
 bpf_trampoline_get_progs(const struct bpf_trampoline *tr, int *total, bool *ip_arg)
 {
-	struct bpf_tramp_link *link;
+	struct bpf_tramp_link_conn *link_conn;
+	struct bpf_tramp_link_conn **links;
 	struct bpf_tramp_links *tlinks;
-	struct bpf_tramp_link **links;
 	int kind;
 
 	*total = 0;
@@ -243,9 +243,9 @@ bpf_trampoline_get_progs(const struct bpf_trampoline *tr, int *total, bool *ip_a
 		*total += tr->progs_cnt[kind];
 		links = tlinks[kind].links;
 
-		hlist_for_each_entry(link, &tr->progs_hlist[kind], tramp_hlist) {
-			*ip_arg |= link->link.prog->call_get_func_ip;
-			*links++ = link;
+		hlist_for_each_entry(link_conn, &tr->progs_hlist[kind], tramp_hlist) {
+			*ip_arg |= link_conn->link->prog->call_get_func_ip;
+			*links++ = link_conn;
 		}
 	}
 	return tlinks;
@@ -521,14 +521,14 @@ static enum bpf_tramp_prog_type bpf_attach_type_to_tramp(struct bpf_prog *prog)
 	}
 }
 
-static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_trampoline *tr)
+static int __bpf_trampoline_link_prog(struct bpf_tramp_link_conn *link, struct bpf_trampoline *tr)
 {
 	enum bpf_tramp_prog_type kind;
-	struct bpf_tramp_link *link_exiting;
+	struct bpf_tramp_link_conn *link_exiting;
 	int err = 0;
 	int cnt = 0, i;
 
-	kind = bpf_attach_type_to_tramp(link->link.prog);
+	kind = bpf_attach_type_to_tramp(link->link->prog);
 	if (tr->extension_prog)
 		/* cannot attach fentry/fexit if extension prog is attached.
 		 * cannot overwrite extension prog either.
@@ -542,9 +542,9 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_tr
 		/* Cannot attach extension if fentry/fexit are in use. */
 		if (cnt)
 			return -EBUSY;
-		tr->extension_prog = link->link.prog;
+		tr->extension_prog = link->link->prog;
 		return bpf_arch_text_poke(tr->func.addr, BPF_MOD_JUMP, NULL,
-					  link->link.prog->bpf_func);
+					  link->link->prog->bpf_func);
 	}
 	if (cnt >= BPF_MAX_TRAMP_LINKS)
 		return -E2BIG;
@@ -552,7 +552,7 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_tr
 		/* prog already linked */
 		return -EBUSY;
 	hlist_for_each_entry(link_exiting, &tr->progs_hlist[kind], tramp_hlist) {
-		if (link_exiting->link.prog != link->link.prog)
+		if (link_exiting->link->prog != link->link->prog)
 			continue;
 		/* prog already linked */
 		return -EBUSY;
@@ -573,17 +573,17 @@ int bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_trampoline
 	int err;
 
 	mutex_lock(&tr->mutex);
-	err = __bpf_trampoline_link_prog(link, tr);
+	err = __bpf_trampoline_link_prog(&link->conn, tr);
 	mutex_unlock(&tr->mutex);
 	return err;
 }
 
-static int __bpf_trampoline_unlink_prog(struct bpf_tramp_link *link, struct bpf_trampoline *tr)
+static int __bpf_trampoline_unlink_prog(struct bpf_tramp_link_conn *link, struct bpf_trampoline *tr)
 {
 	enum bpf_tramp_prog_type kind;
 	int err;
 
-	kind = bpf_attach_type_to_tramp(link->link.prog);
+	kind = bpf_attach_type_to_tramp(link->link->prog);
 	if (kind == BPF_TRAMP_REPLACE) {
 		WARN_ON_ONCE(!tr->extension_prog);
 		err = bpf_arch_text_poke(tr->func.addr, BPF_MOD_JUMP,
@@ -602,7 +602,7 @@ int bpf_trampoline_unlink_prog(struct bpf_tramp_link *link, struct bpf_trampolin
 	int err;
 
 	mutex_lock(&tr->mutex);
-	err = __bpf_trampoline_unlink_prog(link, tr);
+	err = __bpf_trampoline_unlink_prog(&link->conn, tr);
 	mutex_unlock(&tr->mutex);
 	return err;
 }
@@ -645,6 +645,7 @@ static struct bpf_shim_tramp_link *cgroup_shim_alloc(const struct bpf_prog *prog
 	if (!shim_link)
 		return NULL;
 
+	shim_link->link.conn.link = &shim_link->link.link;
 	p = bpf_prog_alloc(1, 0);
 	if (!p) {
 		kfree(shim_link);
@@ -672,15 +673,16 @@ static struct bpf_shim_tramp_link *cgroup_shim_alloc(const struct bpf_prog *prog
 static struct bpf_shim_tramp_link *cgroup_shim_find(struct bpf_trampoline *tr,
 						    bpf_func_t bpf_func)
 {
-	struct bpf_tramp_link *link;
+	struct bpf_tramp_link_conn *link_conn;
 	int kind;
 
 	for (kind = 0; kind < BPF_TRAMP_MAX; kind++) {
-		hlist_for_each_entry(link, &tr->progs_hlist[kind], tramp_hlist) {
-			struct bpf_prog *p = link->link.prog;
+		hlist_for_each_entry(link_conn, &tr->progs_hlist[kind], tramp_hlist) {
+			struct bpf_prog *p = link_conn->link->prog;
 
 			if (p->bpf_func == bpf_func)
-				return container_of(link, struct bpf_shim_tramp_link, link);
+				return container_of((struct bpf_tramp_link *)link_conn->link,
+						    struct bpf_shim_tramp_link, link);
 		}
 	}
 
@@ -731,7 +733,7 @@ int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
 		goto err;
 	}
 
-	err = __bpf_trampoline_link_prog(&shim_link->link, tr);
+	err = __bpf_trampoline_link_prog(&shim_link->link.conn, tr);
 	if (err)
 		goto err;
 
diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_ops.c
index 1b5f812e6972..35a2cf60eef6 100644
--- a/net/bpf/bpf_dummy_struct_ops.c
+++ b/net/bpf/bpf_dummy_struct_ops.c
@@ -120,6 +120,7 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
 		err = -ENOMEM;
 		goto out;
 	}
+	link->conn.link = &link->link;
 	/* prog doesn't take the ownership of the reference from caller */
 	bpf_prog_inc(prog);
 	bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS, &bpf_struct_ops_link_lops, prog);
-- 
2.39.2


