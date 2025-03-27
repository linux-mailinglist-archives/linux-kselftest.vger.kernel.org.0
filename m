Return-Path: <linux-kselftest+bounces-29872-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F771A73F03
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Mar 2025 20:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADDC91B602D7
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Mar 2025 19:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD92218EB1;
	Thu, 27 Mar 2025 19:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsmdXRm2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2314518FC84;
	Thu, 27 Mar 2025 19:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743104691; cv=none; b=RM9gTZLThpNsFye4hWbe0OIqdrrALqocx5hAMfYXr+B+SoPT5KpiyEUYVGMxEls/SIbwLWM25xEi+y6abAOrCcK+LgwZjKWOkQVvGqH1kLHDTiStGxRpYkIRhAbpkiQuvbZw1JrUv/xwG7dS5N6JPA1mWrI+NfsElGqSsDP+xOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743104691; c=relaxed/simple;
	bh=9Mh6b4oCJpQSlZk5cgr4GaAks7FOVq/dlbEme+EYRvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HE1RPoGv7wQziyxVRT3vLqyFI6id0R3AmCixw9VRRKTk14ju1N/y5SlNIvDKAgtvQFh4W5JbMGGJnA+U9F0aIc6WWd3uXBnp/j7FeLzdwYZr4Odn4oZYuHQjNwfzbiOqxFvA9l49gh21/DZYbMs2QVBm6tA1j84GNpvWC7E/4RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IsmdXRm2; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30db2c2c609so16057911fa.3;
        Thu, 27 Mar 2025 12:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743104687; x=1743709487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJrB+25qfJY+3ZkUCcZjNy69G3uZBa+b+woWWSnmCkY=;
        b=IsmdXRm23/Fm9qltyt5/JnGBuuY5HnYS/qrrOQII/YAGpAWTq57SnJuXEehsaa/PDp
         7mZy9pZN3I5jobE9Eq8UPKJsNtFhifjhFlBxeo8HKSsGaf/wWLQQ+ogwEDI2q7G+/qE5
         jTzfSTvfGgqhnj8bw+uTDmwiX3i5wI8k2PAyVJ5Zfjanr6ATtzxAdwak7+SKWmnE7vWy
         oRliUyyJngEa5uo4eB8JH8qOYaBxw0UWMN+9TcvnjQl+bbrP2RE+RWUgyg1n0fZ2FC4Q
         Ij0dGiFsy4eMcj/BTbCgYhDwXOB0YPv5idfzP1M6au6fx0QRxUp+YDucFQ9YDm5x/hUI
         VAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743104687; x=1743709487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zJrB+25qfJY+3ZkUCcZjNy69G3uZBa+b+woWWSnmCkY=;
        b=Iqms9mhU+CnOX4YtzUa4iuZhpmUCeN6gbI9h30HCIdXWcwK8J7DhxdHWL2mg++eIsT
         MMGJ57Lame7RVITWNkWoJHFiR7ADzClwBS30rIU4oIbTWjRNPHMz+v6cD/qNyxMwImf8
         4sRsJJDXsJCDpiAsZ8JqtKH3SJlCotxZ28cH/HpOyKfLYX/odrFtj5vPlQQXdCFpgGKj
         gySn7oriT9u0ZgbmQ6fmosbyq9d6qb/G3sIjzpbAA3PpGfg+L9L4InxM4Yx5VIpCql4p
         y8MNruHZtj7B1Ill33SAqKP8bFccrYE92N853RgENQnANXuB7QKJXL3WDaMeRQ2h/1mO
         bWSw==
X-Forwarded-Encrypted: i=1; AJvYcCU3m8X1wsG3flm5ngLIVI9cT2kfGquo1R/faoM8nYu4Dro6fT+Ee97K334gVPcaTmdjQAVA5EKm@vger.kernel.org, AJvYcCURc2lTdHZs6s5adC2p1OnYxOdropwzFO0Mkq8dL0qDkk7rL/wTUglIRq3m734qtED59lJTgIemuUsIZmA=@vger.kernel.org, AJvYcCVqY3kTZHRd8Pzt7ZrR0XRrfc5Ok2FcqiAGQCXbomK6LcfS4m1//uJfXt5vAFKttBAQpWB28WHN8BI0GiqaNBM=@vger.kernel.org, AJvYcCWJRErpN9XhzW5Ci2JAq591q9naGjpv/CdmUfJnTQHZvYsJ5tRkp440GaW68p4K55nza4hjY/bMNqsa@vger.kernel.org, AJvYcCWYFvXMnaVcxaGraMoFvCcJcfXVHORcnaepAgOqKpc3yB/zuWdQn1KBUw0AzSCC7u8vJjRX0/P9Eu6tg/N6@vger.kernel.org, AJvYcCWhhu9cYoJ7tChJSEVAugPaNBuzgIKu6RCnm6IH3hSVP7o79HvoB8woHs+vTtFoSRMpZi0jVyxoMt43@vger.kernel.org, AJvYcCXACS2pyvZA43LmcpPhRAOooai3fK1dTUdkFnP9oNQN2azz/sYU0aEPp8F+B+Q7HE8OOVx9c08GFLJCipQjjPXJ@vger.kernel.org, AJvYcCXoQZSUWiSb1HmrTRy8xxJWOFOASw1dUQDlMPPeIfIJuxass0Z1dh2QcJYxei1T74X8XOGkX8rMsiq7+eHi@vger.kernel.org
X-Gm-Message-State: AOJu0YxxSCiBRCnrcnxVzIPN0NSQv7z87APFUbavQwX1F4KfS2lP0qmV
	ZsRhuPpTU44HTTZEsQFSEE9H4ztwzNtYyI20LrYxoB0QaiOEm7q0J4nNx/l9YeMKpRYE9nd7ZpL
	ihNQX6PPRi0E1Z73pZ/pb9Kb3zhg=
X-Gm-Gg: ASbGnctltDuWzWGDQ2lrkzW9hJYBCRt7lEdevxZQWN7HVKMG6V+jH/ov8k7MY1SSyMP
	eXJ7kZ2pDOy8x+gDpWKH6QDSc0O9J4rJRFSxrQPcu/VFSzvLv3zAJC5J3aES88XsQ4uqnRb3AOT
	zFzv43S9zGqyFOfbpUML5rIZUvgckOMfPklR9p5oZZlWlBhFiXAJvg
X-Google-Smtp-Source: AGHT+IFyLKYlIEvGpAd9CCRPDur7dyQO/OEa86nU/lx3w5Jjq2h0PxLW9TMc3L3t1yE/rhj6ZShnSCOlezEb1R9xtqM=
X-Received: by 2002:a05:651c:1a0b:b0:30b:b7c3:ea71 with SMTP id
 38308e7fff4ca-30dc5e31b95mr23059291fa.15.1743104686814; Thu, 27 Mar 2025
 12:44:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325-ptr-as-ptr-v7-0-87ab452147b9@gmail.com>
 <D8Q4MSXXZ7OI.1NC226MO02VSN@proton.me> <CAJ-ks9nHKpQPuSBypXTSATYhbAFkQTJzUq8jN0nu4t=Kw+0xxg@mail.gmail.com>
 <D8QCK3CQES3Y.3LTZ4MVO5B3KT@proton.me> <CAJ-ks9nKT2PUDm6=b4AB1QUWwwvcqPn7Vz60=c0B+uFMZrqPew@mail.gmail.com>
 <D8QDOBUM6NF0.CGJY7ZA5KD9S@proton.me> <CAJ-ks9ntTxBM=c5nUZWGv3MoRt-LveBchn-c1Xy-DGap7fLVRA@mail.gmail.com>
 <D8QI804Q3DAS.2BV4WSL81H52Z@proton.me> <CAJ-ks9mA5QDeZ3EvOD3THayFt4TtDysgm0jp2aiSF2mQCrhWiQ@mail.gmail.com>
 <D8QJMH5UR6VG.2OT5MXJJQU5QT@proton.me> <CAJ-ks9m96vf_HxttuopuC_UfNGJbHHNdEGS2er6nZZG38pe3HQ@mail.gmail.com>
In-Reply-To: <CAJ-ks9m96vf_HxttuopuC_UfNGJbHHNdEGS2er6nZZG38pe3HQ@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 27 Mar 2025 15:44:09 -0400
X-Gm-Features: AQ5f1Jr0ooXTkF4heGS1OXy1iD2yeKYqVr9uVRi6oc_-HuImKMszqPEfh2j-Kuc
Message-ID: <CAJ-ks9n3BdKkfCpMXhE8M8Sx4B5rASoNvbmA4zPU3rmPQwZCiQ@mail.gmail.com>
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

On Thu, Mar 27, 2025 at 10:15=E2=80=AFAM Tamir Duberstein <tamird@gmail.com=
> wrote:
>
> On Wed, Mar 26, 2025 at 6:15=E2=80=AFPM Benno Lossin <benno.lossin@proton=
.me> wrote:
> >
> > On Wed Mar 26, 2025 at 11:09 PM CET, Tamir Duberstein wrote:
> > > On Wed, Mar 26, 2025 at 5:09=E2=80=AFPM Benno Lossin <benno.lossin@pr=
oton.me> wrote:
> > >> On Wed Mar 26, 2025 at 8:06 PM CET, Tamir Duberstein wrote:
> > >> > On Wed, Mar 26, 2025 at 1:36=E2=80=AFPM Benno Lossin <benno.lossin=
@proton.me> wrote:
> > >> >> On Wed Mar 26, 2025 at 5:57 PM CET, Tamir Duberstein wrote:
> > >> >> >
> > >> >> > Yeah, we should do this - but again: not relevant in this discu=
ssion.
> > >> >>
> > >> >> I think it's pretty relevant.
> > >> >
> > >> > It's not relevant because we're no longer talking about transmutin=
g
> > >> > pointer to pointer. The two options are:
> > >> > 1. transmute reference to reference.
> > >> > 2. coerce reference to pointer, `as` cast pointer to pointer (trig=
gers
> > >> > `ptr_as_ptr`), reborrow pointer to reference.
> > >> >
> > >> > If anyone can help me understand why (2) is better than (1), I'd
> > >> > certainly appreciate it.
> > >>
> > >> I am very confident that (2) is correct. With (1) I'm not sure (see
> > >> above), so that's why I mentioned it.
> > >
> > > Can you help me understand why you're confident about (2) but not (1)=
?
> >
> > My explanation from above explains why I'm not confident about (1):
> >
> >     For ptr-to-int transmutes, I know that they will probably remove
> >     provenance, hence I am a bit cautious about using them for ptr-to-p=
tr or
> >     ref-to-ref.
> >
> > The reason I'm confident about (2) is that that is the canonical way to
> > cast the type of a reference pointing to an `!Sized` value.
>
> Do you have a citation, other than the transmute doc?

Turns out this appeases clippy:

diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
index 80a9782b1c6e..7a6fc78fc314 100644
--- a/rust/kernel/uaccess.rs
+++ b/rust/kernel/uaccess.rs
@@ -240,9 +240,10 @@ pub fn read_raw(&mut self, out: &mut
[MaybeUninit<u8>]) -> Result {
     /// Fails with [`EFAULT`] if the read happens on a bad address,
or if the read goes out of
     /// bounds of this [`UserSliceReader`]. This call may modify
`out` even if it returns an error.
     pub fn read_slice(&mut self, out: &mut [u8]) -> Result {
+        let out: *mut [u8] =3D out;
         // SAFETY: The types are compatible and `read_raw` doesn't
write uninitialized bytes to
         // `out`.
-        let out =3D unsafe { &mut *(out as *mut [u8] as *mut
[MaybeUninit<u8>]) };
+        let out =3D unsafe { &mut *(out as *mut [MaybeUninit<u8>]) };
         self.read_raw(out)
     }

Benno, would that work for you? Same in str.rs, of course.

