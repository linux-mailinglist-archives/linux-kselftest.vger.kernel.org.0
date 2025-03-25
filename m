Return-Path: <linux-kselftest+bounces-29769-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE354A707DE
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 18:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40EF916C265
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 17:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BB025C716;
	Tue, 25 Mar 2025 17:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chE8zGi4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5201E5B9E;
	Tue, 25 Mar 2025 17:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742923070; cv=none; b=rtKNfm1I6LROd8L73C2QXjvpjIGog0wjfxaP6sYEV8C5wq8gFnjqFAaN3OeXxJDdHJm4SlV8oFHaGU8PNQYSKpRodGazUxkiQJzZzTl7QsLBcOngsGtaCH5/DHbtSbw7Y4+H4JbMpO5Rg7JY8wgItpTc0dzZc2DbNknefG0yeVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742923070; c=relaxed/simple;
	bh=b6MGlnUVaFKBQ+2xHwkDeovJSJdklX90bjhSIP8Uqkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lbx6HuIATkn/hOjfCdr9qmroOaXsCpLhDcss4qLE2PHLPpdPHvuvRF7z5aSLGNCB2oStADd0PIXfXZLfSSpWQ5uT+ZNoOSOZay92/SBvaHwTuXBZKAOQsy8AB1HyBorJo5eQvmP7Xb+vlN4z08g6djbXWJwPrkodbk3/DGA+Iww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chE8zGi4; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30bfd4d4c63so60157881fa.2;
        Tue, 25 Mar 2025 10:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742923067; x=1743527867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncjZuqLz4pCC4vphDuKl5ZPEUefScVXYO+j+PxLNSXk=;
        b=chE8zGi4XqIqrv5sB9O5OWgRv3IWYGWbTNPTrgIkCSnLu4mpaEtpyDqCBx+FQUmXyQ
         Fl0fEWKOuVdo6AfvbQ6lQDmBN9O/Sq6oTvCdPt8sprjVhCs388SMlux64f6Z1/1i8k2Z
         0Q5qiJlSR5E5hJkgwGFiDyEcAEOryMlE/1Xa9dg9PjSGwJ5JLOLArHWD8ESltnQ5mF9K
         JxwK3UostqofxMdAlH5vUE/Y9vbVO9M/2uJLwYTIQgBZcxjRSBIM1mB9FUhOV+uyGe0/
         mC27Q43oCbD1yxSQJ6qDqzrJG7AU3zi81frK6Ov510F+JDT4o8IYg3+VNUFXEM8UHHdW
         FLQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742923067; x=1743527867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ncjZuqLz4pCC4vphDuKl5ZPEUefScVXYO+j+PxLNSXk=;
        b=O+H1NCc5ZiihLR5VaslFJQpKUYAfg1qk0tvveRfuUHfh2wleQWDC/PyCkxMX9pk8zY
         iuG9Wv4BXpqqcNe5Mb8b2GsAUazGb7wliHVuykQjbrTy0vDRcN1MgPLchfSQC4cCDPUi
         oAIZurjwqkYk0fEma+LGODLLJjzqQ8Su8KjsBU18r/PC/9QEGPobvVRgAsnCX7aI+t+u
         xuruTm9NY+t6qEduNYg+hBAa/aeDh0g2WWCSbhjM6UD5TkeS1RWBYpVmP5RMCqx+jXLW
         dcylwhx1iLvxs8r6iRHFHwmhTLQsx9lKuEMlLzAy5oIlPmQpcpi36AYUpH6YPUNgF27i
         bXEQ==
X-Forwarded-Encrypted: i=1; AJvYcCURQcgI4KfD9HA1UuB3yE7JQHkLKIXGzot2H6ncwW9+tLYmsIi+XEGWdeAhiYHV4rmG9LJtpK060V/8i8D+@vger.kernel.org, AJvYcCUxmyZFjf9+7SEpHAPU5LNoQd74T1rHzsPYSR8WHIvpiSDll3ObszKlGqLiolNkttJxbFxEYGIrEQj5LK0=@vger.kernel.org, AJvYcCVDOXk5CSSltCXMusu/YaW3+X00KSJQ/xKdRe6fBRUjJicizZj0CKXT3vaPxXZ0jIMAXdBHMCWNnncazolQM9yu@vger.kernel.org, AJvYcCVS0KJoxxoEgD93+bzub5IDrTyw464yCiOq2rRdVGQ0Uu4w6gVG2h48/XxakYHG2kAIZ+7DCzAuj11f@vger.kernel.org, AJvYcCVjzI95P2wI0ISTP1RWMTbvvqagt369jA2C/hhQ+6MvHDRDWiJjJzE0Gonaft4++NGn3mQ/tVihcvgu@vger.kernel.org, AJvYcCXEyOGWpjSMEEIVKumtMEgtOGqqLIxrp1X0ew5fb/f30mZ9YxDV3coijqcckpwJG4zmnQjPZ4ut8Klp9567@vger.kernel.org, AJvYcCXROI1TbrYkYL66KTXX9gLdNMgNA1aGQ8jhF8OcSVuUksf8BhK3wxP7W8Fr4m7vh9vfHt2/s9qKx5DfzO/jCx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPDqaRApEYYME2dVxALU485X8l9+W/1PbBahFmupYkf3VoWWt/
	45DCVo4wUhHYg/lDrKsDJgVLjEJcfKnwaIbZUpHDnzrN21/90LUrSZJZS26J4d8upAdyBZLetay
	sonJpnpj7kdgE1uqDPzRRJjj0HfA=
X-Gm-Gg: ASbGncutG8fUCQatClst2ow8OXecMPw+wcjbWH16j++a87li5srjRO6Tss6+SSiKFPs
	xrrFA58c35/K3TUhB724FfrhZ92qzNa4RZUrR9iR9kWUq51XWzbndqb4E41/4AQKeAmP6Wx5Yjn
	iwupgEJ8yUKYVpGX3bkBTssYDVRVeCSHZ854xmz4671A==
X-Google-Smtp-Source: AGHT+IEho6TRTFYibffTOcXg2imxNyfO/NDJlMfW4YuFXt5pXTh3sRV4mlcchTRWE3KKFuAFKeLrQV8vCY3tNcZg+Mc=
X-Received: by 2002:a2e:88cb:0:b0:30c:177c:9e64 with SMTP id
 38308e7fff4ca-30d7e2bce01mr65584441fa.35.1742923066511; Tue, 25 Mar 2025
 10:17:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317-ptr-as-ptr-v5-0-5b5f21fa230a@gmail.com>
 <D8ORTXSUTKGL.1KOJAGBM8F8TN@proton.me> <CAJ-ks9n-z0SETz+zBfJmda6Q_vJDeM2jmDXx48xX9qpMmR-mdQ@mail.gmail.com>
 <D8OTXLDQCOKI.34R1U5R0JSB8H@proton.me> <CAJ-ks9nc0ptzfh+tHj47aTCMqoaKB0SnGpZOLQ06upt7x8EBMQ@mail.gmail.com>
 <D8PAQXHJDVQE.36QKQGBVVL4QU@proton.me> <CAJ-ks9kuG8SyybioKQ0+bYwjnCQFMhip+4A1WnMhsdgnNZGiZQ@mail.gmail.com>
 <D8PGG7NTWB6U.3SS3A5LN4XWMN@proton.me>
In-Reply-To: <D8PGG7NTWB6U.3SS3A5LN4XWMN@proton.me>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 25 Mar 2025 13:17:10 -0400
X-Gm-Features: AQ5f1Jo-XOMVt3AtJU0OfhrKyPKg6t27WTK1AODdNRJ_VnhlwpYHl6kJ4WNIc0w
Message-ID: <CAJ-ks9mMVzm4m20AxiZ53DyAmSEaEh9veMoVB5XRxmTQP_H_ZQ@mail.gmail.com>
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

On Tue, Mar 25, 2025 at 11:33=E2=80=AFAM Benno Lossin <benno.lossin@proton.=
me> wrote:
>
> On Tue Mar 25, 2025 at 2:34 PM CET, Tamir Duberstein wrote:
> > On Tue, Mar 25, 2025 at 7:05=E2=80=AFAM Benno Lossin <benno.lossin@prot=
on.me> wrote:
> >> On Mon Mar 24, 2025 at 10:59 PM CET, Tamir Duberstein wrote:
> >> > On Mon, Mar 24, 2025 at 5:55=E2=80=AFPM Benno Lossin <benno.lossin@p=
roton.me> wrote:
> >> >> On Mon Mar 24, 2025 at 9:55 PM CET, Tamir Duberstein wrote:
> >> >> > On Mon, Mar 24, 2025 at 4:16=E2=80=AFPM Benno Lossin <benno.lossi=
n@proton.me> wrote:
> >> >> >> I'll leave it up to you what you want to do with this: add it to=
 this
> >> >> >> series, make a new one, or let someone else handle it. If you do=
n't want
> >> >> >> to handle it, let me know, then I'll create a good-first-issue :=
)
> >> >> >
> >> >> > I'll add a patch for `cast_lossless` -- the rest should probably =
go
> >> >> > into an issue.
> >> >>
> >> >> Do you mind filing the issue? Then you can decide yourself what you=
 want
> >> >> to do yourself vs what you want to leave for others. Feel free to c=
opy
> >> >> from my mail summary.
> >> >
> >> > Well, I don't really know what's left to do. We're pretty close at
> >> > this point to having enabled everything but the nukes. Then there's
> >> > the strict provenance thing, which I suppose we can write down.
> >>
> >> Yes, but there are also these from my original mail:
> >> * `shared_ref as *const _` (for example in rust/kernel/uaccess.rs:247,
> >>   rust/kernel/str.rs:32 and rust/kernel/fs/file.rs:367), these we can
> >>   replace with `let ptr: *const ... =3D shared_ref;`. Don't know if th=
ere
> >>   is a clippy lint for this.
> >
> > I don't think we should go fixing things for which we don't have a
> > clippy lint. That way lies madness, particularly as patches begin to
> > be carried by other trees.
>
> There already exists a lint for that: `clippy::ref_as_ptr` (almost
> created an issue asking for one :)

=F0=9F=AB=A1 picked this one up as well.

> Here is another lint that we probably want to enable (after the `&raw
> {const,mut}` series lands): `clippy::borrow_as_ptr`.

This sounds like a good one to file.

