Return-Path: <linux-kselftest+bounces-6747-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F0E88F236
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 23:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E47531F2EBC6
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 22:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B541154C0E;
	Wed, 27 Mar 2024 22:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/4JanH3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B8415445D;
	Wed, 27 Mar 2024 22:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711580121; cv=none; b=t1ePngiNRKxxw6y1dAG9OxypWgVPc03P5QCeNIVqZE1xbgK9LZUgnvMxNVxxFgnE/WdP4FUZKFxAA1CpP112FTtWl1/qq8of1e/TMyWiS2KGO+eyTSzRR9KEh46jFOfxFpa4bbKiT+ES+s/KrHlA2da1ei2y1vsU65yZgNRNesc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711580121; c=relaxed/simple;
	bh=dMyOthoNkHLVW5M5sdud8Cz8ZlP/s0vnSETYelLAw/M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HcxULMeQBjQVeCrkDCfFGrOxZyk2pZngX7vGr3BrMi9Vls5h4YjO//54a3DuQkD1ffK6YkRZzfdq0oF4hwg2qB//uEfG5jtBTPkPLcj36wS1r7lTouVX5YoPB+HAWBQi6TaE+x9wUkRYUYrQCP0s+BmGxNqVKihxu1L6rAtTifo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/4JanH3; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33eee0258abso166515f8f.3;
        Wed, 27 Mar 2024 15:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711580118; x=1712184918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5+m79uhLEXdVoaBrPdTY3BAK3Wv4St0V6/3gWbwJOI=;
        b=W/4JanH3d4lVPe0HI+t5Mr+de+59mxYR7cTWgcyLrm5PoiicxSQGFnrtug+Y/i878U
         Jyj8n/PyDXx3YALp+/vcI+Z+PBnPrbtHAzhL+iFvkeu3FCxYJMElEZe4vkPIPWH6y2Sn
         WT11TNx94dSH6jUOALjhnYfp4GSBHQ/mnfd2b54V65O0w/IcHnGRuxHaIDp7DmwFjD2a
         IhVHQTG2hL2fpk1SgSFgVvMq+b5SX5I6Qsini0Zg0JrvPlwxZBMnMZwZZR9XHLBEA4pf
         xjuks767ibMxZFJEdrkiCjOradY33QQO9bZtnSYgxW7ZHoaUkxc2OivhXVDxUrZ+u18R
         ygNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711580118; x=1712184918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v5+m79uhLEXdVoaBrPdTY3BAK3Wv4St0V6/3gWbwJOI=;
        b=LaTpI6om0PwNHNCgMSK8imhBYcj2N3cVwCr2Fn24Bf8T0Sv5Q3n0Y7V37NnGgSWjMc
         STqwHureYfBolPln+NTUeHaVz1z0DlrfWPYsY8gVd/D8UXCCV5ME+KcMAjFdJlLzqnlg
         Nxm8W/vLkVHkq0X2iIfyGG7DhHQZy+NWIl/QHDdugKcn4UrIfDOqLuANmlyEANO4q90B
         OWgFlAUVlH4B8i3TOEHhxj+wzeriEGGLF90tGCdBb9pP1KyDYVZCARSjVORbqM8VM0WH
         2Ty3s7zRBd6pMBmwjg7GYGdocmiAEFj3B5nX041PQHUWhFoGnvFtToRguVtoDZMdQHBE
         W/zA==
X-Forwarded-Encrypted: i=1; AJvYcCVx3SZwK4p3bnLSwn3MvyoMKrakM7uZ1FUm4zd0dtq8G6z3kLxcidKpFU4WYPOb8B8bByEcn4oV4E7Rl56P6w8mntYy67x79Gpj1jO/FIdgUNEvIq/O8ZZ8ks+dCuRTmXdq6dH07s0tyg62tyTJtUWUyQRp8F/JTiMCysYA0roJ/LOE8Au21v892xNsYOj5SghZct5lSzCm5dLEww==
X-Gm-Message-State: AOJu0YwQUM2sbA9h0AdKBzM9TC6mVUK7C3unU/C9CRsOaY7SJEg1rEvy
	QHe2wmxFoKd2X1k4JI83zGsz6jxMFTGWaoyIw+oxbVlcba++Azgg
X-Google-Smtp-Source: AGHT+IGmzfBChgCSImBAhgHjs9dtQYNUn9rfk833w7UvcXpMOo/gj/a+75BzNxxtakQDndWUXnw6qg==
X-Received: by 2002:a05:6000:400a:b0:341:cf9c:1c43 with SMTP id cp10-20020a056000400a00b00341cf9c1c43mr919781wrb.43.1711580117876;
        Wed, 27 Mar 2024 15:55:17 -0700 (PDT)
Received: from rorona-tty.. ([154.121.114.3])
        by smtp.googlemail.com with ESMTPSA id cc7-20020a5d5c07000000b0033e75e5f280sm152348wrb.113.2024.03.27.15.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 15:55:17 -0700 (PDT)
From: Djalal Harouni <tixxdz@gmail.com>
To: tixxdz@gmail.com
Cc: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Alexei Starovoitov <ast@kernel.org>,
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
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [RFC PATCH bpf-next 2/3] bpf: add bpf_task_freeze_cgroup() to freeze the cgroup of a task
Date: Wed, 27 Mar 2024 23:53:24 +0100
Message-Id: <20240327225334.58474-3-tixxdz@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240327225334.58474-1-tixxdz@gmail.com>
References: <20240327-ccb56fc7a6e80136db80876c@djalal>
 <20240327225334.58474-1-tixxdz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds a new bpf helper bpf_task_freeze_cgroup() to freeze a
cgroup of a task and all its descendant cgroups. It requires the task
to be on the default cgroup v2 hierarchy.

For some cases we want to freeze the cgroup of a task based on some
signals, doing so from bpf is better than user space which could be
too late.

Planned users of this feature are: tetragon and systemd when freezing
a cgroup hierarchy that could be a K8s pod, container, system service
or a user session.

This helper will acquire the cgroup_mutex during its operation and
release it before it returns.

Signed-off-by: Djalal Harouni <tixxdz@gmail.com>
---
 kernel/bpf/helpers.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 9234174ccb21..8d510a1b265c 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2270,6 +2270,36 @@ bpf_task_get_cgroup1(struct task_struct *task, int hierarchy_id)
 		return NULL;
 	return cgrp;
 }
+
+/**
+ * bpf_task_freeze_cgroup - Freeze the task cgroup and all its descendant cgroups.
+ *
+ * @task: The target task
+ * @freeze: freeze state, passing value 1 causes the freezing of the cgroup
+ * and all descendant cgroups. Processes under this cgroup hierarchy will
+ * be stopped and will not run until the cgroup is explicitly unfrozen.
+ * Passing value 0 unthaws the task cgroup and its descendant cgroups.
+ *
+ * Return: %0 on success or a negative errno code on failure.
+ */
+__bpf_kfunc int bpf_task_freeze_cgroup(struct task_struct *task, int freeze)
+{
+	int ret;
+	struct cgroup *cgrp;
+
+	rcu_read_lock();
+	cgrp = task_dfl_cgroup(task);
+	if (!cgrp || !cgroup_tryget(cgrp)) {
+		rcu_read_unlock();
+		return -ENOENT;
+	}
+	rcu_read_unlock();
+
+	ret = cgroup_freeze_no_kn(cgrp, freeze);
+	cgroup_put(cgrp);
+
+	return ret;
+}
 #endif /* CONFIG_CGROUPS */
 
 /**
@@ -2577,6 +2607,7 @@ BTF_ID_FLAGS(func, bpf_cgroup_ancestor, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_cgroup_from_id, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_under_cgroup, KF_RCU)
 BTF_ID_FLAGS(func, bpf_task_get_cgroup1, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_task_freeze_cgroup, KF_TRUSTED_ARGS | KF_SLEEPABLE)
 #endif
 BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_throw)
-- 
2.34.1


