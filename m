Return-Path: <linux-kselftest+bounces-36023-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B12AEC4C1
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 06:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEBBA4A5BED
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 04:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21AD2153D8;
	Sat, 28 Jun 2025 04:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="ppysf/M9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [178.154.239.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9643198A09;
	Sat, 28 Jun 2025 04:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751083827; cv=none; b=drxVzr38LMgs8TW5mAurKbJnFIcEoe/RrTgqP7Fstnpo83q32FSO28X2iU+E4iCrrA5ImvRbzoaFG/eIeiuSvz6OXdk3n7lKb/pf9q8ZG21yY/BoSDCbosJ9VF2tNHffidpHx5RhLbzOO+02pXH2bFHPgkW3XGzP+P1pYRtGop4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751083827; c=relaxed/simple;
	bh=W15WxcBu1Leih0HLUaMwgxmTlMpK5/pvdo3CF6H9c2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m2oNJEKIHgm1Owe3oT/+9JSKia8r9Um5vPmBm5IP+dt1lqgcMxvzp5Q4ii3ZO3efCxYRwx1UWkoOcZqx7ZjBCEL0ffq2hGdzFOegRBr/cevqv2xWCmCVYqZiox8fg/YhIMOmujAV3VSLHpF+RSOgFw9aup9tOWvZVHb1NSQIDqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=ppysf/M9; arc=none smtp.client-ip=178.154.239.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:623d:0:640:ecee:0])
	by forward101a.mail.yandex.net (Yandex) with ESMTPS id 6D30A60A75;
	Sat, 28 Jun 2025 07:10:17 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id w9OeTYGL2iE0-wkCFADBG;
	Sat, 28 Jun 2025 07:10:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1751083816;
	bh=LIANWbwXoHTm5UELKt2HfrArvsZZLzkN8O1bfaimzTo=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=ppysf/M9yRMHt7PJWMvunNhEFc3jDKIon+AI6fMpspyjMwruGqFFzHVq6WfcgEayb
	 Woyv+EC34ptpE4cA9NY3pO3L+IKmngs//3joY5jrNTM5fOXPnyWHnznnb/HQK2xDBO
	 FFo5AaQ3AnrceMKg5TF6kGJIT6BswhSXfjPZhD4A=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
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
Subject: [PATCH v3 0/3] replace `allow(...)` lints with `expect(...)`
Date: Sat, 28 Jun 2025 07:09:53 +0300
Message-ID: <20250628040956.2181-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes in v3:
  - `#![expect(internal_features)]` is reverted from
  `rust/compiler_builtins.rs` which was done in the
  first 2 versions.

Onur Özkan (3):
  replace `#[allow(...)]` with `#[expect(...)]`
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
 rust/kernel/opp.rs                  | 4 ++--
 rust/kernel/types.rs                | 2 +-
 rust/macros/helpers.rs              | 2 +-
 12 files changed, 17 insertions(+), 19 deletions(-)

--
2.50.0


