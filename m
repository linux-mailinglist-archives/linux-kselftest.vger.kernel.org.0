Return-Path: <linux-kselftest+bounces-19910-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0479A189C
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 04:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F4F41C25A2C
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 02:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A248487BF;
	Thu, 17 Oct 2024 02:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QyBabcJl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF5834CF5
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2024 02:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729131994; cv=none; b=J2DIDdRWyERUFO0RjNdPSmXd3oY/wlvseYgeVF9LJMSRTAQLPkAZEOn7uvqdpsMPsenbUSjbOX/hI4rqBBYNQQYLGzOe6TE0Ff9vwdJBd8lhM5tujuJcrLpzMPLxoYNquE/vqvdoDsR0IOHu7d/RbYfbBzjW+CATllNXb+tbyHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729131994; c=relaxed/simple;
	bh=8I4WqVW9h0oo1wKFnIe5Zs1p9kcN+bU5Oifz/60G8e4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CfZD0Tl3Fuo3noHVefb3cq+KqrwtTxmYAnCUIVBn7sx+wmtO9nE4GiTq37VRVFda6Q4WU6zAdh8P2osOLq6O4dE+DY9jQ7oxDVu3+XYO6+e0/kE5HQTHKptBIR+hSobChBTixUP//8okOhD2tev/mLCRwC6c5w7o+6vRL1dZ630=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QyBabcJl; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7c3d8105646so46002a12.2
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 19:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729131991; x=1729736791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9RN8JQgiITrQj6lHgprvd2MNM/V86U6nLKZivNfuyP0=;
        b=QyBabcJlYHLbRFuHyuScXpLH3azyIc4eososVqk75Gl+/BN1AdvmSqny7UD70gBzGn
         Q9M1DWQsDbig28U+F4qsrq89e9y3FVKH+AKkXF8/kzGayfbsQ1K9gV+kLofLYFtUq6vj
         mF4OsEXPvGL2Hy/y/KceJ3XQYiXj/0jJ3jDD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729131991; x=1729736791;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9RN8JQgiITrQj6lHgprvd2MNM/V86U6nLKZivNfuyP0=;
        b=hbUmXHSwK8ELuDUJ/o89EKB7IJvv/99t+j6jcA93fiIUNr/BBjbujVp+HsCICSy2OR
         cAoYYTCix0Abt5lSHVoJbcgX6V1w6gJAyx/xF5M3WgQTytPeC6HLtPxiNPZFZgCnOlrE
         AYnhuXfk3zbgMsCo+gUSZ8lo4zdRV2JiOJj32ho/2OPQZH5EkEefIuKm7G436N0UcYvI
         GiRpYmZmdGrQkljGL9kiWU6mvkHHJ35tdhOPwGsriTTDsxN/S9ithnMfay+4IJ9poKmH
         8QwELljIioLXY2Mf0lg+Viy6ml3w5xcbYszcewX31NhPxvwyR6I5h2u3BViUIh808dxX
         oAfw==
X-Forwarded-Encrypted: i=1; AJvYcCVsi0CfIQd1EmOLzYwdWYrA4QfyCvPS+HgSd8nMw6+kNPU01NTSBs6dEo4g3YFc2VPKzD7qL5CzGOLUaTL4OGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFytOuEIClHaXH97EkG6aUt8ncmq4A9/dr5xLC1xwtyyWgg6GB
	jysRgHVVVvLTQuBHxKa3GZTqU51oEpQMRqL3WA8xv0bPDyccIolwtyoQaI+hSQ==
X-Google-Smtp-Source: AGHT+IHwzw6bEAHzD80log/xY9cbw81AdrYOnN6MnrGumBq7RqUgylPY4QxMSEBQbIgjN2nq1fXnjw==
X-Received: by 2002:a17:902:c454:b0:20d:345a:965b with SMTP id d9443c01a7336-20d345a9a5fmr22565015ad.7.1729131990866;
        Wed, 16 Oct 2024 19:26:30 -0700 (PDT)
Received: from localhost (56.4.82.34.bc.googleusercontent.com. [34.82.4.56])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-20d18036714sm34755975ad.152.2024.10.16.19.26.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 19:26:30 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	torvalds@linux-foundation.org,
	usama.anjum@collabora.com,
	corbet@lwn.net,
	Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com
Cc: jeffxu@google.com,
	jorgelo@chromium.org,
	groeck@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	jannh@google.com,
	sroettger@google.com,
	pedro.falcato@gmail.com,
	linux-hardening@vger.kernel.org,
	willy@infradead.org,
	gregkh@linuxfoundation.org,
	deraadt@openbsd.org,
	surenb@google.com,
	merimus@google.com,
	rdunlap@infradead.org
Subject: [PATCH] munmap sealed memory cause memory to split (bug)
Date: Thu, 17 Oct 2024 02:26:27 +0000
Message-ID: <20241017022627.3112811-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@google.com>

It appears there is a regression on the latest mm,
when munmap sealed memory, it can cause unexpected VMA split.
E.g. repro use this test.
---
 tools/testing/selftests/mm/mseal_test.c | 76 +++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
index fa74dbe4a684..0af33e13b606 100644
--- a/tools/testing/selftests/mm/mseal_test.c
+++ b/tools/testing/selftests/mm/mseal_test.c
@@ -1969,6 +1969,79 @@ static void test_madvise_filebacked_was_writable(bool seal)
 	REPORT_TEST_PASS();
 }
 
+static void test_munmap_free_multiple_ranges_with_split(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 12 * page_size;
+	int ret;
+	int prot;
+
+	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
+
+	/* seal the middle 4 page */
+	if (seal) {
+		ret = sys_mseal(ptr + 4 * page_size, 4 * page_size);
+		FAIL_TEST_IF_FALSE(!ret);
+
+		size = get_vma_size(ptr, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 4);
+
+		size = get_vma_size(ptr +  4 * page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 4);
+
+		size = get_vma_size(ptr +  8 * page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 4);
+	}
+
+	/* munmap 4  pages from the third page */
+	ret = sys_munmap(ptr + 2 * page_size, 4 * page_size);
+	if (seal) {
+		FAIL_TEST_IF_FALSE(ret);
+		FAIL_TEST_IF_FALSE(errno == EPERM);
+
+		size = get_vma_size(ptr, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 4);
+
+		size = get_vma_size(ptr +  4 * page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 4);
+
+		size = get_vma_size(ptr +  8 * page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 4);
+	} else
+		FAIL_TEST_IF_FALSE(!ret);
+
+	/* munmap 4 pages from the sealed page */
+	ret = sys_munmap(ptr + 6 * page_size, 4 * page_size);
+	if (seal) {
+		FAIL_TEST_IF_FALSE(ret);
+		FAIL_TEST_IF_FALSE(errno == EPERM);
+
+		size = get_vma_size(ptr + 4 * page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 4);
+
+		size = get_vma_size(ptr +  4 * page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 4);
+
+		size = get_vma_size(ptr +  8 * page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 4);
+	} else
+		FAIL_TEST_IF_FALSE(!ret);
+
+	REPORT_TEST_PASS();
+}
+
+
 int main(int argc, char **argv)
 {
 	bool test_seal = seal_support();
@@ -2099,5 +2172,8 @@ int main(int argc, char **argv)
 	test_madvise_filebacked_was_writable(false);
 	test_madvise_filebacked_was_writable(true);
 
+	test_munmap_free_multiple_ranges_with_split(false);
+	test_munmap_free_multiple_ranges_with_split(true);
+
 	ksft_finished();
 }
-- 
2.47.0.rc1.288.g06298d1525-goog


