Return-Path: <linux-kselftest+bounces-37237-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF95B03D32
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 13:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E01F91746BF
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 11:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1365724503E;
	Mon, 14 Jul 2025 11:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1sKVGCQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C751917C77;
	Mon, 14 Jul 2025 11:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752492027; cv=none; b=HNSr3IlE4WzFW0QuNWA5wNo3otfAMXyBfMWcLVHRVDEB4rm3IZFszS4KQjtJ8v3hpz0wNPEM5WG/xSTsFuj0YWAwnbfXvgAfDFmF2pxOfzVL8+Mgn877cgne2mtSXrqQIMcChoX8zrfllWLm6zGAJ2igSLCyEYb4IVr58MDF0D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752492027; c=relaxed/simple;
	bh=yyO1ARgaD0chxUdPV6nq/lVx78EqnrQvO7cKx+N0Xcc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=RWBdJ3c0apcy/pDOaM4TLE+2AwOZyZcOs5XRbAt8d8PzoQy1OZENvOnXg6XWLrlCVFRbgbC03pTs9E2XYoZr8yN1LSmtgv5LOTjitVo9SCxnVX272xFICzBos8iou1EG0QmWeb8Az97JXTVBKp56Kl377nnS5N46bOh0hi8uNfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1sKVGCQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F374C4CEF7;
	Mon, 14 Jul 2025 11:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752492026;
	bh=yyO1ARgaD0chxUdPV6nq/lVx78EqnrQvO7cKx+N0Xcc=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=T1sKVGCQiQdvyl/cIrNjaFkfKdIghzZjDABgUQVkPoZcEydnAmLGISsDlkF2nzUe0
	 FnfuetExCJGdIdp3EpKqzxsGcY2zumfZ2wk57u8+1F/va1VYZAvTuldCeeRkxL4PH6
	 ZTgQ8IzqNfHDLE/8p0Ilbp8QJWdrQ7OtdNeQC8sHgkxBlGYGYYGEiDqRVyIKBRiDFK
	 7r1kchDXiXNFLIRBm7ZOZvlk4hx6ko6J0Xv4pBheLJQQ0kpyrV2aMO879FM4SNZfjs
	 Qen023IiMr+Rpai/MMpXQeFmy8dQnnVBckFzyKZ7vk2+tauOCAapDlMiNEWZRKkiPU
	 W7z9Dhgu5R0YA==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Jul 2025 13:20:14 +0200
Message-Id: <DBBQKL12V4V0.W2CW7276D7WE@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Viresh Kumar"
 <viresh.kumar@linaro.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "FUJITA Tomonori"
 <fujita.tomonori@gmail.com>, "Andrew Lunn" <andrew@lunn.ch>, "Heiner
 Kallweit" <hkallweit1@gmail.com>, "Russell King" <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, "Eric Dumazet"
 <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>, "Michael Turquette" <mturquette@baylibre.com>,
 "Stephen Boyd" <sboyd@kernel.org>, "Breno Leitao" <leitao@debian.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Luis Chamberlain"
 <mcgrof@kernel.org>, "Russ Weight" <russ.weight@linux.dev>, "Dave Ertman"
 <david.m.ertman@intel.com>, "Ira Weiny" <ira.weiny@intel.com>, "Leon
 Romanovsky" <leon@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Arnd
 Bergmann" <arnd@arndb.de>, "Brendan Higgins" <brendan.higgins@linux.dev>,
 "David Gow" <davidgow@google.com>, "Rae Moar" <rmoar@google.com>, "Jens
 Axboe" <axboe@kernel.dk>, <linux-pm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <netdev@vger.kernel.org>, <linux-clk@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <kunit-dev@googlegroups.com>, <linux-block@vger.kernel.org>
To: "Tamir Duberstein" <tamird@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 00/17] rust: replace `kernel::c_str!` with C-Strings
References: <20250710-core-cstr-cstrings-v1-0-027420ea799e@gmail.com>
In-Reply-To: <20250710-core-cstr-cstrings-v1-0-027420ea799e@gmail.com>

On Thu Jul 10, 2025 at 5:31 PM CEST, Tamir Duberstein wrote:
> This series depends on step 3[0] which depends on steps 2a[1] and 2b[2]
> which both depend on step 1[3].

For nova-core, auxiliary, device, firmware, PCI and platform,

	Acked-by: Danilo Krummrich <dakr@kernel.org>

(Note that there is quite some new stuff queued up in various trees that wi=
ll
need those changes as well.)

