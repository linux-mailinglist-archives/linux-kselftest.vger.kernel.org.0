Return-Path: <linux-kselftest+bounces-36042-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE809AEC73B
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 14:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B6A03A7A0A
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 12:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50957246799;
	Sat, 28 Jun 2025 12:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D11Rj4F4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD051BE4A;
	Sat, 28 Jun 2025 12:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751115091; cv=none; b=o56tmEQqXo53/Fg2rx8O0wYjNA6/G/Ql2HfHdRkfIEw+VD73MGZmxaoNOnEXTMatmmT4JkYZ1XqdPBEAdiYI+VoR2ZpR0qFHZzIJl8UFpxwJm/gvvkH0I5brJDdKuHqK7vSUSogEg8fNcJic4e1/xDBp/W4ItRFRf1pN8ztdqhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751115091; c=relaxed/simple;
	bh=/XhzeQ/qIyiKPzYwoMFNVjh3bHYTLrPXCW9JC1ZUonE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ohmfjwK8RaSEkaOC6tyaXbb/3y8gbZr7zGGSnHgDhBGJHSBSm0fehae8Wz2d3VY5n5gAG319sKjVbBfCmtNdS5PNsoe23w+LzeQy+xB38lstwu9eQJWj73eT8gPxvjf5HsKCdH3HXA1EOL8wHNonEm93w92ZCnLWI4WJQ7b/NCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D11Rj4F4; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b2fcd6fe970so516202a12.3;
        Sat, 28 Jun 2025 05:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751115089; x=1751719889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=48TlzH+B/dFIOCV6cmGqmz805LBIodgi+NMhMNWoo4o=;
        b=D11Rj4F4DeIKIthJo7P5b639mGia8D07ZGgjCzE3RTiyaZaDbEm3UfWAy+BNf1HQb3
         ewQOzBwEt4ymlD4+yhc5/30yG46bOnYuduk/Wq205hyBDV/14NDpD/mZvyvg+fxzyXUx
         Ud5C49i3P5K3l6BdMlOyBuphglZ32pH3wvNMt5h2ZY/pPS0QkK31gGnROahPhOaEBiEG
         /EdP+EvPCYKBNFL0eebLeTAfBg5SvI4ahR/DBjWgbIov8qDQwKuJbOBTehlBXcO7YpgA
         N0Om4uV5VUL0KkeTj2BbIW3vp2Twu5RA0bsfqU5q9x64y8aK8mtXW+Vy0b1jDXrgW86C
         PgKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751115089; x=1751719889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=48TlzH+B/dFIOCV6cmGqmz805LBIodgi+NMhMNWoo4o=;
        b=j+OiVtktOdbp6+ORLf3h1WneuA6/59B4snWKv7ixuikE8w6+M1y9t1UFDabiCDy5RT
         A8mfggZ9Ax0lhLd3AN3aJ5sGVc1jbOAG+uek6jTHcq6dIbHRm81Oz46UuDWNv+lOt8zf
         yY/bdFf3Vt9NhoZK48GiMU3062Ho6CHjc0mNn96uk8Dg9RKe+4KpRutttH3o8Kugd83n
         gcloH4RkdVKbbfze58/FcnbvIORRdX/DW/GluML8a0p9gbt9/g7EoJLsQjU/iYeeP43w
         UDlyPzYahQBhT2bqIsI6Em8TatAqyPJPbX386LmXmYKqwdipWViytwLAme8p28fBuin1
         MHkA==
X-Forwarded-Encrypted: i=1; AJvYcCU24VZOaVVFIK8UfYfWo32qlcMUwJPXAZa4GjAMv2DbcQEImBGuC4Yzs36iT9DANJZVkhK8Z1/RuhlTCA4=@vger.kernel.org, AJvYcCUhrr4wAMRs1uNzYwjV7LpMMUJSa7GBSzI0Dg3u6Yd4Lq7MJpY75m4jBxfjekoY6V1k0KtuBIUChQQU8kPw8NgH@vger.kernel.org, AJvYcCUuJSoelxO0kjWn0w2/vvz8M0LFTk7d684iD1YrzXJbfXj2EpAjA9QjgrW/FwElu3K3HPVWw6IbNc8=@vger.kernel.org, AJvYcCW9llOwyHMBa+4vSTi/IZfrmkQZfG0M/Md6iQVoewpVLdz3rj6HDeORdINWLseYN1Qk+sLBfjNzPHklJO7225o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRGMP6bHOW5OOBPGQch1xMbYYzVAtQMLgUcBe3z2ypi4ZA1Y31
	Mlu+iJ6KHrghuHN0Ux1HiF0+XKS7odHASbts64dphTNHpr8+iBJy+wArcAwIxcl9fXhJ/cOzzUZ
	+nPoUYn93w32WPoRVtnfGv9XqD1LR2K8=
X-Gm-Gg: ASbGncuGEkgfskFRClJAjbgZCS9D3bfxO+lJwDXINA5+fSE4b5cBTIPkR9Yd5CHM97h
	+JBipZzF4bZJUeoaUZU1ohniha2SeoCvhzJDOMxUv+M6gisJqT6oW6uJsef8b6hBLffGvxmAbTg
	SYQ+qd31MXCqUPLr3tKoBUOGnDibYUs0hc2drlnlPIL/M=
X-Google-Smtp-Source: AGHT+IF83NxSga/73IzZHP9ZH+Dk1H5ZVUbTyoqGw/fldWN4ASKVsiyAJbL1eYeoiE4JdtyWY1PN4scS4CZe/X2Kwys=
X-Received: by 2002:a17:90b:390b:b0:30a:80bc:ad4 with SMTP id
 98e67ed59e1d1-318edd3da95mr1411969a91.0.1751115089099; Sat, 28 Jun 2025
 05:51:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250628040956.2181-1-work@onurozkan.dev> <20250628040956.2181-4-work@onurozkan.dev>
 <CANiq72kjdj4KbDhfnTbm8jZpLC1+WPB3E6M8D8M2NLnphMs5vg@mail.gmail.com>
 <20250628133013.703461c8@nimda.home> <CANiq72kY9DA_JD_XkF01ZSmXbD8iaFthVZ66X+9N5aa_WObt+A@mail.gmail.com>
 <20250628154237.0f367cee@nimda.home>
In-Reply-To: <20250628154237.0f367cee@nimda.home>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 28 Jun 2025 14:51:15 +0200
X-Gm-Features: Ac12FXwgClP6Yp6fHTMMv5JbyNRAPTPAsfggSLj5a6SGwbkwHWoZ1R_RFA_utb8
Message-ID: <CANiq72mxJM-7WAP8xVDukmiXq=ntThyFESFLs1+dmZJSS2q60Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] rust: remove `#[allow(clippy::non_send_fields_in_send_ty)]`
To: Onur <work@onurozkan.dev>
Cc: viresh.kumar@linaro.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	airlied@gmail.com, simona@ffwll.ch, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com, 
	tmgross@umich.edu, rafael@kernel.org, gregkh@linuxfoundation.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	davidgow@google.com, nm@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 28, 2025 at 2:42=E2=80=AFPM Onur <work@onurozkan.dev> wrote:
>
> Yes, I am sure. Just to clarify, I am not testing 5e7c9b84ad08. I am
> testing c6af9a1191d042839e56abff69e8b0302d117988 where
> `#[allow(clippy::non_send_fields_in_send_ty)]` was added on
> `unsafe impl<T: Driver> Send for Registration<T> {}`.
>
> Switching from `allow` to `expect` produced the following result on my
> end:

Yes, of course it does -- what I am telling you (and what 5e7c9b84ad08
says) is that the lint is disabled.

And since it is disabled, if you change the line to `expect`, then it
will obviously complain.

If you actually enabled the lint with e.g.

    #![warn(clippy::non_send_fields_in_send_ty)]

at the top of the file, and then used `expect`, it will build fine.

Cheers,
Miguel

