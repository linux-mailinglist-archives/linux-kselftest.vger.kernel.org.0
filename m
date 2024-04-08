Return-Path: <linux-kselftest+bounces-7391-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D653889BE20
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 13:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92238282A24
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 11:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24386657C5;
	Mon,  8 Apr 2024 11:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DIqmKBfp";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TiejnKOe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2293D53AC;
	Mon,  8 Apr 2024 11:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712575782; cv=none; b=U1yYal8B5FShSnjCzcxBRWoKucLZGQe2stM+GgFysXUE37hWekSNCK+x6hn8+iacPwgGkEGNtkxGzvbxbGMnzgG10YXGo7Fe8ZF7JrBxTkcEqLNUxGA+Knc5GcOjqKijO7KUXXG7Pgs8d4/YoJBNTN71Lg/HLv4Q4o4qCqK5gME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712575782; c=relaxed/simple;
	bh=ui6zO61OoRy1WTVBGgbxlxDqE3SIMw1GmctCU6KhCl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCBtSvANB+KDmnQemjnkGm4StfRggbPppD8fRqywkdGqsVndcc2rYIvCotwI4EWb+uZCN9qtuBeFfQx9Qox9hGrgPT8p8paYgHTZx/Cs+dioTu6Dg0wAisuNJuRaS1t1kWYMhfzpKawdpe/WkPfHykqHrBB29761NN8llIwDvqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DIqmKBfp; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TiejnKOe; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E89E3227FC;
	Mon,  8 Apr 2024 11:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712575778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wkruFaWMqf9jEP3pbWk4gnmTixQ96+6DeaVPdg/LTxU=;
	b=DIqmKBfpSnO93JQKiKSKdz07gIxN3frXvts4GqUuIVrpLsnXpUIAD9AqOnSE2U4UbWJ4y5
	1qKvZC/NhfysrAs6dgkyumU3cYhxHfOkkYjz5SLXTbe7qxEY0oC7PubfFxqDH9UpMr8zco
	d21F+St+kZjSELYc0FwvNdEXuJgsV88=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712575777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wkruFaWMqf9jEP3pbWk4gnmTixQ96+6DeaVPdg/LTxU=;
	b=TiejnKOefeUVgeT83QWTu1r65qefyoQ8qFnWHlaeBW3PatGsL8R8sCpR/OVF7TevYdnAw9
	VRVxwiUlsK2nW/882oESPIEgFk1EUVeNw132mjhulJ4O2SzHfdviMXAuDQQGwBuCQwhH/S
	Ab8OcVJTMWizgCNgfm9f3rpYVRaxCNU=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id DA25313A92;
	Mon,  8 Apr 2024 11:29:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id w3wONSHVE2b9RgAAn2gu4w
	(envelope-from <mkoutny@suse.com>); Mon, 08 Apr 2024 11:29:37 +0000
Date: Mon, 8 Apr 2024 13:29:32 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Subject: Re: Re: [RFC PATCH v3 6/9] selftests: cgroup: Add basic tests for
 pids controller
Message-ID: <qweowkm4wlfzovp3qhtkzbybeampodtwmpbp2kbtiqcrhmjtdt@syk4itfkpmfr>
References: <20240405170548.15234-1-mkoutny@suse.com>
 <20240405170548.15234-7-mkoutny@suse.com>
 <a45c2ece-acb4-4cff-9d53-f5c007c9b905@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u36r24juol4udy4e"
Content-Disposition: inline
In-Reply-To: <a45c2ece-acb4-4cff-9d53-f5c007c9b905@collabora.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.90 / 50.00];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	BAYES_HAM(-0.00)[40.95%];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns]
X-Spam-Score: -2.90
X-Spam-Flag: NO


--u36r24juol4udy4e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 07, 2024 at 02:37:44AM +0500, Muhammad Usama Anjum <usama.anjum@collabora.com> wrote:
> The
> 	ksft_print_header();
> 	ksft_set_plan(total_number_of_tests);
> are missing. Please use all of the ksft APIs to make the test TAP compliant.

Will do.

> > +	for (i = 0; i < ARRAY_SIZE(tests); i++) {
> > +		switch (tests[i].fn(root)) {
> > +		case KSFT_PASS:
> > +			ksft_test_result_pass("%s\n", tests[i].name);
> > +			break;
> > +		case KSFT_SKIP:
> > +			ksft_test_result_skip("%s\n", tests[i].name);
> > +			break;
> > +		default:
> > +			ret = EXIT_FAILURE;
> > +			ksft_test_result_fail("%s\n", tests[i].name);
> > +			break;
> Use ksft_test_result_report() instead of swith-case here.

Do you mean ksft_test_result()? That one cannot distinguish the
KSFT_SKIP case.
Or ksft_test_result_code(tests[i].fn(root), tests[i].name)?

Would the existing ksft_test_resul_*() calls inside switch-case still
TAP-work?

Thanks,
Michal

--u36r24juol4udy4e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZhPVGgAKCRAGvrMr/1gc
jkcRAQDfTQHi6illQsUgcXSAIodsO9Z2hcWZ0Oly6vYAN7OZXgEAn0NtUBk0wQBw
tQYzo52YpkylzKawaHv3c1ayxTXUwgc=
=hKE+
-----END PGP SIGNATURE-----

--u36r24juol4udy4e--

