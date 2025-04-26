Return-Path: <linux-kselftest+bounces-31695-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3783A9D861
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 08:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21E904C2AAE
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 06:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65F31C861D;
	Sat, 26 Apr 2025 06:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YACXIfsL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981924414;
	Sat, 26 Apr 2025 06:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745648678; cv=none; b=F1VK8rdrCqMSevvcAs17gYF6FXPh4njH8DGmmyw88UHYpUb/Oq5vLgYgo2iQ3hsnV21xee4zK9p0HjUFfpVDDLHyL1C5gsOYE5ZZJEDcCLQwWrXWtEohKDp45OwS5g992kteLe887bK7GOV2ACGADRK4JJM2Ymyrlv6kNsBar94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745648678; c=relaxed/simple;
	bh=Qze9nAZSQ1I6xgR9vshAeYnvUlrjmo6wnxtuAdSnIBw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZFknLLauARw8iHDqcuV1dWtRW3Q41MX3V4zxrtZKXIyKn6cO1sv4racUL8Xwl/IyPVjJjRf/nJ7NZR++t2F2x+IIM93/EtZrQ++3OClb9TLDf2tZ5sdRo72ukSbi7jF9i1ZtOKGCgm5a3UoqeKLBlteSi7n+BCD7xQEt0qlh+c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YACXIfsL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C550C4CEE2;
	Sat, 26 Apr 2025 06:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745648678;
	bh=Qze9nAZSQ1I6xgR9vshAeYnvUlrjmo6wnxtuAdSnIBw=;
	h=From:To:Cc:Subject:Date:From;
	b=YACXIfsLLd0ezCa/kgcZ1zVhji+Ms8ePeU2oczqsV9QSPNbbIrvZCX83ZAL/u5zXi
	 EpBA9dVPSLm4thCA+GhwFofONhDoxbuOK05qoAeW4lF/dYyoCxOJ244JbvNsgENFFU
	 6dL7BML6H88b+KGkSmN1SZdpzq6Q0JTeTLy8y+EvLrI/dkbkEWZCjI7oHem+YGH32d
	 eVMh885NQTB1E9uwz+tR1HisCjaTvjmhi7IpJEs+tkvv4b15JruouO0n35ncxEMB/C
	 F4syJ6YOF5dRrEesNZ8/6Tut3BQarM131xpZxBARnD+5Evx2SlTzx6fEwVPFuVMGHw
	 AphrRSJOs0tPg==
From: Kees Cook <kees@kernel.org>
To: Brendan Higgins <brendan.higgins@linux.dev>
Cc: Kees Cook <kees@kernel.org>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] kunit: executor: Remove const from kunit_filter_suites() allocation type
Date: Fri, 25 Apr 2025 23:24:34 -0700
Message-Id: <20250426062433.work.124-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1374; i=kees@kernel.org; h=from:subject:message-id; bh=Qze9nAZSQ1I6xgR9vshAeYnvUlrjmo6wnxtuAdSnIBw=; b=owGbwMvMwCVmps19z/KJym7G02pJDBk8NYqdH866fBBOjrFOOOxgtLOmabNT3WP2Q5Uqgt++H lN7eP9ZRykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwERW7mVkuDNv4cQ3XzaITFh5 8vVH1fSu7sjTLaef7C+cbxRYfZYxuoyRYbbk99ocRvVHTi92yjhPiej68+v85YKnR6Te+uocMX5 3jAkA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In preparation for making the kmalloc family of allocators type aware,
we need to make sure that the returned type from the allocation matches
the type of the variable being assigned. (Before, the allocator would
always return "void *", which can be implicitly cast to any pointer type.)

The assigned type is "struct kunit_suite **" but the returned type will
be "struct kunit_suite * const *". Since it isn't generally possible
to remove the const qualifier, adjust the allocation type to match
the assignment.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>
Cc: <linux-kselftest@vger.kernel.org>
Cc: <kunit-dev@googlegroups.com>
---
 lib/kunit/executor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 3f39955cb0f1..0061d4c7e351 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -177,7 +177,7 @@ kunit_filter_suites(const struct kunit_suite_set *suite_set,
 
 	const size_t max = suite_set->end - suite_set->start;
 
-	copy = kcalloc(max, sizeof(*filtered.start), GFP_KERNEL);
+	copy = kcalloc(max, sizeof(*copy), GFP_KERNEL);
 	if (!copy) { /* won't be able to run anything, return an empty set */
 		return filtered;
 	}
-- 
2.34.1


