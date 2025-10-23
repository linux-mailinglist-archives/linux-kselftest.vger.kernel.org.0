Return-Path: <linux-kselftest+bounces-43839-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 740E1BFED78
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 03:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 529F33A9FFF
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 01:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016FD2253A1;
	Thu, 23 Oct 2025 01:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uezsR/zJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80CA223702;
	Thu, 23 Oct 2025 01:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761182744; cv=none; b=G8we3bFEuByi3vNV6BbQF2aA70XjPNnCKytx1jQbB+RrujKwsYctGrZSwHcNvoQGRKI9nr/B1PzQInbaHy7FiqX3T6oCN0MLKSqSSOKtSQONfIJIvAG2nH8sesVv/20ycSEgWjwMYVLS02SKZVmxxrkQxMSiL4w9mZNPGuH9kow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761182744; c=relaxed/simple;
	bh=RKBfxsBzDKUrYjFTiKbvh8ntTnFoyVwTsTEd+4eRipY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CR18YmiIF1KDYgtONUH8AvrvJRNIgJco9/M0kkNqW8pU37j0YRxuior6MXAFw1NH5f20SFmt6px2pDAGk/+jvcrMPL56pYKp3WPlW4OsYsLC8rqjnk55rX0VQB6Ap54Aff1yuDBLC9br2jNBJZh1n9TYgN1f0wK8mTa2QZAscDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uezsR/zJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D239CC116B1;
	Thu, 23 Oct 2025 01:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761182744;
	bh=RKBfxsBzDKUrYjFTiKbvh8ntTnFoyVwTsTEd+4eRipY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uezsR/zJxoo+BgYu1GbfDfbFJOX02+pWxKCRXgxjhRtIgWFIdTDzahq7STAK6a6Ex
	 rCrmY3omr5ZoSoytdOgy+5pemZYlaOTn9TYlJ5MWCInC6i9a+iSEW5FmDweM4cWmq8
	 eF8lAvypVFdPAQWzr0Fgjoy3uFf4NAHp9k31Z59kaD9CO1/gsAyXVTGUAPkNLGmnAV
	 9U+xiEEjvBqaUy9fYV/hQ7NC/EoqYvW/WUPbHBgMtDU7duCDO3vofznEhm8GBQG8CS
	 ZdhiWEbkBx6au3ai7F53rC3/3HkKNyC7AfU0zLLBoZ0jBZviOiu/Q/5SrWGXHWyllF
	 obXd6bIItSOKQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Bijan Tabatabai <bijan311@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6/9] selftests/damon/_damon_sysfs: support obsolete_target file
Date: Wed, 22 Oct 2025 18:25:30 -0700
Message-ID: <20251023012535.69625-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251023012535.69625-1-sj@kernel.org>
References: <20251023012535.69625-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A DAMON sysfs file, namely obsolete_target, has been newly introduced.
Add a support of that file to _damon_sysfs.py so that DAMON selftests
for the file can be easily written.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/_damon_sysfs.py | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/damon/_damon_sysfs.py b/tools/testing/selftests/damon/_damon_sysfs.py
index a0e6290833fb..748778b563cd 100644
--- a/tools/testing/selftests/damon/_damon_sysfs.py
+++ b/tools/testing/selftests/damon/_damon_sysfs.py
@@ -475,12 +475,14 @@ class Damos:
 
 class DamonTarget:
     pid = None
+    obsolete = None
     # todo: Support target regions if test is made
     idx = None
     context = None
 
-    def __init__(self, pid):
+    def __init__(self, pid, obsolete=False):
         self.pid = pid
+        self.obsolete = obsolete
 
     def sysfs_dir(self):
         return os.path.join(
@@ -491,8 +493,13 @@ class DamonTarget:
                 os.path.join(self.sysfs_dir(), 'regions', 'nr_regions'), '0')
         if err is not None:
             return err
-        return write_file(
+        err = write_file(
                 os.path.join(self.sysfs_dir(), 'pid_target'), self.pid)
+        if err is not None:
+            return err
+        return write_file(
+                os.path.join(self.sysfs_dir(), 'obsolete_target'),
+                'Y' if self.obsolete else 'N')
 
 class IntervalsGoal:
     access_bp = None
-- 
2.47.3

