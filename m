Return-Path: <linux-kselftest+bounces-25364-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E8BA21E75
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 15:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE1B33A8DA6
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 14:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5D81DE3DF;
	Wed, 29 Jan 2025 14:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kj5aLJhm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5320D1DE2B9;
	Wed, 29 Jan 2025 14:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738159375; cv=none; b=mTw1LzosaA8pa+h2e++RIViEQBTOS9KNHe2oOgxwjuH4aO65nKasgPjYZrfBeRpaB/sUvz3rT4Wb8X1yWPn3wJO0gqrWhhlLY0MS0Q4QHGX3ahRIYLDk5lNqDevDYZUnxxpvLmZMAerGMe71HYVStlMkdVGhCFLMFoXaGvOEAqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738159375; c=relaxed/simple;
	bh=c/TiNvwooN3OUjz6R9/GdMWx4hNJHCwDmJuf1a2GToM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BBlZtiG9pvgVHR08MMnk61fgsK2sWqkoDm9d2awX6eIZ+h9zcJ4C5b4j7/KdpBFgBh2i/fNxxSDstYcFLUcwfgvLBl64R47aaF6tRsA3p2X1YLTXfJnYbh5UNAIDtPuSt7WcYtR/T//G89bdmBdCDbaMEgm4npMjEkgkQSF/EsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kj5aLJhm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D09C4CED3;
	Wed, 29 Jan 2025 14:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738159375;
	bh=c/TiNvwooN3OUjz6R9/GdMWx4hNJHCwDmJuf1a2GToM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kj5aLJhmrUTBSzpIeM4rmGCMxG8YN5XCGVoXJHVgWSpvoUaNXU7DjJMNE6oR7lozZ
	 eM3GRXVr+WG3PPWwnX5n1kfWx0gO9Lj0BZqAYphl2Y+6Gdw31gZEJXcANfVYWkledD
	 TlwKQRz/4Y81c9mHRfxaUh7elgSHdekySap/ll8HLIO11fdv9887d0gBNQ4PE+AsEW
	 5tTlGYySHRgNsjx0hdRWVVbtzKHHaFj2KtBBUIbewAMtb6x7UVo/91AFhGaOaA9Qb8
	 Zlvx+M5hlRFBBlhw8q8kwPy2efEYk1nrrGa3Yz9FiBSyVOK3nW5MeFUxpCHLbS5tG/
	 T5H3wve6LdgGA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Brian Norris <briannorris@chromium.org>,
	kernel test robot <lkp@intel.com>,
	David Gow <davidgow@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	brendan.higgins@linux.dev,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Subject: [PATCH AUTOSEL 6.13 4/8] kunit: platform: Resolve 'struct completion' warning
Date: Wed, 29 Jan 2025 07:58:57 -0500
Message-Id: <20250129125904.1272926-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250129125904.1272926-1-sashal@kernel.org>
References: <20250129125904.1272926-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
Content-Transfer-Encoding: 8bit

From: Brian Norris <briannorris@chromium.org>

[ Upstream commit 7687c66c18c66d4ccd9949c6f641c0e7b5773483 ]

If the <kunit/platform_device.h> header is included in a test without
certain other headers, it produces compiler warnings like:

In file included from [...]
../include/kunit/platform_device.h:15:57: warning: ‘struct completion’
declared inside parameter list will not be visible outside of this
definition or declaration
   15 |                                                  struct completion *x);
      |                                                         ^~~~~~~~~~

Add a 'struct completion' forward declaration to resolve this.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202412241958.dbAImJsA-lkp@intel.com/
Signed-off-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: David Gow <davidgow@google.com>
Link: https://lore.kernel.org/r/20241213180841.3023843-1-briannorris@chromium.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/kunit/platform_device.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/kunit/platform_device.h b/include/kunit/platform_device.h
index 0fc0999d2420a..f8236a8536f7e 100644
--- a/include/kunit/platform_device.h
+++ b/include/kunit/platform_device.h
@@ -2,6 +2,7 @@
 #ifndef _KUNIT_PLATFORM_DRIVER_H
 #define _KUNIT_PLATFORM_DRIVER_H
 
+struct completion;
 struct kunit;
 struct platform_device;
 struct platform_driver;
-- 
2.39.5


