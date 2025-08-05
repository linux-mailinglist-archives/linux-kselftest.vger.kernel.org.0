Return-Path: <linux-kselftest+bounces-38264-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38747B1ACBC
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 05:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5744189D4EC
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 03:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F23F1F2C45;
	Tue,  5 Aug 2025 03:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aZRfkusK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571E31EBA0D
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Aug 2025 03:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754364603; cv=none; b=C2psSVGdeAQ6i+goa5Bd4qTqD3rsnIHrXJ47z1AFO5PGhqIJrqFYSarujUqFAMxp6+UaVo9QbewjVwCOaq7VUQKzz4WXSLm2TajPLiBWvL4tf/2I1u0r6AHnuFGCuMQ2wDHEBEyiyzKYjBuu0MRe6qZ5nwqTNos5Vv7jGklgEHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754364603; c=relaxed/simple;
	bh=fDfEkL0C1rqBLXDR2StNpNta3DtjBXRZvCDkVe2UG0A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c6qUJW4V1Ye8FeBxWV01kgwK+qCc8hiCa4s29G5zGr3nc35HbrYN6P5x5xb5slUVDHNra3tDNrZl9Ja+k4t5B6IvjGgP8r4w5AAzt4SB4mwb0IPhTubAVq155Wlf/fReuib0MGK+qCtVcLYZYbCF/KOzPk4e8qvvlLHapnJaABc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aZRfkusK; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b3beafa8d60so6874364a12.3
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Aug 2025 20:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754364601; x=1754969401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K4p8AcJCyHxjXmF8HoBT5J3THAUNQ+6uS5V9VLSK4rA=;
        b=aZRfkusKyozZbuQGCixms11fGC+l2xC51nm1b5mMu8Vjf31wB5FkQ8hbp+SqZI1waU
         1mo4MRBjRigFEovOhvk5uikrJhslSGOdRyBePjoMPpCOaJXk4UCfyT6V3+wx40vxXW4P
         0yCLgeJ6UjkCFGs5T5m2MpYN4b3F+nSDNnDZ+bFrnffvYNeTKVt23fjDJndoDcUFKzze
         1RPLzx4MkHX6srapNjMhj+HLPKF8qzP8hj6ik+vJA+u4u5B5r3f3EnNJNUOiAB9oBTtc
         5zXjPkoQp0k36DNYl+9nYXb2lbsNajMlrl7ELprGwVNIGGfSzNsM41me9RSVEU6gjNp+
         khbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754364601; x=1754969401;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K4p8AcJCyHxjXmF8HoBT5J3THAUNQ+6uS5V9VLSK4rA=;
        b=WbB7fsSzMpgzQOvcsRt2dQSPrk1QCHjnQ4zwjtVfs152Mbrs/5nbvgDXukIYIP5pnW
         QIFpnl6Hb/c3SwdqcS654e1fkD6ZxzHmnu75W4y8v9i7AxX4VFLWxU4YGywXhmAheLBz
         zX/q3DQRXdnJe4C1sIqWIig6ghdVXdXtdl1bP/rncc0JbkmZdBEz7bPblnwAAWYozZk5
         b0QxbLFabaV4fz7+i2PCp38pF2CA2espxPV+NJPR9CDUmoxKkuecLMdNKcCUX2yUfxzo
         7yYyFj8MLZIFslgb/6lozB+43XACg8cvVA3g8rz4O84/sNvtYQhKw/b116okl154V46c
         7kQg==
X-Forwarded-Encrypted: i=1; AJvYcCV9I5FzaYGxoQkWjHQgkY45y5goRpaUN3AKa6QSwm0lHgab5gUuIhG11d/p/g/z/uDzf7Ym/0W+53UgDfzPwbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxGLrRNbm2inn16HS77rlhJZdiaCp/sqfQwLPNVLiuFy2SMzeh
	vxl4+MYGXzMQAfUGMhxhWTwfWJ27y6YVplLNmUrre9DWdJw8XPSt18yCtBm5NVNVNyUO7SxC3WN
	0OYblxMH8pw==
X-Google-Smtp-Source: AGHT+IFft3BIGzY8qacZ1IDZsSwsJUuuDz/vwzpETTMxDLB25J/qG34n1Pick/LSnERnOECcA/1kZcNvMb1v
X-Received: from plox8.prod.google.com ([2002:a17:902:8ec8:b0:240:296e:ee32])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:22cb:b0:23f:df69:af50
 with SMTP id d9443c01a7336-24246ff2665mr181013195ad.34.1754364600672; Mon, 04
 Aug 2025 20:30:00 -0700 (PDT)
Date: Mon,  4 Aug 2025 20:29:41 -0700
In-Reply-To: <20250805032940.3587891-4-ynaffit@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250805032940.3587891-4-ynaffit@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250805032940.3587891-5-ynaffit@google.com>
Subject: [RFC PATCH v3 1/2] cgroup: cgroup.freeze.stat.local time accounting
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
Content-Type: text/plain; charset="true"
Content-Transfer-Encoding: quoted-printable

There isn't yet a clear way to identify a set of "lost" time that
everyone (or at least a wider group of users) cares about. However,
users can perform some delay accounting by iterating over components of
interest. This patch allows cgroup v2 freezing time to be one of those
components.

Track the cumulative time that each v2 cgroup spends freezing and expose
it to userland via a new core interface file in cgroupfs.

To access this value:
  $ mkdir /sys/fs/cgroup/test
  $ cat /sys/fs/cgroup/test/cgroup.freeze.stat.local
  freeze_time_total 0

Ensure consistent freeze time reads with freeze_seq, a per-cgroup
sequence counter. Writes are serialized using the css_set_lock.

Signed-off-by: Tiffany Yang <ynaffit@google.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 20 ++++++++++++++++++
 include/linux/cgroup-defs.h             | 17 +++++++++++++++
 kernel/cgroup/cgroup.c                  | 28 +++++++++++++++++++++++++
 kernel/cgroup/freezer.c                 | 10 +++++++--
 4 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-=
guide/cgroup-v2.rst
index d9d3cc7df348..e5bc463f8e05 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1027,6 +1027,26 @@ All cgroup core files are prefixed with "cgroup."
 	it's possible to delete a frozen (and empty) cgroup, as well as
 	create new sub-cgroups.
=20
+  cgroup.freeze.stat.local
+	A read-only flat-keyed file which exists in non-root cgroups.
+	The following entry is defined:
+
+	  freeze_time_total
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
+		.. Originally contributed by Michal Koutn=C3=BD <mkoutny@suse.com>
+
+		the duration being measured is the span between a and c.
+
   cgroup.kill
 	A write-only single value file which exists in non-root cgroups.
 	The only allowed value is "1".
diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 6b93a64115fe..a4f9600fc101 100644
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
+	u64 freeze_time_start_ns;
+
+	/*
+	 * Total duration the cgroup has spent freezing.
+	 * Accesses guarded by freeze_seq counter. Writes serialized
+	 * by css_set_lock.
+	 */
+	u64 freeze_time_total_ns;
 };
=20
 struct cgroup {
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 312c6a8b55bb..25e008b40992 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4055,6 +4055,27 @@ static ssize_t cgroup_freeze_write(struct kernfs_ope=
n_file *of,
 	return nbytes;
 }
=20
+static int cgroup_freeze_local_stat_show(struct seq_file *seq, void *v)
+{
+	struct cgroup *cgrp =3D seq_css(seq)->cgroup;
+	unsigned int sequence;
+	u64 freeze_time;
+
+	do {
+		sequence =3D read_seqcount_begin(&cgrp->freezer.freeze_seq);
+		freeze_time =3D cgrp->freezer.freeze_time_total_ns;
+		/* Add in current freezer interval if the task is now frozen */
+		if (test_bit(CGRP_FREEZE, &cgrp->flags))
+			freeze_time +=3D (ktime_get_ns() -
+					cgrp->freezer.freeze_time_start_ns);
+	} while (read_seqcount_retry(&cgrp->freezer.freeze_seq, sequence));
+
+	seq_printf(seq, "freeze_time_total %llu\n",
+		   (unsigned long long) freeze_time / NSEC_PER_USEC);
+
+	return 0;
+}
+
 static void __cgroup_kill(struct cgroup *cgrp)
 {
 	struct css_task_iter it;
@@ -5360,6 +5381,11 @@ static struct cftype cgroup_base_files[] =3D {
 		.seq_show =3D cgroup_freeze_show,
 		.write =3D cgroup_freeze_write,
 	},
+	{
+		.name =3D "cgroup.freeze.stat.local",
+		.flags =3D CFTYPE_NOT_ON_ROOT,
+		.seq_show =3D cgroup_freeze_local_stat_show,
+	},
 	{
 		.name =3D "cgroup.kill",
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
+		cgrp->freezer.freeze_time_start_ns =3D ktime_get_ns();
 		set_bit(CGRP_FROZEN, &cgrp->flags);
 	}
=20
diff --git a/kernel/cgroup/freezer.c b/kernel/cgroup/freezer.c
index bf1690a167dd..bbffad570ff7 100644
--- a/kernel/cgroup/freezer.c
+++ b/kernel/cgroup/freezer.c
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
+		cgrp->freezer.freeze_time_start_ns =3D ktime_get_ns();
+	} else {
 		clear_bit(CGRP_FREEZE, &cgrp->flags);
+		cgrp->freezer.freeze_time_total_ns +=3D (ktime_get_ns() -
+			cgrp->freezer.freeze_time_start_ns);
+	}
+	write_seqcount_end(&cgrp->freezer.freeze_seq);
 	spin_unlock_irq(&css_set_lock);
=20
 	if (freeze)
--=20
2.50.1.565.gc32cd1483b-goog


