Return-Path: <linux-kselftest+bounces-33668-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15548AC296A
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 20:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7756918982C3
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 18:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D0F226CE5;
	Fri, 23 May 2025 18:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7aZHV8T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1E9296FCE;
	Fri, 23 May 2025 18:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748024224; cv=none; b=mzY7zhnIg/RVCeag+g2/g2TK8kuj8/YOE5eA2jAt8UHWDxdyThXHqOLmtJxYgIEjuo6ZILQ0HkUEMMZEbMBTEHeyyFXmxgyloE26n4XCSYXFTMUx1jwWXCIiclO/o1Wz6g0mwMzC4sJCyRXLQybZGKN8psZDiBU7GKWL7pow2L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748024224; c=relaxed/simple;
	bh=0ojk3OmS08CSe+W0zcrgYl9JC/vymBwmSPVtv8lHsZg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BKtpMjtFkg9FnVIijUKz6c+MF2H9nB+MUvV0xQJZlBZtuNPOhxrDkA90Nye5xvhqHedHwoMpjd0MUFz1KsJUBE0VIaIv/a8g+zLOkCo2swzRTACVnxBmITE2pNjfTmqSn3T2m+CnFvXR4WnRpW2N0+z1LizR6SQGqZgtOLancGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J7aZHV8T; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3110807523aso207224a91.1;
        Fri, 23 May 2025 11:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748024222; x=1748629022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zw/MOjfFz4K8rbGZR8XgD40DBGzetjJhkkywW+GhA0c=;
        b=J7aZHV8T9b7/KtW7JRfEG1MgrVdO+WDYOHolzAU7NDfrxR5TfE2OZBHmgdu6471kAP
         wn9/9Fj5W9gkV4e/YL07x3Bmfmlvlr8QFKEQbIw9E769wbIwKKTDkA+XMHZqutEP5Otl
         tJoReaWDZgU5vE0V/l71K1pUmt3xTfww+LmrP1LH8OxkwlDenxu3TX9JSOfKYkbk1Td4
         +/gmQ6q8P6eS5aov6hjMSX5d0r9ejrhiEEGTpcjx5Y7DT6eicaa75U9piAcLC4ogTB8b
         wBpz/jpZ/bp2vVXezeBd4OuVy5bRFdA4rU4Dp+VHhELo9Uwo0WzA69oGftP9eRaEf3lC
         VphA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748024222; x=1748629022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zw/MOjfFz4K8rbGZR8XgD40DBGzetjJhkkywW+GhA0c=;
        b=bdpmu9gz4/4FzseEzYor/uvzlexepbU0QiPUG5cg7FIZYtc9GjUPDK+o7QjTYdmGIs
         WlGP5EViDO5L1nNvQsUNQ9vPYmckXmtwjs/pufqZAcvpLJTHhjLb7DbBn6Kk7+itKu9B
         ztOkGVQ7ReVkRqhLpDyX9+t86Y9BxEBAZAJ/5eTGC2oxU/Uz9BlC2Suo6yhTLg8GqnTf
         02X/l4BTe8Wg6KQSZDd5fA62qaXKAex6UecFsbhiAQ4du1t8+A34HRiLAaxGLyYWel0O
         uIrCm4d8jCaZViCrSXTqEKDISMEQHQHb0eKS9IH5hWdjKgZrZlLWIZnAcYAtDDzgaof6
         ffKA==
X-Forwarded-Encrypted: i=1; AJvYcCVlzvYc794/YGkqqZMaluyIIYpbYi6rJUhUtyPDdZg6zIAqheWGgOHH4hQ9w2q7gJN3CHih4vsB+KTUJPtd@vger.kernel.org, AJvYcCXVeRVCQEUmE1/YSsQjmVo9M7Aa0JErMfLiEFYIsH7I1EEFbNY0+iMBep8P1ECSaYOmA0GdizcCzy5trnfS8FcQ@vger.kernel.org, AJvYcCXx8wpI6PyMB3Gv3lp5/76qbvlGLSV6/OpKvVKhIBnjqaM41uzviqA46T7fPNVja05oFJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIVu2h3fpnntfE1KgamxUPyVikEm7yp/TEeQod6CdX95aAMCyv
	wPmMNJpia57UC5Un6ocFKvnQoscdtOpyR9UZwb9YbA4Iku0Wq1GY3f1foRc4myIW
X-Gm-Gg: ASbGncvQczIwmCTkL+8icheuxc8Qn/d77L1ExNF2Mg6awhvk+B8Nl2KO3q6+ZgVEi+R
	H3t6iAb354b2KmT/jdkNYLsa0LJI0gJRdNMA+kbyHjyUc6WCO1ux1SG/oTnGDuTxcL/iwjBK2H0
	OwyF0Z4IM0IByRkYgqSfvxuB6A9gyWIYkv6M5dK8wGyGKJlM43WCNUt/w6onDnvojPEsE3wqNQw
	AZtVmum1hULVAJ729AGIUp4p6kR6WuSh+JZNq7LN29fXB8Lil4BKd1ylGaoq9nD6k0lgE1Il/wZ
	eBExuUkwBZeJNHT2U91Awj1BlBcilIQyASmUIA4rlQOHp+66cX3WF0FUXavHhzQhgw==
X-Google-Smtp-Source: AGHT+IEf1S7LbaPSzHV8k2IFf3PpHso3pvVQ+QAzZW4pDP/WKfKC7oWmOUIpUklfFxvE82AfwB0DEA==
X-Received: by 2002:a17:90b:33cc:b0:30e:9349:2d83 with SMTP id 98e67ed59e1d1-311102ca4f8mr86444a91.5.1748024211490;
        Fri, 23 May 2025 11:16:51 -0700 (PDT)
Received: from rahul-mintos.ban-spse ([165.204.156.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f365e5bd3sm7633099a91.37.2025.05.23.11.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 11:16:51 -0700 (PDT)
From: Rahul Kumar <rk0006818@gmail.com>
To: skhan@linuxfoundation.org
Cc: pbonzini@redhat.com,
	linux-kselftest@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	rk0006818@gmail.com
Subject: [PATCH] selftests: kvm: Fix spelling of 'occurrences' in sparsebit.c comments
Date: Fri, 23 May 2025 23:43:52 +0530
Message-ID: <20250523181606.568320-1-rk0006818@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Corrected two instances of the misspelled word 'occurences' to
'occurrences' in comments explaining node invariants in sparsebit.c.
These comments describe core behavior of the data structure and
should be clear.

Signed-off-by: Rahul Kumar <rk0006818@gmail.com>
---
 tools/testing/selftests/kvm/lib/sparsebit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/sparsebit.c b/tools/testing/selftests/kvm/lib/sparsebit.c
index cfed9d26cc71..a99188f87a38 100644
--- a/tools/testing/selftests/kvm/lib/sparsebit.c
+++ b/tools/testing/selftests/kvm/lib/sparsebit.c
@@ -116,7 +116,7 @@
  *
  *   + A node with all mask bits set only occurs when the last bit
  *     described by the previous node is not equal to this nodes
- *     starting index - 1.  All such occurences of this condition are
+ *     starting index - 1.  All such occurrences of this condition are
  *     avoided by moving the setting of the nodes mask bits into
  *     the previous nodes num_after setting.
  *
@@ -592,7 +592,7 @@ static struct node *node_split(struct sparsebit *s, sparsebit_idx_t idx)
  *
  *   + A node with all mask bits set only occurs when the last bit
  *     described by the previous node is not equal to this nodes
- *     starting index - 1.  All such occurences of this condition are
+ *     starting index - 1.  All such occurrences of this condition are
  *     avoided by moving the setting of the nodes mask bits into
  *     the previous nodes num_after setting.
  */
-- 
2.43.0





This patch fixes two misspellings of the word 'occurrences' in comments within sparsebit.c used by the KVM selftests.

Fixing the spelling improves readability and clarity of the documented behavior.  
Only comment text has been changed — there are no modifications to the functional logic of the tests.

I would appreciate your review and any feedback you may have.

Thank you for your time and support.

Best regards,  
Rahul Kumar

