Return-Path: <linux-kselftest+bounces-45039-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC85C3E06B
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 01:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9019C188BCB0
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 00:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045C62F531A;
	Fri,  7 Nov 2025 00:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfKs7eKs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0016E2E9EC6
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Nov 2025 00:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762476598; cv=none; b=aU67x8jiRkiWFv76iLQgj9nCKaSvQAp6gxoXKRhJivy+SK9PztKZnZSZm8/r5iN9XfrH12gYJHDXSY+oRRXI6P71LlvsBAicIyCESyajBiS6TJZbOFaMyGZE6MvL2f8XSPQsd52vYpx9e54ut72o7sF77rQT79VfEMcHYQXnX7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762476598; c=relaxed/simple;
	bh=4uCVZgM6UeuQx0XSrGdd9WXjIqluMM3jZUftpCJANAQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=isZMU7IlbBLBYE4XI2pStFY+fFY7BZhpPP+wMGLuMZH43xloONEHOMkntaSH+1YoWWkasXZHEWszsyeCQTUI80PPzO+GC7jB7BSO+p/KI2U3+SneR2hsRqMyNixEU7/4nhEZY4sdvU42LKXY60muFflZ54aLQLjLZ+j2Kkb50uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfKs7eKs; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-28e7cd6dbc0so2667275ad.0
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Nov 2025 16:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762476596; x=1763081396; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ijXE7xEmBTHmMpA+2gEwbQm6yVHcpL7r2RPNx0k5rU=;
        b=jfKs7eKsSRQ+QZYNuOQ3Ewg2uyfpFtWMekNrVmc0lq3cCBiBYHuN8FLOxErNTJQUFK
         Lux8ahAkQVcgK1ZWE6lmgd14rtmEK9WYJIb3UFqjuUV1w+r74RDFtXylyxtR6VgLfKPS
         mTpVXoc41XQwL5RSXmLcSXubHwyylHakv/aHC1hDQ/764NNF1318Jc0nl3YlP9sZuUyE
         tcCdoqd1dJq8ORpBxZnBX82Kxj78WQavRgk6Zbj82tOXfZOMMczMAMLBOyEg04Aq4ooh
         mDFFVwqrzse2OkRqQIyvmR5Vap7rONja74UgKCoVUAfAs4QAvlvsw0mv3IhKjEYXZSgD
         Jacg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762476596; x=1763081396;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/ijXE7xEmBTHmMpA+2gEwbQm6yVHcpL7r2RPNx0k5rU=;
        b=nFYKngbvwj8mNkZtvXnurAK7B1nDf2NQcUf1GhqBWc1yP+PxBBDwv8TtSpNSFpHVQP
         1b+ykb9YsA8wdRaeiyKZzQX70gyXtmn6lW5musnp2Pz3hZiVmGL9pyW8JsrkjVcdrQZM
         9/z5wCrcYZZjwiMin5blIARZqGX39VKowR4NUfqRb2v3vyV8n/brXRVeFPNs1V/REksG
         hlGmchYRzz3zYvVy7xHT+zDTzObVAXl9lGBTAcn1cH6H2nQ5axHFhZbEiq//lg/XkeKH
         129hSz29Z4pJnS4YCrVlKHGwyqcD+FPEzfD9hbjA0uFNhWsqTsZms08vqtjJxVv9Ol5u
         3plg==
X-Forwarded-Encrypted: i=1; AJvYcCUT1iTGpJqW67yJl3SeLUqT0c+inH0pSojnZUw36G1t2zScMJsq1jT9SHCC2Htkza891Pi6HKGkUZW1BXYGvv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjHy7aUQxpZqVRMJ9V4pDiRC1f+8l0xYJy9Q6EEHvsosZNI0rl
	q6AEnL0z+AwXqh5Ue9pqo8bPigX0nkm5aosKIE3qk/7jikwVaRQZ7YwLQBHKPA==
X-Gm-Gg: ASbGncuSqP/Y2oPTkAblK7aKodtJn/77Y1uNI7NYW1Xovxs1iEuum3fhdrcFf5Y1SR+
	sxLwEW+wHjXYx7SMwh2BAdP1qre/sG6/dZ4wc4REp1m8bfUM0dkV5gSejThllGnTjC2W8crIibV
	Ycs+58QoH/hbo9gNFPxDJ4fEinLfGTl4naT8nqrld+n1ruL0YbPEGigeTFnIn3mAWbitbRP1Bb6
	l76rC/VMW6gqm30UHqNqE6TIJLDDqjZVVLpARkihGE2qa3Sdz8UeCLiwmBC75JoL2sVNmOlec6J
	rkL5SB44SOp6nXZwmKMpU1saI4h0aHeN9WT8IG+M8Daony+6Ja8/z7DVSEH7TW53w13P74DPMU7
	xl9sdjIrOoMtVwpniaNG5trJ+tx1cggLqP2mS4gOuQ3NcQ59Xb1z414B7kwNOyBjLLrE30ZZo4A
	==
X-Google-Smtp-Source: AGHT+IGDT33BspNwLZAZGr8rW1mWSoTCi6gvaV3hnBfSUxt42Bs8QnGChK2Hk2M/l58MMqK2S4GupA==
X-Received: by 2002:a17:903:1a86:b0:277:3488:787e with SMTP id d9443c01a7336-297c0389ec8mr16267605ad.12.1762476596231;
        Thu, 06 Nov 2025 16:49:56 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2965096dbe4sm40974195ad.11.2025.11.06.16.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 16:49:55 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 06 Nov 2025 16:49:49 -0800
Subject: [PATCH net-next v3 05/11] selftests/vsock: do not unconditionally
 die if qemu fails
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-vsock-selftests-fixes-and-improvements-v3-5-519372e8a07b@meta.com>
References: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
In-Reply-To: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

If QEMU fails to boot, then set the returncode (via timeout) instead of
unconditionally dying. This is in preparation for tests that expect QEMU
to fail to boot. In that case, we just want to know if the boot failed
or not so we can test the pass/fail criteria, and continue executing the
next test.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index a461ef1fcc61..ede74add070a 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -246,10 +246,8 @@ vm_start() {
 		--append "${KERNEL_CMDLINE}" \
 		--rw  &> ${logfile} &
 
-	if ! timeout ${WAIT_TOTAL} \
-		bash -c 'while [[ ! -s '"${pidfile}"' ]]; do sleep 1; done; exit 0'; then
-		die "failed to boot VM"
-	fi
+	timeout "${WAIT_TOTAL}" \
+		bash -c 'while [[ ! -s '"${pidfile}"' ]]; do sleep 1; done; exit 0'
 }
 
 vm_wait_for_ssh() {

-- 
2.47.3


