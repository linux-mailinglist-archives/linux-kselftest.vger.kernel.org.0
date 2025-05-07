Return-Path: <linux-kselftest+bounces-32626-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FDDAAEF3D
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 01:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51EA31BC6C88
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 23:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2005B291868;
	Wed,  7 May 2025 23:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Dufagjjm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3FB1CAA65
	for <linux-kselftest@vger.kernel.org>; Wed,  7 May 2025 23:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746660113; cv=none; b=I7ftCWEM8QR/L+JbpmdaIgVFkNCHzLLNeoJHPUpo4DAnollLK2HhtSvxICI5DgFu7ibeu6dQykyMsykPexX+1BZDtmYnZqv0BYhRYAW9ST99azxHfsbX6t1upJB1OdKJ+Vghc1u9J6Hq0cpO5V1lPX4G27xGGDGd7TZjVTqBG6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746660113; c=relaxed/simple;
	bh=bamgXzYV0UnQ2r1ph7sXoh7QCDp4e7MSXHZ/X1OQN2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H38bor59ANlCuHDcjN83pBoZATrIwPmSraxpcsJvFWcsLyMGN7lgSuKb3iFXstYN8tknmLbtiiNDMng4KCYv/QkysXUJemN7TPTtpPvzomIgYUxZ++12fxaHHgwrb0WzkBxSrR1LIc+QSbZhKvSGf6NQ6hVyCa5B4r+F01sHmSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Dufagjjm; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-70842dc27easo4448727b3.1
        for <linux-kselftest@vger.kernel.org>; Wed, 07 May 2025 16:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1746660110; x=1747264910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eiS55CU6GCzTdVaqv+v/fNQZYBIDDl972AoagHBKWUg=;
        b=DufagjjmqAeKn6K4RZUlzNzx51kuZ50HrbTQHDXajJrHVRHUeR6fKn3zTLYLi/UCPR
         mE6b2CZ9rsolEuvCNLhwPsyAh00f3244hhKbawmkrGiapbDzhPZYmI4ykn/ofb7pG6Av
         oaUGSKpVNTN7Mpfa28SP0p1z6EvxK5tOtX8LTG9nHHdVHUfLa3wAUfzxqDtJ2jJEVgpc
         gahKKHrGXYhkc+mTeMCqEBG7Bo+n0eRwzpTM4Lh211Qg1micZp+mCnzBzIZAjrIvlynn
         IItkJ4fD350/B2CnYbJJRm7CWugTKWOEcj5iPL3JNZhYDu66nxRkx56+PD0qAHW/1jZ3
         jjvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746660110; x=1747264910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eiS55CU6GCzTdVaqv+v/fNQZYBIDDl972AoagHBKWUg=;
        b=ihDhsoby869sSfiDWKxERQS7mrEU64nGcZaFMZn5XKo2nf4qHhWZgDj52P32ifJWG6
         L+EeHRVmTGic4DALy1le74o+8cj33Ra+goIAuNwDfcOP5QBTEX8Or9Cirayy8ot6LjvE
         dm60cot07jpBbb7pjT8UROLHJDn5THzCVKsQdpomm0oPxO8Kif+uGVEV1miuCg/uacd4
         VPcGCoMil2DH/euqfap3GBR6ViRjDnWRfi9TI4v5B5yDYT/1+jq0fvFF7tY5IL84Xr0N
         eicpRmPPd9ttTmOHicBNBA7OcOBprZpvqWpfNR1rwnGg4gBz6FqHihYVJs7xCfFl2myn
         h/kw==
X-Forwarded-Encrypted: i=1; AJvYcCWRxyaKgDGhq7iHIsbfdJTX72yRPOfsdTyeFRHt/+I+CT29bUOVUoL2wKfq6VEZcoZBhA2wS44y+BHQqV2wjgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwULjpQQ3R8bGntjxInHYjHUo3DCYJsXDh15bc3Je6ddw6pIW8I
	RpDbK6F0VfFz4DGJYQowqFfDR6/ubj4+tNn5DQQAFkxSH5kf7/Ab6XI+O6MK+8kcAZfpsRMJSff
	XJcOTK9bc+kT/36XYzE6rQavikxuR/LGzxUCr
X-Gm-Gg: ASbGncs1LPw6MEUuK6dwO3ObibLId5z4m+KSQmaVdN7VkG3QJpVhBT4VI+P/AEptAkD
	lfGDwEsZWmD4EuPbyuZTn5QDhCjLc3RZ/g2/HA57TM9ye3Ui2JQ1zIf5UxkMJWHiMV932S53CvR
	5Z+4UiIIRC/qs0VclKz1jKNaVMP6ps+bdF
X-Google-Smtp-Source: AGHT+IEdiurNMDjEEGPDbl4FsASjSKl1b0yzZP+/scZr6xyvlLkYWyw7qnY1iU3gzpVhfzU/6D0/RDhTUKWUSun/1+U=
X-Received: by 2002:a05:690c:6f11:b0:708:a778:b447 with SMTP id
 00721157ae682-70a1da3a702mr73951417b3.20.1746660109690; Wed, 07 May 2025
 16:21:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502184421.1424368-1-bboscaccy@linux.microsoft.com>
 <20250502210034.284051-1-kpsingh@kernel.org> <87o6w7ge3o.fsf@microsoft.com>
 <CACYkzJ7Ur4kFaGZTDvcFJpn0ZwJ9V+=3ZefUURtkrQGfa68zLg@mail.gmail.com> <5dbc2a55a655f57a30be3ff7c6faa1d272e9b579.camel@HansenPartnership.com>
In-Reply-To: <5dbc2a55a655f57a30be3ff7c6faa1d272e9b579.camel@HansenPartnership.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 7 May 2025 19:21:38 -0400
X-Gm-Features: ATxdqUHVijVfp4d_bipTBtoKTZV9oFot2QZoyM5v54DevQVu2k9jVQgfjdqjmrE
Message-ID: <CAHC9VhSPLsi+GBtjJsQ8LUqPQW4aHtOL6gOqr9jfpR0i1izVZA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Introducing Hornet LSM
To: KP Singh <kpsingh@kernel.org>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, bpf@vger.kernel.org, code@tyhicks.com, 
	corbet@lwn.net, davem@davemloft.net, dhowells@redhat.com, gnoack@google.com, 
	herbert@gondor.apana.org.au, jarkko@kernel.org, jmorris@namei.org, 
	jstancek@redhat.com, justinstitt@google.com, keyrings@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-security-module@vger.kernel.org, 
	llvm@lists.linux.dev, masahiroy@kernel.org, mic@digikod.net, morbo@google.com, 
	nathan@kernel.org, neal@gompa.dev, nick.desaulniers+lkml@gmail.com, 
	nicolas@fjasle.eu, nkapron@google.com, roberto.sassu@huawei.com, 
	serge@hallyn.com, shuah@kernel.org, teknoraver@meta.com, 
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 1:48=E2=80=AFPM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> I'm with Paul on this: if you could share your design ideas more fully
> than you have above that would help make this debate way more
> technical.

I think it would also help some of us, at the very least me, put your
objections into context.  I believe the more durable solutions that
end up in Linus' tree are combinations of designs created out of
compromise, and right now we are missing the context and detail of
your ideal solution to be able to do that compromise and get to a
design and implementation we can all begrudgingly accept.  In the
absence of a detailed alternate design, and considering that BPF
signature validation efforts have sputtered along for years without
any real success, we'll continue to push forward on-list with
refinements to the current proposal in an effort to drive this to some
form of resolution.

> I also get the impression that there might be a disagreement over
> scope: what seems to be coming out of BPF is that every signing problem
> and scenario must be solved before signing can be considered
> acceptable; however, I think it's not unreasonable to attempt to cover
> a portion of the use cases and allow for future additions of things
> like policy so we can get some forward motion to allow others to play
> with it and produce patches based on their use cases.

Beyond any potential future updates to Hornet, I just wanted to make
it clear that the Hornet LSM approach, like any LSM, can be disabled
both at compile time for those users who build their own kernels, as
well as at kernel boot time using the "lsm=3D" command line option for
those who are limited to pre-built kernels, e.g. distro kernels.
Users can always disable Hornet and replace it with another LSM,
either a BPF LSM or a native/C LSM, of their choosing; the LSM
framework is intentionally flexible to allow for this substitution and
replacement, with plenty of existing examples already.

--=20
paul-moore.com

