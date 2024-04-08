Return-Path: <linux-kselftest+bounces-7393-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0981089BE93
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 14:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B5C91C2217D
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 12:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E8A6A34D;
	Mon,  8 Apr 2024 12:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="j4lkPN0P";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RDtIchqT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B156A325;
	Mon,  8 Apr 2024 12:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712577687; cv=none; b=fSHqekgCM9QwwjzL4nUuRdCjAlz6E/n4PJFTvVJ/sDB488N6Mb3h35on570YWeQI8lpYio5KjrzTMbyIRIH3vwIeMqZQif7byvi009YRkTiRTWcOeEUKz8rZ1tRm9BrvUG0XbVEviGUessFUc63lsnEDKwLsyoPGW1d2r3Ca+kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712577687; c=relaxed/simple;
	bh=Up7QNd+1m5Ux/hBSZmSFppeTpP4WVdtBWIZUNIgXOOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GfZu+s4rGdyy1vwavA9rPRRBl/JPkzbe9aevfDhboTm+jlMkSJW3+RgZ3c4edlS5Mq/EhdrNtN/T4BkA7cka+fs4hHbp+xFtQYxxlPO4CAPWtGgvCsKK3lZG6oEhgrbGwbS94f3KllTJL210D5cHqyrZwiHzMoo4tsRczu+yYG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=j4lkPN0P; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RDtIchqT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C9F6C22866;
	Mon,  8 Apr 2024 12:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712577683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Up7QNd+1m5Ux/hBSZmSFppeTpP4WVdtBWIZUNIgXOOs=;
	b=j4lkPN0PYvmbRxRPJeNvTSMAZjCxTijf8LWiEis7i28YkiLfdxJXVqQ+aLc+Z2YFLjtmy9
	H3KX5zD0sPJy096NF6DXu0s1S5CLeWBiVG4y+J32JWh5MqeDrcgx+mCdslzfdTg1xjKb5w
	4MWnfy0sTkYaEcBLRBzGls2yIIF1UQI=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=RDtIchqT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712577682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Up7QNd+1m5Ux/hBSZmSFppeTpP4WVdtBWIZUNIgXOOs=;
	b=RDtIchqTMjOw17QDR5384H8A/AQLuyPdaiFJn2zOK39q6SZ2v0pdDrsvYRNYzota9Bbzgo
	/zutXQ7MzoaxwMqMquMHd4ccgwRPmv6KNqyCLcSHiK5G/xRwDvBz2Ie4UZtiOUYqasFNf+
	7/sQ0e/t63b1fdCSE0JmHDaQKF+o+HI=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id BB63B1332F;
	Mon,  8 Apr 2024 12:01:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id HPeNLZLcE2YLTgAAn2gu4w
	(envelope-from <mkoutny@suse.com>); Mon, 08 Apr 2024 12:01:22 +0000
Date: Mon, 8 Apr 2024 14:01:21 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Subject: Re: Re: [RFC PATCH v3 6/9] selftests: cgroup: Add basic tests for
 pids controller
Message-ID: <oosadt3f5i3qsvisrxe6hrs46ryfqbyxyk3a6jimd7cqczjtcw@dvlsm7eh3b6r>
References: <20240405170548.15234-1-mkoutny@suse.com>
 <20240405170548.15234-7-mkoutny@suse.com>
 <a45c2ece-acb4-4cff-9d53-f5c007c9b905@collabora.com>
 <qweowkm4wlfzovp3qhtkzbybeampodtwmpbp2kbtiqcrhmjtdt@syk4itfkpmfr>
 <41dd9c5a-0e07-4b98-9dfb-fb57eaa74fa2@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5356ekwjskmg2hlv"
Content-Disposition: inline
In-Reply-To: <41dd9c5a-0e07-4b98-9dfb-fb57eaa74fa2@collabora.com>
X-Spam-Flag: NO
X-Spam-Score: -6.10
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C9F6C22866
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.10 / 50.00];
	BAYES_HAM(-2.99)[99.96%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:email,suse.com:dkim,imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]


--5356ekwjskmg2hlv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2024 at 04:53:11PM +0500, Muhammad Usama Anjum <usama.anjum=
@collabora.com> wrote:
> ksft_test_result_report(tests[i].fn(root), tests[i].name)

$ git grep ksft_test_result_report v6.9-rc3 --=20
(empty result)

I can't find that helper. Is that in some devel repositories?

Michal

--5356ekwjskmg2hlv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZhPcjwAKCRAGvrMr/1gc
jr58AQCPDsmJv8jBG/PuhRG6EDGHAU1JwxcPf/TcqYtsH2nQPAD9HAYai/mkSOPI
bDFJAyl8B+0LHkYvYRNL8Tu6JNkVDAI=
=Noit
-----END PGP SIGNATURE-----

--5356ekwjskmg2hlv--

