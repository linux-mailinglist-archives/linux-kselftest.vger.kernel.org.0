Return-Path: <linux-kselftest+bounces-19406-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D70B997831
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 00:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DE38B21527
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 22:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85181E282D;
	Wed,  9 Oct 2024 22:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVMNCciv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A9217BB0C;
	Wed,  9 Oct 2024 22:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728511621; cv=none; b=ThhiAc/K5IMFhgHkCbAig+bJclJZuvkBZSJTjgZasOO31V/cZQe7Xk6ABu1TphUHXTvgM2EJKaQ3qTGJBc0GLC8LMu6bghmn1VNzvLFeJGO+2uRigLv/2eWf3aw3mfSjvBrfguEuJCTwK6JQaylY+gWE/3GGK/hrFX7VDwCo39I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728511621; c=relaxed/simple;
	bh=qR4G6cpRTNBNGQbp7qj0gyw0DIUnvfkn2WtpYeir/yc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CBXJJqCeZP10koWS/Xf7GTnSVqbkxEjT+bUYFXRiK8GQIN2OFM3nYkIrSOd6OFflqJjYkAlDlPbjn49PjYeKJHUNwQdE+Md0OqerwHywbRYZXiOSWv8pQ2YcmGlpRhJ4JpQAnTF5AJZfZ7rYDBhGgbTcjhFTSByR/3ZGuRHtbDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVMNCciv; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6e214c3d045so3328277b3.0;
        Wed, 09 Oct 2024 15:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728511619; x=1729116419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AFBZjF5Yk4tht/EOD4hcMtQva+b/hCYbw5Gp5MWFIPg=;
        b=NVMNCciv58oNKZDmrmi6J7uzTPPP1eME8oq0FBU+L/lFvX4vvV5jT0rwt7df/M8ddf
         LU+NBrgRWPF2gyiW8+Q/Oo3ncNoJh772vYakCx1mP5DdgPFkXpEVbsFl9V3P7HJyzTB3
         iT7Thea1rOoGXpwe+L3JdyWNjVMgEl1rV7mWz72PRA3oFfBJ7gRl4+qDX1adVlD2wRf+
         q+M9bT/06ito852jS7zLm7tthNer1Kg/nNnNCGpn92TCQ1s+8AjytCXEErrXA1j3LmJR
         OsjOINlDDI9C48vzyuHfslde1mg2YO1gOJzm8RmEjiWhXnvuxqoSKfQYZeqNWVb7Bnyb
         xFcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728511619; x=1729116419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AFBZjF5Yk4tht/EOD4hcMtQva+b/hCYbw5Gp5MWFIPg=;
        b=aIpYJTsIBLpPse1/9X2fJxfgIDYUQIU+6FrI8SJgOXV5B5ff5zioFkUkuUvpKq6lEi
         1VJt4riAfrpoOiskSOwk/2rkm4k1YO6zH/FRwkasCT7x3Bjr63M4plZBunVX/MRQtBGw
         oWdtwoTCpuV971i2yoDd+/T4IrDCi7Ln6sX5cN0ao9EkgWdyKxCFRsOy6tii+EPNFR0M
         M2kqr1lWDzLatOxqum04oCrwjWLovw8/jQNEZ7ygzwMc5SBhyYfsIZ2epuRh3gp5lWqT
         KLFnUNaevKNBgZcYHBdYtAAsYXhXV49pSmPo6Efb5e4NDmtllCWVeu/ynbzHK5GgRnYy
         hp9g==
X-Forwarded-Encrypted: i=1; AJvYcCU3VNgNw5UOUfxrjlirIANmYyr+QLx75j3LjaYMutHW0nR1FvcioCyotBMToj+/17r3GC9as4Nh5fPbMTA=@vger.kernel.org, AJvYcCXMaua0IJaLNNJ4NXyIlvek590oc3waDRDYfMLR60AaiGoC7b32hzgk2iroyA5TG+s34OpbXGao1GW8hgFfnM9DqwXt@vger.kernel.org, AJvYcCXs5jpxLH2ZsCVRe9GImlw2Nwa7p1hDIZtMRNld5LrSNuLEV0oQdTU39NrTXbGTbIHCnDj0u6X27hNGFhJvJEN+@vger.kernel.org
X-Gm-Message-State: AOJu0YxWV8BBuJjMDIAQTqwx/Z1A94VxUn8OgTiJxviSwOxpejV38BBB
	ra4on04o8o4dMTHX5Qh0bxX3riNs7pz10mBZXLz9S9YIlo2qDaqVt1VfNZFl
X-Google-Smtp-Source: AGHT+IG3/Du/0WuPBnLSEF0Xuz0WLmIENO+InrEFUnWJT3Z7T4winPWm0D9pFEwZTNKSn6qIG8DYwA==
X-Received: by 2002:a05:690c:39d:b0:62c:c684:b1e1 with SMTP id 00721157ae682-6e32217b7d9mr39731187b3.29.1728511618856;
        Wed, 09 Oct 2024 15:06:58 -0700 (PDT)
Received: from dev-ubuntu-0.. (104-15-236-76.lightspeed.rlghnc.sbcglobal.net. [104.15.236.76])
        by smtp.googlemail.com with ESMTPSA id 00721157ae682-6e2d926b44esm20294217b3.16.2024.10.09.15.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 15:06:58 -0700 (PDT)
From: Tyrone Wu <wudevelops@gmail.com>
To: bpf@vger.kernel.org,
	wudevelops@gmail.com
Cc: kpsingh@kernel.org,
	mattbobrowski@google.com,
	song@kernel.org,
	jolsa@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	haoluo@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	mykolal@fb.com,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf v1 1/2] bpf: fix unpopulated path_size when uprobe_multi fields unset
Date: Wed,  9 Oct 2024 22:06:37 +0000
Message-ID: <20241009220638.333429-1-wudevelops@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously when retrieving `bpf_link_info.uprobe_multi` with `path` and
`path_size` fields unset, the `path_size` field is not populated
(remains 0). This behavior was inconsistent with how other input/output
string buffer fields work, as the field should be populated in cases
when:
- both buffer and length are set (currently works as expected)
- both buffer and length are unset (not working as expected)

This patch now fills the `path_size` field when `path` and `path_size`
are unset.

Fixes: e56fdbfb06e2 ("bpf: Add link_info support for uprobe multi link")
Signed-off-by: Tyrone Wu <wudevelops@gmail.com>
---
 kernel/trace/bpf_trace.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index a582cd25ca87..ba34e4f3fa8f 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3133,7 +3133,8 @@ static int bpf_uprobe_multi_link_fill_link_info(const struct bpf_link *link,
 	struct bpf_uprobe_multi_link *umulti_link;
 	u32 ucount = info->uprobe_multi.count;
 	int err = 0, i;
-	long left;
+	char *p, *buf;
+	long left = 0;
 
 	if (!upath ^ !upath_size)
 		return -EINVAL;
@@ -3147,26 +3148,24 @@ static int bpf_uprobe_multi_link_fill_link_info(const struct bpf_link *link,
 	info->uprobe_multi.pid = umulti_link->task ?
 				 task_pid_nr_ns(umulti_link->task, task_active_pid_ns(current)) : 0;
 
-	if (upath) {
-		char *p, *buf;
-
-		upath_size = min_t(u32, upath_size, PATH_MAX);
+	upath_size = upath_size ? min_t(u32, upath_size, PATH_MAX) : PATH_MAX;
+	buf = kmalloc(upath_size, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+	p = d_path(&umulti_link->path, buf, upath_size);
+	if (IS_ERR(p)) {
+		kfree(buf);
+		return PTR_ERR(p);
+	}
+	upath_size = buf + upath_size - p;
 
-		buf = kmalloc(upath_size, GFP_KERNEL);
-		if (!buf)
-			return -ENOMEM;
-		p = d_path(&umulti_link->path, buf, upath_size);
-		if (IS_ERR(p)) {
-			kfree(buf);
-			return PTR_ERR(p);
-		}
-		upath_size = buf + upath_size - p;
+	if (upath) {
 		left = copy_to_user(upath, p, upath_size);
-		kfree(buf);
-		if (left)
-			return -EFAULT;
-		info->uprobe_multi.path_size = upath_size;
 	}
+	kfree(buf);
+	if (left)
+		return -EFAULT;
+	info->uprobe_multi.path_size = upath_size;
 
 	if (!uoffsets && !ucookies && !uref_ctr_offsets)
 		return 0;
-- 
2.43.0


