Return-Path: <linux-kselftest+bounces-35567-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CAFAE2C98
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 23:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 409231899F7D
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 21:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E8F1E835C;
	Sat, 21 Jun 2025 21:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXNthaeC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310B5A55;
	Sat, 21 Jun 2025 21:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750540631; cv=none; b=XtMIU/Y0ITFfJwWn2pUMtCvZ8JBNoVcQyJmXm0stQMjTMRpQdTmRZF8MBOYgYo6pg2V2LpoUmsttUIlSGqOHSjyFR73BZP4TlR6gyHohnBTs5WIxJMGNTy5bt+BgkDwFQ6fhy9sh0IzHwthAhXg6Svfe5Ab7C3swT6r1eubcxYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750540631; c=relaxed/simple;
	bh=ZmTQYCTt6FpeXJobXvGHGrkckGX2zkqbJORyKVTdPZ8=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=f0pGZywPEGO40gIJ2AD131ms6UdOjCgyXuTyHqy5ilbL+NONPuSXSJ4qgVd6g6CBOCswYVUolBNOkVyh8zVZIEuup/jc81X+e9vhXjSBtmJDfS+3qt0LteR0Jm2p79PHnncVnoL3Iix7lRTUvgSoNsPiSjdvBmQmVAfQE2CdNDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXNthaeC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF4DC4CEE7;
	Sat, 21 Jun 2025 21:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750540629;
	bh=ZmTQYCTt6FpeXJobXvGHGrkckGX2zkqbJORyKVTdPZ8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=jXNthaeCkH8WUGPQKoQGzy2fRj9hCnJcYGtWtzRFpZuDba0pqwmDxhCwgGnIuzzA1
	 c15Dv1Qi1qtqqC8qI/P0vIS1/OMORDzmteZ9xIajZbOb/b+5eQf4BwOVVSeyNdjKxS
	 ZQbuAYfjkXAvA8vGsQv8FsSm836IvTGTPDcgPtpG9wWbVkydvEgPBbIfztmIfqq04a
	 cuLZHgVHmgyr6xjFb2llW7fp0PUsgdNuLJyMGQ2d5sUFi/quLKPFi9sLlUxSpZ9HKX
	 37ejW0Od87/cdirzu4bxTNYVO8OYMRQPxn0lO8rADA8ffHYpkG9U26Vs8ZgebFBEdL
	 y8fF7nT/yAwww==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250619-cstr-core-v12-4-80c9c7b45900@gmail.com>
References: <20250619-cstr-core-v12-0-80c9c7b45900@gmail.com> <20250619-cstr-core-v12-4-80c9c7b45900@gmail.com>
Subject: Re: [PATCH v12 4/5] rust: replace `kernel::c_str!` with C-Strings
From: Stephen Boyd <sboyd@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, llvm@lists.linux.dev, linux-pci@vger.kernel.org, nouveau@lists.freedesktop.org, linux-block@vger.kernel.org, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>
To: Alex Gaynor <alex.gaynor@gmail.com>, Alice Ryhl <aliceryhl@google.com>, Andreas Hindborg <a.hindborg@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>, Benno Lossin <lossin@kernel.org>, Bill Wendling <morbo@google.com>, Bjorn Helgaas <bhelgaas@google.com>, =?utf-8?q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>, Boqun Feng <boqun.feng@gmail.com>, Brendan Higgins <brendan.higgins@linux.dev>, Breno Leitao <leitao@debian.org>, Danilo Krummrich <dakr@kernel.org>, Dave Ertman <david.m.ertman@intel.com>, David Airlie <airlied@gmail.com>, David Gow <davidgow@google.com>, David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, Gary Guo <gary@garyguo.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Heiner Kallweit <hkallweit1@gmail.com>, Ingo Molnar <mingo@redhat.com>, Ira Weiny <ira.weiny@intel.com>, Jakub Kicinski <kuba@kernel.org>, Jens Axboe <axboe@kernel.dk>, Justin Stitt <justinstitt@goo
 gle.com>, Krzysztof =?utf-8?q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Leon Romanovsky <leon@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Michal Rostecki <vadorovsky@protonmail.com>, Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Rae Moar <rmoar@google.com>, Rafael J. Wysocki <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Russ Weight <russ.weight@linux.dev>, Russell King <linux@armlinux.org.uk>, Saravana Kannan <saravanak@google.com>, Simona Vetter <simona@ffwll.ch>, Tamir Duberstein <tamird@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>, Trevor Gross <tmgross@umich.edu>, Viresh Kumar <viresh.kumar@linaro.org>, Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Date: Sat, 21 Jun 2025 14:17:08 -0700
Message-ID: <175054062889.4372.13449788582456522444@lazor>
User-Agent: alot/0.11

Quoting Tamir Duberstein (2025-06-19 08:06:28)
> C-String literals were added in Rust 1.77. Replace instances of
> `kernel::c_str!` with C-String literals where possible and rename
> `kernel::c_str!` to `str_to_cstr!` to clarify its intended use.
>=20
> Closes: https://github.com/Rust-for-Linux/linux/issues/1075
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---

For clk part

>  rust/kernel/clk.rs                    |  6 ++----

Acked-by: Stephen Boyd <sboyd@kernel.org> # clk

