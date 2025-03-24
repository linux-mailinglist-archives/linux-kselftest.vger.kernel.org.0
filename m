Return-Path: <linux-kselftest+bounces-29709-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3037DA6E625
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 23:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6A011766C8
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 22:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F16C1F150D;
	Mon, 24 Mar 2025 22:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1qsGPRX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273841F12F9;
	Mon, 24 Mar 2025 22:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742853627; cv=none; b=W4gnm9gRpa/eHA4XYSIfgrn2zxf/ldFZpZGVkIA5KgGp2PmNXEaCoA5lRcrOw0jTNdnEQkbGn70AilkJqpmLu04c5rR5yIbBGvcRhnYShiM5CUT5qXkuwCSogeLZjB3CizBd2j0dUzule1ASpXuOvz4Sep0jnIuWILXMm30u5pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742853627; c=relaxed/simple;
	bh=71xNedCC4Z94uiVIEssxqGS6mu2h+O+GIrdzt89KsFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F3FiXh0vH6n6XQi4qVxUzmUjGYhVEJYb+Cu8KoRxbBTbcox0d4DyYLA21CYqCw1BFqX6G7qWH8rzC2Uou0Ie1mH6zBayFle6LDgYiQVxcsif6l6e9wXCxX/K+y3dLahYaeIm0nAHchBDBBd6qI65MUpyPt3F/797LTvgBWWNh9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1qsGPRX; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30bae572157so47426551fa.3;
        Mon, 24 Mar 2025 15:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742853624; x=1743458424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJIj2kwPWDyO/H6Koa3jkD6S+3PQLap6yvrWwbihLMs=;
        b=A1qsGPRXyHyLIPy8Nwk82mBP+JI6iC+Xb+k6TRPI7Jqh2UKoVW2FVE3fsausfaCzbV
         0eABQKm+up8ATAQ5sytYCmjQ0fKH3wK5mC4hvJIO2lr22ZzUKSVkRHfRjmdRRCTP+wAJ
         lnMvX74sb99t0ll5yiWNTY/taohSiIN47XzenflwIKv897Vp7EsNxg+FMj7k7s7OQO0n
         6eTmMAzxEROTlZxTe8VecCZQPZsQ5w3774MVRQEGVjGIVZ7blBF9ucxrBnLMTcbEKdMC
         JJaNlag/OTH+n0xtnh2I9l4cMS9KyayVAjPm52bZsuYsZmbKzR69goZ6NgMu8pczWIw4
         etBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742853624; x=1743458424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJIj2kwPWDyO/H6Koa3jkD6S+3PQLap6yvrWwbihLMs=;
        b=ABPMLmLg0TQcg4I17sBOmV823rNpBnFik5F93hWOwmNfdLzVhiSzF3wh+qBRbj0/AN
         ZsklpcfSC16vGwA+AyyReaB7tISXKQeO5hRAVYSwXS8EJZQXVERRierpbcJMYirSlW+b
         HpDiuzsrKBvfB+Eyplv/QlBLWzuAmMVl21xmZwde7VdIRbdOWHYkbWd1aSmPsRL9PfQp
         fukuNMQDlJ6njNeMqu7k8LYdAR7ko1Jm68gpmQozDkPrOp/wHI/qKtwzSTuZhz2neqrF
         HfKuFtLeTfjiqpuYsGcBYQOwubpBgAeiR26fNlLKzvbdM/N7Pt9bQq8wNPM4byBnVRqt
         uQ6w==
X-Forwarded-Encrypted: i=1; AJvYcCUgT6yMC/+EebEtkbjRTwhfyGibnvIwg4ez2JMMANQQSnecW3Aj7cRxjkxEsTZaeDEJ4u9TQRB9Ff8UOl7MfNs=@vger.kernel.org, AJvYcCUnHb9tyeJxvf9gUXPGwnQB5wtaF1I2ln2OKvg4TSYq9vTgVbDUcCzaFhY5eHqGUTl1nkiCMFmaFFWAvBxF/Bc0@vger.kernel.org, AJvYcCWBPpDlZQncR66K/GNYHFVEdVi7NeAndV1v6iPj9Zm/eeo/YGe6xAZJCL4LJJnEyaI57oQ1W1QlVGH+iaOk@vger.kernel.org, AJvYcCWBvrgK+37kaTTWP4lbZEf1XGPKUPocloNcKIn/5UfB3pLQ3DGmqKXOtZluSIcB7+wwNcE+NZmQTGnj@vger.kernel.org, AJvYcCWeiPihy1dlWg37JqkhpZPBxNmhrLdCbffWVLHdu0OnbpnEcRNiz77LTmDpRU4tDy9cwcnw/COtajMPiO0=@vger.kernel.org, AJvYcCX9mMClVO9k/kbGbgGkTZ6olvc4Go5NMGf9rruLqeNBWXHU5qHqf2FQcfUYQN3qSu1rpO7ZONmea/UzCLhV@vger.kernel.org, AJvYcCXDotCvR88W9EHgBqiMkuqDJjNFMraBiKdAUfPz7CcWozv7Uj3whjU1bLbVG2PVaKLvMZfuXDSOtNo7@vger.kernel.org
X-Gm-Message-State: AOJu0YzSDqcq1JLaWiL71ul0uggzx2w8puAu+D6/pCajs5tLIBvn5m2e
	Ks8i5hPUxgQn8u8ENEqPNIHphCZMqHipRWUEQfjZpTuh9Q9Kp5efitBqb5aKIn/PycCcDlqkDiy
	1hdJUPxg6foBkcFdprgbes+d+vVo=
X-Gm-Gg: ASbGncvLjJ5DqYL/KfS0vQ63dUqlA3ZaylabbyVpWefBcBn13Wt2z7e+00Y4NLOy0L2
	kLSa0sifGXf4KPBYZjuziSBI1UzUNBIXslPpXRiGt+0siJXA1kBVtGDfYxlBmJtZ5IRjqhH28EV
	JCOwove2WbXInPv5hP7YNsmfSV/nHW8ZfFZtUfNcU4ag==
X-Google-Smtp-Source: AGHT+IFeg45oEQUJPJrJjwj5pNO8wB8HGP8iRSPaWOmoQfcnrVDkQ0M/tV/Ph5abLBSgZgYDBnpiW+Lls35LHRVodrY=
X-Received: by 2002:a2e:88cb:0:b0:30c:177c:9e64 with SMTP id
 38308e7fff4ca-30d7e2bce01mr52434671fa.35.1742853623931; Mon, 24 Mar 2025
 15:00:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317-ptr-as-ptr-v5-0-5b5f21fa230a@gmail.com>
 <D8ORTXSUTKGL.1KOJAGBM8F8TN@proton.me> <CAJ-ks9n-z0SETz+zBfJmda6Q_vJDeM2jmDXx48xX9qpMmR-mdQ@mail.gmail.com>
 <D8OTXLDQCOKI.34R1U5R0JSB8H@proton.me>
In-Reply-To: <D8OTXLDQCOKI.34R1U5R0JSB8H@proton.me>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 24 Mar 2025 17:59:47 -0400
X-Gm-Features: AQ5f1Jo_JgGEbpEujqZivDL4PsjF419w5vGvkxnh3P210yQsoVdHUfiWuXxj0tU
Message-ID: <CAJ-ks9nc0ptzfh+tHj47aTCMqoaKB0SnGpZOLQ06upt7x8EBMQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] rust: reduce pointer casts, enable related lints
To: Benno Lossin <benno.lossin@proton.me>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-pci@vger.kernel.org, linux-block@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 5:55=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On Mon Mar 24, 2025 at 9:55 PM CET, Tamir Duberstein wrote:
> > On Mon, Mar 24, 2025 at 4:16=E2=80=AFPM Benno Lossin <benno.lossin@prot=
on.me> wrote:
> >> * `shared_ref as *const _` (for example in rust/kernel/uaccess.rs:247,
> >>   rust/kernel/str.rs:32 and rust/kernel/fs/file.rs:367), these we can
> >>   replace with `let ptr: *const ... =3D shared_ref;`. Don't know if th=
ere
> >>   is a clippy lint for this.
> >
> > I think there's not a focused one. There's a nuclear option:
> > https://rust-lang.github.io/rust-clippy/master/index.html?levels=3Dallo=
w#as_conversions
>
> Yeah I saw that one, I don't think it's a good idea, since there will be
> false positives.
>
> >> * some pointer casts in rust/kernel/list/impl_list_item_mod.rs:{253,25=
4}
> >>   not sure if they can be converted though (maybe they are unsizing th=
e
> >>   pointer?)
> >
> > I have a local series that gets rid of these by doing similar things
> > to https://lore.kernel.org/all/20250307-no-offset-v1-0-0c728f63b69c@gma=
il.com/.
> > I can send it later this week but it probably can't land until Alice
> > is back from vacation; she was the author of this code.
>
> No worries, as I wrote below, I think it's fine to do that in a new
> series.
>
> >>   Another pointer cast in rust/kernel/driver.rs:81 (I'm pretty sure th=
is
> >>   one can be replaced by a `.cast()`)
> >>
> >> Some clippy lints that we could also enable that share the spirit of
> >> this series:
> >>
> >> * `char_lit_as_u8` (maybe that also covers the `'|' as u32` case from
> >>   above?)
> >
> > It's already enabled, it's warn-by-default.
>
> Ah I see, didn't look :)
>
> >> * `cast_lossless` (maybe this catches some of the `num as int_type`
> >>   conversions I mentioned above)
> >
> > Yeah, suggested the same above. I had hoped this would deal with the
> > char as u32 pattern but it did not.
>
> Aw that's a shame. Maybe we should create a clippy issue for that,
> thoughts?

Yeah, it's not clear to me why it isn't covered by `cast_lossless`.
Might just be a bug. Want to file it?

>
> >> I'll leave it up to you what you want to do with this: add it to this
> >> series, make a new one, or let someone else handle it. If you don't wa=
nt
> >> to handle it, let me know, then I'll create a good-first-issue :)
> >
> > I'll add a patch for `cast_lossless` -- the rest should probably go
> > into an issue.
>
> Do you mind filing the issue? Then you can decide yourself what you want
> to do yourself vs what you want to leave for others. Feel free to copy
> from my mail summary.

Well, I don't really know what's left to do. We're pretty close at
this point to having enabled everything but the nukes. Then there's
the strict provenance thing, which I suppose we can write down.

> Also I wouldn't mark it as a good-first-issue yet, since it's pretty
> complicated and needs to be delayed/based on this series.

Yeah, certainly not good-first-issue.

