Return-Path: <linux-kselftest+bounces-36050-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E29AEC771
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 15:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 266873BFFAC
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 13:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC72246782;
	Sat, 28 Jun 2025 13:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNGbf5Xt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9C74A3C;
	Sat, 28 Jun 2025 13:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751117892; cv=none; b=fQvV1/aOYTIeMMAd53y9L3LH7qqc/hAGevNbqOmLuv9x3b5FI4M6R0gG5Drj+jP4TbcDHxCLIV5LvZwF99hH8udZjmK3C3vEvMx8wqFYtTHfwXTFp9jA33pyjqdcctvb2qY+DHP4fLHzvCDaT7cUMMu6/Cjo7hY1TFmewAOVmPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751117892; c=relaxed/simple;
	bh=vIf44i+VyFnPM1VkIxmX0r4UR1zNeK8yVY2SxBYnyZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e0aS9ubRNGvg5G4nGe3th1KDvJeVv6JQ7UkrilMmWvjGXkq7/LgHxhcmqmpn32goDEldz68SU0g0TLmHJ1UJirLWK/1EWJ/vPxVH53jJV33DFWKLZT7ebNzkowYszOTuPPFTBECTDk+5B5jUgykWDtrm510TnSbCi7rnt3vumc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNGbf5Xt; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3138e64fc73so422748a91.2;
        Sat, 28 Jun 2025 06:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751117890; x=1751722690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIf44i+VyFnPM1VkIxmX0r4UR1zNeK8yVY2SxBYnyZg=;
        b=cNGbf5Xt9RAx0CmsgKVu/XgVZ26o5gTma9upfH47E3gcY1hkJdiQK0UZGTaanVYcL8
         E0WRHUvlVR3N7YCKtg2g1kPLhXioChwNJru4Ha+IgcMtryc/D5iQAEmY25FkmqEKkNT9
         1iS1UUpCHeugP8XkOiAo1foNqL9zc7E52AT8E+Br8meO7zRHRvJEAAgOV/TZntIi9ejl
         opFzF71H4Nqs/4qW3IPivirAmg3E5N4A0macU92IlPVPS6wANLY3X2XJehPTjnKXMxfd
         GvLX9d6HzaT8iU+NpOVVcwDKfnGp5v1BYy78bQj5hFxQ8bkrqnnrPXiSdKojl9CaxJNt
         TXyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751117890; x=1751722690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vIf44i+VyFnPM1VkIxmX0r4UR1zNeK8yVY2SxBYnyZg=;
        b=XMDixJ7hN68qZIWFZFRT8d2mSqduQZLznV4DJrORpmcTadAb+JMZH7W+CgWxlUCDmV
         BRQD0i1gsXvCsG8NzbepwhgUTggOrYrit8uWwEsDc9C2Ik46ENkBwwEcMKTdpUtl82cp
         fulc9QRatFwzQigZul+8WlHBF2jh9LsGxYXsiDZy3iXm5hm7TkSdnupR7nDcwo7QDhdB
         XVeUN/kcOSMfQhnZx4FsEoMB1vV3zXEaf27ImTD8eYxsdnt+3YcGWR5aENS2XU5tqZ5B
         esVBHCowxOM3qihuSpKJ/9GP52s+hPqbQtPhxDgFXFtwND4t17IBolFx1Oqy5RBmJBng
         aGLw==
X-Forwarded-Encrypted: i=1; AJvYcCUsJXK2oMKv0GPFYFDE1xMWvInp1NTjLGjtB0TqGpmGqqjUvGgluUJy3VSalQea5zuqpEZm7NdIT01QngHbld8=@vger.kernel.org, AJvYcCVKib/TQ2VwnWS0+nEOOomn+3u/sU59Hsev6zhpKzRgpmIC/M07hNj0Z1dj3jUpwQhfUMmVyepW/Ji3kmGzmhfC@vger.kernel.org, AJvYcCX9fz95beJ75GWwpiB82nvusVdPsuV1fOdp+ZFcSPP0YqgzVnKxlT82ozeEbZZl+2BNg6k3qdkj9xY=@vger.kernel.org, AJvYcCXae38TvtW4zxiDv/6f/uoQN+10BwKdg1o7lFEdXD+KqGdhdc9bgYZG5mZRsyraZIpYbwqDLWbqGNcQvqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLXA3AKoVAD49aXoXy5uP0k3bszawmhvT0nCdk/XZLPJ4E0rLI
	0j+Zaj2wX9uh1W+HAq30K1LyGK9iuosewhB3o6+faW7AIaQLetnhvOmoohgd4UOem8LKzmjnOT4
	qN1x8ZGutyje0VouA16EGUpBhZZ8duOM=
X-Gm-Gg: ASbGncuA5bAQexWVtf6dw5W3rUpdS7HEMJ9jgUmy/ryJLkgQT4AFZRRNi1mMmjjwyNa
	Yp8Z1FgrfL3O3MLIgqCDgsx989RY2rOLMpgK3HaK9LSgARhejt/aqKP6KsqC8N05BbmPH5Sja49
	wl+LOLOqBm7qrY8xJkfeGYAIFt/Om/N0bqmsuwbraEnDw=
X-Google-Smtp-Source: AGHT+IEgTHUXZm8aCKw8gdJX5bX0wwKKRYcrzHQLkm0UPRW/oqr62CWwCcw4F2siFcvRbdmLcajx0brfOaBHI+bBeY0=
X-Received: by 2002:a17:90b:1c0a:b0:313:f9fc:7214 with SMTP id
 98e67ed59e1d1-318ec33ecadmr1834619a91.1.1751117890021; Sat, 28 Jun 2025
 06:38:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250628040956.2181-1-work@onurozkan.dev> <20250628040956.2181-4-work@onurozkan.dev>
 <CANiq72kjdj4KbDhfnTbm8jZpLC1+WPB3E6M8D8M2NLnphMs5vg@mail.gmail.com>
 <20250628133013.703461c8@nimda.home> <CANiq72kY9DA_JD_XkF01ZSmXbD8iaFthVZ66X+9N5aa_WObt+A@mail.gmail.com>
 <20250628154835.4e2e4a92@nimda.home>
In-Reply-To: <20250628154835.4e2e4a92@nimda.home>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 28 Jun 2025 15:37:57 +0200
X-Gm-Features: Ac12FXxAcGE-hs8I2L5vAQYkCC-37OvNogUlsuWHP5RbPdtbwCtWMcOUSWAGNlY
Message-ID: <CANiq72mDJTOwVNOdaWOtJk+O2JFu-RGYHnSLTwDrWu352pRYAA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] rust: remove `#[allow(clippy::non_send_fields_in_send_ty)]`
To: Onur <work@onurozkan.dev>
Cc: viresh.kumar@linaro.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	airlied@gmail.com, simona@ffwll.ch, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com, 
	tmgross@umich.edu, rafael@kernel.org, gregkh@linuxfoundation.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	davidgow@google.com, nm@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 28, 2025 at 3:04=E2=80=AFPM Onur <work@onurozkan.dev> wrote:
>
> Yeah, I meant that it't taking more effort than it should, like digging
> through historical changes in the relevant parts of the source code,
> trying to figuring out whether it was just a false positive or if there
> was a specific reason behind it, etc.

Yeah, that is a big part of kernel development, especially on the
maintenance side :)

I definitely agree that a good comment in the source code is better
than going through Git history, and the kernel sometimes has had some
things documented in the Git log that should have been in the source
code instead. It happens.

However, in some cases like this one it is not clear it would help.
For instance, here the lint reason message could have been something
that made sense back then when the lint was enabled, and yet we would
still have had to notice the lint got disabled later on, so we would
end up still going into the Git log.

`expect` is great to mitigate some of that -- sadly we cannot use it
as much as we would like due to sometimes being conditional to an arch
or the kernel config or the Rust version. (And your first patch may
have some cases that perhaps we cannot convert due to that -- I didn't
check)

Cheers,
Miguel

