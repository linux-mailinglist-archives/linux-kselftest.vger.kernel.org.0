Return-Path: <linux-kselftest+bounces-39618-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 630ADB30ADC
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 03:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 030551C82F18
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 01:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF38B1A0730;
	Fri, 22 Aug 2025 01:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="asdIECFg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2257D1684A4
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 01:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755826735; cv=none; b=ZDRRRcGniubvg9G4YUvFqcuMU0UKMv8FME6YE08f+a8Ru+sgjQ8xk62fhjW+zcmeWVpXvzlqiea1mDuj2TcKRnS2oaN4INe1eTS3EO8TAlC0ZopvexP/ysetTGAkTZYAX3rqgMNWfRLK2S+xUWoINlwB6fXrCm1sOkNFQo5phks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755826735; c=relaxed/simple;
	bh=uzwVbtH3o+hjF2l5bOPykDA1fiOU/qSMF14O0eSqX1A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K4ut6Y/gSw/g8dznopYmpBUOK48/o0l+KJGblgmxB6SoocUbE8GGDeXGwcxZaxUgovKRbEUcCz2DVTG/Sjf6f0/t8R6we/gPViOpUSPuM5AMa6zI85kAgqIa30Ed15I5ZUww/hCAtG5bQQMqWVWM+dSf1fKT9su/GfhOfM5msEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=asdIECFg; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-246364842e7so6678805ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 18:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755826733; x=1756431533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XicJAgG/MZnmzphaKWfnZbo7JmxBw0IawJij22UnvYM=;
        b=asdIECFg5CBy4pTVEYORCBsjv8VKLgsmV38sDVgNkfQrt4MwHwy4RMwosCrixCUiIV
         IFj8kUrPmb6D/pCTjudj0T5mVKMHw6Wwtzrd3c/4bTVIWNTRiHPqlgIxpOv6jV2RZScl
         8Q284gJMJ5x18rGhq0ugUg/CpFSUFao1P0g5VLN3EuskZMUPrIQztsZolB1Bnwu1H22k
         d4/gPzSFuNqDf59pn4NGPtRbkvc01M7wntrYXaOhwnX+QPvwquR131ZS6EqVsBSBH/Lo
         hei1sfj+nliL4Esiw04ICDj/OjDVlI5iIXMOkvX3MfiQSgTQ6tFgNMiGFkyeWkNlxECQ
         gHsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755826733; x=1756431533;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XicJAgG/MZnmzphaKWfnZbo7JmxBw0IawJij22UnvYM=;
        b=kgOKcFQQ0fwnBKdllxR4yjYPacG+xsoGQ1nF/du1TUDASAGj9wGewxCogtjudPtdaJ
         2et/hs2VvMsEDWMYo55pEHc+ai4EXDrl+f2U4uYSXS9f8YoNh+kZ5cNV444E2SvGiq/d
         v48acm0Vt0VvyzkuZykXG4bQEVhZ97h64w4q1sLQ2BgAau/mwSx6hiMgpGeEBXvGEuUv
         CnnQV4C9HQkyDG91yhEPOTBIFtJEpagiQ6CS7LV9tkoNbd735R1AMmVp39AGSnbMHqdM
         kUFWFUOivH8+h4G7n4HL6nhBIPgWKyKBX9NnAsmOwIeqrepaFwzT1Szqk+mDrE/ZIwi6
         V4MQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSCu7L0tGOK7K3DEYZQMiX04fHdcggNraK7le8ogeiaAwu/9NWUJK1mN+zer3fiwhHw6I76t6v3+jshEQMZek=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWQAeeXKiQcla11sK10DbDDsbWX+KPptoY85pzKUkvMN17KDm+
	SuDsw4FrdGAffCc7KewPZ6kgxc1hKbTfCbBrV5+IQzRoci5h4I8Qs49dsEDwcotQQ0YSN4LC/iP
	BphwEG9kGVg==
X-Google-Smtp-Source: AGHT+IGM5W9uClBkGABg+25APHoASZyRNMkhP9+ED/Z5aAxqaCN5U58g337NiIzjq3f8aWlcxcFwpcQBD36K
X-Received: from plblw16.prod.google.com ([2002:a17:903:2ad0:b0:246:1648:2c77])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:238e:b0:240:50ef:2f00
 with SMTP id d9443c01a7336-2462eea80fbmr22118335ad.26.1755826733477; Thu, 21
 Aug 2025 18:38:53 -0700 (PDT)
Date: Thu, 21 Aug 2025 18:37:52 -0700
In-Reply-To: <20250822013749.3268080-6-ynaffit@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822013749.3268080-6-ynaffit@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250822013749.3268080-7-ynaffit@google.com>
Subject: [PATCH v4 1/2] cgroup: cgroup.stat.local time accounting
From: Tiffany Yang <ynaffit@google.com>
To: linux-kernel@vger.kernel.org
Cc: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Stephen Boyd <sboyd@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Chen Ridong <chenridong@huawei.com>, 
	kernel-team@android.com, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

There isn't yet a clear way to identify a set of "lost" time that
everyone (or at least a wider group of users) cares about. However,
users can perform some delay accounting by iterating over components of
interest. This patch allows cgroup v2 freezing time to be one of those
components.

Track the cumulative time that each v2 cgroup spends freezing and expose
it to userland via a new local stat file in cgroupfs. Thank you to
Michal, who provided the ASCII art in the updated documentation.

To access this value:
  $ mkdir /sys/fs/cgroup/test
  $ cat /sys/fs/cgroup/test/cgroup.stat.local
  freeze_time_total 0

Ensure consistent freeze time reads with freeze_seq, a per-cgroup
sequence counter. Writes are serialized using the css_set_lock.

Signed-off-by: Tiffany Yang <ynaffit@google.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Michal Koutn=C3=BD <mkoutny@suse.com>
---
v3 -> v4:
* Replace "freeze_time_total" with "frozen" and expose stats via
  cgroup.stat.local, as recommended by Tejun.
* Use the same timestamp when freezing/unfreezing a cgroup as its
  descendants, as suggested by Michal.

v2 -> v3:
* Use seqcount along with css_set_lock to guard freeze time accesses, as
  suggested by Michal.

v1 -> v2:
* Track per-cgroup freezing time instead of per-task frozen time, as
  suggested by Tejun.
---
 Documentation/admin-guide/cgroup-v2.rst | 18 ++++++++++++++++
 include/linux/cgroup-defs.h             | 17 +++++++++++++++
 kernel/cgroup/cgroup.c                  | 28 +++++++++++++++++++++++++
 kernel/cgroup/freezer.c                 | 16 ++++++++++----
 4 files changed, 75 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-=
guide/cgroup-v2.rst
index 51c0bc4c2dc5..a1e3d431974c 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1001,6 +1001,24 @@ All cgroup core files are prefixed with "cgroup."
 		Total number of dying cgroup subsystems (e.g. memory
 		cgroup) at and beneath the current cgroup.
=20
+  cgroup.stat.local
+	A read-only flat-keyed file which exists in non-root cgroups.
+	The following entry is defined:
+
+	  frozen_usec
+		Cumulative time that this cgroup has spent between freezing and
+		thawing, regardless of whether by self or ancestor groups.
+		NB: (not) reaching "frozen" state is not accounted here.
+
+		Using the following ASCII representation of a cgroup's freezer
+		state, ::
+
+			       1    _____
+			frozen 0 __/     \__
+			          ab    cd
+
+		the duration being measured is the span between a and c.
+
   cgroup.freeze
 	A read-write single value file which exists on non-root cgroups.
 	Allowed values are "0" and "1". The default is "0".
diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 6b93a64115fe..539c64eeef38 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -433,6 +433,23 @@ struct cgroup_freezer_state {
 	 * frozen, SIGSTOPped, and PTRACEd.
 	 */
 	int nr_frozen_tasks;
+
+	/* Freeze time data consistency protection */
+	seqcount_t freeze_seq;
+
+	/*
+	 * Most recent time the cgroup was requested to freeze.
+	 * Accesses guarded by freeze_seq counter. Writes serialized
+	 * by css_set_lock.
+	 */
+	u64 freeze_start_nsec;
+
+	/*
+	 * Total duration the cgroup has spent freezing.
+	 * Accesses guarded by freeze_seq counter. Writes serialized
+	 * by css_set_lock.
+	 */
+	u64 frozen_nsec;
 };
=20
 struct cgroup {
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 312c6a8b55bb..ab096b884bbc 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3763,6 +3763,27 @@ static int cgroup_stat_show(struct seq_file *seq, vo=
id *v)
 	return 0;
 }
=20
+static int cgroup_core_local_stat_show(struct seq_file *seq, void *v)
+{
+	struct cgroup *cgrp =3D seq_css(seq)->cgroup;
+	unsigned int sequence;
+	u64 freeze_time;
+
+	do {
+		sequence =3D read_seqcount_begin(&cgrp->freezer.freeze_seq);
+		freeze_time =3D cgrp->freezer.frozen_nsec;
+		/* Add in current freezer interval if the cgroup is freezing. */
+		if (test_bit(CGRP_FREEZE, &cgrp->flags))
+			freeze_time +=3D (ktime_get_ns() -
+					cgrp->freezer.freeze_start_nsec);
+	} while (read_seqcount_retry(&cgrp->freezer.freeze_seq, sequence));
+
+	seq_printf(seq, "frozen_usec %llu\n",
+		   (unsigned long long) freeze_time / NSEC_PER_USEC);
+
+	return 0;
+}
+
 #ifdef CONFIG_CGROUP_SCHED
 /**
  * cgroup_tryget_css - try to get a cgroup's css for the specified subsyst=
em
@@ -5354,6 +5375,11 @@ static struct cftype cgroup_base_files[] =3D {
 		.name =3D "cgroup.stat",
 		.seq_show =3D cgroup_stat_show,
 	},
+	{
+		.name =3D "cgroup.stat.local",
+		.flags =3D CFTYPE_NOT_ON_ROOT,
+		.seq_show =3D cgroup_core_local_stat_show,
+	},
 	{
 		.name =3D "cgroup.freeze",
 		.flags =3D CFTYPE_NOT_ON_ROOT,
@@ -5763,6 +5789,7 @@ static struct cgroup *cgroup_create(struct cgroup *pa=
rent, const char *name,
 	 * if the parent has to be frozen, the child has too.
 	 */
 	cgrp->freezer.e_freeze =3D parent->freezer.e_freeze;
+	seqcount_init(&cgrp->freezer.freeze_seq);
 	if (cgrp->freezer.e_freeze) {
 		/*
 		 * Set the CGRP_FREEZE flag, so when a process will be
@@ -5771,6 +5798,7 @@ static struct cgroup *cgroup_create(struct cgroup *pa=
rent, const char *name,
 		 * consider it frozen immediately.
 		 */
 		set_bit(CGRP_FREEZE, &cgrp->flags);
+		cgrp->freezer.freeze_start_nsec =3D ktime_get_ns();
 		set_bit(CGRP_FROZEN, &cgrp->flags);
 	}
=20
diff --git a/kernel/cgroup/freezer.c b/kernel/cgroup/freezer.c
index bf1690a167dd..6c18854bff34 100644
--- a/kernel/cgroup/freezer.c
+++ b/kernel/cgroup/freezer.c
@@ -171,7 +171,7 @@ static void cgroup_freeze_task(struct task_struct *task=
, bool freeze)
 /*
  * Freeze or unfreeze all tasks in the given cgroup.
  */
-static void cgroup_do_freeze(struct cgroup *cgrp, bool freeze)
+static void cgroup_do_freeze(struct cgroup *cgrp, bool freeze, u64 ts_nsec=
)
 {
 	struct css_task_iter it;
 	struct task_struct *task;
@@ -179,10 +179,16 @@ static void cgroup_do_freeze(struct cgroup *cgrp, boo=
l freeze)
 	lockdep_assert_held(&cgroup_mutex);
=20
 	spin_lock_irq(&css_set_lock);
-	if (freeze)
+	write_seqcount_begin(&cgrp->freezer.freeze_seq);
+	if (freeze) {
 		set_bit(CGRP_FREEZE, &cgrp->flags);
-	else
+		cgrp->freezer.freeze_start_nsec =3D ts_nsec;
+	} else {
 		clear_bit(CGRP_FREEZE, &cgrp->flags);
+		cgrp->freezer.frozen_nsec +=3D (ts_nsec -
+			cgrp->freezer.freeze_start_nsec);
+	}
+	write_seqcount_end(&cgrp->freezer.freeze_seq);
 	spin_unlock_irq(&css_set_lock);
=20
 	if (freeze)
@@ -260,6 +266,7 @@ void cgroup_freeze(struct cgroup *cgrp, bool freeze)
 	struct cgroup *parent;
 	struct cgroup *dsct;
 	bool applied =3D false;
+	u64 ts_nsec;
 	bool old_e;
=20
 	lockdep_assert_held(&cgroup_mutex);
@@ -271,6 +278,7 @@ void cgroup_freeze(struct cgroup *cgrp, bool freeze)
 		return;
=20
 	cgrp->freezer.freeze =3D freeze;
+	ts_nsec =3D ktime_get_ns();
=20
 	/*
 	 * Propagate changes downwards the cgroup tree.
@@ -298,7 +306,7 @@ void cgroup_freeze(struct cgroup *cgrp, bool freeze)
 		/*
 		 * Do change actual state: freeze or unfreeze.
 		 */
-		cgroup_do_freeze(dsct, freeze);
+		cgroup_do_freeze(dsct, freeze, ts_nsec);
 		applied =3D true;
 	}
=20
--=20
2.51.0.rc2.233.g662b1ed5c5-goog


