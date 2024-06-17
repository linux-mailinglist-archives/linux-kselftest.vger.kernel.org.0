Return-Path: <linux-kselftest+bounces-12060-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDB990B134
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 16:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A5FA286E86
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 14:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599E21AE848;
	Mon, 17 Jun 2024 13:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKZz/rVO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9D11AE840;
	Mon, 17 Jun 2024 13:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630842; cv=none; b=CVa5hg/yC1KGIxxslMKo2Kw0xYTz0PB3/Xr8ndY2ELfTaki1oy8mzWbV8/uPwNvtF6VOcd7zG6YMrGim1RozVYTPdR9tJB5047Oa9ycrURXNkSgjamrfkFHZnIT3gGy5CaebyNY22of5s9Pq3teI0gaWmoDwmkcJCt+fxEPd0Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630842; c=relaxed/simple;
	bh=o9y2ImBDUHBIFJ58FSRGbv0KBquKYclerjTIRvuoJ8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GGiwnmLDsVa8OV45zAcOnVQuCjWQqs1acoDxY93vpEhJU+vXYnyHHHopKRvwT4pjR6L0Or26zbVL1UJuItGBzJ5jCZFDy/Kkn2mbuxdVUWZ4AfoOconWD9iv8OMgCD6uwmz0eRay29T6mrnrgzXyNkD0ktqBDugrMXeXsosz5v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKZz/rVO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98355C2BD10;
	Mon, 17 Jun 2024 13:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630841;
	bh=o9y2ImBDUHBIFJ58FSRGbv0KBquKYclerjTIRvuoJ8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GKZz/rVOhFomr37KlFWWfPjq0+5nKItR5wiwAapRLq33tzIfaxreNoYT1C8r1qBb1
	 KWDlt3rJG4xBHIVUu68R27xQTf8SvKiNm/Kok7AbCSbh0SsaU+/6ZUZo7xYtL351U1
	 rKnh16BHZz6nMRN7f5c8DZaOJFTXQdatvfE9fkIBzD6rBPCl8V17HDbwrLba/d5DXP
	 6ujF95MePV034qke6dy/4sWA4x7lsKT5fIg8IKGHPeaFPwMMmyvpdEvH/hOqWHQ0ct
	 EvJ4+FrzCDoofUuPw7uLzew+996H55evE1tbLwVmqAOoRIrlwt2342qVcJq3bxpH3A
	 YaLXHcHl45xAA==
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
Subject: [PATCH AUTOSEL 5.10 06/13] selftests/openat2: Fix build warnings on ppc64
Date: Mon, 17 Jun 2024 09:26:55 -0400
Message-ID: <20240617132710.2590101-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132710.2590101-1-sashal@kernel.org>
References: <20240617132710.2590101-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.219
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
index 453152b58e7f0..1045df1a98c07 100644
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


