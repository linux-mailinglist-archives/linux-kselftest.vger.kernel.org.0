Return-Path: <linux-kselftest+bounces-24155-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FA6A07F1C
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 18:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 220E23AA3A1
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 17:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0722054EC;
	Thu,  9 Jan 2025 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="IGHq1TWY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6FF1AA1F6;
	Thu,  9 Jan 2025 17:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736444431; cv=pass; b=UkvmUcdk3omrcLhM9QLhNj/scPT9ypd2C2LeiRRySpTo96cItsWaQ9EwW1tgpqsmcYA6pRRy7sUP+K1a0AqHISqevzL8T1OqacLW4BDcbK/SvyNMIzQHJHW1PLHSKLgtKuLntGwN9F8OLGzZR+c5PuxRuy3sX4JcHlZPsGV0v+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736444431; c=relaxed/simple;
	bh=2Pl7z8Zu6hb69EWu+GAANcb6zW3oiCy8MY8Xswaj5PY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AaG7P0B4vW+6OrY+sngWZZhT16tKLpcJMFeYEZm2gmtg65QNZNJp1R4hjPadP5py/Z6qatfU+X9A5o38AlktWAfNuh7ps5UJN7WFc7DaFTft9s7tUpJVObTMzMga6j/EC2hCamrkmD2QYZri1x8fB8KPL9SfuL+fbXjWw7IWGhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=IGHq1TWY; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1736444414; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PBKPPCDCtFUSbvwEA+dM30ZUlOyg8CGjCb4bNH+l3Z9tj457RqYurRZYPqgFRgFQER9IeW1bXjTI6p+qUkE5tcdh+6ur5L5HD9UVvCPTfQo5lE9q+YFPqEAwAGZraoQo3rlVp2er/Ss425w5Igj+T4JCNkiVdy1t8nG+SxVJook=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1736444414; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xbevEof0duXdPukRg64fWg8r3pNNC6hhoZocH1wOXRU=; 
	b=T8NTH9UVPUu8OimEOPe/GCeUgjKd1VM1wL/zIzSZh7mGKGVbqPm/oN1P7w+vm449XhxwbpOhJo5i7TtdF187f1AwLSEOfu0FpZoTIiLQ1yYN/tYzRpWzSuSxQDg1N9wAg85LWrZJFkX3IToiX5yNY5EC8Z7bgo/BVXJuk0s9oOE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736444414;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=xbevEof0duXdPukRg64fWg8r3pNNC6hhoZocH1wOXRU=;
	b=IGHq1TWYopiUOIH2rYweRqWsO3Le0EKf3rjrw1rcvNjecylNL8KffSRkrTjoMBrU
	XSirTpC4sqxpEaQR7dZWm57+mY7GZ3V5rC6zVpzTJeUm+VV8WU8eHfQH4Na1xUnU2Dv
	dOGbVqRhnTVb7hrTdvxAnIuT6bxw0Oid88fjB8aU=
Received: by mx.zohomail.com with SMTPS id 173644441288525.56642632894159;
	Thu, 9 Jan 2025 09:40:12 -0800 (PST)
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
Subject: [PATCH 16/16] selftests/mm: Makefile: Add the compiler flags
Date: Thu,  9 Jan 2025 22:38:42 +0500
Message-Id: <20250109173842.1142376-17-usama.anjum@collabora.com>
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

Add the compiler flags to catch warnings during development.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/mm/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 63ce39d024bb5..006ed2e8df87e 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -34,6 +34,7 @@ endif
 MAKEFLAGS += --no-builtin-rules
 
 CFLAGS = -Wall -O2 -I $(top_srcdir) $(EXTRA_CFLAGS) $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
+CFLAGS += -Wunreachable-code -Wunused -Wunused-parameter -Wunused-function -Wunused-variable
 LDLIBS = -lrt -lpthread -lm
 
 # Some distributions (such as Ubuntu) configure GCC so that _FORTIFY_SOURCE is
-- 
2.39.5


