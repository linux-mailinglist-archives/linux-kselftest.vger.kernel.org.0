Return-Path: <linux-kselftest+bounces-12144-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BCA90CC97
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 14:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C9CF1F21E9B
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 12:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A27C1891DF;
	Tue, 18 Jun 2024 12:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIz5EDn1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713221891D6;
	Tue, 18 Jun 2024 12:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714368; cv=none; b=qTC+O73xYNG6owHhOYMGy8A0Cx7ddeuKkyQyygvUejtYHkb1ApUPrMB9jU1r/bNNNuEcLrmqcZArM8SiqrvS2PYR+B33HNMXeGoK+GmLKKCUWKSEBlRPcpyawCqZfH4hlbuAXVtCQX35GOpcm0HiJMG89/sa93uUhRyg53rh2tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714368; c=relaxed/simple;
	bh=p/MEkPFhCoNKFjAaJOBzSG0+vkNbRgcP32lGx71sjiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DW+Y9MdPKfPap99dZy0DSzRcbmnvBVU9j0rvnctxsZD5Gh6k966u2dNhArapQHfMHDd/UgEVSuJUCMjSnuC+hziEovT1pIFs2TlCgsBLpHgLlzKgFUqv/QKyHi3TJEj102HeVE+FX1ZaIjzw/wN/r7mlPI8/4PBetrIhJSxTNOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIz5EDn1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A43EC4AF48;
	Tue, 18 Jun 2024 12:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714368;
	bh=p/MEkPFhCoNKFjAaJOBzSG0+vkNbRgcP32lGx71sjiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZIz5EDn1B8hCiTcSrfLPypfa0wCYExXYhmUS75VJYhMrhIgV981lW1tFAaJ0EQ+to
	 JrkQ0xregkhGcqJs2o/M+Ix6jn5Ja1gGpJTAl6LhwZEqYMzVyXYxv0fk3tDTaWfD23
	 4/6hF4H0dnvvPu/ZH6NEGokyTrMXJknY/WqdOuXYEUE2+CLX+Z7acLWYvR9y0ggP86
	 IODXTnwvN4WJwaOgzZ1rtxOvYTNzuf0Vq4kpVWlgsZPJQGaCwYxK4LZ2DHqVIX2U8r
	 E8AI2sKhDcHhzKYCFWfQbT7BSnsWsdINcN9XZH6gEmiFSxc2/lmyuofDS5g0SWdj8W
	 a3G5CTfMPe2Ig==
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
Date: Tue, 18 Jun 2024 08:37:42 -0400
Message-ID: <20240618123831.3302346-22-sashal@kernel.org>
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


