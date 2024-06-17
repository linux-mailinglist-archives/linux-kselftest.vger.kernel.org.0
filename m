Return-Path: <linux-kselftest+bounces-12057-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D807C90B0AA
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 16:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE9071C2303C
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 14:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6965B185E49;
	Mon, 17 Jun 2024 13:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGyNTZ+q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411A8185E44;
	Mon, 17 Jun 2024 13:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630740; cv=none; b=OBajm1bstiwfkObzpGKU/CiO4cPqiWor4Nk1RGD58PKE0bQkT4pm1uY9gSKV2cfr895Tx8YP/k26XNE27FEbJ3NwhJpyaNF9xp4qyZ0R03bdqZsX/s33VzxudaYjSJn27fIknBwjDOsMa1rLM+LpR/lOlL7TkvcATawDNv3YaW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630740; c=relaxed/simple;
	bh=RS9U/3BUr1Q86veiwVYktTTSLMNsseftXRF1uo2D5Yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oAF9Ib2AeEbpeSqVBasoc4WBakSM74Ao9+/pLR8aIIf8RyFf26d0KVBGkX9IlaXCnq+8MmIKSoCKRji81f7P06iGcANJO7cOBQwWKjOpxMOJd4RQDkzpj3aOuKImnKTOfMDG9ifi+V20Lm8zN4ejTpb9r1W9Lhoe1ExsQ54SLME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGyNTZ+q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E8DC2BD10;
	Mon, 17 Jun 2024 13:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630739;
	bh=RS9U/3BUr1Q86veiwVYktTTSLMNsseftXRF1uo2D5Yc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OGyNTZ+q8iMBYQli7mMNDuEvcJ/Ss9XNDTB3TBU7n+bD3IjFXqM51lAL+OVdBA6h+
	 /R8V+3cVhCHR7Xt+wZ3kIWPqroidqN9DrUFrbNqzuCfKUn1/yyTOcXJv6vCSbyeA7o
	 tUSQblEqHEwzID1Yn4MfcYdefPhT/82ZNd+CBZf3w3Z5C+1iif7u6nUuYKg9UXMmMj
	 YgO7CnyMxZsl3Vq3T99b8LxuNHKUBI7aWk3c/k6SI4ukxiGnKdxResmBrKS7IYnCnM
	 JKxrrCXUFXJYeUI3VS1LMaM6Gxc5vPGtzDryz62Tlzyh0Q6e4Zok8e1xXvPz5/MGng
	 JaCdimoTH8XGg==
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
Subject: [PATCH AUTOSEL 6.1 20/29] selftests/openat2: Fix build warnings on ppc64
Date: Mon, 17 Jun 2024 09:24:24 -0400
Message-ID: <20240617132456.2588952-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132456.2588952-1-sashal@kernel.org>
References: <20240617132456.2588952-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.94
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


