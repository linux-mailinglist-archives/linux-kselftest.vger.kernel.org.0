Return-Path: <linux-kselftest+bounces-26681-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 156EAA365CC
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 19:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE77216830F
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 18:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F3518C924;
	Fri, 14 Feb 2025 18:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kldu0Giu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F13E23A9;
	Fri, 14 Feb 2025 18:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739558326; cv=none; b=h/zDHU94NGKcwgTwLoMzIonzTRQ5ctf6Ru99QnBQtFZzf/fCjhHjlNbFpwNBRd3MLKP6lMmvH04thOjbLdh4vqDAKnnObuqw1wsgNJhckdWNOusDG7kz+CfltcZ/tizLIAnxAQ4Mr2HvEsXRyT8CRlM6pTSx+pzR0hOfCqrumfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739558326; c=relaxed/simple;
	bh=7bDoYMBdjfFuiWjZHKTG73wMDnCbUFtmg39DNEQdYYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hJNaJu3ldGWyXP3pHB2FLz1QFw2nuMU9hmaib5DOWuWN72I59s9dAPJECxfKi8ai3TyZ7lWt/K7y4epVXfGMglSgwijzZygXR8NiHUArCKXATXSRSMRrqKxg6Cy0ZvxclgTvznKhr6j8AxslKbLy0bczwG/7iOH0nryI14b5YJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kldu0Giu; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-220d27d490dso6288055ad.2;
        Fri, 14 Feb 2025 10:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739558324; x=1740163124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7bDoYMBdjfFuiWjZHKTG73wMDnCbUFtmg39DNEQdYYs=;
        b=kldu0GiuBa4BT2zXtRfQTMPbuTET4NsUSzyrfR7Li9bqc3tNqZDU55Z6Cjkde+TUOe
         +fdG+0mpXCwo1Jm2GtUDlF/PFwju+qFHEpV5hMlwC4zr12LSemG8KZ4X0mV7BHxeGnB7
         8mbp3VDMTh5nbkQvJUVvHGpssUhKSU0EIDzPM1fmLdFIDnYTbRSQOWNZWm5WmmdskAE6
         puu/Z0FyuTLPhMubrEcVZ5cFBV3cldKo7CF4wMhoqmxi6xDrHM0nuocbScGuhq+PvlYw
         io3CPH7Z9urbxLKQzIzhglPcpcMXCPYrOEWoo9h8Gak0Yi6tThCuQhKt8hIpShGSbv2s
         x+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739558324; x=1740163124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7bDoYMBdjfFuiWjZHKTG73wMDnCbUFtmg39DNEQdYYs=;
        b=lhmJQBzKZQSXAsy453K5X6RwZGkvFCwtKThxJYAH602myEbo7OvfDdYtpJ83XnkcMI
         lpfVi7EHyuNgMbu9x3YSa/rBG+evvesoitG8w9gfOfSE6bcNieiRavm1MMA2kXD/19g2
         stQQ8z2L+Bz+UvESM79Cc26kHHGtmW5gihpS0ff+P28WA+j4EtvNN6uUHY8DPdyK/dEs
         Ehs6KMottiof0PxlM2ngDb4PdR+z372plW0Vl/Y1t3Ip0OdUafZmfNr5cKfG2aaXx0Aq
         /cLhbq0RGpWcCXGB7ywQQC387Vna/WUKPBJTlWZ5FcZtZU+gULdEWBDsO2ckJ8J2ILEK
         CaHg==
X-Forwarded-Encrypted: i=1; AJvYcCUK14uWvWepkitFSkEdS286ieQPZoPZvMPOV62Y2nVRrDEA47rRPLDw0GNORLNzakebyiJ7akRoEnMlUF0=@vger.kernel.org, AJvYcCUtaysTMhQWHnD2RJB+myewS74prWWzeHvWPorv6GwcU7lBn7KD9vsT9O+FMCOES1CslV53m/Hc/ZM2d5FbZro=@vger.kernel.org, AJvYcCWDalQ/6PUpmLLPnh2siteXDrWb+6JUx8IoPFUzz8EqtkGYgSlue/AKQGa5Zf2Bh/kT6//TriM79/QVbRohiGUl@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1vgNuHKiHN9XM/v68jpN/BFN0d/twNG5a3s1RqGxk2FJSdj82
	JU0x4iR/nzgBLIWyUG8DzrlcC9uffJgnPlCx2VCTzeRQtOmMIBf0rnVAAkvKnbxZ6gXzgc1YA3t
	WGKNkzPJoihTh1fNBZZy4ZNiX8Lk=
X-Gm-Gg: ASbGncuNNF/RJkA6zRkMq5N6HaDDLLoFOqrKR8b5DZOW7Clg6R08HD3rK/HCySWTOuJ
	5lgOiwKY3xPlQkVbSLYwO/vgHjaZSICxzltTUr40Ho0muUHLch4VmAmgqE2SXi9/04WOPi05N
X-Google-Smtp-Source: AGHT+IEywBc4U7NOxq3vhLhZlguOtxoWR+aAoyWC+kKsStHtBchOiM+PI+Mpq974vKgu4gOw4KaNw7xJ6+mgUeUF40s=
X-Received: by 2002:a17:902:d58b:b0:220:c813:dfca with SMTP id
 d9443c01a7336-22103f05f88mr1732355ad.1.1739558324243; Fri, 14 Feb 2025
 10:38:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214074051.1619256-1-davidgow@google.com> <20250214074051.1619256-3-davidgow@google.com>
 <CAJ-ks9nAT5ETe3qM-DcY-YqES-pTK0RdMAY_fn1jT0_Dv1HkTQ@mail.gmail.com>
In-Reply-To: <CAJ-ks9nAT5ETe3qM-DcY-YqES-pTK0RdMAY_fn1jT0_Dv1HkTQ@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 14 Feb 2025 19:38:31 +0100
X-Gm-Features: AWEUYZn1oG95IU3JBaYclCOUEXdZOfu_EzUusnJCnJ3VbReX6GT8Idw8dCfWXIQ
Message-ID: <CANiq72nvYSo0KHDpOYTNNv5o2VH9KPocJ-q=cQZ7_mkYAqBjjQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] rust: macros: add macro to easily run KUnit tests
To: Tamir Duberstein <tamird@gmail.com>
Cc: David Gow <davidgow@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	=?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>, 
	Rae Moar <rmoar@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Benno Lossin <benno.lossin@proton.me>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Matt Gilbride <mattgilbride@google.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 3:41=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> This is a really helpful comment. It got me wondering: can we have
> host-side unit tests for our proc macros? Code is better than
> comments, of course.

That makes sense (in fact, e.g. Benno wanted them for pinned-init),
but I will defer that until we have the new build system to avoid
adding more things to our plate.

> This makes sense. I wonder if we should think about being able to
> declare a test that runs both on host and in KUnit.

Yeah, when we originally discussed `#[test]`s (years ago), we wanted
to have "attributes" or "tags" like `#[test(host, kernel)]`.

But, again, something for later -- I would rather we finally land `#[test]`=
s.

Cheers,
Miguel

