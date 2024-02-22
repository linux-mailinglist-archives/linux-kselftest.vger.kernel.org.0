Return-Path: <linux-kselftest+bounces-5260-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5722885F06F
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 05:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E32851F229A7
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 04:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A4715BB;
	Thu, 22 Feb 2024 04:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0JoAUak"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8166A382;
	Thu, 22 Feb 2024 04:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708576297; cv=none; b=ajzOzz1z407IVGV0Da7zPGRZeN80IAR53DGDmhjNWNgaWvakOos7AAJYhO4qw/rftndJOxr5l86Mg4WXyOx7aZtU0JizREfL1tTare/hS9XwAMOZ2E5VjUSG2qJUalQULcj/dGZpctJYMphabA0q72XwFxuoRD7dfTZCZeXnXmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708576297; c=relaxed/simple;
	bh=TcxyxtMCbWKsSZiCUDElieO84b/6DAH0dX5gHM8ttJw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PpBzJiJEZOjgjx6R0OCXzBIOeRZI/PNtQhSKAEEpvBjxmyX+QBieDP+ncDOSunybBE6B+UKfAuu7yLQ9r4IfWGazD831flFus84oqVdjcabLI1PX4Gt2b0bG15h5gw3BpbWDgSf14I0rV9Y4ivHuouKJzMPhULcLf1sydfLawKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0JoAUak; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dc1ff3ba1aso20445315ad.3;
        Wed, 21 Feb 2024 20:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708576296; x=1709181096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1qe6sezPW9Q3wTsxfWJprqeu8KJLsVxqYQYWx727S4g=;
        b=E0JoAUakPUxqeHintqW/EHQWOLTDkdIDdcf3iCScb5k4OAGX9d/ZPRIRcs+1+OBnqs
         UrgaspMrfPt407lz+mLhI8O9pZm1yyOLqm3exAs9ZTRrhGZP4eRSMfwKo5EZxVATH362
         /QmGXj36IZP/MqPqwtCcqB8OSQqQHbs+fkJB/M6xmvNm0H+uIZ+71NLJoig+esj+Ig1F
         bI30fkTeAe94Yu4QcxRcnWSEnHq+jNDfwGttpVzWEuiV7lO94yJ6hLp5Uy9eJn9BX06A
         2IhMUXcH5mZXNe0MGjq6U5wngBs0bpXbtRIMAG5gKt1xixcvm32/Id7hY0gzk8IdCtdf
         O9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708576296; x=1709181096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1qe6sezPW9Q3wTsxfWJprqeu8KJLsVxqYQYWx727S4g=;
        b=wu/RgrQ1BqLTXbSVUXcD0ybt1rXApm9TJrPGBc09rbpCTumRO3REG6Q8iyC/F+XxXg
         zKKXe15fx9D7q+8rj6nhbRzbkiYRoF3biiEyYRvEPEBv1lGYfxEhBMovRW9XITXA6Gsm
         08B/hvh3Oo0u1qBmoSsdVyw439MHJM2O1LVOmmNEe8/c+aJ8mQ9nZ9Z0nEhgQGgMEKw7
         BxcI86ky6fvJ6/PMyM90McN+bD0Dy/fmT1TsanFQt5naiDosJ4OzY0y/47Rrg+VcdnJl
         tNczc3SY7mjn3c3c9GyHr0JJb+Su0EA0XMDxw07OvstF2JudNPe5lvbIIrUzgdt8NOId
         3etg==
X-Forwarded-Encrypted: i=1; AJvYcCX1PcegUacOu2G4U/DVB3i5oLAmm5MecVfupYB0mcxm08F/DQJhUqeeY5IxM+Wayxx/sid/bP53+/RwiBe/drYpECPP32DaKV0Z64pIQfB20xmaAn5PDevXpJeqA3/KXbgVdk6lRFaANaYO7QqQioOklMrIUfJHroqi6yl8hlN+mvq12WCV0g==
X-Gm-Message-State: AOJu0YxEnOouD8+PkXaND97RRm70cMP/IEeXp376VCCC/8cmGq8eWhUq
	zO+9eSIQHWEe7rdu8Tgzcxf1poh+Yig2G98VK9AWNdSHKwMw/KG/
X-Google-Smtp-Source: AGHT+IFvwhrdrl0JmcZYiX3fu1qeJSYVF8Ug338hF3xvhP1lnZXSpsbvYZMu3w6zkcy1H5hqE3qsWw==
X-Received: by 2002:a17:902:6b82:b0:1d9:edf5:c858 with SMTP id p2-20020a1709026b8200b001d9edf5c858mr17146757plk.52.1708576295686;
        Wed, 21 Feb 2024 20:31:35 -0800 (PST)
Received: from localhost ([113.22.93.93])
        by smtp.gmail.com with ESMTPSA id s4-20020a17090330c400b001db9cb62f7bsm8947356plc.153.2024.02.21.20.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 20:31:35 -0800 (PST)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: riel@surriel.com,
	shuah@kernel.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	tj@kernel.org,
	lizefan.x@bytedance.com,
	roman.gushchin@linux.dev,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 3/3] selftests: add zswapin and no zswap tests (fix)
Date: Wed, 21 Feb 2024 20:31:32 -0800
Message-Id: <20240222043132.616320-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240205225608.3083251-4-nphamcs@gmail.com>
References: <20240205225608.3083251-4-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove redundant "set up" comment and add check to ensure enough data is
swapped out (in swapin test) and zswapped-in.

Suggested-by: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 tools/testing/selftests/cgroup/test_zswap.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/selftests/cgroup/test_zswap.c
index c263610a4a60..f0e488ed90d8 100644
--- a/tools/testing/selftests/cgroup/test_zswap.c
+++ b/tools/testing/selftests/cgroup/test_zswap.c
@@ -71,7 +71,7 @@ static int allocate_and_read_bytes(const char *cgroup, void *arg)
 	for (int i = 0; i < size; i += 4095)
 		mem[i] = 'a';

-	/* go through the allocated memory to (z)swap in and out pages */
+	/* Go through the allocated memory to (z)swap in and out pages */
 	for (int i = 0; i < size; i += 4095) {
 		if (mem[i] != 'a')
 			ret = -1;
@@ -184,8 +184,8 @@ static int test_swapin_nozswap(const char *root)
 		goto out;
 	}

-	if (swap_peak == 0) {
-		ksft_print_msg("pages should be swapped out\n");
+	if (swap_peak < MB(24)) {
+		ksft_print_msg("at least 24MB of memory should be swapped out\n");
 		goto out;
 	}

@@ -215,7 +215,6 @@ static int test_zswapin(const char *root)
 	char *test_group;
 	long zswpin;

-	/* Set up */
 	test_group = cg_name(root, "zswapin_test");
 	if (!test_group)
 		goto out;
@@ -236,8 +235,8 @@ static int test_zswapin(const char *root)
 		goto out;
 	}

-	if (zswpin == 0) {
-		ksft_print_msg("zswpin should not be 0\n");
+	if (zswpin < MB(24) / PAGE_SIZE) {
+		ksft_print_msg("at least 24MB should be brought back from zswap\n");
 		goto out;
 	}

@@ -260,7 +259,6 @@ static int test_no_invasive_cgroup_shrink(const char *root)
 	size_t control_allocation_size = MB(10);
 	char *control_allocation, *wb_group = NULL, *control_group = NULL;

-	/* Set up */
 	wb_group = setup_test_group_1M(root, "per_memcg_wb_test1");
 	if (!wb_group)
 		return KSFT_FAIL;

base-commit: 9d193b36872d153e02e80c26203de4ee15127b58
--
2.40.1

