Return-Path: <linux-kselftest+bounces-35585-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4F6AE32E6
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 00:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69CEC16F3C5
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Jun 2025 22:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41D51F8908;
	Sun, 22 Jun 2025 22:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z24MCgov"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4489C1A23AD;
	Sun, 22 Jun 2025 22:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750632648; cv=none; b=M0Arz5Bbp6imEMdsUYbXnn6sz+S+q36Uy8U9leyy+ZCJ1aaWXVEZERiwovc7R1CNErCGRmQ6Gaf4LRZ4vRwLdS3CSfg/S6XNI71/mB3JYZC8M7zqg3YZNcj+KUiuQw+TfCVmISIh5e7mCL1ae3s6iWxomgwdSDian13GqExD1CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750632648; c=relaxed/simple;
	bh=wHATzHUwOUqRKn8FAzkIwW1jHvvvptGIND35VrXnmho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P72Any4WIK4YBuExuB5gNVk43vGc4O3aKCqi0XbzJC+EYY3KjAzq/ZRqp3aXsyPFhYE2Ro8AWa9/2rNfdaXksG9JNiSFq3i2WOk1zBIs+8QpYHTZtXFu4JqOd2e5XL0DBuGNwoTtqsx/4EUYqi97gE9Bx5irUHuAPBPAKZkyPt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z24MCgov; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-313fab41fd5so362917a91.1;
        Sun, 22 Jun 2025 15:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750632645; x=1751237445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XyaOPS+SVDJS2nuVakOU+h3pEZcqv0KxHASicqOHR0=;
        b=Z24MCgovbvwdu5n6jAqRkIfOw5jJCQh+oGKuaMUqMdBngf2wlsnuQWeLU66LmYDq2z
         6hw7k23vBiA2Y9WuCa2LHytHLhd9AjZCjDBYpLw/RNAwXGL5c2mSoHy9TiL+VM9waIWQ
         hDDjsBKeKgFNJCIAXkEATw409Ao0BZSGqcsTo+fFphI/QG5t+2oSD8pDGNin+K932gqC
         z/P5x7yi/CqYodSlDqqF2yruBkSdWLEqHmnkxIilqRicDH6SNM/tjvQEKaPEUmceIY6i
         fPISg5bChuNKbTM72LhZXi8DT/WNv8XICieRk96EMqb7/V5PU5R7oeMc5ckw1tm8No+q
         Ll+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750632645; x=1751237445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2XyaOPS+SVDJS2nuVakOU+h3pEZcqv0KxHASicqOHR0=;
        b=Yg7/oxQXPUcbQiJO0o35CqnlRRn8etlZslogx2PoB6trsSH9on4vh6dgHXtBiq6vbY
         Xj1IuRtczyoB7hPH9LYgRvGUw0jjj5vxPzily6IyQQT5F8DEc23nXXx3JNcij5InQP9B
         e5GwQQj6ZIu95g6vzlbZqaHFr4UX5FUNZ/mL6ObMimUpuGRZbZUU0Xy8ygQnVBjwKNZP
         g1Bk/9VyfUlkEdUeUjg7yWYj1EoODnYtF+ZG51v4l2DOqMX4Ke2OUYt3E33g8N8T1qsY
         4/Q/GhaeMC12g0BA7t52iB1T7N3EQnwuhzLSwRtOFQ3goroO+L60CDwrIxFr+AsWW2+h
         iiZg==
X-Forwarded-Encrypted: i=1; AJvYcCU/3qW77tmh1yrHZyZWo2xoTl1aKWR0X3VUOXrNNvD7MQ3UBWva+GjfOvgrN8q083j5J6XZam38U3Yq@vger.kernel.org, AJvYcCU9/aLQ6N3XtilWzy42Hl2kDaZfewDBjkBRXcUv6h/6K3U3K6cVUodVaxwkYel5zxmsirk4VDBjKkJBOjQ=@vger.kernel.org, AJvYcCUXkjfTbBqigvhBjPWJAyVoJeZL4CoZI/CzPkssHcgfMGObinklldaldxAkDcHVNbVWuW98Mk8Es4kWBgN9@vger.kernel.org, AJvYcCV6qWXGP9zRMjakK++6HjOOKcEW9Dk8BYH8Hj9kY0DHw3IMnLMAJZVJSybYfGRc3NVbQ92JIsJYVX6pMu/sTu/1@vger.kernel.org, AJvYcCVWwFnqkXP1G9F6rX5trqeDXF6UwKUTouONx9hHwoSQ1wW4wNtZ6BPoGURjFs6JvAj8GDiSWA50iWIkb/Es@vger.kernel.org, AJvYcCW2umB5Sr62u6StURP0ZDgjAr5gkVfvDh2IjIIIRuKj/ZTnk7FpQujXt2cw5GyDqpDeeNeYqFUyqfDU2b2xSJc=@vger.kernel.org, AJvYcCWdRCugot5CvTHpnyoUm7lIWYhVQeQfHiKvhtyjnfNM+wpLU46FqIExHB1rYi/QgIBMkhgt9nYViqw=@vger.kernel.org, AJvYcCWsn6WJszPgG5oopu5HeV9Uo43Gs/6uFI2WqmJkkpozh5BEa61aowbV0ZgsogMpcHoC8fvxIa2j@vger.kernel.org, AJvYcCWuflZVxkRW8bJKLega5V/K9Nk9Tx9mMfJHEa18k0ZQVPPxuI6Luef+K5nwxvU/cRtKYyf7GrowUOuK@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0by8/QbRy/n6Foebc+H8e7D18JjyY4F4w8bfu3VyYgFeNZTyq
	g72Oy0OvHD1cPzoy2igZbkt+l7iyFfiX1gIw17wwLcnEMzQ7JqruhEJSX6GO8H5nAhLtD1S01wj
	Pg8CSRgriwy14+OD6BCCSi7fO6aH6KHk=
X-Gm-Gg: ASbGnctKm2hQIZtlwxmlnN/lid4QSFMRQAdE/ddYLmW2Ky1GY5PaGYX6pji4qnzgXys
	kKCuDCpwvDBPfXMyrMtMCTcZgIOkGYsEaAae8jzSb7v4S/HBntsFwFY7NrCtXBxlc5fMvmYhn7I
	hvxOsKUqA3gvzn1VGky9UKhiPS68PZttkCQ65fYQ6s3Iwo0llWTk3Qdw==
X-Google-Smtp-Source: AGHT+IHkK5VxbDTzDH+78CGWNybiQ0lflBEpMpSVRH6uwkYDUKXtQuR/kJbEABJn7CeEMEkyXPjXtmArCfcPAjxsRNU=
X-Received: by 2002:a17:90b:3a43:b0:311:fde5:c4ae with SMTP id
 98e67ed59e1d1-3159d8e2be9mr5684021a91.6.1750632645432; Sun, 22 Jun 2025
 15:50:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250615-ptr-as-ptr-v12-0-f43b024581e8@gmail.com>
In-Reply-To: <20250615-ptr-as-ptr-v12-0-f43b024581e8@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 23 Jun 2025 00:50:31 +0200
X-Gm-Features: Ac12FXzAp4qUKl_aNT741tylL3I37tb5s--GlJccgcY1EV1oeXS1Teju6Ztan0w
Message-ID: <CANiq72=xmyHuBYEGbCMi=Um_NvNbf5TfMmJB5YPpVp41FcPdJA@mail.gmail.com>
Subject: Re: [PATCH v12 0/6] rust: reduce `as` casts, enable related lints
To: Tamir Duberstein <tamird@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Robin Murphy <robin.murphy@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Benno Lossin <lossin@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Breno Leitao <leitao@debian.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, 
	linux-block@vger.kernel.org, devicetree@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, linux-mm@kvack.org, 
	linux-pm@vger.kernel.org, nouveau@lists.freedesktop.org, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 15, 2025 at 10:55=E2=80=AFPM Tamir Duberstein <tamird@gmail.com=
> wrote:
>
> This started with a patch that enabled `clippy::ptr_as_ptr`. Benno
> Lossin suggested I also look into `clippy::ptr_cast_constness` and I
> discovered `clippy::as_ptr_cast_mut`. This series now enables all 3
> lints. It also enables `clippy::as_underscore` which ensures other
> pointer casts weren't missed.
>
> As a later addition, `clippy::cast_lossless` and `clippy::ref_as_ptr`
> are also enabled.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Applied to `rust-next` -- thanks everyone!

    [ Added `.cast()` for `opp`. - Miguel ]

    [ Changed `isize` to `c_long`. - Miguel ]

It would still be nice to get the couple remaining Acked-bys (happy to
rebase to apply them), but I feel we are in good shape, and it is a
good time to put it into linux-next so that people see the lint before
they start applying new code into their branches.

Cheers,
Miguel

