Return-Path: <linux-kselftest+bounces-33917-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A6DAC6396
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 10:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 508977B1290
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 08:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BC221FF24;
	Wed, 28 May 2025 08:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6s2xY/f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002D11990A7;
	Wed, 28 May 2025 08:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748419402; cv=none; b=GwKq8TdFzJ9rDfOmg90ig23ZrFRtjbWFYAoECiZGzgRcEpB0A1PWIfrDgEIDL2AAmZSSm3psf8HQw1IJnnsgFMk4dQbFbt0A4faM8Fch+lSBoeh8UQNydJRGTSf9TwWkyaj0ByAEVBhf2iQ2f33bb/ApF98ffc0/PdqW7Im+Gpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748419402; c=relaxed/simple;
	bh=m1AgbkSD9ZhqsKYGnxQT5QuWasbz/mdwKFB3lNLS1o0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i6P4hJOyZZlYzlMBLJorBSHOk8hSDS2BQv1L+7lkKV5/L1gJIrGOsEpR0wcAqNfLB4pUpH2dKAL0ZZQk87d7kjFpY8al4SYWOyd6nLzpyHNNfvcrXgczEaaXg8UaGVPZRjmkawB+HiNWIN/Pjdc0/JOGoiWgT089UFemSWWBWWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6s2xY/f; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-309f26c68b8so279522a91.2;
        Wed, 28 May 2025 01:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748419400; x=1749024200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7EOwFLOIjUGE9rMIYijxRVcus8CYn2cGLNdJL9ka6c0=;
        b=Z6s2xY/fAvUzL8vDUiVijKTi5TK+7jVXS4BgONUdNxXuEVvvMKC9PDSou1xKgeS8Of
         rrNNx67fger4NMvSZbTPtggcZTe/gZE3Pe1rlpIoghBCtl+Nq4dEXZE9kxgsfVrmxmOu
         JHqc0Mbm7uPQGjG31mJAz3EeIqhpO2n7OdhNko+yTHT7OWuu21viXWW/EJ21jAxp65v3
         5LP1BrHxOuRXRnEP1mJ2ZAQBZaUzYp7injDzlMut+riPLNl8aGzgdXojZHAZSaBwgFVK
         DGO2qEk4iROXOOwFGv1GpiT+ewnTJdZ45w05pR6/TpjsZONhTuJAD31OQFGo+Ebu30Sn
         kQqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748419400; x=1749024200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7EOwFLOIjUGE9rMIYijxRVcus8CYn2cGLNdJL9ka6c0=;
        b=lz97CXLBCeixQUTg/0A66oNbAsnj3fXCWqPGRcBstQ9bBjO9DdgOTk4l9I6MTKxRi8
         R8am77/GkPpRuwmW3ZW8TFdiWzOUQG00nCf5JWJcYRLMb/pD0C1k9wuEudd6vDBgY2aV
         obz5NSf+6nR/uDI7ONP5nBdB3CEZA+LiRXGKOxrO2M/nwtYIRbxVwcbM4Gdi/1XJJUsx
         7Aai82ew9tlvfCoMNydzH3i5JBnzPWXntUqAtV6PndP1wLla1tlVrl9AAgbH8oBX5JLQ
         2pC+KnR3J10QhTgEe7tcfmk8qj6wuTee76wipAAh8BIrN4FczJSw7bhkXqVmpPFcjsT2
         aGKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVh7Gq+scQ4wbXEYNHO7MD4RbFmcyKX7nOAnd6/c89tr8SAu7O6KQC2WvXrp+wVGKq1xLEhNuHwZQ+hfdSY1SI=@vger.kernel.org, AJvYcCWFrlp3xQYcwTpiuvrvE2hTCDTvqzgpcly7nLvtXgfJIeklhPzJjYrdy8fnUN9b0wRb4rWipWyPKNVXP/ypkcxr@vger.kernel.org, AJvYcCXXn3fFLJPUFV2ICCHck6LTnKXzAbHr5jtHTYpL4jzCzNCId/lo92urfYtY11M8D5j+obocnVvvZzkB5vw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUZkmOmod9ADzR9cAi9kvoi7ysD0Iw4ax4Es0VfO/d8UTzDCeB
	sJ6rN2DrYIiTMGpPEiUXvqV7CJc5w7ypuwiNJAgJDco8x7EoG1/bvf3OB28oYYrDmzyAObsgSYO
	hz8G5nYWp3vH9y159UAX8xHzWGmW4GvY=
X-Gm-Gg: ASbGncud6fRez0GzjTdQbEtZGYwSxCdX1tF3ldxd/rSjYD3P1ODQeAs+PvKC8wn/e58
	dNtooTBlwKBcK4bNQi4lZ75uQ5PQpoCHp1Z1qHk3FrJz6cXIObIZ14L+hvUz7RymucI7qqTZriR
	Lh+pt3eiDWSCIR3VE9n5Pq7jrk3fkKss36
X-Google-Smtp-Source: AGHT+IEiwicS/q9RUO/V8KuNVVyWFDIAjAK2Mnb5ZiQ/pv0ORt4DIc9nszJacBNbGZrUZagNVQ3qcC1eIdODchfFkbQ=
X-Received: by 2002:a17:90b:1b4b:b0:311:e8cc:424b with SMTP id
 98e67ed59e1d1-311e8cc4639mr847651a91.5.1748419400178; Wed, 28 May 2025
 01:03:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502215133.1923676-1-ojeda@kernel.org> <CANiq72mj2yv4E7Dd+19fmP9xGWELdv6JwXULpu91oq0BMzob+g@mail.gmail.com>
In-Reply-To: <CANiq72mj2yv4E7Dd+19fmP9xGWELdv6JwXULpu91oq0BMzob+g@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 28 May 2025 10:03:07 +0200
X-Gm-Features: AX0GCFvKE0fCOzzRb6dIal5zXh6Jr2moZJDyfrK-nCJ7S0wGurEFElmTeo_tH7w
Message-ID: <CANiq72m2vnoagiFBU81L=Z=AXa--+Sz-Q8OKcv-++mXvRu__mA@mail.gmail.com>
Subject: Re: [PATCH 0/7] Rust KUnit `#[test]` support improvements
To: Miguel Ojeda <ojeda@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Rae Moar <rmoar@google.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 2:10=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
>     [ Used the `cfg_attr` from the TODO comment and clarified its comment
>       now that the stabilization is in beta and thus quite likely stable
>       in Rust 1.88.0. Simplified the `new_body` code by introducing a new
>       variable. Added `#[allow(clippy::incompatible_msrv)]`. - Miguel ]

One addition:

    Required `KUNIT=3Dy` like for doctests.

The build error was reported by Stephen when merging -- thanks!

Cheers,
Miguel

