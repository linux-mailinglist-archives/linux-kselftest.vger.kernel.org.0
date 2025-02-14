Return-Path: <linux-kselftest+bounces-26685-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE178A36715
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 21:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9746517188C
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 20:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8658192B65;
	Fri, 14 Feb 2025 20:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T15ddz2V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F1C18EFD4;
	Fri, 14 Feb 2025 20:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739566168; cv=none; b=lYCGkiGGJ4stUnadYr4Fcjsys9ByRopLU7lCxMaZLqdI9dEloml7nb1x4/uHoxGqHOjD0cKcIAVL0S3riB0dAsazblurQTEcCClyUZAP5OihDCKTbiDsmZmG1Y6rtDUnGVhXZKA6SUDgCU/NxRDgw3NqRGQl+ebZWnJMpjZDoi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739566168; c=relaxed/simple;
	bh=FKYI80UJi6r67EQ3BJDOUhzFbmqN6BXyh63vLRy348g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cw+9x/+lg++7pNBkmmbq3t3dg4SSGvAjLUGwbWJsfIuMbSLB0ga9ERFKzfZtHzu5i14LwPGyOIeSggIwWaiKprKDE2/07I9QpKsvnzxABW6p2rlcSQpHDYxq+wbT5hVPm7tUotFqu6+4/RM58u0FiaM0dM0VuWOZQkQCSlxXROE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T15ddz2V; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2fbfe16cbf5so543394a91.0;
        Fri, 14 Feb 2025 12:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739566167; x=1740170967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FKYI80UJi6r67EQ3BJDOUhzFbmqN6BXyh63vLRy348g=;
        b=T15ddz2VKYQ7BFUpkp9wQ6vo3EJKUAHnc+WN10YApTloQpzvXBySROvLNEzG2xK/hW
         u3CUEXVIT6GDL4TDct5whqcK6Uv5pdxOxLz1kSuSlONCRt2Ce8g4cQPupVAAJ6YA9ef6
         jQ0w4+4sQNvTcSgr/WopHOxF/9PAI1twKgThODAovC4c8/CLmyMPMxWLHeNoxALwvXTe
         8yyIdeqlKyShblhZvl9eGPXvt1XSOjwImYxESmvEpx0P0sLlNfSgihgotxuYZR05LVlV
         8yH8BpLpM5SfFd0XkLWdAHruR5nM4PixUklUbtFL8nzFVIVSFJbe8Y5TpYniwewucdPb
         0MCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739566167; x=1740170967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FKYI80UJi6r67EQ3BJDOUhzFbmqN6BXyh63vLRy348g=;
        b=Hdbbn0YUL367tzmt6B2QEI71xijA9/BdndgH5nPw+gIo8ctVNQ/FnoH+yOwb/yApbn
         Me5jpavB5WJtzs4Sf7gFZYH7qX3ZrI3usllmZz1xDVwyJI5nvtwC6pAXXmIqeKnJqP0D
         AAPZpStFFlm0Zy6c9GaHx36CEOht4PPzOhXrbtiSkZ758YXCKkwKcmPsuADHqm3gYdba
         B3z/i2N1zuMB/dG5bL/9hVzb0R6shmVDs8V9f2t0kvGxPSkZUCoIYyTtaVeY1yTYVHRI
         oM55mDkr6EsHgaRx29+iVVgtUo0+Ge3PjK5RgZmCYZxRxMZJwMTktZHBlzNcIIj0Xkgw
         byZg==
X-Forwarded-Encrypted: i=1; AJvYcCVnZmjzgDAO1svVOK3ulvFrSI/FjbM26WXxXdCOOU/r9sdYdvAG7MfQ6pnXEIxcD/MVoO5pIvVPXOjvvD0er9IG@vger.kernel.org, AJvYcCVyOty738NPjmmqxTAK9RBbXYqCrqoUVe60njwGDCWdT/nEbM4K1GtycKEWmwFo7MIhkPAxkDPsWoeOnB0=@vger.kernel.org, AJvYcCX2/540FYDYKrgbyetUoTTgU81b+tY9BOokYY2BWFX1x1z/KdDqUujd1k8i6lyPNmEzNH1ndLVCRMYkFyZOcAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEooIxDHp5wRh/FgLREIVwPb/GBOaqmEOphS07Rmac1JnV40FA
	4z+nhoJqK6hGd+md4z0lWm8RNj4AryVaoEE+hWYi5X063FjGjFoT1+i3reUr6OiUlJ3FpTlfP9m
	g+Km6qilOmLrUd3gW2fJ5ZOVFt5g=
X-Gm-Gg: ASbGncszYlBSsRfm53x0bdiQ7wXrqgiVe21ZUcBxIreo3TalW+7ctNGPdIUlK8uHll5
	+u0X/YfsJws4x8rjFAGzmwa52Kbx4De9GR0J/7OeD4H9qKl87LSbRhQwhFhdgqOAEoFeiXKys
X-Google-Smtp-Source: AGHT+IGPsCyIeJt8J1l8/QN0KU5uO7jL1pQpZ1i+QrPvwAs871pTp0Qrmzt7+P/+C+DUzsH7NrG1RbxFbhyKOKHVA34=
X-Received: by 2002:a17:90b:2241:b0:2ee:b665:12c2 with SMTP id
 98e67ed59e1d1-2fc40d1246amr295083a91.2.1739566166561; Fri, 14 Feb 2025
 12:49:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214074051.1619256-1-davidgow@google.com>
In-Reply-To: <20250214074051.1619256-1-davidgow@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 14 Feb 2025 21:49:14 +0100
X-Gm-Features: AWEUYZnRHy-tc-NU7T9dbaGK6jL7O9fPdTjkvjfsW9w5Tczle86nNQTinnUmsIM
Message-ID: <CANiq72mqkoSkh_3Q1XYuA_Q7AqRFt1wD_Mkf1nPTbbSHKQz48g@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] rust: kunit: Support KUnit tests with a user-space
 like syntax
To: David Gow <davidgow@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>, 
	Rae Moar <rmoar@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Benno Lossin <benno.lossin@proton.me>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Matt Gilbride <mattgilbride@google.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 8:41=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
>
> After much delay, v6 of the KUnit/Rust integration patchset is here.
> This change incorporates most of Miguels suggestions from v5 (save for
> some of the copyright headers I wasn't comfortable unilaterally
> changing). This means the documentation is much improved, and it should
> work more cleanly on Rust 1.83 and 1.84, no longer requiring
> static_mut_refs or const_mut_refs. (I'm not 100% sure I understand all
> of the details of this, but I'm comfortable enough with how it's ended
> up.)

Thanks a lot, David, really.

I am happy to take it through Rust or KUnit -- I am not sure yet how
many conflicts we will have on our side.

I will give it a go when you think it is ready (since I saw comments
from Tamir, though not sure how many you may want to address --
perhaps the sooner we land this, the easier it may be...).

Cheers,
Miguel

