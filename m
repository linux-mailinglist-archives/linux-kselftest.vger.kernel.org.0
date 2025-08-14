Return-Path: <linux-kselftest+bounces-38946-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F5DB25E78
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 10:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 470151BC5CEB
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 08:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8612E7183;
	Thu, 14 Aug 2025 08:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLbJ0NC1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F3827587D;
	Thu, 14 Aug 2025 08:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755159040; cv=none; b=jJStjg3CQoB6VRd5bYjK8QCOTCqxyRaKUasbvLD8GrHPoRjfzrmQdKfwZpJ7D8B0RCZXTd1t1P3VnXmU6NXv1M4JKBN5cYs237/WHEGYAKsoNRysPYCJS8XmfybdDyECY6JBL9v9sGUUSTQ1ogSCcjft8Q960WDoFDTW4OUYpPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755159040; c=relaxed/simple;
	bh=8PGdpqI11ac8Y8fSWkUX0aKnppBjPfTLxK1xdjlz6cE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=PtEhGhFRSOTxnEqm7Iw+VTGJAl/s2l//MyjB190sPlDAMHS3ZvQdETwlYsCdXKPua1bPmE1RTTOGtRFQaDUXjXMIxslxEgL5z79wF+3QR70LNp6f21x80Mn1umGoKqbWT0Gx5qW/G1HalFm7cr1FO7jY4ZPM0didQIlUC3S2O10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLbJ0NC1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2747C4CEF4;
	Thu, 14 Aug 2025 08:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755159040;
	bh=8PGdpqI11ac8Y8fSWkUX0aKnppBjPfTLxK1xdjlz6cE=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=DLbJ0NC153asI54kpXF/bKi1f5qTjJYsdUrlcRx7KzPAUp3hOB3VlFXB2QW7nMuiK
	 tNAuNlLZzXMh5kyDx4qeuZA+eFTi9ZHbFPq7QZ4nIOLtndciGqwzCJN/rXowebYeng
	 h7yTuboG83nXDd+Buqo5VVartYvky3YZ+6YMqRrsaYBUGjjRudUE6LutBc93y9fZAG
	 VflSSnl1UZlFjNfQWsNH8ltDGKwlrLSo3XQeaAvYbjQMoaq9r9jWSxc41YktvdTf8C
	 qqZ3E+bbhcSlbLc0C0YRYrSk15I0J2lvCVoRPuhIQwY1gjU0+JBx5AVe9d72U5QYeA
	 FRGRzpivjT7zg==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 14 Aug 2025 10:10:31 +0200
Message-Id: <DC1ZY7PYGCK6.2LDYPXE3XSUMK@kernel.org>
Cc: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
 <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v3 11/11] rust: acpi: use `core::ffi::CStr` method names
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
 "Saravana Kannan" <saravanak@google.com>, "Jocelyn Falempe"
 <jfalempe@redhat.com>, "Javier Martinez Canillas" <javierm@redhat.com>,
 "Arnd Bergmann" <arnd@arndb.de>, "Len Brown" <lenb@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250813-core-cstr-fanout-1-v3-0-545c14bc44ff@gmail.com>
 <20250813-core-cstr-fanout-1-v3-11-545c14bc44ff@gmail.com>
In-Reply-To: <20250813-core-cstr-fanout-1-v3-11-545c14bc44ff@gmail.com>

On Wed Aug 13, 2025 at 5:42 PM CEST, Tamir Duberstein wrote:
> Prepare for `core::ffi::CStr` taking the place of `kernel::str::CStr` by
> avoid methods that only exist on the latter.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Benno Lossin <lossin@kernel.org>

---
Cheers,
Benno

> ---
>  rust/kernel/acpi.rs | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

