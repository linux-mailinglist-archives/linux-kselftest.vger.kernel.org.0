Return-Path: <linux-kselftest+bounces-32292-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C55DAA8911
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 May 2025 21:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5285170F1B
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 May 2025 19:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4984D246791;
	Sun,  4 May 2025 19:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtKbcMN8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06A41A76DE;
	Sun,  4 May 2025 19:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746385348; cv=none; b=h/xGkDu975Fn/8gpIJ5sCqY4Ehf78YIr0oDowDV1BSAdeE6HoqgSrT8do6d9uI1LE2UUTYdEFk9ViIQYNPQKdtsmoJhRc6GnrkYROufrMKFqR5LoAWncLeZkJVTFiFuxCR0SGdSOjC9U9aAMRubDUZJNNoHFJ5/m3I/dcAm3yEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746385348; c=relaxed/simple;
	bh=gWhqncYnT79JitMZOxQNY9LoBk9q4Nc/oFC/nBl8/SQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qek6i9dXEQJpCBmOS9tBoOUl/tabUBf47CHjS8tO8zEOJAjstQnzkeVKQ1Va3ihVcZWVrRu8Jmn9gF75ruQ2ThjlLblydivMDqAMwioio9uU+kpZsCNQhjMgFX1cxDjZk/Cxn9mxrE02I//gXR23sngwl99O9XEqCtVVpQkPPSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QtKbcMN8; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-309f26c68b8so374266a91.2;
        Sun, 04 May 2025 12:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746385346; x=1746990146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gWhqncYnT79JitMZOxQNY9LoBk9q4Nc/oFC/nBl8/SQ=;
        b=QtKbcMN8bWAkYgu1OJYH36E/J7ZZUVTwLUwoRlQyy8iMFo84jXh+LPUTLnXb9Nfv7Q
         Wyq7C6I1oBTHp6+3oAb5ad0cqo/ms/QNnwDxsuxiDzreP87y/6pQmo9JKTlB9r5fJGvy
         rgqb7dhrNpy0xhqEiV2M6YqhNYu3l1n6XLuphurklOQZSvxWjkhHXGLRUrQStWLmiTgL
         y0X5pVOAJPbh00kCmm4TKeAzdH2+1mUP3DGsoCBZH2TPkdjpslf8oznfU+8zyRYY9CC9
         oE4sxhskVMdPFGZC0vn5SKEHnxcsIk5/NnDLT8+fpwMiluPSWP88NkkwOX4G57wxxNZW
         WOOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746385346; x=1746990146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gWhqncYnT79JitMZOxQNY9LoBk9q4Nc/oFC/nBl8/SQ=;
        b=VQl9vzPl7B2yZv/1iFibZG79GbQZWCMC8uEWkIWf1D79D8ZzLj2juYJFf+926VJpRl
         ZVBlx978C86hWF7sZEOOy1/ZIeTLyhpgH8F9p0q761RFsDltrGxI7zfbxCC31yAcSG0z
         9Xqf5Wil22z3FgZEyYb26a15DvXhHMgLP93acE21x6uoFm6N1TBqn8hcgKLkyml5vC1V
         OmjSYsUShLGUPKRaqlUjHvOLK24orqLG5rfIL+4w6o9hfK6GmHcHr5cbXaC+93zSdglu
         eIFnEAm2bslZI6kTDQ9y0D1TV5czg7Qw8r7THG7nkljW0CS7qugvqbxDuS4m/GWoGB2d
         oH0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUWzbvjWcNJxNPMy2CqAersfpzljOYMSvYxQuANEz+qJRQjX3Yay1l09oJPw1Rz0FK09AHo0q4Oky6F2UOB0LMS@vger.kernel.org, AJvYcCWCMv8cRZf0tSI0ymhb7Nx2mnLH8xUd0w7e1WSrusT412gbOIb+BbcVhEbrhaX6N+e5d+ScJ49lJimvFVg=@vger.kernel.org, AJvYcCWwiwRi0rxuoQGD3fo5lXXIM03QjgEkH7W04Zk1CnfqaMmy4v5hdLLyYjwQOEUWMs/SWgXZAUlbHq/R6IqJDVU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz31+gtjaWIkBIpSPNv5Iy2yb2se7HFIb8n0gLEVmGLXOKwqUFg
	QfK4DUoJNk+CQqV/ztaR1VCGjhjSI/RYJ+PtbvZrjW2hUOi8LPVvycRXI2OE0HuKo7ALZXwxzia
	HZpybDK67LBXaXEU4Pxw5wmCUJ14=
X-Gm-Gg: ASbGncsaLWFzheNJ7zw5GHnr7sKSi9JRLT5ylKpoMlLc4uw0S/aHW/rFHi8nTQeFte3
	dveeSxia7qAsByjLIzUKqEId5J/818tOVlcoS6k6p8fABRPQ6KrTkLjVLxy7NwHQs5Eyb0w3MUi
	dLNGEIJCCwQg7LvvgrsrA3uA==
X-Google-Smtp-Source: AGHT+IEO0raa8GkuuUNuEp7ZNefeofLseoaoOs06qtWnnjKYQ6iOYJix1qXEG05SOHHwbs5jqIqPiXaFuIPCWJpZQIU=
X-Received: by 2002:a17:90b:4b49:b0:2ff:4b7a:f0a4 with SMTP id
 98e67ed59e1d1-30a4e6c0e69mr5864090a91.3.1746385345937; Sun, 04 May 2025
 12:02:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502215133.1923676-1-ojeda@kernel.org> <20250502215133.1923676-5-ojeda@kernel.org>
 <CAJ-ks9k=uxxumgEU84-54u8OxxJVBsUprGk7Ht31ndoumHB95w@mail.gmail.com>
 <CANiq72=Q_Vbfh6YhDsNeCBDPZ-q1d2HNfaTj4azAsd2Q-zPfEw@mail.gmail.com> <CAJ-ks9mAgR3N+cxL6H5XhAN-iWM=T66vuWr=LEozj8bqofBf6g@mail.gmail.com>
In-Reply-To: <CAJ-ks9mAgR3N+cxL6H5XhAN-iWM=T66vuWr=LEozj8bqofBf6g@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 4 May 2025 21:02:11 +0200
X-Gm-Features: ATxdqUHa3BzmXCDKf-vPiiRQBie8yaB_bY4-x1_F18HdvVt9ZxcHIW-X1fAPluM
Message-ID: <CANiq72nQeHpZFk3KYGsgGO0Sh2TgV8T2z7Pahkijrgd=T64KYQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] rust: str: convert `rusttest` tests into KUnit
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, Rae Moar <rmoar@google.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 4, 2025 at 8:39=E2=80=AFPM Tamir Duberstein <tamird@gmail.com> =
wrote:
>
> One example is https://github.com/torvalds/linux/blob/59c9ab3e8cc7f56cd65=
608f6e938b5ae96eb9cd2/tools/testing/radix-tree/xarray.c.
>
> It might be that these are necessary because the xarray tests don't
> use kunit, and so are pretty inconvenient to run. As you might have
> guessed, I discovered these host tests when my patch porting the
> xarray tests to kunit broke the host-side build :(

It can be useful to have some tests as independent userspace things
(i.e. outside KUnit-UML) to use other tooling on it, but I think for
such cases we would want to have a way to use the tests from userspace
without having to remove them from being KUnit tests too, since we
definitely want to test them in the actual kernel too.

David et al. can probably tell us more context, e.g. I may be missing
some plans on their side here. For instance, for Rust, we wanted to
eventually have a way to tag stuff as kernel vs. host etc., but that
is longer term.

Cheers,
Miguel

