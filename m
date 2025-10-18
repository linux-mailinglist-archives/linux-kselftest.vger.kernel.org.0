Return-Path: <linux-kselftest+bounces-43500-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 14530BED4C0
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 19:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B07ED4F073E
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 17:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7CC270ED9;
	Sat, 18 Oct 2025 17:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="TCfpxQND"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7755266B64
	for <linux-kselftest@vger.kernel.org>; Sat, 18 Oct 2025 17:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760807893; cv=none; b=brXKTu805FqwQDnkq4oZX24gq3TmepvFLZI/4haE5kDLXgJF83eXKB4YxyqqzlU1ajYTMVCw3AoQcwqAgrNKjH0fsUMILq/9n0ps5cBcxWdZBD3aSrtyeXO90sjMEdTWkfN9NvrLMCRTAnmRFPbeXX09QziNdxFV8Xsc2/DsU1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760807893; c=relaxed/simple;
	bh=0XF6mZTda3Mo3Xc5oEB8STcY3fJXR4+QE6+7PIztyAs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rs+IVpIBqsW5ITVG/dPykCs2o6BVC4tC1tQqSsOJt3OhNFq8GD3eAkaJ2J+5NpAxlwXfIDo5hqpPw+iMUoGPijskkYESuBeF2hnB9oB4McveYK/4KSULIlJteKoNKIcomIUmYy3DzuZlZG1RgIrNvsbSHi9FHD3AVGfyB4Q47gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=TCfpxQND; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-87c167c0389so46563056d6.3
        for <linux-kselftest@vger.kernel.org>; Sat, 18 Oct 2025 10:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1760807891; x=1761412691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QFLCF5XN9yDZ1vXn52PKQdU8GeSc6NQJh3Hjw9F38C4=;
        b=TCfpxQNDL1Il6ExdScCLbtwdSyRZGplQ+lsfZWZW/Soflhx/a9cYn2M4UTtxxFR0IC
         sM4FMAwWc8jDMJfUPzViZAlWGpmXJO7kANxMo2s/C+wQoM7cuWKaJHdDsfUhW35l9b1m
         +i5QdKE1PHPPb/hWw/dxPZB2/3j6/P692Y5BiPxmS3ecM46YTQGmiUI7eL+oHHrQBzpB
         pKOVmfLs94+Io91Y+35dIMe9jryFn1X8ocely1Hdi+iR//T3oCObW7JXTq6+Lb9je7BJ
         bKyYwe+AILl7cY2qbXibR0ag5bPla9NxHt8lR7Y9rKpTW9OQ8xqnrM8eQBkwTuAnokja
         eFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760807891; x=1761412691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QFLCF5XN9yDZ1vXn52PKQdU8GeSc6NQJh3Hjw9F38C4=;
        b=gHmViL/AQ0hJ/w7Ue+PGh/bDsFbmvYjjMHhOyKl8w/rfADuKUAUf7GxqKyn/wdpPik
         akXWJTVuCRY+HEi8JW0xK5VtY2aTp9X6e+SXtgXE/oInZYI8MXOUNzqTaaFnkXxT3Ah1
         SttZUcyTQE7d7bMu9VmwyyPvpA7g8YFrVjbL4e0FigaxzhqiNHaXugaJ78wDViVqoWVY
         v0DNpDxo3fBibq6KZEPvrWNgtNQV5TpDdCUU9vPIH2oOwflUlBtsIQHcRHBH+ctXJyFy
         9CJQoFK6+5a0QLk1A4Ojtlo0L1+Oaq/qAm2BrEQIfd6XAP51Gyj7JQw1PxISDlnSHtzn
         q8eQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8DEOEsrqTMcpSbNf9lfB5P+ir4P6zyv/cH2S4yZKo37qGbg3CuIxmrgknUoa7jPid4XPeCB5w2QCS7rMF9K4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxNDC8bgDWzogZimsqDO1ib7FNFDuUXSF0rOiacdUKm8I0w80o
	6+rq+O5QNeTbG6HlYmr97waEcY/7hEqdrBdbvkH+d2knxoEecUlytXatGdm8+durudw=
X-Gm-Gg: ASbGncviofM+woCrrxKcF4GcCOhYdLni6AgsyHSHNt+Dg5wtmQV1T1oW/yzDX4qebOr
	OOh1WpsLUwfVHTA52b9hKAm5LP7i3xd2X+F0RqEAU0VTghxT1gT7srYaDSuZgmV/MKNQsuy58cc
	YvL1WhW4a+OUC1As72CBbjjsi/PkdmLw8PK2Q/HuLrwSJZxbCfjjeBUpOt1yo2KaKOgceHW+m8N
	NsnwT1dZOS3nh3cL+8u6lI0hbgexrqTUVfLXhg8PaZDrYp0sc4Rlr0eaPlWyFKNhLF/pQ9/KSf7
	6S+6HS+mlnIUMh/ivwv7wIvVXJ4nbIvkTI/X/u8Bjwl1Fbg7n7/81sMi2OltyoHjs3O8aelMKOm
	MwadpUS7wQK30a5IUxmNRSW5e9Ban9UbTmpLMKbeVwfmvNsP+gvHXIitC8tWsxfW6ygwzfmUMUt
	HMbDHMh/ZzSTGk7MI9j1ThZhM8Zjl/jijZs1j3SaJ+0cjM0jnCVU2k3tU4XYCV+cCmmJWS9qSYH
	MWL+hvwGI+GAE7p12ZRePbTiMqlIR5G
X-Google-Smtp-Source: AGHT+IEbH67r1bkBBr2fGDtH2iJYzk5qXpz4ZuAYuqM7y3IYRwB0Hgi7HzGfKIjAQO2jFT0oN/PwUA==
X-Received: by 2002:a05:6214:8017:b0:87c:226f:f5c7 with SMTP id 6a1803df08f44-87c226ffc83mr105442856d6.38.1760807890764;
        Sat, 18 Oct 2025 10:18:10 -0700 (PDT)
Received: from soleen.us-east4-b.c.cloudtop-prod-us-east.internal (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d02d8e909sm18478116d6.62.2025.10.18.10.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 10:18:10 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	brauner@kernel.org,
	corbet@lwn.net,
	graf@amazon.com,
	jgg@ziepe.ca,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	masahiroy@kernel.org,
	ojeda@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	rdunlap@infradead.org,
	rppt@kernel.org,
	tj@kernel.org,
	jasonmiu@google.com,
	dmatlack@google.com,
	skhawaja@google.com
Subject: [PATCH v6 10/10] liveupdate: kho: allocate metadata directly from the buddy allocator
Date: Sat, 18 Oct 2025 13:17:56 -0400
Message-ID: <20251018171756.1724191-11-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.915.g61a8936c21-goog
In-Reply-To: <20251018171756.1724191-1-pasha.tatashin@soleen.com>
References: <20251018171756.1724191-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KHO allocates metadata for its preserved memory map using the slab
allocator via kzalloc(). This metadata is temporary and is used by the
next kernel during early boot to find preserved memory.

A problem arises when KFENCE is enabled. kzalloc() calls can be
randomly intercepted by kfence_alloc(), which services the allocation
from a dedicated KFENCE memory pool. This pool is allocated early in
boot via memblock.

When booting via KHO, the memblock allocator is restricted to a "scratch
area", forcing the KFENCE pool to be allocated within it. This creates a
conflict, as the scratch area is expected to be ephemeral and
overwriteable by a subsequent kexec. If KHO metadata is placed in this
KFENCE pool, it leads to memory corruption when the next kernel is
loaded.

To fix this, modify KHO to allocate its metadata directly from the buddy
allocator instead of slab.

Fixes: fc33e4b44b27 ("kexec: enable KHO support for memory preservation")
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
---
 kernel/liveupdate/kexec_handover.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 7c8e89a6b953..92662739a3a2 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -132,6 +132,8 @@ static struct kho_out kho_out = {
 	.finalized = false,
 };
 
+DEFINE_FREE(kho_free_page, void *, free_page((unsigned long)_T))
+
 static void *xa_load_or_alloc(struct xarray *xa, unsigned long index)
 {
 	void *res = xa_load(xa, index);
@@ -139,7 +141,7 @@ static void *xa_load_or_alloc(struct xarray *xa, unsigned long index)
 	if (res)
 		return res;
 
-	void *elm __free(kfree) = kzalloc(PAGE_SIZE, GFP_KERNEL);
+	void *elm __free(kho_free_page) = (void *)get_zeroed_page(GFP_KERNEL);
 
 	if (!elm)
 		return ERR_PTR(-ENOMEM);
@@ -352,9 +354,9 @@ static_assert(sizeof(struct khoser_mem_chunk) == PAGE_SIZE);
 static struct khoser_mem_chunk *new_chunk(struct khoser_mem_chunk *cur_chunk,
 					  unsigned long order)
 {
-	struct khoser_mem_chunk *chunk __free(kfree) = NULL;
+	struct khoser_mem_chunk *chunk __free(kho_free_page) = NULL;
 
-	chunk = kzalloc(PAGE_SIZE, GFP_KERNEL);
+	chunk = (void *)get_zeroed_page(GFP_KERNEL);
 	if (!chunk)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.51.0.915.g61a8936c21-goog


