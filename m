Return-Path: <linux-kselftest+bounces-12055-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1478090AFFB
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 15:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1E6E1F21346
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 13:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACE219B5A8;
	Mon, 17 Jun 2024 13:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4F5KWrc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A006F1C9EDB;
	Mon, 17 Jun 2024 13:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630648; cv=none; b=kCFuPXA49m7CNMsEcOsYQNOFiJ9+knXGp5YKG3J4XloBrZ2RCMvAJg/8tyuuwE+o0aFm7YGvwQge5aMrledPzKfdhjA/dw13nTjNn17Fxlq/tOw9rGXRAR0LVgojkV08ipny6x2+d6bogG44wBPFi5HI6jyZ80rOTZWZckm1LIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630648; c=relaxed/simple;
	bh=RS9U/3BUr1Q86veiwVYktTTSLMNsseftXRF1uo2D5Yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pHEgdWtVuhUsMPAkbQjGlkSKpQBP8LvBaZQ1jEhj+RjJscyCU43wQeOY17QQeNy6f+lXxWRbREF8+SoqYCMOiS/SUbl9TNzdRuMV1wfOH/fDlCyi4EPmm8OPPN76a8XU/pxiKF9zuEPjgwNpDTvmERM+tHQLFfajzRgWadtdSGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l4F5KWrc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4F7C2BD10;
	Mon, 17 Jun 2024 13:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630648;
	bh=RS9U/3BUr1Q86veiwVYktTTSLMNsseftXRF1uo2D5Yc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l4F5KWrcxLJcaF5jojZri1Hm+u8oaEEl4KeXnv02+a9qdBf/eRFj9Ut/PpXtGCQMm
	 toh2ai22xxrVUegU476Eqwt/IqFN5ZGLt65vehMwCVxOEIfQmV2MDaYsGaTFTbMvq+
	 6VFI9uKH/03xeCWxy6tvDEXNAQN5+FZNXv8r2DXK5s8QoN9NgsBU6MUO8ZD9a8/tqi
	 z6VHOviH8Q/x4dZ9N8WU3WMdV1WW73Bh9or1wNRdKsdsMeuCSzbi8sQShk04pgpvjb
	 JBbII0KoiR3S1DqUZN3l5ZVDqbuu2I1movmgMLeyoaxkh3wXtl8J03KkZoZTM44DEB
	 i4NlPkzJue17w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	shuah@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	maciej.wieczor-retman@intel.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 23/35] selftests/openat2: Fix build warnings on ppc64
Date: Mon, 17 Jun 2024 09:22:21 -0400
Message-ID: <20240617132309.2588101-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132309.2588101-1-sashal@kernel.org>
References: <20240617132309.2588101-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.34
Content-Transfer-Encoding: 8bit

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit 84b6df4c49a1cc2854a16937acd5fd3e6315d083 ]

Fix warnings like:

  openat2_test.c: In function ‘test_openat2_flags’:
  openat2_test.c:303:73: warning: format ‘%llX’ expects argument of type
  ‘long long unsigned int’, but argument 5 has type ‘__u64’ {aka ‘long
  unsigned int’} [-Wformat=]

By switching to unsigned long long for u64 for ppc64 builds.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/openat2/openat2_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/openat2/openat2_test.c b/tools/testing/selftests/openat2/openat2_test.c
index 7fb902099de45..f9d2b0ec77564 100644
--- a/tools/testing/selftests/openat2/openat2_test.c
+++ b/tools/testing/selftests/openat2/openat2_test.c
@@ -5,6 +5,7 @@
  */
 
 #define _GNU_SOURCE
+#define __SANE_USERSPACE_TYPES__ // Use ll64
 #include <fcntl.h>
 #include <sched.h>
 #include <sys/stat.h>
-- 
2.43.0


