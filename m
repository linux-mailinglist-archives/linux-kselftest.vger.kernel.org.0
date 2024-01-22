Return-Path: <linux-kselftest+bounces-3321-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E97D836914
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 16:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43C8A1C23661
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 15:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C1C74E2A;
	Mon, 22 Jan 2024 15:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Vt73Fi4M";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Vt73Fi4M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4374B5D2;
	Mon, 22 Jan 2024 15:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936085; cv=none; b=qKLlkOrV2zLkXD5irrhiqLiEKNDnSwXcaMo5273jijxCRPa3eRmmu5RJ/H6vsJM29Dheq4lqb+5I5HgFTgKjXtQpkP04/vdJst+H2p1rb9LY9F68bjCQBsd2UbJH01CFdI60uE0QTmzpkWOYcH+tCeswHWz0qbageP5gHJRKTOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936085; c=relaxed/simple;
	bh=4fYcXhWiSJkRIg6Ip7urrvrUSXMdsY9G0tmUF8/+f4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NNfKb719+3M+hKu6+L5EljWn8dU0KL357DlyS7TqpQFZRwGZf8IQ1CB8RRk6uwHI8XUYxF/zZkQXLuU4AtD5cQ48uI1b1r6HKOcFggi4beyeKVLBjXecSFoadx7tActgTrcODiQriJ9DW1b5S5ZsbJLNqMf1eDNxpx45FI0ZzEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Vt73Fi4M; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Vt73Fi4M; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 065781FC07;
	Mon, 22 Jan 2024 15:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705936080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4fYcXhWiSJkRIg6Ip7urrvrUSXMdsY9G0tmUF8/+f4s=;
	b=Vt73Fi4MXs9fhjCF+W13yZlgGJsMKcIyp7vNlFUQs8CZf06PhXzd4sYXvo6iQLN3kdss75
	yxXbdsT6u9j7YX1kBBdoamwNEMzhqOu9EoH0Z8OQg6fr+YxHO29NYuosqo/k3E9wic4q4b
	ARFTkK7bq0IcHQE0Ka91kbR3qrm+tfI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705936080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4fYcXhWiSJkRIg6Ip7urrvrUSXMdsY9G0tmUF8/+f4s=;
	b=Vt73Fi4MXs9fhjCF+W13yZlgGJsMKcIyp7vNlFUQs8CZf06PhXzd4sYXvo6iQLN3kdss75
	yxXbdsT6u9j7YX1kBBdoamwNEMzhqOu9EoH0Z8OQg6fr+YxHO29NYuosqo/k3E9wic4q4b
	ARFTkK7bq0IcHQE0Ka91kbR3qrm+tfI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ACD86136A4;
	Mon, 22 Jan 2024 15:07:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id s81AKM6ErmW9YgAAD6G6ig
	(envelope-from <mkoutny@suse.com>); Mon, 22 Jan 2024 15:07:58 +0000
Date: Mon, 22 Jan 2024 16:07:57 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Neeraj Upadhyay <quic_neeraju@quicinc.com>, Joel Fernandes <joel@joelfernandes.org>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Mrunal Patel <mpatel@redhat.com>, 
	Ryan Phillips <rphillips@redhat.com>, Brent Rowsell <browsell@redhat.com>, 
	Peter Hunt <pehunt@redhat.com>, Cestmir Kalina <ckalina@redhat.com>, 
	Nicolas Saenz Julienne <nsaenz@kernel.org>, Alex Gladkov <agladkov@redhat.com>, 
	Marcelo Tosatti <mtosatti@redhat.com>, Phil Auld <pauld@redhat.com>, 
	Paul Gortmaker <paul.gortmaker@windriver.com>, Daniel Bristot de Oliveira <bristot@kernel.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Costa Shulyupin <cshulyup@redhat.com>
Subject: Re: [RFC PATCH 0/8] cgroup/cpuset: Support RCU_NOCB on isolated
 partitions
Message-ID: <bql5g22ovp2dm33llmq5oxpmuuhysvdyppj7j6xvrm643xuniv@pkqrwvmqzneh>
References: <20240117163511.88173-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="btekknw55nvxl4ky"
Content-Disposition: inline
In-Reply-To: <20240117163511.88173-1-longman@redhat.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.21 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.01)[51.13%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.20)[multipart/signed,text/plain];
	 R_RATELIMIT(0.00)[to_ip_from(RL6j1h7wxugqfdyj8pnx7tibp9)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWELVE(0.00)[36];
	 SIGNED_PGP(-2.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:~];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[kernel.org,bytedance.com,cmpxchg.org,lwn.net,quicinc.com,joelfernandes.org,joshtriplett.org,gmail.com,goodmis.org,efficios.com,stgolabs.net,vger.kernel.org,redhat.com,windriver.com,infradead.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.21


--btekknw55nvxl4ky
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Waiman.

On Wed, Jan 17, 2024 at 11:35:03AM -0500, Waiman Long <longman@redhat.com> wrote:
> This patch series is based on the RFC patch from Frederic [1]. Instead
> of offering RCU_NOCB as a separate option, it is now lumped into a
> root-only cpuset.cpus.isolation_full flag that will enable all the
> additional CPU isolation capabilities available for isolated partitions
> if set. RCU_NOCB is just the first one to this party. Additional dynamic
> CPU isolation capabilities will be added in the future.

IIUC this is similar to what I suggested back in the day and you didn't
consider it [1]. Do I read this right that you've changed your mind?

(It's fine if you did, I'm only asking to follow the heading of cpuset
controller.)

Thanks,
Michal

[1] https://lore.kernel.org/r/58c87587-417b-1498-185f-1db6bb612c82@redhat.com/

--btekknw55nvxl4ky
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZa6EywAKCRAGvrMr/1gc
jnziAQDeS/BPCM9qEVgM7AdJJ1sdTzQsMQ5YiQ3EnDS8nw0THQD+IlhGeiHOP8eY
Fif9SqmbUs3GzGds3uUPWNBUWQDsjws=
=EAx6
-----END PGP SIGNATURE-----

--btekknw55nvxl4ky--

