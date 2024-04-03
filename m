Return-Path: <linux-kselftest+bounces-7073-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56792896E99
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 14:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8EEB1F23827
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 12:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF0E143892;
	Wed,  3 Apr 2024 12:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nrmmy/zs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075E9134CCA;
	Wed,  3 Apr 2024 12:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712145754; cv=none; b=POW+VnB4HhS3daBV13fxrVOd2OsUcboo8lJW2IxHn+RIcyg8dFFcp+iqBBIJDhqchqrMq7tF/J+JzzZMKh1WUGReT/KICoQz/NOve5up/ZQV777XVD/bA7RTqog5vJMm3gJAllXIOA4qcBQqSn+dyCVD46S4tZvCxbR/ovFi8ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712145754; c=relaxed/simple;
	bh=MIjlzCP1Z9ehRzIIXpDe3raQA7sAPJ0M61/wEYcg7/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pjj1obuyqROJJIec3Oj2hT8xVAMER9ThYa5P4NkAzwC8++P6jVYixOqzJLqUxo7Cvben3xDi1nx4ttE72JhlTSFEVnXCyNC8XFP/OzmpMsyvivq11B2LHsFmbNVuVthDzfYoYBPO0EsfR6xGtmnxaic3sDQZW3yIHW1dtXy9R4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nrmmy/zs; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4A955352D4;
	Wed,  3 Apr 2024 12:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712145751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t2Hnk77vjkotvAO37I/a2KOyOgPIBZ2Mq+MuEdRqQKg=;
	b=nrmmy/zsneWTeL++5/D9B2Y0Ll8wNr1h4y1OcBKbzxxAa3w+x6B5a3WrzWOY7ihqsnRvnj
	8QXs7vq++BB08smCjZwoqVuLc9qWMJSmeLYkMm4KloSdvgTsNU+wCUTk4xgmdL9P9tBXHJ
	E93kGqd5umuaEbHIHpQSg3BQxcqavNM=
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 329991331E;
	Wed,  3 Apr 2024 12:02:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id zqkpDFdFDWbALQAAn2gu4w
	(envelope-from <mkoutny@suse.com>); Wed, 03 Apr 2024 12:02:31 +0000
Date: Wed, 3 Apr 2024 14:02:22 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Valentin Schneider <vschneid@redhat.com>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Alex Shi <alexs@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Barry Song <song.bao.hua@hisilicon.com>
Subject: Re: Re: [PATCH 1/2] cgroup/cpuset: Make cpuset hotplug processing
 synchronous
Message-ID: <u3naomgv34t5rnc7pmyy4zjppgf36skeo45orss2xnqcvtrcez@m74tsl2ws76f>
References: <20240401145858.2656598-1-longman@redhat.com>
 <20240401145858.2656598-2-longman@redhat.com>
 <kce74bx6aafxfuw5yovaschym4ze4kommfk74eq5totojytest@mdxnfvl2kdol>
 <548efd52-e45f-41fa-a477-bc5112d7b00c@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hasfuqktmb566gtt"
Content-Disposition: inline
In-Reply-To: <548efd52-e45f-41fa-a477-bc5112d7b00c@redhat.com>
X-Spam-Score: -5.90
X-Spamd-Result: default: False [-5.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.20)[multipart/signed,text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-0.992];
	 RCPT_COUNT_TWELVE(0.00)[22];
	 SIGNED_PGP(-2.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:~];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO


--hasfuqktmb566gtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2024 at 11:30:11AM -0400, Waiman Long <longman@redhat.com> =
wrote:
> Yes, there is a potential that a cpus_read_lock() may be called leading to
> deadlock. So unless we reverse the current cgroup_mutex --> cpu_hotplug_l=
ock
> ordering, it is not safe to call cgroup_transfer_tasks() directly.

I see that cgroup_transfer_tasks() has the only user -- cpuset. What
about bending it for the specific use like:

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 34aaf0e87def..64deb7212c5c 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -109,7 +109,7 @@ struct cgroup *cgroup_get_from_fd(int fd);
 struct cgroup *cgroup_v1v2_get_from_fd(int fd);
=20
 int cgroup_attach_task_all(struct task_struct *from, struct task_struct *);
-int cgroup_transfer_tasks(struct cgroup *to, struct cgroup *from);
+int cgroup_transfer_tasks_locked(struct cgroup *to, struct cgroup *from);
=20
 int cgroup_add_dfl_cftypes(struct cgroup_subsys *ss, struct cftype *cfts);
 int cgroup_add_legacy_cftypes(struct cgroup_subsys *ss, struct cftype *cft=
s);
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 520a11cb12f4..f97025858c7a 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -91,7 +91,8 @@ EXPORT_SYMBOL_GPL(cgroup_attach_task_all);
  *
  * Return: %0 on success or a negative errno code on failure
  */
-int cgroup_transfer_tasks(struct cgroup *to, struct cgroup *from)
+int cgroup_transfer_tasks_locked(struct cgroup *to, struct cgroup *from)
 {
 	DEFINE_CGROUP_MGCTX(mgctx);
 	struct cgrp_cset_link *link;
@@ -106,9 +106,11 @@ int cgroup_transfer_tasks(struct cgroup *to, struct cg=
roup *from)
 	if (ret)
 		return ret;
=20
-	cgroup_lock();
-
-	cgroup_attach_lock(true);
+	/* The locking rules serve specific purpose of v1 cpuset hotplug
+	 * migration, see hotplug_update_tasks_legacy() and
+	 * cgroup_attach_lock() */
+	lockdep_assert_held(&cgroup_mutex);
+	lockdep_assert_cpus_held();
+	percpu_down_write(&cgroup_threadgroup_rwsem);
=20
 	/* all tasks in @from are being moved, all csets are source */
 	spin_lock_irq(&css_set_lock);
@@ -144,8 +146,7 @@ int cgroup_transfer_tasks(struct cgroup *to, struct cgr=
oup *from)
 	} while (task && !ret);
 out_err:
 	cgroup_migrate_finish(&mgctx);
-	cgroup_attach_unlock(true);
-	cgroup_unlock();
+	percpu_up_write(&cgroup_threadgroup_rwsem);
 	return ret;
 }
=20
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 13d27b17c889..94fb8b26f038 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -4331,7 +4331,7 @@ static void remove_tasks_in_empty_cpuset(struct cpuse=
t *cs)
 			nodes_empty(parent->mems_allowed))
 		parent =3D parent_cs(parent);
=20
-	if (cgroup_transfer_tasks(parent->css.cgroup, cs->css.cgroup)) {
+	if (cgroup_transfer_tasks_locked(parent->css.cgroup, cs->css.cgroup)) {
 		pr_err("cpuset: failed to transfer tasks out of empty cpuset ");
 		pr_cont_cgroup_name(cs->css.cgroup);
 		pr_cont("\n");
@@ -4376,21 +4376,9 @@ hotplug_update_tasks_legacy(struct cpuset *cs,
=20
 	/*
 	 * Move tasks to the nearest ancestor with execution resources,
-	 * This is full cgroup operation which will also call back into
-	 * cpuset. Execute it asynchronously using workqueue.
 	 */
-	if (is_empty && css_tryget_online(&cs->css)) {
-		struct cpuset_remove_tasks_struct *s;
-
-		s =3D kzalloc(sizeof(*s), GFP_KERNEL);
-		if (WARN_ON_ONCE(!s)) {
-			css_put(&cs->css);
-			return;
-		}
-
-		s->cs =3D cs;
-		INIT_WORK(&s->work, cpuset_migrate_tasks_workfn);
-		schedule_work(&s->work);
+	if (is_empty)
+		remove_tasks_in_empty_cpuset(cs);
 	}
 }
=20

--hasfuqktmb566gtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZg1FSwAKCRAGvrMr/1gc
jrAhAP9EAPzvP9ut5Lv9vhE3zzjDfzz7OiWPnQ20fgbULZsGqQEA5zpBHRFrppA/
1N8N9HiJAV3pbeOdaHR/ZDy7Cg6Qjwg=
=GFHO
-----END PGP SIGNATURE-----

--hasfuqktmb566gtt--

