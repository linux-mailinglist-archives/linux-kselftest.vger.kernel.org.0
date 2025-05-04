Return-Path: <linux-kselftest+bounces-32294-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11427AA8982
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 May 2025 23:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4D2418946C4
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 May 2025 21:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83521C6FF4;
	Sun,  4 May 2025 21:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m26nEYiP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B0C12A177;
	Sun,  4 May 2025 21:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746395688; cv=none; b=U5+jre9ipnMz63QeHCGOPiLk7zW6rDv3HgHxW2AqV3WGWOT++Dg2XXsGQGaHdkQzJzBKKfdLWjf1glCWFLhs7MwfbrovNI8CRml3oZ5HJtrnBQwG+moHPx6W27u+z3bIsSiXbdJN2ZC2wbi120Rvyda7C4rn9ep7aFhMM5f50W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746395688; c=relaxed/simple;
	bh=/l+1MvI7GiT5veI5LytixczDbnMXe1+igUv8pI8VedY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lip7Dq6k7UzSoT4LKiSc2yeLspGthA3ase+6f2+dfjSTd+WF9AkfoVLX+c6+OTN3mKc8bDktzxhLCBRQ8FjCRNk8/MX5rAniPSDEg19UlbUxYBuc4LfDZGR3kAGjFQzSRieTGdwF/e00AXzyQ4vtXTsupNyI7fx25Pby6YDCGYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m26nEYiP; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22e17b7173bso3659845ad.3;
        Sun, 04 May 2025 14:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746395686; x=1747000486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJZjw8+wVh7l3iylx7BP6JrAtv+cQBGrHFy+Umlf40Q=;
        b=m26nEYiPKnNkPfBdEHsxvBNpflpK/sO5CSaD3gZHMbKfkyAtO/w5hMN7nm+agjDkgY
         rLkT8W2rb1hIb+XuTJG5yMJ/nbgVgSe4nUjmvrtERKTMWMyh3BjruEMgCB1i2Nuhx8qL
         8L0CRf5Try/1VuwClMdkqAKt7IB7prPSebdyZKRQroO5WWSkqzV4DrkWPglLD6aBueFV
         3QHS97OJ5kTRHIk4qnOG3djyWlSzxvkoHx6X7rv/A0wcjs8ACZx165/D0YlO4ysTzqKC
         WIybCrfcF73TXT7WWSPDZVXmhuntfQZzPiIE6WMspfnaUjAcGRLOOSLgxbLuY18hOizJ
         FqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746395686; x=1747000486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DJZjw8+wVh7l3iylx7BP6JrAtv+cQBGrHFy+Umlf40Q=;
        b=PRC8fT7Bp3ZO4aBMz2+4EVsxJgPGDt0glVQPrMflQpkZ32ZXpSoD1q4tLDi9J5bb9p
         usgdqNGOaeXUXltwjWux3n7KbezUUrz2nIAEdWuASETt6YPMOUSBflQiCm6sWDASMrzs
         Mrf6qt/9SIo6GxmgIj9IBu3jXHUaHooIRlKuhSjZ98khak+/5kFvuiTl+buH+1dXVTV4
         QESUoFK82CMqlgDd0njpcMNM/DAmMrHq1VK7DlKmFWJIT2rkKMSd0ZXRW8xeELgt8E1F
         AXLBvUF+ICQBEFafHEmw2CrigByJzFIp/vi+vlxwXneGvVBElE16gqu18utQ+H0Rxeud
         1rFA==
X-Forwarded-Encrypted: i=1; AJvYcCVBz9Mblz1mPwERqKEufmm5q+BsQMnv+x0nXNMm2AiQQH4oQR7HyEmwc/3Lw2+sCU8Jnb7TFaw9v35xR17e+K00@vger.kernel.org, AJvYcCWwloETWZk0cGlut/MTTr2+j5a6EW4hjDJxCSbagPy6vpyKcfHO7OxEcus+tzHxtMbEtl6Bh/WlZi1MA/k=@vger.kernel.org, AJvYcCXKRseIdVIIl3S+orSYQoqU4YQbiEsdsJ5guygHxiaxiQCO88YZg6uaWHqqdCmxDUw3BgpSeVVrFzZRZFbbF1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaKBaNedIbLknfBo+iDAILAQjrdLwWUIARdDqzC+vCA4AMAU55
	lxU4d77s7+TjKRcJcsL4Gp+o+JNm5yUaJ6m546v+HEaDOBNZv8NpIOuIKd9QkYEe3V4JiuXrETW
	EIfm2RkFfE8x0LPR+Z1UVEtNVeeY=
X-Gm-Gg: ASbGnctcQQn83Uu5ythYjf2TCkS9f25P4BU9B50W4sLcDaCNa7/sTUPQQtREhczC4ET
	7evX+ZcdHXnguH+TcIz1VfzUDGX4Zl5HMXL3Ln8Ipfg6g0K7yN5J+9vkIAbzW6aRABAC3fSt/9w
	WohFmYhF8aCkQAI4JBPKpQqg==
X-Google-Smtp-Source: AGHT+IGdRAz15W9ZI5e1vtLXdhvXxSEUGSGPLW8JUTr/B9AnQL9gWGgZkz1pkGpOe9LOvI/UmsARew+FCAFE5sAYpws=
X-Received: by 2002:a17:90b:4c45:b0:2fe:b879:b68c with SMTP id
 98e67ed59e1d1-30a4e6c1a1cmr6287602a91.6.1746395686405; Sun, 04 May 2025
 14:54:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502215133.1923676-1-ojeda@kernel.org> <20250502215133.1923676-6-ojeda@kernel.org>
 <CAJ-ks9n7u3WkYmJCVc18c_cKod6DaB7KrA7NXbOuD3E3TYbvpQ@mail.gmail.com>
 <CANiq72nEHy5wvOyPzW4DLu9aE_MxTx1gq7AJ-f_Ny4E6bbOJ5g@mail.gmail.com> <CAJ-ks9krSxo_DWFJdccP+SYJhX4WF0hXdq-20Rtf3doMp_2zDw@mail.gmail.com>
In-Reply-To: <CAJ-ks9krSxo_DWFJdccP+SYJhX4WF0hXdq-20Rtf3doMp_2zDw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 4 May 2025 23:54:33 +0200
X-Gm-Features: ATxdqUHzESE1JbgdxZ5Ox-DqWnyCuIUC7SNpfqlQ8QGc4FkMOFcuq4OR1DTOBFg
Message-ID: <CANiq72kLz7nXOKR+f=pNCu=hEEs6XQV_oDr9-xB_sq7N+svQ3A@mail.gmail.com>
Subject: Re: [PATCH 5/7] rust: str: take advantage of the `-> Result` support
 in KUnit `#[test]`'s
To: Tamir Duberstein <tamird@gmail.com>, David Gow <davidgow@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Rae Moar <rmoar@google.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 4, 2025 at 8:23=E2=80=AFPM Tamir Duberstein <tamird@gmail.com> =
wrote:
>
> I see. Up to you, obviously, but ISTM that this degree of freedom is
> unnecessary, but perhaps there's a benefit I'm underappreciating?

Well, having this allows one to write code like the rest of the kernel
code, instead of, say, `.unwrap()`ing or `assert!`ing everywhere.

So easier to read, easier to copy-paste from normal code, and people
(especially those learning) wouldn't get accustomed to seeing
`.unwrap()`s etc. everywhere.

Having said that, C KUnit uses the macros for things that require
stopping the test, even if "unrelated" to the actual test, and it does
not look like normal code, of course. They do have `->init()` which
can return a failure, but not the test cases themselves.

David perhaps has some advice here. Perhaps test functions being
fallible (like returning `int`) were considered (or asserts for
"unrelated" things) for C at some point and discarded.

The custom `?` is quite tempting, to get the best of both worlds,
assuming we could make it work well.

> Even without this change, couldn't you apply
>
>      macro_rules! format {
>          ($($f:tt)*) =3D> ({
> -            &*String::from_fmt(kernel::fmt!($($f)*))
> +            CString::try_from_fmt(kernel::fmt!($($f)*)).unwrap().to_str(=
).unwrap()
>          })
>      }
>
> and achieve roughly the same reduction in line count in the test module?

Sure, the line would need to change again later, but that is fine too,
we can do a separate commit.

Cheers,
Miguel

