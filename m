Return-Path: <linux-kselftest+bounces-48148-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB697CF1704
	for <lists+linux-kselftest@lfdr.de>; Sun, 04 Jan 2026 23:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72C26300D43D
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Jan 2026 22:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E693D25F96D;
	Sun,  4 Jan 2026 22:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzzVBXrJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B0C52F88
	for <linux-kselftest@vger.kernel.org>; Sun,  4 Jan 2026 22:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767567301; cv=none; b=CWk8Z+EZdPr/K9PbAp5FDvruN2Z9hcy7V2h0dRt4hZQL0GQqJjBO+75sysXYsyhoizDXkOffjlQzASJBMk4Ra+0u6D06xEYRg7VZWUjP8nm/eWXr/P0rDv+pZeaBnlE1vBxyYrQSi1+rObKz6Mr++AckP3sJdLtB4LxhkT9uKJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767567301; c=relaxed/simple;
	bh=RGfrK/i8CqdIsUAM6F5jajU+/3DORxQP/tQIjwYyhfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WtzKwS6e4EMQpmsa8GRbBDwYRg7g0L9ZEOiYQVO0/hP/LZ43pGIK6Na9zSGRiVgm72+esCczcQDviqQei5J9MtVhEyKRB6Yykot1QSde9uyNhSFfAyuxDJWuD3raIfA6oUR3ELQTnsnewQQ6FFmfpO5QVNLU2UX3rP2hyhroHi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gzzVBXrJ; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-bd5cf88d165so182896a12.1
        for <linux-kselftest@vger.kernel.org>; Sun, 04 Jan 2026 14:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767567300; x=1768172100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGfrK/i8CqdIsUAM6F5jajU+/3DORxQP/tQIjwYyhfI=;
        b=gzzVBXrJF+a5wVtfPszObhKRfo/sEPKgSqF7n7qUqg/2BZBWl9sBqaj6TrhgSNmVGy
         KTF7pKB+BT4U6yLig1K4bIsZUgPBKliviDu0AGvYjuSU021oBcweHIp9yA3B+UWHki9k
         JOlZYvSHYLxS4eUlcmSo79YSeevEfox55Dpwuu2omz0MHXWeKXX3K7fW2uutjck0ACAr
         EaGTs614kSA5hRjQ+WMiuk0bKMJQUL9yDXrlBQgGVSbSTUm1ZLpVvLjjuPxjvyPQ70hE
         K8NAjUEUz+fv7c/in/sBgMKfyeMo/njE+DNnk8bwuX4ruWVpbxC8DYf0/F3emzGKAydx
         XuZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767567300; x=1768172100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RGfrK/i8CqdIsUAM6F5jajU+/3DORxQP/tQIjwYyhfI=;
        b=Dq1SCO7YijfxcZXd23dT12TTGTCC2/ahfMpgcFfrSWrUw2FFUfhIYI8111083ueue/
         5YsYAssYhbnxsJex/kye3/QCVsJlHVTMhCXWVmp6jQgIKb3S3HMlPfzrvNhweq5HumlO
         2mhiV5UX0nN/HjCJ4ww2HrOjqu8pqIq+gV5t1sUlgAtW5aYz35qUK0g0lRrqg6m8hH2T
         oJoasOgH261qohjqcjYW1XAIACGEVXYNK8Nu785fGlMrDySxMBsrt5ZRHf68wFgJ0K/Y
         pyLDIXzEuuuJPgVPq2BFDFZa7SWSiUwLZlTYURUpUGIsv2RRjFxNMPOLHQWLGJkvw2hz
         HPsQ==
X-Forwarded-Encrypted: i=1; AJvYcCV66qD2S7beYa2IqnkIHkomqceT9lFW0yFgg9tz0MLYxRH5mFPr9kCp4tr9Lf0Lz0vKFLeFuEHen978izvLgTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOy6RkRebTcOUvxkENYUg8XJbaaBBCX1AYVp8otOT+cGhG5ye0
	wv0J9BnkUIEk17ei0k7O75KpMpr22MVKCPFLSRbfj1iR9ziAj06XSq0cr3xxH5hbzZI8u2jW01M
	wYuIMGaoAH94Qx5S8bq0O1VakGeuswH4z7AW5
X-Gm-Gg: AY/fxX5qk7HToZDpTtpbjnNl2jPYbn5HQQUhiDp8ZZdqrUvo80i8fCgp8Y8vU7+e0Wn
	9rakCnCnInYuxknMF4ciTKLq33ytQW6em6CTI+v1grULASDXFS6e/JPSxSBPwimJaeBU9dt/iZh
	eoiCRq8233ENNmXQAtxtfIyijnSHL1f9aVVYNgKZqw7on9TXLtqk+IhkeBy6ug2nfJiJdt1IdAn
	tnMSgxYSnnYCKfyQNMtDKRAQDDk9AUfYAKMVnw9QtNZbdJ5SGoCHtTlB7LtaKYW2a9F2T+Wrc2T
	v6EDLC1oXuRbSTyFYekGrs/MdBPphw0VF9GZIpaa72wbh4JM768zlugEuLlIELW8oHkTpD/9Ysg
	vHizq52TXNmCz
X-Google-Smtp-Source: AGHT+IGfdV3n2immeToIA2HtCjHHk7VCHJdSyBxh60KZPa7f2BlaejcNt7HViaI/dg1w225H/hp/37Uwl1/GBo8Hpbs=
X-Received: by 2002:a05:7300:724d:b0:2ae:5b23:1601 with SMTP id
 5a478bee46e88-2b05ea108fdmr23605192eec.0.1767567299771; Sun, 04 Jan 2026
 14:54:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251211182208.2791025-1-gary@kernel.org>
In-Reply-To: <20251211182208.2791025-1-gary@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 4 Jan 2026 23:54:47 +0100
X-Gm-Features: AQt7F2oeBjY-zPeIIX8N3i0q9UZLwGEO153tgkFaokPfbh-tOwBHelwXkLfnOCE
Message-ID: <CANiq72mUR8NkymK4ZLs1Ejy5Kk6ZxCRBLd=-3UCUGjWSnDfJ9A@mail.gmail.com>
Subject: Re: [PATCH] rust: fix off-by-one line number in rustdoc tests
To: Gary Guo <gary@garyguo.net>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <raemoar63@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2025 at 7:22=E2=80=AFPM Gary Guo <gary@kernel.org> wrote:
>
> From: Gary Guo <gary@garyguo.net>
>
> When the `#![allow]` line was added, the doctest line number anchor
> isn't updated which causes the line number printed in kunit test to be
> off-by-one.
>
> Fixes: ab844cf32058 ("rust: allow `unreachable_pub` for doctests")
> Signed-off-by: Gary Guo <gary@garyguo.net>

Applied to `rust-fixes` -- thanks everyone!

Cheers,
Miguel

