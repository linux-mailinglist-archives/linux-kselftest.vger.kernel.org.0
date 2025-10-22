Return-Path: <linux-kselftest+bounces-43737-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA67BFA3A0
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 08:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED8D73A778D
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 06:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1502EDD6F;
	Wed, 22 Oct 2025 06:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8VB2w7y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB25C2E7192
	for <linux-kselftest@vger.kernel.org>; Wed, 22 Oct 2025 06:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761114602; cv=none; b=aWFg+5lEc6sPm675B4t3Q14kGPg7IEWbOrU3qLecvqYOq+vCXGbO9QR+n7sY7M/uPjX7ExNHRI5XZK9VyUnxozkMyINbUxJCumOSjjgcG846nFYYkPO5isGe2Z9CjT25JVzF0tgMpP84/UeC0OLHrclA69cYikJ0Qtp8HG81BHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761114602; c=relaxed/simple;
	bh=pxi12w+zJvC4kZodhK0Ij6Jx0cFF+FxyL/tgy3imtgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AwckanfvCdDS+zDaiVNlsGnhRlsFh+oLNICrPjDlVZj78EJnzpBNL+1Q/8gp1v/3Jb4bY7EGTvFnBZRMuTGde4msNp1jTHWbcjM+mi8tFcjuvhWpMkYoEk+4oMb6dS2LL7Nk/+qzZU3GqtrjRlh2+CZPZwqU+7qWzigzmdwmRDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I8VB2w7y; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-77f67ba775aso8415986b3a.3
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 23:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761114599; x=1761719399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRyE8t6dhAXyClNR4lT1jQASjbYPHXa83JC4TjDmfbk=;
        b=I8VB2w7yGMF2YQnTnrTzrWkTWo4CX/RcKmOXqOU7pIEnRXK9CUIf/gX2wVxT1zjGoU
         RH9tntSabA0PgGpumchozKxYZGdre00hD3fRfDlP4J6TlEPZTvetyqsME3prVvMFc5y8
         on0CtY6qAQ1GPTfS6tuivN4+mwe1KTPrWzvWsYOMqMVA+163RRTkJJ7TNkDsOXvmClcm
         V+k9HqcFcrrar6zk3BsA/9qdACu5hwJUy4POgdU3Chj8bYl4XI48bD8Up7x6l35uUJth
         Zkj7W5ZtzjApyRPcYWBbTkv5nQg41OelmyhCcqwsy8TwwpV/XFpi0wdPTufDVvgta3o1
         OH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761114599; x=1761719399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yRyE8t6dhAXyClNR4lT1jQASjbYPHXa83JC4TjDmfbk=;
        b=Y2iFE9txzqj2LPmjOOmfENXoJVufF7+wf2Djxum+mrOivCJeEZgo2Rr0KDhiesDBGq
         DdErs2s/NYf5mVc82ESb+wF81CQPEg+Polhkx7nTwqqHqeN8jZRLtdWI8rouQfLxKhsA
         jH+X5id1Hm0/adr5/EtWFyNP/eTyy7RdWqay3vXKdvdq6c/8HyKPMXiKzTdUop08DGxl
         w3WjpAASpWv4w1nUrd+eSiLV8dMS/bO7Jo1DTysASqCknFu88YQAZ1iavgo4FlO40G1o
         F3UR0qRDGZLLKOYitjjbq7FcTdeJFHQwJoiZ6bfdWl6j50clNTegRHg0mpCSFnAZIfmw
         55hg==
X-Forwarded-Encrypted: i=1; AJvYcCXb89tC5geruvCE6rSIznKv5KQVjUVXzSvpPHgp8Nq/vgTjn5ISd9SjjDKjNDrwt8aIZe5zvfXp0OIUeHuH7Ks=@vger.kernel.org
X-Gm-Message-State: AOJu0YylXrnB+FrG7rDsrdXjntClHWmV0NyGuGqLk98UAX4NtpbSFbf3
	4AITvQG8efyhjar0Jwb2ysELoJrc6q88EOfRYAXVJ6b5pSBK/Ho+y83D
X-Gm-Gg: ASbGncsDSxpuwcPusc0E6YAW5dnKjGlWu0ZIHwlxnc/oHyN6mPVv1RcB6n53JIhAarJ
	nj8N/zraZAp1xFWb8Own9ds3TZGUR2C0V8S/1EMj90+15OLcfSD6AJA2nrWnQzaBAxeO9mnFhHT
	3TIoDxoiUK22M5NnzScAkV/AFif4w7gYtV9EvQycGu5qGuQH62Cx/5tvhEBbw4JzqavE1aeGZPf
	3o+kjd3SWMf3KC3ATK8nnFWXDMuTVMfYydXbgQSKOwL0t3a3mMYOyJvumaRwYWrjfOH4EDM8mwk
	HxEXeNR/deRDI0PZgxXwesNioLE0vcH2H50i+ppduxRmUob1uTVM6kwtSbhmtcfsEFtK1D50P67
	NlnpQz8/IsdBJheTKy5Hs8Bvq/Q4HiwsePh6SfCOARH4UddRT/sgYv65JHnKblvRFyusvxWMZE+
	9P+ZSjBDa3xEWnQtt/b3T0funhfY8MnXc=
X-Google-Smtp-Source: AGHT+IHCdWM1S/FVwbPmHY3O4OmTAtweU3JQt3Ila1Kmd/ZSXIEyZnlKVzKCFjwGH+txrzbmUlsmmA==
X-Received: by 2002:a05:6a00:84a:b0:78c:985b:8d3b with SMTP id d2e1a72fcca58-7a220b29d75mr20156837b3a.23.1761114599073;
        Tue, 21 Oct 2025 23:29:59 -0700 (PDT)
Received: from server.. ([103.251.57.247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a23011ec97sm13408435b3a.67.2025.10.21.23.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 23:29:58 -0700 (PDT)
From: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
To: naresh.kamboju@linaro.org,
	broonie@kernel.org
Cc: anders.roxell@linaro.org,
	arnd@arndb.de,
	benjamin.copeland@linaro.org,
	bp@alien8.de,
	dan.carpenter@linaro.org,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	lkft-triage@lists.linaro.org,
	mingo@redhat.com,
	reddybalavignesh9979@gmail.com,
	regressions@lists.linux.dev,
	richard.weiyang@gmail.com,
	shuah@kernel.org,
	surenb@google.com,
	tglx@linutronix.de,
	x86@kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: [PATCH] selftests/x86: Add selftests include path for kselftest.h after centralization
Date: Wed, 22 Oct 2025 11:59:48 +0530
Message-ID: <20251022062948.162852-1-reddybalavignesh9979@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CA+G9fYvKjQcCBMfXA-z2YuL2L+3Qd-pJjEUDX8PDdz2-EEQd=Q@mail.gmail.com>
References: <CA+G9fYvKjQcCBMfXA-z2YuL2L+3Qd-pJjEUDX8PDdz2-EEQd=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous change centralizing kselftest.h include path in lib.mk
caused x86 selftests to fail, as x86 Makefile overwrites CFLAGS using
":=", dropping the include path added in lib.mk. Therefore, helpers.h
could not find kselftest.h during compilation.

Fix this by adding the tools/testing/sefltest to CFLAGS in x86 Makefile.

Fixes: 4d89827dfb27 ("selftests: complete kselftest include centralization")
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Closes: https://lore.kernel.org/lkml/CA+G9fYvKjQcCBMfXA-z2YuL2L+3Qd-pJjEUDX8PDdz2-EEQd=Q@mail.gmail.com/T/#m83fd330231287fc9d6c921155bee16c591db7360

Signed-off-by: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
---
 tools/testing/selftests/x86/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 83148875a12c..434065215d12 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -36,6 +36,7 @@ BINARIES_32 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_32))
 BINARIES_64 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_64))
 
 CFLAGS := -O2 -g -std=gnu99 -pthread -Wall $(KHDR_INCLUDES)
+CFLAGS += -I $(top_srcdir)/tools/testing/selftests/
 
 # call32_from_64 in thunks.S uses absolute addresses.
 ifeq ($(CAN_BUILD_WITH_NOPIE),1)
-- 
2.43.0


