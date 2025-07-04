Return-Path: <linux-kselftest+bounces-36539-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D27AF8F86
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 12:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC498482434
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 10:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330BB2EF653;
	Fri,  4 Jul 2025 10:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjHFAeZa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4B1293B61;
	Fri,  4 Jul 2025 10:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751623798; cv=none; b=XBdrhpDa/+z3W56N2gbnzZhJllid9a+HCRKtMsdD97Hugb2PDGjMAcrMRwiVUpKrhwiQfJcQvjpMb5TgGYpm1cVwOzpq87bbbdwCpObo1UDUPL0ljJHkmmAK39tHHHEj/gt+jIhU0+sTZTLwNSIA0/c6avMPOPr9/GzAW8BR4eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751623798; c=relaxed/simple;
	bh=sErifeomiBisSrJ5F/Z1EiOE+yjyaoOoLVJmALiwIss=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=QBSQrQtDxl3khpvRlIPU5qS8NjGQcj8bGfiG/4VLzik4oLgXwc2074TM6uBfJ6SgTIqix4uNEDSeMVkZzCLHc0Rh6MdthBE2RcCXqdqwRLBxsoLarlHh4+ZwhuqZwHzHjigPU/LkbovziNf9+Nbw1oaGQuvoXCNP18CP7DrmY1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjHFAeZa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EB26C4CEE3;
	Fri,  4 Jul 2025 10:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751623797;
	bh=sErifeomiBisSrJ5F/Z1EiOE+yjyaoOoLVJmALiwIss=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=bjHFAeZaJFAnmlfy0BXQom4D2g8nROdZRV9VSgmHVyp34hx86laW5qYZ9hJt1xRQW
	 0K0KO2yByzLe4dQZLFhD35Ow6d8OFCvrtXqBJsfVoIIfyv2UGdJYm4h3q0G5Jkpw5z
	 wGhbmAF7CZg/+Usn4oPgUWLuVpcLqO00+9bczIkO/xSH+5IJAtnA1+gQ91n+wiBcP6
	 B7oDcHjP2qL77G1iVen1zde1nv2qXrbY4ckstCIFg4BI/BrUjKystwvqi6oNlmq8/O
	 6gVbjWvcNhrRjps2Q90t25m0FTomyUvTA0EnLcqcQEkGdXcBV9HXEB+8pGkJCpLBEg
	 +vGw4nMjPXgxg==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 04 Jul 2025 12:09:43 +0200
Message-Id: <DB36T5JWBL10.2F56EDJ1XKAD0@kernel.org>
Subject: Re: [PATCH v13 2/5] rust: support formatting of foreign types
From: "Benno Lossin" <lossin@kernel.org>
To: "Tamir Duberstein" <tamird@gmail.com>
Cc: "Michal Rostecki" <vadorovsky@protonmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Brendan Higgins"
 <brendan.higgins@linux.dev>, "David Gow" <davidgow@google.com>, "Rae Moar"
 <rmoar@google.com>, "Danilo Krummrich" <dakr@kernel.org>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Luis Chamberlain" <mcgrof@kernel.org>, "Russ Weight"
 <russ.weight@linux.dev>, "FUJITA Tomonori" <fujita.tomonori@gmail.com>,
 "Rob Herring" <robh@kernel.org>, "Saravana Kannan" <saravanak@google.com>,
 "Peter Zijlstra" <peterz@infradead.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Will Deacon" <will@kernel.org>, "Waiman Long" <longman@redhat.com>,
 "Nathan Chancellor" <nathan@kernel.org>, "Nick Desaulniers"
 <nick.desaulniers+lkml@gmail.com>, "Bill Wendling" <morbo@google.com>,
 "Justin Stitt" <justinstitt@google.com>, "Andrew Lunn" <andrew@lunn.ch>,
 "Heiner Kallweit" <hkallweit1@gmail.com>, "Russell King"
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Bjorn Helgaas" <bhelgaas@google.com>, "Arnd
 Bergmann" <arnd@arndb.de>, "Jens Axboe" <axboe@kernel.dk>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Dave
 Ertman" <david.m.ertman@intel.com>, "Ira Weiny" <ira.weiny@intel.com>,
 "Leon Romanovsky" <leon@kernel.org>, "Breno Leitao" <leitao@debian.org>,
 "Viresh Kumar" <viresh.kumar@linaro.org>, "Michael Turquette"
 <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
 <dri-devel@lists.freedesktop.org>, <netdev@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <llvm@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <nouveau@lists.freedesktop.org>,
 <linux-block@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <linux-clk@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20250701-cstr-core-v13-0-29f7d3eb97a6@gmail.com>
 <20250701-cstr-core-v13-2-29f7d3eb97a6@gmail.com>
 <DB2BDSN1JH51.14ZZPETJORBC6@kernel.org>
 <CAJ-ks9nC=AyBPXRY3nJ0NuZvjFskzMcOkVNrBEfXD2hZ5uRntQ@mail.gmail.com>
 <DB2IJ9HBIM0W.3N0JVGKX558QI@kernel.org>
 <CAJ-ks9nF5+m+_bn0Pzi9yU0pw0TyN7Fs4x--mQ4ygyHz4A6hzg@mail.gmail.com>
 <DB2PIGAQHCJR.3BF8ZHECYH3KB@kernel.org>
 <CAJ-ks9=WmuXLJ6KkMEOP2jTvM_YBJO10SNsq0DU2J+_d4jp7qw@mail.gmail.com>
 <CAJ-ks9kNiOgPO7FF3cAbaSNtTWs0_PzQ4k4W0AxjHNFuMJnDcQ@mail.gmail.com>
In-Reply-To: <CAJ-ks9kNiOgPO7FF3cAbaSNtTWs0_PzQ4k4W0AxjHNFuMJnDcQ@mail.gmail.com>

On Fri Jul 4, 2025 at 1:23 AM CEST, Tamir Duberstein wrote:
> On Thu, Jul 3, 2025 at 6:41=E2=80=AFPM Tamir Duberstein <tamird@gmail.com=
> wrote:
>> On Thu, Jul 3, 2025 at 4:36=E2=80=AFPM Benno Lossin <lossin@kernel.org> =
wrote:
>> >
>> > I don't understand, can't you just do:
>> >
>> > * add `rust/kernel/fmt.rs`,
>> > * add `rust/macros/fmt.rs`,
>> > * change all occurrences of `core::fmt` to `kernel::fmt` and
>> >   `format_args!` to `fmt!`.
>>
>> Yes, such a split could be done - I will do so in the next spin
>>
>>
>> > The last one could be split by subsystem, no? Some subsystems might
>> > interact and thus need simultaneous splitting, but there should be som=
e
>> > independent ones.
>>
>> Yes, it probably can. As you say, some subsystems might interact - the
>> claimed benefit of doing this subsystem-by-subsystem split is that it
>> avoids conflicts with ongoing work that will conflict with a large
>> patch, but this is also the downside; if ongoing work changes the set
>> of interactions between subsystems then a maintainer may find
>> themselves unable to emit the log message they want (because one
>> subsystem is using kernel::fmt while another is still on core::fmt).
>
> I gave this a try. I ran into the problem that `format_args!` (and,
> after this patch, `fmt!`) is at the center of `print_macro!`, which
> itself underpins various other formatting macros. This means we'd have
> to bifurcate the formatting infrastructure to support an incremental
> migration. That's quite a bit of code, and likely quite a mess in the
> resulting git history -- and that's setting aside the toil required to
> figure out the correct combinations of subsystems that must migrate
> together.

So here is what we can do without duplicating the logic, though it
requires multiple cycles:

1. We merge the two `fmt.rs` files & each subsystem merges an
   implementation of `kernel::fmt::Display` for their types, but keeps
   the `core::fmt::Display` impl around.
2. After all subsystems have merged the previous step, we change the
   implementations of `print_macro!` to use `fmt!` instead of
   `format_args!`.
3. We remove all occurrences of `core::fmt` (& replace them with
   `kernel::fmt`), removing the `core::fmt::Display` impls.

---
Cheers,
Benno

