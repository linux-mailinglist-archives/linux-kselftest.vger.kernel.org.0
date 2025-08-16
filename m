Return-Path: <linux-kselftest+bounces-39157-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCC9B290A4
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Aug 2025 23:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2E835C135E
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Aug 2025 21:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A02D23496F;
	Sat, 16 Aug 2025 21:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYmP9b7G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22FD2185AA;
	Sat, 16 Aug 2025 21:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755379321; cv=none; b=ZScXltDLpRbu5ZOsUIgxU6fxYSGWhe5kMYKGQFfysLYmu5S/caAlVV8iiSrnZ93cUOiOTpTV4MGUzLtBHynbo5fhMT1BLiWVGR45s/sKxxDhxmjDIcXYAfdsJuwMF9xsMav93AWy/4YaO6jV6r+wI0qACcbGuSsccJ7aI+Z1qrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755379321; c=relaxed/simple;
	bh=jvHsXepbd85mILs5MOLtSpqmRNq7lhyRSHBkFQ6Srjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iNmZOIEDBUp8q5a3BbGpfwK1nVak0XEF+zNAGipAurq0PB9SJ1dV8/n0B4wg7cYjpv4sGEGG8BYxOHUj39xwi79uRTl+ftIP+IWsS51Foyxz73vvExnR15Q00vp58aC5uHpY+8/9H13XlPk4sYdcVLRwAhedzfdIJ6oFHFXW/Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYmP9b7G; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24458051ac6so4461015ad.1;
        Sat, 16 Aug 2025 14:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755379319; x=1755984119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ds8Je7KfY4GjwHXKsWk5Giau9uIeYrla8x9MggnAb0U=;
        b=YYmP9b7Glk5PXXIpgnP4QPyQyyOR76CNqNHrRkgSh/IobLtN6Zc3y4JSU21ABlyvhl
         NtgmllyW7SJj0LzyaSz8XspjRp8YrZSus3CP3DqVUWF/qD2wC4D/Eh8NFcrfg3wO7GAg
         VQ9Y25TTm46wAPsMRM3uYlqBPc3flJcSPri+oRA0Ln8xpd4pMx+q8yUTDx0tHNgoJAx2
         DmK36S+pLIDd4pq/giQwpLygs5OtHdmkepTDn4kkMGxqDGEREA4KwcPuLlsTXQYzHEDk
         LKvsnzVZY6abNDJdsbsiYS3+wnfEfcAWOMP/vw6S+ODfdeKKfaQHRWqxLT6bAx2p0cfo
         evXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755379319; x=1755984119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ds8Je7KfY4GjwHXKsWk5Giau9uIeYrla8x9MggnAb0U=;
        b=pHw1ejC3sBuD9iAr/aWG31gJPHOEcDV1okYqsAaepJYyzx9CR5R34aDlVGkin/i63L
         2igPXqkBzRXoXmuDmmBUOQD+P90vBziNeHKsomqmjfL2L1tcyieHYH7obRJCBjY00qy9
         u69hZYHyqcZ5rqh6jN9Bvbx0IH7lYMaFXbP3CfqQMiR+dJlnnixwI5rCjyBURTxkmei7
         0tT48hyHqQEZYv40k2DOJX+hFnDOhFX5Fu3DQj6E93FkNGsXg5ZIhMiQn1nBi0/MMaoe
         LQyLtJaqbLLRp0DIOpMpPb36GdG+gAcS0hh3kcfBYr1rl1IevGb/4BTxTpNCZZc1SZ9+
         CmBw==
X-Forwarded-Encrypted: i=1; AJvYcCX1C6F0N2Zez7WFAg/QNjq4WbZNkxv1Cj0pgoWmjqly0s+LYlTfwbR5TOa8iyIZXjAYrMk8y7WH5aMeTGHlU7c=@vger.kernel.org, AJvYcCX7f/rmQj3bNGEsr1Yx/TTbWZaDPo4LjgObg2PLwpI+tnpbZExLiUAtTNAMSgE1zqGc7lmu/V3HCCIDo48P@vger.kernel.org, AJvYcCX9AJfBrEb9+e0/2bYkvzLWz84ocJ2eus5Eslz/yzWRl6SV5xj7nzgKRSeSzR1M7aoHLElEIo+iKemihLk=@vger.kernel.org, AJvYcCXtNtKmnUwcp8y2WM2iSoG1+4wBmdrNDUMUYc2mht80lf28x4eobGsEG2nu3lMPpHglH5iThwocM+nmwqgO0x1/@vger.kernel.org
X-Gm-Message-State: AOJu0YxFg6kLamVpeq9/gcvHcJJgodGw3g0OhrJdOQxLh9KKA3NCyrvZ
	fo0oddJlx07c5xsLn0Y2McIhuZKEeSKpLL0ZOuthfNW14Be5rxTR9fJg4ImXaQYJmhyRae59OOE
	UfXMzHKAvcUk8uGm2usRK34QTkEvZ6b0fYvAokPo=
X-Gm-Gg: ASbGncu4FcxsybC1GOZq8NwCnsufqlkYa4IcghsiufV2aSBV0ZdHWbbSXJ+ddAcZOiH
	DFaFnkX57/LfZ4AARp4nE4Avhgz8DfpfKaldCBjShDK1UpoPtfOqpvvKn7FQ/HaTrbkUKuaj6tE
	nx28mnbMIJ8tM2zgQIRW+2MOOQu7/pBWjmtvDd+2NClbr+R5lEjGk5ePO8WhvSXUBYEfHDTNEXk
	E945n9vwnO1Mm4xyos=
X-Google-Smtp-Source: AGHT+IEWjOp4P2fU8wk6DK2g7nuduw++M/0lhwl96NpMeoXDbRf1rYmaSGIzIjyIjkEruBxPEP1OhxK64EdgQTvEFwc=
X-Received: by 2002:a17:903:1a70:b0:240:725d:dd66 with SMTP id
 d9443c01a7336-2446d9c6212mr49127785ad.11.1755379318942; Sat, 16 Aug 2025
 14:21:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250726180750.2735836-1-ojeda@kernel.org> <DBOEANDMX1OU.2B47D7G6EQ38O@kernel.org>
In-Reply-To: <DBOEANDMX1OU.2B47D7G6EQ38O@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 16 Aug 2025 23:21:47 +0200
X-Gm-Features: Ac12FXzLXRqQ8BoWN6f3ka4dcgtWt6sEkaNyDNPtyslcoLw_3oMH2C2O3pfwMyc
Message-ID: <CANiq72nVJpptasJM5+Xe3MGYfP4CZ6=acPV82X=EgVf=3C25MQ@mail.gmail.com>
Subject: Re: [PATCH] rust: kernel: remove support for unused host `#[test]`s
To: Danilo Krummrich <dakr@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 10:27=E2=80=AFAM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> Nice! This should also allow us to remove the Cmalloc allocator subsequen=
tly.

Yeah, unless we want to use it in the `macros` crate for an example or
similar -- I didn't include the removal directly here mainly to split
that decision into another step, but given this other issue in
`rusttest` I just sent:

    https://lore.kernel.org/rust-for-linux/20250816204215.2719559-1-ojeda@k=
ernel.org/

I think it is easiest to just get rid of it (and anyway eventually I
want to run the tests from the macros crate within the kernel too).

I have sent a patch for that here:

    https://lore.kernel.org/rust-for-linux/20250816211900.2731720-1-ojeda@k=
ernel.org/

Cheers,
Miguel

