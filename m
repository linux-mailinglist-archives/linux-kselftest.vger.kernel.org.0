Return-Path: <linux-kselftest+bounces-36152-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB07AEF190
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 10:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B30D4A08F0
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 08:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECBF26A0E0;
	Tue,  1 Jul 2025 08:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ogih3zBt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6658A1E515;
	Tue,  1 Jul 2025 08:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751359406; cv=none; b=HoIquyDUgcEkWj5OpiGutiFytoCGKiT2wdO+XSM+ryqXCF+xPX6FV9JFpL5faEMGbN9BfcEKA/BuB9nIq+i30+FD0TTCFZUOn65vRNxFVFfvgh/eb7X2o7b7xIzJSjRla44sa91nlU/CGqj/duhxIAiJlhOTtxcJZVCC3rc6u0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751359406; c=relaxed/simple;
	bh=2sA7hDRqPBifitR9aGf3wB+vj7jF5rphWDBpFYVEbJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rgh45/O8syy3kOb0NDSkC5uy891t4Ly0afs1tdXno1fEK6KufDdZFAsPejriOqOSIbUhD83UFA54SEml3BQ7itOacsH8ZJVYsz1me1XipDJHnjgfI4VmkMQ9ydTLk8M76dqj7YVYEObGWSwx0UTyIwHVmO4PKd1JkNtuDkz6jL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ogih3zBt; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-313067339e9so842088a91.2;
        Tue, 01 Jul 2025 01:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751359404; x=1751964204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oxNSHfAB9MRWXdubFVEH8wkk+3HweA1a7Rdb19kGmyc=;
        b=Ogih3zBtOMI4RjOm/Jswwi61Cd3e1fnPNf6TyX9BUAuQfG+vrl8kd0KCRaBTjujRJa
         5gNqWNIFSwF6h8qo9TVaVHkqW0Sv62j7gUQ6X4Ws2lwEqufrWEa3MOim0oO0a+T5XAyh
         jGHo8zVS2toeTUEkm9MTfLtk45UP7LD4hHGpCRVrl7Phw5oE74H+QebqtvzO0RxKwetO
         q55B9ljfnWw7gIUinydjDqYOZeSbN7jL144JVNKMyBAop+dZXDCfmPLlP6G3QekS0pew
         EcwMbvW1HLKRA+rMYJFx6bejS0xcsX9uDbP4p1S98uWcV50IfYLCokWDeIkIpLwRzt2N
         K6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751359404; x=1751964204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oxNSHfAB9MRWXdubFVEH8wkk+3HweA1a7Rdb19kGmyc=;
        b=HlcVbSue4DgL+4dvE6+jkqr4jHapt0WmIvZXsaaufJw6fB+bqsTc+qWECxljzTNFuK
         nGocV4cw6ajWuYRoPBSegCxE3aDDA+IYH6ipx+JguIQ86tbFcmXRHpSgivQc4icU+rOj
         uuT6w90dSfWOtLwmdzFZbQetqG56oSv3inUb0UK0B1r5BGV4vSRMfVu1CU5X4iMEi7jO
         /EC2MdjR2hVwRg7QyrUfhKVLE/9ey3GHULfOuakKgp3sZM0p01bweUFvPRzt8Il+LeW5
         kt2JPJR/A6tQiPE/WMUJ0IZEoQ93MXNSizdxAfto8zzPnu0PmE6pKF5wrX655PX2c93C
         8yHA==
X-Forwarded-Encrypted: i=1; AJvYcCViLogJ+nn7KVw/0AHYs0ID+0AgvXkLq5i8/SwUyrWzOKHYVVs4J8eDAdzjVLsL8ChNv1FBRlTBcVNWWXx1jZOa@vger.kernel.org, AJvYcCVmCBGBvv65i1SJqNMxOLXvJTfLRrUFdRuW51+sZMpIRYX6a9UVJWW6H0gJ6qKvxUvWDKfKh2adDNBG72o=@vger.kernel.org, AJvYcCXIF8WcN+TKk04SeV1neRpdiX66x68qfVH1vaIhH2I66cfqKxTYtBH/7TntuW1PC1Ia/F6q3P31Z98=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+Nt+lLG+90gb9om5uKejlYOIFcv4Hw8laucNuyJRFxMwVthf3
	pGBNr64S3yeWye9NBPtiCQ8bCUUzLbs5cXtRgK65w9CGqpzPEk1vft+BA1SgLb+NCJQCjqGqqY0
	hCTqLDyMdkbEVdi3y49QKWGKwmUN4iCQ=
X-Gm-Gg: ASbGncscpMKqKtTFxlU9MepgwdLMQg40wTx6ibM+Pb1CWvIHiYHj74VIifzzLXN4ZWp
	yMOKsXOXlKP3NfHyK+X06iJ3NSx2AHoIuaCeiGq0cw2YS3S7zLLlorc4iVU2XswlZXeg4W4HLih
	dPFsmhOTZXAuQGgrKWoUAtuPy73t2/YIPKROw68a3vseY=
X-Google-Smtp-Source: AGHT+IF+84LcVdlYoIoIe8TlGbMXF1hU8ya8MeZB+0h3qGlySzxftGhGnmh7fR1Qt2waAbxhWaEH5q3Rzv+M81FKjX0=
X-Received: by 2002:a17:90b:280a:b0:311:b0ec:135e with SMTP id
 98e67ed59e1d1-3195196fe9fmr1365806a91.2.1751359404037; Tue, 01 Jul 2025
 01:43:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701053557.20859-1-work@onurozkan.dev>
In-Reply-To: <20250701053557.20859-1-work@onurozkan.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 1 Jul 2025 10:43:10 +0200
X-Gm-Features: Ac12FXxogephnHWqcurm2KToOo7hzNrx3JYMdURGRcPiUy3NtJ-hL8ti9d_xbHo
Message-ID: <CANiq72keo+NKF75F7qB_Epcbf7fhQqUo27EEVkdet1J2syQfvQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] replace `allow(...)` lints with `expect(...)`
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
> Onur =C3=96zkan (6):
>   rust: switch to `#[expect(...)]` in core modules
>   rust: switch to `#[expect(...)]` in init and kunit
>   drivers: gpu: switch to `#[expect(...)]` in nova-core/regs.rs
>   rust: switch to `#[expect(...)]` in devres, driver and ioctl
>   rust: remove `#[allow(clippy::unnecessary_cast)]`
>   rust: remove `#[allow(clippy::non_send_fields_in_send_ty)]`

Thanks for splitting this, it is very much appreciated.

I think you decided on a split based on similarity (?). In the kernel,
different maintainers/trees take care of different areas/files (the
`MAINTAINERS` file describes this mapping). For instance, in one of
them, KUnit and init is mixed, which are maintained by different
people.

That is why the split I suggested was one that allows maintainers to
pick them independently. With this one, maintainers still have to
coordinate, which isn't a big deal, since the changes are small and
straightforward, but the purpose of the split was to avoid that.

Cheers,
Miguel

