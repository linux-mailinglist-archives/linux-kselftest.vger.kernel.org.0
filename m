Return-Path: <linux-kselftest+bounces-29139-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73857A62E73
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 15:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EC5C18998E9
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 14:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302B41F9428;
	Sat, 15 Mar 2025 14:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StvcQOfM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB8D366;
	Sat, 15 Mar 2025 14:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742050379; cv=none; b=Y6d/nyIhQ4E6BP1ygzv4XJTovo8iWqEhZWfpauxbXxzDqNBqJqxM3Ma06iHA2QLDkBPROxPlCsSQkOJEAUTOEwVRM+3GefG+q+cma8U8GLI6nT3wyFutK/voIQZL2LnXCpBI5zt/rYnLjYCqHr1MW/fxRe2UrtS1lwETamO+T0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742050379; c=relaxed/simple;
	bh=25toXEF63pIyQ4BAaA3+SY0YWyKwqbXfkZDOS2yXEXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VnCTsJxWce/saO4H4G1xIF+bruSQpVI7Mt9l6Ha7+AduThmfVvlxe3c5cUmYbdSaBkExWX246BuLLjsIMe3whicBziJHkNGjuNLKBuUv4AkL0zJAEJhDBn9sDtKV6axk5RY04F0LolslkmVrpEt9hCzPag67k1KAlECq3bIubZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=StvcQOfM; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30bfe0d2b6dso33088531fa.3;
        Sat, 15 Mar 2025 07:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742050375; x=1742655175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25toXEF63pIyQ4BAaA3+SY0YWyKwqbXfkZDOS2yXEXk=;
        b=StvcQOfMZsabErV8DBV42/ODW+fZVGzMk6ecV7FxwXVw42S841I1tZU8/AliKU21SC
         onStk8UzRf98iVsvmfof/3NXahDXUpF14uZRvEtCr0fzf5M+V0Zu76kodD2PJUBlJo10
         ePqc9KTHbH50ePsIXoFfXWsSh2Jxk7mJ/5uQ+nF5+33/kQohzqrymxxkFQAbdPBSpA7H
         Eb51sPtaVMWtdkhArfwd8d8T3uMZ7qVHHLXgneaqPSQjB/1J53OfyA/HpwMCmlO+a7Zz
         72ftThHpt4nnO7auws+3bGo/zj13TkR/JnenMJrAdcEZFyGQ+9bhDNtfHuBNjmXwxG7j
         G9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742050375; x=1742655175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=25toXEF63pIyQ4BAaA3+SY0YWyKwqbXfkZDOS2yXEXk=;
        b=oDRFvimbc/PV0sf3a8G+JVUXjTp3A/1qSgPkVt4TdqrPSZ0USHknEp9LE8kFEcudfg
         D9sJiNYM2tEqE/OQ0cNjFerfuO0LyCqUlSnfN2ATh2oXkjwRVcRPigawENnzfnmLUBAb
         LjXfv4EOiwW3ZLDhor9LE5ACs3uuES64Qgs4o5cIFr2vHsFrdU9eqn0CbNyzS304rC7D
         cjWCCZhkgTAol6RtONC056etkbcH9wgg+0EKmAS9lHeWrV3e/pfRlKdQuMMUAiC2/0PI
         /PhiYeUx1uA6fjDHIvBde2q0Cm90sZB7ikLmKd4kYOlV5Dc7rkHY8ESG+j78OpCXPB8C
         8Nrw==
X-Forwarded-Encrypted: i=1; AJvYcCU49P0qTcugGp834alFLslbPFzgf1LNLd5fc45Sj5fRhNdasQ/S8rOtvUkVLYkrDXO8tUTmWrwOOKk1wux6sWU=@vger.kernel.org, AJvYcCUqjk3SS8y0FMT/NDIIqn1u78Bih9i2mIg8V9omMEUzS+RTc9leT+neo4EaDrlK4AYnEwTefBJkB4+u@vger.kernel.org, AJvYcCVEVka0Ne7qSzHvGUS7WOuExFbfeq0RXy1VYq8nqSyYkflrxCWHlr05AIsESadjihY83DzURndSv0lOJxVZ@vger.kernel.org, AJvYcCVZfGy9qp5Jd2PwzVYvQ84rT0ATzuXG8qSHKDfcU8a5h1sihVFi2cIwEXe1kBrGWk09hifPkS7G3wucSA2Q@vger.kernel.org, AJvYcCWNNLK++edMZp26SclQxVV+lpaCRihB8T54kZRmuTDe0LdJ3NeKLcD1zYsrRBH8GXpH+kcJsP6fRGKw5dcyOCWC@vger.kernel.org, AJvYcCWPt+KkLOwXZo4c7m4oX26rv8vkBaBhvleRn018WPdT3dQMoxlqIEq+ELWw1xbWGq0CQ9iDtzhPUoWN@vger.kernel.org, AJvYcCXQa7u+65f6iOTPqbH3PrjlVRRMo5xedYmVh5ylEh3hxBsuedmmpVQy2Kxcc+hQFrMGDu7cCzDiqJOgbC8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykqka6F8FZIRml26Qb9+uDS0SvJ9ZryrC+tZqx+Iv1ylb6DBjE
	BMrwdRdAUgTX+YI93kz6SQ8bkSyKaEpRfd37N3AbVe5vzH0ENifjB5iLBEdw0o/0pcfrJ/lTh9R
	SZopoAN5oT5mg8U6Zuzgkbx5XHfo=
X-Gm-Gg: ASbGncue3kp7EAAXrths7o1VlElVYuHb5/lIKl4ozpko6HfNIudHmTBsFT2EpXIOvFY
	tf6Sr+U/GiIiJ+SCQ4om1zDLpBrEQscUXOoj47yMwTIwOKkEFFuG6HnPylKE2h5uFSobCcmodpN
	Pkhc+muC0ISEypzMeMQaQRnh3g20mG+v5hhILNlBqB0rKKA23rcArotMMO/MW5
X-Google-Smtp-Source: AGHT+IH8nC0TpYa6om1KJkuvMAniWm5KQw6dxG84o6l4T8qWuLbPOUtyA3zl+ap3w3tC9KO/f//DCnawBJXOvMWsW2o=
X-Received: by 2002:a2e:2413:0:b0:30c:514c:55d4 with SMTP id
 38308e7fff4ca-30c514c562cmr12196061fa.16.1742050375070; Sat, 15 Mar 2025
 07:52:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314-ptr-as-ptr-v3-0-e7ba61048f4a@gmail.com>
 <20250314-ptr-as-ptr-v3-6-e7ba61048f4a@gmail.com> <67d4a57f.c80a0220.16ff45.9cf1@mx.google.com>
 <D8GQJQFGKB8C.DZBUZT4IJIM0@proton.me> <Z9V0jSfuhqWi_t52@Mac.home>
 <CAJ-ks9k+5c-MYNaxv412Ri1LDAxvkdSQQfKEgQtTu6aEsS-XFA@mail.gmail.com> <Z9V5srg9h73ufu3G@Mac.home>
In-Reply-To: <Z9V5srg9h73ufu3G@Mac.home>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 15 Mar 2025 10:52:18 -0400
X-Gm-Features: AQ5f1JqjwDEWbdaR9Dml9SSN-lD5tP8ZfiC2uWZ_VNOu30cX7hVl5zfkNy74Ccw
Message-ID: <CAJ-ks9=23BLX_eo9QYESHFR6JCWJg6AL2Bmg45GAS=wHqAZw4w@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] rust: use strict provenance APIs
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Benno Lossin <benno.lossin@proton.me>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-pci@vger.kernel.org, linux-block@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 15, 2025 at 8:59=E2=80=AFAM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Sat, Mar 15, 2025 at 08:41:49AM -0400, Tamir Duberstein wrote:
> > On Sat, Mar 15, 2025 at 8:37=E2=80=AFAM Boqun Feng <boqun.feng@gmail.co=
m> wrote:
> > >
> > > On Sat, Mar 15, 2025 at 09:34:42AM +0000, Benno Lossin wrote:
> > > [...]
> > > > > The rest Rust code changes look good to me. Although I would sugg=
est you
> > > > > to split this patch into several patches: you can do the conversi=
on from
> > > > > "as" pattern to provenance API one file by one file, and this mak=
e it
> > > > > easier for people to review. And after the conversions are done, =
you can
> > > > > introduce the Makefile changes.
> > > >
> > > > I think it's fine to do several of the `as` conversions in a single
> > >
> > > Well, "fine" !=3D "recommended", right? ;-) If the patch was split,
> > > reviewers would be able to give Reviewed-by to individual patches tha=
t
> > > looks fine trivially. Then it's easier to make progress every iterati=
on,
> > > and also allows partially applying the changes. Of course it doesn't
> > > have to be file-by-file.
> >
> > I sent v4 a little while ago, hopefully the resulting complexity is
> > manageable now that the build system is untouched.
> >
>
> I have fun plans today (skiing!), so won't be able to take another
> detailed look. What I was trying to say is that: should you split the
> patches, I would have already given some Reviewed-bys ;-) But as Benno
> said, it's fine, so don't worry, I will take another look later. Thanks!

Have fun! =E2=9B=B7=EF=B8=8F

