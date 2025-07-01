Return-Path: <linux-kselftest+bounces-36140-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 899F1AEEDAD
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 07:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6954E188A61C
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 05:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D691F4634;
	Tue,  1 Jul 2025 05:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="ZbyeDo7b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [178.154.239.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FED31AF0B6;
	Tue,  1 Jul 2025 05:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751348190; cv=none; b=hjyJc2V6FoGX1D78JB1G3qKHiKRy/zGPSPWZ+t3VMwEcu+DtCI1bWRvCEiaTANsIT7tSJtyZUVqI0BsuvxYWokbpPHZJjZssZ/zGRdWpNHEJ7BN0tn1+wXxN6B1A/GQuSCS2KQzU88Ovq8n0PTlaLfcN54MvmGTj0AaLi/8n3G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751348190; c=relaxed/simple;
	bh=QyWrQPXXxFIvY5Y5myJjIi7pV2uH3HswisRYsgJ2pGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YMlgg1eTRD6x9/3niQ3R+dUhzuJY5PsLvOIqIgbbrInYojR4ZDbK4uXYqU7qYvueH0/oxtKjDtKiY26JmTndA7umo3ct4/IYmth897xXjyhdzEyUMr4ytRds8n7lifx90FLmSp7RaJ4dH5utKVWxUIRd00c8TMAv2TKVPxd5aqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=ZbyeDo7b; arc=none smtp.client-ip=178.154.239.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-73.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-73.sas.yp-c.yandex.net [IPv6:2a02:6b8:c23:2f3c:0:640:5ff5:0])
	by forward103b.mail.yandex.net (Yandex) with ESMTPS id 7012E60CFF;
	Tue,  1 Jul 2025 08:36:26 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-73.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 6aSk1O9Lw4Y0-QdGxv3DU;
	Tue, 01 Jul 2025 08:36:25 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1751348185;
	bh=QyWrQPXXxFIvY5Y5myJjIi7pV2uH3HswisRYsgJ2pGw=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=ZbyeDo7bCUa12zV+VLQBteTD7EBASnT+aPfM6wgePDFm/evRJBImQ8CLnylIdCJZv
	 zhE3GRycEFoe2nDIxVCkn6KNeDzFHZc2v5I/wX5oSqzOUP/wm/K0lBDz05caQhJWyH
	 MMjH7vYrsV+b5mr9JImbfvjcbajPvAaB/DMlE69Y=
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
Subject: [PATCH v4 3/6] drivers: gpu: switch to `#[expect(...)]` in nova-core/regs.rs
Date: Tue,  1 Jul 2025 08:35:54 +0300
Message-ID: <20250701053557.20859-4-work@onurozkan.dev>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250701053557.20859-1-work@onurozkan.dev>
References: <20250701053557.20859-1-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This makes it clear that the warning is expected not just
ignored, so we don't end up having various unnecessary
linting rules in the codebase.

Some parts of the codebase already use this approach, this
patch just applies it more broadly.

No functional changes.

Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 drivers/gpu/nova-core/regs.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index 5a1273230306..87e5963f1ebb 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -2,7 +2,7 @@

 // Required to retain the original register names used by OpenRM, which are all capital snake case
 // but are mapped to types.
-#![allow(non_camel_case_types)]
+#![expect(non_camel_case_types)]

 #[macro_use]
 mod macros;
--
2.50.0


