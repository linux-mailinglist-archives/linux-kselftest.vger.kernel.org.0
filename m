Return-Path: <linux-kselftest+bounces-23962-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6961BA0306D
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 20:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F11FD188600B
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 19:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773A51E0496;
	Mon,  6 Jan 2025 19:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzxKP6OC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470981E048C;
	Mon,  6 Jan 2025 19:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736191195; cv=none; b=MV/JCG0OzOe7I/GGQ3K2ScvjYiT9pSFyoufmubXmSoN6ThcurEGnM5z/QtOXIVJ03da9+797r6KfB3kXAZngfRDPtnATHmPvwm7kc3j/iKz6bSUTHKCOF9JIQNrmFkZnH7HjWoGDE9TbQ8qwESPQlObU/5cZXb/uHO1UjhUEt4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736191195; c=relaxed/simple;
	bh=oYXb5ELfdFSBlBTaf0WAv5hcBOQ7eaf8Vl277fIm8X4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k+K6ixiq0tC3G862FhOJEZx88MSrRWTtxX0EQNJdN2G5oLzAJ+i77lKJfFxG9GslLV6f7Q0Lk51n7NhfSfp1S3AFw440E6fsBjld9go2z3yU+VfFhPiIWy8JCbFrEyLUycwsBuAPW5p5ZAAhb3WT4CNBP/W/n+px9JQhVui4vEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lzxKP6OC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE74C4CED2;
	Mon,  6 Jan 2025 19:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736191194;
	bh=oYXb5ELfdFSBlBTaf0WAv5hcBOQ7eaf8Vl277fIm8X4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lzxKP6OC/HFZG9c+oI9PUy3acmh0GsnXsUkRQZ/rHFhB0yyCRx3+xhcFVxxWpTG5h
	 0XAGyldkkEX36Np2apOOk0VRYuyV9y/zjjPJlCbtK7Xetw9Jn2mSRyANa5PihE3wp8
	 bcmie9aNupxlH9o1HQ8uIrdfcB8VPh6BEXCY+r7hzbl0VPXGHQl6rv6QEdptcPpqim
	 A8JXcBrypPBeAlt/e2qNnXgfCqnql+1j8PzUcBH0SSSuC87Y/ELAtATrdc1HZa1ssb
	 QWF+3FbjCBWAMiSGLpgha13sSb2NZakHJdjoBsqII5jE4qXDHgha7Jb5eq6yBdU4s8
	 pw+WgnzsAWgmw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 6/8] kunit: configs: remove configs for DAMON debugfs interface tests
Date: Mon,  6 Jan 2025 11:19:39 -0800
Message-Id: <20250106191941.107070-7-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250106191941.107070-1-sj@kernel.org>
References: <20250106191941.107070-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's time to remove DAMON debugfs interface, which has deprecated long
before in February 2023.  Read the cover letter of this patch series for
more details.

Remove kernel configs for running DAMON debugfs interface kunit tests
from the kunit all_tests configuration, to prevent unnecessary noises
from tests.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/kunit/configs/all_tests.config | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/kunit/configs/all_tests.config b/tools/testing/kunit/configs/all_tests.config
index b3b00269a52a..b0049be00c70 100644
--- a/tools/testing/kunit/configs/all_tests.config
+++ b/tools/testing/kunit/configs/all_tests.config
@@ -38,9 +38,6 @@ CONFIG_IWLWIFI=y
 CONFIG_DAMON=y
 CONFIG_DAMON_VADDR=y
 CONFIG_DAMON_PADDR=y
-CONFIG_DEBUG_FS=y
-CONFIG_DAMON_DBGFS=y
-CONFIG_DAMON_DBGFS_DEPRECATED=y
 
 CONFIG_REGMAP_BUILD=y
 
-- 
2.39.5

