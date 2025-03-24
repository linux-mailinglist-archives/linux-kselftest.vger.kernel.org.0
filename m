Return-Path: <linux-kselftest+bounces-29704-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B564A6E58D
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 22:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C81817938A
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 21:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38AA1DE2A6;
	Mon, 24 Mar 2025 21:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lt+n+2x1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE73519007F;
	Mon, 24 Mar 2025 21:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742851044; cv=none; b=GmSANLUDEcsDuxGhFOGcI5Lv+AonGJAs6dCQWRD/wyqLaN/iH5DOK8f3Uv6mC5KBIx1Ayx0mRB/9kocWpTbJvwz5hi6KACCr38R5/TtmloVRCKW9AVHrveAflvcC0arS6L1Dmj1fmg07Oqp/V7h0BsupiM9UiYV7QAx1+bwxEmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742851044; c=relaxed/simple;
	bh=EYXS49vIEDNmzWn2U+P9XyZXY3qP7ZlhbLU+6p87r2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c49WL2hj5sarle4ZB0UU7Uxk+HiTO2gST/F0laF4y8CPFeL5dpcv+sKlolIGz4/Ekai6thRsnWsye7tVcJJWY9xUlb6a8phLfr6H+doVVCi3n47h402jWg8pgNDDnXxD/Mt8zcnSFgcK4KlY98mrKy9KQKT9UHfi1UuGcqFGwl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lt+n+2x1; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-307c13298eeso56278541fa.0;
        Mon, 24 Mar 2025 14:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742851041; x=1743455841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EYXS49vIEDNmzWn2U+P9XyZXY3qP7ZlhbLU+6p87r2o=;
        b=Lt+n+2x1uzJU6vTSsj+1J67kBz7mf6egu3vqh8K4kDDTJi+oH1/H+xFzgiqJVwjggi
         dciKeUUkly+cp6JIwY/1L4lsfj4Tj87iNcxHFMhAN7ejbKtLP95bpy18lZu6Ff/y8K/v
         lcZTUkXb81vM2fsX3kr6fvWBuaxX6jHsNAXFycCj0kiI96a3S/77y0N0cQKO2hU1awTD
         BkVWfImv0vLRwty30dx/tXToIrc3i3BQo1gwBBAAmHMGUuIBSqOC7+zNp+4shxaZy7us
         koCQU7dG/mwxKDIOZ5C0Qp4wZXCovvBMPlx6A5MaJmjLxd1okoro+TJgA7/5Uzp/9cbe
         fj4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742851041; x=1743455841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EYXS49vIEDNmzWn2U+P9XyZXY3qP7ZlhbLU+6p87r2o=;
        b=lai+rWBo8PQ/YXVeJSH75Y0Asigmw/b/jcYYZnKONT+48uXcs+oc12r3NX8R9mwJ86
         ji+GpAHbdKoNVGqYjuRE8vWUF9ySOUbnCZr+dBX9MY0e3ECdmx9vcWTz16AvxfnlnwOw
         2XqvRE1VwTljWM8tp97nhFpC+qmRSqmxtg7tPTDptLmb3tZQjk2TX0rAmrsxWOcR3cDD
         WpFV7XjqOGuNIdKaBhaKIcoZ7b3mX7gK0JLX+rmnuw7eTIyOUtnLnKXvC33Tssua1EyD
         m/HwfWA5B8ejHH6PWBZwuneNLb6Z6TYj2O5fEXobtYhtFlOA6eiB0lLkKB64jLXGqOLx
         5GiA==
X-Forwarded-Encrypted: i=1; AJvYcCUFJFwUx2q5a4usmOV6rU6UR62+WHLiqrcyQqdcmtj55guiWNi4cPyfe0vsynlLs+GnDkhVx1VbcB/MHYoo@vger.kernel.org, AJvYcCVhRmsUouKLh5C6zo/N8gmwH5f9qHUxogFmtKlNx8in/ppBz1DkVFq1cOlqVAFwgxYvfQsAUVB7oXtYRJE=@vger.kernel.org, AJvYcCW0N7Q5ZaZPi6Vy6C1gf+mgF2+zzRS9yQHZ5JUt9lIPQvKWINKF/J5VWsj24gnFDw/xVMq8as4elY8XsUbiNqcf@vger.kernel.org, AJvYcCW2JV0pckEJztaJc0rh+jntFgG75+orU4Uc7EWSxIzAUKJd6vwqZqsSi0u7skUkHy5z8z5tVGYHVsj1KfoUTlQ=@vger.kernel.org, AJvYcCWKPF5+qLtVwb6WJZJwYbjhg/vs18VlruRf3ec+C33JkoViZG/Yjie8vnIuBvk58qf19YZ5QQCV380sBVdn@vger.kernel.org, AJvYcCWvGxy3C3KklU2hk1sQ63FL0Tw+1y9EkkX7XjI0CbrY00+0EiGQ70lV21IbWVgXXXluhLEAOTaiU+jQ@vger.kernel.org, AJvYcCX/beTF1LvNkyVfTFZcEZtSXE+X+VgpW5ecwXZtl0xvGjRss3gGQCGHAddThyLS92+PX5hBwe3p2Y5s@vger.kernel.org
X-Gm-Message-State: AOJu0YzNiBRKDHtRhIBee5w0r0Tl+Lqj0nFA/nTOR9LTD6FFWLa/wiTy
	e9FukQl0bYETNh0GWBh+QsFQdHr59QL+/xFiTcGoZTpEWEfpUG3Hq9kRnvcaxd1/K8n3zNvYm1T
	HVfUb9jVZa2jkZvJqKF9egy93L8I=
X-Gm-Gg: ASbGnctkwNrbiDimhgzCuH9VJ4/Ul+2lvpX1l8v3M6L0qhFUWTqNbmpk1AKHu8kjX14
	bS+ugogq2CrsCbZBHlqX/Ah99+jYLkbkksrrNJ8bKzjgG36sBmm68p3taNZ5iYshE2RJdOw9EpO
	PoD3vDaGgU0Z2W1czXV/9H1zIETxPNYDqaxrmOWLCUHgTN4knv05dr
X-Google-Smtp-Source: AGHT+IFemchRnvUtUnQdwA3lXtxBXWGiiZIc1P9OgZ5X2p7jXeRSRDnG1ubs4vpNnHeVQo5SmtDh6lQfHRsYzcQX2JI=
X-Received: by 2002:a2e:5152:0:b0:30b:9793:c1f6 with SMTP id
 38308e7fff4ca-30d727b90d4mr70615511fa.17.1742851040590; Mon, 24 Mar 2025
 14:17:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317-ptr-as-ptr-v5-0-5b5f21fa230a@gmail.com>
 <D8ORTXSUTKGL.1KOJAGBM8F8TN@proton.me> <CAJ-ks9n-z0SETz+zBfJmda6Q_vJDeM2jmDXx48xX9qpMmR-mdQ@mail.gmail.com>
In-Reply-To: <CAJ-ks9n-z0SETz+zBfJmda6Q_vJDeM2jmDXx48xX9qpMmR-mdQ@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 24 Mar 2025 17:16:44 -0400
X-Gm-Features: AQ5f1JrYruUbmO7kdKShDjP9Q62aedchRve93iCWOuc9o-zH3uTyfNH-6OBBv78
Message-ID: <CAJ-ks9=sGRYAEs4eBCqwHPTvfL6Fa4_3fcrXCohHp6PsJsM1Fw@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] rust: reduce pointer casts, enable related lints
To: Benno Lossin <benno.lossin@proton.me>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
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

On Mon, Mar 24, 2025 at 4:55=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> On Mon, Mar 24, 2025 at 4:16=E2=80=AFPM Benno Lossin <benno.lossin@proton=
.me> wrote:
> >
> > On Mon Mar 17, 2025 at 3:23 PM CET, Tamir Duberstein wrote:
> > > This started with a patch that enabled `clippy::ptr_as_ptr`. Benno
> > > Lossin suggested I also look into `clippy::ptr_cast_constness` and I
> > > discovered `clippy::as_ptr_cast_mut`. This series now enables all 3
> > > lints. It also enables `clippy::as_underscore` which ensures other
> > > pointer casts weren't missed. The first commit reduces the need for
> > > pointer casts and is shared with another series[1].
> > >
> > > The final patch also enables pointer provenance lints and fixes
> > > violations. See that commit message for details. The build system
> > > portion of that commit is pretty messy but I couldn't find a better w=
ay
> > > to convincingly ensure that these lints were applied globally.
> > > Suggestions would be very welcome.
> >
> > I applied the patches to v6.14-rc7 and did a quick pass with

So I rebased this on rust-next and fixed a few more instances (in
addition to enabling the extra lint), but I realized that rust-next is
still based on v6.14-rc5. I think we're going to have the same problem
here as in the &raw series; either Miguel is going to have to apply
fixups when picking these patches, or we have to split the fixes out
from the lints and land it over several cycles. Thoughts?

