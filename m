Return-Path: <linux-kselftest+bounces-6413-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0B287F682
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Mar 2024 06:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8926D1F22528
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Mar 2024 05:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164B74085B;
	Tue, 19 Mar 2024 05:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b="OMRvrYg7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC363E493
	for <linux-kselftest@vger.kernel.org>; Tue, 19 Mar 2024 05:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710824677; cv=none; b=JcJx9XwnKIAttX/BzvXWGumzeN1AJS4nDBMQkdlNsBWrt/C5vDpbWO5cq4CvSNsR+WI+pPbvEUTwQLC19XI2clVGzHODdUTuoBGfpe7dyJxEAezMPYaWY0AX9VOJtS2UL16CjkG5ye+rVEAq/L8no70M3MfNKShdpg4mSzBqxto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710824677; c=relaxed/simple;
	bh=Lz2CrH8A7WjP27QDwUAd0Apjplhh1crikLeGS9SaF0E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BQZfLOcbrgaMGpNM45sWR//EJ6oKcudwNgELPOOdAbwYWdlOuO0ofPbQRawHPmLNGJwrk3Edp6EWRLW1NoalcU1UooKO6bgS31O75CYaPJGFambdgQy6pbAkByrnc7OabZY4aiDpQBjwOj95/S6YKmVllGo213zFVp09AxdGMhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netflix.com; spf=pass smtp.mailfrom=netflix.com; dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b=OMRvrYg7; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netflix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netflix.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dcbc00f6c04so4453648276.3
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Mar 2024 22:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netflix.com; s=google; t=1710824674; x=1711429474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C+tjYLQhJo+BMVuUInD+N/p7F8UX37fJMVNt77Cc/o8=;
        b=OMRvrYg7HgBuIVmUkj1ch1iK0S0ygVW8fUtADWjIpylwb6Hxo3l66hHvDxyVbY7eoa
         221LGIRkuutwtnLCR6FLdS2PTXMf+ruKaVuZAn0yWT3ov0u/tQDXkwqNRtx+yf81aodF
         1IJEPTgS0ODyBAQ9uFkRyrmGgrh15Tb25B3qg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710824674; x=1711429474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C+tjYLQhJo+BMVuUInD+N/p7F8UX37fJMVNt77Cc/o8=;
        b=U1ZW1nBGnweZRoLSuGT9dF1EnyzCUDWxjI+60+EVQZuxVVyG+WFjbI3twFKpJ+hY0S
         49pGtxettUcYg2h31YkHoSJF3c8euRBKS/Uh0pgCvf3VcWLVEc1zRbNTHKdIJ6AM+iQR
         PSQQkJwWeKmyKyaBVQyBe+2Mi3CfUnyPNV1VNplUwlFwY5r1HLn9F3wnR4saCYh4Zbnm
         zpnX+y079PvtIbkjWfDlePwWQyBl/kiTWGnIOjNJH3AXtD8nP/iSlRY8WPZ9VVlvJ8fB
         mK/n6TLAce1s10T+ldv1xmM9Y+6GHf69yVS7kuaqK2QnFhoOphySrw685oISX2d6wMvm
         ccKA==
X-Forwarded-Encrypted: i=1; AJvYcCXPWAvBjkXWIQQx0EVGt/sU9RbwaerWoq57IN4goekUzmAZsbdyXCuGUgdpQ8JMT/zp+zmHhw8TLMhK4Ax0iwvi2Vv0KCSZfko24TUQRZgw
X-Gm-Message-State: AOJu0YzBv6EHQSGS3ob9bfy5OpHAITqHE7CwMACn5xZRTKhWeV9n+koE
	yH6SboOJVlF6Nx9+WYTybMRW9pWaCPFEnym1vUMMSm0G/di5TyMhHxx++bGnXN4=
X-Google-Smtp-Source: AGHT+IGKnEb1MFeHqBSw8vDsqBbEODWdU6GBl76O84BfZEbLJavR+eqn8sFeEHheRyEbc1ga1F6bAQ==
X-Received: by 2002:a25:6405:0:b0:dc6:deca:468f with SMTP id y5-20020a256405000000b00dc6deca468fmr9032612ybb.29.1710824673931;
        Mon, 18 Mar 2024 22:04:33 -0700 (PDT)
Received: from localhost ([12.220.158.163])
        by smtp.gmail.com with UTF8SMTPSA id t10-20020a25908a000000b00dcc0cbb0aeesm2023977ybl.27.2024.03.18.22.04.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 22:04:33 -0700 (PDT)
From: Jose Fernandez <josef@netflix.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Jose Fernandez <josef@netflix.com>,
	Tycho Andersen <tycho@tycho.pizza>
Subject: [PATCH V3 bpf-next 1/2] bpf: add bpf_task_get_cgroup kfunc
Date: Mon, 18 Mar 2024 23:03:01 -0600
Message-Id: <20240319050302.1085006-1-josef@netflix.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch enhances the BPF helpers by adding a kfunc to retrieve the
cgroup v2 of a task, addressing a previous limitation where only
bpf_task_get_cgroup1 was available for cgroup v1. The new kfunc is
particularly useful for scenarios where obtaining the cgroup ID of a
task other than the "current" one is necessary, which the existing
bpf_get_current_cgroup_id helper cannot accommodate. A specific use
case at Netflix involved the sched_switch tracepoint, where we had to
get the cgroup IDs of both the prev and next tasks.

The bpf_task_get_cgroup kfunc acquires and returns a reference to a
task's default cgroup, ensuring thread-safe access by correctly
implementing RCU read locking and unlocking. It leverages the existing
cgroup.h helper, and cgroup_tryget to safely acquire a reference to it.

Signed-off-by: Jose Fernandez <josef@netflix.com>
Reviewed-by: Tycho Andersen <tycho@tycho.pizza>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Acked-by: Stanislav Fomichev <sdf@google.com>
---
V2 -> V3: No changes
V1 -> V2: Return a pointer to the cgroup instead of the cgroup ID

 kernel/bpf/helpers.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index a89587859571..bbd19d5eedb6 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2266,6 +2266,31 @@ bpf_task_get_cgroup1(struct task_struct *task, int hierarchy_id)
 		return NULL;
 	return cgrp;
 }
+
+/**
+ * bpf_task_get_cgroup - Acquire a reference to the default cgroup of a task.
+ * @task: The target task
+ *
+ * This function returns the task's default cgroup, primarily
+ * designed for use with cgroup v2. In cgroup v1, the concept of default
+ * cgroup varies by subsystem, and while this function will work with
+ * cgroup v1, it's recommended to use bpf_task_get_cgroup1 instead.
+ * A cgroup returned by this kfunc which is not subsequently stored in a
+ * map, must be released by calling bpf_cgroup_release().
+ *
+ * Return: On success, the cgroup is returned. On failure, NULL is returned.
+ */
+__bpf_kfunc struct cgroup *bpf_task_get_cgroup(struct task_struct *task)
+{
+	struct cgroup *cgrp;
+
+	rcu_read_lock();
+	cgrp = task_dfl_cgroup(task);
+	if (!cgroup_tryget(cgrp))
+		cgrp = NULL;
+	rcu_read_unlock();
+	return cgrp;
+}
 #endif /* CONFIG_CGROUPS */
 
 /**
@@ -2573,6 +2598,7 @@ BTF_ID_FLAGS(func, bpf_cgroup_ancestor, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_cgroup_from_id, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_under_cgroup, KF_RCU)
 BTF_ID_FLAGS(func, bpf_task_get_cgroup1, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_task_get_cgroup, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 #endif
 BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_throw)

base-commit: c733239f8f530872a1f80d8c45dcafbaff368737
-- 
2.40.1


