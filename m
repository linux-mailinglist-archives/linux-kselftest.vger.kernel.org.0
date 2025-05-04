Return-Path: <linux-kselftest+bounces-32287-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5282AA88D8
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 May 2025 20:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFE7F7A4D4C
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 May 2025 17:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5B62472B1;
	Sun,  4 May 2025 18:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzGHIERH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60375247294;
	Sun,  4 May 2025 18:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746381604; cv=none; b=PwoB50CcO/IdN1KpvmSgrXEG28mXgJb6TBZI7QWVNY+RAkhUoqC1hxkcE3jZb5dpwScgRz/OjXyK7scxrWeOa1oh+Q3ajBkCXod8v+gpeT8+W8x/j6b2POxUIZw1GMLgxLXgVhBgrWye6FGlFj+yfP6VuAXHeFVcQzLzd0TYWjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746381604; c=relaxed/simple;
	bh=gMmz0xrFGblYrts2MVNPbSYkOBP0t20o7T0mZB/6a+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FwvLozYtjpxHgGEtxr5jue5tzlEgObxDpFTDRMvzX42wjnzYlFD4IeJFo12+q2BhRUFiyt8emicBWAfEnFbYLW0YCou9u1wmUQvd2a+8OQBdDnd2hgZE/TkY6GDHJrsYpwG+r3vs+lkkJ+r5ExmGrWUV69pWvExN2ByLGu/Y+aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LzGHIERH; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2240b4de10eso8601775ad.1;
        Sun, 04 May 2025 11:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746381602; x=1746986402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gMmz0xrFGblYrts2MVNPbSYkOBP0t20o7T0mZB/6a+I=;
        b=LzGHIERHvxTUPEqr9cOS1GV66lxrw4fT0k1GgbGTgpOOhYIhA/M7mk96V2KdisJbpS
         wYuUP8KY3FreWXCEGvYWJZBdHqHxl1JMOD9mBFJZ/xxeqs3uiF+FPKYfp6YuTXlg7eVx
         3yWW5DdmmupBxrQKXoqhTwvS+2uHdC5VEjyHcqrKyAKy6RB5lIZl3FjZGRGenq9bYnV8
         8aZYkD8bvagSbntyD91fwdOgLYAGM91Gp/H9elCLe84MEiqPeI5wC/oO2E50ydcVzvMa
         50SRlol2Eo8uMxOCxpzBC5nyB10Frjl3lRra20nvh78lkeyYOmbHueqn8e6mLev5tYbR
         HjMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746381602; x=1746986402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gMmz0xrFGblYrts2MVNPbSYkOBP0t20o7T0mZB/6a+I=;
        b=YrOdBqh/khS3Zc8hxC3/jcIG8UeZyx9mCus0lo9D320yDrOxohmZCBFmm5yErnAdKe
         klpOVxliCve+nHX7pH8OZT72Ev/+WHvxaucY25l0eWmFCB6XlaErgtOSxTf7Igqg3roM
         Z+m8S4eboIQpwt2l84gqKRBwoGd0nXmR6iHJ/z+XjdeOEZaKmw00JSTgLdU9ytq/6j4p
         XZKLB23I7r8GwyWgTY6BF84CJtaBzjt1IBKwRCYTQDxVDZMnbfEWVper8foAYocT0Zr/
         9pUtWIYK2GlhTN1F0YUJaNEQhvcoC7R0opW2DVuRtZFRfK2leLQ4H+hisrjJevIfNsqC
         daqw==
X-Forwarded-Encrypted: i=1; AJvYcCUPZWScbgfCNmDTQFc2+dnVBEEUtbodtxleGK4qZuXV0KUSXEODHzyRFfU+GnauUu+SmFvbwmdhyWJnhvM42i8=@vger.kernel.org, AJvYcCVd+Yv/o0cexr/D0S6CFR34TplgF3GY2CRwco0P42595a751iNW4OIVXSCgbIO5LEELrOiCv9NbYSEmgO/aFS3y@vger.kernel.org, AJvYcCXuKbcKMv1asxdVSH1RHU8kGmjiOHtD23K+sTjg2G/pulo6aJ52LFU8POVXM7kXeq5izIY+eRI5LSZ++JM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCAb6Sa6p0B3ACTBV6G0OcWe6fN7TSINURKwUgSs6Zlgz/qfpq
	QsNKUnEl99wnJYQjAuhMxcJXfr5nKVlEIqcRQZFC8xO3NSVbVEwjsfeUKGbjCqOHl67tdL/jhCg
	cv4+dWJw2SW0kQtwQ8ZluMswUc6o=
X-Gm-Gg: ASbGncv53TPcNx2YeGxu0ZVRAjKXdzqSL7Eg6i3oVNyHk8PM00P3I6vKdocEYoHkoOg
	zM+y82TyrXkC8ND38fBTkVjtgeEUEmSQW8jYS04Sp08Se9Wo/BoliGUivknzoPf0PmF4AQsyLup
	v9XId5xO80+2shIdcChWomlOFQQveNi10b
X-Google-Smtp-Source: AGHT+IG10nTmSSofjOBje28dUf2+IMvpiGM28AIkNlFwzc+b2QjcTA+FDkybqQ1kasUk4HKenUIhjeB9Q2WKIKme63Y=
X-Received: by 2002:a17:902:c947:b0:221:751f:dab9 with SMTP id
 d9443c01a7336-22e103958e7mr62623825ad.14.1746381602442; Sun, 04 May 2025
 11:00:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502215133.1923676-1-ojeda@kernel.org> <20250502215133.1923676-3-ojeda@kernel.org>
 <CAJ-ks9=v8E_bV+oJ-bdm3KZW2dfrFdiCmeVLs+bgK8oVu6BCUA@mail.gmail.com>
In-Reply-To: <CAJ-ks9=v8E_bV+oJ-bdm3KZW2dfrFdiCmeVLs+bgK8oVu6BCUA@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 4 May 2025 19:59:50 +0200
X-Gm-Features: ATxdqUFd9uspIO8JG7LjKJl3xaEnjAQIhi12ZtAgUBxbovS5zZvywxn5xVHJpf0
Message-ID: <CANiq72=C1+2B221ecxM5Dy1rF8nEtR4ikgAA2nEh3M1=EkkXyg@mail.gmail.com>
Subject: Re: [PATCH 2/7] rust: kunit: support checked `-> Result`s in KUnit `#[test]`s
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

On Sun, May 4, 2025 at 7:34=E2=80=AFPM Tamir Duberstein <tamird@gmail.com> =
wrote:
>
> Why not restrict this to Result<(), E>?

I guess it is an option -- not sure if there may be a use case.

> Is it possible to include the error in the output?

I thought about giving some more context somehow and perhaps printing
it "manually" in the log, possibly in a KUnit `# ...`. David can
probably suggest the "proper" way.

Thanks!

Cheers,
Miguel

