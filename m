Return-Path: <linux-kselftest+bounces-36560-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE823AF938E
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 15:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0B401671DC
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 13:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80CB2F85D1;
	Fri,  4 Jul 2025 13:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTZQCGwh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B3D2F50B0;
	Fri,  4 Jul 2025 13:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751634099; cv=none; b=eaIvkhRVA6PAJJOGJnZApRdCxDy1nTl90Kob8hxCXJBoFAG1jhXVh1sSu3mpwyC81r8exZyxEi1I2vUBoThqZIcfTI7e2Tvij1NnHWXs6JagY+NxCgweWH0hoIKidNsm0jy58fO1/uvszHTJAnWkDSdQEVnISAKbM9TDkvk7IUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751634099; c=relaxed/simple;
	bh=1SFIg86ScSSNsm00r4z39bxOC+QdfD7ofZFsNo39Gyw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=QuDmR68sXHJu1VdwvmOy/8TKkuR13xrJO6c5cZ2Dm/63RUAXWFJo+uSeEfuIuoyWIfr+OSEYH50qX3xum/A/sAZZ72tqBtllDepreXqcg7TkhEkoSAQX7YcMVMYNoQfVX3DGY/+ZHLIamqaMI/wFSizpV1u5LYGB1BhBXd1C95s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTZQCGwh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA72C4CEE3;
	Fri,  4 Jul 2025 13:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751634099;
	bh=1SFIg86ScSSNsm00r4z39bxOC+QdfD7ofZFsNo39Gyw=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=VTZQCGwhAN+TexmrabJGl6LSW4Xumo1b3iyodJcqKKb2S+NtuyH0wgV0XP9jPivaQ
	 QuIqn8AtkfhK0+gKQ1ejE0AWPSMFd9C0sa8nLfuIly2BzdyUP8Px0ho4oMaC2LnN3l
	 4lB1zV53g1wSLGMaKO1dWQLG5r1vqzj/k5z4JY4BdlXr5S/IsxRkvkdm+tgkf2VgOx
	 fZqh+B/8T9b4HB0rnSrjSrFm90CAihtJ2cuZ6KUhRJXNxo5H/Hqv9zo/6d3q3R8XPw
	 gK1OTk3fERiW0Prtx9CO8/vhuUS5bARcvhok3yE2TSbAXA89qvtD+iuArw73v2kZOz
	 bKOGfZaX9sCWQ==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 04 Jul 2025 15:01:23 +0200
Message-Id: <DB3AGL1QO4M4.2HANWHX9TF9WN@kernel.org>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
 <dri-devel@lists.freedesktop.org>, <netdev@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <llvm@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <nouveau@lists.freedesktop.org>,
 <linux-block@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v13 4/5] rust: replace `kernel::c_str!` with C-Strings
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
X-Mailer: aerc 0.20.1
References: <20250701-cstr-core-v13-0-29f7d3eb97a6@gmail.com>
 <20250701-cstr-core-v13-4-29f7d3eb97a6@gmail.com>
In-Reply-To: <20250701-cstr-core-v13-4-29f7d3eb97a6@gmail.com>

On Tue Jul 1, 2025 at 6:49 PM CEST, Tamir Duberstein wrote:
> C-String literals were added in Rust 1.77. Replace instances of
> `kernel::c_str!` with C-String literals where possible and rename
> `kernel::c_str!` to `str_to_cstr!` to clarify its intended use.

These two things can also be split? And it should also be possible to do
this by-subsystem, right?

---
Cheers,
Benno

> Closes: https://github.com/Rust-for-Linux/linux/issues/1075
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  drivers/block/rnull.rs                |  2 +-
>  drivers/cpufreq/rcpufreq_dt.rs        |  5 ++---
>  drivers/gpu/drm/nova/driver.rs        | 10 +++++-----
>  drivers/gpu/nova-core/driver.rs       |  6 +++---
>  drivers/net/phy/ax88796b_rust.rs      |  7 +++----
>  drivers/net/phy/qt2025.rs             |  5 ++---
>  rust/kernel/clk.rs                    |  6 ++----
>  rust/kernel/configfs.rs               |  9 +++++----
>  rust/kernel/cpufreq.rs                |  3 +--
>  rust/kernel/devres.rs                 |  2 +-
>  rust/kernel/drm/ioctl.rs              |  2 +-
>  rust/kernel/firmware.rs               |  6 +++---
>  rust/kernel/kunit.rs                  | 14 ++++++--------
>  rust/kernel/net/phy.rs                |  6 ++----
>  rust/kernel/platform.rs               |  4 ++--
>  rust/kernel/str.rs                    | 24 ++++++++++++++++--------
>  rust/kernel/sync.rs                   |  7 +++----
>  rust/kernel/sync/completion.rs        |  2 +-
>  rust/kernel/sync/lock/global.rs       |  3 ++-
>  rust/kernel/workqueue.rs              |  8 ++++----
>  rust/macros/kunit.rs                  | 10 +++++-----
>  rust/macros/module.rs                 |  2 +-
>  samples/rust/rust_configfs.rs         |  5 ++---
>  samples/rust/rust_driver_auxiliary.rs |  4 ++--
>  samples/rust/rust_driver_faux.rs      |  4 ++--
>  samples/rust/rust_driver_pci.rs       |  4 ++--
>  samples/rust/rust_driver_platform.rs  |  4 ++--
>  samples/rust/rust_misc_device.rs      |  3 +--
>  scripts/rustdoc_test_gen.rs           |  4 ++--
>  29 files changed, 84 insertions(+), 87 deletions(-)

