Return-Path: <linux-kselftest+bounces-3673-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC8D83F710
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Jan 2024 17:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3986F28999B
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Jan 2024 16:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA69604DB;
	Sun, 28 Jan 2024 16:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RyRvfUfw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEA8604CA;
	Sun, 28 Jan 2024 16:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458411; cv=none; b=fyAGMP8boZjH65yEDHWzQKyo0US8lXGIWz3QF0rMcN9nxBGFlXXUd5Us9ANDY8R5Xkg5VE1311s0sDPbmxOdcVyFgf0i3C5vU+NJM39KLge+Lp+8T11kFomOae14o97xj2VnpDehkIYTSP505hAFRNLxAacUh7shz+i0WVl1tUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458411; c=relaxed/simple;
	bh=VBn9Yltm5cfWYKt+VTGYGKZwWroFJx7UMerJX8Wpfqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=to4TLDHe/W0qlX+WcPtLqch4YqojJqpNcSOjOaoJpy0LzqTQ1AI9jsTAuE4evEx+Af2FXglKk090/kBJmMyikgRnJE+pnY4SSUBPYn/goY7ECZOEkWqC9EFgDRuY6fvK1RlAf7qwGYe/Ers6L98Li7OGf979EVnh/y9XW0zHYhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RyRvfUfw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2EE7C433C7;
	Sun, 28 Jan 2024 16:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458410;
	bh=VBn9Yltm5cfWYKt+VTGYGKZwWroFJx7UMerJX8Wpfqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RyRvfUfwGRXJ26jQx8VpYtYO8NntxAIAPVWoKtXbIVrVyE+ldp33DGDSYwu5+SkQP
	 QrvratU5Ev2NDqPl5951cFuF4MnE/XKe5QBqcLqgttQENEgeiZ2jCU2RvBZSXqhB95
	 psOayMkeJN2lmMlbhUNDYvJaPMzQsdc4yqOHDO1866Bp5BuD8TEtQ3g7uDjUP86wNz
	 G5bfF3HbCM3raHZwV1FL7IBwCwtC5wbLEWRvhHRVT93vUPubpyH/MtKMbAIqreOHhL
	 THF0eaBTr2iBDlfL8OpUg/vsUiY02v4GhcbRDF1TM9rogT8kaMlnypuK8+vtIxHMVK
	 Ugt7dDJntfeAg==
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
Subject: [PATCH AUTOSEL 6.6 08/31] selftests/sgx: Fix linker script asserts
Date: Sun, 28 Jan 2024 11:12:38 -0500
Message-ID: <20240128161315.201999-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161315.201999-1-sashal@kernel.org>
References: <20240128161315.201999-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.14
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


