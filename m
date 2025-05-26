Return-Path: <linux-kselftest+bounces-33827-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5FEAC4581
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 01:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE30318989BD
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 23:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5803241663;
	Mon, 26 May 2025 23:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Toydrlzg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C97414830A;
	Mon, 26 May 2025 23:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748301470; cv=none; b=RuLSdEQ8WXJUab1mzmS8hBZCsgbIMqeegDV65vYJyfFghxdJZd+8XqxIJETkCitE57AcckSca09JUlbREfLuQxqGRUvp7vSG02gaEDVkJjCzsPCXc/U1qcFKE/w2MyH0yBALJe79R0KVMUCefoVlFRVxmMMn6BXummUlTBIIAQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748301470; c=relaxed/simple;
	bh=/j09BPeE3E/NiK7v4LnFTp0Eilk8zqqtlKV3xNNcsj0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=UAnHw0p8s6IR2xzFoHmWzNgl/EqtlYuOD2JQklrEQVYVKGnsOrOSvgvM1Rrck2LVylh3p1m4OPLtHxefqZxk1HM3d8zsx6wa3WSpmG2AWu5kI4lrNwjOKrNz7qNZ1jt6PiX/IWh84y6+5OvtJhM5gpnoRl0Vwm/wnj89HLjAqWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Toydrlzg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B731DC4CEE7;
	Mon, 26 May 2025 23:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748301470;
	bh=/j09BPeE3E/NiK7v4LnFTp0Eilk8zqqtlKV3xNNcsj0=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=ToydrlzgB4/AD3R5ylHQaqRl4ZwuDOd8XUO/vXyOQKaD+BNCEtkjvG30nQds8Kcck
	 uxdM/EeTv80EfppD02Kl6C4PUw9tRq4C88IoPUPfvt/PChD2VVh0+gtYApq3ptma4t
	 cEdfN2IMxVM0k1m6aAi0zb+s8pLJHC5osqxdDw/6IMPNdy6DC9O+rKe9eu4uqd2Td7
	 bE9wD58tojx1yvua91L7DXNa+w4Fh3QxrkOeGSwJOPO6S4rjmraVwPGsIRDR5Ole7k
	 SA0EGxWootSi2CsKpF8BX6pAT9QrnmKEXZrDlS9l1Wkjkd55uY+PVvKLL7Hqoy2VsH
	 siNYX66Wiwi7Q==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 May 2025 01:17:37 +0200
Message-Id: <DA6H562MA3LJ.25NISAF9FT1ZD@kernel.org>
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
Subject: Re: [PATCH v10 5/5] rust: remove core::ffi::CStr reexport
From: "Benno Lossin" <lossin@kernel.org>
To: "Tamir Duberstein" <tamird@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250524-cstr-core-v10-0-6412a94d9d75@gmail.com>
 <20250524-cstr-core-v10-5-6412a94d9d75@gmail.com>
 <DA66OFXQCWUK.31LM78DIVABZV@kernel.org>
 <CAJ-ks9m=okC9_K2MJU80xbnO+3+Z0hvC_FYzCtzW9pD=WA_xqQ@mail.gmail.com>
In-Reply-To: <CAJ-ks9m=okC9_K2MJU80xbnO+3+Z0hvC_FYzCtzW9pD=WA_xqQ@mail.gmail.com>

On Tue May 27, 2025 at 12:30 AM CEST, Tamir Duberstein wrote:
> On Mon, May 26, 2025 at 11:05=E2=80=AFAM Benno Lossin <lossin@kernel.org>=
 wrote:
>>
>> On Sat May 24, 2025 at 10:33 PM CEST, Tamir Duberstein wrote:
>> > Clean up references to `kernel::str::CStr`.
>> >
>> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
>> > ---
>> >  drivers/gpu/drm/drm_panic_qr.rs   |  3 ++-
>> >  drivers/gpu/nova-core/firmware.rs |  2 +-
>> >  drivers/net/phy/ax88796b_rust.rs  |  1 +
>> >  drivers/net/phy/qt2025.rs         |  1 +
>> >  rust/kernel/device.rs             |  3 +--
>> >  rust/kernel/driver.rs             |  4 ++--
>> >  rust/kernel/error.rs              |  6 ++----
>> >  rust/kernel/faux.rs               |  5 ++++-
>> >  rust/kernel/firmware.rs           | 15 ++++-----------
>> >  rust/kernel/kunit.rs              |  6 +++---
>> >  rust/kernel/lib.rs                |  2 +-
>> >  rust/kernel/miscdevice.rs         |  3 +--
>> >  rust/kernel/net/phy.rs            |  4 +++-
>> >  rust/kernel/of.rs                 |  3 ++-
>> >  rust/kernel/pci.rs                |  2 +-
>> >  rust/kernel/platform.rs           |  2 +-
>> >  rust/kernel/prelude.rs            |  5 +----
>> >  rust/kernel/str.rs                | 22 ++++++++++------------
>> >  rust/kernel/sync/condvar.rs       |  4 ++--
>> >  rust/kernel/sync/lock.rs          |  4 ++--
>> >  rust/kernel/sync/lock/global.rs   |  5 +++--
>> >  rust/kernel/sync/poll.rs          |  1 +
>> >  rust/kernel/workqueue.rs          |  1 +
>> >  rust/macros/module.rs             |  2 +-
>> >  24 files changed, 51 insertions(+), 55 deletions(-)
>>
>> Haven't compile tested this series yet, but this commit seems to suggest
>> to me that some of the previous commits introduced code that doesn't
>> compile or emits warnings? If so that needs to be fixed.
>
> That's not the case. There are no warnings and no compilation failures
> in prior commits.

Ah it's because of the `pub use`... I tested it both with 1.86 and 1.78
and aside from the `use<>` error reported by the bot everything worked.

---
Cheers,
Benno

