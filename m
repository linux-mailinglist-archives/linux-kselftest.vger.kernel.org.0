Return-Path: <linux-kselftest+bounces-45795-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAAFC6630E
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 22:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 2757F29365
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 21:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FA334C828;
	Mon, 17 Nov 2025 21:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TiDcj3U8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A930934405C
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Nov 2025 21:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763413380; cv=none; b=f1Q4w1FIS6HWkpAElpjaQy+d9iRvG3bbyKhxLUaHP38wEqGwqffUcaWqL32Dytyg7PpR01ThAj/ZT2A2zF69msfoOTjZbETN5bgRx/ZpVz4iVahCwURQGdxloUUsZGLR5okyg+fiG6pz/yVOA0BSGFrAZnBVSwNNPnKAXhZ7PRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763413380; c=relaxed/simple;
	bh=Jx+mIImXSNDfgYqmNpofAZfv7KprXxOGtDGrhRPT+Hk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tlPlERHjN8Vyivm+pldsjkUcljbAWyxAnvhi4359BpRf9OAiPCwvtegxu93QphyZGxbciqJnNd65eWRra64pTOZ9oQ+IG4Ru8ybUHL5ITLuPcOayeK9zApumW1PCSD0Pb7zekxrzIePCTOZO6od1lBzU/zCsLT+UC64AWEhDZ30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TiDcj3U8; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-bc07266d011so153918a12.1
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Nov 2025 13:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763413377; x=1764018177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jx+mIImXSNDfgYqmNpofAZfv7KprXxOGtDGrhRPT+Hk=;
        b=TiDcj3U8S1ILsINQTFqWE77jKsVa1DujxNR/mdKTXMf8opUF3fY+AMG4Jiwzz4Y3SZ
         gJrbSncbN/8t1u+Boy8ODZvVqqQelGRbBRaimG7Z9hbK+UncdL3SgVaBYOztv0XNuqb5
         fwzSG4jgpPM9gN44l+mSKD2P9QqJ7v8giV67zIPIRxj/wMDlU4rKEQvN1mQZ7K64eo6B
         X8mtShRHo2pPeZ7Msyr/r5MRHvHzlAj2w4XMUTvyvAQAmzSjJQKQatFHnP2PgDTGdp0D
         oOcqbcYAlU7jzRVjlJeirfA3mwJtQfWxDbdbQGmu6IjfvuC2TL0qcpKxX0VBPELYEFON
         +fhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763413377; x=1764018177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jx+mIImXSNDfgYqmNpofAZfv7KprXxOGtDGrhRPT+Hk=;
        b=DcJ9my8L7J7YLSuRWAFNLlJTXsD2GGlx8KtJWumjl8l1tcn1ZH9legOA0SVmNJ5KMi
         D8CNJrlIHtTsHkAGtBK5v+Yja253UnxFPIwR7Dke/cfDIIJmykWX2+3FsjKgx9RCilss
         bJG17k8NrYkG1Zzc30/CTxlfgSYonaI9Vcr3Suq3MrfeysfUSVlnW/sRT/cUQU5TF7l8
         uPV/OpNguBkmq/CBVhHVCTyW8WxcibBrn96IVfBA36imJLw7hljU6oM+eS8XfREz9KFN
         nvxj80G29UFxsjFBIM/tHN0Wmuh/m0tAnHQoctAgELr6VJuQOzkEnEUXDyFgdY8RIGbb
         GJxw==
X-Forwarded-Encrypted: i=1; AJvYcCU4TZCAjD+4Ma4a4noN9r11oD9PIg73Pi7ZZdHuIgLBGErCltpKUaa3zJlnAj+KIXRa7TgXSY/EmsQuKVFYTzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMZCbM/0wNg0+ty8Ka5W/g0OPhpD7bFt+vZRo++5d1KMjJK1IM
	nZSvmUj5PjV4Kfey9rGwTpeYMxmqLOc7dlDgrv5fugeqfHje9F3V6P/WT4QlRNEir5Nl8YnX0q6
	jLAFeirYePMcybHQDPuvaOkGW8XHwFeQ=
X-Gm-Gg: ASbGnctOfWMOZvrvK+v5O/jORGNkjzNao/jIO8aRgT2U3GzJOoM4++APsyU8wvCNk3e
	6zlhDRbs/pHrnHmx58woMpcwib59yadTrneEaq0zNDkk7dTenWWWXF9SWsbFn9Bhcv71cGjYUX3
	T+rBmIdYJBvXPPWJfJf0pvNX19DO0eGwTouShWVOtTJgGQb/fDo5Kt2l3fxrGLm1w5cbMzF8lM8
	c94XEzRKKedLltciskuNA9izgTlxgbXQNZxxUHX0BckUtIzwJX+bUcFzqSmIa6ZkMws5zNNgE3R
	4d5BcP7Ncpdo+JsVy6rCAcU8/gItiR0VBnIyzojFb5ZwK0nrAwuGMAZVey4z9G/Gf0wWy1uFPZA
	BAdA=
X-Google-Smtp-Source: AGHT+IEfpg5rcBX3WhvIWQ/UIkVD2lfXwiuAfVldmSreQrz3l7c83vqeEp8kW1iCh0Sg9GCSFOezGN+qgrUI5cjThig=
X-Received: by 2002:a05:7301:19a3:b0:2a4:5129:fe99 with SMTP id
 5a478bee46e88-2a6c9b2447bmr78698eec.2.1763413376824; Mon, 17 Nov 2025
 13:02:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110113528.1658238-1-ojeda@kernel.org>
In-Reply-To: <20251110113528.1658238-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 17 Nov 2025 22:02:42 +0100
X-Gm-Features: AWmQ_bkaYzRIEOl89GTZlEKTMKuZ_To2Yp8qyNl_-3c2oE8WhLT2HaZf1WZMoBI
Message-ID: <CANiq72=n3DGg0gfrVq9+b41Ri6M3efWZxnzqwXkOFRt4ozN3dA@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: allow `unreachable_pub` for doctests
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Rae Moar <raemoar63@gmail.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 12:35=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wr=
ote:
>
> Examples (i.e. doctests) may want to show public items such as structs,
> thus the `unreachable_pub` warning is not very helpful.
>
> Thus allow it for all doctests.
>
> In addition, remove it from the existing `expect`s we have in a couple
> doctests.
>
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Link: https://lore.kernel.org/rust-for-linux/aRG9VjsaCjsvAwUn@google.com/
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied (this one only) to `rust-next` -- thanks everyone!

Cheers,
Miguel

