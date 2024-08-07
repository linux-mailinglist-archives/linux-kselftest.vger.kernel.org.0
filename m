Return-Path: <linux-kselftest+bounces-14936-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2C094AEFA
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 19:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAFD01F2419A
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 17:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E48213DB8D;
	Wed,  7 Aug 2024 17:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjgbfLFz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444C613CFB8;
	Wed,  7 Aug 2024 17:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723052080; cv=none; b=tq66WrrNcodcFkmZ2foZiLpoyFoXGYgNTf/XAKAQ9eh+P8/3Rd1792vMtsRaJvVnAA+3NkcWHA4QOk3XnMaveQLxuNCXjJ+zvQa+gRxtpPj1oOwEUOiRb4BeVneqOuW2lsL6w8cFfMMnGBgxu3gaykpY9x0cvlcxinJpmsR8Cpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723052080; c=relaxed/simple;
	bh=eRMrYiHu2aV19U37soYJjthM4l3uu3pGDQoBe1QBm7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RhL69z8adKq8LRKrr9C0yeMtWvHJJC+teZlUgn23mVKKrp9K+dvHU613RLH67xswmb3mnrCx2qBQy3gO3SlHNq/8JBegL4uXOXFnmGzTLolHJmXt+QAs2Oa+Ir9n3y4BWrcpORy4PN3TYuxogRzDwI0kcXnaJ3osJQSF+B3WwyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjgbfLFz; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f025b94e07so852071fa.0;
        Wed, 07 Aug 2024 10:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723052077; x=1723656877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ug2t+gDCuZhsVMdks6JpJwrHC29Kn6imWNcM3efiL3k=;
        b=gjgbfLFztRb2kwi4cqJHuL4R70TnCB1dJz39XMdk5F/OQRi2dLq1BXVzlKCUOicW7F
         BkgjPG8NVER3t6oUNW6b+9UUp+FA9KA6s1JWRviPdubmXvvjGKPdJNhtpDuJkHVM7WvD
         +Cc2MEejVnm2HpERN9uEmk2Q+VqPIIwT7G0i85nwTLPg0U2NT2HZlCZ0lth3gXSEe7cB
         tuwmnXUq9eA+dkRqsypiKDiXc7W6meXTs2LnYM/JeXGjIrTAfbZG1OxUBdSIusRtgb4N
         pJESScCo9rHi5uE51s6kXDH0g3HIU5y9WOlJYXH2n5TOV+WkVRWJz8soYTSIH/iIv/Yz
         ACmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723052077; x=1723656877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ug2t+gDCuZhsVMdks6JpJwrHC29Kn6imWNcM3efiL3k=;
        b=vbkcar+0bx9PZPtql86t34WLUko2Wt2iO8SSS7R7Tx9J4sLEVRY1amav4izEEbaNDd
         3kej+BtS02Ha2w1ogpemosXoGfuAxwvSiUnhhcgJgawJqR5GTzWFy2PHkd07Cc7VaA0M
         jxir/HTQkKJ3B8Lz8vsQ/EsB1O+C9FoTfAk8f1c2ZmaVE9O3ZMf3FN85V2UyxSgY1Ozq
         quhqnK2dYlBRmT3oJMv09Pzd1DoNYiMykA6eQdqIJiqsGJnWVzyGbMOmhttAnAOkE/yG
         P2Av/7HmXPA1P5JD9VUkLKvr35hSOucuDQ/AvN0wB5qwQcVDbIhZ8qjz82pu3paBU/mZ
         r4iA==
X-Forwarded-Encrypted: i=1; AJvYcCU/BTFXTuNLjL3zI5Sb1zMBq+TlZHzi3quOMzI9aKYGdsWbwDBaVsra7Z88M8owsUM1zAL4/sLfAh94Xi76Y0I=@vger.kernel.org, AJvYcCXJZPjIvFLUzXY7WetHq3KETA1n64FtkRuQ+eokLRNRu1O/GDNr1sZJJpZSJAJPErKIw66LQeim@vger.kernel.org
X-Gm-Message-State: AOJu0YyUHe2pyvkY1oyt0UBxoPwkHabVRM5lQuFw6f39CnYSW4iN6JwL
	m/wX7uelip05CoUZRZW+TUXw/rIlCvBm4rQVQJXzvs+PZ3J5heZ7
X-Google-Smtp-Source: AGHT+IE1nmNuUFZkZfTHaPbqr0JMJqJr7POoTHVNrzs+I1BCOpZInKZ1u0Rx9Zb3aRndvzq9j9VUhg==
X-Received: by 2002:a2e:914b:0:b0:2ef:2b56:36a9 with SMTP id 38308e7fff4ca-2f15aa991f9mr122894281fa.16.1723052076747;
        Wed, 07 Aug 2024 10:34:36 -0700 (PDT)
Received: from PC-PEDRO-ARCH.lan ([2001:818:e92f:6400:96b:aa92:afc0:2d3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42905801f5bsm40335185e9.29.2024.08.07.10.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 10:34:36 -0700 (PDT)
From: Pedro Falcato <pedro.falcato@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Jeff Xu <jeffxu@chromium.org>,
	Kees Cook <kees@kernel.org>,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Pedro Falcato <pedro.falcato@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] mseal: Fix is_madv_discard()
Date: Wed,  7 Aug 2024 18:33:35 +0100
Message-ID: <20240807173336.2523757-2-pedro.falcato@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240807173336.2523757-1-pedro.falcato@gmail.com>
References: <20240807173336.2523757-1-pedro.falcato@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

is_madv_discard did its check wrong. MADV_ flags are not bitwise,
they're normal sequential numbers. So, for instance:
	behavior & (/* ... */ | MADV_REMOVE)

tagged both MADV_REMOVE and MADV_RANDOM (bit 0 set) as
discard operations. This is obviously incorrect, so use
a switch statement instead.

Cc: stable@vger.kernel.org
Fixes: 8be7258aad44 ("mseal: add mseal syscall")
Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
---
 mm/mseal.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/mm/mseal.c b/mm/mseal.c
index bf783bba8ed..15bba28acc0 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -40,9 +40,17 @@ static bool can_modify_vma(struct vm_area_struct *vma)
 
 static bool is_madv_discard(int behavior)
 {
-	return	behavior &
-		(MADV_FREE | MADV_DONTNEED | MADV_DONTNEED_LOCKED |
-		 MADV_REMOVE | MADV_DONTFORK | MADV_WIPEONFORK);
+	switch (behavior) {
+	case MADV_FREE:
+	case MADV_DONTNEED:
+	case MADV_DONTNEED_LOCKED:
+	case MADV_REMOVE:
+	case MADV_DONTFORK:
+	case MADV_WIPEONFORK:
+		return true;
+	}
+
+	return false;
 }
 
 static bool is_ro_anon(struct vm_area_struct *vma)
-- 
2.46.0


