Return-Path: <linux-kselftest+bounces-29827-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B9EA71EC9
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 20:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AA5C16E43A
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 19:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F6024C09B;
	Wed, 26 Mar 2025 19:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTiaoPUT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1804A28F4;
	Wed, 26 Mar 2025 19:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743016019; cv=none; b=LW5i8X0o7ECsneNNaJJV38hM88vnamW6EnYLW1E3Ujtp/Sb9xu9pie3d0TUGQ+9zMZztvMkOB0aGvrYjEK03jG2tdbw27OMjxLafFsopahnXHJCB++hyTgZXk3h/GpzxPTnB4PCKYGm+xO3eq1MSUz5E+ngu+pgZh6hMstYryV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743016019; c=relaxed/simple;
	bh=xyxvZkbyduy9RmkQ3WSeK6/tBzwWPMrfRAoEJmlTmuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XPRRJFjPZ3tUZYhJqdvDZd0R9AMtbCAd8+xdFbD0GIZGfj3M5E0oPAFCl2P4X22rz4lV8eA84QefGpIFAgwufX5pXGfzVoKUR2kwGfNH04vWnBETPlUfd0+bln6nnvcdmHvzmIQuQKXFAcN5BSRco/y/xIRzgXfmHXwc5lJ5an0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTiaoPUT; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30bfed67e08so2255321fa.2;
        Wed, 26 Mar 2025 12:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743016016; x=1743620816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xyxvZkbyduy9RmkQ3WSeK6/tBzwWPMrfRAoEJmlTmuE=;
        b=aTiaoPUTXhlz0TWPtz+Y44JteqxaDLfRo2CXuDryjK/5Nef0PPICQBIUqY4YIhhTmU
         i/w8AGV/lTNgNPYNX0ulVacg3IZAwpb6vEJa0jVz/TlWZXtmQYm0aiLO6pLvjVuav4Ul
         aH3Pg62nzVPkXRmdrPv/aC9LoddjkxcuySQGlvO0ongu1fTtJhytIDkGYSLrZAH+wCzb
         lCCEFdGDf8Q8bPct91/6D1LpnBe7A3cSuDnbyBc+lVvCuB6VfGrOJGFC9TyjjrbsZJuL
         HZfrlp4hsiIl7BQsJz1daj/KyLt8q4ovKxNCr0DYCClG6RWXmaMkv3qg5Y4dQskrykJ/
         Kx+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743016016; x=1743620816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xyxvZkbyduy9RmkQ3WSeK6/tBzwWPMrfRAoEJmlTmuE=;
        b=u7ASLFfjWU3+C4Hbd8ojDjidpvZA8E9wg5fXGtu2Oyu30jJjtQEfukZEmelEyUDeq/
         Z1lIlXAz3uMD4JTFy0F+/LzxsZtXqhOUzy4H5EqzQDxiZ9YwhnhCENa15bBZsEat3w6u
         ltwzmAMnK5RmkpsvYfOf1CybN1wToLbV5XeHBA3VwreXwYz5eDaXyS9nyQtiXQI77F9T
         J2WzxuT+WLstCyq7zfKiqO6m62c/a/3w2INuw/SldqSxSXAR5SzZFnCRR3BCRUAk7KQo
         qhorjFKUy2cY1CNfRaDzW8fQfY8UUvKvobnQuJmWk06mgqaPQhJ5fEDDAFHAyJMKlZ6L
         S4zw==
X-Forwarded-Encrypted: i=1; AJvYcCUjstPFP8AutMsI7KFZy2sxUcI8lpofjeaDtujc5nZb1KM+DSaDgiEDV5Ysph54mc2TjPjX0cKg@vger.kernel.org, AJvYcCUlWlE3gQ4V5qI4mnZA5OfZsXjeEkP0FnyYhEn/0UI5vw09LXjkBETsMNzz6dGwJMPRAlM0yLhyGIWY@vger.kernel.org, AJvYcCUxHO5cL5xOtYBwQ4ssyK3pbgD2Sx5vPX0/kCnar1Bt68z3AFL4c4bpwVyqynkAOWCpjAg95aaruIlAGIsG@vger.kernel.org, AJvYcCUzHrs9hhZPhJHdc8T2hQSfJtlajJClJaaTZZXirNG0rLunB5dfXHvrXxPP4ZrmRYVcf8al2TMrf496wno=@vger.kernel.org, AJvYcCV83ZrNc7qR83APq23ziwqVAqEMJHhCntcCJ2HPdrnQgF9M4z/LnkKOZRQmA7MMggUgv4aX1wtSOP6f@vger.kernel.org, AJvYcCW0MGnWhUKfW7WLe9XElSZ0h6mA+cr+9XzQYCzItXbThwc1R+4GA4KWxlm7eYWhA4LQBWDsQOH8dSP8Mka/ECg=@vger.kernel.org, AJvYcCWCLHlsCqrgPCLB4YzC8gG2XkkJwu2g8DsAqwyr/Kh6P6FfhT0tKSAIIJs7LpXZM+O244iUptxoqmHNfbmd@vger.kernel.org, AJvYcCWRPQKLEotIxfWvm7jfKl4WN43SEV3G8V1tEtQFTmCnMSyHUG5Ld5vnER6ofRGzWKRbMBrBRb3uCP8x9RZnoKPh@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvx5V1cHjnkhzKrKY5P8Z1exSSq9Zq4BWDAxyt0QTmSthHycBf
	gy970IOCP5mamWPyrxXOnU9xa0jcvhuiTPwtTM6oJZPXKPjgFlubsskDMFAbqWKF6PJL2i+MFp6
	40fnd+cwpaboLAdwkBQnCtluHI/A=
X-Gm-Gg: ASbGnctj9WgJZ7cCM3YPJaNxw5v6UwiJ+j7IeNOxGRp0wt24ooHXhLAGEJ0S9u9NLk2
	fylV1BlBEoN3wpI8nMsMBO288/mmCph6NfqixLXVGcNuti+otdsyTbQzLqwTZHRRC+F2JYBLQd3
	Iyi3B6OtmlcYHkTt1/o8iDkT32YFBnWeh6IYgFQMHXXQ==
X-Google-Smtp-Source: AGHT+IHDYgVo8MGaQ9BkG5+GyvT0+QD0Hn1jlcmz/IJfG8ECGaCOtoHRacJDMqa8JoaxSiLcVOV3Dc1Whxt+lMktHno=
X-Received: by 2002:a05:651c:4ca:b0:30b:e440:dbdb with SMTP id
 38308e7fff4ca-30dc5f45b99mr3646831fa.37.1743016015848; Wed, 26 Mar 2025
 12:06:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325-ptr-as-ptr-v7-0-87ab452147b9@gmail.com>
 <20250325-ptr-as-ptr-v7-7-87ab452147b9@gmail.com> <D8POWLFKWABG.37BVXN2QCL8MP@proton.me>
 <CAJ-ks9mUYw4FEJQfmDrHHt0oMy256jhp7qZ-CHp6R5c_sOCD4w@mail.gmail.com>
 <D8PPIYIJCNX8.13VPQULEI0ALN@proton.me> <CAJ-ks9k6220j6CQSOF4TDrgY9qq4PfV9uaMXz1Qk4m=eeSr5Ag@mail.gmail.com>
 <D8Q4MSXXZ7OI.1NC226MO02VSN@proton.me> <CAJ-ks9nHKpQPuSBypXTSATYhbAFkQTJzUq8jN0nu4t=Kw+0xxg@mail.gmail.com>
 <D8QCK3CQES3Y.3LTZ4MVO5B3KT@proton.me> <CAJ-ks9nKT2PUDm6=b4AB1QUWwwvcqPn7Vz60=c0B+uFMZrqPew@mail.gmail.com>
 <D8QDOBUM6NF0.CGJY7ZA5KD9S@proton.me>
In-Reply-To: <D8QDOBUM6NF0.CGJY7ZA5KD9S@proton.me>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 26 Mar 2025 15:06:19 -0400
X-Gm-Features: AQ5f1Jou-JUIkYYZHmN0n0DjKziFwOI3NizL41USvJvQpjSfAnBz0gZwusssOLs
Message-ID: <CAJ-ks9ntTxBM=c5nUZWGv3MoRt-LveBchn-c1Xy-DGap7fLVRA@mail.gmail.com>
Subject: Re: [PATCH v7 7/7] rust: enable `clippy::ref_as_ptr` lint
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
	Saravana Kannan <saravanak@google.com>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Robin Murphy <robin.murphy@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-pci@vger.kernel.org, linux-block@vger.kernel.org, 
	devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 1:36=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On Wed Mar 26, 2025 at 5:57 PM CET, Tamir Duberstein wrote:
> >
> >
> > In the current code you're looking at, yes. But in the code I have
> > locally I'm transmuting `[u8]` to `BStr`. See my earlier reply where I
> > said "Hmm, looking at this again we can just transmute ref-to-ref and
> > avoid pointers entirely. We're already doing that in
> > `CStr::from_bytes_with_nul_unchecked`".
>
> `CStr::from_bytes_with_nul_unchecked` does the transmute with
> references. That is a usage that the docs of `transmute` explicitly
> recommend to change to an `as` cast [1].

RIght. That guidance was written in 2016
(https://github.com/rust-lang/rust/pull/34609) and doesn't present any
rationale for `as` casts being preferred to transmute. I posted a
comment in the most relevant issue I could find:
https://github.com/rust-lang/rust/issues/34249#issuecomment-2755316610.

> No idea about provenance still.

Well that's not surprising, nobody was thinking about provenance in
2016. But I really don't think we should blindly follow the advice in
this case. It doesn't make an iota of sense to me - does it make sense
to you?

>
> [1]: https://doc.rust-lang.org/std/mem/fn.transmute.html#alternatives
>
> >> I tried to find some existing issues about the topic and found that
> >> there exists a clippy lint `transmute_ptr_to_ptr`. There is an issue
> >> asking for a better justification [1] and it seems like nobody provide=
d
> >> one there. Maybe we should ask the opsem team what happens to provenan=
ce
> >> when transmuting?
> >
> > Yeah, we should do this - but again: not relevant in this discussion.
>
> I think it's pretty relevant.

It's not relevant because we're no longer talking about transmuting
pointer to pointer. The two options are:
1. transmute reference to reference.
2. coerce reference to pointer, `as` cast pointer to pointer (triggers
`ptr_as_ptr`), reborrow pointer to reference.

If anyone can help me understand why (2) is better than (1), I'd
certainly appreciate it.

