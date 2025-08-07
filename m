Return-Path: <linux-kselftest+bounces-38443-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 990C7B1D442
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 10:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5309E3AD4B3
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 08:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D77724A049;
	Thu,  7 Aug 2025 08:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjkQg4AL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793C82222D6
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Aug 2025 08:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754555248; cv=none; b=Ojnc7T2HmBjBDtttozp42STasJOptqc43fPcmMWPB0DbRTfkVTtwpfE0gjlPVrUQmtIr/jbzVDuAzWXhvSZjqnWLUeLIkSftZCCjI4PTPe/oJiNDr/OlYtsivlwRMeYcHCLqjyblG7yCWiqonlfJLfxupjB7SuZ9CQSR9ka5Y1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754555248; c=relaxed/simple;
	bh=r2nKRv2hTeYlPV7IfDCU3gLhsc5QHXLYQPqGEuHjEVQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=RY4UJhKyhxLeRpirjmSQWrAHqbywnuXkUr+B6hLZfJpIBiHGH6Lx5+byD20yYWih5iPlr5QruLWHh88MQy5gWaPl9FRmBphWWsAuq1xW1sMT9IwCPR0b0X/b6WMAo6ZS8p2cgMn1BUODkjZ8jdddtHRHpe6YCqtb6ptiWdcCvWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OjkQg4AL; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-615d1865b2dso1119729a12.0
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Aug 2025 01:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754555245; x=1755160045; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MB5v8JGVoli5uQj8yN6hfSf205U6hZvlHyAPh/SZM5g=;
        b=OjkQg4ALQQBztnX4NEJcJPR0OfYsNY+o1FkTy1BvfVPD+sfgpgbkdppKxDLkhtY0oU
         9bL5rmO+gcrpSxDgYtdolxd4Lp9u6GsN5TWJaoqGCd7PAHLeG24BQln4LvBFqZ5VxiV/
         6aHI72QSYo+AYNSVsfOIQX+Q6qaC9s8hi2DFPfn2bIJxNFvXKMxmBz1VozxWkNHSR4c7
         08UgFtRGg93vl+jLOWsLWz0ynzfNBXd6rl6DxPctsLaG5DXJ24qkJhibIhcRiTBC8NTS
         qljBCMcEXtolinSJxbLzMG9ffvV5tAyjwQambNzGLRKs/Ff3p5596mDut9QfXpDnA25O
         YbQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754555245; x=1755160045;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MB5v8JGVoli5uQj8yN6hfSf205U6hZvlHyAPh/SZM5g=;
        b=JTdCB6pzPuwJ1a+xLhc8BLCm2YY47qJq1qk09Bf4KHNEB3zaH9zPO/MoUuzAYQlb6p
         Uv7mP50ukYoVgWnT9PVJu59KtNWaj0GzM2jpAufPIak9cfSxBo61lM21Y+Lc/lzN0EGK
         Ko2s/rkBMYL3k0PQA2uAVspdwNp4evZBWH9g+XAywdUkFqUQFo9A3PHtUdwhrPeQU9Ne
         cIgWOxyCShnlvkJaEEjYxR8Q+CwpkjQxaBwO2oOUiw9EWYwEKdKzoUAUgiYGOVOhXM2s
         6PEFv0bIfyXY7wPqLFzKKOYhf73eUnHf50y1dlUOpMZIdpcoAguFrM8ztJWctpQUO39v
         6egw==
X-Forwarded-Encrypted: i=1; AJvYcCVREgV5fOVXSLHTDP8YTtPfZLQWGFyekSkK8wCqnzrEBAAZXNXOtbkJQmI3YjTWDrM+wk9jat58BmKjpqXBxW0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0ugOrx4AdR6BZndXZ7XKBJsX/fI6vat8gi9aO1UYNJ6GeCWKH
	d6srCdbbWUGX21c1znOVjMY5c/VuN4FhJivf+9w1AJV3C2eIPnmJkHc8
X-Gm-Gg: ASbGncsfkYdQYAWrihS10l4e/dBYtaUmUEbu3gVj6hKB7IKzIBAMCT1reWNk+C/jTE0
	tZDC0ncTZSmlecUtlclYeXAaBCyl/giSqb4aU6kaHLBq99wm33B0vSzTyBbgDZOT2/2bNcQfjIx
	1S6rQsjiBiomPOkTCjQQeC/UULRyaHFh/KMHUUcdTKKqV27uUQPFz+HP+JguxCmeTLwiVgkURWD
	QD4qEcqQR1VqAuWDQBByyOgxXdUhYNVQvhYvmhSFYz/WDalO6UMLdmobYY+XBqs5aSC2DPKNpEH
	jiVrBTXNX5/E8GjnxhF5ce34u0Cp7bv63hhp6nIIVb1FKKheCmRJgtgj3OmYmdVmlbqXUfx9dvq
	CNzI5+wfiSk3VmvNLDX9Tqw==
X-Google-Smtp-Source: AGHT+IF25yLQAf7eBFUkgjncLAroRpjuNfiRZpFZE+k97LTJ+wCTe/63+BHhnOb7vJno150/ttzAGA==
X-Received: by 2002:a50:c003:0:b0:615:d633:9ffc with SMTP id 4fb4d7f45d1cf-617960d5358mr3434967a12.11.1754555244428;
        Thu, 07 Aug 2025 01:27:24 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8ff9fd1sm11299450a12.44.2025.08.07.01.27.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Aug 2025 01:27:23 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	dev.jain@arm.com
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH] selftests/mm: do check_huge_anon() with a number been passed in
Date: Thu,  7 Aug 2025 08:27:07 +0000
Message-Id: <20250807082707.30647-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

Currently it hard coded the number of hugepage to check for
check_huge_anon(), but we already have the number passed in.

Do the check based on the number of hugepage passed in is more
reasonable.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 tools/testing/selftests/mm/split_huge_page_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index 44a3f8a58806..bf40e6b121ab 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -111,7 +111,7 @@ static void verify_rss_anon_split_huge_page_all_zeroes(char *one_page, int nr_hp
 	unsigned long rss_anon_before, rss_anon_after;
 	size_t i;
 
-	if (!check_huge_anon(one_page, 4, pmd_pagesize))
+	if (!check_huge_anon(one_page, nr_hpages, pmd_pagesize))
 		ksft_exit_fail_msg("No THP is allocated\n");
 
 	rss_anon_before = rss_anon();
-- 
2.34.1


