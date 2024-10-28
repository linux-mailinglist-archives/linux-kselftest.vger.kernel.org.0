Return-Path: <linux-kselftest+bounces-20874-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 488269B3E75
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 00:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0073D1F230BB
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 23:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2DD1FF7DF;
	Mon, 28 Oct 2024 23:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXD/8k8V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3CF1F9AB8;
	Mon, 28 Oct 2024 23:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730158269; cv=none; b=VFpvMvZXoAFjO3XL7gfEDENZ01mgVSPAgfmI2RremP/aLr7puZCTsh1UtjW+yHa00ZMXE8maB9e8PcOC6926VKbHLMj0kjI5HISQBGQibYp+MYo2ywzbFVMDZ8DA5/HWoG2mN/vI2e3cWlC2eX90OHLbC5MIY7Lrv/BcAu3StaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730158269; c=relaxed/simple;
	bh=GazCT9AHFa10tZyGrGFsqkLPKdoAkhFdaCC0h4kcK1s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lXGFo1JDxW/ClDQMX5XueEw7MalQEZBnivrLui5Xm3KkX/bRQd2VfM7PAcHbuVxgWYjNuQcftvD5JvGdna5so+pyE5QGxu/rIXGK3aqxFn3fsSxiVn2SR4TMBUUESJadfstq4MdQBWeAezuH9X648h8nAi4j/CksBV2fLFYxXNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXD/8k8V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D558BC4CEEB;
	Mon, 28 Oct 2024 23:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730158269;
	bh=GazCT9AHFa10tZyGrGFsqkLPKdoAkhFdaCC0h4kcK1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gXD/8k8VqVOm4RDi4oU8W+BChyCQbhmPOHNch3H9ndxa8GFgOtX0b7LfvP4kS9dCl
	 gmsLOPpi4OuRJyZEHj4D6P5mRA4krvdaObS7WkZR7dQ474Y6mXbWEGn/OpZit4m+bM
	 5KCFrXNCwY4kJtiapUD4TGSi4U36D0h8vsu3OfgcPRR68ul1J/tYUt5E1CPK8rdzzb
	 JHrMJt7mVd9uWR3ED80xPZlflvbMVorv0vFe1reVnRR4MjLwwxT9zsUCjevOKEDd5l
	 7GXZgHOe8y107TcfC02dDR3bK+Ws9m3MJroG8P1Ep6sCRSOfev84ce6c2cTR+egrrw
	 c4GuMghCNXZWw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] selftests/damon/debugfs_duplicate_context_creation: hide errors from expected file write failures
Date: Mon, 28 Oct 2024 16:30:56 -0700
Message-Id: <20241028233058.283381-5-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241028233058.283381-1-sj@kernel.org>
References: <20241028233058.283381-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

debugfs_duplicate_context_creation.sh does an invalid file write to
ensure it fails.  Check of the failure is sufficient, so the error
message from the failure only makes the output unnecessarily noisy.
Hide it.

Fixes: ade38b8ca5ce ("selftest/damon: add a test for duplicate context dirs creation")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 .../selftests/damon/debugfs_duplicate_context_creation.sh       | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/damon/debugfs_duplicate_context_creation.sh b/tools/testing/selftests/damon/debugfs_duplicate_context_creation.sh
index 4a76e37ef16b..bd6c22d96ead 100755
--- a/tools/testing/selftests/damon/debugfs_duplicate_context_creation.sh
+++ b/tools/testing/selftests/damon/debugfs_duplicate_context_creation.sh
@@ -12,7 +12,7 @@ then
 	exit 1
 fi
 
-if echo foo > "$DBGFS/mk_contexts"
+if echo foo > "$DBGFS/mk_contexts" 2> /dev/null
 then
 	echo "duplicate context creation success"
 	exit 1
-- 
2.39.5


