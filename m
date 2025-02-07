Return-Path: <linux-kselftest+bounces-26057-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 065D1A2D085
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 23:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1838188B74F
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 22:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECDE1C700A;
	Fri,  7 Feb 2025 22:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuMR6EXQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917141B040E;
	Fri,  7 Feb 2025 22:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738967602; cv=none; b=XLMneL23K4LY8E2tSHyTL9oL7jDXtjWwMhfnE3x9OS7Y7KJ4XQfbVHGyyNeNyZJhz5Y0BcsZ+9ilnhuQP9WPupiphW0C1riAN69iqzJikvv2I6Nc24B5DkckzymlN6hHweNlfbngnyQ/pfouaSPyG6bF36/zSo1p3FJFgQ0XQHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738967602; c=relaxed/simple;
	bh=UXEwGHk9t6xoL2Zx11HGNFD0f9BKdUPAnGtgZukd5E0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TEs2VqcFwLburh3bcUS09HNBOzFAL7hWrnK7wVplpyrS4TVYW6TEv8Cpqp6JKf5IFKJxcTvoHO/tV99AP/7Ms5ATEefOA6i2Ea4bYS84YK0zN9QCC83245Ax31gTIoUYuvaKWwnmQGhhD4cly308aipvn3vaRl2SouTAZuD1RyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HuMR6EXQ; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7be44a90468so300858085a.3;
        Fri, 07 Feb 2025 14:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738967599; x=1739572399; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G1Hjji4oGRD8aiqWAUUlAgK6Xz87zL9E3tVYwiX2KRo=;
        b=HuMR6EXQ1vkUb26rNz2jt2vAu4s+BiCyiWlYtIZXISHRE8IdwoBlo0XTTpKJUDpyA4
         GWoPty0yVE1sNgf4p4sLUgg42T9rXbty3Hs7b79Wq+6IN8K8EW+/n5hEQVHO6Pg3JKY/
         GVdQag3pnT+85hsLoWe32UAa8StYv/zTD0ZyV2Sd2uYn+zzrPLhZr6MasjBh3Q57r6KI
         91zdMGrJgAOORd/ZbOvLw2EKhxVSb3GMT1h5+dYL8QR5wlfILRcEXUBCLdlupnYHZYR7
         q1+6aEH7zmYhE421h2Dvtnz9DzZ7DxEXVc2f4erCztKv9GHgv95JPaAlNGrH0Pu6lMFL
         0vjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738967599; x=1739572399;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G1Hjji4oGRD8aiqWAUUlAgK6Xz87zL9E3tVYwiX2KRo=;
        b=pdtoiA5gdpado63VuCGsY10ciWYLXf4yhxnAiR2unP4FrGexjaCCds6wKtUf8TzjNi
         iPVK64xD9U/sDMvhjKZ9swr0Dj9V5gjF41zhL/AkYFp4Tccf7qc23TjL7wlBNv3RgWjb
         eHbvLQftA3kl9iI4wWnkh1UIOViC7fSFKEBGT5eTE8/l20zFdMuCm83VRoPsqd6JjKLQ
         Hfyzh2xkuUeJvmr2dAJGOzpCd8JN32A8ghsLs/zZIcv8RuL15buEfalPO71l0qBT3qi3
         aVLsNAMbE3c3sPxMuBeTJNvgHIBbhIpoQQza3LgKMXsZwbQKax9Ogcvl/BWKpnsjiCU6
         D27Q==
X-Forwarded-Encrypted: i=1; AJvYcCV/HKyXVeHo988evWoWpdAvOr1zV8LVz+ihO70SFaTJW30und9TIyECfmVf7vayrNUJYR+ALFj9q5SdXSqE6FY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywre6zD1sh2507T5m4gtkwDOlzQNXCLWqal4bLqxduaeKn5+SKX
	c7R8dFg0wo51s2EgWtXR4dgD6G4GdVmQAmsvESX5g2V79sxP+H8hkxL/NzOB
X-Gm-Gg: ASbGnctFMjwDrwYD/6HvJz107pF1xVqEel6U9lKZUNshjusuATFY2VbAV/miIj1YpYt
	Me/JLWqWUYA33Vhs3wMTuKHak+XGzJYDAZReXP+DbutGMPHF/IlqSSvyZs6Ri1Weokir8MxK5+E
	YVw9+Vasw7A5eQYnPqY8g6qqLaPfJPnyZ1qTLLqwI1+mXio1e1rCQk1+/w5hADGa7YKIUl9slG2
	oc2SblkE1NuahLNZRtYU4Ly6ZFAV2jDED2e/EpMxcE6M0J2VK/b8UqNPU+Ju2okbO7bV1njBfdi
	aoqllke11u/DhxOg/kDUDll7+ie4JvQwA+EKIp73HA2JvfJi1w==
X-Google-Smtp-Source: AGHT+IE6NWO5v2tuAnuCla7ZxoglmwU5e290/6g2GLbyr0JrNT9qh+15828Vu5UeKBv4Q16tBsRxpA==
X-Received: by 2002:a05:620a:240e:b0:7b6:dc4f:887c with SMTP id af79cd13be357-7c047c956b6mr627465285a.57.1738967598994;
        Fri, 07 Feb 2025 14:33:18 -0800 (PST)
Received: from Tamirs-MacBook-Pro.local ([2600:4041:5be7:7c00:c58e:ed03:1b60:c56d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041e9f965sm240638085a.86.2025.02.07.14.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 14:33:18 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 07 Feb 2025 17:32:59 -0500
Subject: [PATCH 1/2] lib/math: Hook up tests/Makefile
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-prime_numbers-kunit-convert-v1-1-6067f2b7c713@gmail.com>
References: <20250207-prime_numbers-kunit-convert-v1-0-6067f2b7c713@gmail.com>
In-Reply-To: <20250207-prime_numbers-kunit-convert-v1-0-6067f2b7c713@gmail.com>
To: David Gow <davidgow@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
 Luis Felipe Hernandez <luis.hernandez093@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

This Makefile has been dead code since it was added in commit
7fcc9b53216c ("lib/math: Add int_pow test suite"); the tests worked
because of the duplicated rules in the parent directory's Makefile. Wire
up tests/Makefile and remove the duplication.

Fixes: 7fcc9b53216c ("lib/math: Add int_pow test suite")
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 lib/math/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/math/Makefile b/lib/math/Makefile
index 853f023ae537..d390da9a59fe 100644
--- a/lib/math/Makefile
+++ b/lib/math/Makefile
@@ -5,8 +5,8 @@ obj-$(CONFIG_CORDIC)		+= cordic.o
 obj-$(CONFIG_PRIME_NUMBERS)	+= prime_numbers.o
 obj-$(CONFIG_RATIONAL)		+= rational.o
 
-obj-$(CONFIG_INT_POW_TEST)  += tests/int_pow_kunit.o
 obj-$(CONFIG_TEST_DIV64)	+= test_div64.o
 obj-$(CONFIG_TEST_MULDIV64)	+= test_mul_u64_u64_div_u64.o
 obj-$(CONFIG_RATIONAL_KUNIT_TEST) += rational-test.o
-obj-$(CONFIG_INT_SQRT_KUNIT_TEST) += tests/int_sqrt_kunit.o
\ No newline at end of file
+
+obj-y += tests/

-- 
2.48.1


