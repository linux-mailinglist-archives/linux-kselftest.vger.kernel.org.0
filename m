Return-Path: <linux-kselftest+bounces-39212-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88AB3B29D1E
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 11:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CAA23B757F
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 09:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641C430DEAE;
	Mon, 18 Aug 2025 09:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8F8SD2X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F9A30C366;
	Mon, 18 Aug 2025 09:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755507941; cv=none; b=QyzWHgT4Rooh69Sn1UdgXmp8aPMF8cX/I2toSaibIKQ5/TflqIV0Zmoy6Ti558BZywX1Appds93XwCyHmCjmBJFYKeHgTeJw+gQ4U99ctjqCfuitQDZxspuFhDe5Wx0ZZGdGfnG50K2M+h3jLhgCO2W+/YPW5s6TXkVkz/9UrpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755507941; c=relaxed/simple;
	bh=Vaxdln6PvoSuQXVLrreSF67KHxG2vOuiUg9ALmSUzck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cBW+D4ro1RNsCcRP8/2WL9vVEViaHy1dDUd2upgm8myyIKU6fIEDjGaGrPBFuwA0tNOWd9W2J8ZL57sNSkSgvSeje1hxILszzo7EEZy/FISeIT7CW5Sr+JHeF1a/tdAn3WdqnClUwe63urOwmbNlcKDd01a6BzkfOz7RVh+j6vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8F8SD2X; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e93498d436dso782534276.1;
        Mon, 18 Aug 2025 02:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755507939; x=1756112739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8L5QsSIN8yL9VXCRQ/tSDzT2fMRmD+CBZIMe5YLGEqM=;
        b=b8F8SD2XZRLTPcUdpd3Zw+dQtqJnLcHESO1KOsJ71W+Kz7W7a30lDNAm1stJJMuj+8
         MQ0r5m6Q61SbIYp5AmwzyRJpfalWJ7TG63KKvZjS17X9vk2yqwIgKI5mX+5sQiqtn+nj
         6zSam2ICcNvJWnjQ2JcBuDILCMmqn2ngMxOtOG2a4OEqzk+3l3426Mu12eKtmsRUIboN
         Q5gVXlDqwQTS2U4rdKnFLx1FCgnx+xkqjZucpBDMhI9GHguahxSryHZMzHkUfEmPaz6M
         VZw3zwuFNfVzCpyZ5VZhCioeReP5THmncDPURUmkD/zOipgC77Tt+/rlF2HSPVUCF0V0
         0gKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755507939; x=1756112739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8L5QsSIN8yL9VXCRQ/tSDzT2fMRmD+CBZIMe5YLGEqM=;
        b=L9AAwi+hGtE9pQVEYJIX2dhrORFHGbnxo8zlN73KYQQBF1uSCxpn185gVCOy9+8Kjj
         R5TE8pDbipFO0pEWxVD1cxoXm4ZjBmDmRO9T/2YnGfM0ibZreBIJBvlAm6XXCOdTgwy9
         ctnM44aq89ukraeGF2xiQ0dNgJ5263TUaEsTtf4NIvXZWkpAg3sIShq3UtijSXGsiQlr
         mjfvawbuqjn69ykimkUCVQBm49KxILj3c0oEnVyW1jXod2s9UlEgT/hvonjE30RgNAJu
         08USorzgkAXd4X89V80XPnK6mO2Cx6AYiBaqCsmYDl5Zcdd6TnTb8/IDoM0+Ps41QAPu
         2Kpw==
X-Forwarded-Encrypted: i=1; AJvYcCVWoKeuXBRU2nOirirkpsy9OjEhfHdf6oEi1EgLGCSGXz2FJcp7DoDxMH/lRSc3reCKwUY=@vger.kernel.org, AJvYcCVb8jRIFYGXx4TI54UqEb+w4HddTFUFMmOUCMV6k4lM7YaMzzt1pNB6n5xdF0hTKNIOp7h960allQ==@vger.kernel.org, AJvYcCXHBzHCcN3cR46MkvABWgRYGpoyIJd7Z4XgJq18cdb/M9hP/13X7sbVkboW2eyuFh+B6pJFvxQSHgyt5bS9JeLs@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1i49JQ9q7V147g5geDiTNJNLaAMPjRPihKgA48B0I51kr0XgM
	hyzs8Y+PLN/TYYRLjvwAN8jF2sUlZsc/jPv19GBWGog4pEGJNNrlkHag
X-Gm-Gg: ASbGncsDZM2Vx6mAkNtq3E7hzrCoxPjOU68ErFPcCXrU+xThBk6wiBh284Xj1YcBuxy
	jfCKdT7iSu2aHQGS7bgzNj1Bo0Us+NteTQm+oalAcmH8pFJLSRtbyeODBu4++YARPpel8TRM3Wd
	Nd8FJqDVXNx0DfJGl8Z0qJJVaqps1BLyjzgLLPsncgIIMOs0hYpbEpgFGnJ5b6E2BMwQzAYcCmW
	Kv/RbuvCeCuI2U6BIE+efa+3SFUQnD8nwjprwiJ2qmcuV2MuwUiuMCjdvts1waw1ZLuYM4lki4l
	mCW/ubUzMJpaGale0mUlHPp1KmE/xZqquyzCnVc707jV/HACT+m7ia0Z+qrryAcXxp6i33nAiHw
	M8oKCwxnrRGB8ZQ==
X-Google-Smtp-Source: AGHT+IF7iraoL3WH3jX6auppvXUooFl1bUrCDOB6A7AfW8Qjuj03gvthYsxX9nuQOa9jut8MtzcDxA==
X-Received: by 2002:a05:6902:420e:b0:e91:d090:8244 with SMTP id 3f1490d57ef6-e93324e0304mr13647876276.23.1755507938393;
        Mon, 18 Aug 2025 02:05:38 -0700 (PDT)
Received: from roronoa.. ([146.70.98.176])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e933264aabcsm2985389276.9.2025.08.18.02.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 02:05:37 -0700 (PDT)
From: Djalal Harouni <tixxdz@gmail.com>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	cgroups@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	tixxdz@opendz.org
Cc: Djalal Harouni <tixxdz@gmail.com>
Subject: [RFC PATCH v2 bpf-next 2/3] bpf: cgroup: Add BPF Kfunc to write and freeze a cgroup
Date: Mon, 18 Aug 2025 10:04:23 +0100
Message-ID: <20250818090424.90458-3-tixxdz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818090424.90458-1-tixxdz@gmail.com>
References: <20250818090424.90458-1-tixxdz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Add bpf_cgroup_write_interface() kfunc that writes to a cgroup
interface. Takes a cgroup on the default hierarchy as argument, and
writes to the specified interface file of that cgroup.

Freezing a cgroup of a task from BPF is better than user space
which could be too late and is subject to races. Hence, add support
for writing to "cgroup.freeze" interface using the mentioned bpf kfunc.

Planned users of this feature are: systemd and BPF tools.
Taking the freezing example, we could freeze a cgroup hierarchy on
suspicious activity for a more thorough analysis. The cgroup hierarchies
could be system services, user sessions, K8s pods or containers.

Signed-off-by: Djalal Harouni <tixxdz@gmail.com>
---
 kernel/bpf/helpers.c | 45 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 6b4877e85a68..5efc1bc57db9 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2605,6 +2605,50 @@ bpf_task_get_cgroup1(struct task_struct *task, int hierarchy_id)
 		return NULL;
 	return cgrp;
 }
+
+#define BPF_CGROUP_MAX_WRITE	((1UL << 24) - 1)
+
+/**
+ * bpf_cgroup_write_interface - Writes to a cgroup interface file.
+ * @cgrp: The target cgroup
+ * @name__str: name of the cgroup core interface file
+ * @value_p: value to write
+ * @off: offset
+ *
+ * Return: number of bytes written on success, a negative value on error.
+ */
+__bpf_kfunc int
+bpf_cgroup_write_interface(struct cgroup *cgrp, const char *name__str,
+			   const struct bpf_dynptr *value_p, loff_t off)
+{
+	struct bpf_dynptr_kern *value_ptr = (struct bpf_dynptr_kern *)value_p;
+	struct kernfs_node *kn;
+	const void *value;
+	u32 value_len;
+	int ret;
+
+	value_len = __bpf_dynptr_size(value_ptr);
+	if (!value_len)
+		return 0;
+
+	if (value_len > BPF_CGROUP_MAX_WRITE)
+		return -E2BIG;
+
+	value = __bpf_dynptr_data(value_ptr, value_len);
+	if (!value)
+		return -EINVAL;
+
+	rcu_read_lock();
+	kn = cgrp->kn;
+	rcu_read_unlock();
+
+	kernfs_get(kn);
+	ret = cgroup_kn_interface_write(kn, name__str, value, value_len, off);
+	kernfs_put(kn);
+
+	return ret;
+}
+
 #endif /* CONFIG_CGROUPS */
 
 /**
@@ -3736,6 +3780,7 @@ BTF_ID_FLAGS(func, bpf_cgroup_ancestor, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_cgroup_from_id, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_under_cgroup, KF_RCU)
 BTF_ID_FLAGS(func, bpf_task_get_cgroup1, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_cgroup_write_interface, KF_TRUSTED_ARGS | KF_SLEEPABLE)
 #endif
 BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_from_vpid, KF_ACQUIRE | KF_RET_NULL)
-- 
2.43.0


