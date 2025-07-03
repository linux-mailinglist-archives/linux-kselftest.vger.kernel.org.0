Return-Path: <linux-kselftest+bounces-36484-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87048AF82A9
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 23:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2E4817DF27
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 21:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C43E2BE7D9;
	Thu,  3 Jul 2025 21:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Nas0qbwd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F1B2AF19;
	Thu,  3 Jul 2025 21:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751578131; cv=none; b=oJNUjWpHI5H3OsUODtQ4BZjorF0w4Dw2SfGwtD4B+TOVp+7QnMSkujFF3r3oWsv0ctLIuqMP9YwBiO/OTfyZxT05kXbEAUwj+4frTLBLg/kkvPP/wgSZpnWLZmLOR/6kdci7QQ20QQwuhbsL8DI3Ll3sbrY252BpcFROAzzlA8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751578131; c=relaxed/simple;
	bh=7s1vdVb4Jp0AKYi0fqgt4BTeqCIZhFaWic60VjgU5TU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GHB5t5XzldEmrSlyUzdCzN5OmzCJIS5T3FdIn0uTbHwi+calt1iaanfpHJVlhnmTyTUkSMxGXU2iMgy/Qy5MbLWP6SXR3RluJU2NlnbQdYsJ81Qk20k0HiPd7wRKxVfTqhD6oWX3YyniAANFhC7+0y3+JtkJO7Nat1kcEUsXAYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Nas0qbwd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=A83NKRGoevWzL/NcvqijuYTaZ0xDTVIZ9pvu0pc07Jk=; b=Na
	s0qbwdL6B67K0wS+f7tbNlfneHHctNev/cTniYFhLMkwezOAunGEDatFtpLb4g+PG761JVmPtbDzC
	rfpydruVCCrDayQ33cjSGl/o6BiA+VGkuX6ILQmO0/nR1G4/Ap/W5RcWrBNuhbzqrUhTrrpdbnIlt
	YvmVDe7keP8zJfo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uXRTN-0008hX-2p; Thu, 03 Jul 2025 23:28:01 +0200
Date: Thu, 3 Jul 2025 23:28:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Benno Lossin <lossin@kernel.org>,
	Michal Rostecki <vadorovsky@protonmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Jens Axboe <axboe@kernel.dk>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	llvm@lists.linux.dev, linux-pci@vger.kernel.org,
	nouveau@lists.freedesktop.org, linux-block@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v13 2/5] rust: support formatting of foreign types
Message-ID: <34c00dfa-8302-45ee-8d80-58b97a08e52e@lunn.ch>
References: <20250701-cstr-core-v13-0-29f7d3eb97a6@gmail.com>
 <20250701-cstr-core-v13-2-29f7d3eb97a6@gmail.com>
 <DB2BDSN1JH51.14ZZPETJORBC6@kernel.org>
 <CAJ-ks9nC=AyBPXRY3nJ0NuZvjFskzMcOkVNrBEfXD2hZ5uRntQ@mail.gmail.com>
 <DB2IJ9HBIM0W.3N0JVGKX558QI@kernel.org>
 <CAJ-ks9nF5+m+_bn0Pzi9yU0pw0TyN7Fs4x--mQ4ygyHz4A6hzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9nF5+m+_bn0Pzi9yU0pw0TyN7Fs4x--mQ4ygyHz4A6hzg@mail.gmail.com>

On Thu, Jul 03, 2025 at 02:55:30PM -0400, Tamir Duberstein wrote:
> On Thu, Jul 3, 2025 at 11:08 AM Benno Lossin <lossin@kernel.org> wrote:
> >
> > On Thu Jul 3, 2025 at 3:55 PM CEST, Tamir Duberstein wrote:
> > > On Thu, Jul 3, 2025 at 5:32 AM Benno Lossin <lossin@kernel.org> wrote:
> > >> On Tue Jul 1, 2025 at 6:49 PM CEST, Tamir Duberstein wrote:
> > >> > Introduce a `fmt!` macro which wraps all arguments in
> > >> > `kernel::fmt::Adapter` and a `kernel::fmt::Display` trait. This enables
> > >> > formatting of foreign types (like `core::ffi::CStr`) that do not
> > >> > implement `core::fmt::Display` due to concerns around lossy conversions which
> > >> > do not apply in the kernel.
> > >> >
> > >> > Replace all direct calls to `format_args!` with `fmt!`.
> > >> >
> > >> > Replace all implementations of `core::fmt::Display` with implementations
> > >> > of `kernel::fmt::Display`.
> > >> >
> > >> > Suggested-by: Alice Ryhl <aliceryhl@google.com>
> > >> > Link: https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General/topic/Custom.20formatting/with/516476467
> > >> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > >> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > >> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > >> > ---
> > >> >  drivers/block/rnull.rs       |  2 +-
> > >> >  drivers/gpu/nova-core/gpu.rs |  4 +-
> > >> >  rust/kernel/block/mq.rs      |  2 +-
> > >> >  rust/kernel/device.rs        |  2 +-
> > >> >  rust/kernel/fmt.rs           | 89 +++++++++++++++++++++++++++++++++++++++
> > >> >  rust/kernel/kunit.rs         |  6 +--
> > >> >  rust/kernel/lib.rs           |  1 +
> > >> >  rust/kernel/prelude.rs       |  3 +-
> > >> >  rust/kernel/print.rs         |  4 +-
> > >> >  rust/kernel/seq_file.rs      |  2 +-
> > >> >  rust/kernel/str.rs           | 22 ++++------
> > >> >  rust/macros/fmt.rs           | 99 ++++++++++++++++++++++++++++++++++++++++++++
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
> > > would all be in different files, so why would separate commits make it
> > > easier to review?
> >
> > It takes less time to go through the entire patch and give a RB. I can
> > take smaller time chunks and don't have to get back into the entire
> > context of the patch when I don't have 30-60min available.
> 
> Ah, I see what you mean. Yeah, the requirement to RB the entire patch
> does mean there's a benefit to smaller patches.

I often tell kernel newbies:

Lots of small patches which are obviously correct.

A small patch tends to be more obviously correct than a big patch. The
commit message is more focused and helpful because it refers to a
small chunk of code. Because the commit message is more focused, it
can answer questions reviewers might ask, before they ask them. If i
can spend 60 seconds looking at a patch and decide it looks correct,
i'm more likely to actually look at it and give a reviewed by. If i
need to find 10 minutes, it is going to get put off for a later
time. Many reviewers just have a few minutes here, a few there,
slotted into time between other tasks, while drinking coffee, etc.

	Andrew

