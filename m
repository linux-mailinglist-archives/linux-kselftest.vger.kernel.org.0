Return-Path: <linux-kselftest+bounces-45044-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBE4C3E0B9
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 01:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 166AC188E562
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 00:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92483019CF;
	Fri,  7 Nov 2025 00:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i51rLpjR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558732F7AC2
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Nov 2025 00:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762476604; cv=none; b=GSHJWYn+IlzltV/AZ6jw9SEcW72psrbGz26OoEacShq8yaiqXmmapcyB9sdy63zIeRMj6rSyVZD3PqM+yT09XTwZ3L+yUC1fJwKC8Q9Mb6saGw2BLp3GIKHFLCApGsQKKA07e59Udazj8RIeAj2oH/9MIGgLhOoN+McPo3Ptx/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762476604; c=relaxed/simple;
	bh=3X7FcSuFEkDk3JDUhogHRIfC2C0s4TSTiHdkuzapQSE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ktth964p3ecYNFVugohgJLOQnOmabNRuoTZvspC1DqaBBsYjJCx9fhGmevkHug3REPhS5RsgWgOE0ypXv5lqUSZ3B0MDrbZ6uglLfW6o2cWzgI0hAtWomH3LKp0SpTqY0Q43K9YvV0ZDkHJUr0pnaqWHHlh6GSI3B+U65Lm8ccE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i51rLpjR; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-295df6ad56cso1745945ad.3
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Nov 2025 16:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762476601; x=1763081401; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=08hYWGEnuRuvo8cclYTSCBGU9hHXXt88CsOLxaqCDS4=;
        b=i51rLpjRl+DgspFfmCBoDYbYLiR68qY1vwHrcSPjsf8dYDREDmmBaHfN9hAUik6foc
         Gt1efzeGb1H9sjKH6Z3NoUff+iaG+/rKoo97q2/dZVphMKL0CIwImBkzDfdK6QbDIuIj
         7xa8dgx9H8zxnUPrYGTw4E3pbFKDbB081c5I1XYF7Y0+NJYk9jCWjN3vSCWnSv2x9YCx
         Bp/h79fRZRjpMrfrGsHytvUQIocM+XeAouur1gJZ2cdr/k1DWAkPtgFm61Vcpfb6/IfJ
         PkgLEPUq/LH2AeFLDb7V0mOYZAHUVTJmI9NM73XRDZdurqlBwHjGXtRDle8T8HkRzIlY
         lo1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762476601; x=1763081401;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=08hYWGEnuRuvo8cclYTSCBGU9hHXXt88CsOLxaqCDS4=;
        b=GADouuEpu4ANkeu9uCyWXN/12m754AY7Iq1BADOCCXlxeXTtSNGY57Y/5wvUO1QGob
         aw4vi0OqBilL7d8dG/h7ghMmWEz4GUkEXoSjwP7aups3lG7e4mVWRgnssQ5SoENL7fu6
         G++uNU1p9RX70B2Dm6iM/HlgYj2SOvPyXHQxRg0hkpMiM5GHLjjiPtDXABsnavVTqDFR
         qYZ5gdePmKAEWQfNAZXh3K9EXrL5q5aZNUMo/BrkVqMXHVGQuPgmY0SJOCxRHqsD/0bC
         EsGxJRu4isx5XsE3SIzIyL+91Kz4QB5F+VBu2UDScIJFIEWeZ1Zm5uZtEgt5YMO/yRfg
         T4Vw==
X-Forwarded-Encrypted: i=1; AJvYcCUP52+c89sMfTZ4u+mtSY1H7H9yL3Pwyvq/dbqGiSo7VQv66hVWRnMd/mbVWp12MA40VRZOqi52LYVlRHbwT8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHpN30gohBMea+dkfiMKGuNvVfNyiejqeDcOZatnqthTfXPlV4
	2xa0HIUbMmXCr2iydbBdxyfnmURGjK4xG+cZt30MzORbOIxclk1hz0q3
X-Gm-Gg: ASbGnctcu5vS1EKDZPXwg7o49C7Zq35FKcukjeH5u19S786vci1N2I4NjR9w2MZ9HI3
	fXHiGaXdBtQOQmqKyJEGjVwIMSak59PcUidGLOoFERRu68Qbl3GlymV67trdWDw8u1kqMg2AbLX
	jJOBFzOvegsdYN5vptw6kfhLiss6Rr679ILhEXcH/nEmhp4thLbl0B1vHAwgC2PBOgPmTREC7jR
	lUIqVdPSHH4kSpB/r8kdX9e7SdkB6buYWma37JNQXJviyibvq2DAmWiyYfpEZ5nokNX/jqKjJf5
	bDnovcArrvCoIXiUoLGzDeWftuCYmCbMle9sBGKeHqz6DTscvs01HPXT0VbI/62PhEmUcBg7ZGR
	96crgleVacRgUCaNa+65v0hWRoFG6Rk4Ug10nGjBj1GgmESfmF/wsLbH5X9ZZ8FiopWzQbXRgqA
	==
X-Google-Smtp-Source: AGHT+IGJA+8g6wRjaGXZk+uvhQ1e9D6dzx/VUNrIZDpEGW28OcBzHMx9m6/c+9slJaL7jTXyZDCNaQ==
X-Received: by 2002:a17:903:384f:b0:270:e595:a440 with SMTP id d9443c01a7336-297c040a72bmr17286965ad.25.1762476600328;
        Thu, 06 Nov 2025 16:50:00 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:73::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c7409esm40775685ad.64.2025.11.06.16.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 16:50:00 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 06 Nov 2025 16:49:53 -0800
Subject: [PATCH net-next v3 09/11] selftests/vsock: add 1.37 to tested
 virtme-ng versions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-vsock-selftests-fixes-and-improvements-v3-9-519372e8a07b@meta.com>
References: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
In-Reply-To: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Testing with 1.37 shows all tests passing but emits the warning:

warning: vng version 'virtme-ng 1.37' has not been tested and may not function properly.
	The following versions have been tested: 1.33 1.36

This patch adds 1.37 to the virtme-ng versions to get rid of the above
warning.

Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 7962bc40d055..a5c33b475a39 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -170,7 +170,7 @@ check_vng() {
 	local version
 	local ok
 
-	tested_versions=("1.33" "1.36")
+	tested_versions=("1.33" "1.36" "1.37")
 	version="$(vng --version)"
 
 	ok=0

-- 
2.47.3


