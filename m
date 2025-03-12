Return-Path: <linux-kselftest+bounces-28817-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CA7A5DFF8
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 16:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0E2B3AA2F3
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 15:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D372528F0;
	Wed, 12 Mar 2025 15:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0ahZ7kK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE102033A;
	Wed, 12 Mar 2025 15:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792525; cv=none; b=SzuzIX4WFV0n/0cOydWOd42xgjV742LHfZWFwWE/LO7ptMuqi0VwFjMsODjHfh4QIjBWwq/49LIieBo7F0VHngh2isxmZkKspwaEUAl3zIqf+4v/hSgCKgpd087e9nuFE9LzJ6vYZq7jcoLCx5yHPVQXHhjKL1K7PHjf9LQ4Sco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792525; c=relaxed/simple;
	bh=hpaqk/mv5DwZSNPdqzf55YEfwuTPk3Nl7bhiup4Kq9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oDXlk/BX445B6mo4dVXO69yW9bRPf8HEFCp6ZvzSjXQG3ea/ZLt2qtvGvvfE2N/uGR4kqg+DuEgy4iYMuyaNWRIbGLD6hHbwkjvoiQr4mELJ44MoYoFSMq41rBKzlJe3fIcd5e+vxjF4bjrIyYmlFYWPxbSoPDlssMXaySXqg2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0ahZ7kK; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ab771575040so194773766b.1;
        Wed, 12 Mar 2025 08:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741792521; x=1742397321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpaqk/mv5DwZSNPdqzf55YEfwuTPk3Nl7bhiup4Kq9U=;
        b=f0ahZ7kK5S6KzBf9u6/QlK18CD9VNTFO3V1lHhPWE9Mqdw6iT5olGpYTjgGFhVTdgI
         mXSBGkW0ZFfr1udVLHj18ugqY6equPtoa7NLbAfM36OvpGh+Q14Q1EGLlHgXHa1oyeNe
         HZzQC0OPgw/I3PLR6M8q7gDvRPrCMNoyssKHb6tPxc1jrPzGr9bY8mfp5fO6qyQ5h5vJ
         seRO/9DHM7cP38U+csHc+Iwdc2MS5Cr2Hm+vWzdoB3gpTsIcfBEURtPnflMkJLspoq/u
         2+QbXi3hGyt+lN32oR2NmyJNZus+MN1v9CC0I4jGmefZb7f6GlSz3oYvyMUpGPYeUWo/
         n54A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741792521; x=1742397321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hpaqk/mv5DwZSNPdqzf55YEfwuTPk3Nl7bhiup4Kq9U=;
        b=poorYizJ3oomh3/iFttxpPTelossY9Rc2ZnkGZTEXtze9QMclxSAEKbwb9jJR8VKjd
         JOzakORL+ombXiHYdB6GQdQ+SH1Ggo+vlZAnodLXEgVJ+kPAlDk6AQgdX6KnmhT+DHOT
         A6BCfWqJDqBJoSf1XybnQVY97RMCZIxcDtjjtpeu4GClU0G4KpuRgWCRjoAE1CUS/Nlt
         iKV/+TV61TU4G7UKQFQe+kHYYrJ5nQKyrir+PLyg2RLSEl9wMIy5y2+VCDYKTWZDMtXZ
         ZZiOl6+Ow3ZZ3w57jb90zJEuIh/jUOJj++47ZQqimKNmYSmkG3sVZEusNvNy2UysWsBl
         XqVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCy+3nj4EgtcladOLm9SMMRqmN1G5zNfHJVYMaBeUiVYtHAeCLulfqRhpBj93NcEfHTEkOvvM+6XNy0JA=@vger.kernel.org, AJvYcCUkRYjNjsqQW/qm3PkVvH+89FEtYaz1Oj/JiOoSEYMS4wkEmXMToARGmbQVil7nVoK0drczLAJAe52ZXfzVbPfa@vger.kernel.org, AJvYcCV8dnVdVE+cKXZBF6vEnfGHOfPrER4xJaEMoPgjBYW7O74i0tK0YTI3CkJhDG8nSi57fDutCtpn2/cd5LHU@vger.kernel.org, AJvYcCVuBmlEZQNQ3TR27QZ3IPq+AltDstyQvDjuvRrBQH88rsd6TxdOdIKqL4PVQzgtr8wlMThH8G72xVQRRNvFvk0=@vger.kernel.org, AJvYcCVvuzl3AZ5MdS4qt7oMznGQMwTEkcpfMBIgwhZvnoYTW/s78J7QYvLG/2tJy4yGMXiFaLoRcHDEPgcC@vger.kernel.org, AJvYcCWdde7pvAi97xQLOXOT4qdVCOe2xQe4nCyEblTfi6yIXHEf3nNgE5w1CSIZ81dFMWMnL9CoF2bD+EaT7cgl@vger.kernel.org, AJvYcCWqPQGIwJPzp7jyJS+CukuXQO+WPTsfDr5RD8xvFwlw1t/fobmPRGL/OTHFXFQx+zcnRfmU74dHIt8L@vger.kernel.org
X-Gm-Message-State: AOJu0YzxQKGoMkMwwh3/WR4EZNBg+V71ugiDchEnBNi6mHExQuyLcDMN
	9WXiAYKWvr+hwrHS/FUhX2L9XzMs0qvdgCypHwFevm6Z04F9NhXzXe+MNTX0ruDDIDg8ryYk0nS
	7Yd/2f5i14I8jEVgjudgQNRXvLJI=
X-Gm-Gg: ASbGncsO/Z7VOhU6B8E5sUeQbLXDCBlmJki+MDCtOvyNKfi7MRAjVOwGJlHCH79zv9r
	JZA+vHEoLEqBvLhceGeAeHzyOjRrl6fUX88nwzImLng9GrbzVSVU2nKgCBkm9OpO0QA2rI5OJSR
	BPfXczZCaEum7zm/coz6sIk8bX+rpDMPPkAg2VTPe2T+/RydQeK18n
X-Google-Smtp-Source: AGHT+IEFGd7mK4Li8TNUFe5FZ0MgyqeFFzWpydtDcZDosaBLlGopNXJ0CCqcHG7pgKwL4DbIlWheHV38Fzl4uQQfBGE=
X-Received: by 2002:a17:907:c281:b0:ac1:ecb0:ca98 with SMTP id
 a640c23a62f3a-ac2ba594609mr995480166b.26.1741792520988; Wed, 12 Mar 2025
 08:15:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309-ptr-as-ptr-v2-0-25d60ad922b7@gmail.com> <D8EDQLZPDO48.1FXHY80CWMXJ1@proton.me>
In-Reply-To: <D8EDQLZPDO48.1FXHY80CWMXJ1@proton.me>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 12 Mar 2025 11:14:43 -0400
X-Gm-Features: AQ5f1Jrdezm1_wMFu_4E7ztbLfaX1edIJ5DfWceD0p8CBcScOzZTe2F44JuU1pA
Message-ID: <CAJ-ks9=dnmc=MBobXQq7YgpbiqozONvvnT4HBqtHkhW2FDA=oA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] rust: reduce pointer casts, enable related lints
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

On Wed, Mar 12, 2025 at 11:07=E2=80=AFAM Benno Lossin <benno.lossin@proton.=
me> wrote:
>
> Hi Tamir,
>
> On Sun Mar 9, 2025 at 5:00 PM CET, Tamir Duberstein wrote:
> > This started with a patch that enabled `clippy::ptr_as_ptr`. Benno
> > Lossin suggested I also look into `clippy::ptr_cast_constness` and I
> > discovered `clippy::as_ptr_cast_mut`. This series now enables all 3
> > lints. It also enables `clippy::as_underscore` which ensures other
> > pointer casts weren't missed. The first commit reduces the need for
> > pointer casts and is shared with another series[1].
> >
> > Link: https://lore.kernel.org/all/20250307-no-offset-v1-0-0c728f63b69c@=
gmail.com/ [1]
> >
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
>
> Thanks for this series! Did you encounter any instances of `$val as $ty`
> where you couldn't convert them due to unsizing? I remember that we had
> some cases back then (maybe Alice remembers them too?). If not then no
> worries :)

I didn't :)

Thank you for the reviews!

