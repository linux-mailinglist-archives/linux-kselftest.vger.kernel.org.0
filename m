Return-Path: <linux-kselftest+bounces-8392-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE29E8AA754
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 05:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A2311C20DC6
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 03:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11A76110;
	Fri, 19 Apr 2024 03:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RTqOmWpq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAE779CC
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Apr 2024 03:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713498265; cv=none; b=N8HBw4ihM9r2AbIITKGXSsAFPGaCdgs1h3A66pYL2r949mRsR20isyK3ev2zl/hDiL7rO0HycfkIfMwubb6duVHi+448KXohmwuilTjC1wVcyGPnl/mw+7EsSN3I1Ndzb+Q+NWitiozJ9sSJmci9bXknLPOcHs9y+QpJK7p5l7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713498265; c=relaxed/simple;
	bh=PzFAn0FDsFZ/Waix+s2XTLkG6xizshPWUsySmZlHicM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mDknd6QzHLWjzmbYcdislOrZtHKIynHFtzEKQl8Uj/DCO3V0HiCZyWUF80CwO4I5Bo7GJJyO1kjanUpixHxhqVO3j1ApKfs1HSaHCfwDqC5GD70nXAqKSRx9qeBBI7uBOu/UZFAZMmJKBhhq1mgXXaCTWHrHoMEclN0+Nvqvin4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RTqOmWpq; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6ed04c91c46so1570628b3a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Apr 2024 20:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713498264; x=1714103064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=moZbXiSrismoe0dQ3ENCTqJyGh8l337mZ0AAq1SChd0=;
        b=RTqOmWpqrqFJjBscBte/UVIsQ9bYOTB8bBfk1YUTEctO4+y7hIs4oQjp/CC4M+DhRd
         RVbKWxfbMpUWGm+2oiEXWLvgEEHpo/1K/SYN2/CyHZkRHgQLiRutdtoMe0xFRoXoOFrq
         dBLS2eWb33hfNHg/sHttv7vX3WjA4SgdiM/UU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713498264; x=1714103064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=moZbXiSrismoe0dQ3ENCTqJyGh8l337mZ0AAq1SChd0=;
        b=GyUHoiQ1+Izyj07+rvczsuELBhK/hvDXf6mNRlDwstESehmS9ZABlnGdbnRSPkLBIa
         8tP2niyH96+6lVNcYhZlEEFKBT/xcR4Y2jhQeJJsA7Z9JsZ33AQujL0ka2hAEa4Fl0lf
         YN5bynKnuat6qpinlCEg374w3SvEjIFBS/iJBxWjUR7dE/31y+iYzD9O3dQ71G41Dkqp
         q5npdfI1k9RNfMkbrAYrba24Zcsot1aR4L7jvo04hdq5Z9ZQUh3n0jcTGjrXneiSehli
         K0w6P0UHfAxMpQqurdyZ5fRjZ+Ak/QnOfEhFUqh9T3FCREsvn7v//jsO9UizZjs+ORMz
         7hSw==
X-Forwarded-Encrypted: i=1; AJvYcCXragz7OmaB3jmFPJvjjQM+Wxlkj06Ed5JfZtmLaYHjlz/8cxJsL7PWp1nHwccYU0ds0dFGHAYgaVDEAeJIfMe1icHT39Vpuv8TloC1xlzB
X-Gm-Message-State: AOJu0YzLYVXlchnk8+jtwGaZuPzWjPTmHD2upMoQlfRh/4qg4FQ7S9Io
	5bhS9bVbBa1M+hQbBDRrMv4GYdr0cFf2Kg76My9vc01lhnBi6oEt5IyTm4aYQw==
X-Google-Smtp-Source: AGHT+IEwoOQNdqCLD4LdZu6poUSfjmANH+wicy6Ftf8vNTai7e22muf6AlpjizQc6iWEXTVlhSYReg==
X-Received: by 2002:a05:6a00:3a14:b0:6ec:ea14:b829 with SMTP id fj20-20020a056a003a1400b006ecea14b829mr984574pfb.28.1713498263657;
        Thu, 18 Apr 2024 20:44:23 -0700 (PDT)
Received: from localhost (15.4.198.104.bc.googleusercontent.com. [104.198.4.15])
        by smtp.gmail.com with UTF8SMTPSA id j14-20020aa78dce000000b006eac9eb84besm2263624pfr.204.2024.04.18.20.44.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 20:44:23 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org
Cc: jeffxu@google.com,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	Jeff Xu <jeffxu@chromium.org>,
	kernel test robot <yujie.liu@intel.com>
Subject: [PATCH 1/1] selftest mm/mseal: fix compile warning
Date: Fri, 19 Apr 2024 03:43:50 +0000
Message-ID: <20240419034350.127838-2-jeffxu@chromium.org>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
In-Reply-To: <20240419034350.127838-1-jeffxu@chromium.org>
References: <20240419034350.127838-1-jeffxu@chromium.org>
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
---
 tools/testing/selftests/mm/mseal_test.c | 3 +--
 tools/testing/selftests/mm/seal_elf.c   | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
index 4a326334726d..35cdae93e580 100644
--- a/tools/testing/selftests/mm/mseal_test.c
+++ b/tools/testing/selftests/mm/mseal_test.c
@@ -79,7 +79,7 @@ static unsigned long get_vma_size(void *addr, int *prot)
 		return 0;
 
 	while (fgets(line, sizeof(line), maps)) {
-		if (sscanf(line, "%lx-%lx %4s", &addr_start, &addr_end, &protstr) == 3) {
+		if (sscanf(line, "%lx-%lx %4s", &addr_start, &addr_end, (char *) &protstr) == 3) {
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
index 7143dc4f1b10..b7e72f9804f8 100644
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
+			&addr_start, &addr_end, (char *)&prot, (char *)&filename) == 4) {
 			if (strlen(filename)) {
 				/*
 				 * seal the mapping if read only.
-- 
2.44.0.769.g3c40516874-goog


