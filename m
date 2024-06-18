Return-Path: <linux-kselftest+bounces-12140-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3744E90CC1C
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 14:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CBF81C22D47
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 12:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0C415B10B;
	Tue, 18 Jun 2024 12:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rl6S6ljP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7038015AADE;
	Tue, 18 Jun 2024 12:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714233; cv=none; b=pZ240sBEW3Xf+LFFeEvIlHGo+6Mj00g2ZcD/BMuAvxB2tqDP1BhRXzCZM8YuuJLyNTVyELkmXiNv/0akaHRTQHIPHo0oPvzko6xPZPY3zQ1yS7QUyFLhw8sBCn1U+HExgGzRTP11h4vn8UwDbb8GuxKNNQCCoFregziKVN8wLrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714233; c=relaxed/simple;
	bh=+zv0kuWfAVEeu8/6gmrKhn5F4FAKZ4nfFgp5KKdCQfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HWLeAYDXfAjmL+Om5lJ13DXXcfJj5L5qPDtTn/0wbHv6ecGk7LsbOqvEmp1D0zNPi9sIr3nPv3gMVKA8bYSBP7HumnZlZ0gfMUxULGvdGB+h/AXavBcGJ2wPEC0QUcAHai+bidG6yhUkXX+8dni2rSM7Q9L56quv5FefO94Qzmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rl6S6ljP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC063C3277B;
	Tue, 18 Jun 2024 12:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714233;
	bh=+zv0kuWfAVEeu8/6gmrKhn5F4FAKZ4nfFgp5KKdCQfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rl6S6ljP1Oq42zNySXtb/4YP/ORfyYjvCdksVyWbL8mleRoE7/bkOULQUa3Ja4vnv
	 Sre6Oiku7rJBefYrAWuqCMJKU/pw3wf6AdksplsShhN0Ge22pLUl3Tkxn4/Y2zNyZ/
	 +riy6bZuAzL62G0sZ+bQ+Bs9RIJIlT2A+QYEtKOV6HF+qZ8KfrZyF4qDDpa8RkAhS0
	 vDEgiWX20F2QKGewl1ucHiTTY/U24JLGRptEOuz6ZaxT8OfAepER6LIV60uwMMr9S0
	 HN8TvzOppPUEJWIYEVqMfeBg1R0Qt7601LKxDx/e1et/TnLYeZ7ne+Jpsw7+p8r5WJ
	 umZYPBklCy5xQ==
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
Subject: [PATCH AUTOSEL 6.9 25/44] selftests: cachestat: Fix build warnings on ppc64
Date: Tue, 18 Jun 2024 08:35:06 -0400
Message-ID: <20240618123611.3301370-25-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618123611.3301370-1-sashal@kernel.org>
References: <20240618123611.3301370-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.5
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
index b171fd53b004e..632ab44737ec3 100644
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


