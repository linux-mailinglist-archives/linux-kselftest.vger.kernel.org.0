Return-Path: <linux-kselftest+bounces-29493-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13301A6A4E3
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 12:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BC8B1889BBB
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 11:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A35021CA04;
	Thu, 20 Mar 2025 11:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpAZ/rya"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2661E3DFA;
	Thu, 20 Mar 2025 11:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742469873; cv=none; b=ltytqPU+jnYUXBHJ+Nawttot+0jzkhu7YUyD6A1IZiUjgTGIaijdpoql4eCSOVe+UwybdBn/ak2DCiHY4Xbw6zINzoDtNOjxNibEn7BsDf/m9VDhdS8bEWM4hDYhLJ2p49lVF9mfHB5/kuunG5uBMrdkGinTX9jt2gFX0zhvKoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742469873; c=relaxed/simple;
	bh=2AYPkrULStSTDiH6cCL/KT8b8UMZFP1C1MQK7v3jJU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uOWqMT0q9jx1j2Vks1A+Xs1O4uGFnLff4yYlGyB85Xmzys2PxVK5AgtscZqoMzXFFPSkY/LKfcQhyY6vc1AjNbTukW+2nTPWacxI0V2ykInlGRBt4XPwcCyVLagHsF2iIZcepXgY4rntsNlmufWaGbttb8PDrSvQhM1NLnuRjjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VpAZ/rya; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ff5544af03so177758a91.1;
        Thu, 20 Mar 2025 04:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742469871; x=1743074671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXxS2+1nlduyvT5jAyz8owwLa0xh/ALxgXkKxE0OOXI=;
        b=VpAZ/rya6sCYjDAN69qgBRaFvV/gLxT3FWWvSZPy7KQI0LJSo8yq7Z0aMnYNpkYLaD
         FDWefMmgmplolN0UVVXJPta1bKmyipSqUC7VRzUmMtXCqnnDBeBWUH+p1tBTXSbL8mzm
         co9UZuzwIN4cxvGepRhYuah5R3y00EepvPCEz0UnORxzGc1bcXe0laSXqszom3k6prV5
         fWiqHZxalC3vNFbwBycUbLpVwYwNlwrliLd1bb1EmihMsfYl9Zhq/9JFQ39VOCX9O2LX
         FUjujJBMINkGVv4SZet44Fr3c0JUWDZ2NQ/8WmVl00yMWINjvywOpG/iZdDyxCvfkBvF
         TxhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742469871; x=1743074671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QXxS2+1nlduyvT5jAyz8owwLa0xh/ALxgXkKxE0OOXI=;
        b=eoyp2QtBuNjYHgpjAYx95DBaX4FEoj7zBRyfeCJKjpTBigMfuAPFV5mRzh0wOJ6p1k
         A7khFZjbLTweJY5yUsfFPFhTCQXCQXDz/duEiv/Db+nhZTHXvF8vwyOucZPZejeXV1G1
         q5S4FVv4hENCd2gA0gmlS7UgPFd5zcotxa7UAoomR56nLunTy5aw+z9dCAQRKpX4qBtd
         vZpdBTU8imuPqiT5RN3p5iq8NeUEmyfx3IVua9L+x6aG0+69O28G/k+2laLYMdpA8l4D
         Lr1zusEbmoeeqjgeScvpDSMkz6ecvqQuw9b24uJyUdQ8Xdi1P8cMnbKu8fRuyHpj54AF
         5ANg==
X-Forwarded-Encrypted: i=1; AJvYcCViFRuUak8U3GYC8jtgPnZDq5GyMPWAMb3GblBg2uXO63gtGVDaI3315FYnwNfjnQJ8DrAdRBqbgELC/Uo=@vger.kernel.org, AJvYcCW7mQmZwqR9mEOF/MNsie4e6v7bjHYP8A+Yg7ywHcft7FJJb3LUeDIKhOjulfdul3t7F9EpajFLEYioqvNxeXJp@vger.kernel.org, AJvYcCXhDVhXgS4kj3yUphmtvED1VbIxFXG5OaHxsN8gK8ltuSW26jSNablxAsmk05CuYV4B93wrNbkY91M5300qHMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN1CW/2+nZHEJdhTKTS90/qo53/5ojQi8BD/uXqV1vMlDt4Fom
	Y0IxZdgp1pruaQuTKixSiVVMBJ/leYxE80IObHHkkMoyPLU0yEuShQRWpYKddWvXZeru4g27K3y
	GzuhM4dOtiOpW5G8mVYZ8iSW7Jjk=
X-Gm-Gg: ASbGncvBM0ETvbNIon+CerxVmLSCVfabr5NTZuxfHZBbnnLM1nhviCQ4YzhXe9M9R4B
	tBxed5dVe5GwE6Si/LuAZIJDgANT8fPlYVU51ErJwTuo83NtFj7Ij/dghyCUlGwiVSusfwaeS36
	SgubruOtZAGwZYNbGBj8CDlNjlVg==
X-Google-Smtp-Source: AGHT+IE3PLLJa59vfwqCcty3muPU9qlVHzuR9C3fnY4SjCyrJ87bygLZoiZUS/M5wRxig0JVExRf8MshAPDjoMcLnNs=
X-Received: by 2002:a17:90b:2246:b0:301:1c11:aa7a with SMTP id
 98e67ed59e1d1-301bfc749d3mr3350274a91.3.1742469870835; Thu, 20 Mar 2025
 04:24:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307090103.918788-1-davidgow@google.com>
In-Reply-To: <20250307090103.918788-1-davidgow@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 20 Mar 2025 12:24:18 +0100
X-Gm-Features: AQ5f1JqSXM9f71q8LskxtSEECf3N33mqq0DT2VzoMLMfgEbbELpw1_0lPJRaXYA
Message-ID: <CANiq72mi_9fJ2S=hoJnKSOvMkiuqX7J5Xx__Nn1nh9Rt=qVPBQ@mail.gmail.com>
Subject: Re: [PATCH v8 0/3] rust: kunit: Support KUnit tests with a user-space
 like syntax
To: David Gow <davidgow@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>, 
	Rae Moar <rmoar@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Benno Lossin <benno.lossin@proton.me>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Matt Gilbride <mattgilbride@google.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Tamir Duberstein <tamird@gmail.com>, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 10:01=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
>
> This is v8 of the Rust/KUnit integration patch. I think all of the
> suggestions have at least been responded to (even if there are a few I'm
> leaving as either future projects or matters of taste). Hopefully this
> is good-to-go for 6.15, so we can start using it concurrently with
> making any additional improvements we may wish.

Applied to `rust-next` -- thanks everyone!

    [ Applied Markdown in comment. - Miguel ]

    [ Removed spurious (in rendered form) newline in docs. - Miguel ]

(finally! Special thanks to David here.)

Cheers,
Miguel

