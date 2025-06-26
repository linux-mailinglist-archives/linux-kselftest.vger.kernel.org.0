Return-Path: <linux-kselftest+bounces-35856-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F64AE9CD3
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 13:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D925D7AE284
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 11:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB79C4A0C;
	Thu, 26 Jun 2025 11:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCpuq5cp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F37710E0;
	Thu, 26 Jun 2025 11:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750938627; cv=none; b=c/KtXwMaLp/utrOt4fdtHhLVGrTZVQT7wVE4FanFnUjLxKnTAEvz1NfUA/SUTL4OVJdQtLIgQVwHazmyZy+Hs1kYFFWshJxVQKybrp/ASF/CLPkGsvvEXj0wV8UKV4e0XTDl81yrJxkbN12ChovxBha1m9TlfGYCr8un65NiRdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750938627; c=relaxed/simple;
	bh=47DwLxZ5ThOmC2ZCeEvtDYoVmJKiQ13yJRlQWHsuxRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HDvExK4QslpmTXECfK5AEQ/5M1PkyrcApet8k0MD8tftB7JlbDfRycdjBJYnhbZ7b+QCEObb03F/Hlef7YWTP5kpQrvPHV9WLVhoVcG00rM+jof0HB2d66EqhBxpnFCzhPlnNpbkGJgZzwOgtuFop9IP+dKBBoulqBukP9fqiJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCpuq5cp; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-313862d48e7so137115a91.1;
        Thu, 26 Jun 2025 04:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750938625; x=1751543425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9XKIcAVinRyEVth7piavPqwL9ln4+s7PL+WLMnmvUU=;
        b=YCpuq5cpzk5b/44brhIzH+tWmDveDCSdIX7UE7Ata4IKEuOVdL2gAomJjlFnUIVLPQ
         9kqJPJr/ntZT8RGz3FYarsyOcOL8dLLwBjOOXK/WWBffNzx0l340bQAcVpdBs+Xy1wso
         UUL7IFr/1Kj/5wLCY5DMSl+5+ETKuILspgaE1d9UuC3ycBZsI49fpGou03tMxdD5npby
         +DsvMONz+JGEW8Y2WX3R+HZEsun6ipdusBDhCFd91hZpvo2Tn0fPmqX5WNMsSXE4q2eN
         3Sd3B/XbxT7jwvHdfMCjeCIDTEpNkg5O+ijVtwjeZW5DAzDkLGgCkGjriAUEovjqY3Ed
         c1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750938625; x=1751543425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l9XKIcAVinRyEVth7piavPqwL9ln4+s7PL+WLMnmvUU=;
        b=csXnIv/FFV2va5UMYfxadBSWJvkEV6lYlCQURJsMZZQcjm+FYSSzVDcm8qjdI/UIFy
         eRj+jdqQCtCyxvVnfadpfj5vJ8M0nYBWOCzP8noPqBLE0JGj6c0CAXHYY/nQ1gqtVBUG
         yigSqoBTtOY69J0q9ByEF1/tKtR2PKo0Py8LEKGzaIb/XiG2QCxNwCV4ZxQNKWjVy/4H
         e9Ko+opzPz/6j9qHaHUKowQexlusHPdRVe706s/liXjb5BPOL448y0M8VgRMNiFNe2ds
         JRcEx2/wbbg8R1zsc+kLYK2tOK+tqwXGtR1WpNrr0DYSu+iprXTWJPjsZjg7/dTl2aFj
         quFA==
X-Forwarded-Encrypted: i=1; AJvYcCWG8+h3xFjYTnUwZNCPLEhD5LQ8bg0MCydVtu+NSrPSS6bKRFW5QecNQH8jcAZrVkE3RzIWf8W80UU=@vger.kernel.org, AJvYcCWPqXjUMXoE/iZ6urKdggq4FKCG/ggWdo+GUUW36Lwlc8IfpIWG2jnPc1mlBYlWsuCwSlucYs+JB2RNEk0RqxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLbHk8B9AAf51X1SC0sasYAOZOwrxcUpIVGgQwnrqbqX9hJ7Kf
	0pkI/GtDif1RRUY9CF5KxXWC/rRPwBfHLDl3b0Nyw4/5wgY9d1AcaspC8w4uw54Jner9xx8oURF
	2BA5/RBXsx1fSDG3PCjEN5cvIiunb8+Y=
X-Gm-Gg: ASbGncvvv6rF6p8uQJXcewmmr+DFQxQn6M6Xz/zuDt91khcJQI6hD8H1zV9JMXY7OuG
	gHnFLtJUwMx8WVlg0Wg2M1lcGVe2BP/S9riUpOYyyJKBn3M05K+NUWkUlNs1OF6+ZYhkzN4OHIz
	GUZmZ2G8mc3QCnqKEdSppjbrr2IyUTaCtiwEHRMiv0sPs=
X-Google-Smtp-Source: AGHT+IEDAfqrKdcOT2s3DZHiC9RhHcJN9UbcrQCS6mv6OcB4dOUdlDT1p3KWKRr/Jh/jPOgSwAknZPYNmBynDnS0svE=
X-Received: by 2002:a17:90b:2e50:b0:313:2bfc:94c with SMTP id
 98e67ed59e1d1-315f26ae116mr3685087a91.8.1750938625522; Thu, 26 Jun 2025
 04:50:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626100448.27921-1-work@onurozkan.dev> <20250626100448.27921-3-work@onurozkan.dev>
In-Reply-To: <20250626100448.27921-3-work@onurozkan.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 26 Jun 2025 13:50:12 +0200
X-Gm-Features: Ac12FXxu4fukAl2NZsF-4Rlpnor3wUHjieWYL8rynr6tvoB0DmTBZvvc9TN3CrU
Message-ID: <CANiq72mSoq=bVxSsg7_-X+EimVZiuN89fFZSYs8rKSaLmEm5gw@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: drop unnecessary lints caught by `#[expect(...)]`
To: =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	airlied@gmail.com, simona@ffwll.ch, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com, 
	tmgross@umich.edu, rafael@kernel.org, viresh.kumar@linaro.org, 
	gregkh@linuxfoundation.org, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, davidgow@google.com, nm@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 12:06=E2=80=AFPM Onur =C3=96zkan <work@onurozkan.de=
v> wrote:
>
> -        #[expect(clippy::unnecessary_cast)]

We should avoid converting them into `expect` in the previous patch,
because then it would break the build between the commits (it is not
too critical if it is a Clippy one, but we still aim to keep builds
Clippy clean).

In addition, the reasoning for each of these not being needed may not
be immediately obvious (unlike other lint patches that follow all a
pattern). So it would be best to split the patches into cases to
explain each. For instance, this one is because with the new custom
FFI mappings `c_long` is always `isize` now, which is always different
from `c_int` (`i32`).

By the way, please Cc the rust-for-linux list too.

Thanks!

Cheers,
Miguel

