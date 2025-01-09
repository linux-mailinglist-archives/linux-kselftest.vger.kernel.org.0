Return-Path: <linux-kselftest+bounces-24146-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6300BA07EFD
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 18:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0D6B188D2BE
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 17:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503221B21AA;
	Thu,  9 Jan 2025 17:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="GEjQc+1q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC19A1B0413;
	Thu,  9 Jan 2025 17:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736444387; cv=pass; b=GazoZ2tLz77+DKVaijKvUc0yeGrgJugir6vyGbwAoiCJecBTm1Euyq+7VKVkpR6MT/wuvNBqQUJMNUU62Q4PJG7E61BK5ghQ/FmMFomy+IBub3idQYNx3Tq8INd98vk1HtSXob0gumB1EffBHoYO8Xvs+i+0x94WSB5JR0qInss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736444387; c=relaxed/simple;
	bh=sP6Sa6qhxYUKNVv9NaMzHco1K5r8vMv0z+iDxmHq65M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FTU0mP6ENlIgoJGzfWdu7BDk3XAoRYluaZooyaEKaWBeCoaVCEGgVUvJvi0fclRMbQpvgBDDWfUqIQvplH/eUMk9gJ1uStoHwEtUu2tEUYeIqf0j4D7aXryAbOprKovDqS4hAWNGUdY1aOxlSm2zhW1Yh4qTMcwUqcGv7PJN3j8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=GEjQc+1q; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1736444369; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dQCywtZBGitfnS1qwwMPwcZKKj1fcOvWgFyAjsdIOUuQ9DOn70A4XExTpbEyKFV0pZAi1azdlHzgshbb8nqRu0//uMK6R9lUuwGaBC2v1r0SyFsJ6o3ViD8PRcQWHmnQ3cZIxGf2ItfsRUAIuUBMHiYFj/NGE83JaFszncqB/oo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1736444369; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=whETehW2IwIxAg6V15GnWifjsiCvW0cZ8n4HvvwTvLg=; 
	b=MNomiooTbKPn+WmlCmE0PC/5LcShiCufrWplrB0B2zmThdwfttGHYQyEDzth6gUdpFRYT0mku71g6hpYHBh/J/zBsMsZVcd8U/m1roQ852uGKe5xKJR/rTk5NdmbEX88q4i1Dk8ZievNtgAYv1B9xk7iGtGajUpLQUmYb+0DJU8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736444369;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=whETehW2IwIxAg6V15GnWifjsiCvW0cZ8n4HvvwTvLg=;
	b=GEjQc+1qCZ9XenjwXGHFiWjazc7kB1auWHezfrPEIYwjDhXp5wW3Ivn+jWZ6QIk0
	P30gaB6q2IBWCRR7EmiaIVhjCjeES7UA23DfDNSl3ya6lDaNIFRh3eeiYa/X5oLc+FB
	G3ccisZGB5g9LCi7Mo3gBxLPWq2XFAG9sEMFHsAI=
Received: by mx.zohomail.com with SMTPS id 1736444367800740.2406611122897;
	Thu, 9 Jan 2025 09:39:27 -0800 (PST)
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
Subject: [PATCH 08/16] selftests/mm: guard-pages: Fix type mismatch warnings
Date: Thu,  9 Jan 2025 22:38:34 +0500
Message-Id: <20250109173842.1142376-9-usama.anjum@collabora.com>
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

Fix type mismatch warnings.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/mm/guard-pages.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/guard-pages.c b/tools/testing/selftests/mm/guard-pages.c
index ece37212a8a2e..fc1165ef2015f 100644
--- a/tools/testing/selftests/mm/guard-pages.c
+++ b/tools/testing/selftests/mm/guard-pages.c
@@ -142,7 +142,7 @@ TEST_F(guard_pages, basic)
 	const unsigned long NUM_PAGES = 10;
 	const unsigned long page_size = self->page_size;
 	char *ptr;
-	int i;
+	unsigned int i;
 
 	ptr = mmap(NULL, NUM_PAGES * page_size, PROT_READ | PROT_WRITE,
 		   MAP_PRIVATE | MAP_ANON, -1, 0);
@@ -1044,7 +1044,7 @@ TEST_F(guard_pages, fork_cow)
 	const unsigned long page_size = self->page_size;
 	char *ptr;
 	pid_t pid;
-	int i;
+	unsigned int i;
 
 	/* Map 10 pages. */
 	ptr = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
-- 
2.39.5


