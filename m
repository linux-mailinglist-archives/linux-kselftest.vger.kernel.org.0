Return-Path: <linux-kselftest+bounces-45796-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9B0C66316
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 22:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 96AE04ECF5C
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 21:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD47A34CFB3;
	Mon, 17 Nov 2025 21:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NaXVfcwo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507B034C9AE
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Nov 2025 21:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763413382; cv=none; b=Ys0vhRrr1f0dUbzWHCc2orZ8VTJQyG0PPNic4cMQM2D2XdIdJDTl6Ut34r57KvZV7Y5pTYIcs0woCLHwZun5lp+tbR1q5ul7yNoBp0gyWQPYA9Q6hq/wMLbYfCejhx/ghRrEzCpfZUcBRptb3OQXgFB6cKVcVKIDBxXhh5Bnkcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763413382; c=relaxed/simple;
	bh=iP6TspFv6C7dt+qkcsFWTPUOXmBMAp/00Ut2BHL86o4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LT6YWauqpeOFJDbWbj5RAkdwuhmhYEcnVh+vjvTSig9CnrgtyFroUycuLGYfIaD3wHA2oXOPkMv491vq8aBEeZtB9F0DHcmncVHfXDTVHzw4ldPuPOmn2ihaQFEtkicQdZrVXEJrC37L39fwsyiX2oQU/WDJZgwuKSJYWy0yMQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NaXVfcwo; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-343514c781fso729328a91.1
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Nov 2025 13:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763413380; x=1764018180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iP6TspFv6C7dt+qkcsFWTPUOXmBMAp/00Ut2BHL86o4=;
        b=NaXVfcwoZa7LhmxM8NlTRwkrZ0ZZkSPcDLeurc8j2BNgbm4N3rTFMhEyl7nhPo9Dr0
         cyTCIFrOIrbGj2GVaWQkFy6Qsz0GpiUqbQ0+OLzLePXqm1UNnaOL97t/k5LP5cEn1gp/
         4M367BlSX+u/3TV9NHNqACV9VpTIprstQNVbCEXvbT6MPzXMVlvhZuHldbeHRXePRIU0
         Ajvkfu4L/inB1IIzDy/hiAaBnq6rxn5wmN5+n9ONdRZy/8q3JEZQ0zE/mVfrEVcGG8l5
         bb2E/fSeZJD3F39FIGWcZyfvqU0abBW4gPw8n2fApof9N9T6/V/lbEmsesrt/9rdYeR/
         4eMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763413381; x=1764018181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iP6TspFv6C7dt+qkcsFWTPUOXmBMAp/00Ut2BHL86o4=;
        b=pTzaxI1KN6J0ogPzj5FeKp4NEVIoKri1mW8Fdo393t6CVOlHoLhveXdAsEOxjTBRIF
         l1DF1pH9Me+FKit0/pSLvZDQpfEhdg8pq2bCu3Qc2RnFczliGHFFO8loqaBeUOQW2Q9t
         /3DYQ2GxdoNFIQ/X7qSe0BqgwsTd9s4P/XB8kLfufbO0K8X0sDKwVOpzAaq3rhNj0zNZ
         1DZhv4UZXaCIlRYOgrdUjYafJGFfthFOIII8WxL6YPu9T6hatp3KxLotJhnfWYSGNvXM
         GcIlCtjvX04QaWedh54CzRPGUIAGMk3FG1and0Hze8xqpDj5uOJJZc7Fa4vVADwBS/rP
         YeBA==
X-Forwarded-Encrypted: i=1; AJvYcCVBKpXghQQEyDhW7PP2O/fKw6DTm/HX9FThmU/kTBK9h1OL7pC1Pvn0+Snh5ZvTDrU8Nw5Bu7pBQ2OiS+tVtmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzypQ+BPd/i2C05GiMjbyCxwpqzYgogfmo3lGf6ayS55/NzMyGz
	H763Ci90MfLmtbSgNBcnGyRweXWahNGz6+1BIngfOYNrXTlKQ4EWj5AKUv2HImv8hv6KOOMpKDR
	i3VmdIQeUM4CePnMU4YPlt54LZHqsIRM=
X-Gm-Gg: ASbGncvlZbrMp1TKHIu/i3sLAUOLaZUXUgNZxeFdAqV1O0PHJoDBJ51p/MrJNMyavTe
	it3Dea4v5Y3kw9V6PoGR4JYkBO2ShHyPrGb9As3Q8lvpCoReUqQKrfp5by+jdn41YlSwHEzd/lc
	8JzcxR3+HnBcXNZouViK/yJkkoXpYfBUZqVgaFu5s9HNmQYDa6x2IYHnZAHox+D/c301OKxY338
	FcBt9W5q+kGQ1A/qR8efZBXqZJx6oNEXNNPdOdX9fFj372b6Bnu1XLHCkT9a1GT+qMZRQ1g3JyE
	vqlA/+EkZtYTRW75p36zBiht5yOyFo7vl1fpARNcS1IZxgEQML8niYaAA4lWQkZJY3s8yi5U8JO
	O+Xo4OZmQYEwGnw==
X-Google-Smtp-Source: AGHT+IGlfQGUdtSox02ATWkbxSbcf1jC5YZXySUNyLmlrEZvBMimdky+/XqX+bymvXPFrGG75BWC3U7j6V3cT8HAU7U=
X-Received: by 2002:a05:7022:310:b0:11b:98e8:624e with SMTP id
 a92af1059eb24-11c796b9796mr80353c88.4.1763413380425; Mon, 17 Nov 2025
 13:03:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117080714.876978-1-ojeda@kernel.org>
In-Reply-To: <20251117080714.876978-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 17 Nov 2025 22:02:48 +0100
X-Gm-Features: AWmQ_bkVH0zwZmTGtxY2a6yQt4iofNRpnQgdcxIiUj_oO7rEMvoYnw_JJyWw_ro
Message-ID: <CANiq72=-w2p8sQgUKYgPG3Tx9GSUNgcVUp24k0ck2RqYgupCVg@mail.gmail.com>
Subject: Re: [PATCH] rust: allow `clippy::disallowed_names` for doctests
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Benno Lossin <lossin@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	rust-for-linux@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Rae Moar <raemoar63@gmail.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 9:07=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Examples (i.e. doctests) may want to use names such as `foo`, thus the
> `clippy::disallowed_names` lint gets in the way.
>
> Thus allow it for all doctests.
>
> In addition, remove it from the existing `expect`s we have in a few
> doctests.
>
> This does not mean that we should stop trying to find good names for
> our examples, though.
>
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Link: https://lore.kernel.org/rust-for-linux/aRHSLChi5HYXW4-9@google.com/
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-next` -- thanks everyone!

Cheers,
Miguel

