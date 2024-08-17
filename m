Return-Path: <linux-kselftest+bounces-15578-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A92955427
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Aug 2024 02:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 899351F22627
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Aug 2024 00:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E211D1CD25;
	Sat, 17 Aug 2024 00:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFdy8g5u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17078EEDB;
	Sat, 17 Aug 2024 00:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723853936; cv=none; b=M+S5/6L5CyCt4GKeDIOmlQoK5tXWrkt4NYy2e0fwD/TSd7wCnfZdVZNo93sDyEguxEY+7kSZdKkBEYb5DR7GFeDWnsosdZzzcCQ/In2W/XjxKZvwHeo40s4OkmPTb8xbj6gHLNuH34BIsWZhoLvpnPUbLzADmeeqcSVY8gsjU64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723853936; c=relaxed/simple;
	bh=RDAgmQdD7RbbuFFDsahGWPQRcFjak0eGFpbBcaph2tE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=grHfHpIu7dxQeeBHvVqleyTZpUILWqHURwwHmMzNDSGXSzvDJF6FrbH89cmdLd0hvmjiNODSQq/al3GDHjMCR45djAdT8Tb5uY6vOmP50Xnz3vvA5qC732r1gh4v0KdiXujcnRk8Uop+9IvRq8Q9NgYqs/PV0qtiaYkWxsmAVLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lFdy8g5u; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-428163f7635so19745035e9.2;
        Fri, 16 Aug 2024 17:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723853928; x=1724458728; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3BNTUbl7+nCW9RPTsVIAgPqk6kKkrw4lo+pgAchkUc4=;
        b=lFdy8g5uLY/KeZmlZume6CRPzYa/9ryYvJ5nf5WXqdpQFHnXpzs7Ry+w58VLNw91IM
         J9MB99VzkJmC/h0iJK43R9AUF40knHP1upSnFL08OcGaGr9MIylVoA030BQxB6nHq6fD
         HOGF7E3hRCM/IkuKVN8utjv+5ooPxMG1VF3jkT8SPM69lwdYBMty51mMBKiA4YpB6ddC
         NHIpHhjQklDYcSnh3GFjRAKUAE9jk8qYgIFtRauvjhfK5Go5O4mY+nVxQZ4XgWiQ8ADZ
         pRBYQRS3Lq+/Q5mythB8+mLpYV3kpmd2h7L58pNWvDR5hAflNZOh4GbR08LlERSzdkBz
         yQ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723853928; x=1724458728;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3BNTUbl7+nCW9RPTsVIAgPqk6kKkrw4lo+pgAchkUc4=;
        b=h52LsxlCDqJNNAc3yDzd8X/U53KFeVj9MPG3CzxUmmF85QQuGtCvgDWdrEzj9LbAq9
         3ceTNIWcKqL2Qxr481ArrfV2joE1UT6sviwhYTQJnTD6HCEYxTld5wMXF5+LZvCeXgH8
         MvH+dArdcfjO7SJfwtfzX4+jdSUf3mi7E5fPwP/wOprSyP3KUBRCTOsCeDXhYhqi4lSt
         0zlqljaLLHw0tVxhEBl36oVXljl9hs5tm9Wm3Azpuw0/UWYBnVG/15k9TTo6HGZj2Az+
         1/+8XLXof2F51ACOei2+c0dlXn1TExFqM5bDB3rEd1rDexE5131JUS/RjbrkoQUfsqaI
         8Ixw==
X-Forwarded-Encrypted: i=1; AJvYcCVfnQ15sSlQI6b7SrHFgeRhg6dWCBOPSGbLiSfVD79F81vZKtW0XPI3N8XZ4JHSLmBcHGOpKFrSxTFfoKoAjd9F1607V7aEYa7gjwi9SBJKpMM0jfxHOc8gcNMy9hegEP3XH6ELUKQZ9WqKtQ7g
X-Gm-Message-State: AOJu0YwZ6e/d5pYH+eN7hwznnB/8BcC/suL8A32MZZagnWZqlmlTb7mw
	OU/W9OvH/qBcFNyNPPRd3NefPLLO5HvOTSa7rDH2LDB/WoGFI63lWUbz93re
X-Google-Smtp-Source: AGHT+IFIhkDMqUt+pj5IYnY7Cri9JLM7/ke3nV3b+/GsdZDIlIl1wzdvrsc5f4Owwa72QzEPcfRwGQ==
X-Received: by 2002:a05:600c:45ca:b0:426:5ddf:fd22 with SMTP id 5b1f17b1804b1-429ed78572bmr30664255e9.6.1723853927337;
        Fri, 16 Aug 2024 17:18:47 -0700 (PDT)
Received: from [192.168.1.91] ([2001:818:e92f:6400:96b:aa92:afc0:2d3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429d781047asm104842055e9.0.2024.08.16.17.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 17:18:46 -0700 (PDT)
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Sat, 17 Aug 2024 01:18:34 +0100
Subject: [PATCH v3 7/7] selftests/mm: add more mseal traversal tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240817-mseal-depessimize-v3-7-d8d2e037df30@gmail.com>
References: <20240817-mseal-depessimize-v3-0-d8d2e037df30@gmail.com>
In-Reply-To: <20240817-mseal-depessimize-v3-0-d8d2e037df30@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, jeffxu@chromium.org, oliver.sang@intel.com, 
 torvalds@linux-foundation.org, Michael Ellerman <mpe@ellerman.id.au>, 
 Kees Cook <kees@kernel.org>, Pedro Falcato <pedro.falcato@gmail.com>
X-Mailer: b4 0.14.1

Add more mseal traversal tests across VMAs, where we could possibly
screw up sealing checks. These test more across-vma traversal for
mprotect, munmap and madvise. Particularly, we test for the case where a
regular VMA is followed by a sealed VMA.

Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
---
 tools/testing/selftests/mm/mseal_test.c | 111 +++++++++++++++++++++++++++++++-
 1 file changed, 110 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
index 259bef4945e9..0d4d40fb0f88 100644
--- a/tools/testing/selftests/mm/mseal_test.c
+++ b/tools/testing/selftests/mm/mseal_test.c
@@ -766,6 +766,42 @@ static void test_seal_mprotect_partial_mprotect(bool seal)
 	REPORT_TEST_PASS();
 }
 
+static void test_seal_mprotect_partial_mprotect_tail(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 2 * page_size;
+	int ret;
+	int prot;
+
+	/*
+	 * Check if a partial mseal (that results in two vmas) works correctly.
+	 * It might mprotect the first, but it'll never touch the second (msealed) vma.
+	 */
+
+	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
+
+	if (seal) {
+		ret = sys_mseal(ptr + page_size, size);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
+
+	ret = sys_mprotect(ptr, size, PROT_EXEC);
+	if (seal)
+		FAIL_TEST_IF_FALSE(ret < 0);
+	else
+		FAIL_TEST_IF_FALSE(!ret);
+
+	if (seal) {
+		FAIL_TEST_IF_FALSE(get_vma_size(ptr + page_size, &prot) > 0);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
+	}
+
+	REPORT_TEST_PASS();
+}
+
+
 static void test_seal_mprotect_two_vma_with_gap(bool seal)
 {
 	void *ptr;
@@ -983,6 +1019,41 @@ static void test_seal_munmap_vma_with_gap(bool seal)
 	REPORT_TEST_PASS();
 }
 
+static void test_seal_munmap_partial_across_vmas(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 2 * page_size;
+	int ret;
+	int prot;
+
+	/*
+	 * Check if a partial mseal (that results in two vmas) works correctly.
+	 * It might unmap the first, but it'll never unmap the second (msealed) vma.
+	 */
+
+	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
+
+	if (seal) {
+		ret = sys_mseal(ptr + page_size, size);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
+
+	ret = sys_munmap(ptr, size);
+	if (seal)
+		FAIL_TEST_IF_FALSE(ret < 0);
+	else
+		FAIL_TEST_IF_FALSE(!ret);
+
+	if (seal) {
+		FAIL_TEST_IF_FALSE(get_vma_size(ptr + page_size, &prot) > 0);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
+	}
+
+	REPORT_TEST_PASS();
+}
+
 static void test_munmap_start_freed(bool seal)
 {
 	void *ptr;
@@ -1735,6 +1806,37 @@ static void test_seal_discard_ro_anon(bool seal)
 	REPORT_TEST_PASS();
 }
 
+static void test_seal_discard_across_vmas(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 2 * page_size;
+	int ret;
+
+	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
+
+	if (seal) {
+		ret = seal_single_address(ptr + page_size, page_size);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
+
+	ret = sys_madvise(ptr, size, MADV_DONTNEED);
+	if (seal)
+		FAIL_TEST_IF_FALSE(ret < 0);
+	else
+		FAIL_TEST_IF_FALSE(!ret);
+
+	ret = sys_munmap(ptr, size);
+	if (seal)
+		FAIL_TEST_IF_FALSE(ret < 0);
+	else
+		FAIL_TEST_IF_FALSE(!ret);
+
+	REPORT_TEST_PASS();
+}
+
+
 static void test_seal_madvise_nodiscard(bool seal)
 {
 	void *ptr;
@@ -1779,7 +1881,7 @@ int main(int argc, char **argv)
 	if (!pkey_supported())
 		ksft_print_msg("PKEY not supported\n");
 
-	ksft_set_plan(82);
+	ksft_set_plan(88);
 
 	test_seal_addseal();
 	test_seal_unmapped_start();
@@ -1825,12 +1927,17 @@ int main(int argc, char **argv)
 	test_seal_mprotect_split(false);
 	test_seal_mprotect_split(true);
 
+	test_seal_mprotect_partial_mprotect_tail(false);
+	test_seal_mprotect_partial_mprotect_tail(true);
+
 	test_seal_munmap(false);
 	test_seal_munmap(true);
 	test_seal_munmap_two_vma(false);
 	test_seal_munmap_two_vma(true);
 	test_seal_munmap_vma_with_gap(false);
 	test_seal_munmap_vma_with_gap(true);
+	test_seal_munmap_partial_across_vmas(false);
+	test_seal_munmap_partial_across_vmas(true);
 
 	test_munmap_start_freed(false);
 	test_munmap_start_freed(true);
@@ -1862,6 +1969,8 @@ int main(int argc, char **argv)
 	test_seal_madvise_nodiscard(true);
 	test_seal_discard_ro_anon(false);
 	test_seal_discard_ro_anon(true);
+	test_seal_discard_across_vmas(false);
+	test_seal_discard_across_vmas(true);
 	test_seal_discard_ro_anon_on_rw(false);
 	test_seal_discard_ro_anon_on_rw(true);
 	test_seal_discard_ro_anon_on_shared(false);

-- 
2.46.0


