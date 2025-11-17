Return-Path: <linux-kselftest+bounces-45721-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BCCC62CA4
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 08:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C608734906C
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 07:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42957316182;
	Mon, 17 Nov 2025 07:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDna/a6/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF55A86331
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Nov 2025 07:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763365614; cv=none; b=GhBKc1573XR3z5etKiwO4EO+L8SBoe1pMZeKRx/ZLNBEq0r76bIsXfg9lkQH2gWuPswcZ32hVKgR6kAiPC2/J2HtqOCRpk4br4ELqcIdWtLQIhQIAQuJopfvYGCoRjxfYe7mAebqI1O/WKpFPwgBpn+hoCDGGfd5JGGRpSfUbUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763365614; c=relaxed/simple;
	bh=ObmpRVCC1Puh2FN4TUTSDuNBSGR1J6ACRGZuF8hCM1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NmV3UwrRHKgCTHcMsz9zn4lfT+/57W8s2dftxYuOzdtzUQc+ID1GmIh47fekXWWEARlUKBebhyp7hDP+RwZ1hqJa9FqrtAEWzQZ09QWF9ByE72ByOqNzn/G4P1b5molCCZ5YbikFHvMiBJDKgP3q6bwilTRPJ8At4T7Qi20iIU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDna/a6/; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-bc144564e07so110376a12.3
        for <linux-kselftest@vger.kernel.org>; Sun, 16 Nov 2025 23:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763365612; x=1763970412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ObmpRVCC1Puh2FN4TUTSDuNBSGR1J6ACRGZuF8hCM1w=;
        b=EDna/a6/MkdVrusdvi7xH4k+ul7UBdmEJlw00npEg52GaDzaOzhzZ7JiWN6Zl2Rzbk
         l6nyw3oCewdlJuvwJIemdwHmhWWMzJb4+ZD1+5kssVt3sbzrbCho2+Cw24iktPDpcAft
         lpl5a69ixugH9UMb4PZrhd0MZUZRz/LFrNcUWYzdh3QCAIhxx+31at2f21rm+SvK/QRJ
         RxfzgJVMXoQqP8ztE8hVAN+vMowtUBuMt+oRRWwKg43qLoID49YUbs4mC7vYeL1FEsWa
         GxnqsXjFOKmpfwlXea0ZMAIiZQxFHd8HjHZyalJQh2+4oVahATNgz1tBefL0u1qvCXl+
         HayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763365612; x=1763970412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ObmpRVCC1Puh2FN4TUTSDuNBSGR1J6ACRGZuF8hCM1w=;
        b=D+UA+PCVs/8dv0oCBdWZzx7FghvYM2E8y7j8nAzOwbR1Pg8jeZ48oEYcGYHNkKc+Lj
         jkxc0HCXOepxwFjIvvhHlk/UaAp3ZF7NMk4qKCu6bUQNYDq3UOxRDPkp3qyql4dpTu7M
         3EJrdQexZoquQA1IMTzkP5zHNfjzCk9B4mliF5haVnmuh3YsWKHFW4dERsqG1IHCiWsa
         93ef52sCL8HdG7TNy2Z7YsTf8BhKTuAHwZkcazLJ1JWixhDi74AAD9ug2zGRytPdiVb5
         z0/OBiwQN+eT0h/+JteqMXzK98D//gtBpVpC18RV+Y9QWjep6TcEd5La6W8H1Ru9p9jw
         VB6g==
X-Forwarded-Encrypted: i=1; AJvYcCUayeYimYVoCm1X1mqv0CVSMThkXJ/FOX2y9ed9YkmyQwhoHcL8R+IyB4Lx3DpelQ36aZgy4Ry39vs3Y1jxCkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf3/RN/z8ruNFR74dR2sWOkd7yrSMQt0a+xhlm3t7c5cN2D/GS
	KaxZC8YMn/b6M/JBtNgAZXrVtR+g2q7yBTPtjAkRHioU4+8znpIwuvqSGldd3JckkHv8+hnw9bX
	INI24Ox/9zTajPARAYo0Y+Hb4aY6deaasS4q8
X-Gm-Gg: ASbGnctOQv1Zyj62XVW/Cmplwx2VZ5c1piMVyy2EId6ZEXq4vlkc5hkEv1VBYBHtgM5
	C1rq5VvHWA+7j8QVCrQds0PEFxsEv6PCzjJUHewwxlu2i7d/L1uVLIOW8XyxaWfnHQivVqAJ2Tj
	Hpyxb4qHJGweVYsRFnAZKIlLEB3wA3qPWWeOp15rW/4QcTUxa2PO/MulBcEfvboryOeRjgHNDGI
	pFgf/b5+kxh0Mah1g15MhH8/mvXfzzifZ8+kv9jBRIk/Dm/QJXcF9Wq6aMUrD/jJlI44K+sWKnl
	L34QdnnjsGuWPclnQPX2pRzREuxsbpZ/bytMmsWGg3U23DrnxKDUIueWzxABxJIJhO02qa+9HT1
	NKlumv825jm9Qsrzwjgmsa5zT
X-Google-Smtp-Source: AGHT+IHcyHCJS+XHOfR1eZy7OnTrmnx2eonBofGVOY9uvH4vy2lj6EpJkn3+qRUAndgLxU1J4hPJkhNm7LJiEaSgXd4=
X-Received: by 2002:a05:693c:6319:b0:2a4:5129:fe99 with SMTP id
 5a478bee46e88-2a4add16638mr4149911eec.2.1763365612090; Sun, 16 Nov 2025
 23:46:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110113528.1658238-1-ojeda@kernel.org> <20251110113528.1658238-2-ojeda@kernel.org>
In-Reply-To: <20251110113528.1658238-2-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 17 Nov 2025 08:46:39 +0100
X-Gm-Features: AWmQ_bknbkpZ3ljEJgnqzyAN5abYU0FTf1nfb1wVbwRK92rcRHx3LRnBCnh3VYA
Message-ID: <CANiq72nFxpNP3JH-ENKRM72phHXYSMfp_7X89-q4UuGH-OyT-A@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: device: make example buildable
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Rae Moar <raemoar63@gmail.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 12:35=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wr=
ote:
>
> This example can easily be made buildable, thus do so.
>
> It would have triggered an `unreachable_pub` warning without the previous
> commit.
>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Greg et al.: a quick Acked-by would be appreciated.

I can also pick the first patch without this one if preferred.

Thanks!

Cheers,
Miguel

