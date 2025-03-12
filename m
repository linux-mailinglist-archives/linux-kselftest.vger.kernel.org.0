Return-Path: <linux-kselftest+bounces-28815-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E4FA5DFBF
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 16:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA4831763F4
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 15:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309B92505D8;
	Wed, 12 Mar 2025 15:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="J3V/qstg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D4F2512E7;
	Wed, 12 Mar 2025 15:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792036; cv=none; b=JeYSDltoeW3DKHpgcxbKKjf7huRkezMyb+7HtLrp7IgtGWfNd9YmNgtx4dxduquPyUVbFEibjgY2zp20jMOYYRhYlai4BJLI1uCTmDx2N6vk148tnGuoxxuqr2ZakxVjpPvAy36rkyVrSZHDnVjm9Vdn1jMUROL6QONcr48g9Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792036; c=relaxed/simple;
	bh=np+WIadGU74rpJjwWWZpkyFqUUgRYo8QS1bZY8rt66Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HEageKps3sF3f9w4Szq3dZ5t4Hbx7EB9/OccAlxD8ToyMo1rpoqWmR8yFgDrNTPdXtwqxlX3W+f/DIwXndcYJW3ZrNd1Pmra1W8GvhXfIi6MYxB+13MIY6SFIX33y4JU7xzIBDM57u9HUGQ3BGqenjZIb1CE5RDmFAK/NVCEmf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=J3V/qstg; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741792026; x=1742051226;
	bh=np+WIadGU74rpJjwWWZpkyFqUUgRYo8QS1bZY8rt66Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=J3V/qstg7dXBTPPUV/CHvZLEUogJaMJszagAnoFuQE5zGlpT5QzwGWMM3x5c/APr3
	 2RWeU1TZX97KgxfBJDkZJAWF+6rGaCnCAwY9C0CqNR9khJhgLkgKdo/fRxH2GewwJR
	 qU1TpFaIcwEKrhaSyA7eVO4BpFFO57qmjX01UOwQ/tCPmV0a39W4YKbNGQAhDEU3Kt
	 8dPhFy9uX7hCWQS+Z7gLrHMU+9qd+uK3h+D3Z20EgmU2i9ObK5Ypr/p3/TSOfK4Aya
	 oYxqYNIB15ZxH30nwvUROver467jBFhvsL9t+RmhhI2HCig0nxqlc6j8XpPRG3uh7Q
	 mGD1khMVS20+A==
Date: Wed, 12 Mar 2025 15:07:01 +0000
To: Tamir Duberstein <tamird@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/5] rust: reduce pointer casts, enable related lints
Message-ID: <D8EDQLZPDO48.1FXHY80CWMXJ1@proton.me>
In-Reply-To: <20250309-ptr-as-ptr-v2-0-25d60ad922b7@gmail.com>
References: <20250309-ptr-as-ptr-v2-0-25d60ad922b7@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: c73bebe457e912f6fdcb06fff3fb73df91fb0eb0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Tamir,

On Sun Mar 9, 2025 at 5:00 PM CET, Tamir Duberstein wrote:
> This started with a patch that enabled `clippy::ptr_as_ptr`. Benno
> Lossin suggested I also look into `clippy::ptr_cast_constness` and I
> discovered `clippy::as_ptr_cast_mut`. This series now enables all 3
> lints. It also enables `clippy::as_underscore` which ensures other
> pointer casts weren't missed. The first commit reduces the need for
> pointer casts and is shared with another series[1].
>
> Link: https://lore.kernel.org/all/20250307-no-offset-v1-0-0c728f63b69c@gm=
ail.com/ [1]
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Thanks for this series! Did you encounter any instances of `$val as $ty`
where you couldn't convert them due to unsizing? I remember that we had
some cases back then (maybe Alice remembers them too?). If not then no
worries :)

---
Cheers,
Benno


