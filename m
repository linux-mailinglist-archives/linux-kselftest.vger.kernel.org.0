Return-Path: <linux-kselftest+bounces-3672-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 590F983F674
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Jan 2024 17:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DA131F214B9
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Jan 2024 16:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55AC3D3AC;
	Sun, 28 Jan 2024 16:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+eXwc6Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D803CF67;
	Sun, 28 Jan 2024 16:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458306; cv=none; b=G/ZKcs2IPdsrtjgunRTBrIhRkYcH3psYWf2BkPnW3wiABRJ/T+JDNH7WnFIkBQpTFw00nUPdr8/+93cN03WWRsLP7hZGVBDh34LMtIcmAmBAAJxwSfjDWcMB5ZoH4/MDF+oOZe5sEJ9hFrIYlDUjLR3hAilO+SZcxiPr371y1N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458306; c=relaxed/simple;
	bh=VBn9Yltm5cfWYKt+VTGYGKZwWroFJx7UMerJX8Wpfqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pW2RLVS0fYcdqzcLlFSeYu6ylv9++7safOH9Yk4dhycyaiOa9RsG52JsoTXJ9LTGCPcf1OeWxm2r1utN6lPx22e0H7r814zuCrgfbgyKgBlDjWuklrANl8mX604/kQz6b2FMWTJFVq2BZuGCmrQe6A4ftNeQBUWILlfZ6fB8kDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+eXwc6Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4737CC43394;
	Sun, 28 Jan 2024 16:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458306;
	bh=VBn9Yltm5cfWYKt+VTGYGKZwWroFJx7UMerJX8Wpfqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h+eXwc6QRUmXuDyPRCdjuB3dBN+Nz9UWDMHm0vO+VRD4+B5pQD8zZlVDjiBVUsPlX
	 BP/RdedcPXkgR+ZGthvyGbyPm5rHUEHHyPCtaOZAOF3bWc2YCm0//VW21HmeETaK/g
	 lyiQBwQx1DGCy73+t4muds1KfiqnA+WxFCICKAzJGc66njPiMlzfywys70sbdOELzh
	 uvsb0D4HKF+gj6LMNwNFOWwCf4ORuRUWjLOOVXafPa9MwQcS9N+Mq/Nd+ErJ6eZ6WR
	 g8Hjo1aV1svJo1tdFCP+xWTCl1zbC5UqmBS7+dKyBAY0ojUfHFrMZ/Rvm1HEkezS1u
	 DyUd0nhsK/Unw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	shuah@kernel.org,
	linux-sgx@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 08/39] selftests/sgx: Fix linker script asserts
Date: Sun, 28 Jan 2024 11:10:28 -0500
Message-ID: <20240128161130.200783-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161130.200783-1-sashal@kernel.org>
References: <20240128161130.200783-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.2
Content-Transfer-Encoding: 8bit

From: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>

[ Upstream commit 9fd552ee32c6c1e27c125016b87d295bea6faea7 ]

DEFINED only considers symbols, not section names. Hence, replace the
check for .got.plt with the _GLOBAL_OFFSET_TABLE_ symbol and remove other
(non-essential) asserts.

Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lore.kernel.org/all/20231005153854.25566-10-jo.vanbulck%40cs.kuleuven.be
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/sgx/test_encl.lds | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/testing/selftests/sgx/test_encl.lds b/tools/testing/selftests/sgx/test_encl.lds
index a1ec64f7d91f..108bc11d1d8c 100644
--- a/tools/testing/selftests/sgx/test_encl.lds
+++ b/tools/testing/selftests/sgx/test_encl.lds
@@ -34,8 +34,4 @@ SECTIONS
 	}
 }
 
-ASSERT(!DEFINED(.altinstructions), "ALTERNATIVES are not supported in enclaves")
-ASSERT(!DEFINED(.altinstr_replacement), "ALTERNATIVES are not supported in enclaves")
-ASSERT(!DEFINED(.discard.retpoline_safe), "RETPOLINE ALTERNATIVES are not supported in enclaves")
-ASSERT(!DEFINED(.discard.nospec), "RETPOLINE ALTERNATIVES are not supported in enclaves")
-ASSERT(!DEFINED(.got.plt), "Libcalls are not supported in enclaves")
+ASSERT(!DEFINED(_GLOBAL_OFFSET_TABLE_), "Libcalls through GOT are not supported in enclaves")
-- 
2.43.0


