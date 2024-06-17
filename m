Return-Path: <linux-kselftest+bounces-12059-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 391A690B0FF
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 16:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E29BF2853F1
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 14:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F5516A949;
	Mon, 17 Jun 2024 13:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RE9tMNEH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABEE16A944;
	Mon, 17 Jun 2024 13:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630808; cv=none; b=NUbg1zx0G2XQBeJUyQDT1vlzYwNrfLiFzym7pdcv5AMFKGSTwFuW8m07GaMvTwkg7l9iYpDGhdvPplzT6Xm+yUctj8ImMz8Rz0DbSXRRixmLWtV/fCGgPdZiz2mP1mmHgcD9sTZJiurNoFlFdzUaoGNRawvGG+n1EO7vVeooCn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630808; c=relaxed/simple;
	bh=RS9U/3BUr1Q86veiwVYktTTSLMNsseftXRF1uo2D5Yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m3lYLFsd2mHyuxolQSMUe3OR/H/jvgL6VHgefNAI5XkQdO9z01QzHS4d2krbyB1qJwaZhFZhwkQymiZqODymi33VIHZDVCFkNy2XTsmWaXv50N3RtUzvZyGHd9CfMb7mw00K2hHpt6npzC6XmbSJVfaBRP+v32MTQI4/n1pUUb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RE9tMNEH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3633C2BD10;
	Mon, 17 Jun 2024 13:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630807;
	bh=RS9U/3BUr1Q86veiwVYktTTSLMNsseftXRF1uo2D5Yc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RE9tMNEH+v1+n5DTj3Ul7E2cAf7vLcZC7tJ5oUTFz0LpNxIGT6bQESc+87mNNZBp6
	 2hEAWWrhyN959A37PK4sKoMIEaIzbcyP505NtLiStVnPfMZsOZUnm2giM2lK8tr7mW
	 KwF3xUCrlkU5B6ife33we0V7k2oKf1mys501IMdZURCaqBS4QxpTpQ1QPQ0MaFEZ9d
	 Rpk9Wfuth4Pz/em7qrMfXCNG4gIw+h6bUMBrlBS8XxtAaJrLkyHWqNRuMR29F62Yyu
	 +tt8EdsLt03X1FM9nU6pUjAB/CPZEbHfyMQx8gJTh45rEPUNmNzxLVPbG4MTAaHrkn
	 HESuqI3l+zdJQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	shuah@kernel.org,
	maciej.wieczor-retman@intel.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 14/21] selftests/openat2: Fix build warnings on ppc64
Date: Mon, 17 Jun 2024 09:25:51 -0400
Message-ID: <20240617132617.2589631-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132617.2589631-1-sashal@kernel.org>
References: <20240617132617.2589631-1-sashal@kernel.org>
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


