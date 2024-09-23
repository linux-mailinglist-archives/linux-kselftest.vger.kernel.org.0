Return-Path: <linux-kselftest+bounces-18224-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B7497ED16
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 16:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95EBE1C2174D
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 14:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999B51A00DA;
	Mon, 23 Sep 2024 14:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4XcsIOY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF2719FA80;
	Mon, 23 Sep 2024 14:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727101211; cv=none; b=tPz49Ov2nbr/bN+j5q3lCOVeIH0OyOoNN4OqH6gVqTwrUhkEiO5Wiy49Dxs2m3o+8tuP8YJVAnk25alNrbRkgjk/UBvm51bTcRhwQnydCRblR8480trbmdPZnRD2ZZrfavb8QvfmOl7b4uqpnilT15Gm9v7yyBL6fQeKPqErmgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727101211; c=relaxed/simple;
	bh=ebs3EuHqiCsxxspkyNA4R4zdfVt9c4zh/wO85RAJ+iI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tVRxiimK0wK8On5A1jXfyXXo9tgttfVgTfUYansnVrJtXv39giJD8REGu3ufVS28CQL4IbJzg9T0W/xQpeoGADIB0WLIDRR6rO38vrYuknB5Y3eeZWu2PhcHuevIr1w6zvwzHmE2ZAYNhDO3a8ly8qwsoAx0rwWJd+cUnrEuf+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4XcsIOY; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6ddd758aaf4so30887437b3.2;
        Mon, 23 Sep 2024 07:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727101209; x=1727706009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hMq+6UAT8fIPpn9cRI3ClU9mXb9eS44KW5/dqjhFHLA=;
        b=L4XcsIOYYzfpaeyAFSFIEtEBtqQPuKLeOwtsBmFkmggUbSK6qt6EQMS2zrH6b56W1p
         8olGPxtE7f2gQ2CZx7XtnK4lE3nflC0iRez1GvT+ahKREu9zLPei7GoreqTId4sO/mrj
         PVrO8z0SYcH32AVVnDOF1z6RkYM5OuUV+QztAbyHXiUAXJBlmK0b9qBT8OmznLV4lA32
         HvfO+rXKL/FsqpAuIjTlK+6GmrIA5pG+EXSn+PPT3pDmQs3P8U19RN0AUWelP4R9wSHn
         Sp3SJUys9JmB6OObc9cxKBRiUp6B6gZ/lo9b+wBUM64V2YW/vkOqEwrL7K7pOSMWAwk2
         80Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727101209; x=1727706009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hMq+6UAT8fIPpn9cRI3ClU9mXb9eS44KW5/dqjhFHLA=;
        b=tovEuZMLx+tBJU1YaMRM6HBvr7B7+e+4ob1M8onDLJZiemcnyBJbLW33551baTry3w
         2fkpvQmHbh3DJFSWkS4DHBLKri/EZGP44k0ZyqL26qcljKAQ5eLJ6ipw1u8m5EL4g9J2
         hx60iQo/tBPUiYsKVmf9XPsNxAVfqlUIwPDB+KaMp+fsaVslpVL4zRBFaOxhVcYEr5De
         uTLwVAnHGqJwd7ekro3EWZq0X/xbUpddNyvIrjLp4JQOffLvgwdGPys1hOKYslHGiNWh
         /mKZV5lusuDUvYWatmbnTunFYSqbUETUVGtS9R7cjWibilGt2/gxKD5dHudnoCPfGZJB
         xIlw==
X-Forwarded-Encrypted: i=1; AJvYcCWWce+8hNYtk7fZEhbQgZskUa/Pbsa40Tf6rxwSpq3nKyRPL4Rb5RHgepp0OTudUWi7gtm8sfDBBUmhirs=@vger.kernel.org, AJvYcCXcGuC4UGf9VLrYT15aGiOJONiYddUJ15FRyRGuZ0rwgHrysPKb78YKwFlx6C4QBt+Fb2V8r4fPUo5FPe76hSbu@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ3mhulbiYlrU7iN3257Xkg+05bQFiKLsisXjsy4KLEMDId6sL
	tjCYsTEBuCEePM9DHC2j9rAHSSvr+vBx9kUWfW/+zONR6tNTYUYE
X-Google-Smtp-Source: AGHT+IHrz5+t32GGNjybCXr/l01gcME04Qai75cp6HK08SzFs2WVioS9MYS5k0Z5ZbrXkTq65Xk2aA==
X-Received: by 2002:a05:690c:7001:b0:6b7:a7b3:8db2 with SMTP id 00721157ae682-6dfeeeec07emr90989507b3.30.1727101208817;
        Mon, 23 Sep 2024 07:20:08 -0700 (PDT)
Received: from localhost (fwdproxy-frc-003.fbsv.net. [2a03:2880:21ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ddb964f6f2sm32413247b3.32.2024.09.23.07.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 07:20:08 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: tj@kernel.org
Cc: cgroups@vger.kernel.org,
	hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	lizefan.x@bytedance.com,
	mkoutny@suse.com,
	shuah@kernel.org
Subject: [PATCH v3 1/2] cgroup/rstat: Tracking cgroup-level niced CPU time
Date: Mon, 23 Sep 2024 07:20:05 -0700
Message-ID: <20240923142006.3592304-2-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240923142006.3592304-1-joshua.hahnjy@gmail.com>
References: <20240923142006.3592304-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joshua Hahn <joshua.hahn6@gmail.com>

Cgroup-level CPU statistics currently include time spent on
user/system processes, but do not include niced CPU time (despite
already being tracked). This patch exposes niced CPU time to the
userspace, allowing users to get a better understanding of their
hardware limits and can facilitate more informed workload distribution.

A new field 'ntime' is added to struct cgroup_base_stat as opposed to
struct task_cputime to minimize footprint.

Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 include/linux/cgroup-defs.h |  1 +
 kernel/cgroup/rstat.c       | 16 +++++++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index ae04035b6cbe..a2fcb3db6c52 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -315,6 +315,7 @@ struct cgroup_base_stat {
 #ifdef CONFIG_SCHED_CORE
 	u64 forceidle_sum;
 #endif
+	u64 ntime;
 };
 
 /*
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index a06b45272411..a77ba9a83bab 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -444,6 +444,7 @@ static void cgroup_base_stat_add(struct cgroup_base_stat *dst_bstat,
 #ifdef CONFIG_SCHED_CORE
 	dst_bstat->forceidle_sum += src_bstat->forceidle_sum;
 #endif
+	dst_bstat->ntime += src_bstat->ntime;
 }
 
 static void cgroup_base_stat_sub(struct cgroup_base_stat *dst_bstat,
@@ -455,6 +456,7 @@ static void cgroup_base_stat_sub(struct cgroup_base_stat *dst_bstat,
 #ifdef CONFIG_SCHED_CORE
 	dst_bstat->forceidle_sum -= src_bstat->forceidle_sum;
 #endif
+	dst_bstat->ntime -= src_bstat->ntime;
 }
 
 static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu)
@@ -535,7 +537,10 @@ void __cgroup_account_cputime_field(struct cgroup *cgrp,
 
 	switch (index) {
 	case CPUTIME_USER:
+		rstatc->bstat.cputime.utime += delta_exec;
+		break;
 	case CPUTIME_NICE:
+		rstatc->bstat.ntime += delta_exec;
 		rstatc->bstat.cputime.utime += delta_exec;
 		break;
 	case CPUTIME_SYSTEM:
@@ -591,6 +596,7 @@ static void root_cgroup_cputime(struct cgroup_base_stat *bstat)
 #ifdef CONFIG_SCHED_CORE
 		bstat->forceidle_sum += cpustat[CPUTIME_FORCEIDLE];
 #endif
+		bstat->ntime += cpustat[CPUTIME_NICE];
 	}
 }
 
@@ -608,13 +614,14 @@ static void cgroup_force_idle_show(struct seq_file *seq, struct cgroup_base_stat
 void cgroup_base_stat_cputime_show(struct seq_file *seq)
 {
 	struct cgroup *cgrp = seq_css(seq)->cgroup;
-	u64 usage, utime, stime;
+	u64 usage, utime, stime, ntime;
 
 	if (cgroup_parent(cgrp)) {
 		cgroup_rstat_flush_hold(cgrp);
 		usage = cgrp->bstat.cputime.sum_exec_runtime;
 		cputime_adjust(&cgrp->bstat.cputime, &cgrp->prev_cputime,
 			       &utime, &stime);
+		ntime = cgrp->bstat.ntime;
 		cgroup_rstat_flush_release(cgrp);
 	} else {
 		/* cgrp->bstat of root is not actually used, reuse it */
@@ -622,16 +629,19 @@ void cgroup_base_stat_cputime_show(struct seq_file *seq)
 		usage = cgrp->bstat.cputime.sum_exec_runtime;
 		utime = cgrp->bstat.cputime.utime;
 		stime = cgrp->bstat.cputime.stime;
+		ntime = cgrp->bstat.ntime;
 	}
 
 	do_div(usage, NSEC_PER_USEC);
 	do_div(utime, NSEC_PER_USEC);
 	do_div(stime, NSEC_PER_USEC);
+	do_div(ntime, NSEC_PER_USEC);
 
 	seq_printf(seq, "usage_usec %llu\n"
 		   "user_usec %llu\n"
-		   "system_usec %llu\n",
-		   usage, utime, stime);
+			 "system_usec %llu\n"
+			 "nice_usec %llu\n",
+			 usage, utime, stime, ntime);
 
 	cgroup_force_idle_show(seq, &cgrp->bstat);
 }
-- 
2.43.5


