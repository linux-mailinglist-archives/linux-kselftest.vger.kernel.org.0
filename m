Return-Path: <linux-kselftest+bounces-37233-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 898F0B03CFC
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 13:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A674217E42A
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 11:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1690F246763;
	Mon, 14 Jul 2025 11:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCUgbVuw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D214D1FECB4;
	Mon, 14 Jul 2025 11:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752491515; cv=none; b=OYu0CdqMNQaEW+/wStdkQK+e7Qi0fyzBp1RzblUVjzkfSBmtft5bsTxcyEkIV2T357aeecSZY+nk5eZkZl0xpN5VbMR1epgm7z4yA8y0qP/i+ohxVO1F18hpvtUJM2mbsmf89sUkJVoVA8N7z/eHLmb+CGj2epRFkVk0OETkwFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752491515; c=relaxed/simple;
	bh=LrX0RGuZdher2wedibFNe23KtTBoU4hFNhSrfZry7Z4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=LIrPrbMMzSlfGR6gaeB3y1iVO/nPLNVZ3RZno5ORnpl30Q3loLpkh7S1ydXzO0xM1vcMZS4M6O+sGUa/gd8/A35hBZWm7Nngixtf/wF+V/J+Ap2u6z90UNMKBslQOsWDdZbz/wR2k6FNvn2I3OrdiBCu4Dm8ZfRxYZGOynQqe3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCUgbVuw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96EF4C4CEED;
	Mon, 14 Jul 2025 11:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752491514;
	bh=LrX0RGuZdher2wedibFNe23KtTBoU4hFNhSrfZry7Z4=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=gCUgbVuwCBrCSO4Mvgufqg+JpYNjqKPjojpWwPo1arW27+Jg9nGXgu6P+7VTj9QPI
	 6bnAZTw/FrAzII7XqkEOFdZ50MvW2xtqcE03w2JNnNqQ9qAgCKJTwAbU3/T8I+02oY
	 7dFhsh4iDA3DUvFzimMeKU73jHfcPheoWlGZ7+w+0OdXvXEAjJdOOUEtGp1wxiPQuz
	 O4Mdi3PSbaM+Q1bhNRkHWrG3NYSzmW2b6M8M52ZYCCJ1oUfjj87HnhG4OQC85jRFXw
	 v0fMh/csvBThGIlzhxj8krg0NCShqECGro1wDLJvgmR9cOGXKDTgJ2eyz2rTCTkBZy
	 NsrDVuXgyCawA==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Jul 2025 13:11:45 +0200
Message-Id: <DBBQE3GJ0CHT.5PEF7RLS6C33@kernel.org>
Subject: Re: [PATCH 01/10] gpu: nova-core: use `core::ffi::CStr` method
 names
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
 <20250709-core-cstr-fanout-1-v1-1-fd793b3e58a2@gmail.com>
In-Reply-To: <20250709-core-cstr-fanout-1-v1-1-fd793b3e58a2@gmail.com>

On Wed Jul 9, 2025 at 9:58 PM CEST, Tamir Duberstein wrote:
> Prepare for `core::ffi::CStr` taking the place of `kernel::str::CStr` by
> avoid methods that only exist on the latter.
>
> Link: https://github.com/Rust-for-Linux/linux/issues/1075
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  drivers/gpu/drm/drm_panic_qr.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This doesn't look like nova-core. :)

