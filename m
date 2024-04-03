Return-Path: <linux-kselftest+bounces-7098-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1514689732C
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 16:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4711B1C27599
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 14:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52151149C42;
	Wed,  3 Apr 2024 14:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UWe6UtNz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7806C13A41F;
	Wed,  3 Apr 2024 14:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712156225; cv=none; b=bYkBh0CXQ2ZcP/MdknIljMf6Tjkp5toTJnV1/Z82/4PTiVl7qjw7GAX/qZPH4pO6UrT2nip0n/lAXEetgcWlRJTDlAuO+PEMdap46cNH+26eHLNcDmGPWgIqM5O3QxL0oQAtaCytOVcP1icmV4JiAQ5njwidvSENdcldPSqV3sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712156225; c=relaxed/simple;
	bh=eZVmBB1d4Df5D2F0Ce5Nd9fY/AAZw/o+Je5pGJeTmvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QA3Z+4V0D/IwaOhZjLOoDta7SpdsxuWqmD8t6jeBHi09v3Yeb2DbhSJYn9Q5rVfS4+QghOO1yAhQk2egXu7KR1D0LB+RCCmTb6fujU9fuAMk15gdo9ON7J6DZGyJLSVOKbJLjcPwz3SQVpDZGhfZGtLeTYCAHt3kQKgR2v0hgzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UWe6UtNz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A43135CDC4;
	Wed,  3 Apr 2024 14:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712156221; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eZVmBB1d4Df5D2F0Ce5Nd9fY/AAZw/o+Je5pGJeTmvQ=;
	b=UWe6UtNzKToX2b2B2yqhkfbY/y8wLxleX9wXq9Bn2GIkXCuDN9OriucLIt8uIXIB2kG4Oo
	m68swMT8b3cv1YODbkDNHlPWFdotkpgir9Sgu/CYlDd0suCoyYWfT9co9mCdfBU1ErfFZ7
	E2vZ+UOYkYSN6fp0X9WWzPZqZ1iv5kk=
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E11F13357;
	Wed,  3 Apr 2024 14:57:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id j0KEIj1uDWZPagAAn2gu4w
	(envelope-from <mkoutny@suse.com>); Wed, 03 Apr 2024 14:57:01 +0000
Date: Wed, 3 Apr 2024 16:56:52 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Waiman Long <longman@redhat.com>
Cc: Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>, 
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
Message-ID: <tm5kvzgn2g5yv63zoyqvd2bdrgl7l3ytffu4cq4ybxyq5irp76@hpmq3zfbtmlp>
References: <20240401145858.2656598-1-longman@redhat.com>
 <20240401145858.2656598-2-longman@redhat.com>
 <kce74bx6aafxfuw5yovaschym4ze4kommfk74eq5totojytest@mdxnfvl2kdol>
 <548efd52-e45f-41fa-a477-bc5112d7b00c@redhat.com>
 <u3naomgv34t5rnc7pmyy4zjppgf36skeo45orss2xnqcvtrcez@m74tsl2ws76f>
 <7e62b37d-6c9c-4e55-a01a-175695475cb5@redhat.com>
 <xhsmhedbmbjz5.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <620d1b70-cfbc-4b76-ad04-b3be559afd56@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s5g4gqxizdmthray"
Content-Disposition: inline
In-Reply-To: <620d1b70-cfbc-4b76-ad04-b3be559afd56@redhat.com>
X-Spamd-Result: default: False [-4.89 / 50.00];
	BAYES_HAM(-2.99)[99.97%];
	SIGNED_PGP(-2.00)[];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-0.985];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:rdns,imap2.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.89
X-Spam-Level: 
X-Spam-Flag: NO


--s5g4gqxizdmthray
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 03, 2024 at 10:47:33AM -0400, Waiman Long <longman@redhat.com> wrote:
> should be rare these days as it will only apply in the case of cgroup
> v1 under certain condtion,

Could the migration be simply omitted it those special cases?

(Tasks remain in cpusets with empty cpusets -- that already happens in
with the current patch before workqueue is dispatched.)

Michal

--s5g4gqxizdmthray
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZg1uMgAKCRAGvrMr/1gc
juxsAP9LdPIENmgJ+lo1a52HXy+sDng3vYcaC8VapHG5CyOA7AEAlOwpne+LzkiO
IIyeIE+x8ZyV9QlL/DM6cnabIMR+IgI=
=d6JV
-----END PGP SIGNATURE-----

--s5g4gqxizdmthray--

