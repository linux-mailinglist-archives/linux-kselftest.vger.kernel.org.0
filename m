Return-Path: <linux-kselftest+bounces-7492-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C76B89DF47
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 17:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF6091C20C04
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 15:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4DE1369B9;
	Tue,  9 Apr 2024 15:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pwqSGuNn";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pwqSGuNn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F07A136E00;
	Tue,  9 Apr 2024 15:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712676761; cv=none; b=bhiecqOXWfwM1V+S9+2PqcuMFbnwydxGrk7Tzorc4dK2hzzPIK8XBkYmMQc4SEIgCf5pBCfH6KeLyiyEN8tjtAkSmI/ROZ37JSL6/gG79wsFlB3tXLyvePvVv36RMSCg65+NsiyRIDHI2ne9F5Sv1KgWE2ahFDA61QlWgthVItk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712676761; c=relaxed/simple;
	bh=gTkZ5i5KTn1jImE/aha1iK+seMvlYRhPgsM7BgtGxGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UAXfJDWTbbYHRLQd4XiFcIzl+NM5/RGEtegER4wYX/dDEbU7M2SNbRFy5ZD66K+70zmZ23/hAgxd45RlBe4b/kO1hICtZmi8F+dLLphJJ0UYvTH4siYrYiJMAeVl/7F0mxCxF5s29NMqGXB1bzjZwlZB+LlaE23cU73dpRH6rzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pwqSGuNn; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pwqSGuNn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 17EE820A9D;
	Tue,  9 Apr 2024 15:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712676755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=evRi6cjBqVNKW2baFdKQ85UzXHTSdvORxHiKqOKSb20=;
	b=pwqSGuNn2PENPCLa1UrzlKUI91R99iIaK7yIrrVbXbqSPOnqdD+tadkowqBcfWh2jDJrFG
	+SjuRzXLnOIUr2cdM67wIUr9zbqkEWD4z64I9ci0ReGihH62LTwPwqlMhKpjesfrXir3UQ
	Q7t03zfssRaQm+k850evie3N909De0c=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=pwqSGuNn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712676755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=evRi6cjBqVNKW2baFdKQ85UzXHTSdvORxHiKqOKSb20=;
	b=pwqSGuNn2PENPCLa1UrzlKUI91R99iIaK7yIrrVbXbqSPOnqdD+tadkowqBcfWh2jDJrFG
	+SjuRzXLnOIUr2cdM67wIUr9zbqkEWD4z64I9ci0ReGihH62LTwPwqlMhKpjesfrXir3UQ
	Q7t03zfssRaQm+k850evie3N909De0c=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E880E1332F;
	Tue,  9 Apr 2024 15:32:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id h4N7OJJfFWaYGwAAn2gu4w
	(envelope-from <mkoutny@suse.com>); Tue, 09 Apr 2024 15:32:34 +0000
Date: Tue, 9 Apr 2024 17:32:33 +0200
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
Subject: Re: Re: [RFC PATCH bpf-next 0/3] bpf: freeze a task cgroup from bpf
Message-ID: <eosbqsdycwdaezg6huqwpjvttxdxgbu6ptjmpxesy6i2rl276i@72w2orzveyes>
References: <20240327-ccb56fc7a6e80136db80876c@djalal>
 <20240327225334.58474-1-tixxdz@gmail.com>
 <ex2uipr54lb2odxwzwp22ycvlwplsy4mm3shx26hczo3mjtkvz@uuzyk6535prw>
 <705d7180-aced-46ba-80a6-84ac4e2b96b9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ur57wvgvflsnrnty"
Content-Disposition: inline
In-Reply-To: <705d7180-aced-46ba-80a6-84ac4e2b96b9@gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.61 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,bytedance.com,cmpxchg.org,iogearbox.net,linux.dev,gmail.com,google.com,fb.com,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 17EE820A9D
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.61


--ur57wvgvflsnrnty
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi.

On Tue, Apr 02, 2024 at 07:20:45PM +0100, Djalal Harouni <tixxdz@gmail.com> wrote:
> Thanks yes, I would expect freeze to behave like signal, and if one
> wants to block immediately there is the LSM override return. The
> selftest attached tries to do exactly that.

Are you refering to this part:

	int BPF_PROG(lsm_freeze_cgroup, int cmd, union bpf_attr *attr, unsigned int size)
		...
		ret = bpf_task_freeze_cgroup(task, 1);
		if (!ret) {
			ret = -EPERM;
			/* reset for next call */
?


> Could be security signals, reading sensitive files or related to any
> operation management, for X reasons this user session should be freezed
> or killed.

What can be done with a frozen cgroup after anything of that happens?
Anything besides killing anyway?

Killing of an offending process could be caught by its supervisor (like
container runtime or systemd) and propagated accordingly to the whole
cgroup.

> The kill is an effective defense against fork-bombs as an example.

There are several ways how to prevent fork-bombs in kernel already, it
looks like a contrived example.

> Today some container/pod operations are performed at bpf level, having
> the freeze and kill available is straightforward to perform this.

It seems to me like an extra step when the same operation can be done from
(the managing) userspace already.

> For generalizing this, haven't thought about it that much. First use
> case is to try to get freeze and possibly kill support, and use a common
> interface as requested.

BTW, I notice that there is bpf_sys_bpf() helper that allows calling an
arbitrary syscall. Wouldn't that be sufficient for everything?

(Based on how I still understand the problem: either you must respond
immediately and then the direct return from LSM is appropriate or timing
is not sensitive but you want act on whole cgroup.)

Thanks,
Michal

--ur57wvgvflsnrnty
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZhVfjwAKCRAGvrMr/1gc
jmVSAP4gnoRPzcuJjgOFfGrNmt82AS07TT6+tvtaPHXyLoEMYwEAs1rsSXY7Zfk5
YFlpQWdguwO5nJDKXK8YvYS7+wcTlQM=
=0Hv1
-----END PGP SIGNATURE-----

--ur57wvgvflsnrnty--

