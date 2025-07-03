Return-Path: <linux-kselftest+bounces-36482-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84475AF8136
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 21:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 341EF3B89CF
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 19:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186A32F2C65;
	Thu,  3 Jul 2025 19:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHYN9jhC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DB8298CA3;
	Thu,  3 Jul 2025 19:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751570243; cv=none; b=e4hpULlTv8t7bcb5izd1Oz44z2U0S6n7WBYTRqj0xyzfO7hwjWEXbHdd1gLgt3PtfKvenhbJEaZSg6/HuykP2x6I4aXXeFawQbI+cO+Tt5vZ4sAzqcu+cNnFhwXuJzKfXy5N03+K6BqLe/9NzmQhqiqHaK4gGs4GprZWyVeU8E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751570243; c=relaxed/simple;
	bh=8e3W8v7w5bcyQIgewGyA9kt9oSM7xIJIbCEFgUMyAAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kY17xv5a+RGTC34ItuF4Zv/9IefofXjcM7XLZGIh2WYuU2R/xf/IWd+p4cSWXYTRDSxYpB4bOaOwAOQAMuYqQEpe0PIrZE/n5Gm2+mEq5rAiUaEihf1wZaWAGYoA6tEE0KrClBiJOcYL6NIZ/0UBjNPJQUGrNZqya9YEJabRa9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XHYN9jhC; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-32cd0dfbd66so1943161fa.3;
        Thu, 03 Jul 2025 12:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751570239; x=1752175039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R3Barr3IhXzrNTPGC2RTs5bswjpJKBTkkOzXAPniR4c=;
        b=XHYN9jhC0PZ64ASbC6MVF6NWEpjDLlqnSZcdhSmT/MYnclnSalVM02TEqQD+LackTU
         xf9vqY5/HLBUBCjGWwvWUSBP6FFyw4dWBHw5fMEuf8YSNYI0a16sSjgRCTDLldMZg7t1
         DXXNRCTu3J09Q9W70UcQ5ISFZQcnB+POq+0QwsMMeCLxlTB1Jn1UJZWZZZN2cNEscqGD
         /Pry5/Qzs/EQgG4693kddfOrBCKRYh1+kDorUaQrPAieks4IRtZu5Xt/HTJlzgt2eFZl
         bvhR2avzKXIcPTv9oVzuAlOIEV3udetfxpdy7DHKZhL/2B9GTwnZSwM+5OwiVG+lFHPn
         L28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751570239; x=1752175039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R3Barr3IhXzrNTPGC2RTs5bswjpJKBTkkOzXAPniR4c=;
        b=BKpTY2KjJVOWQiXriis4qJ0dyxkmE780Mz+n1Pdmt2PJKsyhAFneilkmZe7OP9fewU
         XQqPYEhMniDigAVFO1wwXISv/up80QCxW51dPYKSvIg4BkO2Ja3472/CZ5XgaQZD1+QF
         kMNqN68WnCag5hBZtqgdN7O6JszbzaQAy19TJEmYxn+KRQ40kz1roxf+odM1qrCk5M6k
         Bu1FEjUVglkCQLnHpxLNV0ytV9MhC+ETjdQmb+j/JwirA4bQyPdvb93kvccmaN3Lbc9H
         E7dK6Z9pwDc8JP/YUfMDfXC0g7c9UGaIvDCYlw8WCGXjudXADxQWsMh1SnFzkqgMYooK
         g0sg==
X-Forwarded-Encrypted: i=1; AJvYcCV0x1prkS9Opk/WN2MBLJh7F65VUMIIlB6VgPwT7Rqh/smAanb7pGUqAeiqBrHC2D7MYybicrSUobtqS8M=@vger.kernel.org, AJvYcCV6JMO3qtQwPDMk4zcmAJ9WEuqieKKX/1QsIYYMBjkb29duPbfufwwupKIn9hHFRtqNGLsxqgl3ek9t@vger.kernel.org, AJvYcCVKvbkl0UkzHXGMwGQtFn6qFuAlvpphN45VHO0ujEI+rm9dKcdk1PnLNXs77zIlXCDPy0F6zp0H@vger.kernel.org, AJvYcCWXjm0Z8X3X/SbxUoIXAnN2JG2nMQoZ+iKaZUXQUnXeHkTi2XZRsn85/VMB2Kyu9xIfT8Bk8ZO1Y4ciNzGX@vger.kernel.org, AJvYcCWYqOBU/tN9EnPpoc9hxnO/xeOhzrM0mAdHUPrBqZf5jEi4xrqbvodUCKF8c3ZLNnPx1lEVt8YoaLBmzKoMsRc=@vger.kernel.org, AJvYcCX8MvpA5ZcXrustMrBULAJQwMtNQfj4IXXdEJe8QGny7si0t0ZwYRNDMqDh7KcfCcRESLbxjhdTGuX9@vger.kernel.org, AJvYcCXDuNADXeCALEcj31q5XyazECv/9UG1MxKUYazfeQVnSr7NQ1OEdPU4kzLi8A/D2rajf2E42MTw7ADj0+BEB9LP@vger.kernel.org, AJvYcCXFDUQ6zmK6wMMuweaBgSNFfHkEsZGrcqtD9VWrM0QOlhtKVF093oASgq2kWT1pBXjgHxVrY1ABckc=@vger.kernel.org, AJvYcCXcqXVhntPjs453kfnuO/Bno79rixzJtG1J3qQAuFFgOBXJXYWyeLckkQMKWLLldmaTHJo8rfdP75yJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyRX0JkJwNF1MSdUMP8JTwneFdTf2W0To9LngexUnCRHxyKaQOK
	hpA+GYXwjGfjd+Z66Xm4QodQtDxjlbHFcqQ6UCzStvqIERsqG8oBIdrN2IA59RjQ1fsT2Zke/CT
	m8DynGvGj7WCGbUu5I1VQCRwi8N2nYe0=
X-Gm-Gg: ASbGncvE/17EmCkJpr+D89P468ZRQho8gGUlYT9LXEp5nOy4cyTwEbeA4wVvN1m5NkE
	Jc4WZcPQPIYqOWeen+HfoXnOSjQI6YL7/ibvOYwb2r5A4vxNDK6UlDVKxI2fPBi9UxnyaHuEqom
	KGMpxDc2JDhkh8+YITxGL8NHn8m3rn9Fe96nFl8iNtUrgMzQ==
X-Google-Smtp-Source: AGHT+IGjC0TGXLvqJzlq7AH9t/Q8+27F2aQQEGTeZqTm6S+IuruBMFgglwnG67+02iIc84HBQzCfPbXa93QdJ3TTD74=
X-Received: by 2002:a05:651c:3c2:b0:327:fec0:b85d with SMTP id
 38308e7fff4ca-32e00049994mr27628221fa.21.1751570238849; Thu, 03 Jul 2025
 12:17:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701-cstr-core-v13-0-29f7d3eb97a6@gmail.com>
 <20250701-cstr-core-v13-2-29f7d3eb97a6@gmail.com> <DB2BDSN1JH51.14ZZPETJORBC6@kernel.org>
 <CAJ-ks9nC=AyBPXRY3nJ0NuZvjFskzMcOkVNrBEfXD2hZ5uRntQ@mail.gmail.com>
 <DB2IJ9HBIM0W.3N0JVGKX558QI@kernel.org> <CAJ-ks9nF5+m+_bn0Pzi9yU0pw0TyN7Fs4x--mQ4ygyHz4A6hzg@mail.gmail.com>
In-Reply-To: <CAJ-ks9nF5+m+_bn0Pzi9yU0pw0TyN7Fs4x--mQ4ygyHz4A6hzg@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 3 Jul 2025 15:16:42 -0400
X-Gm-Features: Ac12FXxZ9om-DmQ4Jtb_QO5Js54rwUi8z1hnIkmX71Lj1sGPMSjTGrGnMcngSCg
Message-ID: <CAJ-ks9nCHCBqfM5nG3XpBBsWSqGpJLexV53UGL2i3KTdRiWRXQ@mail.gmail.com>
Subject: Re: [PATCH v13 2/5] rust: support formatting of foreign types
To: Benno Lossin <lossin@kernel.org>
Cc: Michal Rostecki <vadorovsky@protonmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	Danilo Krummrich <dakr@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Breno Leitao <leitao@debian.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, dri-devel@lists.freedesktop.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, llvm@lists.linux.dev, 
	linux-pci@vger.kernel.org, nouveau@lists.freedesktop.org, 
	linux-block@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 2:55=E2=80=AFPM Tamir Duberstein <tamird@gmail.com> =
wrote:
>
> On Thu, Jul 3, 2025 at 11:08=E2=80=AFAM Benno Lossin <lossin@kernel.org> =
wrote:
> >
> > On Thu Jul 3, 2025 at 3:55 PM CEST, Tamir Duberstein wrote:
> > > On Thu, Jul 3, 2025 at 5:32=E2=80=AFAM Benno Lossin <lossin@kernel.or=
g> wrote:
> > >> On Tue Jul 1, 2025 at 6:49 PM CEST, Tamir Duberstein wrote:
> > >> > Introduce a `fmt!` macro which wraps all arguments in
> > >> > `kernel::fmt::Adapter` and a `kernel::fmt::Display` trait. This en=
ables
> > >> > formatting of foreign types (like `core::ffi::CStr`) that do not
> > >> > implement `core::fmt::Display` due to concerns around lossy conver=
sions which
> > >> > do not apply in the kernel.
> > >> >
> > >> > Replace all direct calls to `format_args!` with `fmt!`.
> > >> >
> > >> > Replace all implementations of `core::fmt::Display` with implement=
ations
> > >> > of `kernel::fmt::Display`.
> > >> >
> > >> > Suggested-by: Alice Ryhl <aliceryhl@google.com>
> > >> > Link: https://rust-for-linux.zulipchat.com/#narrow/channel/288089-=
General/topic/Custom.20formatting/with/516476467
> > >> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > >> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > >> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > >> > ---
> > >> >  drivers/block/rnull.rs       |  2 +-
> > >> >  drivers/gpu/nova-core/gpu.rs |  4 +-
> > >> >  rust/kernel/block/mq.rs      |  2 +-
> > >> >  rust/kernel/device.rs        |  2 +-
> > >> >  rust/kernel/fmt.rs           | 89 +++++++++++++++++++++++++++++++=
++++++++
> > >> >  rust/kernel/kunit.rs         |  6 +--
> > >> >  rust/kernel/lib.rs           |  1 +
> > >> >  rust/kernel/prelude.rs       |  3 +-
> > >> >  rust/kernel/print.rs         |  4 +-
> > >> >  rust/kernel/seq_file.rs      |  2 +-
> > >> >  rust/kernel/str.rs           | 22 ++++------
> > >> >  rust/macros/fmt.rs           | 99 +++++++++++++++++++++++++++++++=
+++++++++++++
> > >> >  rust/macros/lib.rs           | 19 +++++++++
> > >> >  rust/macros/quote.rs         |  7 ++++
> > >> >  scripts/rustdoc_test_gen.rs  |  2 +-
> > >> >  15 files changed, 236 insertions(+), 28 deletions(-)
> > >>
> > >> This would be a lot easier to review if he proc-macro and the call
> > >> replacement were different patches.
> > >>
> > >> Also the `kernel/fmt.rs` file should be a different commit.
> > >
> > > Can you help me understand why? The changes you ask to be separated
> > > would all be in different files, so why would separate commits make i=
t
> > > easier to review?
> >
> > It takes less time to go through the entire patch and give a RB. I can
> > take smaller time chunks and don't have to get back into the entire
> > context of the patch when I don't have 30-60min available.
>
> Ah, I see what you mean. Yeah, the requirement to RB the entire patch
> does mean there's a benefit to smaller patches.
>
> > In this patch the biggest problem is the rename & addition of new
> > things, maybe just adding 200 lines in those files could be okay to go
> > together, see below for more.
>
> After implementing your suggestion of re-exporting things from
> `kernel::fmt` the diffstat is
>
> 26 files changed, 253 insertions(+), 51 deletions(-)
>
> so I guess I could do all the additions in one patch, but then
> *everything* else has to go in a single patch together because the
> formatting macros either want core::fmt::Display or
> kernel::fmt::Display; they can't work in a halfway state.
>
> >
> > > I prefer to keep things in one commit because the changes are highly
> > > interdependent. The proc macro doesn't make sense without
> > > kernel/fmt.rs and kernel/fmt.rs is useless without the proc macro.
> >
> > I think that `Adapter`, the custom `Display` and their impl blocks
> > don't need to be in the same commit as the proc-macro. They are related=
,
> > but maybe someone is not well-versed in proc-macros and thus doesn't
> > want to review that part.
>
> Sure, I guess I will split them. But as noted above: changing the
> formatting macros and all the types' trait implementations has to be a
> "flag day" change.
>
> >
> > >> > diff --git a/rust/kernel/fmt.rs b/rust/kernel/fmt.rs
> > >> > new file mode 100644
> > >> > index 000000000000..348d16987de6
> > >> > --- /dev/null
> > >> > +++ b/rust/kernel/fmt.rs
> > >> > @@ -0,0 +1,89 @@
> > >> > +// SPDX-License-Identifier: GPL-2.0
> > >> > +
> > >> > +//! Formatting utilities.
> > >> > +
> > >> > +use core::fmt;
> > >>
> > >> I think we should pub export all types that we are still using from
> > >> `core::fmt`. For example `Result`, `Formatter`, `Debug` etc.
> > >>
> > >> That way I can still use the same pattern of importing `fmt` and the=
n
> > >> writing
> > >>
> > >>     impl fmt::Display for MyType {
> > >>         fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {}
> > >>     }
> > >
> > > Great idea, done for the next spin. It would be nice to be able to
> > > lint against references to `core::fmt` outside of kernel/fmt.rs.
> >
> > I think there was something in clippy that can do that globally and we
> > could allow that in this file?
>
> I didn't find anything suitable. Do you have one in mind?

I think we want https://github.com/rust-lang/rust-clippy/issues/14807.

