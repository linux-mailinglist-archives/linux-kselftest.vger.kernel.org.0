Return-Path: <linux-kselftest+bounces-14731-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C349462B5
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 19:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FD4B283286
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 17:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF58B25632;
	Fri,  2 Aug 2024 17:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="YvsMsO+w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C951AE02E;
	Fri,  2 Aug 2024 17:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722620779; cv=pass; b=Yy81ZsYMkCReqzgeNvhL533MQ2/s4zuBtNjXdAhIKFfwl/BVA5TVqbjtJZBnT3NdtDdpRRGbvJj5BrDOWLIwsqIYX6486PZc/UmUGC0pkepBSw7UI8z0/QkjfHz6XqbJSlYCddMQqIzFvNGYjAKC5L40EYaT8jaTnzcHumXJAEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722620779; c=relaxed/simple;
	bh=FaSy9z5/BKbRyNYMvsp7Zib7UTxTj9ufwAnK5qE4gdU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Y5DrU5GQudPUedscMcNfXR5QAEeH74q5jqzJaMiIvx5qgWUOwxZXGaXjisnPJ3Cx+X2CV6qVgo9rV2z3zIzx7jYezWlkoBvjTQxE2qpQZ9/sR9faTz0TOxPw+JwgMQ6E5CR+M3s5snaYB/02DNHj77qXsL043wt4irewZ8lA2rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=YvsMsO+w; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from localhost (91-154-92-171.elisa-laajakaista.fi [91.154.92.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sakkinen)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4WbCtX2ZK0z49Pv3;
	Fri,  2 Aug 2024 20:46:11 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1722620772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EJA5dz6GT1ZPM1EjDcSFSj0xz36BOkfodV/mooPCX64=;
	b=YvsMsO+w2yl7JvT6prNmcGULOsmsSUNO8p+g/57AkH2HGSjY4Q+ha+zVLy3defbXX5aKV/
	UZqdkoms4EDkJnQA8oR8sEev0fR45v2YYtLuEux2JdkOY7rtl/3aWZ/odsdlUQPTyJtyye
	LEBBMfwnBFfqImTPbDNcHsl5uBLCmYOeC0NcZrKb66U56rOaJGuqUVX2FPd51IAiQhV/Tr
	ht2F6ISgmmr3OJQPFJpjWdLdgP5YQ83r4H1WTU5J7ekCKNCewdFS/bXwQ+lMJHL5TKvdby
	7Osw7DfhZ8UKEUy/az78xWxI9yw9kkSYFEKr8vRkjkU1WFM2w/i9QiDsDgx19w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1722620772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EJA5dz6GT1ZPM1EjDcSFSj0xz36BOkfodV/mooPCX64=;
	b=OjgtywO+ZzXIeSzuyXr72K3aTrvCa2zcnLpJSmEW3arU7Zy0xtxExN7bh3J9YDBTHWYnZv
	21cPNn3lVkzLr7TpS7+Xj3HQodzegr+N6cCFomtwAQqQ4rzouYhQbScwnBuwJOChIzdYXQ
	WV9N7tQVO50mPMsAP6smAEfbUAmlNPthpDHp0BLCHrB9d8sF4zHUeH0RoQz6S6ZXKMqF1J
	bAwSrO3MElegkJdbDmwTNdVTcsRVckVJnrS0rV/Qjzc7y3fgK4Zp4pFEfQJ9WsoNLTkoe2
	SdjpriiG1qOlitg/QQKIVKI82lL4Ki/mNAsxYXKp17mlPhOUzEyzV3+sPhh5Ng==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sakkinen smtp.mailfrom=jarkko.sakkinen@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1722620772; a=rsa-sha256;
	cv=none;
	b=kSjNsjxJonm2XFSz2z1T+mGe15fzaoWVVaM18lSFkdLqFzkoK+981ndvH96m/YKe6PekcD
	E9lPgIVVUK+fZmEZ3AMGH/zxZjwaOMiXlXxSzjPPta52CGVTs2wu1tNhn66o1qj5P0NKcS
	4LpEbd5u4VAfiOtnEEg+8wMoWkWy4oj1HQB77eKdRLR4qZf+HVQbaqRaA/OUjnMlRNMZvG
	VPx2zq5ck9aJrR+t2YcgapEo9ASByPfnGEwWuFraLkPfxvVj4ZYUh5XQO2Jl2SWZZEyfzc
	/cCZbBqU6aBgo0YEi79jebqoh16gjQ699hW0fbl9LDVzczQxKA1YEjtD4IzEBA==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 Aug 2024 20:46:10 +0300
Message-Id: <D35M3L2PFQFK.RYW2GMO04RYI@iki.fi>
Cc: <kernel@collabora.com>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests: tpm2: redirect python unittest logs to
 stdout
From: "Jarkko Sakkinen" <jarkko.sakkinen@iki.fi>
To: "Shuah Khan" <skhan@linuxfoundation.org>, "Jarkko Sakkinen"
 <jarkko@kernel.org>, "Muhammad Usama Anjum" <usama.anjum@collabora.com>,
 "Shuah Khan" <shuah@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240710081539.1741132-1-usama.anjum@collabora.com>
 <47ea7423-3aae-4bb3-a41f-1fcb5c07e74b@collabora.com>
 <8696338c-fcd7-4c0f-87ec-9303c9c1ce88@linuxfoundation.org>
 <D34XE10GQHIY.1H7BTET3DOREV@kernel.org>
 <deda17e1-328f-4eed-b14b-84b47d36e8d7@linuxfoundation.org>
In-Reply-To: <deda17e1-328f-4eed-b14b-84b47d36e8d7@linuxfoundation.org>

On Fri Aug 2, 2024 at 1:58 AM EEST, Shuah Khan wrote:
> On 8/1/24 16:24, Jarkko Sakkinen wrote:
> > On Wed Jul 31, 2024 at 8:45 PM EEST, Shuah Khan wrote:
> >> On 7/31/24 07:42, Muhammad Usama Anjum wrote:
> >>> Reminder
> >>>
> >>
> >> top post???
> >>
> >>> On 7/10/24 1:15 PM, Muhammad Usama Anjum wrote:
> >>>> The python unittest module writes all its output to stderr, even whe=
n
> >>>> the run is clean. Redirect its output logs to stdout.
> >>>>
> >>>> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> >>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> >>>> ---
> >>>>    tools/testing/selftests/tpm2/test_async.sh | 2 +-
> >>>>    tools/testing/selftests/tpm2/test_smoke.sh | 2 +-
> >>>>    tools/testing/selftests/tpm2/test_space.sh | 2 +-
> >>>>    3 files changed, 3 insertions(+), 3 deletions(-)
> >>>>
> >>
> >> Applied to linux-kselftest next for Linux 6.12-rc1
> >>
> >> thanks,
> >> -- Shuah
> >=20
> > OK, great. Maybe it is not *that* critical to backport this.
> >=20
>
> I took the liberty to pull this in. I agree that this doesn't need
> backport. It suppresses messages and doesn't really fix any bug.
>
> I tested it to make sure it doesn't suppress important messages.

OK, great thanks a lot!

>
> thanks,
> -- Shuah

BR, Jarkko


