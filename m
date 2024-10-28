Return-Path: <linux-kselftest+bounces-20875-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A37659B3E78
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 00:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15EFB2835BA
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 23:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B44201001;
	Mon, 28 Oct 2024 23:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qxwS+Q8p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CB9200CA6;
	Mon, 28 Oct 2024 23:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730158271; cv=none; b=agqM0lpQ7zDhkEB/SceU38ClW34ayse/daQQfQCKPpmrJopoY4yaSvsy8WGryntnxKzbUawtc6XtkVWA34Z1pX5pMkpQ2eLHXNTB56T8X7ebj0zpU4Yjh3JO0mxRl8TZkiVC7nDJq4oQ1tI/nplrU2scsYmQ69hspK3WBU1VYss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730158271; c=relaxed/simple;
	bh=SlHvDphEAy4awEmwSNRWCo+v7tVbgoHm+S7EddVhM8A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X4aOF/y7P61JZULALLwk2BZsgmPadio++KNci5AnI85gHIyBmLgb5woH1Pz3twsqXw78Q8SXAx0vtFSd/IuGhuXLGIwsGcQ7+W9xZ7xAHrdVheOQY1TSLBhYR3MCy/DSSVSij/uXHvIDLY3qKc9hHR/Gyxf/uzIdZTu7pt2sCLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qxwS+Q8p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4E6C4CEE7;
	Mon, 28 Oct 2024 23:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730158271;
	bh=SlHvDphEAy4awEmwSNRWCo+v7tVbgoHm+S7EddVhM8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qxwS+Q8pmd+EYvpeVmCCR+TKdaMXzXDJMb3D5yUmekm8IKdyHe7kh5nwzljScU7D1
	 J4Xb2hVbWrJn0hnZmw1GSWp9SRkvqjwMCSoNjtqtH+qHlJQRfMV8r884RAGKUIDLXO
	 ioD+vStofbYdL2pEuiMzOcjuHPLF8DOmnR3e/uEIqALom7LrOp3o+H8jDEGJJn6z8h
	 08SKZfH4EwsT8HRzEX6T5Ms0jDrsDbSwzmoRBJNJ4GptWDglY8LfjB9rcwPkRdp/32
	 L1mQ+Mrxxq2tVhO6LuvN9p+8g9VecLGAOg7pujKDjgB+ZI7PccBd1lReJdLkB+Xu24
	 l67WbyVEiPFxw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] mm/damon/tests/dbgfs-kunit: fix the header double inclusion guarding ifdef comment
Date: Mon, 28 Oct 2024 16:30:58 -0700
Message-Id: <20241028233058.283381-7-sj@kernel.org>
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

Closing part of double inclusion guarding macro for dbgfs-kunit.h was
copy-pasted from somewhere (maybe before the initial mainline merge of
DAMON), and not properly updated.  Fix it.

Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/tests/dbgfs-kunit.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/tests/dbgfs-kunit.h b/mm/damon/tests/dbgfs-kunit.h
index d2ecfcc8db86..087e53f641a8 100644
--- a/mm/damon/tests/dbgfs-kunit.h
+++ b/mm/damon/tests/dbgfs-kunit.h
@@ -168,6 +168,6 @@ static struct kunit_suite damon_test_suite = {
 };
 kunit_test_suite(damon_test_suite);
 
-#endif /* _DAMON_TEST_H */
+#endif /* _DAMON_DBGFS_TEST_H */
 
 #endif	/* CONFIG_DAMON_KUNIT_TEST */
-- 
2.39.5


