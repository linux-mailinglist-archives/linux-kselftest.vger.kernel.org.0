Return-Path: <linux-kselftest+bounces-10617-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2437A8CD157
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 13:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DC85B20EFA
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 11:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793EB1487CB;
	Thu, 23 May 2024 11:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PaI7MKYJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05BE13D2A8;
	Thu, 23 May 2024 11:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716464287; cv=none; b=cunp3pFuntE9SfLYXLx/qbuCUI9WvZk+knLgIe3O6TCz4vHCs8hLqCymDzAeB5cddrAvhhcPCUSe7ma1HAxRVzJ2lL3YRJQv6PRk40UgY5An8CnPwXIRaZAC2yWU5BBO+ZDPFhRvxk1QA7EwWUOxgErGEeQBLpZ0fDyrCCp02iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716464287; c=relaxed/simple;
	bh=18slTayNbrDxXRTDHctjnSZxYHIh7ey5nRzuUlCOa8w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Qxx8JqcvkdIF1KgM+QajhHjsF3rtr+IG1NRPdrTVnGSNDexuXXtsD8yOuOuCsdsc+o7ftdSnVs95Jxv8FIexqd/xGuJFSgwk1zfzmq311/dimi7HMvGiSVhtzlI1s5NAoayuKA3IDTral2jnUEIy/fQk5XVnixjhCenyijGleE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PaI7MKYJ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-354f6ab168aso434814f8f.1;
        Thu, 23 May 2024 04:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716464284; x=1717069084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aqT4y2vS8dNyIczJ8/6qqGRpO0964EMbDkWUyIXs2l4=;
        b=PaI7MKYJeA+XzTHNq89c1OyRRQ1D+/xYWl0bpmS3pgoW3Ij+exl0ZM79sQk7GvNa6i
         343hRoMxOHvppM00b7P3J46TTSj3U+RVbJcBdd9zd98dJYVNTvL+WoQj/kj5BpUjFW9Q
         T5xQTGWKq6V2VXkHRttmCeJcWeU3JLZcGjbv2AVoWj2BMpAGwTMW1fS7/dNHhSH1PlOp
         prb6A0SkGDAnwdH9C/MBXJ3AjpfY65ly3YuSDDVW8sZJF8t4JpnJ9Nefuo1jN2Wu9852
         YuJS17mf6OplleZBI2/JDUnwHF0hjB/P8qT4CH13P6oejg5DZmqtgw0fIHh0gbZJVrFC
         95Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716464284; x=1717069084;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aqT4y2vS8dNyIczJ8/6qqGRpO0964EMbDkWUyIXs2l4=;
        b=SNwmHygMg28nRHh6Lzz6Zd4+1q4aDqbwW5A3iVBVU7a2t/EIKxhlDDEbirsFnrjynh
         hsSktfm1tz0IdXXJoTRrp9l2sl8k7lDkwhXcouIeKr9rAmt7b8Td5PXstY0aVQEisjs6
         FNpgMXtnpY+NCtTAidttS2CwMSVViPZPta+noVMrCGiv0QysShUy11dYknSWJ5Attl9A
         xsHVIlZfFDFsVFDngGmDiZNYnkrJQ+IXAtqhw2MGy+Yz+a3GBsiu1mFCmsJdbR24IugC
         AFHmakO++isoNa84xBnS0l8MnlOTtNjiQLMi6VCJZRAGxL4Vky0subjgFJxyjx6aXurg
         yQYA==
X-Forwarded-Encrypted: i=1; AJvYcCUuS6ci0if0HyCRxlbwC7XuNqo1q0hHUz/CSmuTlZ3BnCKg/zbSnzzzhu7Nh/JKo10qacaD0bAQcIABU0Oqx0gXWgt2muyFBx/EW0eh+6kVXUSggaZOuF55Yh9VuTukzHevAfITIfLoQLG5GMvJTAmoqKfdVgt4PJmWiEVV9DvoC42M
X-Gm-Message-State: AOJu0YzgMtMQJ9frvNNjE0yMYN7e+/8TRXf9KoY97CVxVYxAtIji9OSj
	QFaMKyzE6YLr6F5fgXJ5hJNcD6GeXqUoKDj49DSmr+o7F2J+Vo3E
X-Google-Smtp-Source: AGHT+IF0zOUS4HcsGOW8XOAHOsMjR5/9orrWORqY68lF8DKEooBrJ/0B1LJhJnM5j8Xmn6sFwitvJA==
X-Received: by 2002:adf:e7c8:0:b0:354:f248:4aa8 with SMTP id ffacd0b85a97d-354f75218a2mr1796665f8f.18.1716464284075;
        Thu, 23 May 2024 04:38:04 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b8a77easm36377801f8f.53.2024.05.23.04.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 04:38:03 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] selftests: kvm: fix shift of 32 bit unsigned int more than 32 bits
Date: Thu, 23 May 2024 12:38:02 +0100
Message-Id: <20240523113802.2195703-1-colin.i.king@gmail.com>
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
+		else if (KNOWN_FEATURES & BIT_ULL(u))
 			test_init2(vm_type,
 				&(struct kvm_sev_init){ .vmsa_features = BIT_ULL(i) });
 	}
-- 
2.39.2


