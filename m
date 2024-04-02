Return-Path: <linux-kselftest+bounces-6986-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 794E1895664
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 16:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33B16284AF7
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 14:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B81286656;
	Tue,  2 Apr 2024 14:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Y2B+7rff"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6FB86259;
	Tue,  2 Apr 2024 14:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712067230; cv=none; b=db0Plv7fct2Jz2osOdOnziEY7Rg4j0svbRpmDT1N4KXhhs+Chu4sCO1pIOAM/nJx6/4Jhv/9aFXybJOPc00LaoT6FEWaYzccnfC0kTOHiIiHrM4s29+D3JT6xhe+ISQcX4wj6UdNIBXcflShbHOUEqeRnVbIpM5E04pJzCY3gpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712067230; c=relaxed/simple;
	bh=36P1uOtujsizwW2usw7mfkPhuqvi59s5Nt+PgGGqx0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LcEW63i967IIA9Khq0BAlyAeMZNST+wDFXPISvneQIwhUhgAYWF93Jq01L9LldYNIiMcyCoMl2pTRbzPcrY9sNmBXRJLiGjyRdfgjwjLTtPaEBR9MzeXFiLAlIj3L5/WMNo9pEJoaTzNSfMQlP/LhOVoQIofUHIcFpg1gN8z5qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Y2B+7rff; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DDFFA5BE2C;
	Tue,  2 Apr 2024 14:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712067226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KA7AVUof0UCDazD9kIzVR9xQgcPzIYUy3fkudyiEwWk=;
	b=Y2B+7rffqbEm69uPQnaA7mdz2w0eK/38jkGPgDQNkMcQKA374UbUoeFc45NFeiLZyw3USB
	LOnnWKV3sfhN0kfcSC946P9eJTPVNi6U3gYFCnc5aixSwPz2vhlDAxN1/XGc10nBRVDsys
	F6ICdlUQn+ZzhTJsur2HWshIBvDb604=
Authentication-Results: smtp-out2.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C9C1A13A90;
	Tue,  2 Apr 2024 14:13:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id GiIRMZoSDGboYwAAn2gu4w
	(envelope-from <mkoutny@suse.com>); Tue, 02 Apr 2024 14:13:46 +0000
Date: Tue, 2 Apr 2024 16:13:41 +0200
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
Subject: Re: [PATCH 1/2] cgroup/cpuset: Make cpuset hotplug processing
 synchronous
Message-ID: <kce74bx6aafxfuw5yovaschym4ze4kommfk74eq5totojytest@mdxnfvl2kdol>
References: <20240401145858.2656598-1-longman@redhat.com>
 <20240401145858.2656598-2-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m3jtt4lb3pupq4nw"
Content-Disposition: inline
In-Reply-To: <20240401145858.2656598-2-longman@redhat.com>
X-Spam-Score: -1.19
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.19 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-0.96)[-0.965];
	 MIME_GOOD(-0.20)[multipart/signed,text/plain];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 RCPT_COUNT_TWELVE(0.00)[22];
	 SIGNED_PGP(-2.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:~];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.52)[80.23%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spam-Level: 
X-Rspamd-Queue-Id: DDFFA5BE2C


--m3jtt4lb3pupq4nw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Waiman.

(I have no opinion on the overall locking reworks, only the bits about
v1 migrations caught my attention.)

On Mon, Apr 01, 2024 at 10:58:57AM -0400, Waiman Long <longman@redhat.com> wrote:
...
> @@ -4383,12 +4377,20 @@ hotplug_update_tasks_legacy(struct cpuset *cs,
>  	/*
>  	 * Move tasks to the nearest ancestor with execution resources,
>  	 * This is full cgroup operation which will also call back into
> -	 * cpuset. Should be done outside any lock.
> +	 * cpuset. Execute it asynchronously using workqueue.

                   ...to avoid deadlock on cpus_read_lock

Is this the reason?
Also, what happens with the tasks in the window till the migration
happens?
Is it handled gracefully that their cpu is gone?


> -	if (is_empty) {
> -		mutex_unlock(&cpuset_mutex);
> -		remove_tasks_in_empty_cpuset(cs);
> -		mutex_lock(&cpuset_mutex);
> +	if (is_empty && css_tryget_online(&cs->css)) {
> +		struct cpuset_remove_tasks_struct *s;
> +
> +		s = kzalloc(sizeof(*s), GFP_KERNEL);

Is there a benefit of having a work for each cpuset?
Instead of traversing whole top_cpuset once in the async work.


Thanks,
Michal


--m3jtt4lb3pupq4nw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZgwSkwAKCRAGvrMr/1gc
jku7AP4wunT3qTbn0gNfnNlgS+aZURi7eScVHpxboPBoGEeorgEA0EEpGH79hJUs
C5xcOZLm/5ZRgE5MXKIx0kiWKBGt9QY=
=8lGP
-----END PGP SIGNATURE-----

--m3jtt4lb3pupq4nw--

