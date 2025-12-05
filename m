Return-Path: <linux-kselftest+bounces-47119-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 76094CA8822
	for <lists+linux-kselftest@lfdr.de>; Fri, 05 Dec 2025 18:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A1B6A303BEFB
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Dec 2025 17:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2B634886B;
	Fri,  5 Dec 2025 17:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuK7fuQN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C34346FA2
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Dec 2025 17:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764954751; cv=none; b=glM7ouwc0AFBt9clG4o+ns2N5YeBY5k2Vbb1NLCPCRzvWiq0LhvilAJWRxZBNnzXCd2qwD2+sADCpwUexAdK0qkk4+pXKazep6aw/UKiWqybcFk3+l/3sw1e7v8KQ3fwbYRYV0T6CL1euiblmUm0s7Oixbr425fvYUCMaaY3bi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764954751; c=relaxed/simple;
	bh=TVRX6OVXaN6/F8l3SopsYHbh+ST+dk2HGsZrDg1QD84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pSxQDtQz/AFYWWAUDj5nb8eitGZr7SlTsgH9Kvtj8ppvBs0EEzCHkwnn5bQydi5l3XG3G29q1xFqH1bum47RsxwHyRXqJQkdLFoFKMh48YsslvuZe0xE7XblRgJ+kPvvOEzYuXEBQoJSND/VuoefO2RbCO/ldPedw+ceNw389WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UuK7fuQN; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-bf1b402fa3cso2162376a12.3
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Dec 2025 09:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764954740; x=1765559540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIl/aawA4xeGwYCaPG7Uh3j0tRW+jDxmmUaf9p3hcUE=;
        b=UuK7fuQNuI0rtnsf7Nc33GBdx6dzAfSUeKBvuz7tojI5LL5uZh4PrtvpuiYSBRBeSM
         ALQc4EF1zFTgEOJdSA9/Azvs02cgC57UADu8nM8X/hUYv8e5LBzzofRDfuScv1lfbmqU
         ZZaUKJQBjM5BcLmAbfVdaofY6/tVaNo3OhT+Qk2VokG9/i0l/pBjCPFxlX+yz5lJxMvu
         uGlJDWWBFhfLoUj5DLdlaMMwW48YvUmSAgySVa3+mFNnnWqQl0cpQgFRxLN3aVeJPF7a
         wHwwCt/+MFb8XFzLUn73PPQHYSIPOSIQna7daHzGmE4udWc9O8LjdtN9ZcKkXEEtEg8U
         u7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764954740; x=1765559540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BIl/aawA4xeGwYCaPG7Uh3j0tRW+jDxmmUaf9p3hcUE=;
        b=YYxofWtQPEudGkhOwgXpo/MwPtxIx3H4JHraNLahb8ci+AuG9PuMy4D7BcfQlaLog1
         dCeIgFVB7138e7YOosZrSGvGac3hLmeZe1TQazUUA+21pWjHPtF33pqTe0soDcCDQM5n
         cdyjkeM0y/iPs1Y1Mwh8plOXiu8NMneT8JQduNDXde2dWZi29f5mbp9QNGzDZG+ymsvT
         8Mi8uEt/ng7XyaQa5+e64M0TglYXgL8P5d/7tOwIofGRTcjSdd50EMinA/E/m0WncD9p
         jMzVddrLJ3BQ1BIxAScGTDyLzaL9ii6ubo9xlgvb4J16xqts/uZUL/+rhZQeypMtM2jz
         VmWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWU4INVFXgLucKXWxARDe8AMHRn6a/1Fc/p7KR47hlbnCoXs8QDi3kTWTR7Vwn33IFsOj5IVX0pAqtQuesz9QY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+FkD/Q4Gm5Jodp3XIPXFfb2EkVe3ayZA+6v2AkQC1aS86a015
	HdPSbfNaD6aJfewGsvty9iOfnfCvUnr29RjRxkCafdV23mcJ1jWAI+F2
X-Gm-Gg: ASbGnctoCMCWVUxuDZn5hy4KP2D+qPoFP7N+7fXA0yY+QeGligkt8o2yWx1jNp/IOIs
	46QoUgTvggQgKluRVteS8f08kp+ucJxrCcwNPaKCgD9fgh8VfPC0smi91cTSbKv2kPlHXf2D3nN
	49NjdqNew0QlL9YPxKhvqrEDND75AJPvL3r6De+PjJDtePWjPzfiqqkzAzSnrOuxzcUxn3QmtVS
	5o8HxIIZlQs95dr+kzDV7XN32+aKGgVTDc3RV0A8J5MybHDb/m6IdeCFmw1xYxwtWZizsuP5Ig+
	aBs+xMPms3lSsTiw7RYKmmaZqDc1kUcfhibjCn2J4gP8tFy5ICgLqPiMd4wKd8UaCqWWMecs6NG
	4EMHgGtl8t7PvmYCqgrrNrSZAeR9oJeDbC6mJgmrRlqskIxUtsF6RHKuOixXdhWGqNcH3+tRfYd
	Q0N2Nb5kM6rbJJas/1NbjTkII=
X-Google-Smtp-Source: AGHT+IGLmu//P31DCy/RNC7sTNOq4cvelmghY7u/vM6nTRJiFEDfwjbdinP/0y5Z7o1g/QEtoGFjOg==
X-Received: by 2002:a05:7301:4616:b0:2a4:3594:72e7 with SMTP id 5a478bee46e88-2ab92e2da45mr5744996eec.22.1764954739092;
        Fri, 05 Dec 2025 09:12:19 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2aba87d7b9dsm20594306eec.4.2025.12.05.09.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 09:12:18 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Shuah Khan <shuah@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	wine-devel@winehq.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v2 07/13] selftest/futex: Comment out test_futex_mpol
Date: Fri,  5 Dec 2025 09:10:01 -0800
Message-ID: <20251205171010.515236-8-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251205171010.515236-1-linux@roeck-us.net>
References: <20251205171010.515236-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

test_futex_mpol() is not called, resulting in the following build warning.

futex_numa_mpol.c:134:13: warning: ‘test_futex_mpol’ defined but not used

Disable the function but keep it in case it was supposed to be used.

Fixes: d35ca2f64272 ("selftests/futex: Refactor futex_numa_mpol with kselftest_harness.h")
Cc: André Almeida <andrealmeid@igalia.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Update subject and description to reflect that the patch fixes a build
    warning. 

 tools/testing/selftests/futex/functional/futex_numa_mpol.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/futex/functional/futex_numa_mpol.c b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
index d037a3f10ee8..8e3d17d66684 100644
--- a/tools/testing/selftests/futex/functional/futex_numa_mpol.c
+++ b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
@@ -131,10 +131,12 @@ static void test_futex(void *futex_ptr, int err_value)
 	__test_futex(futex_ptr, err_value, FUTEX2_SIZE_U32 | FUTEX_PRIVATE_FLAG | FUTEX2_NUMA);
 }
 
+#ifdef NOTUSED
 static void test_futex_mpol(void *futex_ptr, int err_value)
 {
 	__test_futex(futex_ptr, err_value, FUTEX2_SIZE_U32 | FUTEX_PRIVATE_FLAG | FUTEX2_NUMA | FUTEX2_MPOL);
 }
+#endif
 
 TEST(futex_numa_mpol)
 {
-- 
2.45.2


