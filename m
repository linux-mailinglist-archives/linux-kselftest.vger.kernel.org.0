Return-Path: <linux-kselftest+bounces-12049-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA13590AF69
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 15:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 835DD28B9C4
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 13:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596821AC22F;
	Mon, 17 Jun 2024 13:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egHd+HnU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312481AC22A;
	Mon, 17 Jun 2024 13:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630508; cv=none; b=WilL5EK8TqfLBuqJ+kQtFTufL8N8yf6J7elcaD8iVrMZTJsg8D3q2cpgkdOR6W2Jqg5TrvKpImilxvl3pkxP0DopsFdJsn3/p+D6z8kb4lq0X972cdI4J1nCtOPxfKsEdKpfrV3qYzuKxs8S1mKlFu3wKDa/kxTK3AwXWNnml3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630508; c=relaxed/simple;
	bh=+zv0kuWfAVEeu8/6gmrKhn5F4FAKZ4nfFgp5KKdCQfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BnzoMp4JTPWQEdUaIwjV9hm9m5yAYR5ePt077SlreSS1STtJAIig20xkM6jRKp4/8TTkOK4B1k1PWitjBrehN1geSohe0mlgPgV1URcjAbm2nLUdDo03PXOFSONHQ92AQSdJup61bY/2CzGD7oT19L/oXlUpyxz34TH0SpIK0rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egHd+HnU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E2CC2BD10;
	Mon, 17 Jun 2024 13:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630508;
	bh=+zv0kuWfAVEeu8/6gmrKhn5F4FAKZ4nfFgp5KKdCQfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=egHd+HnUFGjqmYPURGWmS5+Z4iGvQq5dcPtkHoRu/sxYLMsbyrTaYcqLrA+tqdb++
	 M1PpESq8CCgHMk5CVCrlJKbsVeo/faR9bdHRhL+IT2+f+xklBURc+uuyTp7V5hq20S
	 HPaA3JTuvrJRteXLVqBvFqUMZxHklLKTRrFTMagHOaTs/T0gSX4sgLcB8UmeHFyk1g
	 Z6mPaKTiQNiJ/Vp2I8/fid6nXCmF6YGZyX5wrQlAZEDRlPvRFrXMDgD+SaVB/2/+kW
	 BHksSqTwnYN8YJwymSj1OR98tNRw6wZpWtQyiNoMF1OdSrRw74F50T1WfO4k54LicE
	 nI42q6K1RFpEQ==
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
Date: Mon, 17 Jun 2024 09:19:38 -0400
Message-ID: <20240617132046.2587008-25-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132046.2587008-1-sashal@kernel.org>
References: <20240617132046.2587008-1-sashal@kernel.org>
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


