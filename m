Return-Path: <linux-kselftest+bounces-33809-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B91D0AC4316
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 18:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F2507AB411
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 16:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC5223E336;
	Mon, 26 May 2025 16:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNipAPOW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07BD202997;
	Mon, 26 May 2025 16:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748277184; cv=none; b=uB+CRrcHK1UCU+wLEiM3DkJ35Mdx/+lTbQIAWTcTLVhj5VMIiNZ1qYQPCIYTZpF+PT8JnejGkfa6aquiWud+Vyi7DtTUgdfyyANLmpWfq4R8BDV3cKH+OBTCgJG7J9wzOpvev3h1ZNU7jk6OKtj8BMTPbJFksjOCG7NcgM+CD90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748277184; c=relaxed/simple;
	bh=oBX3nGJZkm65kJYi/wZh7jMVYKo8z9H1xxl+NXM/IVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iQnvPVE3SvqOUuqCMVlj8skjj5xb7TnbWLFADEg+fqh+CXnwjJXGnzJKvvBUY10O1uYo5hifN6UHNU7vor4XDahSU97p5bCUZa2xW2RLL402k2PwDktIbafCiVVbJlcfiolu9lOWzZSS2xeZon72Y1U70nbVsOTSn5qSgLw2+dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNipAPOW; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b2700de85d0so215390a12.2;
        Mon, 26 May 2025 09:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748277182; x=1748881982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oBX3nGJZkm65kJYi/wZh7jMVYKo8z9H1xxl+NXM/IVM=;
        b=iNipAPOWPkmyskPWL+aV/64+DloCE5SBZyeMN1iDbwuwYjWowo7eZ3nK9rwXuDvB4w
         tdE2qX1Wqsk7HQ/J8naNsziEVqgwJanFx2cuM8StQjrFkL/HFr7wz57yA8k2hy19qRlr
         JHnQWhJd2I+x6rGE0a13XnY8BY42ToiybBJyaK9Qid+4h5dqxJh4wXlc8uWDF20ITslO
         SjCEuce2jgXTfQBFxgWnoM2LRiR13R/k867z1sgD0mnSkH8hnpGK7cg+fincM4LIBKNp
         top5HBzS7JiyzD30oszWXKnix1K3cjuS7mktzn35kfMUvjPIomHnMP3Kn58pLGMX/F3k
         J25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748277182; x=1748881982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oBX3nGJZkm65kJYi/wZh7jMVYKo8z9H1xxl+NXM/IVM=;
        b=fo4M0Xp7WltWbBQZgJhnSegg/22K5n10o8ewPpDPZM5NQruwS8E4/9YVO9H3ogX3fE
         Q0BRZ09WUpg71li9wOEe/ZX2V8Ff4fbDPkZeAqcOLrn5XyWK1R+wG1miwYmJKoC4l8jm
         PAEYKaqJBQvtVAuhd+Fii6xWABkFBaH1RExOvvC/oPHN7RQAmv6Tq92zXGBly6vvwcrW
         yjHVKQVCrbQdvDtOQwEE9lVRwhXZsCYuYtBa1zKNe7TWVdr/Y2RWsHfjU7yOJB+u4glf
         MGpfE4vEvVnqIpUR9VeKyfsjqivXzyYqaHgEirB1kPaym0sqMsOVUzcxyK2o8ZxfXBOK
         d8Tw==
X-Forwarded-Encrypted: i=1; AJvYcCWibOdGn3uhr/a3JCH2btiOyRhMaAqvQqWP+m4ng6ZNZUcmGdPKvgj2RlVjh/DJ02ogA5dn45LVCrQxZI+7dUHD@vger.kernel.org, AJvYcCX57E6lS6duCAkAAEvHu2MvRIlLvsaGX2OQN1jXZmb7dwD8J/UhElATLh9+6F34FAyXqokios2KoYsIKto=@vger.kernel.org, AJvYcCXqAr9UKt+U4Qq7Wjx048uUTIqF9PeIKsQzWl/4xjBGXcBqc5eyLsknm0Pyr3VW1TGoMbwie2hxYKMZaYhMbVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTAp/Yv45OT43YqRdHOuBETirAP8VjaPnxBAqsEN4HnpklPoUw
	7sLtLrT6z4YMpFwsTHjWyiwiMMYK0C6v2ED+iBcTIVVNrLGph9R/sQ4uKWB52NOe8YaKQk2P8Fh
	KzeCpQIzk84ghJl5WWQiTBOAqwGsZwFY/zaEWZYnw+/Hg
X-Gm-Gg: ASbGncuVimJUgGm4ApCRitFliB1BwGu6E1kRdkBGU4Dnq3/Mpz/oQpdR4YIWKoKBAcM
	i0tSqy/hjhWCo9vJdPuO3ewOFB6VDhN+1qokGss58W3RpgcUgDwZQFej3D/heYHZGApR5W7+DYj
	lz7gIU8RcZgkE/kXM6A1gkZ5zlnlla9iha
X-Google-Smtp-Source: AGHT+IEeSG0n7ehhVOoESnQux1xpNOuBanOUMCLNlX3yyDGthV4KhuWZRSp/Dq4T8uCR1SZVJ++rnFMO42A6T9LVFtg=
X-Received: by 2002:a17:90b:1b51:b0:310:cf8f:48e2 with SMTP id
 98e67ed59e1d1-311108a0e9amr5921408a91.8.1748277181833; Mon, 26 May 2025
 09:33:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250526162429.1114862-1-y.j3ms.n@gmail.com>
In-Reply-To: <20250526162429.1114862-1-y.j3ms.n@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 26 May 2025 18:32:49 +0200
X-Gm-Features: AX0GCFtaEjDrnXGZgOSiQXbYSiqvotIG0xz7ZDUZgnA7xOt6QSocK4DknJ3FBX4
Message-ID: <CANiq72mGiQeQPZY39_URhTM4-3U2Pf9WvWETfnTMAJsfpH_NyA@mail.gmail.com>
Subject: Re: [PATCH] rust: kunit: use crate-level mapping for `c_void`
To: Jesung Yang <y.j3ms.n@gmail.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 6:26=E2=80=AFPM Jesung Yang <y.j3ms.n@gmail.com> wr=
ote:
>
> Since `kernel::ffi::c_void` is a transparent wrapper around
> `core::ffi::c_void`, both are functionally equivalent. However, using

Hmm... It is not a transparent wrapper, but a reexport, right? (it is
not even a type alias, like the others in the `ffi` crate).

Other than that, the change looks fine -- thanks for the patch!

(By the way, in general, please provide the `--base` flag to
`format-patch` when possible, since that makes later on applying
commits much easier. And it usually doesn't hurt to have a "Link:" tag
to the discussion in Zulip.)

Cheers,
Miguel

