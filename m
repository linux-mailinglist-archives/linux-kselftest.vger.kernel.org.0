Return-Path: <linux-kselftest+bounces-35579-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D80AAE322B
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Jun 2025 23:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E74FF16F2E8
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Jun 2025 21:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E43021ABCB;
	Sun, 22 Jun 2025 21:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SutzdAv5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1291B219A95;
	Sun, 22 Jun 2025 21:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750626217; cv=none; b=hR1ITaLV0jqzek5R8KnUWLSMPplm5Jbya9OihcHHgaubpcEhkgZvqJRn6dEsL9u4hPmxot2ebpUEQv4BL0I1TQxnKdZAXscSSWmqA1tmAT/PE5sS9Y99ZUpfES0XkQt2SK9U188u+fgxJT7xYgW9UmXOBvwJ3W5wYhEoG11QkoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750626217; c=relaxed/simple;
	bh=/RUstGJfkJjRI+Pr6WW5egPsetwstPl+AsaLyBk7JE4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Afy70MDEWkUFEgopKvkoBSL7BP4JUXQMfEs/zhcqLK7mZ1bQFCMmO5CqV8pmDk9DfUgBqW2LNqC0omdHAgVBF2X4qEL9x2ppAPPBQyIXQmG1efTl7SAKALsM9ofk2jwNaPUayAl985f7zCDWKmH3cXibDNIuIPjQLAudF61V3eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SutzdAv5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C050AC4CEF9;
	Sun, 22 Jun 2025 21:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750626216;
	bh=/RUstGJfkJjRI+Pr6WW5egPsetwstPl+AsaLyBk7JE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SutzdAv5FmZPQLzQd5uxJiGRCyX33vYX8YZ6a9jyu9gW6/MSmjfCPZHCgt2dLLuR4
	 NahuqXySvzmk4Ncl4QfHBqqz0F8uCvIX2Bt9xE8KBvmuDrr0NkYfQ5NYE7GfO0oOuS
	 dQeY40T9lZ06fq8ew4Oqsf5xagcKtI4KwVx9KftQB5YSN8dlwtKwFgX7Q1HulkF+BU
	 qKvXBrsMa3jekBKzPi6Oh0+rrOjf3qNx9Bz8uBowfGmMl9F+Wmt1z3XK7rPRsQTFw7
	 NeH6JuyVBQ3o3R/YMuF7wITjp9leHWbMxAROdtmA9xlIhJNjd3JKgqOF2IV0DazRVe
	 x1/XdEJnlr+nQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 2/6] selftests/damon/_damon_sysfs: set Kdamond.pid in start()
Date: Sun, 22 Jun 2025 14:03:26 -0700
Message-Id: <20250622210330.40490-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250622210330.40490-1-sj@kernel.org>
References: <20250622210330.40490-1-sj@kernel.org>
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

