Return-Path: <linux-kselftest+bounces-30125-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D46FDA7C336
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 20:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5115D189A365
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 18:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCC1215178;
	Fri,  4 Apr 2025 18:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ccyke/mQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6914C1FF611
	for <linux-kselftest@vger.kernel.org>; Fri,  4 Apr 2025 18:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743791186; cv=none; b=mI2xbifosd46X/pXFFMz8b3LPJDQt2z77JTbJ2Wi27vVlRVz+M/YfcZl59GVAvNKkeV9+Tbd9jD23729NB91xcfxMWzsoM/iLO1BJ2QviqLbON9y8x2RVtVgFZJ2yc25/XRw1zilz11y8WDMSxUnJQxNbpOj1blzrIH1NU6x0q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743791186; c=relaxed/simple;
	bh=ZOTccLSgfI9cTOLRpsnzj9bwhsvfPOgW3jKDNeC0EZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnqpiyrND9hvyNDTGiSoZNftM7DDsa2reMXZJaA2TZQxv8iHU32IDAi2HrOLtqhr+pLAIHRXpTjKyK64n5dYd+yIyj1tHtCZDcTITc6QPECoVwzonBch+RWMTM1rHtnUtzvcvWdGU5IWeGmgDjHoRmlFURmuhu55fmQ1z8NrdPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ccyke/mQ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43690d4605dso16002715e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 04 Apr 2025 11:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743791182; x=1744395982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TLhJnFT3Gwgfc4DYQiW9AZKUF72F44NtVJtW3JeRxAo=;
        b=ccyke/mQQfKXb4ceiQm/QSwzwrJ8wzmRxIL4Zl+KxbKAWRA3PqO0errlnZdbfpCTaU
         njoTLMoATvHs7AMbyjNkU7qs3hTLaYX30+9agUIwDM8h73haKXTDWPuTJpHB+CzWdxdx
         SkshbfUPyU5974CCRaByTBUY0xUHVqo109Khqx5xcJYFG/MWFb+WnFpTpatxsSnB75Su
         Gs0pTG3rFyIFjnGEG3yqe8xZ/rrAZx+xWmZlOOtobwdIoowjFLeF+889gmnmTekw180i
         OO4JnJ36+iXATlhkc4BAm+02Nj4r8yaN9J+jlBTN8iFamsXh8UGhmTXdwEhnN1D/b4XX
         4xLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743791183; x=1744395983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLhJnFT3Gwgfc4DYQiW9AZKUF72F44NtVJtW3JeRxAo=;
        b=Tz5qrTb/P3y8B1WmogfByuU1Vypy3Z4FWP5qmQEtynFThS4Yhrkcknp/meYcDqzwya
         kj/mRVw0aM1cHHnnfkdOszzJZPtaXfPoeGxlKX1yGuG3GLxJF4w8A1A0bmUCPdQ5CeNJ
         S/2hb1lu2fmGB9d/cgmXVFU+P9ul0c28D3wZNr3B79VNRo4otKuUrm/+GmhgWnFjAkip
         +1iRsWMsoWRzmhqAlpdII8Xo28StCko62wQz4Rb1/5SBCCTwZjciPwN15Zydh6oqFcP/
         Yb2ie+kCDM0deQcGN0JOkKUR4u3F4rNrycdDaEUXKELm8QuN5jsMzA7kIYfuQdG7l2tR
         0cJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWM3rEaSTCYVzVU63+0Mm6h3Clh3t7tu3RSwV2FidoM+6UMlWMI++AjCjo/GE/G19G+B/tqMktVWZxIi+bjHPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJn4wmXbNjUB2Jj5RWwVHE3hO6RSDWbqQjy6XmSHkU/bnhJ1Ut
	Vayv8oXJVjNEy07LOvUvjpWugcjgXCbWj2HIVG0pn/KkgCuFAjFsGDZyzpociH4=
X-Gm-Gg: ASbGnctPtlr9WCO49Vkejm541nRmCvtgfnF1NODWypUVvBN2ykqZ5dOuulqvPFwQ6Zm
	ROnGuTi+S9kQelH8Ix4Mu9zd7YC6RORlUeUcdQ4dlEvpgVixBpo92x0BjBCr1P6a7KklQgkEriK
	Y5v5VRK9tvS2YJOyaIv9GniglZoMFmX7yM4bY8MCeRe+/MhzSon6fffPUgip/7AU2n9O7OpNyi3
	PCjfSQKSPTRnTIb4MUiTOwfYfG+pGf4a1rbQbq8SIRWMk1AqJnLwe8P4Cp37sARIuEAH30Vcx6w
	2q8F2h3Ln6PS6odkfEYcFQkgEGsnA/OYAAdmwAmpIsHur5Q=
X-Google-Smtp-Source: AGHT+IFVVzcvCxUkq7QqYrnEsRDzq8Ic4YqHD2DrlGgpG3HTOI3DOpixIDGv0syuaug71lzZJsL3oA==
X-Received: by 2002:a05:6000:2406:b0:38f:3a89:fdb5 with SMTP id ffacd0b85a97d-39cb3575d97mr3948931f8f.11.1743791182544;
        Fri, 04 Apr 2025 11:26:22 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c3020d975sm5041239f8f.75.2025.04.04.11.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 11:26:22 -0700 (PDT)
Date: Fri, 4 Apr 2025 20:26:20 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Waiman Long <longman@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Tejun Heo <tj@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/2] memcg: Don't generate low/min events if either
 low/min or elow/emin is 0
Message-ID: <aopkqb4bd6sag5mgvnvmoojlsz47lxrgxav7lsywkzeqtb5pco@ptxoqnloplzi>
References: <20250404012435.656045-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3ezm3guyzo3fa3j5"
Content-Disposition: inline
In-Reply-To: <20250404012435.656045-1-longman@redhat.com>


--3ezm3guyzo3fa3j5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/2] memcg: Don't generate low/min events if either
 low/min or elow/emin is 0
MIME-Version: 1.0

Hello Waiman.

On Thu, Apr 03, 2025 at 09:24:34PM -0400, Waiman Long <longman@redhat.com> =
wrote:
> 1) memory.low is set to 0, but low events can still be triggered and
>    so the cgroup may have a non-zero low event count. I doubt users are
>    looking for that as they didn't set memory.low at all.

I agree with this reasoning, been there [1] but fix ain't easy (also
consensus of whether such an event should count or not and whether
reclaim should happen or not). (See also [2] where I had tried other
approaches that _didn't_ work.)

> 2) memory.low is set to a non-zero value but the cgroup has no task in
>    it so that it has an effective low value of 0.=20

There maybe page cache remaining in the cgroup even with not present
task inside it.

>    Again it may have a non-zero low event count if memory reclaim
>    happens. This is probably not a result expected by the users and it
>    is really doubtful that users will check an empty cgroup with no
>    task in it and expecting some non-zero event counts.

Well, if memory.current > 0, some reclaim events can be justified and
thus expected (e.g. by me).

> The simple and naive fix of changing the operator to ">", however,
> changes the memory reclaim behavior which can lead to other failures
> as low events are needed to facilitate memory reclaim.  So we can't do
> that without some relatively riskier changes in memory reclaim.
>=20
> Another simpler alternative is to avoid reporting below_low failure
> if either memory.low or its effective equivalent is 0 which is done
> by this patch specifically for the two failed use cases above.

Admittedly, I haven't seen any complaints from real world about these
events except for this test (which was ported from selftests to LTP
too).

> With this patch applied, the test_memcg_low sub-test finishes
> successfully without failure in most cases.

I'd say the simplest solution to make the test pass without figuring out
what semantics of low events should be correct is not to check the
memory.events:low at all with memory_recursiveprot (this is what was
done in the cloned LTP test).

Michal

[1] https://lore.kernel.org/all/20220322182248.29121-1-mkoutny@suse.com/
[2] https://bugzilla.suse.com/show_bug.cgi?id=3D1196298

--3ezm3guyzo3fa3j5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ/AkSQAKCRAt3Wney77B
SXLwAQCLHjkGHqdonWWfAZmkRMLnnd/9GLDwQHs1pDPkdB+LygEAv1ILh4buquz3
RL8ZpTYF0zHvtsUdp9Ow556iY7pSSw8=
=fCfQ
-----END PGP SIGNATURE-----

--3ezm3guyzo3fa3j5--

