Return-Path: <linux-kselftest+bounces-21352-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D6E9BA671
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Nov 2024 16:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 572AB281241
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Nov 2024 15:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81918176AA1;
	Sun,  3 Nov 2024 15:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8gWtwPu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6EB15D5C1;
	Sun,  3 Nov 2024 15:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730648501; cv=none; b=WHUKdj6lMzygy6CW3mb0KJT3WnaNK0P8dNaz17uhqxxCxsOz+vK1zfKwoQjw2XxjxLSvJSDq2H/XwQ+XBgVNQHdPN0BspNeGjhMQ/AyExuUdsQNig5eXrpcEckv1aZDZ8Qn6WuftHk2Ww/jqGB8+qa4XIBwUMrEwlk/xxDhgiyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730648501; c=relaxed/simple;
	bh=GyLcRZpOkBrsPxswcDFQ0iEUVqRw2osCdv+d3ezkn04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X23r9j92JoB22pcjlje8uXyO77rz/XJ1SsHMT67mgdmG2TdEAhijzSQ2X5OSHycW98YuauvSc05u67TeS0fLebj8tBfFTNmBYFKg5IpDvdNpysGDa6NjLQXrEKQO7I5U5AUaLrcuLFXmbvTe/Rx/iPKGgYS1fVXr/1XobbKexoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8gWtwPu; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7ea535890e0so569868a12.2;
        Sun, 03 Nov 2024 07:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730648499; x=1731253299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9gTIZzADuASrTW+VUIVvizdFrSJXJfISDBymYqSNdUQ=;
        b=Z8gWtwPu7XfmEoGNQBlUFUCrQCmW5d5h31r9m1m6BX7PRD2tpymsNkYmJSxz2FY9b7
         iAYgdlMtsIWt6nYTgyscGrmnmPMQ2vpTbymKBIbDG0hWwmhw3XTRiBoDZhcmjY5nS2ii
         PYUakRGN7wY7Qoj2ZbNBU3o4wV3Z5PdlSUpH7lgAojo+vdFlzDRevcOgK2fk90edjCTA
         g6AY/d3OZYOZ8ATzIMd/ueYGbrUV1KWRucGZCjrEZFnhSoj0PT3NRmNeDsPK0SAsA5jY
         961L6Th1akEn65SFroyQCGsxqHDrLnl7QKjyXilQGVyhsBsYwQzSnT0VvjAMkut9CpDh
         RZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730648499; x=1731253299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9gTIZzADuASrTW+VUIVvizdFrSJXJfISDBymYqSNdUQ=;
        b=JWiw4qv4rroARl2oIyxYxsE2Aybt9p+xV62RqOWX3qhmAjB8jwIsQtJRkWd47G1bVh
         H5JINRZUy5nEvdWZNWqrsix7/tQTbD/VdfMEgQpgS7vorjWXBTnwcfa1RR6WhluySHxU
         /FagwRRd+92zqohSkW7ag+zSrIoRTcLaEXds2mbVFlnmdMX8E5rTMP5JB1DUl1ozrXnV
         qPm4ZlHAMlVq3cXh+uvUFIUws9/dYiUUOhKxwO+QGwfpPUTL43qC8SrJE/0Fwu6prNfD
         1l26lBHF4NyoyIPGwYgfJhhgv4m06CvjgSdank91l1zFCbEslces0N/dqFE9Zg5HQY+7
         7/WA==
X-Forwarded-Encrypted: i=1; AJvYcCVRjOMQvRO/Pn6bNNwUl9mw5+kyTZWFKPjelkXvbW8Yhy5jt8MgbJKlH+yG9W6Winrs/nQSDFjEQv1ZeEjoaK7n@vger.kernel.org, AJvYcCWqz054pdcvTvf1DFWUUkP9wXYyEvrKW1YnBcf+aRMFGqmMyWmlMho00PstOGCEfxUZ8/t2afULm0SOA3VWztU=@vger.kernel.org, AJvYcCXD3qsUBGPZs8tlQO+tNezVm+mVxflPZHF0pdhDsvWIITEV0xn778VvzHKWwDltvAmq9CSiQzlpEIhYqHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX1XVsBnmjgO+OOwbW41G0UUWXrx94EeKyUXXwT8wFQzpp7rxz
	s9zriBYHh/8YMqXe4Khs2DaWJZfxFsWUtZk+DjJSWwj/rPLjsz/07C9zOKB0uqaOVT/0T//EPj1
	HlrLXMOeXkVQHcCVUQGasj4ljdptotOiZ
X-Google-Smtp-Source: AGHT+IEe28SlBSIrk0bjLKSCj7X8IBJqLInnAUxgkFLVSWSSYRoJ6oiVQ2ZyKKfTli7kJtAxzgUlvF/jYhozIC9fTy0=
X-Received: by 2002:a17:903:2285:b0:207:da7:bd95 with SMTP id
 d9443c01a7336-210c6ce5fc8mr180583105ad.13.1730648499051; Sun, 03 Nov 2024
 07:41:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101064505.3820737-1-davidgow@google.com> <20241101064505.3820737-3-davidgow@google.com>
 <ZyVKSKUq_bKH5jn_@Boquns-Mac-mini.local> <CANiq72=yhH7MEQWxVSVXGa5M5=HXudtS0Xja=w7ViU4Ph1Mpdw@mail.gmail.com>
 <ZyVtcXTW99YpUF0o@Boquns-Mac-mini.local>
In-Reply-To: <ZyVtcXTW99YpUF0o@Boquns-Mac-mini.local>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 3 Nov 2024 16:41:26 +0100
Message-ID: <CANiq72mMnmgG_SfRcxmo24Wjwtmc4Q5Q+zm4GmtZg=Cr5Dd7uw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] rust: macros: add macro to easily run KUnit tests
To: Boqun Feng <boqun.feng@gmail.com>
Cc: David Gow <davidgow@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	=?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Benno Lossin <benno.lossin@proton.me>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Matt Gilbride <mattgilbride@google.com>, 
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 2, 2024 at 1:08=E2=80=AFAM Boqun Feng <boqun.feng@gmail.com> wr=
ote:
>
> Hmm.. so I think clippy won't warn for a normal Rust #[test] function:
>
>         https://github.com/rust-lang/rust-clippy/pull/7811

That is a very good point. It is a bit surprising that those details
are not documented, but we could mimic that behavior.

(Personally, I don't particularly enjoy exceptional/context-dependent
cases, unless it is something used everywhere, like `use`ing the
prelude that we have).

Cheers,
Miguel

