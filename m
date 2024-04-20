Return-Path: <linux-kselftest+bounces-8513-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 759328AB824
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 02:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C4171F2165F
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 00:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8D638B;
	Sat, 20 Apr 2024 00:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nCD3xqH+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3264633
	for <linux-kselftest@vger.kernel.org>; Sat, 20 Apr 2024 00:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713573330; cv=none; b=UzOyXADZheJfvuOG1kth//GiO+x3b80L3bvlVW9VPjeIR/mQDF235jWInoz+7yL4lNYYsenSBIy7yLX0lJ3R+U5tRob9IyyioyVuLozGa7iQ6yG0mXCgiECDQv8lICKKYV0JRHbgzfhog6n4baCcO+rUqV5YVm3tsSGCGWMysYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713573330; c=relaxed/simple;
	bh=FIm2iJrCiENzWfFF+/D8Na+dgf6FRxGxFTu4mXiyHdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G0ftgSfnfXHboxMUyCgpdbnEOYel6auBwjWcZwfDDrGkxujiTV5ZsDILi2J6heG9HIk2LKBV7SYE29ZyHIhCP+XoBv+2EOPwgBNvLuz30zYJvOuCQ7xSRs+tTzKiwLiOpvs8+xoVzizbAX0jDwvibZmEAVqxVinMJZZ3bg7AwjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nCD3xqH+; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5dca1efad59so1880971a12.2
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Apr 2024 17:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713573328; x=1714178128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rSZUBk+dbCuBhbQEFLeD5/VPzrbTWdtNRtfBg+KonAw=;
        b=nCD3xqH+z7aUf3DqOeReBV+Wr2vadh8+AeWmv6nGWsrIyEotCvW2Xop/bw2SXwXkzF
         AJmWXiZoqGGt1qF9cm+72VVQxr5+xO5rpN0cbqGIhkQY/p4oHZi1SxQYmb+vqfS8noQR
         FWPA21b2IfKPnhOXTAlOY8umXCCLlf9l/AS44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713573328; x=1714178128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rSZUBk+dbCuBhbQEFLeD5/VPzrbTWdtNRtfBg+KonAw=;
        b=P3yztnoz5LOHkHigOuYTzrKWpgG45HnkhoBbb/yNIDfmeiZphfu5SMxhEj/dj6FwQ4
         YqrzFNQw8Jn4bbh2DIE6QJjNVru1IdsK8uw7z1kuR3+9dK+6g8tVH2XxpzH0ykPOJKO9
         ACEJUyvOi3nk+/biVKhVqKaJyjea4sBBE4a9T+vLnLwP4oSy9WCN35iP2gpTgZ6o1c09
         5t+d1aV/rLfHUwDq7iLgFGFDgVagnEoHJB9LFlmBYfLMvgbbr8gaPnjuVswsmc28GoJ/
         W1XAj96aDVuacpr4nCCtRN2+0dcAUccSniDoG5aSxYhZb3407OmJvwxYgzzyqLAi2woJ
         hAqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHHUgXePOpuY95RwTLHlCAYRiklyRCWlyCw0ZvtMfe2BrSE8l53bFGf2SwwXNeVqp/1I4xGEZyYvL7yjp3C50/e9KI90AgcgRQtSCTUbZh
X-Gm-Message-State: AOJu0Yx89ZbAaSdlY5LQOmMtlI67CDLLxvQDrogRt6V+k4DPrtZMGKEj
	HFd4ejum7NXUq9a/cOGrT6Xp1M1ezACt7CSMGJgAg+kdJPjy9ZHSX5EximqP/w==
X-Google-Smtp-Source: AGHT+IHAnWaldXLkr5TP+r9/gYF60huLiq5MwiOnjV0Lg+sR9Vqt5NIyvRmASZIUPid9B00gjHBAIQ==
X-Received: by 2002:a05:6a21:168b:b0:1ac:423b:7c7a with SMTP id np11-20020a056a21168b00b001ac423b7c7amr4351613pzb.21.1713573328072;
        Fri, 19 Apr 2024 17:35:28 -0700 (PDT)
Received: from localhost (15.4.198.104.bc.googleusercontent.com. [104.198.4.15])
        by smtp.gmail.com with UTF8SMTPSA id e15-20020a62aa0f000000b006ece85910edsm3838926pff.152.2024.04.19.17.35.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 17:35:27 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	pedro.falcato@gmail.com,
	usama.anjum@collabora.com
Cc: jeffxu@google.com,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	Jeff Xu <jeffxu@chromium.org>,
	kernel test robot <yujie.liu@intel.com>
Subject: [PATCH v2 1/1] selftest mm/mseal: fix compile warning
Date: Sat, 20 Apr 2024 00:35:15 +0000
Message-ID: <20240420003515.345982-2-jeffxu@chromium.org>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
In-Reply-To: <20240420003515.345982-1-jeffxu@chromium.org>
References: <20240420003515.345982-1-jeffxu@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

fix compile warning reported by test robot

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
Reported-by: kernel test robot <yujie.liu@intel.com>
Closes: https://lore.kernel.org/r/202404190226.OfJOewV8-lkp@intel.com/
Suggested-by: Pedro Falcato <pedro.falcato@gmail.com>
---
 tools/testing/selftests/mm/mseal_test.c | 3 +--
 tools/testing/selftests/mm/seal_elf.c   | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
index 4a326334726d..ca8dbee0c612 100644
--- a/tools/testing/selftests/mm/mseal_test.c
+++ b/tools/testing/selftests/mm/mseal_test.c
@@ -79,7 +79,7 @@ static unsigned long get_vma_size(void *addr, int *prot)
 		return 0;
 
 	while (fgets(line, sizeof(line), maps)) {
-		if (sscanf(line, "%lx-%lx %4s", &addr_start, &addr_end, &protstr) == 3) {
+		if (sscanf(line, "%lx-%lx %4s", &addr_start, &addr_end, protstr) == 3) {
 			if (addr_start == (uintptr_t) addr) {
 				size = addr_end - addr_start;
 				if (protstr[0] == 'r')
@@ -208,7 +208,6 @@ static u64 set_pkey_bits(u64 reg, int pkey, u64 flags)
 
 static void set_pkey(int pkey, unsigned long pkey_value)
 {
-	unsigned long mask = (PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE);
 	u64 new_pkey_reg;
 
 	new_pkey_reg = set_pkey_bits(__read_pkey_reg(), pkey, pkey_value);
diff --git a/tools/testing/selftests/mm/seal_elf.c b/tools/testing/selftests/mm/seal_elf.c
index 7143dc4f1b10..48a9b12f99de 100644
--- a/tools/testing/selftests/mm/seal_elf.c
+++ b/tools/testing/selftests/mm/seal_elf.c
@@ -105,7 +105,6 @@ static void test_seal_elf(void)
 	int ret;
 	FILE *maps;
 	char line[512];
-	int size = 0;
 	uintptr_t  addr_start, addr_end;
 	char prot[5];
 	char filename[256];
@@ -136,7 +135,7 @@ static void test_seal_elf(void)
 	 */
 	while (fgets(line, sizeof(line), maps)) {
 		if (sscanf(line, "%lx-%lx %4s %*x %*x:%*x %*u %255[^\n]",
-			&addr_start, &addr_end, &prot, &filename) == 4) {
+			&addr_start, &addr_end, prot, filename) == 4) {
 			if (strlen(filename)) {
 				/*
 				 * seal the mapping if read only.
-- 
2.44.0.769.g3c40516874-goog


