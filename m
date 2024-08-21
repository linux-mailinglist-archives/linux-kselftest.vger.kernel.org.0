Return-Path: <linux-kselftest+bounces-15856-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF70959F00
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 15:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15A591C2180F
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 13:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C5D1AF4EB;
	Wed, 21 Aug 2024 13:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dolPsNWv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF5119993F
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Aug 2024 13:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724248068; cv=none; b=bnROZvZ4QktQIUVV/OQM1KR4HgJtw6X0HJe8cDcZ+V/lJJ/UrUXn2cZ6vFWKPuvx/QJtN1jmImTPFn0xZpXuqogbhhsf7oHoxjhyMA6HR+o/eq6U4aiQoQZnPrZXAYWQr4dtrLLC8E076BySoCAkEPnU/T6xzJidnMCIwCe4xrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724248068; c=relaxed/simple;
	bh=gwLjHNTsXHMmlKgeIfCrG8pO4t2Y8x/pcVf6IX7HJS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oqdylxslY18JprkIL2OBuh/f+JkFykF6mDlZ+37V893NCE4LrSjf1CkGTprPfpoaU+WxkW9f0YVld4o1mG0irDq785OUKBsZ5qTxwkXKefZRhUOZQ3qy9eNKY/QcUVgDc/TfEZ85lphwpyEOVA+Ij7eymf/ec3FFXAWwpnbYUfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dolPsNWv; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-428243f928cso54374195e9.3
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Aug 2024 06:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724248064; x=1724852864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ZR2V02XpqNEW9fvu30UGOqjOdE3SQr9bcH8M/YKkZE=;
        b=dolPsNWvrSeN1bjtX6ZyZ4JT8coc+48QIJvDg6MwxbHw4pe3mbqEbesmqh2lL+eRSt
         ReiP3BYXHER5gTs/Jgp7JRX0IWMn6sHNnDz11HD7NaNDq9cJKYxk1YaAP+epj1nRgN9h
         Sj7nO0Ht/2ie9fOWrMi51EH3Vy6GHn3Gk0K0fchKPqn9daRfq3eI4R9HalWAJ9asFj6h
         GMAfKvdYGyPmjpsjCxvrZm+xtqrdrSYM4MTJ6uJQuR94rao+lhvsaPPrk/apjYCHkvpX
         YFgneHgTgJYG89FU7AH00ltJjxOda2SnkXlEoYvjNcTsNKeQlI8Q1W/gIeDUqATCQfRg
         3ckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724248064; x=1724852864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ZR2V02XpqNEW9fvu30UGOqjOdE3SQr9bcH8M/YKkZE=;
        b=BHNLofgi+0pyDJjZCWDPO7mNniFSjxEsKY+rEXiHyQHJXKnezZcqBhaURCANGU+Oh7
         fhyg863t0t50nrTkJM7VNJ2vWadDruJckdbCOj+/JT+BpLfO6S79lt4nTJnMSDsgIS+c
         WPY7pdzAtC/ZqF8nf0UuGOUqHqeY03sgOX7aHpjao2UGmvpQPPdJZsX6Ahl1pxOBmExg
         f0v4RGaulSQlQ9YMXyVDjF/2/TR4e6u+TLPH5ixSKGgtobtU6fjcgfhYo6g+QcJvnHlI
         KU/ziseyo2Tqixr/vf2CdhDBRwxkDYrM60Ckl1ThITZ6xTaDQ9MXxFdoXrhHxaEs3HCf
         FPqg==
X-Forwarded-Encrypted: i=1; AJvYcCXvA2csPxytG0cwpWBAwJr2mxqqC9K3W+X/DEjog4bEbBgUqxgPVles0J4cmSm+LQCj3EQHCA2y8LSKxjUQrfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcT4hM2+0Cz9kbS0AEcmy92orbEndocWOWxsBUpdpTTz71WLlH
	O3pstRkQxBJQJuH0UQyoTq9aAEGjq0tmq08SkcSU9adnCpW2iuPdyQ5XHV/lgXpq+NUBSXfVc2s
	wm5VjgpMtw4GKe7YK4pLJZNgJArIdPE0d5rnr
X-Google-Smtp-Source: AGHT+IE+WRPQ5cxJkts/8lQ1Pyrz4IDfgbmZOe9kRkxkJ6+Ctq49hnrFtuGR4cuPoH3txY4c4UXweZZ+1LQnmVHuF+A=
X-Received: by 2002:a05:600c:4e91:b0:426:6f5f:9da6 with SMTP id
 5b1f17b1804b1-42abf096794mr15321995e9.27.1724248063553; Wed, 21 Aug 2024
 06:47:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819153656.28807-2-vadorovsky@protonmail.com> <CAH5fLghOFYxwCOGrk8NYX0V9rgrJJ70YOa+dY1O0pbNB-CoK=w@mail.gmail.com>
In-Reply-To: <CAH5fLghOFYxwCOGrk8NYX0V9rgrJJ70YOa+dY1O0pbNB-CoK=w@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 21 Aug 2024 15:47:31 +0200
Message-ID: <CAH5fLgiRPOVRsF5yz6d-fOciHg1EcwjD21eAgu4sSynSSsgf5A@mail.gmail.com>
Subject: Re: [PATCH RESEND v5] rust: str: Use `core::CStr`, remove the custom
 `CStr` implementation
To: Michal Rostecki <vadorovsky@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Trevor Gross <tmgross@umich.edu>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, 
	Finn Behrens <me@kloenk.dev>, Manmohan Shukla <manmshuk@gmail.com>, 
	Valentin Obst <kernel@valentinobst.de>, Yutaro Ohno <yutaro.ono.418@gmail.com>, 
	Asahi Lina <lina@asahilina.net>, Danilo Krummrich <dakr@redhat.com>, Tiago Lam <tiagolam@gmail.com>, 
	Charalampos Mitrodimas <charmitro@posteo.net>, Tejun Heo <tj@kernel.org>, Roland Xu <mu001999@outlook.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	netdev@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 2:08=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> On Mon, Aug 19, 2024 at 5:39=E2=80=AFPM Michal Rostecki <vadorovsky@gmail=
.com> wrote:
> >
> > From: Michal Rostecki <vadorovsky@gmail.com>
> >
> > `CStr` became a part of `core` library in Rust 1.75. This change replac=
es
> > the custom `CStr` implementation with the one from `core`.
> >
> > `core::CStr` behaves generally the same as the removed implementation,
> > with the following differences:
> >
> > - It does not implement `Display`.
> > - It does not provide `from_bytes_with_nul_unchecked_mut` method.
> > - It has `as_ptr()` method instead of `as_char_ptr()`, which also retur=
ns
> >   `*const c_char`.
> >
> > The first two differences are handled by providing the `CStrExt` trait,
> > with `display()` and `from_bytes_with_nul_unchecked_mut()` methods.
> > `display()` returns a `CStrDisplay` wrapper, with a custom `Display`
> > implementation.
> >
> > `DerefMut` implementation for `CString` is removed here, as it's not
> > being used anywhere.
> >
> > Signed-off-by: Michal Rostecki <vadorovsky@gmail.com>
>
> A few comments:
>
> * I would probably add CStrExt to the kernel prelude.
> * I would probably remove `from_bytes_with_nul_unchecked_mut` and keep
> `DerefMut for CString` instead of the other way around.
> * Perhaps we should remove the `c_str!` macro and use c"" instead?

Ah, also, please add this tag:

Closes: https://github.com/Rust-for-Linux/linux/issues/1075

Alice

