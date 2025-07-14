Return-Path: <linux-kselftest+bounces-37234-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1074FB03D06
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 13:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 558171898074
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 11:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E66246335;
	Mon, 14 Jul 2025 11:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P75fHWWY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B32023A6;
	Mon, 14 Jul 2025 11:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752491600; cv=none; b=AUo8I00PDXH01HC3/u26zroi4xabGLTf6W3WDHGr99KJcwOiexav9GCOdqDHijtuswJgU+w2Oe/00M5i81SaXgo/S2Oa880kQKyJxe2FNPAWYfL3tV2g67TQQMX+HuMhrz5QrZYzpVjgR6jneuJ9Oq/XPNt67cvOEmDtlj+QLHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752491600; c=relaxed/simple;
	bh=erXsUtawprD4isU/yr+4FpL23DS53LPqT5KOgC9aMBI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=WpBLCy9jZ34RDbtnj9Ior9ZN3Q/n/zM5kBEs4crDGvGrKyOUbwhDOuqyKHhpUtRUtiK4bOF9VtIOf4TjObyJw4i6ek2b837OPC/d0jNLM5VtlSSEybM0I2FFUCLUyKmY8rIxiel/+pCtbpxhQ6rJz72Gw92KSALbzIHPkkHWehU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P75fHWWY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A55DC4CEED;
	Mon, 14 Jul 2025 11:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752491600;
	bh=erXsUtawprD4isU/yr+4FpL23DS53LPqT5KOgC9aMBI=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=P75fHWWYABMV3U8XfDElCZaNAwkTMXz0CUXsj+tGp2w0xg3NBv5EotE+dHh/Fy9tc
	 36zFXLoeEWhNWMAhGC9MDsuxbT64Iptyy18gOFP90vni0AOUBbD9CwR/3Qe+R+xrEM
	 LvokLjInAYml/9bR1oriH/cpDD6D2HY5RsAOuOu/qshHZaiiylpYysGHIwHIQ/ure9
	 V3i1tQmfAbBvnEMQlilJhFVcX6md+PHxg7Wn3GHsOBOOLMrlYRKizP4e2MGqCIDNOm
	 aIcqzlLjqgHNbOuCZlBi2BPusV6o53fRX5aF510pSFMmd/6aiHF8Ti/odViDgx5zmA
	 180DDCBfB6lRw==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Jul 2025 13:13:09 +0200
Message-Id: <DBBQF605AHON.3OS1TIRYKWQ5L@kernel.org>
Subject: Re: [PATCH 00/10] rust: use `core::ffi::CStr` method names
Cc: "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Dave Ertman"
 <david.m.ertman@intel.com>, "Ira Weiny" <ira.weiny@intel.com>, "Leon
 Romanovsky" <leon@kernel.org>, "Breno Leitao" <leitao@debian.org>, "Rafael
 J. Wysocki" <rafael@kernel.org>, "Viresh Kumar" <viresh.kumar@linaro.org>,
 "Luis Chamberlain" <mcgrof@kernel.org>, "Russ Weight"
 <russ.weight@linux.dev>, "Brendan Higgins" <brendan.higgins@linux.dev>,
 "David Gow" <davidgow@google.com>, "Rae Moar" <rmoar@google.com>, "FUJITA
 Tomonori" <fujita.tomonori@gmail.com>, "Rob Herring" <robh@kernel.org>,
 "Saravana Kannan" <saravanak@google.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
 <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>
To: "Tamir Duberstein" <tamird@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250709-core-cstr-fanout-1-v1-0-fd793b3e58a2@gmail.com>
In-Reply-To: <20250709-core-cstr-fanout-1-v1-0-fd793b3e58a2@gmail.com>

On Wed Jul 9, 2025 at 9:58 PM CEST, Tamir Duberstein wrote:
> This is series 2b/5 of the migration to `core::ffi::CStr`[0].
> 20250704-core-cstr-prepare-v1-0-a91524037783@gmail.com.

For auxiliary, firmware and drm,

	Acked-by: Danilo Krummrich <dakr@kernel.org>

