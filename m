Return-Path: <linux-kselftest+bounces-48129-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E33ABCF1018
	for <lists+linux-kselftest@lfdr.de>; Sun, 04 Jan 2026 14:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8500C300D65E
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Jan 2026 13:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D71A30E83B;
	Sun,  4 Jan 2026 13:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5OZTfMG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963381A2C11
	for <linux-kselftest@vger.kernel.org>; Sun,  4 Jan 2026 13:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767534022; cv=none; b=hnhGUbTk5gnYxcbHyXWo1fw1oKwY24j82jOR3Zm+x6K4rmpyeXTRqqynLA6XeWKrGFSTeBzrYQ+oP0V8CKlqHTZqbYRykfmCXdAoZWVVbtdnW+5LwEa/Y1kwKAqogenOhe0uae2zCNbjOwrjZqSRYk/nw1acWIDo08z2tf0Opa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767534022; c=relaxed/simple;
	bh=PxhnafdhUkoL7xs39CEOt903VzFLroguxsgbB0FJ5Dc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jz6rtuxK4sj4goLsoozeYqZxc2GIAZH0uZDLTTaQ4e5cqt/2MVnsvyPmThZdWXpAi0aakpSFPwmHSgirCfsYDkDjuUnHyg+YTggdGYFVGQLe20UUOYYR1aQAzYYmhseK4Y/uJNkpQmAf5ySkbmZfPvlnZuS8h3E27cZlOgq4Soo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5OZTfMG; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-37a3a4d3d53so124058131fa.3
        for <linux-kselftest@vger.kernel.org>; Sun, 04 Jan 2026 05:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767534018; x=1768138818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PxhnafdhUkoL7xs39CEOt903VzFLroguxsgbB0FJ5Dc=;
        b=f5OZTfMGFVWRHDACpgOK8Ax1DFbvD4QQsrXxSp4N2m5p1dVgQBpf/PNmZgP0eeHYKw
         6BQy1cm/6IHn1qyRRUfUazNcujHecZYGGsZnHpxUQZ6njyQXrlNxpBxU1KZp8vL8LuF/
         OvQHwvvfVTToolTVrr/s9orcsglzQ7TomLEq9j3wf5uGMVm9NKGQ7EoPEXet9n3NGrte
         2mt6TQ9TsoZdPvxWJes529zrA22BCf+uDPGomt+ZzexZPj64peDUZfqtyPHvRr2w8RTI
         WeAvfmMq4GoZ5ylO/OzwnZZi3e6svV3eEhw3oMrd+uf83ujxdDzaqnQODecn8Y4aio1J
         6dKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767534018; x=1768138818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PxhnafdhUkoL7xs39CEOt903VzFLroguxsgbB0FJ5Dc=;
        b=AYb7WShidw4jncMHYo4I7XlF+0rwGqlEIQEpqLaPbNJAZn7XYls92ocfkKFYJZyfhd
         S2/uswaZy5KYFHOqFib6mOmvU/aLI+JEZhnFNKByayy6rUi67PSXanjGxND0QILTI3tX
         4uluZwC//5lsWwGd1QNts6zUxI/19CmRJY0+Bk7T9ntlUgrKYBVt9xWGx/09ib+84v3y
         U4LkQQFIT93W4GyCY8Upfbrn/3ISvnrS3NeOV/xsz7LuoaJIsBq0TJ6oAFx2FtUscLR/
         x470fY0a7JDZ9pG1T1y6Piq0gP/6X1JnhmRRUFDdSGlf6+Zqv238ROcT9Ll7ksRYGlxN
         A8Pw==
X-Forwarded-Encrypted: i=1; AJvYcCXWzhtg++g5fUZzpKbp6yvunUByYLVOc2lznYfs2AWSQ3tR4dfw2DN5SsZqPqTRhGlKgelaQkXrAJ1Fd7eKMyk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz4OaJItscGmavaujxdp7vJFCiPCKT1SAxImiAOOH6UPnPKUDf
	j2j9iT86jn+LEf6F58hfoDyF6d0zbxJMbpjK0Dnh97aZY2UBcJz70bLOn+2JJwHTHajaGz2W4VO
	PRrlLXrHl41dqEEtrMUszUfTjrLBtf1g=
X-Gm-Gg: AY/fxX55pg2XRY0iqsYgfUlR7MTJj6UL7O4Usm6dLAIl9eS3WQt3mvnbROrx+ZGLteV
	4uKTHUgIvQQvLVZtH5puP5qChAbTDIbMzjvOn2gkIR4rNUt5e43XMb8IJl46i/bag3cliNK+idm
	j3fUrhkxIGwuEk/Ukaq5f4xIOy5P+4fLuwcOU30+vCNBfZ8NsfW2z1CrrZeT/I/eWJjtNv3Vo0t
	y2ElYlx12YiHaufF+s/hopQgOLt2nRe32yI+tDwbGoJmvlUUKz9IK6PhBJFf9n67gAF/AagSiNP
	qwbSFWkWMtIuMpqj3a2jg+QQ1fPzhuF6EC1ZSbxt6TBTh+4FimuZmoW+7Nv9J5mbI4HvEFxgmFL
	1kNiRT2jDrXftS20q/pPTDsSzp/26TvN/snseUcPECw==
X-Google-Smtp-Source: AGHT+IEbBB9vVZCX9s2Xya73C0YMR1yaHANMzVSX2SG6EOMN2EgG7mq5cYhnsniYCMMQ4mlIafFdcZHA4pK0y+I92ZU=
X-Received: by 2002:a05:651c:b23:b0:37a:5990:2ba8 with SMTP id
 38308e7fff4ca-3812161517dmr152767841fa.23.1767534017462; Sun, 04 Jan 2026
 05:40:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251211185805.2835633-1-gary@kernel.org> <20251211185805.2835633-3-gary@kernel.org>
 <DEZJOAT8ERZ5.34R3FCWWNF065@kernel.org>
In-Reply-To: <DEZJOAT8ERZ5.34R3FCWWNF065@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sun, 4 Jan 2026 08:39:41 -0500
X-Gm-Features: AQt7F2qVzPAZs4tIHaDG_ROmfVds8KB9z5J4NySN-dxo_RD5WIHqxR9vi_U-EnE
Message-ID: <CAJ-ks9mMnmf+KiMYigyRjnpvcvmRzA86GuDAKAcbQFu2YWt6ww@mail.gmail.com>
Subject: Re: [PATCH 02/11] rust: macros: use `quote!` from vendored crate
To: Benno Lossin <lossin@kernel.org>
Cc: Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <raemoar63@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Fiona Behrens <me@kloenk.dev>, Igor Korotin <igor.korotin.linux@gmail.com>, 
	=?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>, 
	Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 4:47=E2=80=AFAM Benno Lossin <lossin@kernel.org> wr=
ote:
>
> On Thu Dec 11, 2025 at 7:56 PM CET, Gary Guo wrote:
> > From: Gary Guo <gary@garyguo.net>
> >
> > With `quote` crate now vendored in the kernel, we can remove our custom
> > `quote!` macro implementation and just rely on that crate instead.
> >
> > The `quote` crate uses types from the `proc-macro2` library so we also
> > update to use that, and perform conversion in the top-level lib.rs.
> >
> > Signed-off-by: Gary Guo <gary@garyguo.net>
>
> Reviewed-by: Benno Lossin <lossin@kernel.org>

Reviewed-by: Tamir Duberstein <tamird@gmail.com>

