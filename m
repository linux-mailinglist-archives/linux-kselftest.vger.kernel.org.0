Return-Path: <linux-kselftest+bounces-43332-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9FBBE3FC2
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 16:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC0021A651CB
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 14:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A271345725;
	Thu, 16 Oct 2025 14:47:07 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A933343219
	for <linux-kselftest@vger.kernel.org>; Thu, 16 Oct 2025 14:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760626027; cv=none; b=uxf543/dm85R02m73ylKRsSx4fsK78ROFpxgyuxITmsdIUF5d6aUHs0MPOHeQt5tZg7Yw1FmxDu+eXjZAyZXwls63axMbBUY0zCElkKf0oJF3dNbmKW9tdgEQwafjxz/CPsHC3afytTHOalj3BBLwKv5UFxIMr13Y3ATMdHgd3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760626027; c=relaxed/simple;
	bh=BtawZQfHc3r94zhdPsLAO1Sny98T6rBbY+VgVvkTtNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FrHlTWEkBvZnwOC5Ua6GjrACOweldik8hF8Pm/5q+6OmCG2VezXcwEiC1BqPXrw4un0BxlfCheOtYFPkxCcZNSYvlW4ldYf3Er0gDngMB2eQHWKsmo/8qRNxzSb6HzFqpPOAuGBGdEQHqDYOeBnmyAcZ0mljfghQQpQGdnMftJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=yonch.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=yonch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7b00927607eso585803a34.0
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Oct 2025 07:47:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760626023; x=1761230823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/EHCgPHyfakU523tKXhaAbUatgQF6sU/svILEddytVE=;
        b=DZi/LeoaR6b/EQuk9jFP5v31mhyzc3RqVoP42LVh0Jvph88aatMh4re8vJNsbnWPaN
         eyja758h0faKgcPaXC9ukvz4NtKlEm3Lx7oHoJrO0+6QFVlOlaNUgNUXA9rgFLux2I//
         bYA77L7gXvaX7RjYg65iqvsOHETVJrUYr1BCcE7/tfKPtELC/PgLxzlxYecbdFQq7bjQ
         oXXrjjD0IHWrGT1N2xPNWiZp/T1iJRGGeGrH59F2YuIv7wM+Y8IrJIEIMEz3z8SzRbKw
         BaEng6BDgeNsv3+J+QSmKWTO7MXmK9RsOKgmlBJ+S5HecKJq5cJLA9gX90eY/6OmAJ6T
         OWDQ==
X-Gm-Message-State: AOJu0YxaV1CZBTm34bT+hRF2RWWglg0ajHt9YNhd24A8KAd3x7btmxCr
	GtzWgUut2TI+a1jGIylLNknE+8xZCT2jagRRMfRGbMG/J02w9iI4CwDX
X-Gm-Gg: ASbGncs2wR7XCh7lvyaVKHDmFhDiJpDSGz4lctLBkAEZJbn+1GRR8kMgSbnbKNe9xoZ
	OohqROoHJ4ee8WwodLUpO2DjH6ZTK6mkteWyFzcMCkzxqy8LvaetvS4GUbySC/8czTzo1Wxc+Rg
	9Q9nG+zQMYw0/v2jI2433JJ6OYu+mfOYBpcbLbqGnI/AxjOrQRO9HzwMA2eOIrz5xUfxs5wfKG5
	XnmUAmBjgQ3XqjhikVfG9a7MfvqJLp5d3rOEUn7oQRQYO2jYXlgdRgnV8aQ3xTzG0mRp1rFs7ES
	4drp902bkq6RhYq11xiEgPdEeENaitQL1qF9d3FRlLZrozf1d3ALc+TUI1o+Ll8/027VxtTGAty
	J1cKP6pCSI/fq7sAPU9YVySEdMW/st/nh5RWQ2zHIfM7+HAAk/FZkWw7hd2IlQC582PjMFcLZx2
	ViwEfIeJMr4S1W2nG6UDYpHBmeh+rJxT6ErYn9jNQC60s1sVMyl3gY5L9D
X-Google-Smtp-Source: AGHT+IFaoc5h662tQMy3sYuAt7P7VYvJhJI8+JkPL9/LadjSZTqNRwdw+T5zs/QxcPeMC09gOumcZw==
X-Received: by 2002:a05:6808:250a:b0:441:c9c5:b76d with SMTP id 5614622812f47-443a2e63051mr110288b6e.28.1760626023486;
        Thu, 16 Oct 2025 07:47:03 -0700 (PDT)
Received: from localhost.localdomain (syn-067-079-108-173.biz.spectrum.com. [67.79.108.173])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-441cc812f24sm3678018b6e.12.2025.10.16.07.47.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Oct 2025 07:47:03 -0700 (PDT)
From: Jonathan Perry <yonch@yonch.com>
To: Tony Luck <tony.luck@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	James Morse <james.morse@arm.com>,
	Roman Storozhenko <romeusmeister@gmail.com>,
	Jonathan Perry <yonch@yonch.com>
Subject: [PATCH 2/8] resctrl/mon: Split RMID read init from execution
Date: Thu, 16 Oct 2025 09:46:50 -0500
Message-ID: <20251016144656.74928-3-yonch@yonch.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251016144656.74928-1-yonch@yonch.com>
References: <20251016144656.74928-1-yonch@yonch.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce rmid_read_init() to fill struct rmid_read (resource, domain,
rdtgroup, event id, flags, ci). Change mon_event_read() to accept a
prepared rmid_read and a CPU mask.

Update callers to use rmid_read_init() + mon_event_read().

This prepares reuse from contexts that pre-select the CPU (e.g. the
perf PMU) without duplicating initialization logic.

No functional change intended.

Signed-off-by: Jonathan Perry <yonch@yonch.com>
---
 fs/resctrl/ctrlmondata.c | 40 ++++++++++++++++++++++------------------
 fs/resctrl/internal.h    |  5 +++--
 fs/resctrl/rdtgroup.c    |  6 ++++--
 3 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index 0d0ef54fc4de..82f8ad2b3053 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -546,28 +546,31 @@ struct rdt_domain_hdr *resctrl_find_domain(struct list_head *h, int id,
 	return NULL;
 }
 
-void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
+void rmid_read_init(struct rmid_read *rr, struct rdt_resource *r,
 		    struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
-		    cpumask_t *cpumask, int evtid, int first)
+		    int evtid, int first, struct cacheinfo *ci)
 {
-	int cpu;
-
-	/* When picking a CPU from cpu_mask, ensure it can't race with cpuhp */
-	lockdep_assert_cpus_held();
-
-	/*
-	 * Setup the parameters to pass to mon_event_count() to read the data.
-	 */
+	memset(rr, 0, sizeof(*rr));
 	rr->rgrp = rdtgrp;
 	rr->evtid = evtid;
 	rr->r = r;
 	rr->d = d;
 	rr->first = first;
+	rr->ci = ci;
 	if (resctrl_arch_mbm_cntr_assign_enabled(r) &&
-	    resctrl_is_mbm_event(evtid)) {
+	    resctrl_is_mbm_event(evtid))
 		rr->is_mbm_cntr = true;
-	} else {
-		rr->arch_mon_ctx = resctrl_arch_mon_ctx_alloc(r, evtid);
+}
+
+void mon_event_read(struct rmid_read *rr, cpumask_t *cpumask)
+{
+	int cpu;
+
+	/* When picking a CPU from cpu_mask, ensure it can't race with cpuhp */
+	lockdep_assert_cpus_held();
+
+	if (!rr->is_mbm_cntr) {
+		rr->arch_mon_ctx = resctrl_arch_mon_ctx_alloc(rr->r, rr->evtid);
 		if (IS_ERR(rr->arch_mon_ctx)) {
 			rr->err = -EINVAL;
 			return;
@@ -588,7 +591,7 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 		smp_call_on_cpu(cpu, smp_mon_event_count, rr, false);
 
 	if (rr->arch_mon_ctx)
-		resctrl_arch_mon_ctx_free(r, evtid, rr->arch_mon_ctx);
+		resctrl_arch_mon_ctx_free(rr->r, rr->evtid, rr->arch_mon_ctx);
 }
 
 int rdtgroup_mondata_show(struct seq_file *m, void *arg)
@@ -635,9 +638,9 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 				ci = get_cpu_cacheinfo_level(cpu, RESCTRL_L3_CACHE);
 				if (!ci)
 					continue;
-				rr.ci = ci;
-				mon_event_read(&rr, r, NULL, rdtgrp,
-					       &ci->shared_cpu_map, evtid, false);
+				rmid_read_init(&rr, r, NULL, rdtgrp,
+					       evtid, false, ci);
+				mon_event_read(&rr, &ci->shared_cpu_map);
 				goto checkresult;
 			}
 		}
@@ -654,7 +657,8 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 			goto out;
 		}
 		d = container_of(hdr, struct rdt_mon_domain, hdr);
-		mon_event_read(&rr, r, d, rdtgrp, &d->hdr.cpu_mask, evtid, false);
+		rmid_read_init(&rr, r, d, rdtgrp, evtid, false, NULL);
+		mon_event_read(&rr, &d->hdr.cpu_mask);
 	}
 
 checkresult:
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 63fb4d6c21a7..dcc0b7bea3ac 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -363,9 +363,10 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg);
 int rdtgroup_mondata_open(struct kernfs_open_file *of);
 void rdtgroup_mondata_release(struct kernfs_open_file *of);
 
-void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
+void rmid_read_init(struct rmid_read *rr, struct rdt_resource *r,
 		    struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
-		    cpumask_t *cpumask, int evtid, int first);
+		    int evtid, int first, struct cacheinfo *ci);
+void mon_event_read(struct rmid_read *rr, cpumask_t *cpumask);
 
 int resctrl_mon_resource_init(void);
 
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 17b61dcfad07..34337abe5345 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -3235,8 +3235,10 @@ static int mon_add_all_files(struct kernfs_node *kn, struct rdt_mon_domain *d,
 		if (ret)
 			return ret;
 
-		if (!do_sum && resctrl_is_mbm_event(mevt->evtid))
-			mon_event_read(&rr, r, d, prgrp, &d->hdr.cpu_mask, mevt->evtid, true);
+		if (!do_sum && resctrl_is_mbm_event(mevt->evtid)) {
+			rmid_read_init(&rr, r, d, prgrp, mevt->evtid, true, NULL);
+			mon_event_read(&rr, &d->hdr.cpu_mask);
+		}
 	}
 
 	return 0;

