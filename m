Return-Path: <linux-kselftest+bounces-36154-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E960AEF1A0
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 10:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04416188E918
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 08:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBBB222590;
	Tue,  1 Jul 2025 08:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ao0bvY5m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60A01E833C;
	Tue,  1 Jul 2025 08:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751359580; cv=none; b=L21nMRbN3JUKtTe8fwilViofv1B3TpgVv7NGvweGZKpFfmh6DgSwTg5QbrVapPXVBMEOA7Ahw3vNn+c0PaMRFHgU2k+8pM7RH/TJ9iMHgpTd8xixEE8/0Jr1pEv0d/vI2kaRPOP4OwJoNaGhpHqYbxgYd/34OAkO5lVCwjC/RjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751359580; c=relaxed/simple;
	bh=adu+8i0sSmJ/HE3ZQgmBuKqQJ13BpqfiMhweYdrG56Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fWsK113Pr/diFx8T/hwqADkv8lSE4JNHkNTwaTpE+aTMdKg2+Zr9xDXNeKJvG4Zsgva5EB38cy30JdtcZq4jcainv+rPwQy7xsnSvSbCVluWODEdl0tAl3YZAF6Wia7aCSDHRhEJos20kEzDf/L29qMbXzLsi6l4R/r+58SHWaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ao0bvY5m; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b34dde96cbfso424939a12.2;
        Tue, 01 Jul 2025 01:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751359578; x=1751964378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/v0xD6UvnMJc03nf121OpAGHnJPH1i49Y2f3p3BdBU=;
        b=Ao0bvY5mlnsQv9k1okNkEF+WiKH4BP96wrWJOe/D0HZQQegu5AWWszpSoVuUZGbuCg
         3XK128wsSGefs6ga1ZtZl/VxDYI9L6Dx5L5jNCNUba2BRyYtlOXowfWHK7JS3RvlWAdp
         xxxGOmoFXT+hEjhR/v4/C5s8bIDbP1pU0kp/BbRtyU3si6Cd4tNWgum5t7vmRqr592lM
         LfK574d78SoK+xnGdS9vOF+NsPj+/oL2oVfipVsbu7x9PUtTqRfpsmaiCU/b8XO9cfwi
         v4tFsxU4pFK4MmC2BSZ3dwoa7J8mbZSMdCloaIG3+yMNkVptERPNzTp5d7hU1ymAxVIJ
         6/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751359578; x=1751964378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/v0xD6UvnMJc03nf121OpAGHnJPH1i49Y2f3p3BdBU=;
        b=L4oey5quoH0Kelpb6SDB2cUdduo40MZjy+Fbz6qBPXz3Tr23D5MXfQSilZP20J6DgO
         L+JaSjqPGYOfhZ61oX1UyeCoHT2YzgB9L4MWEcjASRR9ZnHK2MEPK1Tgh+fScjIf+A5y
         A3siyNNc6xZrZdeUOAS3bB0kGvXiP9gOdjbuEp9xaeXZFNYQFei2WRgdHK3zHFTuTtZ7
         wquxRCj9jDtsjQWFTRC7YQeZklHfAkpj/Htp+18fs0vVN9FfTvZGRGgACiqn5a9cssnH
         cWylYkN4+RCB1/KW68WmUVrEr+mrPRSk84XNdVxgbWgLmN2q6DUWD2n1sjlI7C6z2Acp
         qidA==
X-Forwarded-Encrypted: i=1; AJvYcCUnTr/YZUFn2yDhVDyThtf6efQ+c+bsK6g7+JNBJd3teCxw19IZZsExilBtbaOQehWBjYJGJwthacg=@vger.kernel.org, AJvYcCVjSFfJU8QaP2vU/YDoUwZAl/S8jyPpNxAtsiKGjiLeLnzkUo84qGnXMEgJQgHNGvbtbDQi67KZo8UWqP5Nij9x@vger.kernel.org, AJvYcCX7OysUKFe8KCtk7SOT58hSsQnA1cK5ebP21ARh+9i7mViCv98fldgktWr3P1RyREr3SlU3mz0dgTyg2ZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy9L+Q1p5UVNiLZgdh/8HzI3lB9qZKLp94BJ/xjxLvTDvIY+4N
	ledZEwzBVtJkhfjg3EfGSf/FHrHltOz+z58hX100rvjZ/P6C8JZb47Gk5AhXo1+wCJ83RyQoY3P
	8gNC2PipJg6JlwqadzWvgXf6Q6xc0IbY=
X-Gm-Gg: ASbGncuVZYgZFXuqXNp4boF8HItXJ4p+k+qrlweXgF26l9j08yQhq3cBxrJJTXyWKI1
	+AU86nmLqI5TFXE1xjXL+w7Clscp/3EdKxUvZ3C4XSRkQqNdxtRhK0NhIcD7i4Q6UReQjg8vqy2
	6WYowgYo+4PEDLLKkfdKPhZ0f2oU9ibzUAvBpqYIlLaiY=
X-Google-Smtp-Source: AGHT+IGayysUot5FJmNyS1+LhAXkSuEABGqTts/x9kFQq2v3uECf9Pjd6BFyweSkXtMkC4KdiSu54T+GD3+7VQpgqcQ=
X-Received: by 2002:a17:90b:3c91:b0:312:1ae9:1537 with SMTP id
 98e67ed59e1d1-319420d6defmr1484022a91.0.1751359577749; Tue, 01 Jul 2025
 01:46:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701053557.20859-1-work@onurozkan.dev> <20250701053557.20859-7-work@onurozkan.dev>
In-Reply-To: <20250701053557.20859-7-work@onurozkan.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 1 Jul 2025 10:46:04 +0200
X-Gm-Features: Ac12FXzHDv1UinEBt9Y-8t0CdxgdsylkUNnz7RlsW1aWZL7FWxUuIV4iYhqdPNA
Message-ID: <CANiq72=NBhCeENQ7x94viBEmSx+N8ET0if91y=N93pXFoGKdDQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] rust: remove `#[allow(clippy::non_send_fields_in_send_ty)]`
To: =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, airlied@gmail.com, simona@ffwll.ch, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, 
	rafael@kernel.org, viresh.kumar@linaro.org, gregkh@linuxfoundation.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	davidgow@google.com, nm@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 7:36=E2=80=AFAM Onur =C3=96zkan <work@onurozkan.dev>=
 wrote:
>
> Just like how we did in [1], we no longer need this lint
> as it's no longer part of Clippy's `suspicious` lint group.
>
> Link: https://github.com/torvalds/linux/commit/5e7c9b84ad08cc7a41b2ddbbba=
ccb60057da3860 [1]

Normally this format is used:

    ... did in commit 5e7c9b84ad08 ("rust: sync: remove unneeded
`#[allow(clippy::non_send_fields_in_send_ty)]`"), we no longer ...

Maintainers may want to fix this when they apply the patch, so I
wouldn't send a new version just for this (but if you do, then please
reword it).

Cheers,
Miguel

