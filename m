Return-Path: <linux-kselftest+bounces-17809-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2FD9766B7
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 12:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 263141C23374
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 10:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EA719F12D;
	Thu, 12 Sep 2024 10:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="angwLnBs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117DB18E043;
	Thu, 12 Sep 2024 10:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726137146; cv=pass; b=DNfuSh2+9+knlgCFmtt/aPeDrk+/TiKihLwmnWspq8PGczt3UDVozWpFiwFBcYio+Y5uPi38NVildybdDhuXEiQzLWseoR9yIbqZp9Rcz6vXrriB17xcA75I6QXUQHRbn+69sRkqSdRNdrJ9Xs/KdxMM+PjsYSThn6PHpJ3DR7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726137146; c=relaxed/simple;
	bh=vmqX2w/Cu707ZQWEALXLDG9u1fWpIVh3jY/q5HFldtI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qTa++LNSYvomZD/mTMsKA11sDAVS8YRDYAVNjTX4kMJbC1eL0nGZjpYDL0A/8qIJeipQJGi+nGK80YfmMzhCZolDP0+nwQW2L0GrUWM46mxYa6yCJplkVcygM7S6CyFKUzMT5CiyQom4UDTMJRZy8tF34ShI+XcJISl2EWvZiQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=angwLnBs; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1726137134; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EZpA+P+Y2FEA4EpO8s45jGgMGI4VOo7iBqY8qWtMuotw+SYcl6ESteJnKy1KWkp0nvCiNKfrhIhbunjPOTkpXKqi8TbeVXn8SrpI6T+b7kbpLoeeQSVUoyDMSROHZeNgyjl2M8Ex24+lJ/0ResBHif7z3ERwJCFun9P/V3cCad0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1726137134; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=KSpDKK1DAsive3QibtWD5FNSGNv2v0elbqHMj3W+HfM=; 
	b=A3qq24RhL4lPUXtV1TX+K2SkSODWeE2zeIN7ewTJYAHYpwOsmQbGQWqTnw4LE3TSN9xq2oZSFufHdn948wN7zNHS0U4MPHjUGbHFHL1vHk1ANPcENAAAJqc4btcRLPnn9omhZuKlox9IQoq7paZEHzm4/bBvfZ3SAy/s9HZmKqI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726137134;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=KSpDKK1DAsive3QibtWD5FNSGNv2v0elbqHMj3W+HfM=;
	b=angwLnBslkPYWhbz4ZUN12nwu+j2uWW0ycMuHhwIzEU9HmKVRYvDymVZ32IXNtBi
	9D45h0c5kjywyTzvO+w38dJCG4n10k38U50MmyfdvcfNUzwieeyQBZShfAXdLoNzjV+
	p8KteobJ9o1T1Z9wM/8aF5uigeXN8J4+HRp94frg=
Received: by mx.zohomail.com with SMTPS id 172613713313932.761884341043356;
	Thu, 12 Sep 2024 03:32:13 -0700 (PDT)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] kselftests: mm: Fail the test if userfaultfd syscall isn't found
Date: Thu, 12 Sep 2024 15:31:51 +0500
Message-Id: <20240912103151.1520254-2-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240912103151.1520254-1-usama.anjum@collabora.com>
References: <20240912103151.1520254-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The userfaultfd is enabled in the config fragment of mm selftest suite.
It must always be present. If it isn't present, we should throw error
and not just skip. This would have helped us catch the test breakage.
Adding this now to catch the future breakages.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/mm/pagemap_ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/pagemap_ioctl.c b/tools/testing/selftests/mm/pagemap_ioctl.c
index bcc73b4e805c6..d83dda8edf62c 100644
--- a/tools/testing/selftests/mm/pagemap_ioctl.c
+++ b/tools/testing/selftests/mm/pagemap_ioctl.c
@@ -95,7 +95,7 @@ int init_uffd(void)
 
 	uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK | UFFD_USER_MODE_ONLY);
 	if (uffd == -1)
-		return uffd;
+		ksft_exit_fail_perror("Userfaultfd syscall failed");
 
 	uffdio_api.api = UFFD_API;
 	uffdio_api.features = UFFD_FEATURE_WP_UNPOPULATED | UFFD_FEATURE_WP_ASYNC |
-- 
2.39.2


