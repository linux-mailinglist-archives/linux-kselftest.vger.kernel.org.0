Return-Path: <linux-kselftest+bounces-25138-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C27A1BDC5
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 22:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32DD03AC170
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 21:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0ADE1DD520;
	Fri, 24 Jan 2025 21:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdwn3F60"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C371DC9B2;
	Fri, 24 Jan 2025 21:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737753162; cv=none; b=n/ITesgsYrIrza8rzoGmnh7jvZeJRT35LknQqIb4Y3BrGX1gjf7mWRedqyqx6VmDlrX/vLGG0mOdl8vkCTY9FGuTe0T55uV4+uZzgOGVA+q/SkY/HAbz6C92fPfrC1jYoawcLS4qATiPsXC1s8EmtI34298xo4K+SKLf8sfBQ/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737753162; c=relaxed/simple;
	bh=ZtvH8clksU9XxC9iXGNlAeXJsw3fmV7yXstdOZSLnAU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y/5gS++S38JcGD7lUrb9vjEoIRkNtvQjCs0TPRAZbvahwvUrW4klFnlmiDyS9kJavSUxLGh7buuSnHEJB8RifG77X7KrXPWNgz3CdV87Z1T/W2fcJWlcVZw1w7u87ZolQcQQAbw1+/DkrenZqWNkG1Le0Lo3DP63YIfw163VcUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdwn3F60; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2163b0c09afso49799755ad.0;
        Fri, 24 Jan 2025 13:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737753159; x=1738357959; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nGzkSXXrA7jYqSv+MBWBhKjKjIZTADsGXE7oxPj/cDg=;
        b=bdwn3F60wF3vdnmEavB5HU7OkuldrWLjXPn7cZJF+pLzgr8FF6ioVxR9fL9dT7HQuo
         eUme77tpYRrDDO0YpV7QXatKq7BBQ6esefkW10y5viqdYNGsGs/cG1QpumC5EVpy4+qa
         HXuYGZ/unc+IRp3cSaLIunungD8loP1dlbMzkmJc4DZh+m1KzKXvS4VoLRpJ1g3lONKW
         mI8GpTeYvvtLu5QUhIYVOP1zw3S/l7+M4JDOKhyl72Au+SOO82rHnrHr2eZW6mj7RDLh
         OD847IWeMBFt1kYudhfWOp5/3a9D5T6OwiuwnGUxHsJkWe/fWVsaTWxc8JCkdeSpiTpL
         wKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737753159; x=1738357959;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nGzkSXXrA7jYqSv+MBWBhKjKjIZTADsGXE7oxPj/cDg=;
        b=V4cOCGVGfRs3AFzYIBGsULkyjLYEepsfQePKPpnbs87XuuML2QUwa02kqiLWmpSMHP
         QJvQL5qsLORJ9/pcjJItiw2HEy6zKI70dpU0UgIl/w2pjt2d7XixxCyiW/36Q387KQSn
         UcDYnmUti8S7Lj+i8oAU+IaemUIXL+F2YWMe9mg+DZAQDmB4zVntm+xnwSpG8R/csxu6
         Pc8/XKKD5ZDr5yz1nL9BeHtTzK1UwmP0IbTNp38Aj9BaQVNwg5DrMgbGrSedzS7pZRpP
         cl50W1WymeCKJddQyM5of1QyqmB4gqyKJMYU3bzaXPOZg6EMWcB6oVibGBJGo8G+DjEG
         w3oQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+eKcJAvuMveJ4VPTBGIZ0bEhM5i9zHkXJxcTUv/vDDIS02wFWq3w4hpHFVP3ocFfOW7LXDdntNYX7@vger.kernel.org, AJvYcCVwn6AFvmmojRtAL8a8M5KCtIg7H6+QV9n8BzLCXHLVnw7Ch7CdsuGNdesNPkB6rduHPwqYfUIi/LvuzGU=@vger.kernel.org, AJvYcCWTHLqxy6de8bvIsbTnYjt4RnE0igbPV4h+fsfHcsDDKwJYA7DNF00E2Cbo5XYqfkOdGLpc3H6JPg47XqH8yIWc@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9M0HMQTdoZgFR2KU+4cH7Q+upPn/HFdqrusqoZuhPLLhlq4Yd
	iobuf7wfNK+CiW5/36bmSey5fx7N19aclvrmoi4e/L1R6LhqlWcY
X-Gm-Gg: ASbGncvUjqN9TK+/fJU4NjR7QoHvF6CBOyR3poSknxn0KJLZIYSfXrRNqUc4Aye2kLE
	47Pc7JgrSfCiql1epFQgXgggyjtu3eHVSRHWkayqL5TpIGzGFi/IOltew9Bwmqan8qB/+ixxhQk
	9ouX7qDObPXgHZTCPt5cuoE6B9wBxpL/wXggHcqvd27i+IyFoafg3Pc7KqhWUBiaeO/7TfHcwtw
	mD27XT5Bz9HjlUdx+gDsvcks0b6cKw+JYdtsgxaPi3sspcqxbyvvLSaXN+y3BR/jvKL2xVz8No7
	ae11UuDQfvqBpM0uSRyaJs9rwttzwbp9IJw/z7+KIuRiZ8AhyHM=
X-Google-Smtp-Source: AGHT+IGQunDQe7Ga5HOHK7oamtTMzDBL11HRtkIJFu1joG/eqDIl8j9Lzcy6B1FtF7LxRuD9eZKMmQ==
X-Received: by 2002:a05:6a20:a11d:b0:1d9:aa1:23e3 with SMTP id adf61e73a8af0-1eb215901d5mr59465264637.32.1737753157707;
        Fri, 24 Jan 2025 13:12:37 -0800 (PST)
Received: from ?IPv6:2804:1b3:a801:16c4:2e00:3d86:8f34:c7fb? ([2804:1b3:a801:16c4:2e00:3d86:8f34:c7fb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ac495d5531bsm2099472a12.47.2025.01.24.13.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 13:12:37 -0800 (PST)
Message-ID: <bd37528d1c704951cb86a751a5c81e4c76962f51.camel@gmail.com>
Subject: Re: [PATCH v2 0/5] kci-gitlab: Introducing GitLab-CI Pipeline for
 Kernel Testing
From: Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras.c@gmail.com>
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>, Laurent Pinchart
	 <laurent.pinchart@ideasonboard.com>, Mauro Carvalho Chehab
	 <mchehab+huawei@kernel.org>
Cc: Vignesh Raman <vignesh.raman@collabora.com>, kernelci@lists.linux.dev, 
	linuxtv-ci@linuxtv.org, dave.pigott@collabora.com, mripard@kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kselftest@vger.kernel.org, pawiecz@collabora.com, 
	tales.aparecida@gmail.com, workflows@vger.kernel.org,
 kunit-dev@googlegroups.com, 	nfraprado@collabora.com, davidgow@google.com,
 cocci@inria.fr, 	Julia.Lawall@inria.fr, kernel@collabora.com,
 torvalds@linuxfoundation.org, 	gregkh@linuxfoundation.org,
 daniels@collabora.com, shreeya.patel@collabora.com, 	denys.f@collabora.com,
 louis.chauvet@bootlin.com, hamohammed.sa@gmail.com, 	melissa.srw@gmail.com,
 simona@ffwll.ch, airlied@gmail.com, Tim.Bird@sony.com, 	broonie@kernel.org,
 groeck@google.com, rdunlap@infradead.org, geert@linux-m68k.org, 
	michel.daenzer@mailbox.org, sakari.ailus@iki.fi, jarkko@kernel.org
Date: Fri, 24 Jan 2025 18:12:24 -0300
In-Reply-To: <f1c73327073c98ade56dfeabf629e2f9cd7d1663.camel@collabora.com>
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
		 <f779c9af4133629f724e366241fab7421d13d227.camel@gmail.com>
		 <20250124081250.GA24731@pendragon.ideasonboard.com>
		 <20250124135203.040d0852@foz.lan>
		 <20250124130021.GA6853@pendragon.ideasonboard.com>
	 <f1c73327073c98ade56dfeabf629e2f9cd7d1663.camel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-01-24 at 10:45 -0500, Nicolas Dufresne wrote:
> Le vendredi 24 janvier 2025 =C3=A0 15:00 +0200, Laurent Pinchart a =C3=A9=
crit=C2=A0:
> > On Fri, Jan 24, 2025 at 01:52:03PM +0100, Mauro Carvalho Chehab wrote:
> > > Em Fri, 24 Jan 2025 10:12:50 +0200 Laurent Pinchart escreveu:
> > >=20
> > > > > It's been a few years since I first thought on finding a good way=
 of helping
> > > > > kernel developers testing their patches, while making use of the =
free runner
> > > > > minutes Gitlab offers. It can greatly simplify the testing for pe=
ople who are
> > > > > new to kernel development, or students trying to understand it be=
tter.
> > > > >=20
> > > > > And this patchset allows that to happen :)
> > > > >=20
> > > > > Actually, I spoke to Helen last year, and to enable it to run on =
the free
> > > > > Gitlab-CI runners, there is a small extra patch which is needed:
> > > > >=20
> > > > > https://lore.kernel.org/all/20240327013055.139494-2-leobras@redha=
t.com/ =20
> > >=20
> > > Sounds interesting!
> > >=20
> > > > Gitlab as an open-source software project (the community edition) i=
s one
> > > > thing, but can we please avoid advertising specific proprietary ser=
vices
> > > > in the kernel documentation ?
> > >=20
> > > Every time Gitlab is mentioned, the brand of the company that
> > > developed it and has been providing proprietary services is also
> > > advertised. If you're not happy with that, you should move to use
> > > a git forge developed by some open source community.
> >=20
> > I'm fine mentioning the gitlab community edition, I'm not fine
> > advertising gitlab.com SaaS in the kernel source tree.

Hello Laurent,

I see your point, and I see no issue on removing the two last lines of CI_T=
AGS
documentation.

I just added this information on documentation because the default runner u=
sed
for the Free Tier of Gitlab does not work for this CI, as it needs more
resources to run. This information can be added on some other place, but at=
 the
time I thought it would be ok to let it be there.=C2=A0
This other runner I mentioned in the patch is also available on the Free Ti=
er
(free as in beer).

I would like to make it clear that I have no connection/affiliation to Gitl=
ab,
other than a free account in their system, which I use for some CI. I have =
no
interest on advertising anything from them.

My only objective is to make it easier to hobbyists/beginners to use those
available free minutes to test some change before sending the patch, if the=
y
think that's valuable.

>=20
> I've just looked attentively, the intention is just to explain you may ne=
ed to
> set gitlab variable in your project fork in order to select correctly siz=
ed
> sized runners in your own instance.

That's correct

>  Its is not strictly about commercial gitlab.com instance.=C2=A0

Exactly, the change is about being able to choose the runner you want.

> The default only works with the original project used
> instance (which is not gitlab.com as far as I know), but the comment refe=
r to
> companies that will choose gitlab.com internally to reduce their IT cost.

Correct.
Companies can benefit on that, but my focus was on hobbyist (or begginers) =
who
may want to test their patches on free CI before sending them to the ML.

>=20
> Its quite a stretch to call this "advertisement", that makes it looks ver=
y
> dramatic. I personally believe its quite ahead of most other gitlab CI to=
 take
> into consideration running these pipelines on foreign (to the project)
> instances.
>=20
> Nicolas

Thank you!
Leo

>=20
> >=20
> > > The way I see, the best would be if the CI integration could work
> > > with more than one type of forge and being able to use any
> > > free Git??b-CI runners that would be available for developers to
> > > use, as this would allow testing more subsystems with CI, thus
> > > increasing code quality.
> >=20
>=20


