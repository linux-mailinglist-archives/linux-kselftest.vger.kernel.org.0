Return-Path: <linux-kselftest+bounces-39532-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09820B2FF4B
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 17:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7B05AC228D
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 15:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFB52E1EF5;
	Thu, 21 Aug 2025 15:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+1P/zpy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745BC2E1EED;
	Thu, 21 Aug 2025 15:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755790894; cv=none; b=gr2v5jH+Ri2z/45hDwPDLWMc8IUnpLVYv02Z3TVjxjQPShpVuawb8e+0Mf4hSjAz1T2M6vAM0Vk+w+Af5QF4xDhw7n49ty7u55oObzzmlOUpRNb1AMRTltUL9m4Yk9NzgIeWRJj60IowlEDoVWKZRztHAiRFFGMXQbSmM01Qy1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755790894; c=relaxed/simple;
	bh=xZfQUgbZnh68Crkj2L8djsDkAGtbGZgFkYXgmuw/02s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nPFiJX4Y6244mn7GZAEmQHG8BRkyhThYVF8Ej1cMdkvaYysXceD1w7pUCs+PDw079+25R8aXmPSYkM0QPcjhzykO69GUu17DIndQbsL7oHBBHGjAzPAMMCvVk1xeTqCkp6Tepkz6zoTqa4of2uiKM9Afr2KiiFwZBEv305LqNTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+1P/zpy; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b4743621044so708147a12.0;
        Thu, 21 Aug 2025 08:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755790893; x=1756395693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5RWfX5SToSzLPcly9AU1U5Uw7VFDv2dnTyM+JJFNb14=;
        b=W+1P/zpyxEGgOj82vN4+Bpx7X0cwu20saxGK21xAlLqKtgBhSr1xg0MrHbgAoSm5kJ
         Kj+Q3sgO0JVX+1RgN+FqAogq74Jz0dMfzOMwbISMbnqZWih6s5qtzfsjI9ed5nj2zZ3i
         fOJ97tg3HOQKsKtf+s0JeI6BqFoOvCJSJCLQnXmdr9ra4JKRjJaW0/nlFQN/323b5VV9
         Vdqhc9sAvyepSz5c6q4SK2Ih+3RuLSlaxX6uNUzmPlRKKZWhknuJWolKMqJXWAr1T3GL
         9Aq+rgWD4wqXVUD+lqjtkqFX+WYL1RW359HeiuPCw6oamv335miRN15dvNgbc/CKJ7Tv
         Nc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755790893; x=1756395693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5RWfX5SToSzLPcly9AU1U5Uw7VFDv2dnTyM+JJFNb14=;
        b=Utnl3OoUfJSx1xJvEtDiq/9UuemtYpzFcv9csMFWRevU+Kk16bcHJr48vl6I5ETmUR
         FBWyiCAeIQqkiTLSX1DyLX70BrM+M7g4+x1yYrKr8h5xQY1o/mhBxqH/hHi7oLrYfgRK
         9gLJc6sGbvweHhwo1N3T1XkNwluhlmZ0ErBV6Wj0QXoWy7toDGu+bTeD1f5zq/wywVs6
         sH13Vazd7dGsblH5j7x+DRHppzEZxuUMGv7FFzrPQlLFSYk1rG9NMZt0d7CfEn3K672v
         EeVKIzCDk5WOjmSvOI9Bsu0Jfe584k9XxytZTgJgu9AqnthkXySM+zkJ6sLKztpI8OKk
         08ww==
X-Forwarded-Encrypted: i=1; AJvYcCU0mglTQFs2qbPAi/r5qaUst4I+/71zikdK3RQ8Gjau4brjGuZm0mI1xLqcd5lx8Yci9ENgTIBNm65C3dJimXzV@vger.kernel.org, AJvYcCVKaw5oRCJZvbPRBuNTB44wGjpbGbFv/Ro8U/mTdcTECpa5Hez2QjCIpKKlNYq88W/7Kxl3MN4xp+tjPiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZu0ssls4DF/F4bgYSyzF6G8p0I1DTFnDm+iaI0z103Kd/1Z92
	kg1IIcT2wv/UKnYU0vVr6OzQIGOzbLGXB6fZ/Mk6/GaHYtrHghcexnhm
X-Gm-Gg: ASbGncv0zavOfTvxdjUsS0sBArUTP76Lz6O17zhj3uKuQWYDvIrNnB3N4awrT65vhZ0
	kIZ0Agn1Z44rmPlwvcYKUqDxEULpFqbLFBaomlz3q46OvBpwY/98I/IsKdipxX/rCwBc0vjQQZk
	ow2rP50tRl2weJLeUOdRMFhUrHG9GVhEgI6I/oQX/xICr0TGRaqrydj4y2211ezh00JVBEGNYeM
	9ZoE4RHTAQGsaheaJ+T+TwlkEaaBkHtHbDWdIWIFcLpQ9DDSgYK1aIiOt+aO6NkNdsnUaQw4iZC
	SQJJ3kynEeUnZYKaSKrO6n38lnKBuzkIbDqvhh5sHCugj4MsDw5kOEDqsKfxUEVvPThZiKh9Bfd
	rgy8oJ30YOdYdooZn1ELvbS4UNCu4FU1zoogI0dr33Pt9kVFg
X-Google-Smtp-Source: AGHT+IFoS5sjeqDzHKWvRWy3jAZgwmRoH6W/HrMPd3Q27lnUP/3qOikzDhMaT/C+xdmi4QUuen54/w==
X-Received: by 2002:a17:902:fc8d:b0:23f:cf96:3072 with SMTP id d9443c01a7336-245fed88bf0mr40353715ad.26.1755790892570;
        Thu, 21 Aug 2025 08:41:32 -0700 (PDT)
Received: from ti-am64x-sdk.. ([152.57.22.150])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed51c027sm58971345ad.148.2025.08.21.08.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 08:41:32 -0700 (PDT)
From: bhanuseshukumar <bhanuseshukumar@gmail.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	shuah@kernel.org
Cc: peterz@infradead.org,
	dvhart@infradead.org,
	dave@stgolabs.net,
	andrealmeid@igalia.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	bigeasy@linutronix.de,
	colin.i.king@gmail.com,
	bhanuseshukumar <bhanuseshukumar@gmail.com>
Subject: [PATCH] selftests: futex; Fix spelling in test messages
Date: Thu, 21 Aug 2025 21:11:03 +0530
Message-Id: <20250821154103.115110-1-bhanuseshukumar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct a few spelling mistakes in selftest output messages to improve
readability

Signed-off-by: bhanuseshukumar <bhanuseshukumar@gmail.com>
---
 This fix is part of kselftest pre-requisite task for kernel mentorship fall 2025
 tools/testing/selftests/futex/functional/futex_priv_hash.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_priv_hash.c b/tools/testing/selftests/futex/functional/futex_priv_hash.c
index aea001ac4946..a8cec7bd2b5d 100644
--- a/tools/testing/selftests/futex/functional/futex_priv_hash.c
+++ b/tools/testing/selftests/futex/functional/futex_priv_hash.c
@@ -132,7 +132,7 @@ static void usage(char *prog)
 {
 	printf("Usage: %s\n", prog);
 	printf("  -c    Use color\n");
-	printf("  -g    Test global hash instead intead local immutable \n");
+	printf("  -g    Test global hash instead local immutable\n");
 	printf("  -h    Display this help message\n");
 	printf("  -v L  Verbosity level: %d=QUIET %d=CRITICAL %d=INFO\n",
 	       VQUIET, VCRITICAL, VINFO);
@@ -267,7 +267,7 @@ int main(int argc, char *argv[])
 	join_max_threads();
 
 	ret = futex_hash_slots_get();
-	ksft_test_result(ret == 2, "No more auto-resize after manaul setting, got %d\n",
+	ksft_test_result(ret == 2, "No more auto-resize after manual setting, got %d\n",
 			 ret);
 
 	futex_hash_slots_set_must_fail(1 << 29);
-- 
2.34.1


