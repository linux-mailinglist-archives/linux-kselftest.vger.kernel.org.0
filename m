Return-Path: <linux-kselftest+bounces-7683-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CB58A0B20
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 10:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B98131C21FC5
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 08:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8654613FD85;
	Thu, 11 Apr 2024 08:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mvpUJWKX";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mvpUJWKX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE5913E023;
	Thu, 11 Apr 2024 08:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712823964; cv=none; b=cqWzM4Rkv08eEqw5Dy4L10D8m9CyGlOeeXCa1JmL0fZ92+3unT1rIwanH9kagByTyVWzAi5yWqgQKdZ9GIBURrC7kR6Z06G+3WYom5XEYobhpZpDV+0v4uKDRmLCebopjXAihscL8RS6b6L/twLZyle6zPDAd2+w3KQDP2UHViI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712823964; c=relaxed/simple;
	bh=kBsrwI1nrQ+DqBTdvGD+kXeHsKAdfRqKLaUqW7+FO2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udIDhic2/HIv0WV4FwTvHU42xx8S1dxnM5wKhCWjPVFYKws+Vgrkvhu5fqSIOCtBgobnEfJbk6NKVcw6rLBljzML6hs105glBJtI+v12cv+JZTpjcrP+1xhzxH8mZtXc/3kxrrcJjHB7qHx8NR7xhhBJqrlLBamqBbO0PJs6o0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mvpUJWKX; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mvpUJWKX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2923620B61;
	Thu, 11 Apr 2024 08:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712823960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kBsrwI1nrQ+DqBTdvGD+kXeHsKAdfRqKLaUqW7+FO2Y=;
	b=mvpUJWKX5SM0fRVFK6fwiJKVgTAfKbkGws5cOhVE4iW0qy99hKEhZ5mggNEjbt+vV1U2j4
	FxSCaEz4rQw9k6Qupjkv445G1yXs+cKVFg8v8B0Z1S7fdII2CZ9W9XDzHxupS4n+zI4gKd
	aBguafXJPmMQWCA31rknna4jX564ehU=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=mvpUJWKX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712823960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kBsrwI1nrQ+DqBTdvGD+kXeHsKAdfRqKLaUqW7+FO2Y=;
	b=mvpUJWKX5SM0fRVFK6fwiJKVgTAfKbkGws5cOhVE4iW0qy99hKEhZ5mggNEjbt+vV1U2j4
	FxSCaEz4rQw9k6Qupjkv445G1yXs+cKVFg8v8B0Z1S7fdII2CZ9W9XDzHxupS4n+zI4gKd
	aBguafXJPmMQWCA31rknna4jX564ehU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E73A13685;
	Thu, 11 Apr 2024 08:26:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GCRiA5ieF2Y/RwAAD6G6ig
	(envelope-from <mkoutny@suse.com>); Thu, 11 Apr 2024 08:26:00 +0000
Date: Thu, 11 Apr 2024 10:25:54 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Djalal Harouni <tixxdz@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: Re: [RFC PATCH bpf-next 0/3] bpf: freeze a task cgroup from bpf
Message-ID: <mizwxyeznmb3ezlkwcjjc6fwwjseby6f5o2fb7ppunxtjdnitk@k5bxjxhfy6kv>
References: <20240327-ccb56fc7a6e80136db80876c@djalal>
 <20240327225334.58474-1-tixxdz@gmail.com>
 <ex2uipr54lb2odxwzwp22ycvlwplsy4mm3shx26hczo3mjtkvz@uuzyk6535prw>
 <705d7180-aced-46ba-80a6-84ac4e2b96b9@gmail.com>
 <eosbqsdycwdaezg6huqwpjvttxdxgbu6ptjmpxesy6i2rl276i@72w2orzveyes>
 <31904afe-1d8a-4169-a3bd-d6d1c86cac5f@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qnegwa3hbjphuauz"
Content-Disposition: inline
In-Reply-To: <31904afe-1d8a-4169-a3bd-d6d1c86cac5f@linux.dev>
X-Spam-Flag: NO
X-Spam-Score: -5.45
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 2923620B61
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.45 / 50.00];
	BAYES_HAM(-2.84)[99.31%];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	DWL_DNSWL_LOW(-1.00)[suse.com:dkim];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,bytedance.com,cmpxchg.org,iogearbox.net,linux.dev,google.com,fb.com,vger.kernel.org];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]


--qnegwa3hbjphuauz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 10, 2024 at 05:26:18PM -0700, Yonghong Song <yonghong.song@linux.dev> wrote:
> This is not true.

Oh, I misunderstood a manpage, I can see now it's not for any syscall.

> More syscalls can be added (through kfunc) if there is a use case for that.

Thus, I don't want to open this up.

Michal

--qnegwa3hbjphuauz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZheekAAKCRAGvrMr/1gc
jnl+AP9K1DB6KLICURjslQg8RPwAxt5ZS4vkUe5biaeljWRA7wEA9UKJ0+1wiJV4
4Mf98MQLtuvEFv5v6L6qtBRpvrcGCQw=
=0oQ4
-----END PGP SIGNATURE-----

--qnegwa3hbjphuauz--

