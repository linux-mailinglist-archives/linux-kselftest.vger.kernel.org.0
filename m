Return-Path: <linux-kselftest+bounces-6746-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C03A88F22C
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 23:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0406F1F2EB19
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 22:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAE1153BC4;
	Wed, 27 Mar 2024 22:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klHJV2sW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFBE2DF92;
	Wed, 27 Mar 2024 22:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711580109; cv=none; b=ugumjBWE36wmqKX98eCB7J2nszDtjUTEOQLdzvltXlAyP8xwqSH6kasPcrBYKnV6qUORur5BRcSzS8JtZmhV68ZZXNaf6dU701e9RCE+Mn5SR/+dveVHdY7MEKQBNjrP9BX/ExkVNes7X3z/xmFl1TGJabpzcRNDdoWEdgFN7n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711580109; c=relaxed/simple;
	bh=+jtsaYid9d6k38CUcsY8zjQJOAoqkoOupXt7LZrPhpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Plq8pSz6qh/r3q88OX9rALHPctLXjnecL0xzh6zlWqezAkIGxWE+JMw2VUvXnN+mHX5yZOczFIcHokBdmh5WbV7G1z3HaN9aTG7M9I+/QG60v6P20NIVPFG6sunmGQk9vwgnSaC7/OaYUnlaRh67dtP+Pqeo41ZyHMw9YtB6Rjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=klHJV2sW; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-341808b6217so171396f8f.3;
        Wed, 27 Mar 2024 15:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711580106; x=1712184906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nH4tgs9aLkl4Y8wm8Zix864aLcytoWhaI17Seukw8fs=;
        b=klHJV2sWYetYbRUv2JmPpqr6clbttXA6X2r2Koaa8fLpLf99Fw1fYW5WT/fVn65Sof
         XwNfzUTxc2aw5HzwPJvnUfUojc+54/7ccMfLHH/5grTnyN6DDsK/bFYRFc2WR4W8DF9l
         UKKoxWREa1XFRfkMqAkEO5VIpb+XLT//h/H2xv887QS2a0VkJodrIeSFLFOhjL+DvOJ1
         DVuqQLKJ+xy7Kh4zo6waQJCa+bht8ivfgyZDz5pW/PFXUojr104jlQJULM7poEbKNlox
         Xar82KPsa+IIcL4NwHwCDhqeWkv0bSvndEEKcxT2oagr7QFd9Icotf3r+AvxG/m7irnT
         NmIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711580106; x=1712184906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nH4tgs9aLkl4Y8wm8Zix864aLcytoWhaI17Seukw8fs=;
        b=sbbhuuSaxcAMi2IBlQoJw2t1KcviF30FMfd7NHKv9K0eSfVXImR5WNm8ZcdDHXhzVu
         hKb7Fn+kv0gh9J9nSRzxOTeNHWmbWs/NWXR95MP1Fk2TjR3X1h5FFuMAeezQnInRtzkd
         VF744Y0VaYAIv829iJRJGSSCembw1q0wNnqspitiM7y4NQof4j0JJo2jGUKkFC3Aph3m
         yrqwVfyoMIfI6hB55puPr1lrWE7jar89mvyyjuK9/+h+lKdIG/793kPSB1aKuAcMhUDa
         4kD46fjQQDzLPPvuQMGjQs7pxP0/53RQ18vSgGhfqgp/yc84+8NRi8IgbT7SeTbBcXPe
         TS0w==
X-Forwarded-Encrypted: i=1; AJvYcCUS7Z0NrR2x/b46PvwxU53HycStNM5fzvVDlmtcyoIRKybJ18/Ijh6VuFzQoYtqX2N/Kg9l/pCGCeEQZR0NXrQ/ewElMUbNgwMNpojHZ9N9n5pCLCM6DzAw1pui9LdKfggFvS5ekUt6ygC96Fh6oDhWGiXsKfdAtZz/Msurd+pyPLWZeJNuY9cTfhlCMiboL1m4gpDqjoNs/vqmTQ==
X-Gm-Message-State: AOJu0Yw+Boi6t3ydLZ3o9FhFQpy959VcYOgOIARbeKMzt6jiPeKIxNDy
	ACvcD3Zkm5DaLkwXBHLfjtowGvyitAaL/C40bOCijUIDy6MFwVsm
X-Google-Smtp-Source: AGHT+IHdigNsmxm7L+bIAaCTVVAcKK+rZSQ0wKNyArZKj0RkvVRFrWOTxBNeNbH91E28js+snEK0fA==
X-Received: by 2002:a5d:6b87:0:b0:33e:7402:f4d3 with SMTP id n7-20020a5d6b87000000b0033e7402f4d3mr938250wrx.33.1711580106330;
        Wed, 27 Mar 2024 15:55:06 -0700 (PDT)
Received: from rorona-tty.. ([154.121.114.3])
        by smtp.googlemail.com with ESMTPSA id cc7-20020a5d5c07000000b0033e75e5f280sm152348wrb.113.2024.03.27.15.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 15:55:06 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next 1/3] cgroup: add cgroup_freeze_no_kn() to freeze a cgroup from bpf
Date: Wed, 27 Mar 2024 23:53:23 +0100
Message-Id: <20240327225334.58474-2-tixxdz@gmail.com>
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

This patch adds a new cgroup helper cgroup_freeze_no_kn() to freeze a
cgroup hierarchy that is on a default cgroup v2 without going through
kernfs interface.

For some cases we want to freeze the cgroup of a task based on some
signals, doing so from bpf is better than user space which could be
too late.

The cgroup_freeze_no_kn() will acquire the cgroup_mutex and release it
at the end.

It also checks if the cgroup is on the default hierarchy and it is not
a root cgroup.

Signed-off-by: Djalal Harouni <tixxdz@gmail.com>
---
 include/linux/cgroup.h |  2 ++
 kernel/cgroup/cgroup.c | 69 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 34aaf0e87def..5019b32ea933 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -137,6 +137,8 @@ int cgroup_init(void);
 
 int cgroup_parse_float(const char *input, unsigned dec_shift, s64 *v);
 
+int cgroup_freeze_no_kn(struct cgroup *cgrp, int freeze);
+
 /*
  * Iteration helpers and macros.
  */
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index a66c088c851c..0aafcd9e39b5 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1595,6 +1595,26 @@ static u16 cgroup_calc_subtree_ss_mask(u16 subtree_control, u16 this_ss_mask)
 	return cur_ss_mask;
 }
 
+/**
+ * cgroup_dfl_write_no_kn - check if direct writes to cgroup without going
+ * through kernfs is allowed.
+ * @cgrp: the target cgroup
+ *
+ * This helper ensures that the cgroup is on the default hierarchy and it
+ * is not a root cgroup.
+ *
+ * Return: %0 on success or a negative errno code on failure.
+ */
+static int cgroup_dfl_write_no_kn(struct cgroup *cgrp)
+{
+	lockdep_assert_held(&cgroup_mutex);
+
+	if (!cgroup_on_dfl(cgrp) || !cgroup_parent(cgrp))
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
 /**
  * cgroup_kn_unlock - unlocking helper for cgroup kernfs methods
  * @kn: the kernfs_node being serviced
@@ -1668,6 +1688,25 @@ struct cgroup *cgroup_kn_lock_live(struct kernfs_node *kn, bool drain_offline)
 	return NULL;
 }
 
+/**
+ * cgroup_lock_live_no_kn - locking helper for direct writes to cgroup without
+ * going through kernfs interface.
+ * @cgrp: the target cgroup
+ *
+ * This helper performs cgroup locking and verifies that the associated cgroup
+ * is alive. Returns the cgroup if alive; otherwise, %NULL.
+ * A successful return should be undone by a matching cgroup_unlock()
+ * invocation.
+ */
+static struct cgroup *cgroup_lock_live_no_kn(struct cgroup *cgrp)
+{
+	cgroup_lock();
+	if (!cgroup_is_dead(cgrp))
+		return cgrp;
+	cgroup_unlock();
+	return NULL;
+}
+
 static void cgroup_rm_file(struct cgroup *cgrp, const struct cftype *cft)
 {
 	char name[CGROUP_FILE_NAME_MAX];
@@ -3930,6 +3969,36 @@ static int cgroup_freeze_show(struct seq_file *seq, void *v)
 	return 0;
 }
 
+/**
+ * cgroup_freeze_no_kn - Freeze a cgroup that is on the default hierarchy
+ * without going through kernfs interface.
+ *
+ * @cgrp: the target cgroup
+ * @freeze: freeze state, passing value 1 causes the freezing of the cgroup
+ * and all descendant cgroups. Processes under this cgroup hierarchy will
+ * be stopped and will not run until the cgroup is explicitly unfrozen.
+ * Passing value 0 unthaws the cgroup hierarchy.
+ *
+ * Return: %0 on success or a negative errno code on failure.
+ */
+int cgroup_freeze_no_kn(struct cgroup *cgrp, int freeze)
+{
+	int ret = 0;
+
+	if (freeze < 0 || freeze > 1)
+		return -ERANGE;
+
+	if (!cgroup_lock_live_no_kn(cgrp))
+		return -ENOENT;
+
+	ret = cgroup_dfl_write_no_kn(cgrp);
+	if (!ret)
+		cgroup_freeze(cgrp, freeze);
+
+	cgroup_unlock();
+	return ret;
+}
+
 static ssize_t cgroup_freeze_write(struct kernfs_open_file *of,
 				   char *buf, size_t nbytes, loff_t off)
 {
-- 
2.34.1


