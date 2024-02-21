Return-Path: <linux-kselftest+bounces-5163-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A0B85D85F
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 13:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30DF81F237CF
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 12:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A60169D30;
	Wed, 21 Feb 2024 12:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/JMfN5b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE3869D13
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 12:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708520008; cv=none; b=Hvi5lpNsRFlQTnzQ2Uij040IPZI88c+t042Pg1QSD1W7v+bqNLpFfk9NS1M0islSw1yocUoNg49XykGZwn8CnYzODIdRIOMCceOttFD79A3ZDt1In8TdIdMyA8An+dVmazQKHF913ol+6fWb08I2DGj7FDgqsGz4GlDJoGml8Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708520008; c=relaxed/simple;
	bh=lCY3BGNGmSFTNxZNxhtjQMLUgQVyXOqUKqhS3zniBlA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IoAYdBfOtYPck0n1OdQyfTnVFDsrFYKQCuXiuvQFRysTWMyDV21dPmlGI28yhYjbKtsOq6GWB743Mo0bfU5MvY5v57V6Tn6chJbX4n647hAL91N8KplCddknWf3BWhCNSDRVSDLaATHgup+ZRFNWeFH1H/TU290Hwh38GRjijZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/JMfN5b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB5EC43390;
	Wed, 21 Feb 2024 12:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708520008;
	bh=lCY3BGNGmSFTNxZNxhtjQMLUgQVyXOqUKqhS3zniBlA=;
	h=From:To:Cc:Subject:Date:From;
	b=H/JMfN5bYXxRJ0yE5Yn1Df3XNuulB4xkxyrsbDcm61nA+KfwzNctU1bqprEPdvK1H
	 6m6OjxjULMl63x5ZPAiM5RuYStr6fze8ZddP0KB6zIWJLhC1f+MM731Ko658/Nk816
	 mOr6T7kyidvFVg+MZlFdpiPHU0IMau98/v2pGBo83pVswBdP4QHbQqULaDE+D20Mfw
	 VBAWiswUlcd+zWogIOG9izFQN+9nABHAZqbv/ppVEVHXwE16J21SqSBQw/kg3r2eDd
	 SNjIINeTOb1WU/O12U6v653MtWjxbSYm2M2WsA3yXNWQtvvwNhZrbkHpvyHzd4mmkn
	 IAMJy6m3eTbkA==
From: Maxime Ripard <mripard@kernel.org>
To: David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	Brendan Higgins <brendan.higgins@linux.dev>
Cc: kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	Maxime Ripard <mripard@kernel.org>
Subject: [PATCH] kunit: Setup DMA masks on the kunit device
Date: Wed, 21 Feb 2024 13:53:24 +0100
Message-ID: <20240221125324.718192-1-mripard@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit d393acce7b3f ("drm/tests: Switch to kunit devices") switched the
DRM device creation helpers from an ad-hoc implementation to the new
kunit device creation helpers introduced in commit d03c720e03bd ("kunit:
Add APIs for managing devices").

However, while the DRM helpers were using a platform_device, the kunit
helpers are using a dedicated bus and device type.

That situation creates small differences in the initialisation, and one
of them is that the kunit devices do not have the DMA masks setup. In
turn, this means that we can't do any kind of DMA buffer allocation
anymore, which creates a regression on some (downstream for now) tests.

Let's set up a default DMA mask that should work on any platform to fix
it.

Fixes: d03c720e03bd ("kunit: Add APIs for managing devices")
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 lib/kunit/device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/kunit/device.c b/lib/kunit/device.c
index 644a38a1f5b1..9ea399049749 100644
--- a/lib/kunit/device.c
+++ b/lib/kunit/device.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/device.h>
+#include <linux/dma-mapping.h>
 
 #include <kunit/test.h>
 #include <kunit/device.h>
@@ -133,6 +134,9 @@ static struct kunit_device *kunit_device_register_internal(struct kunit *test,
 		return ERR_PTR(err);
 	}
 
+	kunit_dev->dev.dma_mask = &kunit_dev->dev.coherent_dma_mask;
+	kunit_dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
+
 	kunit_add_action(test, device_unregister_wrapper, &kunit_dev->dev);
 
 	return kunit_dev;
-- 
2.43.2


