Return-Path: <linux-kselftest+bounces-43333-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 277BDBE3FC7
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 16:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 943681A6577B
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 14:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76788345741;
	Thu, 16 Oct 2025 14:47:08 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782193451C4
	for <linux-kselftest@vger.kernel.org>; Thu, 16 Oct 2025 14:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760626028; cv=none; b=D+9chC8LXa9hEP0Zyu3x1U0aH0LL03jhISeu01SwW5SJ37D0aoJNfCQKztSgLtEru9ZzAld5CAMFj2uFj228Ttr8IPR29TfJpGVTpXX3GfN9zDWdh+E5wUsv2Vz1enPWzseOHaU7fhFOhIleEuy7YN3A26SRAPBb02ij5ANwP/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760626028; c=relaxed/simple;
	bh=vxd5viqIAF53p9qHcx2+SSC6DWLKIshKJ2YVAGNmP6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KmSIDLxwbZsMSUM71Y0KcPMrLx3J6HmH4C2gsF7uvX4KzsYD+68x+BHu4kuml3c3Z96FVdXF6IQVMrjMqe9lnH+b4lcJy4f7L60GYCCCIwyt2aeM59xlejgu7njwf8yBrfU0g/qTH9nLxhGyEItnk+h9LDw7N8R+5Zv4tddsorg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=yonch.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=yonch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-43f5ec025d3so480281b6e.1
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Oct 2025 07:47:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760626025; x=1761230825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WkeQ5GVzAIUDDgYC2BBLNxE47r9RQHz/6gTcvpiCb7E=;
        b=tTAN14TuBXk4TXCkPVsaeymPhgtB266+kkXYsW3xbkHHiTN1eI3XHpOqeZtl03PyY0
         KanOpREhNYKKSAUObcpqyyLbQ8GTU/nqGcfVBdhsJNmumIvdbz8jHkNU2NRLocwhlnWU
         pXxoLFlW/c0VZFo12h4kQ6ZvWHg2O01HP4zrU/30Ggsmz5TAMnple8x0VEnwi/RxjsFM
         pBm5sXz1HSXleLUU5zgt6dgdbeTSq7JltYWlUTe4lGXeCRZijzRe+n4vW7Y1Gl8n3nH2
         p7Y7qPiZfREqGbmaouHNpbTeHl2jQLfXQLouS5qfmqI9t9y4ehSf+w7l8xAbYgjh2rxi
         XZ6g==
X-Gm-Message-State: AOJu0YwtGf4/t6hA0bMdw59fRp58MVyllzq+7J7lRTMFQPsVIx6ipyUi
	L1Di/1W5Cp6pZtwgfiPpL7oyTAT2xR7QOKdZwDoXNPdg4TvbY87I8Jt8
X-Gm-Gg: ASbGncuR9oqYsfJdkBn9hFdOPjN+oNpgpOtv9Cg58OvYVTT2EAFRX0hQga103I0mlzI
	eiPZbCdKc+eC7CASRj949V4qVXbiX0BFHe0BR6w7o8AzQXD1VoVgu3qYcGWpbMuw9LuCfWYFutz
	ZXQ5arbbYPTcspsu1ZMG1prRw5ohaGwxOJWl8wubg7MEBQPQ89YLuVAqOr5qhysgNFNJeA5BC3c
	oSS/UxgpnMzLcva4bYXVThU/tmGNUcWpoy9LZ1n1IWod8xIhzPd8eewkI2+6/yF0gT8E6ooGkxF
	i7w8PrtgnpivEeLHFBpCr0QrkZkgJ4Mu02AGKgM1DFBkqJkazj5DumvU33z+zcG1G37TQfFKfkb
	11Xp3eKb498CgD5r5MZcKEUqPcM2mgwcxVNbT5FVq/kziQaXE4Fd66tMFX/nFIEKUOJAZv8Mzab
	fkfCXEwuHrTlLLQa7eSCKD6n8OLlSdGyVphwNjfwGN6R/xG5xoiqc2sZ7H
X-Google-Smtp-Source: AGHT+IHad8QU7400Suvztwz7R3TknwRXuPTBhGJThjhex4bA27wajLbo4tHyKKwflCEojRIUm28PFg==
X-Received: by 2002:a05:6808:14c5:b0:43f:507f:ced2 with SMTP id 5614622812f47-443a2f1b8camr127533b6e.23.1760626025484;
        Thu, 16 Oct 2025 07:47:05 -0700 (PDT)
Received: from localhost.localdomain (syn-067-079-108-173.biz.spectrum.com. [67.79.108.173])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-441cc812f24sm3678018b6e.12.2025.10.16.07.47.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Oct 2025 07:47:05 -0700 (PDT)
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
Subject: [PATCH 4/8] resctrl/mon: Create mon_event_setup_read() helper
Date: Thu, 16 Oct 2025 09:46:52 -0500
Message-ID: <20251016144656.74928-5-yonch@yonch.com>
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

Refactor the selection of monitored event from the kernfs seq_show
handler to a helper function. This provides a single setup path that
the resctrl PMU will reuse.

Add mon_event_setup_read() to encapsulate domain lookup,
rmid_read_init(), and selection of the valid CPU mask for the read.
Rework rdtgroup_mondata_show() to call the helper before reading.

No functional change intended.

Signed-off-by: Jonathan Perry <yonch@yonch.com>
---
 fs/resctrl/ctrlmondata.c | 71 ++++++++++++++++++++++------------------
 fs/resctrl/internal.h    |  2 ++
 2 files changed, 41 insertions(+), 32 deletions(-)

diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index f28328c49479..d1e4cf6f2128 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -594,32 +594,16 @@ void mon_event_read(struct rmid_read *rr, cpumask_t *cpumask)
 		resctrl_arch_mon_ctx_free(rr->r, rr->evtid, rr->arch_mon_ctx);
 }
 
-int rdtgroup_mondata_show(struct seq_file *m, void *arg)
+int mon_event_setup_read(struct rmid_read *rr, cpumask_t **cpumask,
+			 struct mon_data *md, struct rdtgroup *rdtgrp)
 {
-	struct kernfs_open_file *of = m->private;
 	enum resctrl_res_level resid;
 	enum resctrl_event_id evtid;
 	struct rdt_domain_hdr *hdr;
-	struct rmid_read rr = {0};
 	struct rdt_mon_domain *d;
-	struct rdtgroup *rdtgrp;
-	int domid, cpu, ret = 0;
 	struct rdt_resource *r;
 	struct cacheinfo *ci;
-	struct mon_data *md;
-	cpumask_t *cpumask;
-
-	rdtgrp = rdtgroup_kn_lock_live(of->kn);
-	if (!rdtgrp) {
-		ret = -ENOENT;
-		goto out;
-	}
-
-	md = of->kn->priv;
-	if (WARN_ON_ONCE(!md)) {
-		ret = -EIO;
-		goto out;
-	}
+	int domid, cpu;
 
 	resid = md->rid;
 	domid = md->domid;
@@ -639,30 +623,53 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 				ci = get_cpu_cacheinfo_level(cpu, RESCTRL_L3_CACHE);
 				if (!ci)
 					continue;
-				rmid_read_init(&rr, r, NULL, rdtgrp,
-						     evtid, false, ci);
-				cpumask = &ci->shared_cpu_map;
-				goto perform;
+				rmid_read_init(rr, r, NULL, rdtgrp,
+					       evtid, false, ci);
+				*cpumask = &ci->shared_cpu_map;
+				return 0;
 			}
 		}
-		ret = -ENOENT;
-		goto out;
+		return -ENOENT;
 	} else {
 		/*
 		 * This file provides data from a single domain. Search
 		 * the resource to find the domain with "domid".
 		 */
 		hdr = resctrl_find_domain(&r->mon_domains, domid, NULL);
-		if (!hdr || WARN_ON_ONCE(hdr->type != RESCTRL_MON_DOMAIN)) {
-			ret = -ENOENT;
-			goto out;
-		}
+		if (!hdr || WARN_ON_ONCE(hdr->type != RESCTRL_MON_DOMAIN))
+			return -ENOENT;
+
 		d = container_of(hdr, struct rdt_mon_domain, hdr);
-		rmid_read_init(&rr, r, d, rdtgrp, evtid, false, NULL);
-		cpumask = &d->hdr.cpu_mask;
+		rmid_read_init(rr, r, d, rdtgrp, evtid, false, NULL);
+		*cpumask = &d->hdr.cpu_mask;
+		return 0;
 	}
+}
 
-perform:
+int rdtgroup_mondata_show(struct seq_file *m, void *arg)
+{
+	struct kernfs_open_file *of = m->private;
+	struct rmid_read rr = {0};
+	struct rdtgroup *rdtgrp;
+	int ret = 0;
+	struct mon_data *md;
+	cpumask_t *cpumask;
+
+	rdtgrp = rdtgroup_kn_lock_live(of->kn);
+	if (!rdtgrp) {
+		ret = -ENOENT;
+		goto out;
+	}
+
+	md = of->kn->priv;
+	if (WARN_ON_ONCE(!md)) {
+		ret = -EIO;
+		goto out;
+	}
+
+	ret = mon_event_setup_read(&rr, &cpumask, md, rdtgrp);
+	if (ret)
+		goto out;
 	mon_event_read(&rr, cpumask);
 
 	/*
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index dcc0b7bea3ac..486cbca8d0ec 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -366,6 +366,8 @@ void rdtgroup_mondata_release(struct kernfs_open_file *of);
 void rmid_read_init(struct rmid_read *rr, struct rdt_resource *r,
 		    struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
 		    int evtid, int first, struct cacheinfo *ci);
+int mon_event_setup_read(struct rmid_read *rr, cpumask_t **cpumask,
+			 struct mon_data *md, struct rdtgroup *rdtgrp);
 void mon_event_read(struct rmid_read *rr, cpumask_t *cpumask);
 
 int resctrl_mon_resource_init(void);

