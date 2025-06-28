Return-Path: <linux-kselftest+bounces-36061-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC94EAEC878
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 18:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 097683ABC7E
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 16:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB00F24DD0E;
	Sat, 28 Jun 2025 16:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AL3CjV8R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC6224A046;
	Sat, 28 Jun 2025 16:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751126674; cv=none; b=tevsHdau7IvmTmZ/Q7XjQ1k6rO8tEpUl0KYWeRjE8vB+XoZk7uBFs5tShFeWdQUSnbNNGekcGujMKNf4S4EZzVoZRWRUOPm981Dg7FppGCNaILuc09caSCnYug2x60vhXCzTMLjBJVqqiSMuTiE93rWXCwio1efa4YoqFjhbHEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751126674; c=relaxed/simple;
	bh=/RUstGJfkJjRI+Pr6WW5egPsetwstPl+AsaLyBk7JE4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o5S7z9Spk5Z60uL2MFB9fqO21IJz5/zdIub9ADyppnwJGIZF3KDMwc2fZqQD56q0ZUCEOkaO8NjS2xmMkDe5c4wVB6pAe3I+NvIQ16VxrJoiJu4mqcadVcgmNi4FDpGt8u/19jTv7g/V2fM9Yg9gLDz6qnRLxJqyB+M8NfqmvEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AL3CjV8R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B039C4CEF0;
	Sat, 28 Jun 2025 16:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751126674;
	bh=/RUstGJfkJjRI+Pr6WW5egPsetwstPl+AsaLyBk7JE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AL3CjV8RIxzxWxM0CBi6GhgIMqaf9qt6luLN0tmydUTgFd+kG6t/FoisMMGa+eE/7
	 sT34yBMVuQTiXpRS7fxFl6+/bzgfvu3Xp4VcdlVWLUM00qeumc63oD3hbfNntsc6tA
	 uxPFbiM/CqYQHJNsuH6CX1SWnn2ilDD3htKqZFui/qo7Qnm/LQqIjR+XPqLBEUaTfX
	 zHUHKT4zKiJs45m1KEvgkG24rlK5H3yI8hkbM/ZSd7ZP64/uNDuj3HHvGNzlVmzBsA
	 2enrh9+qZoK2oNklSK1BRvbaHgH9d2kvsjfI6ON0/mMvOzjB+l3sj8DfFX8WNfqbGK
	 XNW4o+oz7ABVQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/6] selftests/damon/_damon_sysfs: set Kdamond.pid in start()
Date: Sat, 28 Jun 2025 09:04:24 -0700
Message-Id: <20250628160428.53115-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250628160428.53115-1-sj@kernel.org>
References: <20250628160428.53115-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

_damon_sysfs.py is a Python module for reading and writing DAMON sysfs
for testing.  It is not reading resulting kdamond pids.  Read and update
those when starting kdamonds.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/_damon_sysfs.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/damon/_damon_sysfs.py b/tools/testing/selftests/damon/_damon_sysfs.py
index 5b1cb6b3ce4e..f587e117472e 100644
--- a/tools/testing/selftests/damon/_damon_sysfs.py
+++ b/tools/testing/selftests/damon/_damon_sysfs.py
@@ -408,6 +408,9 @@ class Kdamond:
             if err is not None:
                 return err
         err = write_file(os.path.join(self.sysfs_dir(), 'state'), 'on')
+        if err is not None:
+            return err
+        self.pid, err = read_file(os.path.join(self.sysfs_dir(), 'pid'))
         return err
 
     def stop(self):
-- 
2.39.5

