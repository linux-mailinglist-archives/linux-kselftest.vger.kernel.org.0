Return-Path: <linux-kselftest+bounces-16739-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E2996523B
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 23:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 529C9B248CD
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 21:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3981BB6AB;
	Thu, 29 Aug 2024 21:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vdihf0KT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D8D1BB68E
	for <linux-kselftest@vger.kernel.org>; Thu, 29 Aug 2024 21:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724967850; cv=none; b=MWB209R9m+qJhfQw2MmX5RbviopGRZuQJBiAi9LrsP0OSJ/DPy5AmGo0L83lnuNII3ONecYUIPcO0Q51ixJs49lVYxZrbOy/FKIU6axbyG93SrSfmRXZs5IRz1SIKP9U2ZNLIB6VccNRKCnQfCYxJwDogJM329vCh7DRLQFlFO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724967850; c=relaxed/simple;
	bh=j5DIz/FwohbXIbAOYNtL4lsH2nx4Cd5E1K3MEN4JHG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qgana5zPmEj/M4v4IOL0x4T++gE0a4v3hteWQc0GV8T2tbPaxbcsSYdgNImYqHJbldrhS+kGCcgcfnCBevpmTuyzyZwENLH5BMO6ahchanqJYgSvAACW6bkTOzP6BJ4rEIqlcZ3uP4+gUlrLacUAXZJoSJy6J+p1Idiqo6r0GMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Vdihf0KT; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3dd4297af75so70943b6e.0
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Aug 2024 14:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724967848; x=1725572648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pOFHefv5origwTURYhXBdEyQH2l+L4eXRhYcbCi88yk=;
        b=Vdihf0KTL5G8F2ERjwy0ZOXENyZVsW4MVBZXPRWFwiZytZamcKr84ShU4RPD+C/TPe
         6sec6OMT3RTy4zCmCi6tl0iJutZv6NA+jlfk9p/wh2mFRk4IR+P/oQce95LqUaFgBjLW
         fEDsqIdii1lyOuUeqeUFmOml6vZdLL18ctdqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724967848; x=1725572648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pOFHefv5origwTURYhXBdEyQH2l+L4eXRhYcbCi88yk=;
        b=OmfaqGm5KcyRiYPrveptn+6O1S47C02nY24nfv8fEyV+RII/XrtF1gzklVpJxEfufw
         U+YKaskTLwh+UtJHT3DGBM2mEmtMq5AgPw1kjPN1RIeOWsNB6EOvAxxvyWqAubDbC56n
         0eCzP+c6aj17Fii4/zf4tLTmZyyiwnNeqbC4lVYieQ/B3oEGGAURL/AqUkclYuqq5WNQ
         7ibFi1xovd4mpAlIEfnrWXqfsXMHFlueCCx0+6ULHsHyAMJ/Na+9NEDaFQpg3Hz4dzXl
         Rzz+1wp364gMyHpFjYXsg2hzu1bQSz2mkT0MsIUEk8nOUFGJ187rJT3YtCFg8EE7E1Uu
         8/ZQ==
X-Gm-Message-State: AOJu0YzVPMjXGcofr/WdHPDW6xizfRGs7oibZFKSycFdJaCZEU7FKoqW
	oxKQxSsQpr0/rWDF4+PDqbmUvE2mZtStfhJAsm/mHsGPS2QAmBMwYyXMiK1u6Q==
X-Google-Smtp-Source: AGHT+IFyc3ebYhYoxmlTy374CXmH+6Huc2oIlQtKye5oZuLAVTm63hVpSqGBNKx/nJcUYkxMgJL0wg==
X-Received: by 2002:a05:6870:8a26:b0:26f:de62:7d8a with SMTP id 586e51a60fabf-277903bdf4cmr2281204fac.10.1724967848269;
        Thu, 29 Aug 2024 14:44:08 -0700 (PDT)
Received: from localhost (150.12.83.34.bc.googleusercontent.com. [34.83.12.150])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-7d22e771c48sm1709417a12.23.2024.08.29.14.44.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 14:44:07 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org
Cc: linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pedro.falcato@gmail.com,
	willy@infradead.org,
	lorenzo.stoakes@oracle.com,
	broonie@kernel.org,
	vbabka@suse.cz,
	Liam.Howlett@oracle.com,
	rientjes@google.com,
	keescook@chromium.org,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v2 3/4] selftests/mm: mseal_test add more tests for mmap
Date: Thu, 29 Aug 2024 21:43:51 +0000
Message-ID: <20240829214352.963001-4-jeffxu@chromium.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240829214352.963001-1-jeffxu@chromium.org>
References: <20240829214352.963001-1-jeffxu@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Add sealing test to cover mmap for
Expand/shrink across vmas.
Reuse the same address in !MAP_FIXED case.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 tools/testing/selftests/mm/mseal_test.c | 125 +++++++++++++++++++++++-
 1 file changed, 124 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
index ae06c354220d..d83538039e76 100644
--- a/tools/testing/selftests/mm/mseal_test.c
+++ b/tools/testing/selftests/mm/mseal_test.c
@@ -2222,6 +2222,122 @@ static void test_munmap_free_multiple_ranges(bool seal)
 	REPORT_TEST_PASS();
 }
 
+static void test_seal_mmap_expand_seal_middle(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 12 * page_size;
+	int ret;
+	void *ret2;
+	int prot;
+
+	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
+	/* ummap last 4 pages. */
+	ret = sys_munmap(ptr + 8 * page_size, 4 * page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	size = get_vma_size(ptr, &prot);
+	FAIL_TEST_IF_FALSE(size == 8 * page_size);
+	FAIL_TEST_IF_FALSE(prot == 0x4);
+
+	if (seal) {
+		ret = sys_mseal(ptr + 4 * page_size, 4 * page_size);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
+
+	/* use mmap to expand. */
+	ret2 = mmap(ptr, 12 * page_size, PROT_READ,
+			MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	if (seal) {
+		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
+		FAIL_TEST_IF_FALSE(errno == EPERM);
+
+		size = get_vma_size(ptr, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
+
+		size = get_vma_size(ptr + 4 * page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
+	} else
+		FAIL_TEST_IF_FALSE(ret2 == ptr);
+
+	REPORT_TEST_PASS();
+}
+
+static void test_seal_mmap_shrink_seal_middle(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 12 * page_size;
+	int ret;
+	void *ret2;
+	int prot;
+
+	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
+
+	if (seal) {
+		ret = sys_mseal(ptr + 4 * page_size, 4 * page_size);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
+
+	/* use mmap to shrink. */
+	ret2 = mmap(ptr, 7 * page_size, PROT_READ,
+			MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	if (seal) {
+		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
+		FAIL_TEST_IF_FALSE(errno == EPERM);
+
+		size = get_vma_size(ptr, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
+
+		size = get_vma_size(ptr + 4 * page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
+
+		size = get_vma_size(ptr + 4 * page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
+	} else
+		FAIL_TEST_IF_FALSE(ret2 == ptr);
+
+	REPORT_TEST_PASS();
+}
+
+static void test_seal_mmap_reuse_addr(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = page_size;
+	int ret;
+	void *ret2;
+	int prot;
+
+	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
+
+	if (seal) {
+		ret = sys_mseal(ptr, size);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
+
+	/* use mmap to change protection. */
+	ret2 = mmap(ptr, size, PROT_NONE,
+			MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+
+	FAIL_TEST_IF_FALSE(!(ret2 == MAP_FAILED));
+	FAIL_TEST_IF_FALSE(ret2 != ptr);
+
+	size = get_vma_size(ptr, &prot);
+	FAIL_TEST_IF_FALSE(size == page_size);
+	FAIL_TEST_IF_FALSE(prot == 0x4);
+
+	REPORT_TEST_PASS();
+}
+
 int main(int argc, char **argv)
 {
 	bool test_seal = seal_support();
@@ -2243,7 +2359,7 @@ int main(int argc, char **argv)
 	if (!get_vma_size_supported())
 		ksft_exit_skip("get_vma_size not supported\n");
 
-	ksft_set_plan(91);
+	ksft_set_plan(97);
 
 	test_seal_addseal();
 	test_seal_unmapped_start();
@@ -2357,5 +2473,12 @@ int main(int argc, char **argv)
 	test_munmap_free_multiple_ranges(false);
 	test_munmap_free_multiple_ranges(true);
 
+	test_seal_mmap_expand_seal_middle(false);
+	test_seal_mmap_expand_seal_middle(true);
+	test_seal_mmap_shrink_seal_middle(false);
+	test_seal_mmap_shrink_seal_middle(true);
+	test_seal_mmap_reuse_addr(false);
+	test_seal_mmap_reuse_addr(true);
+
 	ksft_finished();
 }
-- 
2.46.0.469.g59c65b2a67-goog


