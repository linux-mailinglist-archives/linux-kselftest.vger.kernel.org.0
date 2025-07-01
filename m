Return-Path: <linux-kselftest+bounces-36147-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6275EAEEDEB
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 07:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAF047A70B1
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 05:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AFB218ADC;
	Tue,  1 Jul 2025 05:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="ml3D77bY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from forward205b.mail.yandex.net (forward205b.mail.yandex.net [178.154.239.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0601B0414;
	Tue,  1 Jul 2025 05:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751348537; cv=none; b=h0OFdahqv9i+FoMSMin4RrAT6sCYG1AYb59XAV45aIWqgIuMGz8WJ5SoPOSQJ3g8F3zJvOU7tdxD9PWmbiMy4JYkgt9GReDv5qCD6rIO/WlozmzNBBYz7+bpGq6uzhL/JaBUQ77Y43mAcVzWsYAF/Spw88hYtKkTW2wcNOPAu6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751348537; c=relaxed/simple;
	bh=i1aPR6BIE6KEUkbHTFPanjGCXGxd/hTIyhnIdYbaHbo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QDmucHwRA3OxGHe3ttITchOHDx8nmpCs4jmIgj+A6JHJdXGTjKXErYJMdVbtU5wcZyLrPmXnTbaTDjUFlGK2iL0Ae5sYEEOz3CBhgg/XoDP1nKiqUXJRoK0TvHRSkO1s3AYlfLNSBkWqeyAPBUdpJZ5HJPZXUYdTLqWI03siYy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=ml3D77bY; arc=none smtp.client-ip=178.154.239.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d100])
	by forward205b.mail.yandex.net (Yandex) with ESMTPS id 76AE063EC5;
	Tue,  1 Jul 2025 08:36:22 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-73.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-73.sas.yp-c.yandex.net [IPv6:2a02:6b8:c23:2f3c:0:640:5ff5:0])
	by forward100b.mail.yandex.net (Yandex) with ESMTPS id 124D360B12;
	Tue,  1 Jul 2025 08:36:14 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-73.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 6aSk1O9Lw4Y0-CKfRbmeG;
	Tue, 01 Jul 2025 08:36:12 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1751348172;
	bh=3xevoVdXu0fGS38zSyAy3XEDQJhBP15KVagmQp94MpU=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=ml3D77bYh/Kaon6DF/jIWmuCIsUC7A2eA84EDHnjyo1BWNUAH2HZewmKVVxdsvAKI
	 F6HB2FmniehUIs8zWxLgAGlapqaqA36huO1Z9GHxFXs5Bs5R/ZJiKfBz5kD+gxltF8
	 ISZQoY4w9uXbwXOxluSKks3O4KzglKw4OJXMk3fY=
Authentication-Results: mail-nwsmtp-smtp-production-main-73.sas.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
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
Subject: [PATCH v4 0/6] replace `allow(...)` lints with `expect(...)`
Date: Tue,  1 Jul 2025 08:35:51 +0300
Message-ID: <20250701053557.20859-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes in v4:
  - The first patch from previous versions is now
    broken down into multiple smaller patches.
  - `#![expect(dead_code)]` is reverted from
    `rust/kernel/opp.rs` as it failed on the
    kernel test bot (see [1] for more).


Link: https://lore.kernel.org/all/202506291507.M9eg5kic-lkp@intel.com [1]

Onur Özkan (6):
  rust: switch to `#[expect(...)]` in core modules
  rust: switch to `#[expect(...)]` in init and kunit
  drivers: gpu: switch to `#[expect(...)]` in nova-core/regs.rs
  rust: switch to `#[expect(...)]` in devres, driver and ioctl
  rust: remove `#[allow(clippy::unnecessary_cast)]`
  rust: remove `#[allow(clippy::non_send_fields_in_send_ty)]`

 drivers/gpu/nova-core/regs.rs       | 2 +-
 rust/kernel/alloc/allocator_test.rs | 2 +-
 rust/kernel/cpufreq.rs              | 1 -
 rust/kernel/devres.rs               | 2 +-
 rust/kernel/driver.rs               | 2 +-
 rust/kernel/drm/ioctl.rs            | 8 ++++----
 rust/kernel/error.rs                | 3 +--
 rust/kernel/init.rs                 | 6 +++---
 rust/kernel/kunit.rs                | 2 +-
 rust/kernel/types.rs                | 2 +-
 rust/macros/helpers.rs              | 2 +-
 11 files changed, 15 insertions(+), 17 deletions(-)

--
2.50.0


