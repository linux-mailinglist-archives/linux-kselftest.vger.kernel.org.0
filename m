Return-Path: <linux-kselftest+bounces-12054-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BC090AFF8
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 15:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0DBD284BFE
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 13:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204FE1C9EBC;
	Mon, 17 Jun 2024 13:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9fM1iDU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84181C9EB7;
	Mon, 17 Jun 2024 13:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630646; cv=none; b=R/JMZzBrO8a8cwsWZW5QfLDGqBtMPeownJ9RVnTIMCwktK4oe1+P/F0EWqU3Rb7fkHVp5tzpTOlEmIlX67oZPdZcQxA9EW8JvVlR4h76jQTxZxFUjVN8bbHsBGKYoGz8etcQP3JlE8sv+F1Oa2RULhnJZZpOpbcuQWWDcMC5Thw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630646; c=relaxed/simple;
	bh=p/MEkPFhCoNKFjAaJOBzSG0+vkNbRgcP32lGx71sjiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OxZMuQ1zfx8Ba7a+3xnYt4L/sIqbpbOPDq/uGXaz3T6U7gaggUqFvF+xZc4NgbAZygTrMK3+dmcpBv5LaIoBQce+xWRJs8v/jtaCkToWJK+W6bq67sd0rDvgC69I6IntvXF0zBO/xF8DdTtbDfxmxaBz76wXw7kNwrSIkUEEhds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9fM1iDU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A231C4AF1C;
	Mon, 17 Jun 2024 13:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630645;
	bh=p/MEkPFhCoNKFjAaJOBzSG0+vkNbRgcP32lGx71sjiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e9fM1iDUfw+Jsuj6xfJf6oKesgFs2C9VSE1ZDqJWNdPZbRtUsGrI9sWQkdaKFY9Fv
	 Tzb0eVAa7xg0F4MJdHuCbDD+mS8YswfA0zNH5Gv+m2tUGCW6L41C5w8et+A9oNz0pU
	 wJNuAnXbhIMQFUM26r7y3rhBjOFMl2MbY57zDUQIXrGLjqqctUXdUeHrw3ZRYDyGsw
	 uN47pate/JYupPSUkGz1VwmC13er0LS2yh2u1v6LuTsLbM9K5cCx+v+RcefdFCJPR8
	 52KG8AqnZz542XheXJVaE/RORLkiS32LyFvT4fGyb6e+6tfcwmO61bGkDimz8yOVSv
	 L1q8D4OY0Udog==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	nphamcs@gmail.com,
	hannes@cmpxchg.org,
	shuah@kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 22/35] selftests: cachestat: Fix build warnings on ppc64
Date: Mon, 17 Jun 2024 09:22:20 -0400
Message-ID: <20240617132309.2588101-22-sashal@kernel.org>
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

[ Upstream commit bc4d5f5d2debf8bb65fba188313481549ead8576 ]

Fix warnings like:
  test_cachestat.c: In function ‘print_cachestat’:
  test_cachestat.c:30:38: warning: format ‘%llu’ expects argument of
  type ‘long long unsigned int’, but argument 2 has type ‘__u64’ {aka
  ‘long unsigned int’} [-Wformat=]

By switching to unsigned long long for u64 for ppc64 builds.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/cachestat/test_cachestat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/cachestat/test_cachestat.c b/tools/testing/selftests/cachestat/test_cachestat.c
index 4804c7dc7b312..ddb70d418c6a8 100644
--- a/tools/testing/selftests/cachestat/test_cachestat.c
+++ b/tools/testing/selftests/cachestat/test_cachestat.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #define _GNU_SOURCE
+#define __SANE_USERSPACE_TYPES__ // Use ll64
 
 #include <stdio.h>
 #include <stdbool.h>
-- 
2.43.0


