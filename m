Return-Path: <linux-kselftest+bounces-33828-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06804AC459F
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 02:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 712EE3B6E9F
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 00:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A906F3FC7;
	Tue, 27 May 2025 00:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoP9Bm8R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F391853;
	Tue, 27 May 2025 00:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748304155; cv=none; b=FWpcAOApyKBmyatW2lBIYRu69ECpm/A0Pw/apbaxmGCITVs9K6j+WngddV9VZTAc0BPYvh5X7vkMgQKVhbcLm8noMK+UgfmpikRVY5thde0ePguF4dcZQGQNzLTeBGtDd6OA0smNtOfpXHVmH/AK1pj2yITPNmRcPP4Hb14uQ8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748304155; c=relaxed/simple;
	bh=f+8nvxqAogtH+5lnlaOWfFsRXBDYOv09eJ8tjN3kC+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SISUCpOmBk8Mo1bPo2SnI04mKd1mFrWWJZc82nsNjUR5yg8JiCtBQAdFo5toMIametH9gzLoXPL/5AjMYvD1gtVwCW+Qj26hCrdL243/KDvXaU46MQLl2V+Qesjy+lPCPc6/cYkAXlLGWA0PGaHjcWanozAigsJ+KedfGFTE3gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VoP9Bm8R; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7429cbbeec6so238743b3a.2;
        Mon, 26 May 2025 17:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748304153; x=1748908953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qo02AqQm7aPI5AXw08SD3FnZ4W/ANkIsGd8/cxnS2ic=;
        b=VoP9Bm8Rqao/ygsSabNDdzLeIXOrr2Z8oBKk646E78H8RViBSUP5Z33byDrzN7M6gT
         lIuhnbrzi+QZNJ8fSVBBzK7KV86+a+/q6x8RH1Bb+D0oomRCQG6tvS/kzfULouxg9vY9
         N5MO2jH3/l0LaJ3lpbLmSK3jaluA6AkYKkwivVIN39efL22eUxCEwNSO1gSDLOc/C/Ib
         c6wbXP3qO5bfy8O5roCayOoznjcxuHE5qN6v00//k7gOhG4xGh3fURDuL4WVxPA3Glg5
         ve3AxOdoKsYWpzd6eFdHzQ6oMuHzwmrrvXPBvYEMzdnSy9vg6QsCwrI1hy4LC18HkDEo
         RBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748304153; x=1748908953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qo02AqQm7aPI5AXw08SD3FnZ4W/ANkIsGd8/cxnS2ic=;
        b=w7fUWiyiQlOPDYeNfMI/6GdQmP1rxieFQdWfJhTzydP2zz1hmQFlsA16ZK5QfGyWU8
         ukd18umWKTHZDhZok03yFlkO8YKFZBJTz6yiIzq9WbZbc4LqkedXRwXVh/rLQDFmybh2
         A9Rv1PfybAs5/FlN1PHGhl12P9T2ox3OO8DabaD+HDkV4KjZ5WbLqyYGX7/MBtQygkiF
         PQa7GXM4E+nYX5uG2wPuCbRo3iKSj9NE5O5dBk401oKa70BJ38UlmMVTzFlxSQboaxZj
         JphalxJEjaGBjgD8tP3k+F0Hlsiajy5j30VkiMXc0n6xUrdBMTeS57lpMtuUC/uYrPE+
         7jOg==
X-Forwarded-Encrypted: i=1; AJvYcCVIB/hfUB13iRBPQlkxdfgZej0aqYMcKCdInGZ1Suh0feEpABpDXujyl+78d8O54ZSJDCIpnx0MOhFhHRc=@vger.kernel.org, AJvYcCWo+jCaTevFTcgDAADNWoXpdkwzmlagnayTVYSDnplN9OUBzDoHlo5nAsCi3EK40muOrYvRm95VhFq0ZPoH63FV@vger.kernel.org, AJvYcCXYw0rFTa4MwyC5NVAUE69ZESp4s1jAw8DbAzONJ9PhdlFPv4ExzttR/clUXY9GXxb5jAtVWQq8on9fBBasoIk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh5xqTWAEaw6cfmkXYlFKM529qsT0OfILYvLDvJnWXcgmq+sTT
	qkkEu3YQueoNUjJqeogFOtRDvUWRWcQmqOfjsLOZqe4KPEDBrWJB5UXA/ftsND8rVLASidCWKeQ
	Q4NApHvaY+vTAnEYyckMuOzZLXuWI1uc=
X-Gm-Gg: ASbGncvpgI5cSvMoM4XrfoypTwV2N4T1yhEJb/cHEjxwp2AOucnorftL2CWHqxH5+fO
	PjVMFRHxQUwNFKoIt+MTgDSn3EZY10KvTUauiHaGD7lVTJ8Z7n+ygI6WwNQgFJUCJw7Fz2GwY6/
	1yWKzpvongd0lCEMzAB9ZFbTwTCPEB5ppz
X-Google-Smtp-Source: AGHT+IFLR5Hpmi57Nu9/l8Jb/vmsnSGEkmpsKnlFA/5TAMPItHxsEnKoMcGdVwDZxw1QGAebInPuw6+aOLDpLWBXEVo=
X-Received: by 2002:a17:902:f546:b0:212:48f0:5b6f with SMTP id
 d9443c01a7336-23414f9ec0cmr57708035ad.9.1748304153325; Mon, 26 May 2025
 17:02:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502215133.1923676-1-ojeda@kernel.org> <20250502215133.1923676-2-ojeda@kernel.org>
 <CAJ-ks9kARZT5TMrfXvAqmGdsMD+EgdaY061tyhm_n4oerFLOfA@mail.gmail.com>
In-Reply-To: <CAJ-ks9kARZT5TMrfXvAqmGdsMD+EgdaY061tyhm_n4oerFLOfA@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 27 May 2025 02:02:21 +0200
X-Gm-Features: AX0GCFtkmg5n1i3Rkj3QS56FAgXX8HJxYKe8JvyvMOKylvsvamZOsGINzJRln0g
Message-ID: <CANiq72kRMSLpXChRtLHgeHUsO39iSBNUygzcFXWmyCfetdC6mg@mail.gmail.com>
Subject: Re: [PATCH 1/7] rust: kunit: support KUnit-mapped `assert!` macros in `#[test]`s
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

On Sun, May 4, 2025 at 7:42=E2=80=AFPM Tamir Duberstein <tamird@gmail.com> =
wrote:
>
> How come this vanished?

It doesn't lint anymore -- the lint only appears to be intended to
work with the standard `assert_eq!` macro (and related ones), if I am
reading its source code correctly.

I created an issue upstream and linked it into our Clippy metalist,
similar to the custom `dbg!` request:

    https://github.com/rust-lang/rust-clippy/issues/14903

> nit: why not String::new() for all these?

I prefer that too, but I kept it consistent with the other lines. We
could put that as a "good first issue" unless someone gives a reason
to prefer other methods.

> Could we do this (pushing `assert_macros`) before the block above to
> avoid this body/new_body name juggling?

We can use a new variable, changing the line below (i.e. it is clear
then that we are "assembling the final body") -- I did that.

Moving the new variable then is also possible, but I think it makes it
a bit harder to see the three "main parts" that we assemble into the
final body.

But if you have a better approach or I misunderstood, please of course
feel free to send a patch (or maybe a "good first issue", since that
would be a good one I think).

Thanks!

Cheers,
Miguel

