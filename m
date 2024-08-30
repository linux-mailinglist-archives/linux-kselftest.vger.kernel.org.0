Return-Path: <linux-kselftest+bounces-16803-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FED966408
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 16:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C4AC285546
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 14:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8131B250F;
	Fri, 30 Aug 2024 14:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fbin6Vcs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B7F1A3BCE;
	Fri, 30 Aug 2024 14:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725027584; cv=none; b=m22xh7/SdSeNY/MUsSPv9rjHszHA4GKzU+7Yz8+mCcqHLUgmQh0k1q9S89RFakfRW62p7LLbwPpobOORb55/O5agshed+Qy3LWP9PAgMxltIyEZb2lYKgazWJS4+U/TZ4KzgmTlhBQZI2Iwv7WZis1ylU4/qHjxsb73oLWj7HPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725027584; c=relaxed/simple;
	bh=0yvlZyHLGZ9q0yZCsy22Nvrg7X3bocc2rzmJK6VHv38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pR+e3B1wZe2/Xlju3CM9+FCNJJlPBwGMYsiS/MvAqDF5y26TnE+NrOnqJ82wLfAg9djtIkjs9PsJbu6y/WIj63XqCCa2gTNL8bo9FaAlXTYwBGfpSKiWCnEs1WDpvMf7QDNmHOLkaa/CAX0kzDHZgMv9pM9psWN302XPUiq8xi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fbin6Vcs; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6b8d96aa4c3so15761037b3.1;
        Fri, 30 Aug 2024 07:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725027582; x=1725632382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o8wsTyBt93zFdaQMuF2yX3q/AqNfyBZAjYg98sqkDKA=;
        b=Fbin6VcsnLb3+ZKfXXkaYof+B3QOY7Kvq0aJrwXDI5MwtBdw/he93mBD5GjmCj/YmI
         5Rww/1y0jzNQMu+9/JnE21iBWousaQx88XynRzEvUnXzL4AU1r7cbn2h/oUfcrTh2TlE
         D5MMHWnZCFU1iiXadPRTXHtGIeA7qVxw4qiItzItqM0YEvrrhtJLzk9JeLMS+jb+ppTE
         xxIzzRmUUGLDwWb5kcaYW+Ptj/TaIG3bwyVbDRT5A5CY7tsZd+JOf1ntvXmbMAHQ3wd8
         mlI/+a8FVU3J09+rawJEUzQbGSHUIml4quTURk5L0WcqRmTeikBQOYLzwzEbBqkg5TH/
         CPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725027582; x=1725632382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o8wsTyBt93zFdaQMuF2yX3q/AqNfyBZAjYg98sqkDKA=;
        b=S/XJ0Db5H+OLbqY7xtiDxozXEd0UeTtWmxnw9kdSeKTl5EP42di5EMD2ZXmMF4qkl4
         oenuZG+YsITi9jFemT2ucHuRnFkKyLu1KMCJBPPz1PiWb9Nwkf1/YspT5RqTkbaPp2Db
         M2MB1+H53USJcN+XAmdfYJHoWcVvTh+OOrh5rRaX/BcZfqkpIJjxvjFbJHw0RQZRRaW0
         pkdAc0FoL1IwhfFXuN3k/K6fH+QgWH1q5kgFF5mIfnc7fjdZhgibVQL/b6rlYYL1GsRC
         sQe/uznigaRN4iaUgH5Wd3n5eQBNsRgw1KqC15AQgXMf+oIZM7JhizSY/Vi5NbWHwT34
         c8DQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhmjPmbpoghgvJ+qeidFAQjNb21kyzJC86AfrgEFQ+RapwTsVZxKvPxQCcn8HImV4J6ksFtxI4pqzypy98jVTS@vger.kernel.org, AJvYcCUmftTyksND2pni0ya1/5esM8/7BjfB2T8Kd49xtzPeGle0IPxT8HaNvg/VoYXQmk8kzuAM3n4pQwdMnkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbgBqZMfxLDzhOumM99gP3KdZMeufJP1e1eIb4FRGtipYL3Ilg
	kJ3N/PILa4rokwsTxeOKI4hdFVMWaENnA7pmu2dAEJYzP3Nnnaty
X-Google-Smtp-Source: AGHT+IHisrlTowfx/VJ7m0sQtw8H8eqK1asZeA3MTcRbBKm6CMycphyVsZSkH+bfUUftYtYVPH582A==
X-Received: by 2002:a05:690c:610c:b0:664:8646:4d02 with SMTP id 00721157ae682-6d40dd720bdmr25301197b3.12.1725027581858;
        Fri, 30 Aug 2024 07:19:41 -0700 (PDT)
Received: from localhost (fwdproxy-frc-020.fbsv.net. [2a03:2880:21ff:14::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6d2d57de3fbsm6291487b3.78.2024.08.30.07.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 07:19:41 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: tj@kernel.org
Cc: cgroups@vger.kernel.org,
	hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	lizefan.x@bytedance.com,
	mkoutny@suse.com,
	shuah@kernel.org
Subject: [PATCH v2 1/2] Tracking cgroup-level niced CPU time
Date: Fri, 30 Aug 2024 07:19:38 -0700
Message-ID: <20240830141939.723729-2-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240830141939.723729-1-joshua.hahnjy@gmail.com>
References: <20240830141939.723729-1-joshua.hahnjy@gmail.com>
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


