Return-Path: <linux-kselftest+bounces-36894-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E94AFF4D2
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 00:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B7071C86456
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 22:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589BB248F52;
	Wed,  9 Jul 2025 22:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+/VCJ1u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781AC248879;
	Wed,  9 Jul 2025 22:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752100615; cv=none; b=TmMikUvRxH5sovPHyaBmGo14b9KhipqrnQbrrQt4m6YH7QU7Rrfev/Y+QkxuU/BVg+wx8u4n8QOuYWkApMT89hTksZUt5LyqshYgna8w13UgmKWgUvSKBOcgvCV8QzwTh4yf4V9/C5F542XcqG9VkCIybeGFSoIxbFJrh9YXuXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752100615; c=relaxed/simple;
	bh=CLm/0pb5W4sPJtUgUjYFJoNYPSIUT2mYJQmNysMDGeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oxlL6L0RCP0iTOh3m/X2lLcpiNzi7MVIMe5pCARBbp1/nlkcQ0mIqmJAB6X6Zv0foRklbc4rp9lbLz/1odU9QdlKwsEBS5EejtNotM7tLk99HMz6NNH3erUk8Tsys9x22jepeYAYZDjvXbEszIEaWrSCCG3RcqmtO6uQdWvWJFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+/VCJ1u; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-32f1df5b089so2902501fa.3;
        Wed, 09 Jul 2025 15:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752100611; x=1752705411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xhfrvtOMsoaE+gDC4ofthavQSM3N4fj7JS72/QkCgSI=;
        b=g+/VCJ1uGfkQj9JcQrzLxlsFBk5CCfujYG/i2fyTiii37udq9kj772t6H8x+E5o2AH
         B+HFX0RJlTF/DUqL/sYeOL7qYhuqBfV4pc4MgMzIfWj5zZcx8PYiC4AA/s0ZSP94ZZP4
         PLcx/KSOC90sVippNKsN5vSiRwAlH4Bpq12iaeJ+LnofT99i++8vdHNfe6lkKyqXQqOy
         LVtOXpRU5mu5wZaRe7jWcgC45IBw2yyNUFF9UBq1qoFNRD6Okh+hlZqQe6LZJP3Nzk3s
         gK/8cRY9Cnuxikv4hFFncOU2PWAiZdb0/N1vd7q3J+CBeWQaNhehqwFm6inxe84r23Up
         YARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752100611; x=1752705411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xhfrvtOMsoaE+gDC4ofthavQSM3N4fj7JS72/QkCgSI=;
        b=vpz6rO04/v/CTsIMUhNZfb7az2s80BcFRCVNB/HYQy8Rft1InHMQFjRCvfoxccOIci
         j7Rc/y2ubJOPAXdD5Igjdnj3symA90B2tvfAKbhiLUqSaMUdlaHJzzRUOCBISoJVXJxH
         cOfOFvlLGMF17EJ6NNfI4tl6uWeymq4mDuFW0n3MKvWNmGvSm0fB7SdBX0vKSS07MdZ1
         GVOHzO4aVVftM++fEsjYrR0jucLTvWQUBzwHyE3Pe3ksCy17V+TM0IP/hEqi1BVzfoN0
         5wV2ZH64QZbG/VlyUla+/8Fqq+mzd8xdhBGaJR+bWPZsXZzpD282GtoCrak43Wdqyt9z
         k8Rw==
X-Forwarded-Encrypted: i=1; AJvYcCVuURpgTcnYodTTnMz09+mT3+3Rj8rSHHAY9kM4O3Gz7NYNu7+0ABPS53Q5Hq2/Zyo6aK3sEANw5EENli6P@vger.kernel.org, AJvYcCWqvCpPMjRl5DEpWlk1f1ixFBOioztRa1JLrDey1j/9u+MHI7+QXXlA47+19bNO/VBhNQ1LGlwAnVbhEjWMtUs=@vger.kernel.org, AJvYcCXMl2sE6pD97Qu3hmOppNL6PMwXAu7y2jWxFhlyqplTZzyOJD6ynMSVNXjLyvKDjkzUmTwRhiuAAa3vwU5jDACT@vger.kernel.org, AJvYcCXryPjniUMF/mWzDIWOkuLZxpvWJcMvQ4TXx9E0C/frtAFlajQhSpwk5R2yZWwXbbh6Tdr4zwJDeY8W8A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdi+dKUaCWElMmvnGBZL5MK1DyK2aTJ6I22xv9q9ca2Do8vVCj
	1Oj6oOs7u2XFocHbtQIBjoT+wi47bGcsafR4YmyBl+2hdh9tryKVLsJ0etDL6IAgo1jAXtQzn4q
	aSUfY6JrSE9k51Gp7qTkQ/xkzgAFYuHU=
X-Gm-Gg: ASbGnctWIoGORbzLjhOC8FAv6Dibo4GMTM9nA0783zX5rGvu+OPOVh1Cvm77KXBR6JG
	7pQ3muGjJVB0jaAD7ce5zU3WXUZgDPK8YfwtwjcYjcM/HGXDlz0FXQOTwpBtFKze3qP/Q+YDg5x
	aa+UCtrqrevDzSN2BSjWuCI0+DtlOnQ9kPQ/lLYzVhA6oa3BVTeOjaPwHqQpUJKwd62OBvGddWH
	C7tXw==
X-Google-Smtp-Source: AGHT+IFONhq6F+DbkzpsEpK1WwNv3QQhAm3j21ralGrjpCechN0UN+rtIDTk39PxuYI9EYRr21JY2C6Wn5OzerY5ENU=
X-Received: by 2002:a05:651c:49c:b0:32b:80e1:300d with SMTP id
 38308e7fff4ca-32f4fdaa020mr4072561fa.0.1752100611215; Wed, 09 Jul 2025
 15:36:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709-core-cstr-fanout-1-v1-0-64308e7203fc@gmail.com>
 <20250709-core-cstr-fanout-1-v1-7-64308e7203fc@gmail.com> <DB7SVTBZ46QB.31WTHFLWDHPZY@kernel.org>
 <CAJ-ks9nNc_pThtb+gHUcjEnvR6V0RAEG0tkv+_DHYYjXs1N7=A@mail.gmail.com> <DB7V0GL2HVMV.BR1JSWQPDMC3@kernel.org>
In-Reply-To: <DB7V0GL2HVMV.BR1JSWQPDMC3@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 9 Jul 2025 18:36:15 -0400
X-Gm-Features: Ac12FXy3ucGydWQMIVi5coi-DwzxVJ4W0f_hIIoGG4YPbQ2PMfi0zxdVxhB4wD8
Message-ID: <CAJ-ks9n9Z0PtBmqNupS2390B+gq7UJuV0npD+3Ri0tJrQZVB9g@mail.gmail.com>
Subject: Re: [PATCH 7/9] rust: pin-init: use `kernel::{fmt,prelude::fmt!}`
To: Benno Lossin <lossin@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Jens Axboe <axboe@kernel.dk>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 5:58=E2=80=AFPM Benno Lossin <lossin@kernel.org> wro=
te:
>
> On Wed Jul 9, 2025 at 11:01 PM CEST, Tamir Duberstein wrote:
> > On Wed, Jul 9, 2025 at 4:18=E2=80=AFPM Benno Lossin <lossin@kernel.org>=
 wrote:
> >>
> >> On Wed Jul 9, 2025 at 10:00 PM CEST, Tamir Duberstein wrote:
> >> > Reduce coupling to implementation details of the formatting machiner=
y by
> >> > avoiding direct use for `core`'s formatting traits and macros.
> >> >
> >> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> >> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> >> > ---
> >> >  rust/kernel/init.rs | 4 ++--
> >> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> I usually prefix patches to init.rs with `rust: init`. I'll fix it up
> >> when picking the patch or Miguel can do it if he takes it:
> >>
> >> Acked-by: Benno Lossin <lossin@kernel.org>
> >
> > Actually, squinting at this patch more closely now, I think this isn't
> > what you had in mind. The comment says "Dummy error that can be
> > constructed outside the `kernel` crate." but the error now comes from
> > the kernel crate :(
>
> It's a re-export, so the comment still holds.
>
> > Perhaps you could suggest a different modification that would both
> > meet the original intent and allow references to core::fmt to
> > disappear?
>
> The code comes from a time when `Error::from_errno` was `pub(crate)`,
> but that was changed some time ago... Now we can just remove the
> `FromErrno` trait entirely from that example. Feel free to do that in
> this series or as a standalone patch.

Ack, sent https://lore.kernel.org/all/20250709-init-remove-old-workaround-v=
1-1-a922d32338d2@gmail.com/.

With that patch, this one can be dropped (since it is just a comment).

