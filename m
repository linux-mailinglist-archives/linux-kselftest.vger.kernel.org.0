Return-Path: <linux-kselftest+bounces-7808-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7508A308F
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 16:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A73E1F21B89
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 14:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087EF127E0D;
	Fri, 12 Apr 2024 14:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aaK8eDl8";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aaK8eDl8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB918626D;
	Fri, 12 Apr 2024 14:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712931808; cv=none; b=AeZKmNNueRC8lcZf14NRx8JfJZXJyz2uOgdamYEsvR/l/Tl3kNP+TMpsOufY4/ZJnAGxb7B2Bxm30kQThMqP4ZG4Br+NiAbDqW7I3IkVv/E8qxdWKmV86OWe8ABdqba8WLvhdDpLG2t1FLCfWgGE+qXGlTYaXMinsRLSSad/jRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712931808; c=relaxed/simple;
	bh=JxNUt0WI8VJtqkr1vI04CciRk6AsgIvjNELyWKMNfaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwi/v3swpW0G79F3dc51+tSgxRK1wjg6KmkBvFBWzeYyBRFaPkVbUJwc41dsVvb2cfOI5SNkuVhqCy6+CwSXyE5y10R3gXIf0nCqQX9vdnFJ7Zw1YrGyxX4yYrkrgvnUW1AB787cJwnGc+LA9I4fwQy6pMU1Sot9UQVC1/Mbgas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aaK8eDl8; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aaK8eDl8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8170B3835A;
	Fri, 12 Apr 2024 14:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712931805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JxNUt0WI8VJtqkr1vI04CciRk6AsgIvjNELyWKMNfaI=;
	b=aaK8eDl8BbXj/V9hd6/mjA++UiyT5kZSEtZ189Pvr4jHoHuZz9d+z4mZzyui0I2g6ZS9+b
	SuZrlvcQKWtdyZltI/Kt3evj81rlqpDyiLMckCFuyKea/bA5Oc+Q+d4wp8GTMglf/6LLHY
	dfoGgS7VsdYJXfExdxGLfjyMWE/llbo=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712931805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JxNUt0WI8VJtqkr1vI04CciRk6AsgIvjNELyWKMNfaI=;
	b=aaK8eDl8BbXj/V9hd6/mjA++UiyT5kZSEtZ189Pvr4jHoHuZz9d+z4mZzyui0I2g6ZS9+b
	SuZrlvcQKWtdyZltI/Kt3evj81rlqpDyiLMckCFuyKea/bA5Oc+Q+d4wp8GTMglf/6LLHY
	dfoGgS7VsdYJXfExdxGLfjyMWE/llbo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 66F6C1368B;
	Fri, 12 Apr 2024 14:23:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FUDyGN1DGWZvcAAAD6G6ig
	(envelope-from <mkoutny@suse.com>); Fri, 12 Apr 2024 14:23:25 +0000
Date: Fri, 12 Apr 2024 16:23:24 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Subject: Re: Re: [RFC PATCH v3 2/9] cgroup/pids: Separate semantics of
 pids.events related to pids.max
Message-ID: <w7cenotcuudapq4zsq6mybfvaqyljgy5hez3uc3byqzdn44yi6@76yfnhg4irt6>
References: <20240405170548.15234-1-mkoutny@suse.com>
 <20240405170548.15234-3-mkoutny@suse.com>
 <ZhQvmnnxhiVo1duU@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="746pwchwjxtzohce"
Content-Disposition: inline
In-Reply-To: <ZhQvmnnxhiVo1duU@slm.duckdns.org>
X-Spam-Flag: NO
X-Spam-Score: -5.75
X-Spam-Level: 
X-Spamd-Result: default: False [-5.75 / 50.00];
	BAYES_HAM(-2.85)[99.34%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]


--746pwchwjxtzohce
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 08, 2024 at 07:55:38AM -1000, Tejun Heo <tj@kernel.org> wrote:
> The whole series make sense to me.

Including the migration charging?
(Asking whether I should keep it stacked in v4 posting.)

Thanks,
Michal

--746pwchwjxtzohce
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZhlD1wAKCRAGvrMr/1gc
jqWHAP43KM4VxC2WEkbxsocIW9835Ah5tJFCnWq+L9dCH0YYeQEAgf4YC5EsufMc
emrWLa4i67lHae7Mxu5+aJkQVhJQ2AY=
=vxlD
-----END PGP SIGNATURE-----

--746pwchwjxtzohce--

