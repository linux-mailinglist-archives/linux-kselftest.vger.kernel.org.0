Return-Path: <linux-kselftest+bounces-33826-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9E7AC4571
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 01:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7B483AD53C
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 23:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D37223706;
	Mon, 26 May 2025 23:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hmnhKAlk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B774A0A;
	Mon, 26 May 2025 23:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748300827; cv=none; b=cGZJleOzLvryrq8DZ1vWtmbNp9zbgKApqdU0pzqHPZCrT/ckneYSdu8YxgTQ/7Drt+vJ0blcbxPYqBBMoj13fgqTSp+ibsKzgnhRcF+LQx40QT3HOOZs+SI+tKmwbCtKMzhRXUXZdNoHWqgEAZDx1E4tlHcML96zd5O1uh37f94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748300827; c=relaxed/simple;
	bh=4GTm92/StxP3CBkdP9+oBFRRK5sAn5a+30xV9eMTjdU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=dZQMYB96wnZozZyoNKZsIdk6RzyaFZMNOVLhK1RA//b+SPOE5LQ13xklUHnK0Dl/fFHaT6HNkCKG5rp8o61ad+h2tdbOQaYZltC7MUV6QI+LTpzIL5Dis+7CqNh7x99gHxlFijs1H68mH84Wi/8ch2KvL8mKj/5jcCUj7rIxDCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hmnhKAlk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FFA7C4CEE7;
	Mon, 26 May 2025 23:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748300826;
	bh=4GTm92/StxP3CBkdP9+oBFRRK5sAn5a+30xV9eMTjdU=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=hmnhKAlkvuE2emSj9dfAfZcutKdfVzcU9bHAsmsJM0Zdbg+V3tiZL4LWoWqx3jK1j
	 3W6J1AiBX0jOVwW6Uu1l0coUJkbN0O0ub5j8wJo2M9UXwM5vZXNBD9kvVh9tq8uHsq
	 gLBAxelbgU8kLF9pUNkSdyvxKo/nMlcwAuEGO5BmfY0GFTGnOyUUIaOZL2F3dZHH3O
	 nnnM/URug0l9b4XyH0WCyhIzfOi+i6T0vfoSkCnTGQv2MEdZ0ix2Gw5r8+kcePcIAB
	 Uabc3hOKze8/XRm5QNUyIsnrUQBNoPOTwHuuWxMU2qSqGW4cGQwCFJK7RhFJovfi+z
	 ScfsK7T/pbYzA==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 May 2025 01:06:54 +0200
Message-Id: <DA6GWYHOSTWH.1OBQV7XCU2643@kernel.org>
Subject: Re: [PATCH v10 4/5] rust: replace `kernel::c_str!` with C-Strings
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
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
 <dri-devel@lists.freedesktop.org>, <netdev@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <llvm@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <nouveau@lists.freedesktop.org>,
 <linux-block@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20250524-cstr-core-v10-0-6412a94d9d75@gmail.com>
 <20250524-cstr-core-v10-4-6412a94d9d75@gmail.com>
 <DA66NJXU86M4.1HU12P6E79JLO@kernel.org>
 <CAJ-ks9nd6_iGK+ie-f+F0x4kwpyEGJ-kQiQGt-ffdbVN5S6kOg@mail.gmail.com>
In-Reply-To: <CAJ-ks9nd6_iGK+ie-f+F0x4kwpyEGJ-kQiQGt-ffdbVN5S6kOg@mail.gmail.com>

On Tue May 27, 2025 at 12:29 AM CEST, Tamir Duberstein wrote:
> On Mon, May 26, 2025 at 11:04=E2=80=AFAM Benno Lossin <lossin@kernel.org>=
 wrote:
>> On Sat May 24, 2025 at 10:33 PM CEST, Tamir Duberstein wrote:
>> > +macro_rules! c_str_avoid_literals {
>>
>> I don't like this name, how about `concat_to_c_str` or
>> `concat_with_nul`?
>>
>> This macro also is useful from macros that have a normal string literal,
>> but can't turn it into a `c""` one.
>
> Uh, can you give an example? I'm not attached to the name.

There is one in this patch (:

    diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs               =
                                                                     =20
    index e5621d596ed3..09148e982f48 100644                                =
                                                                     =20
    --- a/rust/kernel/kunit.rs                                             =
                                                                     =20
    +++ b/rust/kernel/kunit.rs                                             =
                                                                     =20
    @@ -58,9 +58,10 @@ macro_rules! kunit_assert {                         =
                                                                     =20
                     break 'out;                                           =
                                                                     =20
                 }                                                         =
                                                                     =20
                                                                           =
                                                                     =20
    -            static FILE: &'static $crate::str::CStr =3D $crate::c_str!=
($file);                                                               =20
    +            static FILE: &'static $crate::str::CStr =3D $crate::c_str_=
avoid_literals!($file);

---
Cheers,
Benno

