Return-Path: <linux-kselftest+bounces-32090-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E06AAA6181
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 18:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 437F07B5D44
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 16:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306952153EA;
	Thu,  1 May 2025 16:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4XogXnw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F571214A9B;
	Thu,  1 May 2025 16:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746117634; cv=none; b=Xt6Wpb3Umhme0W1j4k+C19aXzrg6DQavuMG+Oyafet51vkqw/geA6MT0cpl15SCEWPYjONGiCSKwkvIO7FAsQpGZ5POJ9Z6oea33ZdHzAiC/jMbisqfkbAwSaJUFXE+5P1KhkxpbWK+Q9/rQAlcgf21S1SvVQjlE6/Htx52n1ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746117634; c=relaxed/simple;
	bh=ZLXpMNhjbMhJUyuguYDHAZXGWQC9HHtDncPQGBlHJ/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lYrrI1ZanqQtLSzeqUbvlrZT9TQ/jQ+/9Z+D8ywwZyceh8UzHWBU6S3Q+z4JbIEWBWT7g5+OD6qNMgZbOhDcgA+P3WjkSdqJFlpLWGmv0aTJ5k+dYrXkbsv1kf8meXrBleesKeSSvr4WJHXNoUns/e194BWsnAxqUaFsiqWYCgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4XogXnw; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22c33677183so12862735ad.2;
        Thu, 01 May 2025 09:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746117631; x=1746722431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vgPGTCQFUFW1kU3FlNW3yK7JtTBlo5vps0nfxBSj1K4=;
        b=K4XogXnwMsqfV9MVGYxmuwkX6V11HV3v1tQeN+vcb5n+v5ZNIjPeRCioE/VI5t0aro
         a8i2qRsi6KYyT6qlCS92EG9fWyFyDDT9xYViscH0Aps/l+CIoAH/DV1l3qI5yncQ/gjv
         56d+5xKxMwZE648jpqj4BPvwy6RZES72CE3TG+9W2aAGlZrXD8v3D6eSTmF8qxUnVVd9
         vZiLvtn4odUKPQfJ3qyk/hffAC0RHfrFtDBTK9JuKaJR1/Icd2WKxBauk6dn7H0ef8pX
         2SafFyeKt6zYg6yo51DT9l/pl1Wj2chEVHq7nrKfi7lxeuPxQ0TAeXhvVTol/AY+HOmP
         Vtog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746117631; x=1746722431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vgPGTCQFUFW1kU3FlNW3yK7JtTBlo5vps0nfxBSj1K4=;
        b=Aym6udv8GE2d108v6cpLcvi8xeOu5Lp1yESWKaKj5YVEhoMyD6ww/JTU06Ce99knn0
         SdiphKuSLj38sfN/o2z1TrICsSYfRp4NmOF0tDmhcEtlBODRMNDPBbes+xBmPAoSrzk9
         Qa7k6LIqZO2uaxQlGRURNnbvDdpMoehqA6H91jtNciCcjuPsFlV7A4wkn0xoloJoK9ZM
         3oqLMnIVoQ8RNpLveLcDLRJywqhxeO3K8fB9LrgyjsAeSQRrR4064f+YhfZHetnHfeb3
         Hoklb3uvtg8J6g3/AK6E2FelSEKqQ4VWNI57rXOHrURVuMtiPht+axPKdm4W4txszRzu
         elmw==
X-Forwarded-Encrypted: i=1; AJvYcCUuRFP94617DASu9v2KHsblndlmOpD2OXA9OPTE7RrvxVE1DxHnq7+Yh+A7XsAJEVR3ZXf19WAWFp47v/Y=@vger.kernel.org, AJvYcCW3Zg7dmYRSfPIduv8I8IYlrAiPTkFc9icG0ztSKSn2dR7ggB0rnhM55moo3ZKGri+3GG0rtnajNJFHrDQbUUwO@vger.kernel.org
X-Gm-Message-State: AOJu0YwQVX8plJ0B3cYHJTiG4/2CXYA8XnL9xhW9Wyi3nOMAssOi82pY
	hutq4SuHqegHT09TIOYeqIqzNYBzhj9ou/blIyQPEm/LQgnReQk=
X-Gm-Gg: ASbGncufdcqQ85doPB/NCT81FbWjS7NJFPtDzZXiC51PP2/z88VWS+Z8nWpJHTLyuqh
	SLwGQx7QUoqkEHpvsAa2bHYoxYcbfd892iFRosu0go8sdh5M12ITK1ixa9G8mbxugv/xtE0twFu
	LrMNKFj82WkkibktC3cYAspRu9kWHXe9kZCh33qaIDO2kFrhhsxEYNBcS94eV1G/n45gWr269Rq
	jMZHmXNR+H/HN5Y+HgLW5o1KeEm+Fp8ZBDNwcZ+LG1yQ/2eGaMO7lZc6HNVHDleZJyQTmJmoKDR
	TSXrq1HShUSFFOQqUx8RahoArWwrimIB6GadykKUzx5pIwlTIseQNJgVHihi
X-Google-Smtp-Source: AGHT+IGfA4+30n/veK7qPrC5roeakakzXs1CCl29OolxjuG2a7TLj+Et6zwpS35yrIvta2uRaadkVQ==
X-Received: by 2002:a17:903:11d0:b0:223:53fb:e1dd with SMTP id d9443c01a7336-22e040b014cmr48138075ad.9.1746117630722;
        Thu, 01 May 2025 09:40:30 -0700 (PDT)
Received: from debian.ujwal.com ([223.185.132.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e0bc6e678sm8797525ad.132.2025.05.01.09.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 09:40:30 -0700 (PDT)
From: Ujwal Kundur <ujwal.kundur@gmail.com>
To: akpm@linux-foundation.org,
	peterx@redhat.com,
	shuah@kernel.org
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ujwal Kundur <ujwal.kundur@gmail.com>
Subject: [PATCH 4/4] selftests/mm/uffd: Swap global variables with global test opts
Date: Thu,  1 May 2025 22:08:27 +0530
Message-Id: <20250501163827.2598-5-ujwal.kundur@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250501163827.2598-1-ujwal.kundur@gmail.com>
References: <20250501163827.2598-1-ujwal.kundur@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We use the refactored uffd_global_test_opts instead of global variables
for uffd-wp-mremap tests.

Signed-off-by: Ujwal Kundur <ujwal.kundur@gmail.com>
---
 tools/testing/selftests/mm/uffd-wp-mremap.c | 23 +++++++++++++--------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-wp-mremap.c b/tools/testing/selftests/mm/uffd-wp-mremap.c
index c2ba7d46c7b4..a24f35728ac3 100644
--- a/tools/testing/selftests/mm/uffd-wp-mremap.c
+++ b/tools/testing/selftests/mm/uffd-wp-mremap.c
@@ -157,7 +157,11 @@ static bool range_is_swapped(void *addr, size_t size)
 	return true;
 }
 
-static void test_one_folio(size_t size, bool private, bool swapout, bool hugetlb)
+static void test_one_folio(uffd_global_test_opts_t *gopts,
+						size_t size,
+						bool private,
+						bool swapout,
+						bool hugetlb)
 {
 	struct uffdio_writeprotect wp_prms;
 	uint64_t features = 0;
@@ -181,21 +185,21 @@ static void test_one_folio(size_t size, bool private, bool swapout, bool hugetlb
 	}
 
 	/* Register range for uffd-wp. */
-	if (userfaultfd_open(&features)) {
+	if (userfaultfd_open(gopts, &features)) {
 		if (errno == ENOENT)
 			ksft_test_result_skip("userfaultfd not available\n");
 		else
 			ksft_test_result_fail("userfaultfd_open() failed\n");
 		goto out;
 	}
-	if (uffd_register(uffd, mem, size, false, true, false)) {
+	if (uffd_register(gopts->uffd, mem, size, false, true, false)) {
 		ksft_test_result_fail("uffd_register() failed\n");
 		goto out;
 	}
 	wp_prms.mode = UFFDIO_WRITEPROTECT_MODE_WP;
 	wp_prms.range.start = (uintptr_t)mem;
 	wp_prms.range.len = size;
-	if (ioctl(uffd, UFFDIO_WRITEPROTECT, &wp_prms)) {
+	if (ioctl(gopts->uffd, UFFDIO_WRITEPROTECT, &wp_prms)) {
 		ksft_test_result_fail("ioctl(UFFDIO_WRITEPROTECT) failed\n");
 		goto out;
 	}
@@ -242,9 +246,9 @@ static void test_one_folio(size_t size, bool private, bool swapout, bool hugetlb
 out:
 	if (mem)
 		munmap(mem, size);
-	if (uffd >= 0) {
-		close(uffd);
-		uffd = -1;
+	if (gopts->uffd >= 0) {
+		close(gopts->uffd);
+		gopts->uffd = -1;
 	}
 }
 
@@ -336,6 +340,7 @@ static const struct testcase testcases[] = {
 
 int main(int argc, char **argv)
 {
+	uffd_global_test_opts_t gopts;
 	struct thp_settings settings;
 	int i, j, plan = 0;
 
@@ -367,8 +372,8 @@ int main(int argc, char **argv)
 		const struct testcase *tc = &testcases[i];
 
 		for (j = 0; j < *tc->nr_sizes; j++)
-			test_one_folio(tc->sizes[j], tc->private, tc->swapout,
-				       tc->hugetlb);
+			test_one_folio(&gopts, tc->sizes[j], tc->private,
+					   tc->swapout, tc->hugetlb);
 	}
 
 	/* If THP is supported, restore original THP settings. */
-- 
2.20.1


