Return-Path: <linux-kselftest+bounces-32288-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 837CFAA88E8
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 May 2025 20:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAA067A4F88
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 May 2025 18:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6196E17A31D;
	Sun,  4 May 2025 18:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PyA04lpQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CBD6D17;
	Sun,  4 May 2025 18:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746382536; cv=none; b=QjiQoqjWYDlLL+ObfcEUeX8dLnzt6G20FbAw1NidV1c1YDRHjVG9eRi5eaQEWfPxKx8ka3+uIf9sQJT+7Th75Z6rcVWnyTCqiHdkWNLK+Kct6yhsf5VJIFUaryNAbaiuqi/mVMXc/WehENIU22sOJpeQBH9+b3mj/J18EgZ1PtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746382536; c=relaxed/simple;
	bh=iHDK/mT+8VpYoXqj3KoxisbDMvRsGiCNPD9pvfdaYBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hS0SynmmyAxeuf7CSma1EHSJBDD9J3pY8B0soRQ/KbZn0WecZuKAALl5v0tDikhXw0WKcTfoC+V6q0O7jipIhOzkOifWspKit8isDxHjndWB2SIrPeEcxeKVu+cFb9+zt+iDMlLlT9XYW5rGpW4eOHokEU1dSeOvIhFYSykBFxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PyA04lpQ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2240ff0bd6eso8076665ad.0;
        Sun, 04 May 2025 11:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746382534; x=1746987334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iHDK/mT+8VpYoXqj3KoxisbDMvRsGiCNPD9pvfdaYBo=;
        b=PyA04lpQTd3JJH1Gdh+l+SmMjwyfR+rrJ+cau5+6G0x+mmR8Tzx0rRd/wIYxTWOVQX
         qUTgzJu4TBTnGHagAemq9apU8D+1U5kp3me4RUWgywDc3VxyiQfEA0oV4OnKoCU94yGX
         QUiAy/Rzd6WFQioV7xFZkWmmg9gAZ3N/yg1l5dkm7YkdbaoOiwszfPL5RksHch0/jHyh
         6gc62vlt2mgpIzfeKgrd/fM+XU/vGrmwof8d33eXRFESIfEWcqaVDv7aN3eGHaLbIVUh
         +ER9n0DtKYIddiazRG0pX21jia2MNd5rNTZsu7YepivbXeCBeCs5LIktRxL8jW4TeisX
         OVxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746382534; x=1746987334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iHDK/mT+8VpYoXqj3KoxisbDMvRsGiCNPD9pvfdaYBo=;
        b=rcYqbk3wH8stoE+fCazlSoz248G4bprlzdZE/RVbWLcX7Tr1E4j9E7uu/wU382izRC
         rgGiAXkFDnBdPzjIuKCjqd+QqJWY+DArGQM0Zp++0LCb9z7NxRKgkdafm/GORrXydVGc
         g5yqeNuShynb8WMK/03tNj6wO3kg9OeGpLP9ta6j9V4s2NU1xtSfCqX7Njrw9x6+QJ8g
         2Lx3uvNZUASg+q+RjJhEEjYz9pgwag4/iVnymps7CkPjFFhs8/b40WUAHUmrYmPhw1J/
         ZCtwLmfl1p5iehZAue9oEI7ZTO5bNys+3Dwe4XLSdlwg8oyEjXoNYzBvPRtssymwUAi5
         9Cmw==
X-Forwarded-Encrypted: i=1; AJvYcCUGu6sqUEinZU+76kK/CmTP+g8tuKjdNy54Hnfs2CXsAyn8kVkXX0ijyn3hSYmbpLhk8Fvex7RyAfyVMRCCa/1x@vger.kernel.org, AJvYcCWVTnMOat377fyxcpENixheSkMHb5/6Lq/G9pW5FcNPj4GMKFBiQfLYTDvW1mdvrILoFblWtymL8OqLNa4=@vger.kernel.org, AJvYcCWlKzd9Y8bgOpwej0Vc5lnKt26BAOX+gSC/QbzAZ5Rr3wWaI5HL95ROlB7MW46VrEzLSXKbZ7s0wG8Nd0duP3U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw412EqkWHkETSFfuFI4+4Q9zCOiinfiEo0CPGH1QREUfIceDxT
	EPzTBPgHN2VmIiRZ3ZGplRNVmCOawg6Zf6QbqlJPSP2SJL8DwRRlqm8gyIg4CnjbG2g6v24mp8I
	HFFxV87/8ooEChWYwD960P0HKlK/1gF6dwE8=
X-Gm-Gg: ASbGncseokDSerRSUmY2CLx4v8YvoxX0qx2FP7UG9ahwV3ScbxyG4/vjryk21kDK2WZ
	Loe1plY8HyC0wz1m0ixXxzsoK6G3PQjo2mLUhRv0Q94vOePN2gyuiqpQMTRTVbBLaBF0fVYS+n8
	lEmb4V1Ymfk+/Sf+lgWOhMZg==
X-Google-Smtp-Source: AGHT+IEemidPH6vW5/TRDN5e9+d9JcDfBVlErQobuzLmwdwFYyViq34WrxjvT1CZdT1gVv6+ZWIoXvKFcZ6rObHPb0g=
X-Received: by 2002:a17:902:c945:b0:224:216e:38bd with SMTP id
 d9443c01a7336-22e102cd13dmr54711965ad.5.1746382534079; Sun, 04 May 2025
 11:15:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502215133.1923676-1-ojeda@kernel.org> <20250502215133.1923676-6-ojeda@kernel.org>
 <CAJ-ks9n7u3WkYmJCVc18c_cKod6DaB7KrA7NXbOuD3E3TYbvpQ@mail.gmail.com>
In-Reply-To: <CAJ-ks9n7u3WkYmJCVc18c_cKod6DaB7KrA7NXbOuD3E3TYbvpQ@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 4 May 2025 20:15:21 +0200
X-Gm-Features: ATxdqUHvCBKb0VeR7w6toc9zpMWghyfk5KguE4071p5IEpYEVUX2PY5b1ywME50
Message-ID: <CANiq72nEHy5wvOyPzW4DLu9aE_MxTx1gq7AJ-f_Ny4E6bbOJ5g@mail.gmail.com>
Subject: Re: [PATCH 5/7] rust: str: take advantage of the `-> Result` support
 in KUnit `#[test]`'s
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, Rae Moar <rmoar@google.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 4, 2025 at 7:30=E2=80=AFPM Tamir Duberstein <tamird@gmail.com> =
wrote:
>
> Alice pointed this out in another thread but: one of the downsides of
> returning Result is that in the event of failure the line number where
> the error occurred is no longer contained in the test output. I'm =F0=9F=
=91=8E
> on this change for that reason.

We could perhaps customize `?` to help here, e.g. printing a trace or
panic, with the `Try` trait or similar.

Related to this: I thought about saying in the guidelines that `?` in
tests is intended for things that you would normally use `?` in
similar kernel code, i.e. things that the test is not "testing",
rather than things that you would want to assert explicitly. Thus the
actual code under test should still have `assert!`s in the right
places. I did that in the sample. That way, having `?` would still
simplify a lot of test code and yet allow us to differentiate between
code under test vs. other code failing.

> These changes don't depend on returning `Result` from the tests
> AFAICT. Can they be in a separate patch?

Not sure what you mean. The change below uses `?`, which is what
allows this to be removed.

Thanks!

Cheers,
Miguel

