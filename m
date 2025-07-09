Return-Path: <linux-kselftest+bounces-36879-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4425AFF2DE
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 22:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAF0B3A9DB0
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 20:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4D8241673;
	Wed,  9 Jul 2025 20:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bChUWIyZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64737223338;
	Wed,  9 Jul 2025 20:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752092463; cv=none; b=BoCGo716k4o2CWPL76tGta50X/ljcUuEuDjOMo+zm+lJkEdEK/drjMLrrjUcpSTr8O2U2+ouJ3W5WKNXWgaoQ8PlRoGa0QaoB1emaacj5hNNoXwqT5xsV0DS9yn8KkWOLnc3bwpgaD1ZXJNcg1Q6aLVUQAwt+NRJl5pf6df5NXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752092463; c=relaxed/simple;
	bh=quTcM77+JwIDAwk/mszow6YJfzgDAsI1Ebx3aEw25ho=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=b5ANWgDUt8mCQ61AMcdasf7enVQC6qrlP3K45h/Aq1uKGgcX3faR9ROuWkYvFlB13AGIe0GeVAXkAl0M1RehjlNCyzK+KBHbzesH6bozKQSL/mSjl59qBF0w6mGO7dQxLmLKA7GfqsGFevVhN4UDf3IwFhq5IiG0HV94BF4i37Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bChUWIyZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E11FEC4CEEF;
	Wed,  9 Jul 2025 20:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752092462;
	bh=quTcM77+JwIDAwk/mszow6YJfzgDAsI1Ebx3aEw25ho=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=bChUWIyZAu8N9v9iqcGEu+8pPx7QPo/j7e1LSNTHfMCR1ybTS2EfBKpaX0Xe9qljU
	 jzJCfu4BGEGgzvoeS3AXrq/n6oCJwewWKx9LHwtZBbN3JfQ7Y/f3ECH+6b23epdgzw
	 /hT6TLrb8CWQjBayEVsq/8lTsN77CseuGy/SAYgycxdoKjD4iOhkBaDlsJBQffmyfb
	 T/b3pq0pL1wMggdFEYxPUB+VVWMYWsD8OXQ74ZYGCWq179+lyUCBycizDOTvaJvzFM
	 5gT7xA1RNXVyX0UQ54FTSnDQ3xci+jrqgG7USlBxP6VumKhnpFIEUypJ8FQqpJhk0m
	 VibIefCIzfJhQ==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 09 Jul 2025 22:20:54 +0200
Message-Id: <DB7SXTRZ1VKL.VONQAEWAV9TX@kernel.org>
Cc: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
 <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 00/10] rust: use `core::ffi::CStr` method names
From: "Benno Lossin" <lossin@kernel.org>
To: "Tamir Duberstein" <tamird@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Dave Ertman"
 <david.m.ertman@intel.com>, "Ira Weiny" <ira.weiny@intel.com>, "Leon
 Romanovsky" <leon@kernel.org>, "Breno Leitao" <leitao@debian.org>, "Rafael
 J. Wysocki" <rafael@kernel.org>, "Viresh Kumar" <viresh.kumar@linaro.org>,
 "Luis Chamberlain" <mcgrof@kernel.org>, "Russ Weight"
 <russ.weight@linux.dev>, "Brendan Higgins" <brendan.higgins@linux.dev>,
 "David Gow" <davidgow@google.com>, "Rae Moar" <rmoar@google.com>, "FUJITA
 Tomonori" <fujita.tomonori@gmail.com>, "Rob Herring" <robh@kernel.org>,
 "Saravana Kannan" <saravanak@google.com>
X-Mailer: aerc 0.20.1
References: <20250709-core-cstr-fanout-1-v1-0-fd793b3e58a2@gmail.com>
In-Reply-To: <20250709-core-cstr-fanout-1-v1-0-fd793b3e58a2@gmail.com>

On Wed Jul 9, 2025 at 9:58 PM CEST, Tamir Duberstein wrote:
> This is series 2b/5 of the migration to `core::ffi::CStr`[0].
> 20250704-core-cstr-prepare-v1-0-a91524037783@gmail.com.
>
> This series depends on the prior series[0] and is intended to go through
> the rust tree to reduce the number of release cycles required to
> complete the work.
>
> Subsystem maintainers: I would appreciate your `Acked-by`s so that this
> can be taken through Miguel's tree (where the other series must go).
>
> [0] https://lore.kernel.org/all/20250704-core-cstr-prepare-v1-0-a91524037=
783@gmail.com/
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
> Tamir Duberstein (10):
>       gpu: nova-core: use `core::ffi::CStr` method names
>       rust: auxiliary: use `core::ffi::CStr` method names
>       rust: configfs: use `core::ffi::CStr` method names
>       rust: cpufreq: use `core::ffi::CStr` method names
>       rust: drm: use `core::ffi::CStr` method names
>       rust: firmware: use `core::ffi::CStr` method names
>       rust: kunit: use `core::ffi::CStr` method names
>       rust: miscdevice: use `core::ffi::CStr` method names
>       rust: net: use `core::ffi::CStr` method names
>       rust: of: use `core::ffi::CStr` method names
>
>  drivers/gpu/drm/drm_panic_qr.rs | 2 +-
>  rust/kernel/auxiliary.rs        | 4 ++--
>  rust/kernel/configfs.rs         | 4 ++--
>  rust/kernel/cpufreq.rs          | 2 +-
>  rust/kernel/drm/device.rs       | 4 ++--
>  rust/kernel/firmware.rs         | 2 +-
>  rust/kernel/kunit.rs            | 6 +++---
>  rust/kernel/miscdevice.rs       | 2 +-
>  rust/kernel/net/phy.rs          | 2 +-
>  rust/kernel/of.rs               | 2 +-
>  samples/rust/rust_configfs.rs   | 2 +-
>  11 files changed, 16 insertions(+), 16 deletions(-)

For the entire series:

Reviewed-by: Benno Lossin <lossin@kernel.org>

Thanks a lot for splitting it up into these tiny pieces!

---
Cheers,
Benno

