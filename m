Return-Path: <linux-kselftest+bounces-11180-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E958FB254
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 14:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C33C3B2315B
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 12:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA481474B2;
	Tue,  4 Jun 2024 12:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KorNNrwt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0432C146D4D;
	Tue,  4 Jun 2024 12:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504373; cv=none; b=sEilIh24SMWeOxORzk4C3XpI07xfnfhlX7aR/dQOmyjEhImk9u85Qhyz7MhTl1nFRNCETf5/8bkDaYYjei/h1W7WYNbRn15GIJZhi1aKMr8SACKXfdS2cVQZB+4R4KDKMYhzjaiRr5t68nSek6MMYJu1XFzz5kjyr/E+5jmsheg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504373; c=relaxed/simple;
	bh=s5QTEl8avTLCywD+yMrBHIhLbHpxN43v91JE2hPsTQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MIbUzf3wdt0Vdis2MioDOGOkgn+yw8nNV5qgq+4KYwfN98H7+Nlh758MZH7rvUbzxLj83B1hXZyToZzb9I6mN9EKzP8NFL+vpHv/jimOia6GMmqg/s6U63dWaqVb5ei9vgfZK7zJENrixkaj59qhjuAvq91U2pms32tcbCyrvQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KorNNrwt; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52b9a7fb034so177510e87.1;
        Tue, 04 Jun 2024 05:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717504370; x=1718109170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8sMeT1jEzulHyaa1CBMKL3RJvYNB57BjMb6V3pNuGo0=;
        b=KorNNrwtaYwleKlF7EArYCPxAm5z9V33Fiy/j9cp/2RYKFhfuJz2sVFsodsmOdFXPB
         KBC89Sw73smFNeEXdNnGCn/44xZLvJKT/vSCKX7hdgFP7Yc6A5NccXl5yr7/tuGmTAPs
         FNQ9M2DP/9Iuus6eHGWlJ/hCYKwYPSVjG9nh5vdXWRAGHwwm1sgJecjOsb3AHCdX23cD
         j4ZPlZ0O3KGSRbl8ayx0/UVqi38nTrdKl5NZXh62MzCZkyLQosEXpn+wSiZMo8qSOlzw
         6h3U6tpZPbEhsuMleX0ktP/oHEU0b9RUdHq3X0U0vhthpELO7K1K3iYFddeqftzvq/1K
         Rv7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717504370; x=1718109170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8sMeT1jEzulHyaa1CBMKL3RJvYNB57BjMb6V3pNuGo0=;
        b=WHy8Nns2st8UN6Jnt1bfPVS9jYtHBhwLb6f4wEuaFruYvZE1mtVR5B5XihB+jmltrx
         a0+q4zb2GNCyyoaKaeUa460GnXsIBl0r09M0HNjwQvuvlzw23OG3ZN+j3kxNsSSJb/Wl
         ok+Omm3x2qLmcuTiejHsUaNDtcf5olMC1A6fMGv6mcgFM7e+3x6xadCq67yc1SC8m4Xy
         geW2vxflPQRGuPjXPwGnXflLTREL7PZW50Nf9z1vUFpx1Dk/rDIQlshX2qp1fKevJCio
         U55WtYY0gk8Fw6Z/O5VZaExULQ7hveuNy2tyGyIDTPZVeZnliXyPYzPiW2UfG306r1gt
         jigg==
X-Forwarded-Encrypted: i=1; AJvYcCWtZmeNwgZMlUYRHKp7wTVyww1ZZP8Ax8A1yP2ZNU02YrynvKBLXxKUk1pw6OdAaJmbGRR8Bik4gn2lPY16VG99rF+Hq5zv+QCsIKahCuEZ9xPrSFUi5vnJpVHxnExqr/vGfD1c+Rc3TDMGUZ+/
X-Gm-Message-State: AOJu0Yz5D24PF1Lgnd0hKkRLn3OyHtp/YyIDf6g2ITxZCYFgBDgqH9mb
	45VptoWk4xCjHuJn42g7YttP9xg1AOdL8Ve7I28Z26Fupqhp/xdF
X-Google-Smtp-Source: AGHT+IH4MqbZlrE8NuAF05L8iSWfy4SesXmj/SAsMMm0WfWl7qxM76jujmDju423FBfp7/kHx/nb/g==
X-Received: by 2002:a05:6512:3b25:b0:52b:8909:58b1 with SMTP id 2adb3069b0e04-52b89702d1emr10752838e87.3.1717504369804;
        Tue, 04 Jun 2024 05:32:49 -0700 (PDT)
Received: from ivan-HLYL-WXX9.guest.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35e535567e9sm7209179f8f.21.2024.06.04.05.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 05:32:49 -0700 (PDT)
From: Ivan Orlov <ivan.orlov0322@gmail.com>
To: brendan.higgins@linux.dev,
	davidgow@google.com,
	rmoar@google.com
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] kunit: kunit-test: Remove stub for log tests
Date: Tue,  4 Jun 2024 13:32:01 +0100
Message-Id: <20240604123204.10412-3-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240604123204.10412-1-ivan.orlov0322@gmail.com>
References: <20240604123204.10412-1-ivan.orlov0322@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since now we are exporting string-stream functions into the KUnit
namespace, we can safely use them in kunit-test when it is compiled as
a module as well. So, remove the stubs used when kunit-test is compiled
as a module. Import the KUnit namespace in the test.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
 lib/kunit/kunit-test.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index e3412e0ca399..42178d5a97d1 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -577,12 +577,6 @@ static struct kunit_suite kunit_resource_test_suite = {
 	.test_cases = kunit_resource_test_cases,
 };
 
-/*
- * Log tests call string_stream functions, which aren't exported. So only
- * build this code if this test is built-in.
- */
-#if IS_BUILTIN(CONFIG_KUNIT_TEST)
-
 /* This avoids a cast warning if kfree() is passed direct to kunit_add_action(). */
 KUNIT_DEFINE_ACTION_WRAPPER(kfree_wrapper, kfree, const void *);
 
@@ -637,17 +631,6 @@ static void kunit_log_newline_test(struct kunit *test)
 		kunit_skip(test, "only useful when debugfs is enabled");
 	}
 }
-#else
-static void kunit_log_test(struct kunit *test)
-{
-	kunit_skip(test, "Log tests only run when built-in");
-}
-
-static void kunit_log_newline_test(struct kunit *test)
-{
-	kunit_skip(test, "Log tests only run when built-in");
-}
-#endif /* IS_BUILTIN(CONFIG_KUNIT_TEST) */
 
 static struct kunit_case kunit_log_test_cases[] = {
 	KUNIT_CASE(kunit_log_test),
@@ -871,4 +854,5 @@ kunit_test_suites(&kunit_try_catch_test_suite, &kunit_resource_test_suite,
 		  &kunit_current_test_suite, &kunit_device_test_suite,
 		  &kunit_fault_test_suite);
 
+MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING);
 MODULE_LICENSE("GPL v2");
-- 
2.34.1


