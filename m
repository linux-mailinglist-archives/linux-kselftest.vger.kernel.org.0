Return-Path: <linux-kselftest+bounces-15847-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9A0959B4A
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 14:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66B9D1C21EE0
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 12:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B700F16DEA5;
	Wed, 21 Aug 2024 12:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="el4ac9Ch"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05A61D1305
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Aug 2024 12:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724242141; cv=none; b=SRKgJKxH6hjM1t3g/P4eeNSO9NA1Gagz8hNdkcp19nC2fnlIgtrTvlA7ZlNyv9TOrVocjjRjGxCIgV4BdSkj8viw5cT/lb8wD05idsmIF/DG0p2iazHbv877d3yxyhVtG42BYyEDUyRAnlYorvy4C97oPvqd7GUbMTVk/mjRzqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724242141; c=relaxed/simple;
	bh=DA1X9Ve0Vn6diqrYfPjFkkduWMPJiWV9pT4xIJEPvqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T7l+a6nWBATCZoEy6CPcWbRXG8zMw51w/i/KbEvLC34I3fLcBhyu1iRvO//xR+Zsz/4Ludakq7Xbl8dZo1nBW7Xke00MFAw49Aap1LPk7mFTYu1puAJWSVedoCWdRtYHTuusDYk+kmK2RClKFqpVc+ky2gjXwMAiE4REPNL/40k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=el4ac9Ch; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37182eee02dso432313f8f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Aug 2024 05:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724242137; x=1724846937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mDwqhRHhMBQJ/+TLyoRpyJFlfsxxIUrIdKu8FSn6JKQ=;
        b=el4ac9ChIdU3dbBwOzt1Ipwcxb58MCdsiuKZO3aBWpLg7jNbUs066ybdpBPeCYXCTn
         7gicQIB1zld37AXYhH5LqLi5QzYsaMWDfWln8mU8FGHaTmcwg4plNC7FxPOCOVr1WoeM
         YJZOMOBMehuGPWIDYYukie6A1j0LoQbimC9sEqdsljqKu2F987/mcxABHlMHETQXW/6z
         2PlpI3gKBbvHJPY3tna82klmpc1iFjRXYV7Gg3MfHccFrdUy+/skUWRs5xU34Y+v9IL/
         xCOcuZhEAYb1Wk5NB3832Z2tKroexKQrUsZfhTf+V0Zy/o9NLuwfCAnn6Vdx9huXTllR
         ODPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724242137; x=1724846937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mDwqhRHhMBQJ/+TLyoRpyJFlfsxxIUrIdKu8FSn6JKQ=;
        b=LJELtP90c97fZg6HvQ0pEOlC+1TsVqncFGh/0tilXVobvsBXZWRci1WYuSp5Cmx45p
         ZM6hlDhp9NoUE6fGM+L3PAgjjbCL9zQZn1XeWE3DSdXwFnRVHfa8Jq+5rJcRoEOp+HPy
         hPyvhBlVAGafVEiLgAr91tyl1h/sqNh4In7pPsG/beKbglArEKpD1pWVTEW0LXl3kZOD
         LJ3jokkDHHpYBka4haPH1vKF3KQOj+fqk7M3Ntlp2ZomYjt0NZSiYA/FFt8DCJjjUUnw
         mpxnWYqKoe59UaOzvR8faChb8tym0vxfwt5KdTorZNcrvIkfVfL0Tal2jGo2ktf2fOEZ
         lO5A==
X-Forwarded-Encrypted: i=1; AJvYcCUNw/fOxhelpV+sT/5I88ynM+yd/xAySmzMFb/cCVms001hTA79BxGCArHtq1a9+0Bsuolij3eHlD6vBpyZhJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLC0L50rcOFue3lPIf1okPE2a3DPQT0Zoh/qdph0BNOXE1rZgF
	njkCyVQP7RLpVCBR+mH0hwafSRjN+tWekPt3/rRU3x9A7IpdEMNnFYgEzswlHrGNBS1pnlJfshC
	RFKwoDJo64CTJcrbXhQIc3MO3QjkDA5n/hJ8c
X-Google-Smtp-Source: AGHT+IF/+B4e2rOwDucRvS4kWT6EeKo58j00U+Ub/62J14Eex9C5zjjnxt5zAjMaLCrIZo2JrYvwnhV20MJ6wjBJhW4=
X-Received: by 2002:a05:6000:b01:b0:366:dfc4:3790 with SMTP id
 ffacd0b85a97d-372fd98d681mr1189198f8f.0.1724242136775; Wed, 21 Aug 2024
 05:08:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819153656.28807-2-vadorovsky@protonmail.com>
In-Reply-To: <20240819153656.28807-2-vadorovsky@protonmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 21 Aug 2024 14:08:44 +0200
Message-ID: <CAH5fLghOFYxwCOGrk8NYX0V9rgrJJ70YOa+dY1O0pbNB-CoK=w@mail.gmail.com>
Subject: Re: [PATCH RESEND v5] rust: str: Use `core::CStr`, remove the custom
 `CStr` implementation
To: Michal Rostecki <vadorovsky@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Trevor Gross <tmgross@umich.edu>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, 
	Finn Behrens <me@kloenk.dev>, Manmohan Shukla <manmshuk@gmail.com>, 
	Valentin Obst <kernel@valentinobst.de>, Yutaro Ohno <yutaro.ono.418@gmail.com>, 
	Asahi Lina <lina@asahilina.net>, Danilo Krummrich <dakr@redhat.com>, Tiago Lam <tiagolam@gmail.com>, 
	Charalampos Mitrodimas <charmitro@posteo.net>, Tejun Heo <tj@kernel.org>, Roland Xu <mu001999@outlook.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	netdev@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 5:39=E2=80=AFPM Michal Rostecki <vadorovsky@gmail.c=
om> wrote:
>
> From: Michal Rostecki <vadorovsky@gmail.com>
>
> `CStr` became a part of `core` library in Rust 1.75. This change replaces
> the custom `CStr` implementation with the one from `core`.
>
> `core::CStr` behaves generally the same as the removed implementation,
> with the following differences:
>
> - It does not implement `Display`.
> - It does not provide `from_bytes_with_nul_unchecked_mut` method.
> - It has `as_ptr()` method instead of `as_char_ptr()`, which also returns
>   `*const c_char`.
>
> The first two differences are handled by providing the `CStrExt` trait,
> with `display()` and `from_bytes_with_nul_unchecked_mut()` methods.
> `display()` returns a `CStrDisplay` wrapper, with a custom `Display`
> implementation.
>
> `DerefMut` implementation for `CString` is removed here, as it's not
> being used anywhere.
>
> Signed-off-by: Michal Rostecki <vadorovsky@gmail.com>

A few comments:

* I would probably add CStrExt to the kernel prelude.
* I would probably remove `from_bytes_with_nul_unchecked_mut` and keep
`DerefMut for CString` instead of the other way around.
* Perhaps we should remove the `c_str!` macro and use c"" instead?

Alice

