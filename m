Return-Path: <linux-kselftest+bounces-47843-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 266D3CD6138
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 13:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C0AB300268E
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 12:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5593923A9BD;
	Mon, 22 Dec 2025 12:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sbp6orvo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C98136349
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Dec 2025 12:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766408376; cv=none; b=m3P54jTYS5wjdA07Wt5hMXeEp0CetRtJ0Agyu35MruLkHS1KeTaUh+vWbm4666CYqqJPD3+9nx9fSRMLMI2dnDzzgYYJ6GlzwRQm2+Pk6J/5MnrBqE7YpHK1PSIoXuG08rbrdofAfSQ4Z2vvyJ/jehBaq4i9RycScyeSCghsYCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766408376; c=relaxed/simple;
	bh=o9/LIe/t01Dtx//s28WR54LGa2BLxh5Sr8vzmSC6Krw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VnWW05EcNgl9V73e3+mWdgOw2vqePFLp7Y9V2JB+68ijbscrStvaDkgcod0k7SwRpR1UFwScIPlS6yOu6Xr0gg/gkjVrTVQPblB6C6iEkePCLqpf/EwoX+8F2XvdkHitJo3Qq0iUBfH+3OmH3GxQ7fxF+lfSl8W2Nj8alsakprQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sbp6orvo; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c1e33f2cb6bso35782a12.0
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Dec 2025 04:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766408374; x=1767013174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o9/LIe/t01Dtx//s28WR54LGa2BLxh5Sr8vzmSC6Krw=;
        b=Sbp6orvo48VvVrFHRwqb/jJN0nBNycF8D+up7LLzS/guB8Km0w4RSkpsdomiRKLWK1
         8Rk5rh3cL7vXAUCEbShCD+HXqBhn9rp+WL9jd/zjfrKMRqi1I68XCNB5qYmTMZWlciAx
         wWQGoqyAa96ZG/d5Rp1aq19YshGUCLIAs75HU+Ag+ZxFNUWCrOvpluzeJyP+ucbmN7cI
         4ZCYVCkhEUr+32XavZoZ/kZW9aHMkQF4c8Ij4dPwX2mxK/UTdOTmbjOfTMcoJhBSxZcK
         TPcN61qX+2rrR2Yfgoc3ccNnPZvX9JeZfv9PEtut3Ij1owrVukJlZVas2Zxwh9zrOtwn
         MVZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766408374; x=1767013174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o9/LIe/t01Dtx//s28WR54LGa2BLxh5Sr8vzmSC6Krw=;
        b=XOv8LHKp4tkEBN1/JEvGbd5J3y83pSAxjMMSi4PAOyW5WmckBr5rhghK6Vv7z9P1lP
         Od5NOUi9M9JqgFH/0WGUyTqUfnjIU7hahCN8nF1Ebjl5YMgptfm7yRJvGG7mFfa4zXRz
         Bev6bIeLH+4wabO/v7gqDkDPyL2jZN2JwvLpeUMkubvBYbDsUrE4es82hnXAVkO+r9gP
         nWhD2eM3vXrSQ7qWgtWrTJ7lCA/GiDooqmbeQDR3XM/6eeWp8N8pXVrxRRlrXYKdVarC
         dKMJEJjVzAdT4StpeuS+EsIWpHBvftwRGWRE7bmDDB1uPzfPupvO668ExwR3iShjSE8j
         0qKw==
X-Forwarded-Encrypted: i=1; AJvYcCURr9NamScnvVieTpOIB+BYUZOwg/1vgFiNl3GCeXKwT/Dx7LifUqwzpuXZ1Jc1Nw5DjEBdi73AMwPct3WmHjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDyp2rbeoMcFQv5OBjSEmmt0NfpVUIYNdxuBAAfWWSFzrng+Mx
	sMnkcql7YbQm05H0y6RLPVV3j7o/HB1oRWu7V0GKbwSvvbGOkIawfEmpLOCLc49IYq+SjuT79eT
	irbnfnKIAH8vURYgro9n+KwULhvrLMTw=
X-Gm-Gg: AY/fxX7DvLuDPNaugNiEdmidr3gLFVLrnKjy9PY0i8sFsjMYGnjRx25KPuX9VhiQKhF
	aRl/ohpVuJ6ueIiTUGs5QvSaBdHtcbD7syWOSElGuDkP9PWrag5G6VlpPXALbpOvNbEjVWt+UCa
	ubPWDzuAjS78+HsGmo1SodIj2YxqGLEYnPeMt8iGuR4FE4Q3LFeMZwrdpxvV20+3N5CiG0Gv5qh
	5i4+vmza0KZODB17/LflbxIifbwhQ67HlA9AeibZ00MxG2i5orDoUnCh6fgeeF0QGfzoxMh4XyK
	xgm83xbRAQNcOVGMLqg/XZCDsSNAe1/now9F00vHnIiz6AeIlWtz8rF+ONWv2zm//WKQ0dNOY/i
	Lb72FO+ShPZGy
X-Google-Smtp-Source: AGHT+IFHAcgBr0PVotYFuFTF7OjZKmvWsbvlEFz9nAa1cL8iusRiWmKDBD+/DHGMteQ0h0o0ZWFWhyXrQxYscG/Y4Ro=
X-Received: by 2002:a05:7300:c00c:10b0:2ae:5d59:3ef6 with SMTP id
 5a478bee46e88-2b05ec8546fmr5480797eec.9.1766408374069; Mon, 22 Dec 2025
 04:59:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251222-cstr-kunit-v1-1-39d999672f35@gmail.com>
In-Reply-To: <20251222-cstr-kunit-v1-1-39d999672f35@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 22 Dec 2025 13:59:20 +0100
X-Gm-Features: AQt7F2ph3j-0abungPUTjgCBpVZrW47P41gv1eL_uGKW0T5r_mvKZ1U0z8gGGFs
Message-ID: <CANiq72=wHw5Vq4Gm9R0cb+2ftDxE5yDOddQ2aRbHDT_9q6d-Jw@mail.gmail.com>
Subject: Re: [PATCH] rust: kunit: replace `kernel::c_str!` with C-Strings
To: Tamir Duberstein <tamird@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <raemoar63@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2025 at 1:28=E2=80=AFPM Tamir Duberstein <tamird@kernel.org=
> wrote:
>
> From: Tamir Duberstein <tamird@gmail.com>
>
> C-String literals were added in Rust 1.77. Replace instances of
> `kernel::c_str!` with C-String literals where possible.
>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Benno Lossin <lossin@kernel.org>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Thanks for these (and all the others you just sent) cleanups.

David et al.: I can pick this up if you want with an Acked-by -- thanks!

Cheers,
Miguel

