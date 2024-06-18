Return-Path: <linux-kselftest+bounces-12145-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4167E90CC9C
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 14:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE0A5285148
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 12:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE52B18A957;
	Tue, 18 Jun 2024 12:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCm7qEpO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9486B18A955;
	Tue, 18 Jun 2024 12:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714372; cv=none; b=pNhav8eDKbj8o67XtZ1h7YX3gH+b8Md5IIiFHKptHj66duw242MaPzEyH3V49vC8bJNy9Nofr/Mx+e/FdO8GLxJwxXPRvrhN2tNJRLvR+Z9pTMfDPuUNrYTPf/APKX5Qtmq+0VNTbkDTrBNfmoGo1LqXTuIzMFC1Px9ypXCQiNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714372; c=relaxed/simple;
	bh=RS9U/3BUr1Q86veiwVYktTTSLMNsseftXRF1uo2D5Yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e3s7RwwsSwtgl0C3FqhFFyeOqDb6kHSftH9LWq80d03lMxTxEjAta9/QEAxEqiYxuV4ZI6Vt4R/rOXwg/mJCxdZzjNijmBXWj/ebCVRpZeNCnKPtLbWAcW9+6h5KEzidZyTjzaSjvM2ZXsM+S0CJT/TNNzMIovHTNp+f8dTTizc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCm7qEpO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B05C3277B;
	Tue, 18 Jun 2024 12:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714371;
	bh=RS9U/3BUr1Q86veiwVYktTTSLMNsseftXRF1uo2D5Yc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HCm7qEpO5kf2BPvLaT45jRxULX3yPtgCIOjS35qAODjDw5XOpvmLmzqYH8H2u5ARk
	 eSKyVUDRJ7GbCAg73OFI2aFDlGYBiwJ2o00yNEk0Gpq1MwiE291repfpn42TXlbm2p
	 bRzUlYeXJgsjJXmxfoRT2E+i6zc9nWAvYNzZenLRZwE+mI4u/f5hPFEf3/GBTaskA2
	 jyo4kpD3A7pkzbdSHThy4AInQWfKTubq1kBHWrouUzWka7WV/FGgiwbUt0Zh7C0A7E
	 zgTaz4UE/aEcyH6rNQyVZJhv6d8fmsqLHpGpXR/Crrm4j5ALW7tok8hRoJ/6PGog16
	 mmzpg5qxAx5iA==
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
Date: Tue, 18 Jun 2024 08:37:43 -0400
Message-ID: <20240618123831.3302346-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618123831.3302346-1-sashal@kernel.org>
References: <20240618123831.3302346-1-sashal@kernel.org>
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


