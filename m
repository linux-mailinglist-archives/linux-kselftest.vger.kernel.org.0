Return-Path: <linux-kselftest+bounces-33928-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F35AC6711
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 12:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 314594E3984
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 10:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AD527991E;
	Wed, 28 May 2025 10:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B5eSM2ys"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BF9214229
	for <linux-kselftest@vger.kernel.org>; Wed, 28 May 2025 10:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748428597; cv=none; b=THKQ766GzP8YG/3YlnJenEpHZYobIuy7oUsrtKez3lbgujqmG0sWmNH3SJKLyeHUYtTI6XsfF+j5gTBraz3cnqKxfZuc+mXVdR9043gYAnANG006AVwdCgx/TQd2GGuHRQih79b5QNFE3YQ0E9DhavFz4VgbvQUgqSYmEVAMD6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748428597; c=relaxed/simple;
	bh=Si1j6uouuZRKixZgcv6BHoJXWodMnlY2oC/q9yWhRtM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pC533zs9iHDHy+6qD5Ypj7cc6TkAQgLCEnQfeG/cwx3N/cI0KO5xQlLzD7Ko+khM6GkNecx2e02q129/MXyCi0vLJDC3wwWtGSXHktBX2UeE/TFZZkLCX4Wo+VzMOFyzLuccZ07+sExCr06A8yKLXJu6Ra4Rut2KDXwzHyHorf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B5eSM2ys; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43d4d15058dso32373785e9.0
        for <linux-kselftest@vger.kernel.org>; Wed, 28 May 2025 03:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748428594; x=1749033394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Si1j6uouuZRKixZgcv6BHoJXWodMnlY2oC/q9yWhRtM=;
        b=B5eSM2ys+lzU9jsSKW8f2NVwNe8eM8+bJ9Ksg0qLUykjwmdFPweLQsA2/kF+LfbdR8
         EsIc+idddvAhVYGr1+sUwYD72Xxq4Phgts9qUcpqLWH+zBunCLT3mtJRvorYWaH269ia
         76WYrmuuTpaSXQ8kuLwNcE2+uzJ/VTMxs1CwpmHEICrvEzUCg77IGhCE9EiXGSZf7oO6
         cdUa6gukkH8IQC4asmvi9L4vk+ZfJZwyoAAApzCpjJjmSJxvcZjnKFqxENnZ6YR8a/4u
         CwEEY+jVnVwEYzBGXymd/EtIjY0b5Fek0EzcpNvaUSIVlrGx5DPowZVn1EwrZkjzaW1r
         Tgbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748428594; x=1749033394;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Si1j6uouuZRKixZgcv6BHoJXWodMnlY2oC/q9yWhRtM=;
        b=D0x1WBXo1fsfAHKNSgCikVwAM7XA2m7seP4IRDuc6tMwSAxak6zTGljMIOLRAkhvbo
         pqWdhdkq8qjqaHTaJ2BMG/XcusQ07RydwlnNTOYeTKYLbjbv+2ItYDo/cSJlNmaf1JVA
         kxKeTmZ4kSrbIDTrg2IIwhgind0WONyzPBZhcQkEn4DCu0A2EJBR9ECdqJW77yu3W67P
         LO/dkODxbNH4ALgIFv45QRJSYKwtax6oDWs7WDDkr4xe/CC2EvFHzXWdptCAPhSbs/2l
         ZHpJC7ai5euuM3a1O/Qe3d6mOiIGI44SklLblWm83abnsm5JFh7wpqdq0jNMdVm71zZh
         El3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWevExBSG7vuTHP6Y/qlX9eHp5SQQpEhaCg1acLFdvMxa1BogK/OMLO+uuEGyNi5wvD0TX5d9y+wYGI3VEn/WM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKrFs7brvYaO2rlKft2Z2VMIcMxD5pz0Jx/3vWIgX1VJn+nSEh
	SjC8M6uINI6skfelmEjSzT3LBxJJyXRad/MA7UZdNzLyZseh10qH/puD50+5kCRSxYkX1xJG/eG
	p1QvP+uLvI62BZ9a87A==
X-Google-Smtp-Source: AGHT+IHiPY375iu6n+ZkU8ZC6vWYnO6vfkfIsES083JMYvmdbEogAqIJfVfK9XDvKlL1n6CsZmK6dlKKd2C91Us=
X-Received: from wmbhc21.prod.google.com ([2002:a05:600c:8715:b0:442:f984:ed5e])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a13:b0:43d:160:cd9e with SMTP id 5b1f17b1804b1-44c91fbb448mr159783095e9.17.1748428594079;
 Wed, 28 May 2025 03:36:34 -0700 (PDT)
Date: Wed, 28 May 2025 10:36:31 +0000
In-Reply-To: <CAJ-ks9nd6_iGK+ie-f+F0x4kwpyEGJ-kQiQGt-ffdbVN5S6kOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250524-cstr-core-v10-0-6412a94d9d75@gmail.com>
 <20250524-cstr-core-v10-4-6412a94d9d75@gmail.com> <DA66NJXU86M4.1HU12P6E79JLO@kernel.org>
 <CAJ-ks9nd6_iGK+ie-f+F0x4kwpyEGJ-kQiQGt-ffdbVN5S6kOg@mail.gmail.com>
Message-ID: <aDbnLzPIGiAZISOq@google.com>
Subject: Re: [PATCH v10 4/5] rust: replace `kernel::c_str!` with C-Strings
From: Alice Ryhl <aliceryhl@google.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Benno Lossin <lossin@kernel.org>, Michal Rostecki <vadorovsky@protonmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	Danilo Krummrich <dakr@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>, 
	"Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=" <kwilczynski@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, dri-devel@lists.freedesktop.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, llvm@lists.linux.dev, 
	linux-pci@vger.kernel.org, nouveau@lists.freedesktop.org, 
	linux-block@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 06:29:46PM -0400, Tamir Duberstein wrote:
> On Mon, May 26, 2025 at 11:04=E2=80=AFAM Benno Lossin <lossin@kernel.org>=
 wrote:
> >
> > On Sat May 24, 2025 at 10:33 PM CEST, Tamir Duberstein wrote:
> > > +macro_rules! c_str_avoid_literals {
> >
> > I don't like this name, how about `concat_to_c_str` or
> > `concat_with_nul`?
> >
> > This macro also is useful from macros that have a normal string literal=
,
> > but can't turn it into a `c""` one.
>=20
> Uh, can you give an example? I'm not attached to the name.

I also think it should be renamed. Right now it sounds like it creates a
c string while avoiding literals in the input ... whatever that means. I
like Benno's suggestions, but str_to_cstr! could also work?

Alice

