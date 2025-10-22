Return-Path: <linux-kselftest+bounces-43755-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B19BFBA77
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 13:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C7E2480600
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 11:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3262532E6A5;
	Wed, 22 Oct 2025 11:34:34 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from localhost.localdomain (unknown [147.136.157.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9550FCA6B;
	Wed, 22 Oct 2025 11:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.136.157.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761132874; cv=none; b=f3tIX2dCDVf/qYeNiH6Ym4yeM+YV2svdw3eGpqZSCEpE+mABG4mCrlX3tvyfpSVLCUc5rsoURE3S/KNa68QiSxwLWQsMBb4m4tVbSpMunKxMlFL4XahuYfL7IwaBCHhKKksde1W1QWGBV0j+Fqc3flARBPzakZPHcfBt5+lTKM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761132874; c=relaxed/simple;
	bh=lqZuVsh6cqTUJ2qP8Rezj8NoXhCSbR1HxzDKh5rwqi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SE04Y89hDHp3mzf+tmWUlbgD3XFNm27mG2dhaJNzq/B03w6WTgWXJJ/XWGetfcul6iWXL0wqdV4jU95YYEfpNUAw7PWF+bskKhqfxvaC+gWtyvOu5sg3rssMEzsgCg5k5atzsaZtHmd59Z1HmQsYRWwLQF0O6LMv6e4TWHdOh80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=none smtp.mailfrom=localhost.localdomain; arc=none smtp.client-ip=147.136.157.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=localhost.localdomain
Received: by localhost.localdomain (Postfix, from userid 1007)
	id D7B758B2A0D; Wed, 22 Oct 2025 19:34:30 +0800 (+08)
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v1 1/2] bpf: Add kfuncs for detecting execution context
Date: Wed, 22 Oct 2025 19:33:32 +0800
Message-ID: <20251022113412.352307-2-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022113412.352307-1-jiayuan.chen@linux.dev>
References: <20251022113412.352307-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This path introduces several kfuncs to help BPF programs determine their
current execution context. When hooking functions for statistics, we often
need to use current->comm to get the process name.

However, these hooked functions can be called from either process context
or interrupt context. When called from interrupt context, the current we
obtain may refer to the process that was interrupted, which may not be
what we need.

These new kfuncs expose APIs that allow users to determine the actual
execution context.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 kernel/bpf/helpers.c | 45 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b9ec6ee21c94..e09c70b4eaea 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4252,6 +4252,47 @@ __bpf_kfunc int bpf_task_work_schedule_resume(struct task_struct *task, struct b
 	return bpf_task_work_schedule(task, tw, map__map, callback, aux__prog, TWA_RESUME);
 }
 
+/**
+ * bpf_in_nmi_context - Check whether we are serving NMI
+ *
+ * Return: true if we are serving NMI
+ */
+__bpf_kfunc bool bpf_in_nmi_context(void)
+{
+	return in_nmi();
+}
+
+/**
+ * bpf_in_hardirq_context - Check whether we are serving hard irq
+ *
+ * Return: true if we are serving hard irq
+ */
+__bpf_kfunc bool bpf_in_hardirq_context(void)
+{
+	return in_hardirq();
+}
+
+/**
+ * bpf_in_softirq_context - Check whether we are serving soft irq
+ *
+ * Return: true if we are serving soft irq
+ */
+__bpf_kfunc bool bpf_in_softirq_context(void)
+{
+	/* in_softirq() has been deprecated */
+	return in_serving_softirq();
+}
+
+/**
+ * bpf_in_task_context - Check whether we are in task context
+ *
+ * Return: true if we are in task context
+ */
+__bpf_kfunc bool bpf_in_task_context(void)
+{
+	return in_task();
+}
+
 __bpf_kfunc_end_defs();
 
 static void bpf_task_work_cancel_scheduled(struct irq_work *irq_work)
@@ -4429,6 +4470,10 @@ BTF_ID_FLAGS(func, bpf_cgroup_read_xattr, KF_RCU)
 BTF_ID_FLAGS(func, bpf_stream_vprintk, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_task_work_schedule_signal, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_in_softirq_context)
+BTF_ID_FLAGS(func, bpf_in_hardirq_context)
+BTF_ID_FLAGS(func, bpf_in_task_context)
+BTF_ID_FLAGS(func, bpf_in_nmi_context)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
-- 
2.43.0


