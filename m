Return-Path: <linux-kselftest+bounces-10622-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FB58CD760
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 17:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 501C528250F
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 15:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E2411C92;
	Thu, 23 May 2024 15:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T86A/Y/Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF3D1170F;
	Thu, 23 May 2024 15:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716478867; cv=none; b=jSPnn3GR8tpORcUgIghlCrmgAF9F8J53VZOrdWUMKEJL9QWvauS/WaJhrokZCzS0YYlCFt/M+56b+YFFdNN9sQPSk6CU3H8WQnSemqYFwaMzoLVn91MSitGAaOBC8cRe0WOsdi4kprfXuD8IdqPyVnNaiSFAq266Pcz1SGhvQ4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716478867; c=relaxed/simple;
	bh=yJgeKp2USP9hyFWHB6DyX7h+mt/gXrBpRhUYxVDXLak=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=rUZIWssetgxnQhLyS9ddnDSHMJOnGyNUWUKWgbfOWYjOePOvkvo7RAVJVI86TgS8tbVrMOmyoPby9YpuC3vMCI+NUS+pnwdyvLVgmPJUKRXO2xf/j9RZOdTxR+f8Lsft+Y4bVGLY8NSk5F/piwT9bLsDih6Bmtk4vG3toAMFxYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T86A/Y/Q; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42102c51524so4971505e9.1;
        Thu, 23 May 2024 08:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716478864; x=1717083664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N0T/0BOLbQiEg7zkcIb/GRTDdLTeXOCbl42VLf5DDY4=;
        b=T86A/Y/QYuk42Li4lOWU7gbBLqqvpyJScTGQNHjktZ4p3WedMnwR84W7icxDLrgs67
         kUrVFd2mH0qF0Yk9/04u6mPhTnJvK798otVXCp1hjYC/L2C7DidPNMOZooctwplvezhq
         MbHxfmifDZELn9Y3iFNIXD/OubXrjoaGn8PCpE5StoFa+7FditzmFthibZIoZvi7L1QU
         ldEnParIG5/7fc4Jkm4qFoDHAsWo3Z9UQdz9QyW/fHAHbbq/AGFWo/9YmdIK7wGdqWvg
         0BH4RCwbyE568ZizLMh29Whm91hm/phKdyMPRMf/9sJTE/1sv3JVIdjKM2h0eHvgMRot
         rORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716478864; x=1717083664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N0T/0BOLbQiEg7zkcIb/GRTDdLTeXOCbl42VLf5DDY4=;
        b=eNL7SMtTDyUS3BH1G0DShxp9FEP9PZNfKTQvmzK8CRJUXyUA9AZ+HkMMTT4j5QXNlv
         UD7YVJYf9pyYV0IEI1rnhLBNHqpZwG3fZUf8radc6om2cpq1TAjqLOKoGGfbofqtQ0h9
         P87IIjyjdJq4XXLUDJ9kSU+G9hLzbAuq+jXFpsVyHQP8WnnZ9Iv+5WVEwttaQhNp9egr
         XHY+q484jzVxuLaGdP+cUcD4Ckda3D0w3g5HTLbhEGdL5hLeY5Gd9I+HwBhHpii8pFeR
         Zr8yPQCAw3d4SwchBuJoXr4TuCw9uM9sWenZivAid+ZS4dKMeabAqtQYdF58o3sXC9lX
         Pg+g==
X-Forwarded-Encrypted: i=1; AJvYcCUCO2AhsH0xyIdnqTXWUSm3gDYH6ZpIUeFcY1vLMwDRhZjL9+Rhm37PwFcQGUz8wbKL+bl2of8DjQEBVZerX4JneRTDiIx/o0/1dHHnNY5Vazz+cK4jXC+ghdeTQQU1Du69l45fSqlM/jFhj9dzVC25BiNBhH+lljQ6AtBbr64c7se0
X-Gm-Message-State: AOJu0YwelbNNTPghYQrMkpD5P0+W9RA5w3WxmYQKWb6iLFmtearBoZUQ
	iCSj7UwS9gzsKp/0ouPOtMB++iI14IqlOW4Pa8GZWxJuz75Uq6eX
X-Google-Smtp-Source: AGHT+IEWXVf9qKaCwbnz/ddAncvRecD6EHwq3qDLQWks4lfRFKJXN6Zj4ogMsTsAkLKRi/EovgDXOQ==
X-Received: by 2002:a05:600c:4709:b0:415:ff48:59fc with SMTP id 5b1f17b1804b1-421015af252mr23109415e9.8.1716478863738;
        Thu, 23 May 2024 08:41:03 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100fadd72sm28467225e9.31.2024.05.23.08.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 08:41:03 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next][V2] selftests: kvm: fix shift of 32 bit unsigned int more than 32 bits
Date: Thu, 23 May 2024 16:41:02 +0100
Message-Id: <20240523154102.2236133-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Currrentl a 32 bit 1u value is being shifted more than 32 bits causing
overflow and incorrect checking of bits 32-63. Fix this by using the
BIT_ULL macro for shifting bits.

Detected by cppcheck:
sev_init2_tests.c:108:34: error: Shifting 32-bit value by 63 bits is
undefined behaviour [shiftTooManyBits]

Fixes: dfc083a181ba ("selftests: kvm: add tests for KVM_SEV_INIT2")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

---

V2: Fix incorrect variable in 2nd BIT_ULL(), kudos to Dan Carpenter for
    catching this error.

---
 tools/testing/selftests/kvm/x86_64/sev_init2_tests.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/sev_init2_tests.c b/tools/testing/selftests/kvm/x86_64/sev_init2_tests.c
index 7a4a61be119b..ea09f7a06aa4 100644
--- a/tools/testing/selftests/kvm/x86_64/sev_init2_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/sev_init2_tests.c
@@ -105,11 +105,11 @@ void test_features(uint32_t vm_type, uint64_t supported_features)
 	int i;
 
 	for (i = 0; i < 64; i++) {
-		if (!(supported_features & (1u << i)))
+		if (!(supported_features & BIT_ULL(i)))
 			test_init2_invalid(vm_type,
 				&(struct kvm_sev_init){ .vmsa_features = BIT_ULL(i) },
 				"unknown feature");
-		else if (KNOWN_FEATURES & (1u << i))
+		else if (KNOWN_FEATURES & BIT_ULL(i))
 			test_init2(vm_type,
 				&(struct kvm_sev_init){ .vmsa_features = BIT_ULL(i) });
 	}
-- 
2.39.2


