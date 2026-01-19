Return-Path: <linux-kselftest+bounces-49336-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B99D3A186
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 09:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10E3E30A598C
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 08:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC04433C53B;
	Mon, 19 Jan 2026 08:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ft0PIjKb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242FE26B764
	for <linux-kselftest@vger.kernel.org>; Mon, 19 Jan 2026 08:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768810859; cv=pass; b=ZH1VWo1mLYXY6Io+oHTrxl6HozNH+RuZtAzBY4oY4+LwX+tPOCp07DkSLhsmI0Vk6AKDnqe0mwpb5sMg9v3Nk8j/VPVkZu/FUB00oBvtVktgTM7jAHhYl6EPh0gsaqScnUz4VqNF6BysULc1JJKQQEUH1e2EFSahu9JEDDTWAQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768810859; c=relaxed/simple;
	bh=5BvaM2zTZp6LRXT2gqEqhSNTny0R7bUn7MjFDG5LA8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kPxImDvnjnHpoc13W69b+CnFp0hwt6GdYxBguU6+hQVIQeaocEioJboskpK+SK204YrOz7JP027O8MBdrqqp90gfRJ/cWiTABc3FV38/hge3H5oGRudqfqmdg9+1STfBGQh8DR32K7JsZduPmYIeJqQi4qO6GRGZKt0M4LXnRqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ft0PIjKb; arc=pass smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2ac370cf8c0so313161eec.0
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Jan 2026 00:20:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768810857; cv=none;
        d=google.com; s=arc-20240605;
        b=TBo5W4hwC/K4fCsv7vioS9LLjWPCy/MNLlx/RqmrLwIrOxpfoH9Lxxyd3e+xfioiKf
         NPYLybqiny3WMvZnNG8JIUqnN1R6ez6F2tH4jnrkHtjTpBp9/T5faEVOzXNBrnzLNnay
         RxjiWeEdBxJ+U9lU2/uniz6NhYaYDRZe0Ajax7TQa6DlOnbMHaAMq2wtUoJyrPLl7+P1
         nl8pe0sd8QF22onOHdCfZYFzsmhZ+jpc7xL3exCbayXjGanXiaHqZ4OHf19Uncq22gwo
         /oV9VzMUmQreS1TWoJgHd7jIo4M9ax+J+PDVB3nTXFkZip6Dzdh2H/yE5ZgNdW9tKELH
         pP6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5BvaM2zTZp6LRXT2gqEqhSNTny0R7bUn7MjFDG5LA8A=;
        fh=imlQoLex0KIznkha8G925T7D171sz8R8YrQETbWjpdg=;
        b=USKfDV3k5n8Meqja83u8D+7MB+hMguU/HSGMZwyhBfig3TNLO1WlPSv3psmR8WhQbo
         q7xfszVjb/tcP7ZL5pQzrvSJP+Ub6vMM3HrpznuvFRIB211q/KsqwRS8xgeKf4poh5OP
         9j1nAWK/MxlceF8K/TL99zVBL4xMvkzlfMpZLV9UOdqO6m/4Zqu/92cljylDWbj/YLZg
         9DxKet4pYkvJGzH859gxNrN1mfAQW6FBEdcSTwf+gY4aUbOEHF91yDzf7PuJbYnDC+3k
         /Q4JAvblzyOBaZmHa3Q3QvrX8wn6zYn8DGK2AbnP29E8LgdIFhz96233nQM73gnRU5at
         8VZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768810857; x=1769415657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5BvaM2zTZp6LRXT2gqEqhSNTny0R7bUn7MjFDG5LA8A=;
        b=Ft0PIjKbJX1PovTrwAIWhkE8E56u94Se6jQozD969V9wk82aOvhq5h+ZcVSeTMmATX
         mtxqtlTFYTZLhVg9uiS/ICrDvCK4b/NGdVMxs85zbLC/n0fPy26Fh/Kfk/iSIh5uL1DV
         48IcWffrlS8/Dik8s8PLz6/ZP3TgCycMoSuJqdKgmHjthZncrc3bamE6Q+X6bYUj89p6
         B+dfRHmIZzwI40TaQz/WO+RXFxrDXPMC5QTixmfDAaInIpU7A7BhIZ1uPEQVju/tqtcL
         fo469XZw4gHdSW6he/vTaY/I4MzHwmuID0IRt+Ju+E3SuKnq2CYemqR5zwN0i1vR1zeD
         /JQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768810857; x=1769415657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5BvaM2zTZp6LRXT2gqEqhSNTny0R7bUn7MjFDG5LA8A=;
        b=mpN4irCwdxLmtvacRaZDnmTDXUlL3chIpbSDhjM7cIc/xSymTlMlXZTPPu4svjtgOD
         kuFoTLlPaqAdNB7lJ31qI8NCD65Kdy82YHxpNhC40uI7HPMjdOGqTnrS+aqUtSnURg+z
         lXiLSIvAYe2H2c6OdJMAA2KiwdyxckIg1YBhE4cr39zgOBwUs7YKyTEg8ZcjM6JmK4hZ
         EMssnL4O/MtHyUKZYJF4IP+2d5mxCdrgjgEMKYsa96AAF8pFExjWJw/PnFpCfr7pBMTN
         grD1o4wPymopmwqbdTM3bXdTF7P1YjqzCJRQqhX0NRslU6hZGtP84AdwTgpagygqXj2y
         mL8g==
X-Forwarded-Encrypted: i=1; AJvYcCWaJuWnId87iugdgUzwf19VvZw5EEy1RbgFKIr1ggSdfCiFChu7a/CB9II3I2odwVpLl4XgBkJAJEGaoFdIya8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE+WcIFJCLSleUnEhl/6e+IbnKoeTYj90LzVK8KF268wRaDF/Q
	lwGy3d7kTccJgaaaK3i7Hyuce3Vt81uMvvdlGfrFRoWLNsdzUOMIyBJLZCGddB2/+SETR77T3Wz
	sAvPwQJ/Md8BXUDz5A1NiXvT8Q4pcar0=
X-Gm-Gg: AY/fxX5kzvuSpSiZQgNUu1ZUgsHMGmIXUKXRIyFxgrHgCwUdrAak+GMxhtCSheThqBx
	KiTizxXJ5iOsZ4YNSzRWFLDibqkrqHWBgPjo2v0CNznKhz6OJ+uIzeUgmF21oTs7DZxN7LYdTq+
	p/Wa1Xox9g4tyc0vg7nPceadHc4sYRWxOaKm9ErpqbTcaa/JzcBocHdPKaYpSTD9nbcXkz/AfcK
	j3uei6KEmJgaetaCUZa7q84ElHwvZvTW+mSoHeTCZNzRf1NkkbaDGVGij8RiH6bVYZKicyOyPDg
	NbBGtF0MS3OTIbIGTypktyUh3foMPJbJSN+a9elvD/ebUFVSgH4XKE+SXwCf4kxbGgNKh7apQtl
	OrQt3tj/WilxI
X-Received: by 2002:a05:7300:5712:b0:2ae:5dd5:c178 with SMTP id
 5a478bee46e88-2b6b3ef8367mr4917736eec.2.1768810857205; Mon, 19 Jan 2026
 00:20:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251222-cstr-kunit-v1-1-39d999672f35@gmail.com>
In-Reply-To: <20251222-cstr-kunit-v1-1-39d999672f35@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 19 Jan 2026 09:20:42 +0100
X-Gm-Features: AZwV_QhMB7zF8Mr9kifw_DFz2eE2ID4lBxi_wpfWg_BlkA7yDGSUKzHqRGH0rl4
Message-ID: <CANiq72mP-42jWuMJyUsdmFuxyLAuyKzGtg01k6JBFK7c9G6=8g@mail.gmail.com>
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

Applied to `rust-next` -- thanks everyone!

Cheers,
Miguel

