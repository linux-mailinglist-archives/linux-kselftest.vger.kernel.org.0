Return-Path: <linux-kselftest+bounces-37629-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDA7B0AFF6
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 14:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC26C3A3C23
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 12:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56365287256;
	Sat, 19 Jul 2025 12:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImLi7oNl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B81267F59;
	Sat, 19 Jul 2025 12:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752928891; cv=none; b=qYeZkIj7CBi87+MfhqQBTlu4wrfxkHZVqCpUMNMCdzFC3X08IOkFQHL+EiavsMZQlV052hWjqOAsQuwb0Ybep64/QaH0b/fT/ERikmN9QRpM197TCwSVGReyLM9vbBT2iz20HwKvAtaNUmxr/8kMzisjTyG1snMwPF74Yup84pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752928891; c=relaxed/simple;
	bh=KW5Nb2ul1JPz4vN9sgjaRvexZHNs3hWo0wZgzfZUqMA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rNHYPSgEo7Jjs8FIZGeQFClenZMAhq7GwRIfmCpXq/aWNVSU+MZ3rj6YeE9uv+mcFDUOTgs7ygkPl0aORbbzSfH2jPrloNkRc4cWAUS/Z/BDtpL+p6YHRac0tgjRgJsV7ZozI9X+AV+fyetlgvENZt6iOIeHHMWnsh7QbEqQB6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImLi7oNl; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2349f096605so33718785ad.3;
        Sat, 19 Jul 2025 05:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752928889; x=1753533689; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/CqM90XvhjX010FVl0D/9KMhn6DiMjTxxZcRfzTTzYA=;
        b=ImLi7oNlmXUGk/IEPJGJ1NaZLGnr+CQGb7VQW8yiHRsWFqFq16Kw0EQBGba4QkZr+Z
         0aWwsH2fojY9eJRCMwgktpsEX3Dw/tONFkg7TDIwMWpJ1uQSo4/Cv2H5H2bQ85tu8ipH
         GSFQiQQfCn1HMKUgB+E7VWj9Nm17TN9NTTmbY1Kchvd1RCAnXnz4PMR1b7hxfifGTu3J
         fNH8s7dArmrmEtyX6QMNVUALktDSNQd0/k9bWnYZG5+saJT792IG+rUuJ1SVsz/u/c8a
         SHoCEYByrSuF0ZtQ8RLZSWBXXa6U3uUe5wumI2Img3Fuc71yhcFJlXHWH6aU1w4Jhl6m
         NR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752928889; x=1753533689;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/CqM90XvhjX010FVl0D/9KMhn6DiMjTxxZcRfzTTzYA=;
        b=nu8nehnZUNvcat9Y+yrb/eKh3IJLfTneI5+1mJOXErtTBeBitsLpL8aA3B7RR5iQ7X
         afP/pvdRz2ygViUpopVYurX8d8xqXnJpnYdyiE4WaS6PstLQPOrbh2dzTLjNB+x6M89o
         l4X1UhEm0usU9s8iBduNB1oF++6+dHx4EgjEzlQw4wYuUyjDN30toF9+Vv8AJ1CKykaT
         qqGkSW0lXdfW+ltezS9G0aJhZ9PQbFK9K+xPiitoKdbtPqXys0YbQEY0bTrdA0XGv0fy
         WtIQ4yLDUEwkgYTcaarOGqpPp1eaPmtfXZKP0cdAWQRw+BltAJ/XnFzAQroYeeRgMR4V
         vpPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtwYT9vXaVApB5Trt2qMXXkspZADdkl9vh6A41UAjZH+eQybHd6tDlH5U5bA1Wj1+cRRSSYd92j+l6qpM=@vger.kernel.org, AJvYcCXZJgnYFjukWdDWMEzL5IY4Csrh8A65jmOC+9gURrNf4rmeaHPGDKlHWg4KAw1BiD6w9agza5vbjfFJ50w554E+@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3K6aR6CKuZJXMEOk3XG7FaITfuwPwDIJBaSTy7zfaZFh4rQkO
	/42pQv9AeB9AyFSZbbQIuvD/uzW0cAWLJUqqGLVaPzPUgwNCat1IAzQF6ujGyyUaYVg=
X-Gm-Gg: ASbGncv+9bZAqW3q4bKM5TFejGtzg8q4FCIWd1pcu2nu1IR89lZ6xuqhlp/c0bAHpsT
	0npk/69MkbmTcgiAiIox76FdGULFMW1Z9xbZvNSj7f2rmEGc9/2F0Y/0WOMSe+mkAUdCqQz7TZB
	/mUWQdTcYgdlMVovxZAvfPmiNtnVKq0rahC5WXWdF502qkb4T3pH1+wzntFKQ1yN2MQHrc3Z6wI
	lv51/Rd5dz/yWUiHxXV7NKQvz9PcjX4PaKjJI3yv5VXfjnNXmOiXoA2FziThCm0RukLo7xtcooH
	FzvtARHwxmAuxNsq2crJ1uvolFDd7P3e32eXwESXIKKxnmad89oeOBNL0tFNmeacgTQoM+YfHtY
	R+rJkV++XMRD/mD1G5fgr
X-Google-Smtp-Source: AGHT+IENpSRIhbHqUIJLT2KJXcxCax3ui0g4fjXI2qT45DYDiQ7DPFM1ya6iAdmOyGauTbCNOkFXWg==
X-Received: by 2002:a17:902:dac9:b0:23d:dd63:2cd9 with SMTP id d9443c01a7336-23e25780c52mr250537885ad.46.1752928888756;
        Sat, 19 Jul 2025 05:41:28 -0700 (PDT)
Received: from [0.0.5.57] ([136.159.213.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6b4b36sm28630285ad.92.2025.07.19.05.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 05:41:28 -0700 (PDT)
From: Abhinav Saxena <xandfury@gmail.com>
Date: Sat, 19 Jul 2025 06:41:24 -0600
Subject: [PATCH RFC 1/3] selftests/landlock: move sandbox_type to common
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250719-landlock_abstractions-v1-1-2c4fd61f8973@gmail.com>
References: <20250719-landlock_abstractions-v1-0-2c4fd61f8973@gmail.com>
In-Reply-To: <20250719-landlock_abstractions-v1-0-2c4fd61f8973@gmail.com>
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abhinav Saxena <xandfury@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752928886; l=1976;
 i=xandfury@gmail.com; s=20250614; h=from:subject:message-id;
 bh=KW5Nb2ul1JPz4vN9sgjaRvexZHNs3hWo0wZgzfZUqMA=;
 b=f4RGMTyzGWNzvsQxwe3W0Y2zPvzVqT1/5L/yTIer1rTAKjJGLA9alteJI6H3FhgrjF+VL7Urv
 SI5L4/IjvEoAPT4XmRXeKQ1A+QtbjwEtJ0MF3749MRHm2drUgVG1D+y
X-Developer-Key: i=xandfury@gmail.com; a=ed25519;
 pk=YN6w7WNet8skqvMWxhG5BlAmtd1SQmo8If6Mofh4k44=

The enum sandbox_type describes three execution modes for Landlock
test tasks:
  - NO_SANDBOX: no Landlock domain
  - SCOPE_SANDBOX: scoped Landlock domain
  - OTHER_SANDBOX: placeholder for future cases

This enum was defined in scoped_multiple_domain_variants.h but is
needed by upcoming cross-domain test variants. Rather than duplicate
the definition, move it to scoped_common.h which is already included
by all scope-related tests.

This is a pure refactor with no functional changes to test binaries.

Signed-off-by: Abhinav Saxena <xandfury@gmail.com>
---
 tools/testing/selftests/landlock/scoped_common.h                   | 7 +++++++
 tools/testing/selftests/landlock/scoped_multiple_domain_variants.h | 7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/landlock/scoped_common.h b/tools/testing/selftests/landlock/scoped_common.h
index a9a912d30c4d..08c7d732650c 100644
--- a/tools/testing/selftests/landlock/scoped_common.h
+++ b/tools/testing/selftests/landlock/scoped_common.h
@@ -9,6 +9,13 @@
 
 #include <sys/types.h>
 
+enum sandbox_type {
+	NO_SANDBOX,
+	SCOPE_SANDBOX,
+	/* Any other type of sandboxing domain */
+	OTHER_SANDBOX,
+};
+
 static void create_scoped_domain(struct __test_metadata *const _metadata,
 				 const __u16 scope)
 {
diff --git a/tools/testing/selftests/landlock/scoped_multiple_domain_variants.h b/tools/testing/selftests/landlock/scoped_multiple_domain_variants.h
index bcd9a83805d0..23022c6ebece 100644
--- a/tools/testing/selftests/landlock/scoped_multiple_domain_variants.h
+++ b/tools/testing/selftests/landlock/scoped_multiple_domain_variants.h
@@ -5,13 +5,6 @@
  * Copyright © 2024 Tahera Fahimi <fahimitahera@gmail.com>
  */
 
-enum sandbox_type {
-	NO_SANDBOX,
-	SCOPE_SANDBOX,
-	/* Any other type of sandboxing domain */
-	OTHER_SANDBOX,
-};
-
 /* clang-format on */
 FIXTURE_VARIANT(scoped_vs_unscoped)
 {

-- 
2.43.0


