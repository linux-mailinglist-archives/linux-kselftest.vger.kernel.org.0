Return-Path: <linux-kselftest+bounces-15574-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8CE95541F
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Aug 2024 02:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1DAE1F23684
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Aug 2024 00:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09AB2913;
	Sat, 17 Aug 2024 00:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWKIwrhb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E3979CF;
	Sat, 17 Aug 2024 00:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723853929; cv=none; b=i71PDR6nAxdZFYMI3VUD1+WUFulsUM6heXB47K7fqtLKZG+rTf1sOJr4Wpx5a3eFzso4kD4oBzc9MqhokQr0tmkTK/aZPHq4tK4CQRfCjnsXlNMlXAFx7A+uKjc+PNeeh9DBr+PzzMk98qvS4MuqJHP9duJ3VaRzDxzuKejy2Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723853929; c=relaxed/simple;
	bh=9qBu9Ek1/IFuCMDXuTD8qKQ1G284lan1qhEPi5YvOgk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fWCrzEPOID1EPs0l/1iyqlEhndaG4Oub/mj20UEtsaOloMx8gox0nGf8Utq4R0jx+XXpg8ALiA9Wvn4QSjq/gCqszGza6l/fNE21xzRviKxGQTBzSQfaSLrELggB3jZqTeqDcFqW5tJKpVRfHrqix1aLXWSoxc7/N/szEQj7YjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWKIwrhb; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3717de33d58so1435268f8f.1;
        Fri, 16 Aug 2024 17:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723853921; x=1724458721; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yXNmIj+NcTYxWHoqolJZlZHTThjq2Cli8Ss2fpPQn+g=;
        b=PWKIwrhbaYS4eGpqJDgVSURDT/CjmsTf/AmtaQgXweQiq8oHjaw8WKYr8BFJCxwUQM
         qL9/Dko4vir+txUGYfRJFspwNkoLvf/kajssatyeMBPvqJLHzgO+zFmvctgT+7YJX210
         hoH25456WRser0hnW3EtvBoeATfQJYEdJuTCwOhPJLxRhRUsytTYndReuae6ncUodjmI
         /7yDpZHiuSOfxZDDyv7Tx+q3sG3eqrfn2sTAKFsyY09wsVGqygWTxuNVxFgRvOILHUEu
         ELGLsrcoyM8aA/NCRHhqyJOvjwIGU0SYcZtKKSN5nWRiqPlRZLa+3nK6u04pnIGEvmt6
         1KQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723853921; x=1724458721;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yXNmIj+NcTYxWHoqolJZlZHTThjq2Cli8Ss2fpPQn+g=;
        b=feSsnTILYsqhS7sK3pftnCw4F0/tkonyP/Xayo+Oo7cnzwtWZl6DPXOPt5Xu7aVq5z
         HAatKV1CJK0nOasmUGnIX6pri8pPhkM5M68lEcR6D0TtLMqKExQL53Ru2egaaXZzDa/n
         q/pnoWhC7vrahLT04su5o/JUqIdNOdaNnayR19Y/TB2/9Xqq9RFcGjl7wH62aM9gXMdG
         j9t6sbqEg67VS2gZ+a2kLr9gH2ZJ7flb87N02uWBSqnuvAGW/0gbTClln1pcrqHxjSvC
         QIylR2HsxLWdb/bvo6j8sLaCXFcwPd8nCu/cnQVrDorDJPSijhcqvL8EavS+4Jkdpq27
         tpDg==
X-Forwarded-Encrypted: i=1; AJvYcCUm/5ErRIHsPEh43ILABAZZYue7IMgdvPO1/ngWCxUC+jYqep5KJKUZZP7bIVRpd65ksX+nvJfeQ8Umysc=@vger.kernel.org, AJvYcCVpfsZJ31JQopB9VSkuGndBm8YrOwMeOJuT6d9tYkn7IzbU393zF6TNZ24KvOqHX0ObAXXVnHJhVHgUHtxXqw1/@vger.kernel.org
X-Gm-Message-State: AOJu0YyME82geoBxqaimnL4NvpzLKR5v1nNmWEqWkSj+oOwhVr5A7EN1
	fkUSGGBMlyUF1ePEssJJpj5J8Lcsn0bUnLuDoo4PKzKI0psW8WnoQv2SIotf
X-Google-Smtp-Source: AGHT+IFoYlT2c74A++INbVCxGR66uRuw0eMCD6t4X/oZJnDreC1ipLncpJI2gMf0RbWhFUUMPxAr9w==
X-Received: by 2002:a5d:5a15:0:b0:360:7c4b:58c3 with SMTP id ffacd0b85a97d-371946a0b75mr5498311f8f.54.1723853920474;
        Fri, 16 Aug 2024 17:18:40 -0700 (PDT)
Received: from [192.168.1.91] ([2001:818:e92f:6400:96b:aa92:afc0:2d3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429d781047asm104842055e9.0.2024.08.16.17.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 17:18:40 -0700 (PDT)
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Sat, 17 Aug 2024 01:18:30 +0100
Subject: [PATCH v3 3/7] mm/mprotect: Replace can_modify_mm with
 can_modify_vma
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240817-mseal-depessimize-v3-3-d8d2e037df30@gmail.com>
References: <20240817-mseal-depessimize-v3-0-d8d2e037df30@gmail.com>
In-Reply-To: <20240817-mseal-depessimize-v3-0-d8d2e037df30@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, jeffxu@chromium.org, oliver.sang@intel.com, 
 torvalds@linux-foundation.org, Michael Ellerman <mpe@ellerman.id.au>, 
 Kees Cook <kees@kernel.org>, Pedro Falcato <pedro.falcato@gmail.com>
X-Mailer: b4 0.14.1

Avoid taking an extra trip down the mmap tree by checking the vmas
directly. mprotect (per POSIX) tolerates partial failure.

Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
---
 mm/mprotect.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 446f8e5f10d9..0c5d6d06107d 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -611,6 +611,9 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
 	unsigned long charged = 0;
 	int error;
 
+	if (!can_modify_vma(vma))
+		return -EPERM;
+
 	if (newflags == oldflags) {
 		*pprev = vma;
 		return 0;
@@ -769,15 +772,6 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 		}
 	}
 
-	/*
-	 * checking if memory is sealed.
-	 * can_modify_mm assumes we have acquired the lock on MM.
-	 */
-	if (unlikely(!can_modify_mm(current->mm, start, end))) {
-		error = -EPERM;
-		goto out;
-	}
-
 	prev = vma_prev(&vmi);
 	if (start > vma->vm_start)
 		prev = vma;

-- 
2.46.0


