Return-Path: <linux-kselftest+bounces-33802-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DCBAC41EA
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 16:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5CB87AAE26
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 14:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623CE20E330;
	Mon, 26 May 2025 14:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2u6SKz5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205DB28373;
	Mon, 26 May 2025 14:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748271404; cv=none; b=F0M46PCbyWZH1EVTpPXuGmv8OyoiQoD46GWkYpjKgiQPq7FQomI290PvoNWWZg6qcv3z/DJDeSb8Eazzj66iJq9ZxPZ/o1Sq+Zr5Of7wUBt9cW/L7Z5tA6qIMrIoIiCgzssuhWhEvwhyq/rw6p7jS/GrOaRYvmaaHF9RSVzRXac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748271404; c=relaxed/simple;
	bh=FquHezFUc7DH27pfpWI+rH+kmjgYOsLlioRhkjrQCPs=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=eZ+rDGAlPyYpAGcFbCGh/kzVQz7MkJ5SfFpf6pXMJOOrIf3c0+wPd3IeyykE3yxmvr/5hFKRXRcUKws7x4Fdmrtk3JAYyILz6QHLfX7+WEBOZ+02+jS5BnPsQPDk3SATvednedYM2vwG0dBil2RoePhOS48hcInoHnhWMkjFDAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2u6SKz5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51704C4CEE9;
	Mon, 26 May 2025 14:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748271403;
	bh=FquHezFUc7DH27pfpWI+rH+kmjgYOsLlioRhkjrQCPs=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=I2u6SKz5k5kaCxDX4uSlRUIJZbwixl2yhSR3XLFBE1J++2X4FAsCXkSjofc1VlCY7
	 VBLN0Cl5HvPpWt6CG9iBzCDfaCicBR3fVmTroqdFJGSpPQFkB4XK860J2Jn/XKO6a4
	 OatOQ6AjrmPficieHssNFE4Oo3mKqgwHkX7Yr/177vz7FGGPCvChV1QslpsSyp8HtW
	 vpT2b5LtdSsWlRdKEPvRqeCaaZLo6wUiyh/IJP1vRFyoZwcfP+/nA1wx3usYofjEez
	 fzu1dW2zgTZTJFsZ/IOYU5QtABXcSKFywKh2XyLJ6wExrlEe3sQIbfsVMMixELYon/
	 Z0ruliGT49S9g==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 May 2025 16:56:31 +0200
Message-Id: <DA66HHUA8ANF.BI2FH7POFSRJ@kernel.org>
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
 <kwilczynski@kernel.org>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
 <dri-devel@lists.freedesktop.org>, <netdev@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <llvm@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <nouveau@lists.freedesktop.org>,
 <linux-block@vger.kernel.org>
Subject: Re: [PATCH v10 3/5] rust: replace `CStr` with `core::ffi::CStr`
From: "Benno Lossin" <lossin@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250524-cstr-core-v10-0-6412a94d9d75@gmail.com>
 <20250524-cstr-core-v10-3-6412a94d9d75@gmail.com>
In-Reply-To: <20250524-cstr-core-v10-3-6412a94d9d75@gmail.com>

On Sat May 24, 2025 at 10:33 PM CEST, Tamir Duberstein wrote:
> `std::ffi::CStr` was moved to `core::ffi::CStr` in Rust 1.64. Replace
> `kernel::str::CStr` with `core::ffi::CStr` now that we can.

What's this supposed to mean?

> C-String literals were added in Rust 1.77. Opportunistically replace
> instances of `kernel::c_str!` with C-String literals where other code
> changes were already necessary; the rest will be done in a later commit.

Similarly this, the message should explain the motivation for the
change, the change itself and can include additional information.

>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  drivers/gpu/drm/drm_panic_qr.rs |   2 +-
>  rust/kernel/device.rs           |   4 +-
>  rust/kernel/error.rs            |   4 +-
>  rust/kernel/firmware.rs         |  11 +-
>  rust/kernel/kunit.rs            |   6 +-
>  rust/kernel/miscdevice.rs       |   2 +-
>  rust/kernel/net/phy.rs          |   2 +-
>  rust/kernel/of.rs               |   2 +-
>  rust/kernel/prelude.rs          |   5 +-
>  rust/kernel/seq_file.rs         |   4 +-
>  rust/kernel/str.rs              | 358 +++++++++-------------------------=
------
>  rust/kernel/sync/condvar.rs     |   2 +-
>  rust/kernel/sync/lock.rs        |   2 +-
>  rust/kernel/sync/lock/global.rs |   2 +-
>  14 files changed, 112 insertions(+), 294 deletions(-)

I'm a bit confused by some of the diffs here, they seem pretty messy,
any chance that they can be improved?

---
Cheers,
Benno

