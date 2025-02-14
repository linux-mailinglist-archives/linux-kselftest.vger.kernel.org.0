Return-Path: <linux-kselftest+bounces-26682-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DD3A365D7
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 19:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C09913AADF3
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 18:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED6119066D;
	Fri, 14 Feb 2025 18:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jalWnTfS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C8E23A9;
	Fri, 14 Feb 2025 18:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739558570; cv=none; b=r5OoAnPuYlMPtNDf3r/GEtnmHkTBgcMX4ijT/AxLj2ILCLZlPd+rQaXT4Guzn9w2m0T3nqTwXefeSGkR3cWr2b10oXjN5DxEqbNWgDX5DHnVFtTYM4D2D6z48A0yTDRIloFEuwtEHdepkCI4JhO1i7fNlMvI3P3Hbi5eOx5oI4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739558570; c=relaxed/simple;
	bh=+Ppp9czNRk7XvC+wiqLcRD0Mif/eCE22uoNFcb/qHMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RCjoIo7hoprRkh++wVaSAlaRdu9JI3MJ93MDY/3IjUV75giVeD+4IuXQn3f+ArVm2JzSNhG2VMgZKsrFBZjB0s0m8R2wlPnrFG1bmNOOHCyFIxvyHYVCMfRYKAOTfHqqcYuR0FP04qQEMqkuQxikilbAam/u8oGKkJ8h1JpDGd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jalWnTfS; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30920855d5bso9617051fa.0;
        Fri, 14 Feb 2025 10:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739558566; x=1740163366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Ppp9czNRk7XvC+wiqLcRD0Mif/eCE22uoNFcb/qHMA=;
        b=jalWnTfSwBKi3O+5O6wXgZXfyz7W9qPVYbLreVOQl0+Y3Rq7nIl9EmsGzZYcP9j0Wo
         zI2AYMJhcNQfVERd2QCsPCP+BRnV50NMNTu8fvzmEfU2HNTZkFJR0SlpV1VRw1KTfF2p
         TlP7UK+yVNi47StEYvB2rHe+/OFI4TzLxWJPWVGhT/FF8gayMu1UyAds/BBbXUyT+o9H
         s+ItMyJ9KsGdDCvEvJ9v0nXzSN25vfX5RcPH99j84ZZihKunv/1Xuda0gTQcnLNuxGA5
         CZmJTGvYkp6lFH69JNfn124IBTwNv5GqT7nvw0R08TGvHs1/CGvUmxuP8tk7I4Nayfqb
         86aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739558566; x=1740163366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Ppp9czNRk7XvC+wiqLcRD0Mif/eCE22uoNFcb/qHMA=;
        b=qKw2lv00FEOmv+q6mx+tlLWHYyihaPkZBwp/KadUj7qtBqeGIfoDvd3+kbC/FvN0aK
         Pcw6BLyaTJJSVDtyoejBnR48wodXVI1ZknwzHXICbm1MzzJJUx54DaudzZl7AwYLkBhl
         G61nv3vz4LGQB8PQct9u0mZe1qA+b+jHSEAyc0HPy4SRryWzaqokY+MB+aw4qJU6WK3Z
         50xyqZCDgb5uD7VrIFEnf96kcVvd7I63eU8bgfCdV7YTDyfMeB8T/WMQ9Famy+hfXJGk
         2qwvXFkIIiea1GrNARY3xKz7SPcmMpKftuhJF/TQv3L2f1UUH4YUT8ec6Gve368/6fvv
         0qhw==
X-Forwarded-Encrypted: i=1; AJvYcCVOGvLceceuJ79TJ6zMoxCdeC9Rv3c5X30m1CkY4JQkj4WikndCoKrB55hNeSD7yyPx9J8e+Z+fsHfy8ymdyXc=@vger.kernel.org, AJvYcCWUAsw/pTCY7V84/6coFkIPXCXPxH5zZo5yFq6D2Qtvdofstbf1/Jdtut5jKFiOnpPgdcz3ItbBgu8SZhs=@vger.kernel.org, AJvYcCWtTfb1O3NvmX5d4tK8lBCDdx+LPfsMgpEO04xn2bRyCYj7wbjb8R0QL+i8YQHwtWHh+gu1KVkPUjMD5WVPCwem@vger.kernel.org
X-Gm-Message-State: AOJu0YwX/4vhd3K+CHdJOS66oLc70Ywjq4TgwmYtOMQB7xRyubaU4HHj
	KPK98dgb77uLKBbDzSHJFjCxlKoUU+QrPNDr/m6V5zBicqgdWiourjGqb7hEnqeILNgeMjJJqa3
	1L1Lj45e/RWKPfNCsv5f2pmEjqs4=
X-Gm-Gg: ASbGncu0LYKyBiDyW6wnpk+e2q9f3+z7w6tmQYB+ANeu0xbePqD0EROwrusZIkHV/Hp
	QtXZ29FUoSLVVufdSjsjXe4Gk1i0ILB3EhN7jSmWCPYqpuXv0W5NCpkCQZsv7yQJCH2J6ALeI4y
	cj/AydCPgEB1Jhgk8tuU4ICIEskqF5Tg==
X-Google-Smtp-Source: AGHT+IG/DbkJpzmDRij1aXUq/DJiFEA2hRU2uT3oNHgjRUzszo/1DJpq//Zt50xWwJybnu7eIUZU+nk71iKW4DA3luo=
X-Received: by 2002:a05:651c:1074:b0:309:20ad:c514 with SMTP id
 38308e7fff4ca-30920adc703mr10285831fa.0.1739558566104; Fri, 14 Feb 2025
 10:42:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214074051.1619256-1-davidgow@google.com> <20250214074051.1619256-3-davidgow@google.com>
 <CAJ-ks9nAT5ETe3qM-DcY-YqES-pTK0RdMAY_fn1jT0_Dv1HkTQ@mail.gmail.com> <CANiq72nvYSo0KHDpOYTNNv5o2VH9KPocJ-q=cQZ7_mkYAqBjjQ@mail.gmail.com>
In-Reply-To: <CANiq72nvYSo0KHDpOYTNNv5o2VH9KPocJ-q=cQZ7_mkYAqBjjQ@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 14 Feb 2025 13:42:09 -0500
X-Gm-Features: AWEUYZkhwa962pazWk7qxNv87ch69sDiIBbCfxRGZpCgIvrUIQ3D7TWlWPhxHVA
Message-ID: <CAJ-ks9mz=MaR2wSC5VSeBbyAraC_LedPoxf4A9bEnD5O_ASPYA@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] rust: macros: add macro to easily run KUnit tests
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: David Gow <davidgow@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	=?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>, 
	Rae Moar <rmoar@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Benno Lossin <benno.lossin@proton.me>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Matt Gilbride <mattgilbride@google.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 1:38=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Fri, Feb 14, 2025 at 3:41=E2=80=AFPM Tamir Duberstein <tamird@gmail.co=
m> wrote:
> >
> > This is a really helpful comment. It got me wondering: can we have
> > host-side unit tests for our proc macros? Code is better than
> > comments, of course.
>
> That makes sense (in fact, e.g. Benno wanted them for pinned-init),
> but I will defer that until we have the new build system to avoid
> adding more things to our plate.
>
> > This makes sense. I wonder if we should think about being able to
> > declare a test that runs both on host and in KUnit.
>
> Yeah, when we originally discussed `#[test]`s (years ago), we wanted
> to have "attributes" or "tags" like `#[test(host, kernel)]`.
>
> But, again, something for later -- I would rather we finally land `#[test=
]`s.
>
> Cheers,
> Miguel

Works for me. Could you link to issues tracking these, if they exist?

Reviewed-by: Tamir Duberstein <tamird@gmail.com>

