Return-Path: <linux-kselftest+bounces-26128-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C833A2DA6B
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Feb 2025 03:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 370FC165CB0
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Feb 2025 02:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F4714A85;
	Sun,  9 Feb 2025 02:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnrYwHs5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECE824338A;
	Sun,  9 Feb 2025 02:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739069087; cv=none; b=dEZDqUrrL3vAaNzm7x0yUuP/DnySxkRt5hoHRL4ZNOh3VrwrSdCuD+mtlrRCvUU5Er3Oov9pGEf401LP6GDHDEP0pG5BXcTBOhqViq6lwBvuxj9MTC47vjLI8PaQu3rVW74bKmHCK5DnCMNzZA9Yd6XzYIhZxKn92q0jn5juL/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739069087; c=relaxed/simple;
	bh=vFzH7kZIUHplLwMO/YhtToMuYdArZnJPTL69f+iTkag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sLYWAwv22P13AL+Kw0q7wlxVrpNAQKK6fSbbOdJqVc9HM3x94DabYNSRFjEenf/xdW39Sch1drANSdM3D4n80GNflQTKPzfQX/13HSCCUq+Dh7UT4PYKJ4gtjm1p0Ir9k3Rc8mVp1o7M6mhZElSXWfgTfPSYiDqEH1N6673Z754=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jnrYwHs5; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e45af17a2eso6418946d6.0;
        Sat, 08 Feb 2025 18:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739069085; x=1739673885; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J3DDHGysBiLYcpS1FXaBmNHNv2jJ0jErFhub3UQ5cJo=;
        b=jnrYwHs5N0Lq2wJrDLBqT/WokUFarFK+CYJ0DXYHbvMCFJC/ZpesMQbusqfP6mk0zm
         BSDZCshw96BOb5fTnU1/K7f/2TShoNQdi+DxbDwVCdPqyuy/G6TobOsyMEXvWUNyp2i4
         rYA54Fdwqg0JOe5+Rs9b1R+3p7nn1MLveFbWkGn0b/2osqTtSBrN9Qiyk/vDS4nEoNTB
         aaAEykS7f/tgwUW3ycv2TFt4eKPXIzLiV41GJRyKGVrGD+q0lq8u5rknxd7IYdrSnKSr
         8afHcs3/xbKFhm82+LM9QdgHGPtDVtSb+m+A9TvORC0RDZvdrBmvq/ngMxIT7ZgZF9PQ
         +vDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739069085; x=1739673885;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J3DDHGysBiLYcpS1FXaBmNHNv2jJ0jErFhub3UQ5cJo=;
        b=TgCzC7dQLpYNNCRW2dAWDmfIPU0LD5e2cRFl2j5Cof9c9sofGNV4e3EKJ9zNKjLz/m
         haCARsE2QU1818hF4z3ehDqhej8CwoJpV1HgTeHlF8j7hlvV8Da5jg2c9AZQFeTtCOTI
         PlIJU5QJJ0uUxazP6uexilvMHObPrIRI1Q8ibEQFRwQC6x7ylWBC2O3HAs8TLHoUw7LA
         SD5A5LThH7fXTaQm/AE8Qr3Nvr/bm96RaKWSe1qgpYOSgwSxPTugmQM23n5veDuESfbf
         OcPgxeVRcIq2sh7xhPpLhbpwrSNnfz35YEnBsqrYAzXR3x9/AruOhFYMP2Fz0F0fqMPY
         HBNw==
X-Forwarded-Encrypted: i=1; AJvYcCWcp0gdNAddhlzRPGCfNjxzPdSOZlo2NU9GCihyL5j7f2R+8MFuFFIxDTimw1aCbl1iSgDf6nu7I6ooyyEUK9w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe5YkjedBb1363VkfzrcBpBSMmAISCJh4pIHgdyFRV/ytVoHgG
	RhM1/LxH5q3N1EwGPSpjVBXMKhsOxvx4zNjEW/lWINvSrz61m5Ab
X-Gm-Gg: ASbGncsy1W1QLZFDbj9l0fOo9XjVEClVyPZuodViR3Y2N/gD/lvJ2NUwDDlVn9JfFj3
	yqrs6bwmBeUVQOQleL3dogNKw9nmjFsaql6jLdKqjbrZl1gaGHdhtBpR9Nen/DtYlmEcEohx2/V
	3DGHbIyD10tfJvzMu5IF+1LdXo2zLEvl/c9Z9khH2Akv30oVytkehB0pTuuxMjqbAB7I3Uvj0LA
	gKdReAcW3yvIchzz2WltNR9HQPF/w56B7y6NfdECanRklXr1zDXnsQmQIVcMQRAro1tbLVWlEvj
	iafUBtzhvSwj50aU8a6inYoLx3Pvsazvp4KGe8SyF2qqTVK4ySR4I4m8+MvXkgKRZkD3bCV4ndP
	y+sWwUjbpzZHYNkg5W467hCxHLFGaINPhrr7ydg==
X-Google-Smtp-Source: AGHT+IEt4HF79yWDf1KHb0w8ekiaHbfp8qd4aAfVgUK5BngfVnz+EeebCW60P81hs9MB+zNuiczF+A==
X-Received: by 2002:a05:6214:5016:b0:6e4:442c:2888 with SMTP id 6a1803df08f44-6e445732a6emr113064496d6.39.1739069084672;
        Sat, 08 Feb 2025 18:44:44 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4041:5be7:7c00:15f6:96e9:3308:934a])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e451a83cbcsm11572356d6.102.2025.02.08.18.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 18:44:44 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 08 Feb 2025 21:44:38 -0500
Subject: [PATCH v5 1/2] lib/math: Hook up tests/Makefile
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250208-prime_numbers-kunit-convert-v5-1-b0cb82ae7c7d@gmail.com>
References: <20250208-prime_numbers-kunit-convert-v5-0-b0cb82ae7c7d@gmail.com>
In-Reply-To: <20250208-prime_numbers-kunit-convert-v5-0-b0cb82ae7c7d@gmail.com>
To: David Gow <davidgow@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
 Luis Felipe Hernandez <luis.hernandez093@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

This Makefile has been dead code since it was added in commit
7fcc9b53216c ("lib/math: Add int_pow test suite"); the tests worked
because of the duplicated rules in the parent directory's Makefile. Wire
up tests/Makefile and remove the duplication.

Fixes: 7fcc9b53216c ("lib/math: Add int_pow test suite")
Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 lib/math/Makefile | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/math/Makefile b/lib/math/Makefile
index 3484078177af..d390da9a59fe 100644
--- a/lib/math/Makefile
+++ b/lib/math/Makefile
@@ -5,9 +5,8 @@ obj-$(CONFIG_CORDIC)		+= cordic.o
 obj-$(CONFIG_PRIME_NUMBERS)	+= prime_numbers.o
 obj-$(CONFIG_RATIONAL)		+= rational.o
 
-obj-$(CONFIG_INT_POW_TEST)  += tests/int_pow_kunit.o
 obj-$(CONFIG_TEST_DIV64)	+= test_div64.o
 obj-$(CONFIG_TEST_MULDIV64)	+= test_mul_u64_u64_div_u64.o
 obj-$(CONFIG_RATIONAL_KUNIT_TEST) += rational-test.o
-obj-$(CONFIG_INT_SQRT_KUNIT_TEST) += tests/int_sqrt_kunit.o
-obj-$(CONFIG_GCD_KUNIT_TEST) += tests/gcd_kunit.o
+
+obj-y += tests/

-- 
2.48.1


