Return-Path: <linux-kselftest+bounces-35949-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8A4AEAF48
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 08:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9C421BC1042
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 06:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED3A216605;
	Fri, 27 Jun 2025 06:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="eLlFtzX3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [178.154.239.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053E15475E;
	Fri, 27 Jun 2025 06:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751007287; cv=none; b=Rh1KxIg1hoZZLGqz6/X+UwgpV6hywq9KAl4qXb4iNOXjeLHYem0T/5yzfA4A602TLKchdJ1+rLdmOQJXg6YqVdgJZlgBLMcCehn/Ttd6JYUjguV0cq6gLNWpQXzT2m5E/LUp4gHsGTEsEMbwQoiFtta7L6xs5dRg9cofdVz9BIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751007287; c=relaxed/simple;
	bh=VbiOjkMGx8RbxGecy4HGHfDEcdfX0CcHQBAusBhbrgg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IrG+RNgjr7oCMrga6TvmH4nmcKDVudOHnMpmc/bwuLN9pwiEv1OMBn9EGxLO8emcibG9DJ/lhiW8y2xnIdfi7/2W+BsO5JLhf3Hf2c7Xq2qV2/TPJur6RO9OHH2k+TIqXbVUk9AkZVFIHXh7Bs6ewiwmPXNsS8BORvoFVH2F5JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=eLlFtzX3; arc=none smtp.client-ip=178.154.239.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net [IPv6:2a02:6b8:c23:2ea3:0:640:da3e:0])
	by forward103b.mail.yandex.net (Yandex) with ESMTPS id 5053960A8F;
	Fri, 27 Jun 2025 09:54:41 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id PsPIlP9LwSw0-gTqUx7D4;
	Fri, 27 Jun 2025 09:54:39 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1751007279;
	bh=CJNwJ0KShExEmokb1VTyUgnlCMRXg6H/DizRF/P0E2k=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=eLlFtzX3Npmy1h9o+JVKvYItTJ8QgPVZSUfll3pl8usLWah2ow7CpvdGMepgX0XSG
	 S9Lg5/bVB1Na3tQiQZEDQd3WK/vM697y6AfKQpluCuGkuH89SW3QoocCXRR7JLG/qd
	 7+BUTW/0JHI3TVthr5RJ4/Wm5j9levNHUd87pdMU=
Authentication-Results: mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
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
Subject: [PATCH v2 0/3] replace `allow(...)` lints with `expect(...)`
Date: Fri, 27 Jun 2025 09:53:17 +0300
Message-ID: <20250627065320.9315-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes in v2:
  - Removed lints are not replaced with `expect` in the first diff.
  - Removals are done in separate diffs for each.

The `#[allow(clippy::non_send_fields_in_send_ty)]` removal was tested
on 1.81 and clippy was still happy with it. I couldn't test it on 1.78
because when I go below 1.81 `menuconfig` no longer shows the Rust option.
And any manual changes I make to `.config` are immediately reverted on
`make` invocations.

Onur Özkan (3):
  replace `#[allow(...)]` with `#[expect(...)]`
  rust: remove `#[allow(clippy::unnecessary_cast)]`
  rust: remove `#[allow(clippy::non_send_fields_in_send_ty)]`

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


