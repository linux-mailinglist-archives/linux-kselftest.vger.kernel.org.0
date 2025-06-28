Return-Path: <linux-kselftest+bounces-36041-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1209AEC732
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 14:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FC9A1BC2F9A
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 12:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A24C248F51;
	Sat, 28 Jun 2025 12:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="kO4zj33U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from forward501b.mail.yandex.net (forward501b.mail.yandex.net [178.154.239.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA66B247295;
	Sat, 28 Jun 2025 12:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751114579; cv=none; b=eT+RfpyABUAJBny9vyoCandoytZ1PQLYgNmXvwqDhIlv6GDEBzTSnWFXeAOCOByT7XnV2za7l+X50XSJ+CI7HbJd82zvRPjOTvtobTMsmTuvqFui/sTFU1bNurejxjkJouPaFfoyH8WT9c84Dx8qa9esnSX2A9klZwyooNfG0u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751114579; c=relaxed/simple;
	bh=s/WZnLwH3tHwxZ/2hCc6hHoR41MuA7BSIsnaMlHFV2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VeyM6KO9rsuGY7ZIvbjBP0vqis5y8oAi4TUd4jXNd7aqpoGFCfdLS6mb5tILHlIg2sQh3rUWLDG6scWQlRcNf9C9pXKN6ulADsvXLwLxRyjqFBx+dpy9RP6kLhofqlYhHq1ZwNejgYsbYrv4dbgLPonNqUqiR8QsB8GwezdI0hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=kO4zj33U; arc=none smtp.client-ip=178.154.239.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net [IPv6:2a02:6b8:c11:c1e:0:640:507e:0])
	by forward501b.mail.yandex.net (Yandex) with ESMTPS id 2E0436166C;
	Sat, 28 Jun 2025 15:42:47 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id cgWMKGFLu0U0-cPlMrCZa;
	Sat, 28 Jun 2025 15:42:45 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1751114565;
	bh=l9sqUa1BCO8G9s1UQoEHxXQzb1nfW17lDgk2JjFmzCw=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=kO4zj33U4BUJWRq7uO+H5s9Fg1NfZTZLABQkmN8D8eND+h1LgxQEFvO6shgQEze4Y
	 bnMBgsFDeWJa4E/1JT4mVk1Gjw4An/QAQh944aZD5f7zGuVWXInPMWF+UJlJAb/Pje
	 61etcJ5bnEGOixDGzM2ljCzJAJnVv50u6pvj/uNs=
Authentication-Results: mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Sat, 28 Jun 2025 15:42:37 +0300
From: Onur <work@onurozkan.dev>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: viresh.kumar@linaro.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 airlied@gmail.com, simona@ffwll.ch, ojeda@kernel.org,
 alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 aliceryhl@google.com, tmgross@umich.edu, rafael@kernel.org,
 gregkh@linuxfoundation.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, davidgow@google.com, nm@ti.com
Subject: Re: [PATCH v3 3/3] rust: remove
 `#[allow(clippy::non_send_fields_in_send_ty)]`
Message-ID: <20250628154237.0f367cee@nimda.home>
In-Reply-To: <CANiq72kY9DA_JD_XkF01ZSmXbD8iaFthVZ66X+9N5aa_WObt+A@mail.gmail.com>
References: <20250628040956.2181-1-work@onurozkan.dev>
	<20250628040956.2181-4-work@onurozkan.dev>
	<CANiq72kjdj4KbDhfnTbm8jZpLC1+WPB3E6M8D8M2NLnphMs5vg@mail.gmail.com>
	<20250628133013.703461c8@nimda.home>
	<CANiq72kY9DA_JD_XkF01ZSmXbD8iaFthVZ66X+9N5aa_WObt+A@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 28 Jun 2025 14:18:53 +0200
Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:

> On Sat, Jun 28, 2025 at 12:30=E2=80=AFPM Onur <work@onurozkan.dev> wrote:
> >
> > It doesn't seem to be the same reason. I rebased over
> > c6af9a1191d042839e56abff69e8b0302d117988 (the exact commit where
> > that lint was added) but still Clippy did not complain about it on
> > the MSRV. So it was either a leftover, or there is a version between
> > 1.78 and the current stable where Clippy did complain. I can dig
> > into it more during the week if you would like.
>=20
> Are you sure? The lint is actually disabled, as I mention in
> 5e7c9b84ad08.
>=20
> From a quick test, I enabled it in that file, and I get the warning.
>=20
> Thus it seems to me Clippy would still complain about it just fine.

Yes, I am sure. Just to clarify, I am not testing 5e7c9b84ad08. I am
testing c6af9a1191d042839e56abff69e8b0302d117988 where
`#[allow(clippy::non_send_fields_in_send_ty)]` was added on
`unsafe impl<T: Driver> Send for Registration<T> {}`.

Switching from `allow` to `expect` produced the following result on my
end:

```
$ make LLVM=3D1 -j $(nproc)
CLIPPY=3D1 DESCEND objtool
  CALL    scripts/checksyscalls.sh
  INSTALL libsubcmd_headers
  CLIPPY L rust/kernel.o
error: this lint expectation is unfulfilled
   --> rust/kernel/cpufreq.rs:908:10
    |
908 | #[expect(clippy::non_send_fields_in_send_ty)]
    |          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    |
    =3D note: `-D unfulfilled-lint-expectations` implied by `-D warnings`
    =3D help: to override `-D warnings` add
`#[allow(unfulfilled_lint_expectations)]`

error: aborting due to 1 previous error

make[2]: *** [rust/Makefile:534: rust/kernel.o] Error 1
make[1]: *** [/home/nimda/devspace/onur-ozkan/linux/Makefile:1283:
prepare] Error 2 make: *** [Makefile:248: __sub-make] Error 2

$ git log -1
commit c6af9a1191d042839e56abff69e8b0302d117988 (HEAD -> master)
Author: Viresh Kumar <viresh.kumar@linaro.org>
Date:   Wed Jan 24 12:36:33 2024 +0530

    rust: cpufreq: Extend abstractions for driver registration

    Extend the cpufreq abstractions to support driver registration from
    Rust.

    Reviewed-by: Danilo Krummrich <dakr@kernel.org>
    Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

$ rustc --version --verbose
rustc 1.78.0 (9b00956e5 2024-04-29)
binary: rustc
commit-hash: 9b00956e56009bab2aa15d7bff10916599e3d6d6
commit-date: 2024-04-29
host: x86_64-unknown-linux-gnu
release: 1.78.0
LLVM version: 18.1.2
```

Regards,
Onur


