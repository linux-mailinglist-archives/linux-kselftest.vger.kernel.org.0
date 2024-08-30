Return-Path: <linux-kselftest+bounces-16840-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE46C96689D
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 20:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 595121F2471A
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 18:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B1D1BC07B;
	Fri, 30 Aug 2024 18:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TcvTW5Ns"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AB11BBBF4
	for <linux-kselftest@vger.kernel.org>; Fri, 30 Aug 2024 18:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725040965; cv=none; b=F3u2P0wKIIu9AVyJhO0+Zxfz10VVCZP++PvtzLpYYrp7T+j3PCG2k8dwOhftIqYBRKoLCn172tef69t2/ATrevzlAIhho/7K1E/8VzGtqUgVg5JVRvzc2snglq/NVpjlgpfPNOiqTnv02fTlGEhf7XmiJVlUGm8DOBnqG0K6pBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725040965; c=relaxed/simple;
	bh=43bJiScg9S0+2a59vw6ENrMPRMP4sp01lRmumuKJSQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OIfY30aSy9DsDS67yda9sXYh1LMSIza3X+fqjJgRTl+Rb3EWBz0UfwHPaZ4Gr531vmrtMy8grcAJKxSMEg6jnadFwdxykfY21YV6JqK947el9qLEoKraPPMZRNmDmqHXiBd6wUatO0u+srg7hwegHadJih5rsXq4Hxfn3NJTD7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TcvTW5Ns; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7143a0ce91cso203512b3a.2
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Aug 2024 11:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725040964; x=1725645764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O/lLriAP27R5nHPgsK9ypk/521J0I4x/lWwi5ADQ+zA=;
        b=TcvTW5NszHJoTNak4uL+xbjNopz2etxhfKDqVOftECGQhPV52SNaThSXfbAox+h0g4
         SP6luZW91W9BSkjDsf8f45OHZULi7pu8SNBkIbFaPVt2acOW4hVrQca0I4+uYZQ4e0dg
         UDZTMCHHD3LPQ/tuSmmSogz2OhCZ1O0e6+IKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725040964; x=1725645764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O/lLriAP27R5nHPgsK9ypk/521J0I4x/lWwi5ADQ+zA=;
        b=ob3ZXTcji+tA8/ML5+FOF2iLRBGkqfn9j/55/8bRgBE8WeSUAXJiS1k8D0fAPvH9MH
         dYxNU5l3QBHvLoWwi1pFPrMbjLLZABL7JZeL2EWjt4/eaZdtJoDx7CzapTnb3sK0kd8k
         SA8H/kgcE8++3nM+IDXJpTrlHaMI6f4VTE73kOis8D4XmnTDo/ANWj2n/yr46ONoo2Zp
         sWOQet0dp29Up8rUY+9/nbgo8y/7eYn0MBU+tH/uUh3KBtfX4sms2XX1KYZU0DxR7u2j
         Xx9p8aJBz4yJOJZzNfK2KxUo3unsU3mj9q17Qr6qD2ZiQSJehJNVTBriXKS4e2IIh26d
         IepQ==
X-Gm-Message-State: AOJu0Yw1O2CuvnWK7KXyBKS1cxjAP+wuBD+AZj4nUt4cqt3i8aIfaPzS
	mSmJVAupocwvSKb6NPWE0Sv+D85sa0XgZQK2CPy2E9ZIaa8lEgx1LtMP2CyGOQ==
X-Google-Smtp-Source: AGHT+IF7ss5vHuxDy95Wgb4WUGPyZvgp4tHfy8UO1MWvFABXKWvo/BydPzQQ6FPcavBSzZ5iLhUHAQ==
X-Received: by 2002:a05:6a00:3e0a:b0:710:5243:4161 with SMTP id d2e1a72fcca58-7173078b724mr1724291b3a.5.1725040963782;
        Fri, 30 Aug 2024 11:02:43 -0700 (PDT)
Received: from localhost (150.12.83.34.bc.googleusercontent.com. [34.83.12.150])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-715e575d087sm3037827b3a.207.2024.08.30.11.02.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 11:02:42 -0700 (PDT)
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
Subject: [PATCH v3 2/5] selftests/mseal: add sealed madvise type
Date: Fri, 30 Aug 2024 18:02:34 +0000
Message-ID: <20240830180237.1220027-3-jeffxu@chromium.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240830180237.1220027-1-jeffxu@chromium.org>
References: <20240830180237.1220027-1-jeffxu@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Add a testcase to cover all sealed madvise type.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 tools/testing/selftests/mm/mseal_test.c | 30 ++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
index 7198f2314f9b..6d77dc9b5442 100644
--- a/tools/testing/selftests/mm/mseal_test.c
+++ b/tools/testing/selftests/mm/mseal_test.c
@@ -2121,6 +2121,32 @@ static void test_seal_madvise_nodiscard(bool seal)
 	REPORT_TEST_PASS();
 }
 
+static void test_seal_discard_madvise_advice(void)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+	int sealed_advice[] = {MADV_FREE, MADV_DONTNEED,
+		MADV_DONTNEED_LOCKED, MADV_REMOVE,
+		MADV_DONTFORK, MADV_WIPEONFORK};
+	int size_sealed_advice = sizeof(sealed_advice) / sizeof(int);
+
+	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
+
+	ret = seal_single_address(ptr, size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	for (int i = 0; i < size_sealed_advice; i++) {
+		ret = sys_madvise(ptr, size, sealed_advice[i]);
+		FAIL_TEST_IF_FALSE(ret < 0);
+		FAIL_TEST_IF_FALSE(errno == EPERM);
+	}
+
+	REPORT_TEST_PASS();
+}
+
 int main(int argc, char **argv)
 {
 	bool test_seal = seal_support();
@@ -2142,7 +2168,7 @@ int main(int argc, char **argv)
 	if (!get_vma_size_supported())
 		ksft_exit_skip("get_vma_size not supported\n");
 
-	ksft_set_plan(88);
+	ksft_set_plan(89);
 
 	test_seal_addseal();
 	test_seal_unmapped_start();
@@ -2251,5 +2277,7 @@ int main(int argc, char **argv)
 	test_seal_discard_ro_anon_on_pkey(false);
 	test_seal_discard_ro_anon_on_pkey(true);
 
+	test_seal_discard_madvise_advice();
+
 	ksft_finished();
 }
-- 
2.46.0.469.g59c65b2a67-goog


