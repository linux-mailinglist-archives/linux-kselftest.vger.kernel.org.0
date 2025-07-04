Return-Path: <linux-kselftest+bounces-36558-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABDDAF9381
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 15:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F194C1CC0321
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 13:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9936302056;
	Fri,  4 Jul 2025 13:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mi+LrZHj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854A230115E;
	Fri,  4 Jul 2025 13:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751634040; cv=none; b=SKe0fAGSOx1JFqKAcC7jmbgGSKazfi17EXF98nTfCmeLnq5yV7JyZniqn3sNm6fGwQLfnaIfSZLVUC+FbTQn4OP/RgdcfInNo+4CMKE5qavggoSjnODOt4nhk3dqf3bDU2yp8zT4MMt9x24YnXYwbL4otgL1SIEvJhq/e6tLIH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751634040; c=relaxed/simple;
	bh=PQ+uuvbgXKFc5vIr220QI1Lf8oYUGvsoSa+Kga5uCxI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=CyR8vl9fWmINm7RKWId4dKPyemJ+9FqSebnWLZfFSs+UEEcvziTdvmE78TALAjSnNGurITdNjyS+SEu8DCBS807qDW6WL/bDrnQZx5dCJuxYJE94bbP6/KZGu2OL2Hm6q/X0mtxxoz1z+F233S/Li37GmVT0W4joNTzs5rGAUGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mi+LrZHj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F840C4CEE3;
	Fri,  4 Jul 2025 13:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751634040;
	bh=PQ+uuvbgXKFc5vIr220QI1Lf8oYUGvsoSa+Kga5uCxI=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=mi+LrZHjF+yRfLmrMqCm45+w6sUTBWLIFLln4t06TCRfNNID72odMCaUkq6P7uCUX
	 6UUsEVXl8dcAwtsGpEQ4be8tzBNVlVqFR/dHUws6kyBu1YvtpkQhwwKUxloNwWR9R/
	 IGSdHN0MxrYLaSCkpAV78+BdMxg3sCNdQTC9sRmKmYWFLMqIw4rrFCZRyV7KRJtd2E
	 0j73lXtusTnleqcS0NxrPxjaCD0MHAoeWaeskbB4i7ET3pELASmMynDmabvpgju8s5
	 lM5kWnUgAXLXzxzcI7AEuaVKCn3OYtKdR4/uhCwyRJ5lqmW3Ng5o+Qj0VkMX0rxdf6
	 342H5Q7Nz/erA==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 04 Jul 2025 15:00:24 +0200
Message-Id: <DB3AFTUC22W1.39C4DMWSENZGB@kernel.org>
Subject: Re: [PATCH v13 3/5] rust: replace `CStr` with `core::ffi::CStr`
From: "Benno Lossin" <lossin@kernel.org>
To: "Tamir Duberstein" <tamird@gmail.com>, "Michal Rostecki"
 <vadorovsky@protonmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex
 Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Brendan Higgins" <brendan.higgins@linux.dev>, "David Gow"
 <davidgow@google.com>, "Rae Moar" <rmoar@google.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>, "Thomas Zimmermann"
 <tzimmermann@suse.de>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Luis Chamberlain"
 <mcgrof@kernel.org>, "Russ Weight" <russ.weight@linux.dev>, "FUJITA
 Tomonori" <fujita.tomonori@gmail.com>, "Rob Herring" <robh@kernel.org>,
 "Saravana Kannan" <saravanak@google.com>, "Peter Zijlstra"
 <peterz@infradead.org>, "Ingo Molnar" <mingo@redhat.com>, "Will Deacon"
 <will@kernel.org>, "Waiman Long" <longman@redhat.com>, "Nathan Chancellor"
 <nathan@kernel.org>, "Nick Desaulniers" <nick.desaulniers+lkml@gmail.com>,
 "Bill Wendling" <morbo@google.com>, "Justin Stitt"
 <justinstitt@google.com>, "Andrew Lunn" <andrew@lunn.ch>, "Heiner Kallweit"
 <hkallweit1@gmail.com>, "Russell King" <linux@armlinux.org.uk>, "David S.
 Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, "Arnd Bergmann" <arnd@arndb.de>, "Jens
 Axboe" <axboe@kernel.dk>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Dave Ertman" <david.m.ertman@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, "Leon Romanovsky" <leon@kernel.org>, "Breno
 Leitao" <leitao@debian.org>, "Viresh Kumar" <viresh.kumar@linaro.org>,
 "Michael Turquette" <mturquette@baylibre.com>, "Stephen Boyd"
 <sboyd@kernel.org>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
 <dri-devel@lists.freedesktop.org>, <netdev@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <llvm@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <nouveau@lists.freedesktop.org>,
 <linux-block@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <linux-clk@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20250701-cstr-core-v13-0-29f7d3eb97a6@gmail.com>
 <20250701-cstr-core-v13-3-29f7d3eb97a6@gmail.com>
In-Reply-To: <20250701-cstr-core-v13-3-29f7d3eb97a6@gmail.com>

On Tue Jul 1, 2025 at 6:49 PM CEST, Tamir Duberstein wrote:
> `kernel::ffi::CStr` was introduced in commit d126d2380131 ("rust: str:
> add `CStr` type") in November 2022 as an upstreaming of earlier work
> that was done in May 2021[0]. That earlier work, having predated the
> inclusion of `CStr` in `core`, largely duplicated the implementation of
> `std::ffi::CStr`.
>
> `std::ffi::CStr` was moved to `core::ffi::CStr` in Rust 1.64 in
> September 2022. Hence replace `kernel::str::CStr` with `core::ffi::CStr`
> to reduce our custom code footprint, and retain needed custom
> functionality through an extension trait.
>
> C-String literals were added in Rust 1.77, while our MSRV is 1.78. Thus
> opportunistically replace instances of `kernel::c_str!` with C-String
> literals where other code changes were already necessary or where
> existing code triggered clippy lints; the rest will be done in a later
> commit.
>
> Link: https://github.com/Rust-for-Linux/linux/commit/faa3cbcca03d0dec8f8e=
43f1d8d5c0860d98a23f [0]
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  drivers/gpu/drm/drm_panic_qr.rs |   2 +-
>  rust/kernel/auxiliary.rs        |   4 +-
>  rust/kernel/configfs.rs         |   4 +-
>  rust/kernel/cpufreq.rs          |   2 +-
>  rust/kernel/device.rs           |   4 +-
>  rust/kernel/drm/device.rs       |   4 +-
>  rust/kernel/error.rs            |   4 +-
>  rust/kernel/firmware.rs         |  11 +-
>  rust/kernel/kunit.rs            |   6 +-
>  rust/kernel/miscdevice.rs       |   2 +-
>  rust/kernel/net/phy.rs          |   2 +-
>  rust/kernel/of.rs               |   2 +-
>  rust/kernel/prelude.rs          |   5 +-
>  rust/kernel/seq_file.rs         |   4 +-
>  rust/kernel/str.rs              | 394 +++++++++++-----------------------=
------
>  rust/kernel/sync/condvar.rs     |   2 +-
>  rust/kernel/sync/lock.rs        |   2 +-
>  rust/kernel/sync/lock/global.rs |   2 +-
>  samples/rust/rust_configfs.rs   |   2 +-
>  19 files changed, 140 insertions(+), 318 deletions(-)

Is it also possible to split this? First rename the existing functions
on our CStr to match upstream & then you don't need to do the rename &
removal of our CStr in the same patch?

---
Cheers,
Benno

