Return-Path: <linux-kselftest+bounces-10459-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB758CA690
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 05:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E2C61F22768
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 03:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495E912E71;
	Tue, 21 May 2024 03:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="SdlCKIvN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156351FDA;
	Tue, 21 May 2024 03:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716260480; cv=none; b=H338juvvuu6pMIglor8bkUbvnzT4+14/TenCrrxTzj8ZcRfwOSb9Mumq9YW6h0sbLSW+r9ffh2OP+f5QD9+seMH/crAPLkLuariilvM6I1KWQ3gf0LgIgh+OKIdGooo5PFXjLy5p7wqGxj1pTrEnPaIlIk/2TWLr3jGmAKKsfiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716260480; c=relaxed/simple;
	bh=r8821WaSZV86GCQaRc1hlgkua+SVB3nfmJuMVczjS30=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DPb45ee+IhZdM6gmdhohmcH59TGsnc9pQ3QC+TaznikIfmPZ4GcRJPQFHZDrw8cIuJyZm/2ZXUaDcU9qKrMYOyQP1kAiVaiEEIGzbiNnD28sz2amAUESE4LQYZWaCEuoYg/emLKlMC3Stxlqla9BVbm/faLX/kRjnx1NRQiUq1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=SdlCKIvN; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1716260476;
	bh=HeX+ig8qxtmDxUpT3wj3GXg4AsVmeDqRACTRwneLw0A=;
	h=From:To:Cc:Subject:Date:From;
	b=SdlCKIvNkUzfDQN0vRTs7acrYOni4xbXcU7DBQk6uJPiskIGomlcFwKf2XYs1F1fQ
	 M/EEbhGlBfRbb++kgMILjYcGd1mRMUOu/EVI9CWLX2g+hyrI0CxR59iBAybfpXhOa3
	 sVGweflawWcur84zMc0kNBx04J6JIzuvtwKg1hjnhPjAXWyH9KvMsubFJ78p5fa51j
	 rv/bVykNb203yU/XLMr4Lizea2Dygwcy2AHVsF4Y9zFBmxb6rd2YA7JsUOqM4DPz9D
	 QI3KQTRImB2NKopwZ3dAdY923pS5zylD80k0ejmjS0eb+nZSBL75KqBz86zUJaBrCX
	 dja2t+qyUFsKw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Vjzj80dZpz4wc3;
	Tue, 21 May 2024 13:01:16 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linux-kselftest@vger.kernel.org>,
	<skhan@linuxfoundation.org>
Cc: <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>,
	hannes@cmpxchg.org,
	nphamcs@gmail.com
Subject: [PATCH] selftests: cachestat: Fix build warnings on ppc64
Date: Tue, 21 May 2024 13:01:11 +1000
Message-ID: <20240521030111.56568-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix warnings like:
  test_cachestat.c: In function ‘print_cachestat’:
  test_cachestat.c:30:38: warning: format ‘%llu’ expects argument of
  type ‘long long unsigned int’, but argument 2 has type ‘__u64’ {aka
  ‘long unsigned int’} [-Wformat=]

By switching to unsigned long long for u64 for ppc64 builds.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/cachestat/test_cachestat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/cachestat/test_cachestat.c b/tools/testing/selftests/cachestat/test_cachestat.c
index b171fd53b004..632ab44737ec 100644
--- a/tools/testing/selftests/cachestat/test_cachestat.c
+++ b/tools/testing/selftests/cachestat/test_cachestat.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #define _GNU_SOURCE
+#define __SANE_USERSPACE_TYPES__ // Use ll64
 
 #include <stdio.h>
 #include <stdbool.h>
-- 
2.45.1


