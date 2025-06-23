Return-Path: <linux-kselftest+bounces-35657-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCD7AE57AF
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 01:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8798D7AEA2F
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 23:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6145B226865;
	Mon, 23 Jun 2025 23:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+leis0x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EC128EA;
	Mon, 23 Jun 2025 23:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750720336; cv=none; b=I4dokoTTqJStQYerMAqSKRRnidhDQdMVzxxQiVdwBTeDN42Ovo2lmUJlv4wTTNLykpr9HZmy938GOuNB4VVMF4nq/wOIh06spGdYIHsObCN3ahpQNnj3XJYR/2/M63JETG1HvHswc041yqVFU1HOJB0Xo0BnwqNyn7P1Eip0eRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750720336; c=relaxed/simple;
	bh=OXlr1yF0Sv9rwvXvPs5aTpuJ+a9sKko9efc+xXFpxqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=os/4g3D7xZOd6q0IbFimqanmup67qllw4657RdUdX2qqN1U48eRIgQkGhDO9TRCuiEoxW9al4givN/ziQh9nsx/yEG8msZgmsDTQsagH9m4+T20TWsgKQEOdaLRHMnW10cqUEedmQ+ZGm4ulbfTaibvWhGTf7cyt6KTO1acxgzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+leis0x; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-23496600df1so10334785ad.2;
        Mon, 23 Jun 2025 16:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750720334; x=1751325134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OXlr1yF0Sv9rwvXvPs5aTpuJ+a9sKko9efc+xXFpxqc=;
        b=A+leis0x6J1uZXp1J7mZwMIynHrwurms9VvideD2PorMnn4pl8KfT2qgkI6XljGSXN
         Lo5/1QeHo/2OXE86BKtpTV9UL3WfgGeprriFzaNobizkp9EYhdDUwp0izhZNR7TaATLQ
         V3YgIOdowRM1ZAUXpjSZXOsa8vS/tVYIjgTk9gXdun/1nPI3aa2PEdIFb9ovnHRI5wvX
         OdTQXkrYWPFa7YdkdARojLo7fow6IpKSXTHNrxA0iB1gTX/0FnPFqwLletcZXGhCQHMe
         WZaliyk/kcuTtj346TCCQsSGdv30mnUuYBOyMaImfZF/zFXGjxidZsLYU+f1OF9r0bgz
         3hxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750720334; x=1751325134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OXlr1yF0Sv9rwvXvPs5aTpuJ+a9sKko9efc+xXFpxqc=;
        b=joRcQf6RZc7lmF6dtPR95pINuFll1E+AeM4TI1R0VmzySqEKpEbYFxZyzB9ASmxT6x
         C2+n/GMXj/rJ7M2BbZS1TFf2Dx+rHA5HqbpVeLZv/KS42j+5rRmAGb4iRFbEFzLvz/Me
         /74gkLWb/MbBG4EGPZCN+ybdV3ksGimCCyF/HAbtXNY9jkrls95aHXGbSYvDlqnsUZZC
         +CeHJf0DcrJxlGDgZHp2JElAFSwbXnOW++b0EPsSGUpxRowRGrA+mUewF1tkLpKkRTEE
         APzgMoJZqnbwZtU9qE69A1BCoERaUNDesaumLHEfmzE1RX51rRtJXBcc7VuKofyNbqy8
         Tldw==
X-Forwarded-Encrypted: i=1; AJvYcCU5a06wEgOP2vKB3qbCncQ5/aF23BhgT1f/M+OHcEXlmoWPZvbDcXLHGIdSHuP2+mAtWMJElOD0Rnk30hOYhOg=@vger.kernel.org, AJvYcCUxBQ5mNg9Y9OofEjaXG7j0/Bo8hT9FR3nwZdcca3lk2gwdAzDt6huInTjkL3xpsHai7TIHKBe7uCVJTws=@vger.kernel.org, AJvYcCXw/YakgdnoOenhfZ1OGGofpt0muJPyj6K4ge5W3F+QiVAHggzMknOoShs3sDG8iqvY2+XgQK0wKQK/Isqzf3xD@vger.kernel.org
X-Gm-Message-State: AOJu0YzjJe7CtPCnpDc1GSz+Jxs+ASIIb3LCWPW0IP+6F/1SGjq/HCxP
	8of/GWV/qPJg4ZSeE3Q5IHSSwTIgkR27d9IxOH0yDqNAVBw1uGRSVtcj2qpXJ/zEHBbfi5UMM4S
	nYjE51CchRTsXkwUN4Nr472nX24kHFAA=
X-Gm-Gg: ASbGncuWSu8R3DjEwiT89xE/v8XBWB++wN7oBd9CRBWZtSGNGy8Kixx9mW88UKURFxs
	+Rw8KvSuLLWNbkLx80nLSDArUe2djOekFUSZ6qzJ5ubZRb8DWtaXgXU9RyzrKD17PwEeBtLpaBe
	k2snAsa+FF4mijhdvEHLc4+1pEZj5upAhXiBa18bBFOLU=
X-Google-Smtp-Source: AGHT+IEyTbn2237c2Hr31vCXUyYt8AHF82k+rm80b+xf6aeGb6FyZfjgW0zu3Cma9NlYREtN0F2AZV8USuCwvY6JKbk=
X-Received: by 2002:a17:902:d487:b0:235:ee04:dd2e with SMTP id
 d9443c01a7336-237d9a7743emr94347515ad.10.1750720334082; Mon, 23 Jun 2025
 16:12:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528174953.2948570-1-y.j3ms.n@gmail.com>
In-Reply-To: <20250528174953.2948570-1-y.j3ms.n@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 24 Jun 2025 01:12:01 +0200
X-Gm-Features: Ac12FXx5OoNfI1d2_Fa2rZCqEx25veUJNrUk5MYiNNH_z3yPSX8Wkm7urNEFEP4
Message-ID: <CANiq72nfHFM4rdr8VhjvL0PRwMn+_G_rG3dqwk2eTr1ahbBmGg@mail.gmail.com>
Subject: Re: [PATCH v3] rust: kunit: use crate-level mapping for `c_void`
To: Jesung Yang <y.j3ms.n@gmail.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 7:51=E2=80=AFPM Jesung Yang <y.j3ms.n@gmail.com> wr=
ote:
>
> Remove `use core::ffi::c_void`, which shadows `kernel::ffi::c_void`
> brought in via `use crate::prelude::*`, to maintain consistency and
> centralize the abstraction.
>
> Since `kernel::ffi::c_void` is a straightforward re-export of
> `core::ffi::c_void`, both are functionally equivalent. However, using
> `kernel::ffi::c_void` improves consistency across the kernel's Rust code
> and provides a unified reference point in case the definition ever needs
> to change, even if such a change is unlikely.
>
> Reviewed-by: Benno Lossin <lossin@kernel.org>
> Signed-off-by: Jesung Yang <y.j3ms.n@gmail.com>
> Link: https://rust-for-linux.zulipchat.com/#narrow/channel/288089/topic/x=
/near/520452733

Applied to `rust-next` -- thanks everyone!

Cheers,
Miguel

