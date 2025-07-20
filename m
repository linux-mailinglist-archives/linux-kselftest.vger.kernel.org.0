Return-Path: <linux-kselftest+bounces-37695-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A141B0B726
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 19:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EA6E3BD50D
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 17:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9779822D781;
	Sun, 20 Jul 2025 17:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3zPFu8u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E51822B8D0;
	Sun, 20 Jul 2025 17:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753031825; cv=none; b=K03h87fwhJV3z9vpdUVlJHkiGIRzDtEZfVq6/6ZM4vehez2KRMxjca76cHgovvpCjg70KC08qxU8sBp4+cK9WYIPTntksPxPbkqmF/GoPjeziiv8twNiF5+SVC/dQYMsFs7EgJJQ2uNp4purJY/z4VdscqIe1hG0fpko8CedUtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753031825; c=relaxed/simple;
	bh=Au9qdbaf1y862mEtrhaeMOCqkg6S44qyZ+dQYN9tIfI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jFaIONvgmhb7KCAKUXxz2BT/cByomG/GpkS9u6LiD39fj+CNAucgCF37tvHtoGqX7HfbFYpx8jnQCSCBiCEwNa0lURQEcCSjqyyMajL0v7GX5jsKEDzr3MP+WIeXnpWOkNmZB2pXG0+bxQAtQ34ba2axzyvVVVOxBJbxay7bV2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3zPFu8u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A348C4CEE7;
	Sun, 20 Jul 2025 17:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753031825;
	bh=Au9qdbaf1y862mEtrhaeMOCqkg6S44qyZ+dQYN9tIfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R3zPFu8uQHYONdsQRuFMY2bzF2HqjUx2ddSPUQaX0iCJ3QEGXirC+s7lDwEtAWYWq
	 1qsHJTDzb22o97QHdQorzmJufZT4qZImqLaf95aFGkAM5YaEAl1b2Rn15XSExkpyWP
	 VhW0zbdq0KbWru2vo0EsIoBS8SJrIpfzPqihdlkNbHWA9vPseeahmSl1ln0/5uwsKr
	 482WVCHeSBt3IBDTwFgF5VNXUaLai4hsFnU3OQsqgLzL58y6yoah/t76m7AUIZaEtA
	 oLKgs4KMZdmbN6trm252gOD8xGUUGlIr1CM+hptnikjK4qvQV98F83i4PLX8Hvzo4e
	 U/y+c3lIsmDIA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 08/22] selftests/damon/_damon_sysfs: use 2**32 - 1 as max nr_accesses and age
Date: Sun, 20 Jul 2025 10:16:38 -0700
Message-Id: <20250720171652.92309-9-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250720171652.92309-1-sj@kernel.org>
References: <20250720171652.92309-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nr_accesses and age are unsigned int.  Use the proper max value.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/_damon_sysfs.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/damon/_damon_sysfs.py b/tools/testing/selftests/damon/_damon_sysfs.py
index 70860d925503..a0e6290833fb 100644
--- a/tools/testing/selftests/damon/_damon_sysfs.py
+++ b/tools/testing/selftests/damon/_damon_sysfs.py
@@ -52,9 +52,9 @@ class DamosAccessPattern:
         if self.size is None:
             self.size = [0, 2**64 - 1]
         if self.nr_accesses is None:
-            self.nr_accesses = [0, 2**64 - 1]
+            self.nr_accesses = [0, 2**32 - 1]
         if self.age is None:
-            self.age = [0, 2**64 - 1]
+            self.age = [0, 2**32 - 1]
 
     def sysfs_dir(self):
         return os.path.join(self.scheme.sysfs_dir(), 'access_pattern')
-- 
2.39.5

