Return-Path: <linux-kselftest+bounces-45802-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF2DC66447
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 22:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C26A14E191D
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 21:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC383246EC;
	Mon, 17 Nov 2025 21:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmkbWEOz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306DE270569
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Nov 2025 21:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763414656; cv=none; b=il3/AvKyL7sYtTn6/L3s1F2WjlBnP61fBwg4yCZ1DfSQI3ABt8XcQ8KKQ1al3taW8EdbtsXApnJ3KdSkMbkjikoksm0qZEW3tOaKnoEvzJmL5RLIk10TtHeQ3fqTlUMLtsKkh38q616Lvc1xOFgCbiCSpX7iCq6W8VEZNr+H4j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763414656; c=relaxed/simple;
	bh=G4tcmLmD4TGgP90V5T3RjMU67lyU6CakfI184VKf+7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GfSYaDflMKmi05qSFm59YkngrWMmi6iVsSPgch/NXjGlrIRPEwKjLfzhZx7MV7KTw5H43JF0cYY3rB+M64+ZT3EfU0Xf/Bbnm7pMfqbFTWG5s91w4Uf591NphJ6b6EEPijZmHjmR/yI2IVPsQ8QEdMXM5cDXkKOyKsZejnI7fhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmkbWEOz; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b983fbc731bso344045a12.2
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Nov 2025 13:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763414654; x=1764019454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4tcmLmD4TGgP90V5T3RjMU67lyU6CakfI184VKf+7g=;
        b=BmkbWEOzBqT4iabrQZk4EwrkyAzfPKLjh8KHi+zwGIkdb2jRC2uSsKb8I3TCQVX8mA
         NPyOHkFa5QLLqV4kFMUSVuu0enIwUweZ7grTSe556Os3onthWKoaPNCoLSlxNFNFT1Yn
         DD2/Kxnx3XmW07OvjfVv91btSSyWHDy6fig2+LOX80WnfmNNQyXcOPT8fetphBjJzNWY
         2tMncdY/PKX8s+PgUhxGWF7GouWBCPFtIndcMR2BkDLysk3v4eG0oVTnp1C1aOlQD8hx
         OxV6aoqQ4vhMuage0y+Aa4YGN8OiTujJQBExhoSXCrX403V385tAZ0zMa/O0H71E6dEx
         9b+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763414654; x=1764019454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G4tcmLmD4TGgP90V5T3RjMU67lyU6CakfI184VKf+7g=;
        b=smosnOMEcXAVbdZ3WCLMQXL90qo3D6flH7rwx1YA7hZIZtAxbDkLlsfKr/4kDrrl/g
         da5Ly8bOCfDLkLMzczL9UOuIsz8KpXmYhyCBI920b9Au54NMW9JnCi4kAXASu8khCCw/
         LhQEyAsDap3uxjNYqV0383iN4Uuf3VCKWIE+WTnxUK4181Rq66DuVI7J+Pl0XA8rKPy/
         YkPDigUxmIrccEsoq9TK8U+97gkPeOdQA1pZVEorLfJbGZCkU7CpxyO9X6zcTERwVtzK
         M0X5/nnbg+7SM6lLcQzSlZWPRrMchF6yxb1C7qK5WLTx2qOhLJaLloa9nDHq1dwnmTlp
         lmaA==
X-Forwarded-Encrypted: i=1; AJvYcCULAyt9ULzfbIi1i9AtATUSOIQ0O6inayyHObdKpaI3SMoU9xzUOS6Ntr2yLGr0yjXbevZFtTZh0XmKDIw/Clo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFQQU37CndCPiBqP95YcHSpNf5f4lhlVPAB45bHhKR/735jLHR
	3QKoQRArjnHmL6bzsjZTrlCrbtm5rytyGMVI1cT7d4xiXCyDKTNb/Bu/NDIYCAbx90SjFRqz/6L
	+PCCra57HfQpeiBIkJGfUwIOu5pcpqSo=
X-Gm-Gg: ASbGnctDv2nmAb4tong4TB2OCib7s1+8tqhdFbjoCG7XjkztKtFHwW3lZogPwckPEGj
	RTCIzXRU5nABAt0xOOwxODtRPXkvVn6Ee8/oqLWPXyZhJDC3ESIIA3eeBHJX46tqw8+MrXWKSUZ
	whywt9rfhWgjpSRtX2K3vcxDsj9CpRq09EEYS0OjJFSAvUfG667UawyXDepittEWci+zd+95xbq
	FCq4nyIEde1pEwfsBf9IQrjRSg/5/uI2VbfS/TcbhjTURz7YL5Ep0F7fsTAK1NhCIQfXn4+JDkO
	BUV+Cwpb1ZM2+iV3HkaUE/pYLKytOanMfzIKe6BZJzeIusGK/pZZ5rpsOI5z9Kk3fH61cbNT64c
	tF+Y=
X-Google-Smtp-Source: AGHT+IF5e9mxc2TlUqR/IuIzDsINCnyxiPRtbODMMA08p3mcq7TW15LDpP62M3hfNnb4H0E7VwOv9J4UgcE6VN2HjBo=
X-Received: by 2002:a05:693c:2888:b0:2a4:3593:5fc6 with SMTP id
 5a478bee46e88-2a4ab7784bcmr4270948eec.0.1763414654473; Mon, 17 Nov 2025
 13:24:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117080714.876978-1-ojeda@kernel.org> <CANiq72=-w2p8sQgUKYgPG3Tx9GSUNgcVUp24k0ck2RqYgupCVg@mail.gmail.com>
 <da4877d2-65fd-4ad2-ac31-68d55bda7c07@nvidia.com>
In-Reply-To: <da4877d2-65fd-4ad2-ac31-68d55bda7c07@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 17 Nov 2025 22:24:02 +0100
X-Gm-Features: AWmQ_bn2evH1S1qhbERgt7QMqGn0X-tvVoVxDBYpFTLNd4sEA7R3dYLfxUq4l5U
Message-ID: <CANiq72ki4nMTzTnLN2hH6XY_88=dsEYO8fxr=rUaDnxktPtarw@mail.gmail.com>
Subject: Re: [PATCH] rust: allow `clippy::disallowed_names` for doctests
To: John Hubbard <jhubbard@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Benno Lossin <lossin@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, rust-for-linux@vger.kernel.org, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Rae Moar <raemoar63@gmail.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 10:13=E2=80=AFPM John Hubbard <jhubbard@nvidia.com>=
 wrote:
>
> Is rust-next a rebasing branch? I was going to request a non-empty commit
> body, in order to make it more immediately clear what this does. Somethin=
g
> like:
>
> The current set of disallowed names is inherited from clippy's defaults [=
1],
> which are "foo", "baz", and "quux". This may be extended via .clipy.toml,
> which so far has no entries for disallowed names.

What do you mean by "non-empty commit body"? The commit has several
short paragraphs and mentions the `foo` example (precisely to hint at
what the lint does).

But, sure, I am happy to add a Link: tag to the lint -- I typically
add those when enabling a lint (e.g. commit db4f72c904cb ("rust:
enable `clippy::undocumented_unsafe_blocks` lint")).

Cheers,
Miguel

