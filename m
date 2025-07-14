Return-Path: <linux-kselftest+bounces-37244-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14535B03EAF
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 14:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29528174051
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 12:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03232472B1;
	Mon, 14 Jul 2025 12:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOMiTO0B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D5C23C4E1;
	Mon, 14 Jul 2025 12:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752496133; cv=none; b=NlRe+adHU0bU/kqq0lpl6FTWZdx526IDyEyznFmSwyiHCF5bRdObSVArUvgApBKibZlIUu/iO7rXn9pQsVWJpA0v8F2PdwNVf0kurQrNBDqjHcylnYa2svlCCqs7gZIM7Qzg/1aEe7wQXKVNmaEM1Tl5o4kiacgzU+Eq5I3g6NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752496133; c=relaxed/simple;
	bh=VhjsyGfVk/NYPkxf3dUl3ag4ZXP4DikybPpZX89jZFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tgKKWwFtRFaPSJAQJEjiYvk5pY/ucMBV+0mutzY3TtoRHY53vuHCv7kW7sLL89Zp5sE/VI+6pY/tuH8XhhLdef3QurPZcMa036UWy4DYXLXTUX0Bq288s2NaEYkyTrJY7wxoN77NU/mZ5y8wiq44nzuua383HktasmXkqAQTN4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lOMiTO0B; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-32cd0dfbdb8so34196881fa.0;
        Mon, 14 Jul 2025 05:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752496130; x=1753100930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SbUxRDt1V115BL2AgQxJUishMrxXTwdY/Gt4NlJymo0=;
        b=lOMiTO0B2YTNiSCrl+ZvRtoZ98lAhynFz1dmUxHF79iSRytHCZL+crfJl/ZYoubxfl
         z9NG2U8v9EjaTemKOx0nGA/XZdmeagJmGKjEydKdPl5isnmWASZJ34+JB1oIsWMYXqPo
         KLYHDj0EbqhWFdILgZMcirT3hhL8NOTWdwN2f+5xweI9Xjqhf8fMS7zJOMvxGXBs/9iB
         kvxaQ7iy7Mgn68KoMx12V86Yo6J3Po2iOuUnsVcLkTnN6ieL4dnxw3MGJEr4EVSZ7B6V
         /uJ/KIThHJ9qVHzYLfNcUZDiJnOq+Yf2vwDMTDkVogtaAnsHpOqHzxtYg7XGGu0gmJAc
         oA1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752496130; x=1753100930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SbUxRDt1V115BL2AgQxJUishMrxXTwdY/Gt4NlJymo0=;
        b=RU+IE5tWIWzaz8RAXxLYlhEZVkzFynVSCe/Ay08/S6LD2IRuxm1WhMkfN8QTi8wjqM
         t6qZ5ce6wS1ohLe2645SPQ0qwv6sagu9bok9f4UKBbi4XWCpxv2yK/kh31k96G05xdqr
         llchz9sa/9dvwqKyifJyuUcn72GvH6aw0zB9Yky0ZoRXrog39VBK3uLkHPvQ32CtcBB4
         8ilXF9KzER6c9tCZDMd6jtB1nteLmU5Vpf2kgTCk/8NR21AbyQ5DCVQQgTp2Ikh9U66u
         grqAJlKfzc4qccvaOpigMYzDw3IgQj3lF2MmOfeQmHUtoaTKqDrL2iuDsGQ+XCNDr6ju
         plrg==
X-Forwarded-Encrypted: i=1; AJvYcCUYdt9Z0redpu3PgAlxy3YM9zjWVbG/oFXMmSSWYSCbpqaIbnT6eVy8gnmlfgeGPGYQTQYRu0+U6euvKOjU@vger.kernel.org, AJvYcCW6ks7v2fNsNs6yBAtlCTJ+SpP1jhc7A7NtQMB3uPo2KC+2yBqd6QQyjS7EfXIoIIw7itV2eLFM5hQXUYT7b0A=@vger.kernel.org, AJvYcCWj3eNRE6w4HNQQYTIrYS9WS/76foJTtmbskLw832SpneCKGgCctOr1EDQVboLfLy708RN7RTtyDACA@vger.kernel.org, AJvYcCXHGm+Hs7wcSZKG1KiShqWFZUbYB7nBRWrDYSwjvTu0eOHZQcEZ5gZCWNa6ZRiGRQp0jxuP7o49FyinAE691Pa3@vger.kernel.org, AJvYcCXMi/2YI4HO8d84iMtrln4ETDc8Oh0d/oyYU4oezrXRtCj7GSM6Wlg/S8neeplI0KGJTUfwh6tf@vger.kernel.org, AJvYcCXuA5rnfUtruG3RHZWAuHRpE+RFqjj4aa6ZvAu73WH4tHLuvwmMSPiGAEOVDWXPtFRaI959hUtjyLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRm8oXPWILPjaV9akEciCXyBtcq2VHdvF2bPcbyNX9dweB8MlQ
	crBqEgnhAk/lICQhE7GLyOpxnk+lMGDcJlQNxgr4tEGpxm0S6916uisfXpiQzBaOokRgbivD5HH
	BuZoAF+aYWm3s+0bx20ve6lFNv5NL/nE=
X-Gm-Gg: ASbGncsH8CJC47vwTo/RcthQZcwakpV3sn5eTFwFeu0AnITy/qkJhOSd0E0I+HqZwMb
	q260G5JyW8C1mpZkR6oLU0C8lANHw2P942KkAXcX5RNPetzpLV/dTolFuJHKXslU/jcPV+XTXb5
	3xt+r056+BlXmIrJdzCM55xXSJYiv1L59WzOroT/NcR7kNEh+pgmy1NpGIyUJABC3MvVnwAEJTF
	3sRPlFf0Xlpu9Iyl275IU5i6padEU8gGRa4B+vlsz27Vo+z3pC+
X-Google-Smtp-Source: AGHT+IHrSBkjEoqU/I5DY/nGtzSq30SG70sPRuWAgDJvgCsJU9oDbgAOubBSXw4/LD+Vz0YhYyXX8s9x0cDKBQKVndA=
X-Received: by 2002:a2e:b5da:0:b0:32b:7111:95a7 with SMTP id
 38308e7fff4ca-330535da03dmr27580171fa.41.1752496129946; Mon, 14 Jul 2025
 05:28:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709-core-cstr-fanout-1-v1-0-fd793b3e58a2@gmail.com>
 <20250709-core-cstr-fanout-1-v1-5-fd793b3e58a2@gmail.com> <DBBQCHNN1N7F.3O470V9YDXE70@kernel.org>
In-Reply-To: <DBBQCHNN1N7F.3O470V9YDXE70@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 14 Jul 2025 08:28:13 -0400
X-Gm-Features: Ac12FXxlpQphBeoscQniP1NYfXjAeRGBqEAxGkTlGCPTLLtOzVyVDIQfLGYMkU0
Message-ID: <CAJ-ks9k2jyVpc6g9bGK4fUHbqUBUnH-aHawi5YKvhtpAEcqr2A@mail.gmail.com>
Subject: Re: [PATCH 05/10] rust: drm: use `core::ffi::CStr` method names
To: Danilo Krummrich <dakr@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman <david.m.ertman@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>, Breno Leitao <leitao@debian.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 7:09=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Wed Jul 9, 2025 at 9:58 PM CEST, Tamir Duberstein wrote:
> > Prepare for `core::ffi::CStr` taking the place of `kernel::str::CStr` b=
y
> > avoid methods that only exist on the latter.
> >
> > Link: https://github.com/Rust-for-Linux/linux/issues/1075
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > ---
> >  rust/kernel/drm/device.rs | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
> > index b7ee3c464a12..998b942b6dd8 100644
> > --- a/rust/kernel/drm/device.rs
> > +++ b/rust/kernel/drm/device.rs
> > @@ -83,8 +83,8 @@ impl<T: drm::Driver> Device<T> {
> >          major: T::INFO.major,
> >          minor: T::INFO.minor,
> >          patchlevel: T::INFO.patchlevel,
> > -        name: T::INFO.name.as_char_ptr().cast_mut(),
> > -        desc: T::INFO.desc.as_char_ptr().cast_mut(),
> > +        name: crate::str::as_char_ptr_in_const_context(T::INFO.name).c=
ast_mut(),
> > +        desc: crate::str::as_char_ptr_in_const_context(T::INFO.desc).c=
ast_mut(),
>
> Maybe looks slightly cleaner to import this function, not a blocker thoug=
h.

I don't feel strongly. I think I chose not to import it because of the
potential for conflicts.

See also https://github.com/rust-lang/rfcs/pull/3490 which would
obviate the need for this method.

