Return-Path: <linux-kselftest+bounces-32408-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B5FAA9A19
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 19:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FFFF167CB3
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 17:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8247B264A89;
	Mon,  5 May 2025 17:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4DqN/24"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EC818132A;
	Mon,  5 May 2025 17:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746464850; cv=none; b=JAcXlvf4i9Qxmv393UCvS+v1ZpnAWEbSas1uNQDZ4NGfpukyfmk6EPH+knhAACbGFH04KqXRyCp51/dmSuxQm2QdgdzAcdSPnP9QgRWDinick0YNYkSUzVLOoP5dL/w0okWK/HwZcGsGnzoQzbWFBOeSkVOc3HqrWIuslurHjXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746464850; c=relaxed/simple;
	bh=Wgko8I/m9BqxxB27PfRkqwDAClmx9QE/pUan8G37ook=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R4UyzfZTA6D9OJsizT/Euyf9V1WCwHcktj4fW9d/mDYSeIMgB1nu2SFrpQkcio5KGHPQGwb5XOQpzeAftcxySSmI9DcyQJkUXSbLRx1L1kWB8L0OXVqFhDFyfagfS57x3x1hc2U6iuq3tdXT/6AXSqiggB1WZqaSSTZIOny5M8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4DqN/24; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22e1782cbb2so3346965ad.0;
        Mon, 05 May 2025 10:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746464848; x=1747069648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wgko8I/m9BqxxB27PfRkqwDAClmx9QE/pUan8G37ook=;
        b=a4DqN/244hiGlIpVaOp97ncK//IfBYjR0y7koJmhp1CMFEmCyWB/3Sm1zxvXVTOcTH
         BJuKKYETTEaoNYevdOMNlMpJRtTL0cssN/AABiXuTxnQIYPOTP22n79iUsna26iHX0xe
         7FDokiiipxqGXJqGzHDVbO5g3vbdVAFSwffuyAprN1k6q3ZsKegHRQq31wmM9W2WAMSb
         zaJrlcc0cFpd++ITiiuc21PONJ5d67Y+TlkppwoyGWSmxWPU93h9j4UKXys7RoS6UXDj
         syCbioGs36mKHu0HpxoXKZ5bPi25SPES/PUxF8RSJ7GJtrWSeTCd3y3pr17kVeVUMApM
         UIaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746464848; x=1747069648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wgko8I/m9BqxxB27PfRkqwDAClmx9QE/pUan8G37ook=;
        b=j4jNZe52r3sM53c9qSFSyh0dZgfjTh+9ritGjb0whcRnM/Je4ZXRsmpNLVjVpPygGZ
         pXshYQA4Covtknk3KD2kP5s0VcfOcTT/QHRAvjKi4X/30Z6DF4fPx717NMCUhmOr6IQl
         tJWm+0yEPaZ+irl6pZBfVHulqYkbc4fmDVpls9rdlPA4sG8yFJaxJSsVS39WCFCnTr4v
         VV5c/nA90vPI1BM7sDAsV/s+GsHUF5IxBIpYQa0m6HtypqtbD2TUngk782V7UpbwivNL
         ut5cttYPUXk/Z9WgxD8qChDtXL1535ycDgeFFQgTHkID/IU89DGgXokCdkVxCqAA3D/c
         7plQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5dd5rKHR3+C5T5f1VDUhYf3dRoXoq6QGjiHfb/q5JDxkH4p1/L4GeUiGiqS/uUqxjIjmcguTcozYMAmcmckY=@vger.kernel.org, AJvYcCW3tzjuT1J58/q/njeB7M6Xj4DwkGOagFUbplwjWS02iBa8zTTaYonQTU9RPjkU76A4GocXvNhWvj3XPZxPxtws@vger.kernel.org, AJvYcCXAsJmQ8ruhRrMy7Rrdb/C3LQTxaq7uaNbARf2rK6HCMCKBPY7os4w3DwMjeK9j+YqO3CJQ8THDCQjLHdU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4x4DBYLMh3u/re1Mdx5OG+UAKR99YBHEzH9opda//cKtdmrG5
	MHSLwxEq/7/wNYYroW0y+DJS44ckPARVCEPrSxoDR9Vb3UX5w8rf2fsa2uSJTzwFJnVQMPYe/j6
	NGRsvWFoTBIuabmnu+HjtnceiTgI=
X-Gm-Gg: ASbGnctBrJdTbXJpnE6wpLlEUSpVnFZg1dAap5tK6mqiTnJhAtIdBMdkwnW1b3yYHxY
	Lz7WjOYYMrIBbHyEziffsyhZzR/oVcEZczy/njogi4nBo9p0j3s9LEkt417bJg6j1IyO+fGYv+m
	2KCM9Ws4aQVMPYW29kFrwl/w==
X-Google-Smtp-Source: AGHT+IFLxWjul1SJF7ZqOgOBbbo9BHWzWJnRRxBf0NBIcb0vX721AMZ+hB1vr+RFDd/SU5sNyV4H1Xw17bDGwqpnmp4=
X-Received: by 2002:a17:903:1905:b0:224:10a2:cad1 with SMTP id
 d9443c01a7336-22e10373938mr79787315ad.10.1746464848170; Mon, 05 May 2025
 10:07:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502215133.1923676-1-ojeda@kernel.org> <aBjuCIHH1ZCIVs_0@polis>
In-Reply-To: <aBjuCIHH1ZCIVs_0@polis>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 5 May 2025 19:07:16 +0200
X-Gm-Features: ATxdqUGrqf4jwWLSpQZ_Dz46MOZsF8WvrNskaiy2DPAE2SfbmleZGwbWqKSwNaw
Message-ID: <CANiq72mKKh437k7HQBuyr+oBqAZ23Z=VKgo42TnQjD2s-VoF7Q@mail.gmail.com>
Subject: Re: [PATCH 0/7] Rust KUnit `#[test]` support improvements
To: Danilo Krummrich <dakr@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, Rae Moar <rmoar@google.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 6:57=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> With that, do we still expose `alloc` primitives to userspace tests?

I considered removing a bunch of stuff (even the build support for
non-`macros` `rusttest`, to be honest) -- you are referring to the
`any(test, testlib)` bits, right?

I think we can wait to see if we need it, or we can also just remove
it and re-introduce later if needed.

Thanks for taking a look!

Cheers,
Miguel

