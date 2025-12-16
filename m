Return-Path: <linux-kselftest+bounces-47602-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DFDCC43A5
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Dec 2025 17:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D99A3084DBF
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Dec 2025 16:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A321231355F;
	Tue, 16 Dec 2025 12:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtS5MFfR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774CD26E6F9;
	Tue, 16 Dec 2025 12:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765889344; cv=none; b=XG6aOak/2LBlQ1e4sMJfW8E6WFreoGN/qjvHg7qGqc4Xl0pw46TaSbqS4LP9z2lLHEaPavccKupmpnNi0PuOXVJb8HaxEqzvIA/mmw2hAXO/4+ghppxrata9SztrKwZDvMzPlfinlUKKVrqIeMvqrzhHi+xjVGTORTcockQr7VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765889344; c=relaxed/simple;
	bh=WgHbCJVC+hTPJT+eNfHvL9qKZ/IzwVRLqtU2q3fAe6Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=TUk7ohmC1/jZQQtXCgwHC4C6YXsU88g2Dj4utXl6zrGaI3iq0mCebCQrPn7A2aNCfZAiMq3T0QjOC89FdG45FtDtSi9vtp/tQD9KTmJqFBrNGMBSdYQiXRS0Ednnwwts2DvTQ0chGJO7Wb3aT9eaFPiQpVEdbibulSuXGmc+xIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WtS5MFfR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA50C4CEF1;
	Tue, 16 Dec 2025 12:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765889344;
	bh=WgHbCJVC+hTPJT+eNfHvL9qKZ/IzwVRLqtU2q3fAe6Y=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=WtS5MFfRHWxKqReDqJBVUtFemQ5ucli7HfsuxrLjwooekJ+OdqhOHtu97lNe8fSkk
	 nsFr96Ha7rZaQfmxXz1yPUlIkMtCheEeqmDNcMoa3tKVTbd6DS6L4nnZm2D2FNR3r2
	 cCaKun1M5KiMVNifn0Bh7tNr19IH8E6l4hOnVVZTCdxIafdpTHrxLtYXP4sYGDtUit
	 sEkqzruCIQeHRgedlCdrJvqouaBQ1v6i6Oe1wj/aUQv0pyVhRKNppY5PTTi/tHkbY6
	 kVrjXjdHorBrIU4SikvK2NNFyui5gxeKkv3yujROewzWiDDzSa60eqGUoPPR+KGgrK
	 4PhBuokS8yrJg==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Dec 2025 13:48:59 +0100
Message-Id: <DEZNIZ8XBGU8.2DQIT65L11ZBF@kernel.org>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <kunit-dev@googlegroups.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 11/11] rust: kunit: use `pin_init::zeroed` instead of
 custom null value
From: "Benno Lossin" <lossin@kernel.org>
To: "Gary Guo" <gary@garyguo.net>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun.feng@gmail.com>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Brendan Higgins"
 <brendan.higgins@linux.dev>, "David Gow" <davidgow@google.com>, "Rae Moar"
 <raemoar63@gmail.com>
X-Mailer: aerc 0.21.0
References: <20251211185805.2835633-1-gary@kernel.org>
 <20251211185805.2835633-12-gary@kernel.org>
In-Reply-To: <20251211185805.2835633-12-gary@kernel.org>

On Thu Dec 11, 2025 at 7:56 PM CET, Gary Guo wrote:
> From: Gary Guo <gary@garyguo.net>
>
> The last null element can be created (constly) using `pin_init::zeroed`,
> so prefer to use it instead of adding a custom way of building it.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Benno Lossin <lossin@kernel.org>

Cheers,
Benno

> ---
>  rust/kernel/kunit.rs | 26 +-------------------------
>  rust/macros/kunit.rs |  4 ++--
>  2 files changed, 3 insertions(+), 27 deletions(-)

