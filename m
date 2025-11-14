Return-Path: <linux-kselftest+bounces-45644-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EB7C5D9EF
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 15:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F72D423622
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 14:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DD2328245;
	Fri, 14 Nov 2025 14:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="U/iWaspM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71827327213
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Nov 2025 14:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763130760; cv=none; b=a2juMtO2jUlXsU/DV8fLpJ6qXd4KEvfhr4AtwHh4bh/uD6AUriryN0YbuXFKOMYG6USQZCMnkAYg+itiSS3FYzW9R8xGZoF7YjUmr7KEzaDUWE5E+wFYqTLSwP1xDxDG/SFle0HPpmRetKyCXxzR0siJZeVTyYvB21vc9ZorCco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763130760; c=relaxed/simple;
	bh=HN3jnmUy+Cud7sca2nzou+9fsUG3OJoMB2unjr//I7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8/XJd6Jde28aB/zVeSDdLsJQClV/Vzj/kABGir2bOf2jlj4W70o4B1LNYucrw6XMz+X0cg2r3fb/KzyfWAd1T8Kpo14zVkuNi8g+bKgE4SVhWBzDRZn44GMDO4WLcAfX3qnL7vfIu33rdJxpalpyVd9SOu20Zrf/v0DXVczGqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=U/iWaspM; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42b3720e58eso1886432f8f.3
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Nov 2025 06:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763130757; x=1763735557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HN3jnmUy+Cud7sca2nzou+9fsUG3OJoMB2unjr//I7Y=;
        b=U/iWaspMoTD/e2lIs9AM+3/XgbYqp6QstaOAl+YZhvy9MmJCi3XjpnW9bHmziQEaqs
         UqKrDRXaqjLkX5OWkrT2g2aulQJrlnDmkmDCYAutzGiCODIVhSrJTLy3g4+Lnu1cKFEL
         6fjLJVPMu2J14s7ZnbRQmoQGv0DdxkwML7VbwrNn/H66EXT+4tAzM8iIfVyBo9iyt0EE
         zQ4HDazCnatbWN9UbuHvM6w7kOE3xASNSTzCS/BpRTKjrOAnC/koYyiT/S6771S1z+67
         b7SDhu6Z+ARQwu3HkEOXBRFpREl9/Md4Ph06yksDJk1CUh8ZmYJ54qrZ0FYAUZbC+YdY
         9cYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763130757; x=1763735557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HN3jnmUy+Cud7sca2nzou+9fsUG3OJoMB2unjr//I7Y=;
        b=P6zAXAjo3Vxgx0Ki6+KUVOFxsZloSO05Ou+oNtvMJCyHAH1zkJyvlfg2z/ZQRhRxDW
         kQpRRHBJbd9eEQYtS0BMCJOoW4pHF/y+rYr8ikvuBZ0lyTesSacv81jt+mop/HLm1jLE
         QQAl6LeDN2hihYfyhde4LN83BqNPvS09OQM4A+ofcem5H4oC8bPX+pFvWNmif4ZYCBQq
         e1PKOGo5Ld6sVzocm4To+Ke0vqGTJEwseYVS/jgrMQhFSZg0Y/TZFOT/K2z+As54sNSU
         9Q04/p4ltVamAavsSvjC9c6UX05f+AB/SLWMg4kURO19KmKBOsn/8unVOGEbt+J+qIlL
         jwZA==
X-Forwarded-Encrypted: i=1; AJvYcCUskZuA6Hi3x7oVvbe822m5rzBO8ZObH9SaW72IEXEC995mxQMt+PjBsd7Wz6yONoQmeEttpmT2vv4S168hkUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRMHUN7umXj2xMWyxUD/r6tI7Be89HBT1qEC8Ui7GUlKncDOth
	F7xZTxcsDpJGJ/PQKuF3P5+k3VT7qzmm4dJCXfOrnf25vX3klQ6tGewgRiQLQBf9MrA=
X-Gm-Gg: ASbGncuaXz5g1H83scyVbM9pideyrO8uom9rIaneCDOqfCJT4sWD2NE84V3uq4gH/m7
	VFFJnQX8b9MTxRrVu3XkWGUAhmSNrG7/INMevoNSA4OW3ZcP9Od+Htec/Wrm9ROoTbRTtizumyu
	hUitxIQaH/nb6mihkjAVh4Ebza5O1sM+ktPppK2bMLbWekxdiCc+6iUD0kOaEfoXNYQBKO56b7e
	bcgd+XCIc9/m1q5a0aKZaq75/X08pdmob4kMMamfnC6CXWy5Pft7xnKELCQf3bsAt2lMa2qbE7+
	8eJ1TeVE1gDGEehREUu4XF91Vfqx53tjBQfMYEAAjRKBjoEw7Tzb7f7gpJAyIyp9NNxUNVCeL0D
	UXhdxpwHITK4YksCIxFQmFfBVYew3TbkHYWB9VsagzA0M3oABEqqB2203ClHEyrww3bpWc4rW6D
	1LmznI1IvOviT1c0HPTc8J
X-Google-Smtp-Source: AGHT+IG/wsNger26E0V0m6xgXzA1Oo9csceQsjfNfsN8BI+4W7SPfZqWJAu79dOI4diXiuEuLjz23Q==
X-Received: by 2002:a05:6000:2c0f:b0:42b:41d3:daf9 with SMTP id ffacd0b85a97d-42b5933ce36mr2926758f8f.2.1763130756418;
        Fri, 14 Nov 2025 06:32:36 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e982d6sm10480919f8f.21.2025.11.14.06.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 06:32:36 -0800 (PST)
Date: Fri, 14 Nov 2025 15:32:34 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Guopeng Zhang <zhangguopeng@kylinos.cn>
Cc: tj@kernel.org, hannes@cmpxchg.org, shuah@kernel.org, 
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sebastian.chlad@suse.com, longman@redhat.com
Subject: Re: [PATCH] selftests/cgroup: conform test to TAP format output
Message-ID: <4h54pkcisk5fmevglu3qldk5fb2rgo5355vfds3wplhekfumtz@qtwtixmuw2hz>
References: <6lwnagu63xzanum2xx6vkm2qe4oh74fteqeymmkqxyjbovcce6@3jekdivdr7yf>
 <6916a8f5.050a0220.23bb4.ab7dSMTPIN_ADDED_BROKEN@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s6uqnsagtupmqone"
Content-Disposition: inline
In-Reply-To: <6916a8f5.050a0220.23bb4.ab7dSMTPIN_ADDED_BROKEN@mx.google.com>


--s6uqnsagtupmqone
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] selftests/cgroup: conform test to TAP format output
MIME-Version: 1.0

On Fri, Nov 14, 2025 at 11:55:48AM +0800, Guopeng Zhang <zhangguopeng@kylin=
os.cn> wrote:
> Actually, selftests are no longer just something for developers to view l=
ocally; they are now extensively=20
> run in CI and stable branch regression testing. Using a standardized layo=
ut means that general test runners=20
> and CI systems can parse the cgroup test results without any special hand=
ling.

Nice. I appreciate you took this up.

> This patch is not part of a formal, tree-wide conversion series I am runn=
ing; it is an incremental step to align the=20
> cgroup C tests with the existing TAP usage. I started here because these =
tests already use ksft_test_result_*() and=20
> only require minor changes to generate proper TAP output.

The tests are in various state of usage, correctness and usefulness,
hence...

>=20
> > I'm asking to better asses whether also the scripts listed in
> > Makefile:TEST_PROGS should be converted too.
>=20
> I agree that having them produce TAP output would benefit tooling and CI.=
 I did not want to mix=20
> that into this change, but if you and other maintainers think this direct=
ion is reasonable,=20
> I would be happy to follow up and convert the cgroup shell tests to TAP a=
s well.

=2E..I'd suggest next focus on test_cpuset_prs.sh (as discussed, it may
need more changes to adapt its output too).

Michal

--s6uqnsagtupmqone
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaRc9gBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AgLgQD/fbe7S0AtogwfuP1y5Bqn
wM4mhSkCc3blXh/7ObpsjqEA/3cTt2T97D0h3i5iLPdSu/NO3AwScgRBygMG5F3I
dJUB
=rsPe
-----END PGP SIGNATURE-----

--s6uqnsagtupmqone--

