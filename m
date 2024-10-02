Return-Path: <linux-kselftest+bounces-18922-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4088298E2CB
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 20:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EECDF2835E5
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 18:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0202141B9;
	Wed,  2 Oct 2024 18:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6KMvQSY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087701CFEDB;
	Wed,  2 Oct 2024 18:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727894842; cv=none; b=nQWtUmZPqFWNjXo+DYFEU1IHy6gjy2DSl1aqdzfl4h+F14SBRCfnh0nADTerdv4kP8T1IIg9JAGq60SBxVz7vGkzHKbNqjNsMpsrCRm9gewb2Fi6zSgWI3mKATVVIXlRjrQodDlBapub+6yXgRk7A/Vw+Yi4TQRMMaoD3QSZ6ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727894842; c=relaxed/simple;
	bh=QFpi4nOmAYmWPRfEpCi2cboXqTYLLkYBgebDPN8ccVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VCx90EBddDGQkFk7eElLweE4/0srpo4qVbfdVH3PBfCbNcZIcRhXnpv2z6+M/ZMMQgR27IsRTyRA69MhCb8VUOfVMkIWdNKSZ3ATXkgFMgoWOsnGTseAG3JoS1Wf694ORE7js68bEqhKXfkPGXX/jFulq2bII1Z92xqw8oaId6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6KMvQSY; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e26290a13d5so114304276.1;
        Wed, 02 Oct 2024 11:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727894840; x=1728499640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DK/LZr4KfG4ktKDCJuZWCOYnYGLFEtPM2432GNAs3Jg=;
        b=Z6KMvQSYSbFdFygIo2dHGQToth4hdcPpwzq1Gxm0UXyRfxrWi0y3bjCC7U52p8cPac
         hn26hEgrDwR+3kvdXTtb5s34nVdY16qXxEdpHxuFt318aN97bGHWKgUlC2dBzkuivGS1
         nYv37ULHNu8l+eN14BmZai6tbW10oHmlDYKf1uNSC8KQjuRzA36hFt0H+dM/hdIaDEpz
         NLyReZgaUxq1qmtVGL7pu5jHzW7kcXdF+0PJjnePZtl1QvNsHek+q0DXboGXctTzfkQf
         1F+uHao1ZxRbc+d73n425MoZHM2reyynevh+rfJp5viAoo1ZvAkFxcsjCa8QHW3Y8sZz
         6mrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727894840; x=1728499640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DK/LZr4KfG4ktKDCJuZWCOYnYGLFEtPM2432GNAs3Jg=;
        b=kBYgmXqOQ3ZjwkLzQC9nqkj+JjUt3b4bjW1RKctDj/Wr7TirlKHFd/bjkx2LQdw7UU
         FLJBeniIwr972V9vi2zGnSgfHt3xL62fRixIJW/gPYKCvNxOg6VpPfh0VDelkPY/Z0W7
         vasXIk9f6RLQBqhWJMRkXxhAUPwNt0lBAoOI8DbJnHuLzuAY9XgdXcqoLr5UuZbv7dWI
         yiVey7Y/hQcBoQQiT/LgtQlL2tjC+tqdxSG+qYa/G0714YRWB1cHlE+Kv9DxnNw4/fhc
         L68bJ83PSHWE65uCWz37lkIfBHjxyVKZ25FmtCYdy9rZQUeshFGTgh92MsnT7ytJAkaA
         dfPg==
X-Forwarded-Encrypted: i=1; AJvYcCWS5Z5vk9mVNbhSsJJJM9IaMY2WTS2WEKWnOAnI/xxsglykQaAT61cxT9wID4yU0G4nmAyCpB6sFvYMeP4taH4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6vRX6FphEBOcidAqOM+S1YB+WQCCCp2Zg1r85pBbZWVBYj8eK
	I80kRnQQ00RVGVmQorkMZkeCUq743h23HMvpK5708f2i+clQaIuHj0ut7oS1
X-Google-Smtp-Source: AGHT+IEoqKXosAnJjmt/xj4/xLRZUmOviH2rVrhqNYdE30zrxyW0en3k/UIyTlNZDv7u9dQwOJ9JxA==
X-Received: by 2002:a05:690c:4a88:b0:6db:da26:e8c6 with SMTP id 00721157ae682-6e2a310688emr29344987b3.44.1727894839797;
        Wed, 02 Oct 2024 11:47:19 -0700 (PDT)
Received: from localhost (fwdproxy-frc-007.fbsv.net. [2a03:2880:21ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e24530aeeesm26148777b3.47.2024.10.02.11.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 11:47:19 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: tj@kernel.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	hannes@cmpxchg.org,
	linux-kernel@vger.org,
	linux-kselftest@vger.kernel.org,
	lizefan.x@bytedance.com,
	shuah@kernel.org
Subject: [PATCH v4 1/2] cgroup/rstat: Tracking cgroup-level niced CPU time
Date: Wed,  2 Oct 2024 11:47:16 -0700
Message-ID: <20241002184717.153302-2-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241002184717.153302-1-joshua.hahnjy@gmail.com>
References: <20241002184717.153302-1-joshua.hahnjy@gmail.com>
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
 kernel/cgroup/rstat.c       | 19 ++++++++++++++-----
 2 files changed, 15 insertions(+), 5 deletions(-)

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
index a06b45272411..5877974ece92 100644
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
@@ -534,8 +536,10 @@ void __cgroup_account_cputime_field(struct cgroup *cgrp,
 	rstatc = cgroup_base_stat_cputime_account_begin(cgrp, &flags);
 
 	switch (index) {
-	case CPUTIME_USER:
 	case CPUTIME_NICE:
+		rstatc->bstat.ntime += delta_exec;
+		fallthrough;
+	case CPUTIME_USER:
 		rstatc->bstat.cputime.utime += delta_exec;
 		break;
 	case CPUTIME_SYSTEM:
@@ -591,6 +595,7 @@ static void root_cgroup_cputime(struct cgroup_base_stat *bstat)
 #ifdef CONFIG_SCHED_CORE
 		bstat->forceidle_sum += cpustat[CPUTIME_FORCEIDLE];
 #endif
+		bstat->ntime += cpustat[CPUTIME_NICE];
 	}
 }
 
@@ -608,13 +613,14 @@ static void cgroup_force_idle_show(struct seq_file *seq, struct cgroup_base_stat
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
@@ -622,16 +628,19 @@ void cgroup_base_stat_cputime_show(struct seq_file *seq)
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
-		   "user_usec %llu\n"
-		   "system_usec %llu\n",
-		   usage, utime, stime);
+			"user_usec %llu\n"
+			"system_usec %llu\n"
+			"nice_usec %llu\n",
+			usage, utime, stime, ntime);
 
 	cgroup_force_idle_show(seq, &cgrp->bstat);
 }
-- 
2.43.5


