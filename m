Return-Path: <linux-kselftest+bounces-24144-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E4BA07EF8
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 18:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0139168613
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 17:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598C81990C4;
	Thu,  9 Jan 2025 17:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="XU/sASa1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF07A198E6D;
	Thu,  9 Jan 2025 17:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736444381; cv=pass; b=UZyuSrBo04UAPOOgHiBQqoiRiM77shOXR523y7PoLYle1orwXYY6U4+wumD8PZQfSLMDWiFUT0Vens6bIzxE+kq4wdfeW2KVjCd9Eq/lNa6oxX6oHdK3uHSaoUz9y3WvcJhnstKHgBLQRZm4Jk9nMuGZJNIfET2A97GixcLm2A4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736444381; c=relaxed/simple;
	bh=ZHEGChUaNaul4Y7oapj44ZB7OWiHuHeZ6Wgsjkj8vM0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TM7erUPz+Z03FdEdWBjO4jRVURUmWS3sGY2ks8o2k6rzlRyz+grpoHFp8Ai1bQD45AsPw/LyL8YHWnxrkCZlYf77oQQwje/QsWYT9RaAh51dqlBlP0RTSfXWt02h/WVze0/hoEDTJtdQr7uXyLZHGTtQYEROS15NaCVOd9mkzqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=XU/sASa1; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1736444363; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GcRTWK8stBDDIx3AFdOF3FC0tL59k7NOZ/YfNMyaUnC+X4d5U0tq7M11m6RxtYTSPrhSv542fV1l+RATOAgW1YdlM66s1wlEzlNPeU9ilQxHhLv8Cj9GauCHVHPfV+1gXfj5ua8uGYEShRs+cv3YJ/BeEFvZz0PWCjrgfn10GsU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1736444363; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Ns4Cnzb7SpJKJg+vEktGwwn4CtMu0+tM6En/nkl/o18=; 
	b=HIeETnI+JRyrYG3axVdu04XWKOIIOVK6EAJoXYy+aIiXkvmFm/A8XaFv8u8IKdtCxF+rk0Ws3xmtVPgb7KKLhbuEPfPJxnMLmvXgRN4DWK7BT+Y5zZjc16SX2y+5TfjWJKwRU4icIt0Dir/igpoTRw1rbzenAy39/mDTqdSB+S4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736444363;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=Ns4Cnzb7SpJKJg+vEktGwwn4CtMu0+tM6En/nkl/o18=;
	b=XU/sASa1xATVXTeeB8hh/d7+0vZQ5lAGzXWOEWzpKhC4sNIoFpqSo+akp9eu1Cwq
	A7BHMKJO//06Zd5vbwFFfrPlnC5e7lFSns9uYNJdfyBxtJMwIBerXgc+Idcb1cTvHF2
	wWX9wuwy9o+xj0v/fCN5PPabFf/TJQxsxBFr1jTI=
Received: by mx.zohomail.com with SMTPS id 1736444362474197.40330045642895;
	Thu, 9 Jan 2025 09:39:22 -0800 (PST)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Kees Cook <kees@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com
Subject: [PATCH 07/16] selftests/mm: hmm-tests: Remove always false expressions
Date: Thu,  9 Jan 2025 22:38:33 +0500
Message-Id: <20250109173842.1142376-8-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250109173842.1142376-1-usama.anjum@collabora.com>
References: <20250109173842.1142376-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

As default_hsize is unsigned, it is always greater than equal to zero.
Remove expression which is checking if it is less than 0.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/mm/hmm-tests.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/hmm-tests.c b/tools/testing/selftests/mm/hmm-tests.c
index 141bf63cbe05e..3b4db583bd3b6 100644
--- a/tools/testing/selftests/mm/hmm-tests.c
+++ b/tools/testing/selftests/mm/hmm-tests.c
@@ -796,7 +796,7 @@ TEST_F(hmm, anon_write_hugetlbfs)
 	int ret;
 
 	default_hsize = file_read_ulong("/proc/meminfo", "Hugepagesize:");
-	if (default_hsize < 0 || default_hsize*1024 < default_hsize)
+	if (default_hsize*1024 < default_hsize)
 		SKIP(return, "Huge page size could not be determined");
 	default_hsize = default_hsize*1024; /* KB to B */
 
@@ -1579,7 +1579,7 @@ TEST_F(hmm, compound)
 	/* Skip test if we can't allocate a hugetlbfs page. */
 
 	default_hsize = file_read_ulong("/proc/meminfo", "Hugepagesize:");
-	if (default_hsize < 0 || default_hsize*1024 < default_hsize)
+	if (default_hsize*1024 < default_hsize)
 		SKIP(return, "Huge page size could not be determined");
 	default_hsize = default_hsize*1024; /* KB to B */
 
-- 
2.39.5


