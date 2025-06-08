Return-Path: <linux-kselftest+bounces-34439-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DBEAD145C
	for <lists+linux-kselftest@lfdr.de>; Sun,  8 Jun 2025 23:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45BD716834C
	for <lists+linux-kselftest@lfdr.de>; Sun,  8 Jun 2025 21:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8052E254867;
	Sun,  8 Jun 2025 21:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5J7kCyN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D1F1D7E26;
	Sun,  8 Jun 2025 21:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749416809; cv=none; b=RJ337+asIAVq19Z6WH7KmMzVoUh14mIa0pLmyLUSmiY1lqwNB7kCkY75JiWeMmlz5LJIeGIFvH5/eaPptGSo0i4LI+p9nk1E1boA+GbeYyEa3zEk7eTbpFW6egzvcUjOpxuDcqPy8Wa5hNgPSr0Rs2VzQIx9HkO8/bx9mg+rluc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749416809; c=relaxed/simple;
	bh=eRXTMlFFM37HL8dqZWTxuAL+kEE86cK1FaotSq/A8As=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pdK9j+CDy3CbEWBj0YtY+kWVtAC8l/PsiF9DiPnukLZwDwMXSz78HnXV2LCFhx7MpMHLyswMg1w866k5yBoeV7wBa9HbNOMHi+emFPd14oRU9jkBXoLHd3GKfEDF2VaIu/yZRzSlWk7VVVr3F6LO/fUAyuUqh2m5+CzaQVjCFok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5J7kCyN; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-313290ea247so560414a91.3;
        Sun, 08 Jun 2025 14:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749416807; x=1750021607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=biTxWw1XUhzgVcSaJ7pNel53LmqsXpVkyjyl/XngF0Y=;
        b=P5J7kCyNWMQu0xC59DiFCqsYpdY7ehaiIi2a+f4rtg6KgEJo1XjON00G++xpQKBj1L
         OigQy0mwO6GNA2llYVZT+badovLEyOQ/CdbmxfOHkK/zv5oerjBMi51d5rn8EfRUp/Cq
         zrfIjUIuAVlTj7nQqyfCZntJcdWX56dX7GZTmNRgHYaaGpiQN8BnO43eMbtzd3B756is
         +hVz6Wyfx/MFVUwQMKZPkv++C9XqA9z7nP9ajVj493AWCzefiGIOL2dJNPJ2j+Xdt6v5
         pCRFGxdYltiq8Jpg1EgAAMz8sHmSSx/epp5oecqwdpHgHcz9E76LjFw/KJPDM5eztguv
         Npow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749416807; x=1750021607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=biTxWw1XUhzgVcSaJ7pNel53LmqsXpVkyjyl/XngF0Y=;
        b=bC8u8aCOTKJzgB1WuBHyfVfQPhuChzDkas8dIPbD2RW/I74wk35WZP1cI+P44zUEPw
         QTz/DXXqtiS9TE6sZqoK1M9Aa5dUCATyJK5GQHaqGg663vzdD13eS5dnjxE+q/gC5j5f
         2sy0Hg/RFuDqIKYYNTXW7x1VVEShBsgWubGMo1Jefd1rMq6Q5mbkvLUAEf4aEgP9S/EG
         VGBIdcwxlZOIhEYlPnXMvk50iuCAVK/95oIoYRzYXkBnPWHp4O2cAhNXp5pRrvU4c3O7
         4bZMsU7XrhReJoyxgZRkte1QXit/3zBFBMMBYbGjmC9Czc4PxVAb+xnIqseaH014xpvl
         xg/A==
X-Forwarded-Encrypted: i=1; AJvYcCVFxXc0oEn+5RpdPLl7RoxrlCXJ0SF5n0VIm89rClfYT1QJGX8KeAQ879p/E+fpGnUniz/TbzASj97F1K2I@vger.kernel.org, AJvYcCVL51OElPgxYwQLXuGEsfD9zgimufY4iKnX17/Pgfii+O+Ulp7GnyJTqLttXVdcu7NrceC9qj/SYdI0@vger.kernel.org, AJvYcCVQkztA4C53byBCSiSQYqeU7bR3hxVjftxt/CjNOI2A1KVLmgUvi5SWPWVPTkEjyqik0UI9IW6K9oG1XbBv9kJn@vger.kernel.org, AJvYcCVxeGg+0gMGIcRat0RSYpcjhB0GnVs2ST9pBMGRyT+NqfuUNl4/TClnOVsOLjlnZi9Guu/nNwsP3BBRj54j1tI=@vger.kernel.org, AJvYcCWQQEdG1nV02tGBLs+4q/KQwwD1s4BdJdOoIbmDZlWKEJdwIV3VuFJK9mcqY0XN/rd+hqQ21d0X@vger.kernel.org, AJvYcCWpm6/d0St9BDJ4YQVK+RKtWt0jzylERGCmPqlCD/tZ4Fz5uEbmn5zFVt5NtUmkyJBcAkCyDTUNaVBs@vger.kernel.org, AJvYcCX6rwlgOg7Ec5yTC2Fy+u/gJosU7heu6GV1+ve0KFsdgIwPySuxEvfB5lDZY9fWQvDAeHOBpeWPOElsxlqY@vger.kernel.org, AJvYcCXXHoEpMpMpYhZz0PuVa7P9Ncyzl2PI9eswXELu6/3T/VZHGtVgl/5X6XxbpRPOWo1fuFLDGtuRnZiQO+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YycS/x8gh1zUuTd6KPiJwuhGdxVsRLvdeWpkQZLV17QhzivHG7D
	+7EldevgueUn7PfABKNiDG8mTYpglFaKpVmcBBUC6tEBqsSxh82K/vN5AOXwFs7IE5mLmokumRl
	zS0LiC++bO+nJ8x+kXenjztieD6LXcNI=
X-Gm-Gg: ASbGncshQXbDcy5SN/52D7KL5+goHX4qvuDHKy4ICf1Rwnz4jr/Q49SuP1CeFPqabvY
	ubz2t/Oqiq+ROLuTjMETra4SoN5pi2jZ9PDqFRSdQjbZHq1G2yErlHVo4wQvhn7e42FVzFmMmCS
	tcOGP5m8MjyvFMmi5DdxBHjGKtVNna1hwcbiNRS/gORhw=
X-Google-Smtp-Source: AGHT+IFZoj5H78nminVpVR/Eh5MZKRu2FMUA3tOH8l/xEYd1B6AKUG5XkEb/S2u3ZweF07euOUkBTgoKB1wHH0vNBBM=
X-Received: by 2002:a17:90b:3a87:b0:312:db8:dbd3 with SMTP id
 98e67ed59e1d1-3134e422457mr4671636a91.6.1749416807159; Sun, 08 Jun 2025
 14:06:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418-ptr-as-ptr-v10-0-3d63d27907aa@gmail.com> <20250418-ptr-as-ptr-v10-4-3d63d27907aa@gmail.com>
In-Reply-To: <20250418-ptr-as-ptr-v10-4-3d63d27907aa@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 8 Jun 2025 23:06:34 +0200
X-Gm-Features: AX0GCFsmqnoEKQUFsySPfR-zWKNBdsKqanc84VNOHBrhPbLWWUXTYAKIeQekh14
Message-ID: <CANiq72kWtEsXDuoXpbTNRLiZ=c==Ne=v4igxCWMwWFj0LOC-Yw@mail.gmail.com>
Subject: Re: [PATCH v10 4/6] rust: enable `clippy::as_underscore` lint
To: Tamir Duberstein <tamird@gmail.com>
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

On Fri, Apr 18, 2025 at 5:37=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> -            bindings::BLK_STS_OK as _
> +            bindings::BLK_STS_OK as u8

> -        unsafe { bindings::blk_mq_end_request(request_ptr, bindings::BLK=
_STS_OK as _) };
> +        unsafe { bindings::blk_mq_end_request(request_ptr, bindings::BLK=
_STS_OK as u8) };

For these two: `BLK_STS_OK` was discussed in a previous version, but
why are we not using `blk_status_t` type instead?

We are even already using it in the first case, and in the second it
is the parameter's type.

> -/// # use kernel::{bindings, c_str, device::Device, devres::Devres, io::=
{Io, IoRaw}};
> +/// # use kernel::{bindings, c_str, device::Device, devres::Devres, ffi:=
:c_void, io::{Io, IoRaw}};

For v11 this can be removed since it is now in the prelude. There may
others that can be removed too (I would not add an import just to use
it in these patches, but if the prelude is already imported, then we
should use it).

> -        result.minor =3D bindings::MISC_DYNAMIC_MINOR as _;
> +        result.minor =3D bindings::MISC_DYNAMIC_MINOR as i32;

Similarly here, shouldn't we use `c_int`?

i.e. it is the one in the C side, not the "resolved" `i32` that the
compiler suggests.

> -                    bindings::wq_misc_consts_WORK_CPU_UNBOUND as _,
> +                    bindings::wq_misc_consts_WORK_CPU_UNBOUND as i32,

Similarly, this should probably be `c_int` since that is the
parameter's type, right?

Cheers,
Miguel

