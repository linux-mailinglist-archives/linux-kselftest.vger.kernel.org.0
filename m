Return-Path: <linux-kselftest+bounces-36880-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D49AFF37D
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 23:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B67C65C1391
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 21:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778A2233152;
	Wed,  9 Jul 2025 21:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U06PViuT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F73E22D793;
	Wed,  9 Jul 2025 21:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752094930; cv=none; b=OzNPi2tOuIjUZ6t8nt9Ec4SNQ8CycuqWLBfH+bv0pCna7nlAwNuEctY8j9d2KiCQf/hWSVLqNmJ4bDuOmEY1+kJzEXqYNEVMR78+eORgvLJAwqGZpMDp3oIDW28Fw80e0desaRTApqIEw/qlVdywlEt+3GKUX0vPZeHMPB5ozaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752094930; c=relaxed/simple;
	bh=Tv3TPTR5E+wGvhY1J4ym9T3lNka/SXP07Y7RXtDtqhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BNSqYBvyhAJRJQKwDJgUwTORamKY0BdFz/Iw/piWFJ4xt04c3sf9t1QbU4uGrSimqdcHwwBLNpJxz9NZfvTr+OBXrNYyW/1bOSrqyJBT/AXlw/7hzr9m1rqsyB9H/eHRomZ/LRNFKatEelIqOxWtj6eIsQ7VxrGqqxqNBsVnJXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U06PViuT; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-32cdc9544ceso2434211fa.0;
        Wed, 09 Jul 2025 14:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752094927; x=1752699727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/NYN5eCrplLxDbEYSWBaln4nRDogh/r4mbR4dmIqRU=;
        b=U06PViuTX2xwGhWroVTEJIyryIAIjRTKcJ7JrY24lBjyJ0SYZPRaJqMSvvZKRHIXQT
         qQ/w9DNqsFQj9DtSRavMJ2/Go59lEvZdrpOQuamXEVAc1dEaSDF3fGSE3jTWqno305Jj
         xiXJ3AjHB28jhkyPGtKOPaDvrZBIC/jSIAstDN54ZtFSPE4J/XkQiHbhl3cKY38yMuZP
         i4/vHVOrt369s6UE1gmW++lBDBI1FBLizbvIruUgvBNJQ6uc0ZKHwiwhk0d36pxZZZiA
         xz4jOaSFfGD8gavB2LjGtVKEPugJTRLezSmDyD6V57suW6Cp9LCpnUCA17cECPjz7FMG
         KFqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752094927; x=1752699727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i/NYN5eCrplLxDbEYSWBaln4nRDogh/r4mbR4dmIqRU=;
        b=TuIUE/7Pd+lE+EjGJUXwcLjOu8PUMxYRLJsh99RY+NgP5qnhAU9VFQN5mZvzAmaQ+U
         axMivrTGSC16eS2QKxaGbgGXJjGf9F3NqSgZUA7Ad4rJ8Ep04L7UgIRzwwyfmDdYMjqP
         2QVp0jwRl0fPkZ2l+SOzLURi6Gnmm/QSXWlGShiwBnhYuQQD7LKBG9k1tZaBrc5mfnZ5
         SSlZJAQKMx/1569Z/p7Gl8CPTV1nrlpAhJjof+cSlGW4zV0LfkCDl38Ox6wH77RJLS1j
         glD4JV5aJt49K/Ri82VPeaH8MhsP7Z3Tsi7/1Jxwh1n/Sf9bbw/JIZHhcMQ40nMo8TZv
         IBAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHs+9V70UrbtN9zY6vDi1015avZpn+pL00oURJvOEGWkuwtm79nmyb54995XF+2zXzM6gp9KTz7PupVv43@vger.kernel.org, AJvYcCVZ2IM/b5MLSs10hPRpz0NkqKc4C3SxlGyDQePtJaI3HH49BFQ3O7aqVPF12CbUcOZ11MiKhViWGlSJI4LwHqMr@vger.kernel.org, AJvYcCW+/9vkBlaxHMB/o7FO30Tk6Px4Iz7K++lyGGuQT96XuI9liNtZG62bdd6ldGdvo5NmToMWdlAOOadmi4WhoiU=@vger.kernel.org, AJvYcCWy8EhwzvUDTSLkOvoKNk0klhlrKOxby9Yiqqa8FugrRLWmcS9hFwsaY3iiiJMYECl9oPYxP8tDEZwcaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzGB/LSzgjcA1m5MVLrJAYAemLnYrjf87hXhx1PWg5osuZI7fR
	W3wOWpzxFSIOEWmSwFCrI0oMNhhRTzdLv9NkoVHghckA4U7IlXibh+2ZLdE3jJxB8NbIxPNWiSe
	usUDyYwopjLhCZ/84D+lDRQrqShNuix8=
X-Gm-Gg: ASbGncs4+2ENz4O5HHCkoDS+5xtWK6PS5RmRKbbO1J/MxDrKqzJlSxgr0GhJfrkPSL1
	21LMDQLFPgvqIgxMjyI8rr6qBcxVf30AU0Vddv+CzqQfNIUt2WtI7hvdnN/71BfiN041H8fsyV2
	kv53+CJyCzQXIr5GNoKiyRthVXkGlH6sUjlbiWyrOEBXjy
X-Google-Smtp-Source: AGHT+IExWIJ6hhfEb6UoxlwctM02YNDW0TZ2aarCHGVCLMDXTN2AKn+P851gVPEhqrddHdHhddIZDLinIFW32pqJpSE=
X-Received: by 2002:a2e:9d09:0:b0:310:81a0:64f7 with SMTP id
 38308e7fff4ca-32f5011b1ddmr2792091fa.24.1752094926332; Wed, 09 Jul 2025
 14:02:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709-core-cstr-fanout-1-v1-0-64308e7203fc@gmail.com>
 <20250709-core-cstr-fanout-1-v1-7-64308e7203fc@gmail.com> <DB7SVTBZ46QB.31WTHFLWDHPZY@kernel.org>
In-Reply-To: <DB7SVTBZ46QB.31WTHFLWDHPZY@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 9 Jul 2025 17:01:28 -0400
X-Gm-Features: Ac12FXyhsUe6smRBxo6FiBw1g5N18SKhkX08Ac6QMkarBxohB2ddH5MIOdKITP8
Message-ID: <CAJ-ks9nNc_pThtb+gHUcjEnvR6V0RAEG0tkv+_DHYYjXs1N7=A@mail.gmail.com>
Subject: Re: [PATCH 7/9] rust: pin-init: use `kernel::{fmt,prelude::fmt!}`
To: Benno Lossin <lossin@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Jens Axboe <axboe@kernel.dk>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 4:18=E2=80=AFPM Benno Lossin <lossin@kernel.org> wro=
te:
>
> On Wed Jul 9, 2025 at 10:00 PM CEST, Tamir Duberstein wrote:
> > Reduce coupling to implementation details of the formatting machinery b=
y
> > avoiding direct use for `core`'s formatting traits and macros.
> >
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > ---
> >  rust/kernel/init.rs | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>
> I usually prefix patches to init.rs with `rust: init`. I'll fix it up
> when picking the patch or Miguel can do it if he takes it:
>
> Acked-by: Benno Lossin <lossin@kernel.org>

Actually, squinting at this patch more closely now, I think this isn't
what you had in mind. The comment says "Dummy error that can be
constructed outside the `kernel` crate." but the error now comes from
the kernel crate :(

Perhaps you could suggest a different modification that would both
meet the original intent and allow references to core::fmt to
disappear?

