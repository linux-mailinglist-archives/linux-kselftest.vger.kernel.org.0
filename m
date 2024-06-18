Return-Path: <linux-kselftest+bounces-12149-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 109F290CEBC
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 15:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F388B26107
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 13:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E50E1AE093;
	Tue, 18 Jun 2024 12:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifiRM5GW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343FF1AD9FC;
	Tue, 18 Jun 2024 12:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714530; cv=none; b=igtL4OMxU0R49mw1MV5RA2+jToU73+wMksToIqjl36ySwgzfwacXKlePExyERFp9LdQIGCqT9ytM/jjECwAPGeNKC11V84LLbKRcOcV5//0VydlNyuR84qsaZtymX80FBOMh8BGGoO5pEn2ZAK6WcljwPvjFdM706lSewYYj16k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714530; c=relaxed/simple;
	bh=RS9U/3BUr1Q86veiwVYktTTSLMNsseftXRF1uo2D5Yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KBOJ+0CpGZj+OMTzstFHDtVQkwO/4bR1Tn8pJ8QCzPujenOnUNN5HYeoM/6rfxKHy6/ef3gUCVK7U1X8NUigddWzk1XS6FNZR0ZIOqq/JvSck2yuQnZ74Uat21q53cPY3HKg7hKPIiktXL7+5ylX1UTrDe2RHpECwE/nFccKJ48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifiRM5GW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A172DC3277B;
	Tue, 18 Jun 2024 12:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714529;
	bh=RS9U/3BUr1Q86veiwVYktTTSLMNsseftXRF1uo2D5Yc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ifiRM5GW9/ozWh94dbgSclZ3EBhNnokSah7Ltm1LYR8i9xgeYn75x62qdEU9Kj///
	 IiozMN/St2WfemsX47AbG53W4Sc6r1YYJDsdRXCd8JLe0rXxF7ODzxIhfqSDAUnnnT
	 Z/KOHoN2JXRRhxNK77qU9dLHYTkhMdLtWThjr1R61T5cEmOxmyRLbdMRQOqNPxyiFr
	 2gydkPpptByndRSr4S33yj3VM4VvpJSrKpFLq+vPgM4kxKdTcnI9vcy3fvnyDQedOR
	 xNQNp2xaO0B4moPxUrIJV47tGExwN/3CA6uTkW99Pzrnk63mALnDtkjpQx0C9ckT1J
	 n+aDMPArc80Xw==
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
Subject: [PATCH AUTOSEL 5.15 14/21] selftests/openat2: Fix build warnings on ppc64
Date: Tue, 18 Jun 2024 08:41:13 -0400
Message-ID: <20240618124139.3303801-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618124139.3303801-1-sashal@kernel.org>
References: <20240618124139.3303801-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.161
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


