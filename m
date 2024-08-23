Return-Path: <linux-kselftest+bounces-16182-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5D095D7AB
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 22:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF55F286091
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 20:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEC41A2547;
	Fri, 23 Aug 2024 20:13:21 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521911A0AEA;
	Fri, 23 Aug 2024 20:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724444001; cv=none; b=nGcuibytJznGqrWWHWjtZo8jO8cS7Ow9ptR9igiMJRu3tJLnl8ImNCaRs9BH5YRmmw0Z+vfY3JtvwsFCorpCMrDoMtP0nxBQWMsTyabXLLQ9QhPmBZnjUcQ45AnetYqlNJMdAMPDMQN0bz4EwhoSSzypuVYw+c/lQLK+86i55GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724444001; c=relaxed/simple;
	bh=UL/XckKo3kn7th1uM+7y69Pt86ODI3pVVR/tWeCFLEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UyCY2ADwSixgjZm9yXGEobTILTP4KgkPsMGWeUXeSui4obghySI19laoyfjDEAMHCPyp3zoqsAlA/j2p8O3gSPgc2dcD2gEA4/hxSniARZXRzcqmNFjTdW9xo32164V/R7hMPL1xn4A+kuZrdShwDjwBMg38K5VDeWlgghIEwHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e1659e9a982so2690741276.1;
        Fri, 23 Aug 2024 13:13:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724443999; x=1725048799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nWwDIy8I8h3qLuacU8FLKoOjmAz8N3kjG+Ycu/vPy88=;
        b=l86DybrcIV5J6nEwrRv3mMxn4e4+dSak3u25s4+5VvSoVNPa4JYa99egimnQ//tAHL
         vF1bKKXTRnjzrhpRyZBwfHEX5GFAykXK9dY2P0JNwQQZXaFTtJayMa9jVSPQvwb1sd6y
         rlx7fgXg7uOTt/V7QfjenCyI1tK9MB3LS13vgH0Nd/ECIKVRHT1bOn8Y7pMrSpSmj9CL
         Q6ERNN282XnaJggOzLk146FMEgBe5XgGB3RzqyVjrMbPw/iOuJ1cIiznD5ut3gJS2Cpn
         QC8bXpjj33EUoJw4Pyc27Y+BVFjf99X0SUDeen9vSsLD9b9qPbQgfaip/JMEQ8KT6fLB
         ojjw==
X-Forwarded-Encrypted: i=1; AJvYcCU28+UkV3S2sfs/JYr6V2ikrl7H+jScMiBvGK8WE0EylT7zc+Iczw3kPKMc+TQS+n/orQtVD+UhGRqDMGT8@vger.kernel.org, AJvYcCXFg2h882R+7nI4IqKHQE4Jjkl8oN6HwCgCkNM3D00DwvSGIxmOB8faunoDCjgVro5CSdBS2HsSMHH/IxLeajDZ@vger.kernel.org, AJvYcCXnjfyvY3msG1GJ0ut8Q5+B9DdsOEm7iVJt0deQjrPw0n8faeRa4dJL9eaCLIWSriKHnOZZ48cs@vger.kernel.org
X-Gm-Message-State: AOJu0YwKAOfPVoNbNZya2orkWhMWAlua++s+Gyd+JQThFLW+aN2lTQjb
	BKFM+Odw0oQdegOXqfiDVCwcvmU+Vu86hPzRVWheAVJm8deDmBqo
X-Google-Smtp-Source: AGHT+IGGQcXqQBnVapgoipWzzWG7/XIjvm84064Irp0z/7OKPnrFAtLNiyo8JHuDyQL335N3YTTz7g==
X-Received: by 2002:a05:6902:1895:b0:e0b:e28c:b4f4 with SMTP id 3f1490d57ef6-e17a8666314mr4182818276.38.1724443999227;
        Fri, 23 Aug 2024 13:13:19 -0700 (PDT)
Received: from localhost (fwdproxy-frc-007.fbsv.net. [2a03:2880:21ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e178e4637e1sm788386276.15.2024.08.23.13.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 13:13:18 -0700 (PDT)
From: Joshua@web.codeaurora.org, Hahn@web.codeaurora.org,
	joshua.hahn6@gmail.com
To: tj@kernel.org
Cc: lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	shuah@kernel.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 1/2] Tracking cgroup-level niced CPU time
Date: Fri, 23 Aug 2024 13:05:17 -0700
Message-ID: <20240823201317.156379-2-joshua.hahn6@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240823201317.156379-1-joshua.hahn6@gmail.com>
References: <20240823201317.156379-1-joshua.hahn6@gmail.com>
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
hardware limits and can facilitate better load-balancing.

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


