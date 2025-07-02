Return-Path: <linux-kselftest+bounces-36357-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAACAF61C7
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 20:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF994176D9B
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 18:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB621E492D;
	Wed,  2 Jul 2025 18:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtTnCluC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BCD2F7D07;
	Wed,  2 Jul 2025 18:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751482052; cv=none; b=E78aSVv7X4GuiZEtbWln0Y637ofBaXq9pK9cQ7owPRiPWyGjwx66FVDZj7dMIG3186YM75VE33ktbngzAL23Q+nC5bKMT1a5GJJf80mWIfsEeGlPfuaNhDBtxzi+5BRxDWN2Jh3mVRNV0NaE+fZKPg4JhhpH+Dcny50D5rT5sp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751482052; c=relaxed/simple;
	bh=urZtsqWwOJhSQf6BJio6DtJ58Ptki5mkWpBNQK5au1g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=I+d6KESvvQN0s3+k1tT8bm2HZIheWkoO0f6KH06qIhuraTs2xpMcz+B+3ldE/XkP3aQLKel2+Mzt8kcB39vQyEC1efEXcmrTHHP63gv3fV25KApdI8f4VLFwOami9mUZy3julNy0daA7a3QVjyHe+LrJmIB1D3nGT6FPRLtbxFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtTnCluC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01742C4CEE7;
	Wed,  2 Jul 2025 18:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751482051;
	bh=urZtsqWwOJhSQf6BJio6DtJ58Ptki5mkWpBNQK5au1g=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=NtTnCluCW6K3OmHZvzLAR9+57BQhXtTHx/AVdwGAUf2iuo1Aerne5Kdbd15ViaIu6
	 8FpzUqcwykIQEg687Hubs/pyPP++v9SWXn3TIHy9dMa1sPMzvQegm1Nr9z87QUky+W
	 3ny0Ica0XI+4/XEyeEgik6IUkHoJIYUVQxeqXqR/cgsfKZbnAWMySc6MSUQBO6Gb/Z
	 tx0NkXSY9HtmIec3CZEZgIpbVmGMeYA2B/UEycJLjehmsP7v6RuOw7MREBDQFakeff
	 AGWgzgikNi/c6VYojooPLjQ4N0PNBGFQ6QeToVBYR53NoAHT4qt3b/bpa1DdJdNzWi
	 5ALCrQ/0Af5ig==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 02 Jul 2025 20:47:25 +0200
Message-Id: <DB1SKFOR9W3I.1MBT3C6FGBWH7@kernel.org>
Cc: <airlied@gmail.com>, <simona@ffwll.ch>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <rafael@kernel.org>,
 <viresh.kumar@linaro.org>, <gregkh@linuxfoundation.org>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <davidgow@google.com>, <nm@ti.com>
Subject: Re: [PATCH v4 2/6] rust: switch to `#[expect(...)]` in init and
 kunit
From: "Benno Lossin" <lossin@kernel.org>
To: =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <kunit-dev@googlegroups.com>
X-Mailer: aerc 0.20.1
References: <20250701053557.20859-1-work@onurozkan.dev>
 <20250701053557.20859-3-work@onurozkan.dev>
In-Reply-To: <20250701053557.20859-3-work@onurozkan.dev>

	=20
On Tue Jul 1, 2025 at 7:35 AM CEST, Onur =C3=96zkan wrote:
> This makes it clear that the warning is expected not just
> ignored, so we don't end up having various unnecessary
> linting rules in the codebase.
>
> Some parts of the codebase already use this approach, this
> patch just applies it more broadly.
>
> No functional changes.
>
> Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>
> ---
>  rust/kernel/init.rs  | 6 +++---
>  rust/kernel/kunit.rs | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)

@Miguel are you going to pick this eventually, or do you think it should=20
have a new version with the right splitting?=09

---
Cheers,
Benno





