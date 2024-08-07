Return-Path: <linux-kselftest+bounces-14937-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B7794AEFE
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 19:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE32EB22BB0
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 17:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1D713DDCD;
	Wed,  7 Aug 2024 17:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T940ysed"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423D313D53F;
	Wed,  7 Aug 2024 17:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723052081; cv=none; b=i+AQLDto8+9ivkoPm231At5SMuwWR4AeWgIxDKOJop8nOxRoIr4IslCF75nyGe3xd8LKzCrIBcyvf840ItI4cYD9irwGgH29x3gNuwDVGLEz7RhCQ0iOJ5LaXeMdoaI/oRzThZdfNsx8bu09p/AKOF0NMPlR43bFCmP3E+oTj5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723052081; c=relaxed/simple;
	bh=PrxRm/D+gH6hP8WNQ6u//nRouzN6ryRD5SwlsPZ1JAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mPWnFRGyB8jCSQXYW6W56IqIqQbsHgDp7n6fTW+37FG2yGIh4CG046rrXQ56bgvEHFy+hMDgcI5BG4Ooim6A7VBBtNrzGBKkQmIrKxJAAoH8SNITzvxBJQtzEqefMSMmfCIEBT5WcBsW3mV1VY3MjfyEwZtlYV+QcClNpeKDJdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T940ysed; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f035ae1083so510961fa.3;
        Wed, 07 Aug 2024 10:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723052078; x=1723656878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fkbLPlxft252tCcvtQQOAioY0nhUSIetGhYQZRnuOjM=;
        b=T940ysedopRuEfFbaTROs+Haub9qKO0ElkICqA3wvrmKZYeRMrmt24OMRATCtZB3V1
         vxBbAqgSGusaGBixFy8DdrLeglQpa4lJwCIX/RHTRwB5xcLdVMNHGRLaEGKVtdJocngh
         yR8w5x1PCy2HQV8A/xSLq1oQqk55Bmp716vzatWCT6shAnBkqNAA+MuXQK5vY9fX3wsW
         tAXvUftn+L2raRcEGAaJ3Xq5hvn8OLEHMU9k+AqYRljPc3a1SP/tH06LhSnfVLf/MHVE
         4QgGDKFOzp+V5IP5Dpa/WeZ6HOSmiiyb5A/IjGlWXj9IcuueZlEfJ+STsc0ei48o3FbE
         jKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723052078; x=1723656878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fkbLPlxft252tCcvtQQOAioY0nhUSIetGhYQZRnuOjM=;
        b=l0GMnW1k0FhgD7vTmWbvVSSUuJeXLdObybJDix+g7nwHoxTtHAOab2gG7Iij/TIPP9
         GYY1ls2BsQhHb6DUdo1JXYnp6LG4i6gcp+qk5JMjWuytoHag1prmnRBM3j16lfSSGuXf
         r0U61PCqru+WR2SiHQAL0G6qTjeBb8qfQMzPonpxn1hjYq1vWULJ4suN39IQG+8LhUSe
         vGwQCCRn/SsrLTFjquhj9j0IxEuftjiGEZHKtqgJV0oV+qrWzgtY8alc6KLUyutwyUsO
         z5Q+ZDq21/mSsTTTzk/FeAi3muJE8lXI/9fVO3hOwYUDWNhUxut+Rjc/VDTroqyGQBp/
         usHA==
X-Forwarded-Encrypted: i=1; AJvYcCU+emgO82Sd1XAZl+HPxl4ySFa56vInSwcCDFzdYYZh+in6QRWrab4KEGudiFiezP6IN67aKcFtATkGmjCuv7D2azdU9+JMsSDyQOMuaWJ3
X-Gm-Message-State: AOJu0YwmWtLDCPSmJFPhNDr1aZ6vQl8MUvXRBfLqgnQ4KlRf4N1XBIys
	A9hx6rZeKgla3KAEEdr69rIlCqzHvragiDaw6SICA+t0asWw8ZlA
X-Google-Smtp-Source: AGHT+IHIIJqMOzpEvAkMj1C5BnPy4mssOYul/wmg3Y4s/jeLUk3lFc/ZevqzIKcixd25dALAJ8jRxg==
X-Received: by 2002:a05:651c:a0a:b0:2f1:5c89:c875 with SMTP id 38308e7fff4ca-2f15c89ca6amr155201391fa.26.1723052077831;
        Wed, 07 Aug 2024 10:34:37 -0700 (PDT)
Received: from PC-PEDRO-ARCH.lan ([2001:818:e92f:6400:96b:aa92:afc0:2d3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42905801f5bsm40335185e9.29.2024.08.07.10.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 10:34:37 -0700 (PDT)
From: Pedro Falcato <pedro.falcato@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Jeff Xu <jeffxu@chromium.org>,
	Kees Cook <kees@kernel.org>,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Pedro Falcato <pedro.falcato@gmail.com>
Subject: [PATCH 2/2] selftests/mm: Add mseal test for no-discard madvise
Date: Wed,  7 Aug 2024 18:33:36 +0100
Message-ID: <20240807173336.2523757-3-pedro.falcato@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240807173336.2523757-1-pedro.falcato@gmail.com>
References: <20240807173336.2523757-1-pedro.falcato@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an mseal test for madvise() operations that aren't considered
"discard" (e.g purely advisory ops such as MADV_RANDOM).

Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
---
 tools/testing/selftests/mm/mseal_test.c | 34 +++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
index a818f010de4..2dcda7440eb 100644
--- a/tools/testing/selftests/mm/mseal_test.c
+++ b/tools/testing/selftests/mm/mseal_test.c
@@ -1731,6 +1731,38 @@ static void test_seal_discard_ro_anon(bool seal)
 	REPORT_TEST_PASS();
 }
 
+static void test_seal_madvise_nodiscard(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+
+	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
+
+	if (seal) {
+		ret = seal_single_address(ptr, size);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
+
+	/*
+	 * Test a random madvise flag like MADV_RANDOM that does not touch page
+	 * contents (and thus should work for msealed VMAs). RANDOM also happens to
+	 * share bits with other discard-ish flags like REMOVE.
+	 */
+	ret = sys_madvise(ptr, size, MADV_RANDOM);
+	FAIL_TEST_IF_FALSE(!ret);
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
 int main(int argc, char **argv)
 {
 	bool test_seal = seal_support();
@@ -1822,6 +1854,8 @@ int main(int argc, char **argv)
 	test_seal_mremap_move_fixed_zero(true);
 	test_seal_mremap_move_dontunmap_anyaddr(false);
 	test_seal_mremap_move_dontunmap_anyaddr(true);
+	test_seal_madvise_nodiscard(false);
+	test_seal_madvise_nodiscard(true);
 	test_seal_discard_ro_anon(false);
 	test_seal_discard_ro_anon(true);
 	test_seal_discard_ro_anon_on_rw(false);
-- 
2.46.0


