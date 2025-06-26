Return-Path: <linux-kselftest+bounces-35848-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0585AE9ACD
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 12:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CA2A3B4409
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 10:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2DA21ABA4;
	Thu, 26 Jun 2025 10:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="kz/m0gKr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [178.154.239.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B582821A436;
	Thu, 26 Jun 2025 10:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750932359; cv=none; b=aSx6ng8RvdlROdS9/7J6v7swn8WIgTlPm2lTCIbqpdg1a/5LmKp3WCmSlviJFlpBtd9kFoVr8qt69nigDMjFOgBiVjgKO8ZI5Mrzz3iSC44btPy7hhSC7MYSpdcOf/dquglh2FUUo8Lw3287m2KWvCuo06EbvlSyw62w0fmVOBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750932359; c=relaxed/simple;
	bh=V6YTCqv8OIOxtQZzDkzntC0e9vI7/sizjp0ssSxqBHU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m2sstFymibEY4uNRf1cuZeR5bxbV9Y4QkKCHPGeo0TIdS1FMkA+8eJx6ox0eD8aDCxZUtHPPl0d+MDY0YfaJmRI8rxpHi4xR2MqxPSGBUTlLpqilbiqh24QtUZtbyDGk25v1rpTZopP4b8HJ0nHT1iYfkDL1kBuuPwV9/HsvRbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=kz/m0gKr; arc=none smtp.client-ip=178.154.239.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net [IPv6:2a02:6b8:c1e:299f:0:640:8fbe:0])
	by forward103b.mail.yandex.net (Yandex) with ESMTPS id A664D60AA7;
	Thu, 26 Jun 2025 13:05:47 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id R5SeXwKLg8c0-n27nJIN2;
	Thu, 26 Jun 2025 13:05:46 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1750932346;
	bh=WeJBx0hJf3pn1EIeBpOe1QyfcrmywlGvQz5HjI9T2zE=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=kz/m0gKrsnjeD3B6iCkAl+9lyItvXwCyrZLx4uRdVeELuq13+BaW1YEOjdVEMcEHO
	 sfAJ/p5ulnJm0tm6EdlDJoM6rndflY5n3n2N0agrD1wqzragA4IVE/NVxR67Yo1Rvm
	 FdYycab5X+vB2hpv6Id8YiW/sA7egct7kRF7/qlw=
Authentication-Results: mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Cc: airlied@gmail.com,
	simona@ffwll.ch,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	gregkh@linuxfoundation.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	davidgow@google.com,
	nm@ti.com,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: [PATCH 0/2] rust: replace `allow(...)` with `expect(...)`
Date: Thu, 26 Jun 2025 13:04:46 +0300
Message-ID: <20250626100448.27921-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replaces various `#[allow(...)]` with `#[expect(...)]` as suggested
in the kernel coding guidelines: [link]

[link]: https://docs.kernel.org/rust/coding-guidelines.html#lints

After switching to `#[expect(...)]`, I found some dead linting rules
that are no longer needed which are removed in the second patch.

Onur Özkan (1):
  replace `#[allow(...)]` with `#[expect(...)]`

onur-ozkan (1):
  rust: drop unnecessary lints caught by `#[expect(...)]`

 drivers/gpu/nova-core/regs.rs       | 2 +-
 rust/compiler_builtins.rs           | 2 +-
 rust/kernel/alloc/allocator_test.rs | 2 +-
 rust/kernel/cpufreq.rs              | 1 -
 rust/kernel/devres.rs               | 2 +-
 rust/kernel/driver.rs               | 2 +-
 rust/kernel/drm/ioctl.rs            | 8 ++++----
 rust/kernel/error.rs                | 3 +--
 rust/kernel/init.rs                 | 6 +++---
 rust/kernel/kunit.rs                | 2 +-
 rust/kernel/opp.rs                  | 4 ++--
 rust/kernel/types.rs                | 2 +-
 rust/macros/helpers.rs              | 2 +-
 13 files changed, 18 insertions(+), 20 deletions(-)

-- 
2.50.0


