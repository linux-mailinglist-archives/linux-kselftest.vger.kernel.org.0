Return-Path: <linux-kselftest+bounces-6996-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FC6895A7F
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 19:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F1881F23948
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 17:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB8715A48D;
	Tue,  2 Apr 2024 17:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HyDNeoUo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E4015990F;
	Tue,  2 Apr 2024 17:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712078202; cv=none; b=KBe1BNEs+p8Utt7UMOp8o9wKunXLsxXXxMrtGtd2FNt1aIKwA6f4exP1Qv4QYg6/ZlpVQuMabfVUeqOBEgcwGvTld5ImhVXtMntLTODt75gEObO7YagF/ILl8UUcRnCAopMtNaeMZcOmi375UiyKXu6oauNh5x/f5IHIaTSFF4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712078202; c=relaxed/simple;
	bh=pP519wusPUAXRys+Pm1fP6WiHUMTu+p8h8uiy+wJCy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhN2ioAM1ciUs4CDbPC5zygsxd3URYjQXuGoz17kk8MorneA35V05UY/BIZ0ItY+fpZQj54EL2Ax2oLat2m0BFIgLLiWIlwHrlyU8pZauhRg9Dp8qFU5nEd2lv9Cdc+G1L2DMVuPX1L9A2fE6KFjj7IE8IRY4zvlK9pljnRBMu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HyDNeoUo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8637B34934;
	Tue,  2 Apr 2024 17:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712078198; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pP519wusPUAXRys+Pm1fP6WiHUMTu+p8h8uiy+wJCy0=;
	b=HyDNeoUoZJkyHWwJ8XCspPVKQE0grsOAe6fIzOJfL6spCvd8yGbYzAefLUZLCRHZcjQuWZ
	P21owtoIlNmvKSzoFThdyX2PRKtb7ph/zuDKnK7aTsZtPYc5WbgwGy/kozkVocQijFMnGr
	KxxnZHv5eGwVoSboBVG4imEzEAx39Mk=
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7240F13357;
	Tue,  2 Apr 2024 17:16:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id vLDAG3Y9DGZiIgAAn2gu4w
	(envelope-from <mkoutny@suse.com>); Tue, 02 Apr 2024 17:16:38 +0000
Date: Tue, 2 Apr 2024 19:16:29 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Djalal Harouni <tixxdz@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next 0/3] bpf: freeze a task cgroup from bpf
Message-ID: <ex2uipr54lb2odxwzwp22ycvlwplsy4mm3shx26hczo3mjtkvz@uuzyk6535prw>
References: <20240327-ccb56fc7a6e80136db80876c@djalal>
 <20240327225334.58474-1-tixxdz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jy46jtmbnpyw2njk"
Content-Disposition: inline
In-Reply-To: <20240327225334.58474-1-tixxdz@gmail.com>
X-Spam-Score: -2.01
X-Spamd-Result: default: False [-2.01 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.62)[82.04%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.20)[multipart/signed,text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.19)[-0.971];
	 RCPT_COUNT_TWELVE(0.00)[22];
	 SIGNED_PGP(-2.00)[];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:~];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[kernel.org,bytedance.com,cmpxchg.org,iogearbox.net,linux.dev,gmail.com,google.com,fb.com,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: 
X-Spam-Flag: NO


--jy46jtmbnpyw2njk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello.

On Wed, Mar 27, 2024 at 11:53:22PM +0100, Djalal Harouni <tixxdz@gmail.com> wrote:
> ...
> For some cases we want to freeze the cgroup of a task based on some
> signals, doing so from bpf is better than user space which could be
> too late.

Notice that freezer itself is not immediate -- tasks are frozen as if a
signal (kill(2)) was delivered to them (i.e. returning to userspace).

What kind of signals (also kill?) are you talking about for
illustration?

> Planned users of this feature are: tetragon and systemd when freezing
> a cgroup hierarchy that could be a K8s pod, container, system service
> or a user session.

It sounds like the signals are related to a particular process. If so
what is it good for to freeze unrelated processes in the same cgroup?

I think those answers better clarify why this is needed.


As for the generalization to any cgroup attribute (or kernfs). Can this
be compared with sysctls -- I see there are helpers to intercept user
writes but no helpers to affect sysctl values without an outer writer.
What would justify different approaches between kernfs attributes and
sysctls (direct writes vs modified writes)?


Thanks,
Michal

--jy46jtmbnpyw2njk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZgw9awAKCRAGvrMr/1gc
jkx3AP9q4yObx2ZVhnJrJtyuNXurHxN0CyA34JgyPMSJk2fz8wD/eQvPgsUzvuGS
lms51KfenKpEwlwmmEfvlZSNXVAU1Qw=
=rjUz
-----END PGP SIGNATURE-----

--jy46jtmbnpyw2njk--

