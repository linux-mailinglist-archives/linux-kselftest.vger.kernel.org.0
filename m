Return-Path: <linux-kselftest+bounces-12050-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D4D90AF6C
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 15:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB6B328C541
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 13:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909C01AC25F;
	Mon, 17 Jun 2024 13:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qc4fURfF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616E01AC234;
	Mon, 17 Jun 2024 13:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630511; cv=none; b=iv9hKM/uyq4d21DOmRxkH5dUoV2s2RHPkZxF7rKUD+dC/2g5LOu9DEhesQXuGD37OkHdobnLI3pCx4wHkhhuRzBoFxrwKX9pJSGIP6xunKQOJgYgI//taq0jRSGyPEdt5dzli/Dc+OmAwpqn64cuxIYMk3/Nne632D29FpWIzFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630511; c=relaxed/simple;
	bh=qO1jR9fw2QLVSsRBqloYLaKnhU/7rxY1avhNaHxskmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TFsPZHa5S1kSrU9YIV0ICIJDUol5dat1mZnWWr9Kbu8s6WKnYbZgTxVcwSRf1GdTBbTQXxg8WM42vrICS0Xp6Ui/tfaquywdquB+Eqj14lV/4K0A0+k7EVtPNLg66VNDNvx067yyXB6sZzCy/Vov7urKGKIu4wprx1DSS7JK1Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qc4fURfF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C76ADC4AF1D;
	Mon, 17 Jun 2024 13:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630510;
	bh=qO1jR9fw2QLVSsRBqloYLaKnhU/7rxY1avhNaHxskmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qc4fURfFWr2DBKsSY15W+wGoR1CZi040dwVTsqYo3SMZVqAhnGRy6YbUtkFqT0VTV
	 clNu8RDU+9J9N5scULd8iWu17g0ycBXwyDY9zWygpK1uSnOO+g8VOuNloWb3qu3+aH
	 2q0RyQN3p/eMaL/mmrrEl2aUYdO+hbfcThZ83KQrknGYQkQ4jWEGGZrhTpYWqtojhj
	 IeWtOUvn1afLl0A7uqoXHfZmD3XPUK9boN80P1qA9C97Wa7lfKa2Je3K1aoUxqhGmC
	 dQ3vUc8xkIPgR6328AKaVLtRs0FiM2Bg78YyFWdr87JbqzY6lseMEut9mqRbpAoB1H
	 CkxTaJcm3b8RQ==
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
Subject: [PATCH AUTOSEL 6.9 26/44] selftests/openat2: Fix build warnings on ppc64
Date: Mon, 17 Jun 2024 09:19:39 -0400
Message-ID: <20240617132046.2587008-26-sashal@kernel.org>
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
index 9024754530b23..5790ab446527f 100644
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


