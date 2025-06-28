Return-Path: <linux-kselftest+bounces-36040-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B332AEC70A
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 14:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACC6F16F4E5
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 12:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356562459F8;
	Sat, 28 Jun 2025 12:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yprr9nQ6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA379220F41;
	Sat, 28 Jun 2025 12:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751113148; cv=none; b=moEEJ0bSZgbsXeBBo27BUpoiNXBr+wpixeV/XOjBl+jmTD1qNYdO/T0ZMOxNaWkjfMNIVx8FaEKbN8g9z4Zfn8W3HflTDjxHqEb9Ewhz+CPNeofZOE19Pf+QFWuvzTMnA2xS1MgldNkW3Tbw9jhAD1pKKwZgaaF8DsoKK/Pfcv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751113148; c=relaxed/simple;
	bh=SzdKukWgBhdmdV1afJ4LoBiWW5gP6MVZ4xof9rPG9mA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CynyFzdbxjw+lGNZAg183Mvtu0VpDKp6rDUaYCOaTowiUuYQQfy+b5/tCTpKL9LXwFwSlNvRWK5PGUCIjpHQ+sP/MhRoAwi0Ol2+O7sFW5IFMz426ScPXX99h+DFMfEDYExQlbm78D8x2YyMgoAyLCJTlUI9TX88v7FhmcYljl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yprr9nQ6; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-31306794b30so417585a91.2;
        Sat, 28 Jun 2025 05:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751113146; x=1751717946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SzdKukWgBhdmdV1afJ4LoBiWW5gP6MVZ4xof9rPG9mA=;
        b=Yprr9nQ6Dr2Y7QGYzjtUZfwcvZ64VIK3sxVsF7MTD2vCnu9CAcjzyK/YpptOc75HCT
         ln2ryBEUWMXpJot66DjJly7ahbe3Y0oqzjSm1ewrFJlYd7/cPTLj9Rk+onwRRj71Fqju
         PF7Y/2MVRMml1WoJy/ssNxu3sE8G91srKSalX2L1dbGfg5T63LwBagb1Y2lN/SDv2muv
         Lp23uGkr2AdtjYS4OVr4iloJ+8hkUcL1AqaaJa2rE9tw1BNBfVSUTa932d2reE8WdNBF
         tlwreS+e4D9m245AxCo4Vy/K8GUgpm44AAyTVMDPjITMC2hMphdvmzJ2bUAG/ttpBALl
         OwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751113146; x=1751717946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzdKukWgBhdmdV1afJ4LoBiWW5gP6MVZ4xof9rPG9mA=;
        b=xAQpk093MgACncpEb8rb9Od/3oMEeoTKFysO5bqaY4ksg7KrH1eIAyris5PKLLVmxs
         AoOm4v9FGVQa/EG89SWc+LtJlBnkqbz/ZOoSZdrFVW5tLk0GRr9sAV/A+HJ5yFpEzrSO
         awOVbiVgLWMtHxj1F6suCytzY8wzCDb4UrUecckoUFjqm9unsJsPf02EqWk3gI3djbac
         INNmc35eLMg/hyCL/ZsoslIUrmFJv2ZOWUCnByHabItlL8CQj7ADhDaeaI1c2A8aqCZo
         CorDAkgM0kHfhB/TgKESEmemYClaLdV09Ao9wJY1+zdS9YPjkJNrZfMaWfYNDAgSL1XV
         543g==
X-Forwarded-Encrypted: i=1; AJvYcCV4g46FTntD0NYELu5IkjVB+iXrHyyO5qrP2axQdeC9lDqPAkstj0VAeaQQzrefyYR+5PzF+NOiIlA=@vger.kernel.org, AJvYcCVfxrIme3z0zHAlVvxbX/R10EauMUs6R24v4nQEeR65baal1Hc8W/+8JzyuSqcDJhqjAIoWbxqa0JWuTrM=@vger.kernel.org, AJvYcCWURrTluT//ahWEr+hhkASd4Yqxf4gRgcXOEA0BefXGTCdT0LzIzvuJhW5DAFtWmKblkKrHcLX+QiRmc/O1Dulf@vger.kernel.org
X-Gm-Message-State: AOJu0YwEpP9gAgBls/pa0TLuwFz0uSgpkrakWk5OEcQ+BZkF3XqAXmmd
	xgZhynmn6sAKU0YJPHo7qEvUTIVBqFyA0HsjrRna/skPaIQ1Gb01cFOFnQT3lfynSwxhMNZzqWA
	s7qtqjDZDUSsOHMPo6aC8dY422SgWvJukDfEC86k+UA==
X-Gm-Gg: ASbGnct8/7R0X77DEM6Sz8aaKraybBaSd7aaiMP4r83y6IFiwAzoz1DfMPdKuf1DFn8
	gcKGxGeja9lVXofTFbTalXlYCtXvnKZDdMXBP2X0+MMAWpueL262x3PBH4JAg6e0lasbRRdjsDI
	+bFTZohTfH5a+loOY0unz3XahjExK7ZH0mY1419utdMlQ=
X-Google-Smtp-Source: AGHT+IGgOIPOSWcI4SyHL/P/nImiGOwt6QITJk5YEphAa0NrYbuKsNiPSt631d7/8lZfIvKm4XE3s49XsmhW3bUKW18=
X-Received: by 2002:a17:90b:390b:b0:30a:80bc:ad4 with SMTP id
 98e67ed59e1d1-318edd3da95mr1366705a91.0.1751113145945; Sat, 28 Jun 2025
 05:19:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250628040956.2181-1-work@onurozkan.dev> <20250628040956.2181-4-work@onurozkan.dev>
 <CANiq72kjdj4KbDhfnTbm8jZpLC1+WPB3E6M8D8M2NLnphMs5vg@mail.gmail.com> <20250628133013.703461c8@nimda.home>
In-Reply-To: <20250628133013.703461c8@nimda.home>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 28 Jun 2025 14:18:53 +0200
X-Gm-Features: Ac12FXy8IZuX4C_aGR3lTNf1m2yaOzD8uNrtbrbCmNNocjT9FjWir7FB3_SiMBY
Message-ID: <CANiq72kY9DA_JD_XkF01ZSmXbD8iaFthVZ66X+9N5aa_WObt+A@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] rust: remove `#[allow(clippy::non_send_fields_in_send_ty)]`
To: Onur <work@onurozkan.dev>, viresh.kumar@linaro.org
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, airlied@gmail.com, simona@ffwll.ch, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, 
	rafael@kernel.org, gregkh@linuxfoundation.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	davidgow@google.com, nm@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 28, 2025 at 12:30=E2=80=AFPM Onur <work@onurozkan.dev> wrote:
>
> It doesn't seem to be the same reason. I rebased over
> c6af9a1191d042839e56abff69e8b0302d117988 (the exact commit where that
> lint was added) but still Clippy did not complain about it on the
> MSRV. So it was either a leftover, or there is a version between
> 1.78 and the current stable where Clippy did complain. I can dig into it
> more during the week if you would like.

Are you sure? The lint is actually disabled, as I mention in 5e7c9b84ad08.

From a quick test, I enabled it in that file, and I get the warning.

Thus it seems to me Clippy would still complain about it just fine.

It doesn't mean we shouldn't remove it, though.

> IMO, we should require people to add a comment explaining the reason
> for adding these lint rules to the codebase. It would make both reading
> and modifying the code much simpler and clearer.

Do you mean using the lint reasons feature? IIRC we discussed at some
point doing that when the feature was added (we enabled it for the
`expect` side of things).

For non-obvious cases or uncommon lints, it would be definitely nice
(a comment is also OK). I am not sure if it is worth enforcing it for
every single case, though.

It would be nice if `clippy::allow_attributes_without_reason` could be
enabled just for `allow`, or ignore it for certain lints.

Cheers,
Miguel

