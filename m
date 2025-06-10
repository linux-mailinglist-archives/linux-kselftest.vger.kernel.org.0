Return-Path: <linux-kselftest+bounces-34591-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B67D8AD3AE5
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 16:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 614FB1899238
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 14:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91B027AC54;
	Tue, 10 Jun 2025 14:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8UlAxUx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B5142A8B;
	Tue, 10 Jun 2025 14:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749564870; cv=none; b=YvAt46+FQBKuqe+058Jr8jpjVkD8SD/yEZtgZwsTnZy1ct7+DT3Oqe70FOWYg5XGVdZ636dPBgCab7RAg84oyUEB7L0vzcUMBis22yRryzzEDK1RMBaDL+VJ4svi3FGddjEkPL+cG9nR9dAOgv51QE73ELEU+At2l4qtMxrSGDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749564870; c=relaxed/simple;
	bh=sPd2q1kJbN8qnD3LntQitJqqVFUiNmhSJ4fKZSeUThU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=srPMpNtA7DIJbNU/zAWgJ0beYInB2PhBpgyeB85neD1IYuZldM6CZD1380QFqrxyEOGbsI622Zo8h5IZPWYaswZaa4SMARllkZ3GTUKm7HhCpJo5O48F9jMKVgLA0XbAb1G+l735fxveVI36GQQ0tl7WU8w8ggLnjX0bec7DFa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8UlAxUx; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-32ac52f78c1so55855131fa.3;
        Tue, 10 Jun 2025 07:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749564867; x=1750169667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vuMEGKtcKU7mmxYrWQc80Di8yLcBsgrY66zcTsKw9jA=;
        b=g8UlAxUxrXM4AsYNAA8aOhoRbCxuPAcvCUC28HKuwkE5XUq08VNP9dvqgVwhtcEWyF
         zImAtUEH2m+Oo5fbH0p+wEThiQLtpBaGv1O9ph6wTEEbi8znOkBRu+hBcrhcPyxD6FBd
         4IJGpQlRSjS71G3y0qrH35W3VUfZAsOh6VK4G70zAHIo25l8nbOWvo2e+L32ZMZwLxwB
         Saq40EEuYgdPN3v2IvOV41NohXG/hbOZ4jl5BAARzhD5phxSkZYFDdADlijxm4n4Y9US
         VOxh0MtBzTAJUGmj39Yh0q7ja4T3xXKjg1sLY53lOnovViJ/1jcG4P1yH2wVgYLGjR2Q
         j6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749564867; x=1750169667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vuMEGKtcKU7mmxYrWQc80Di8yLcBsgrY66zcTsKw9jA=;
        b=bQZ4Pv4k7RmBSHz1JgVDtM6uWuCLZ0mfzlb+WaZCMfWaiqZn9tMlK8ZcuuZ3BVesC6
         VRPJ+KvRut1ZllExL20oPdUBc5gxnxWJSgYKfgW1yf0P70QAnBI9UEVOvEa/53qPN19M
         HS+SLad50/QEEnn8PO/9PrV4wi5OrBhqbOesfhRn/FMx3kM2ujFNRrp3xzOXXJBB/pEM
         5BWsdr5qOe47NZjsaGypzOag5k7LjypRbOoufzpirFup0Ds3yrul+wMGQYw8EijQRV4x
         xGis3Dzlt+9XRuStwM0q1otaWeg6KR3gxyLFqs+pu9oeu6gFZh2qQqUrx32A7P/mM1/e
         umtw==
X-Forwarded-Encrypted: i=1; AJvYcCUHna4Pr6LqCVGR+P1y+VkJzgc8mhb55I4pkBxVxbzswb0oBvh1Hbc80C9ZjR2kUzIWZclWY8bbtYvte/U=@vger.kernel.org, AJvYcCVoWOpO9aR3ZGm1CTPC6heKUjwmotd4oFYipiKV+RmcrkH0TOUZnKrO8moaY7wldJ7Ryl7vgmIf@vger.kernel.org, AJvYcCWsxhbz4rSi4lxorsfztj2LXoju7Z4ARj06D0/xhVZfrBEvAPytokcmor46xh9oNCy28lUN59GKlhgO@vger.kernel.org, AJvYcCX0miSQcONPypmRY0DYXZRCcac3ZQsjScNUVFATHFkku5FLu2gWC8SBEt1L/S2mbKfvdPsNU8Il5ujSTYEfhTU=@vger.kernel.org, AJvYcCXKhBKzxZLJ5ar1LwR1FLQWKM3+i22C7QFNjM6+Nw7z1rVeCWB1cADuOb0LWvqvQ1HkoiECmDQfLrmf@vger.kernel.org, AJvYcCXNw9qqJ9xrIbNYR30U0L2mwGU9KYPDRXXSJJzY1btWsC0FDVK9gVIY6ysoJ65B0tCUrje0iPTBSg8BXJPp@vger.kernel.org, AJvYcCXQ+nBdjDmbhD7bxfYB32xvFQHL5CXV5/hLY/VcKx8DUfKsAFgS1r1EPBal0lWXseaH6HZ1/u+z6Dn/icP+@vger.kernel.org, AJvYcCXv+VaQoxkq9k6+VmkXcKXwuULAQhe6IG6/zc+2MOpH0FLvODcTo1lJ6mnIJ590eGaeunbIewbdLTqD4tNtry87@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh9fyHduOEO/xYcSna2NypfHSg3eCUZVoSn7jl6yJLhnUnidT8
	gUrrBg9M5izryLwge1HKF7OXZxAwF1duBMegLL560D/fnFKtLXbmeG0M9THgL76iGr7KIh6ef3e
	DyeicIQKT7iL6liO+oZg5CqzBQPHvxiQ=
X-Gm-Gg: ASbGncu1NsWIngkWysdKWPmXIgwAxni+ocAXc+pHvae1QQ6l+NNatw2wcxUIOmo7X1u
	ok3btoL2x7XqQXdLKsf/L70wyxsFETcnFwODB+2XniwQKLD5hntt3HtoDm2kCRYAsDF/CKITQ/c
	yKBv6dbl59AeaHt1ALQDmwDsnCEmumnPUykGqR65IdOPku0i6iIcGa7WoMdRs=
X-Google-Smtp-Source: AGHT+IFs+FOaKv26OTPjKCXkGEVIsKYLeIeoc9L5o7yKIFbtvD9PHVbw58XaSCpX4CNs2yC2qsatn7XHITlBY36o8SI=
X-Received: by 2002:a05:651c:19a2:b0:32a:6b16:3a27 with SMTP id
 38308e7fff4ca-32adfe1dbf3mr46462091fa.35.1749564866581; Tue, 10 Jun 2025
 07:14:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418-ptr-as-ptr-v10-0-3d63d27907aa@gmail.com>
 <20250418-ptr-as-ptr-v10-4-3d63d27907aa@gmail.com> <CANiq72kWtEsXDuoXpbTNRLiZ=c==Ne=v4igxCWMwWFj0LOC-Yw@mail.gmail.com>
In-Reply-To: <CANiq72kWtEsXDuoXpbTNRLiZ=c==Ne=v4igxCWMwWFj0LOC-Yw@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 10 Jun 2025 10:13:50 -0400
X-Gm-Features: AX0GCFuew5JuDEc_jx48ZSACU5BVvcLvpbd6GdnUaVlDV59_UtgyTusAE2HFbXQ
Message-ID: <CAJ-ks9ny_VNvKM-w04kkk4Yw=UpYEt82TyFZZuXEFK=DxfwcgQ@mail.gmail.com>
Subject: Re: [PATCH v10 4/6] rust: enable `clippy::as_underscore` lint
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Robin Murphy <robin.murphy@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, 
	linux-block@vger.kernel.org, devicetree@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 8, 2025 at 5:06=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Fri, Apr 18, 2025 at 5:37=E2=80=AFPM Tamir Duberstein <tamird@gmail.co=
m> wrote:
> >
> > -            bindings::BLK_STS_OK as _
> > +            bindings::BLK_STS_OK as u8
>
> > -        unsafe { bindings::blk_mq_end_request(request_ptr, bindings::B=
LK_STS_OK as _) };
> > +        unsafe { bindings::blk_mq_end_request(request_ptr, bindings::B=
LK_STS_OK as u8) };
>
> For these two: `BLK_STS_OK` was discussed in a previous version, but
> why are we not using `blk_status_t` type instead?
>
> We are even already using it in the first case, and in the second it
> is the parameter's type.
>
> > -/// # use kernel::{bindings, c_str, device::Device, devres::Devres, io=
::{Io, IoRaw}};
> > +/// # use kernel::{bindings, c_str, device::Device, devres::Devres, ff=
i::c_void, io::{Io, IoRaw}};
>
> For v11 this can be removed since it is now in the prelude. There may
> others that can be removed too (I would not add an import just to use
> it in these patches, but if the prelude is already imported, then we
> should use it).
>
> > -        result.minor =3D bindings::MISC_DYNAMIC_MINOR as _;
> > +        result.minor =3D bindings::MISC_DYNAMIC_MINOR as i32;
>
> Similarly here, shouldn't we use `c_int`?
>
> i.e. it is the one in the C side, not the "resolved" `i32` that the
> compiler suggests.
>
> > -                    bindings::wq_misc_consts_WORK_CPU_UNBOUND as _,
> > +                    bindings::wq_misc_consts_WORK_CPU_UNBOUND as i32,
>
> Similarly, this should probably be `c_int` since that is the
> parameter's type, right?

Yeah, I think these are good calls - I'll fix it in v11. When would
you like me to send it?

