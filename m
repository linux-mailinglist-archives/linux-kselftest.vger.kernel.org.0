Return-Path: <linux-kselftest+bounces-7097-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8DB897317
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 16:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9ABF28FE2E
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 14:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F93B14900F;
	Wed,  3 Apr 2024 14:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pN9EiLN+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F93148FE8;
	Wed,  3 Apr 2024 14:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712156069; cv=none; b=pBSFSuygiIdZ6mkJI90qMD674gKm8pS+i33SsNk5PsxNJNaEfXPV34iwI+ljRSb0y7zbJTKq8FKxW6x4sXUXQ/36fJQhzMsN29FiHfzDMDxVtiM8Tf6yWv0+pEiFSxGWEiLEO0ZgE8Gho+/N6/agAgxYK/LqZ4ulH89uQ/e3GmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712156069; c=relaxed/simple;
	bh=FiNmi7tHU8LCxNQpULgn4kNN5KVMjzNkfB/llFUlLW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8cFcaAq25dMkcrnq7SwPRwKWMYJrILGwyw5FKdtlELxzmk1/CFCrruj8hx5yHByCol7xrAXJoq5T6BlKkTA/VjEV13x4fKKidBCqz+mDJJf2g+hs+wKxnNKxGulzcaZUqHRUriC62Z9cavEssElNBkP+FwcHAsdobHMUEeHsiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pN9EiLN+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A03A9371BB;
	Wed,  3 Apr 2024 14:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712156065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L0WbLD5l/t9iedAnyVn1INK22TgmOVbQD9aZe2QlLvI=;
	b=pN9EiLN+i4rF1gJsFqxla+MO3HuIbs0l6XLPl+uROOaIHhrUJiGYZpphGQwbFz6FOvT3ji
	xlm2JJg9V37LdzAd504GUH9LqXvO4+TBoN8mdf8LsgSrzQrQThZ8nUGt+Ba9dW7BEHjPlp
	diTzeU0eOQs7bKO5ijG97x9HyZ/6Dtw=
Authentication-Results: smtp-out1.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8A00F13357;
	Wed,  3 Apr 2024 14:54:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id BeB+IaFtDWZ+aQAAn2gu4w
	(envelope-from <mkoutny@suse.com>); Wed, 03 Apr 2024 14:54:25 +0000
Date: Wed, 3 Apr 2024 16:54:20 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>, 
	Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Frederic Weisbecker <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Alex Shi <alexs@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Barry Song <song.bao.hua@hisilicon.com>
Subject: Re: Re: [PATCH 1/2] cgroup/cpuset: Make cpuset hotplug processing
 synchronous
Message-ID: <mhwbjfm3zsoinm2eozz6d7djtflf6tbpmfzsbbsscv3u5aijtr@p2edxl6voxoa>
References: <20240401145858.2656598-1-longman@redhat.com>
 <20240401145858.2656598-2-longman@redhat.com>
 <kce74bx6aafxfuw5yovaschym4ze4kommfk74eq5totojytest@mdxnfvl2kdol>
 <548efd52-e45f-41fa-a477-bc5112d7b00c@redhat.com>
 <u3naomgv34t5rnc7pmyy4zjppgf36skeo45orss2xnqcvtrcez@m74tsl2ws76f>
 <7e62b37d-6c9c-4e55-a01a-175695475cb5@redhat.com>
 <xhsmhedbmbjz5.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4oauttmks2s2kyvd"
Content-Disposition: inline
In-Reply-To: <xhsmhedbmbjz5.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
X-Spam-Score: -3.72
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.72 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-0.993];
	 SIGNED_PGP(-2.00)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:~];
	 BAYES_HAM(-2.51)[97.79%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.20)[multipart/signed,text/plain];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWELVE(0.00)[22];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Rspamd-Queue-Id: A03A9371BB


--4oauttmks2s2kyvd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 03, 2024 at 04:26:38PM +0200, Valentin Schneider <vschneid@redh=
at.com> wrote:
> Also, I gave Michal's patch a try and it looks like it's introducing a

Thank you.

>   cgroup_threadgroup_rwsem -> cpuset_mutex
> ordering from
>   cgroup_transfer_tasks_locked()
>   `\
>     percpu_down_write(&cgroup_threadgroup_rwsem);
>     cgroup_migrate()
>     `\
>       cgroup_migrate_execute()
>       `\
>         ss->can_attach() // cpuset_can_attach()
>         `\
>           mutex_lock(&cpuset_mutex);
>=20
> which is invalid, see below.

_This_ should be the right order (cpuset_mutex inside
cgroup_threadgroup_rwsem), at least in my mental model. Thus I missed
that cpuset_mutex must have been taken somewhere higher up in the
hotplug code (CPU 0 in the lockdep dump, I can't easily see where from)
:-/.

Michal

--4oauttmks2s2kyvd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZg1tmgAKCRAGvrMr/1gc
jkuBAQCOU5ydo9y0TCnjqjAp/O4I1OLjgDDV/yffUbpaHCtEQwD+JkXKjW2H8u/w
FTxiJwyMy2sI6p0otQdxSBa7Bpu0Vgs=
=vBqH
-----END PGP SIGNATURE-----

--4oauttmks2s2kyvd--

