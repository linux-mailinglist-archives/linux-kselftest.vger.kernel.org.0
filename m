Return-Path: <linux-kselftest+bounces-43499-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35078BED4D2
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 19:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEBAB5E8E32
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 17:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5658126F2AB;
	Sat, 18 Oct 2025 17:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="E1aY8Eou"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF26261B8D
	for <linux-kselftest@vger.kernel.org>; Sat, 18 Oct 2025 17:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760807893; cv=none; b=OR5yMqsQXwINr/G43rEQQcN+In9BARnu3RrjHWuUkp3l2vd0zCkTidx71KytHP8qNaSJZHLDXFDNGXxL9lS5f6T+g2EJE2zdz7EEYHn2+YJFRiPvDRNUElb4d0BkuARNVtuotI4MIiBX+JSLLBHi0hFDFFc4p1mu+NfQhr2SkNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760807893; c=relaxed/simple;
	bh=3WWC3nv053Mu9XPdOFn+xrlFtzqec5hSHDB0nXy9HI8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XrTxi3L/iuFzMW9YkJ11/Ic0Ut9EWTFdx6w0bI81FZJOzTU+/bRIzyupY/6QXqQhWOk52KyRk76G8JGkqj2Fr7MgEGMAypuMhdDnnQoQHqkZv+lR+aq2b3Dm2SbF7NWTs+vbPIgTOl9MEjvGWa7gbT3NTX35W3cIl6BFrxsT0Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=E1aY8Eou; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-87c0ea50881so63675736d6.2
        for <linux-kselftest@vger.kernel.org>; Sat, 18 Oct 2025 10:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1760807889; x=1761412689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9+4s/LMKH18C3S9kWxUuCFP/sSm2GXOGXRSXRIxgHJg=;
        b=E1aY8EouFucyW8bbwCYfa7o6TUN9ne+AiwHCYZyJ2uCnz2WIcfUfUPEyibc7OPOQTU
         GJMV7RkQlgzLpDb5TzZEH51P4uFBVHRaUK1rfbwcGXi8youOEoXnaRa7NRkT3RO+DOPW
         nvMj7OoycEjd3Ty0mjofSCmviQxq8ImZMnMpNjE8qDipGMbHULaBxYVXit6VjcMZf4UR
         AImhFMgUukD4NV8NwvESBUIIKKY0IHytL+tV3KgCz4yfsWmINhc98hv3v2e/4S5NFWl6
         UiIIIpipcA4ChFrJgRDoGbKetVPG8tcizaWosX1DFtr19PA2aytKlwy3sTEwOgQUZaMm
         Wr5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760807889; x=1761412689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9+4s/LMKH18C3S9kWxUuCFP/sSm2GXOGXRSXRIxgHJg=;
        b=GTuSnnlo0bv/s/63Q1dJATjROCMqNjYgyzJHxKwLnFE6BgenFCZL3wih18igW2GFM9
         xlxRyrClGxEJrjsti8f3+yfE49TwXd/hi8CZ2cDBKYLGIzkv55hwIZTcEOh9tx7h7dUn
         tx2IbcX/HaPFJHYeq/5+m2jpcvsNEguIqAVhtLdtMQYsP9XdjcZ17Gps7vwM72Re9GS4
         q/iUj4EezzKadpi+h4ON4FWNBa0yruSFE3Jc5Y6d+afLKEENZX9V0BPmrO6cqsVkvVU7
         hDATF0WjTywKpz7Hd2Hk8nOJl7FDRiEUGzVI/tOE4ppTilXEooG1nan6sDSrj/nWzovl
         Kz2g==
X-Forwarded-Encrypted: i=1; AJvYcCUCynNkEqK2AiBbm2+HQuGyXBwVV7i3C8lVOgbjw0APuLysamD8ZKW/4BE36qqt0IGklWSVTN3CUILFqinY/WQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsoCFQKKxpOFvyyIMmxqH00TjzSD1SqjfMZv8AzK7DGGO1AK6d
	Lq5rtkHVhtA/qWnL6HELf1V7Yb7Z1j1SXN4b7X2VAKc33dTq4lscjneNkULGFDK2MKc=
X-Gm-Gg: ASbGnctKN8DPmjibySJPigNtyBSXcylChgy2gh0LDLN22tmcZtztEE+editz0MS6DJn
	7CBJWzgmSMWQGBMgF+0IoWmTCcq12JsvA0unD1FeTAf3yEwJr4uc+1eWC1i8FknlLKPEKvJqoHA
	WN2sgEnte4QT1/Fpj3S0i8eIigJko75DtoP/ToqWcT9SXNVpNDJX4tzpaBUVDnck/4d4jCpeoOi
	oyWDSXoZaxIum7052yTc26h8CkIwxb3A+v/bnXZFcMW+Ky9Cu3S0CNvxg4y5b2wYdtJ4QTEgkmW
	lpWplwS0fbdSBm21294uDjURG6MvBwo7JIraWTpmniO6WuwhwxvXyBLqGoVjBliDxB7rfVCiZ/m
	kUqXTxgwiPFUckk5C6GIjMF4yMkuXwwHRCqzANNlVxjHmAKJajWu90OPAVmKf0UIuQWeUblu9Q/
	gg5JN/TwlkkPemPPdCG/xpQ2gwAE189YPX9MhZ6ouvqhS3eWYe4zuRCbbl7EgQ8zL1ldMydtZ/r
	MPYNQo25tGjJ4yFTh5whx9ySL0cTPrb1KLR9oQH/uo=
X-Google-Smtp-Source: AGHT+IGwicpZ/o0IuY1PRlF5+Xwpp0Zedm9EU1jTpFbIRqEFcd5qCkFHdNzCn7aZrNCsS7eWlfmhaw==
X-Received: by 2002:ad4:5b85:0:b0:7ea:1156:def3 with SMTP id 6a1803df08f44-87c205b103cmr120184846d6.28.1760807889222;
        Sat, 18 Oct 2025 10:18:09 -0700 (PDT)
Received: from soleen.us-east4-b.c.cloudtop-prod-us-east.internal (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d02d8e909sm18478116d6.62.2025.10.18.10.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 10:18:08 -0700 (PDT)
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
Subject: [PATCH v6 09/10] liveupdate: kho: Increase metadata bitmap size to PAGE_SIZE
Date: Sat, 18 Oct 2025 13:17:55 -0400
Message-ID: <20251018171756.1724191-10-pasha.tatashin@soleen.com>
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

Metadata is preserved via 512-bytes, which requires using slabs. Slabs
are not safe to be used with KHO because of kfence, and because partial
slabs may lead leaks to the next kernel. Change the size to be
PAGE_SIZE.

While this change could potentially increase metadata overhead on
systems with sparsely preserved memory, this is being mitigated by
ongoing work to reduce sparseness during preservation via 1G guest
pages. Furthermore, this change aligns with future work on a stateless
KHO, which will also use page-sized bitmaps for its radix tree metadata.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/kexec_handover.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index ebfc31814d16..7c8e89a6b953 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -67,10 +67,10 @@ early_param("kho", kho_parse_enable);
  * Keep track of memory that is to be preserved across KHO.
  *
  * The serializing side uses two levels of xarrays to manage chunks of per-order
- * 512 byte bitmaps. For instance if PAGE_SIZE = 4096, the entire 1G order of a
- * 1TB system would fit inside a single 512 byte bitmap. For order 0 allocations
- * each bitmap will cover 16M of address space. Thus, for 16G of memory at most
- * 512K of bitmap memory will be needed for order 0.
+ * PAGE_SIZE byte bitmaps. For instance if PAGE_SIZE = 4096, the entire 1G order
+ * of a 8TB system would fit inside a single 4096 byte bitmap. For order 0
+ * allocations each bitmap will cover 128M of address space. Thus, for 16G of
+ * memory at most 512K of bitmap memory will be needed for order 0.
  *
  * This approach is fully incremental, as the serialization progresses folios
  * can continue be aggregated to the tracker. The final step, immediately prior
@@ -78,12 +78,14 @@ early_param("kho", kho_parse_enable);
  * successor kernel to parse.
  */
 
-#define PRESERVE_BITS (512 * 8)
+#define PRESERVE_BITS (PAGE_SIZE * 8)
 
 struct kho_mem_phys_bits {
 	DECLARE_BITMAP(preserve, PRESERVE_BITS);
 };
 
+static_assert(sizeof(struct kho_mem_phys_bits) == PAGE_SIZE);
+
 struct kho_mem_phys {
 	/*
 	 * Points to kho_mem_phys_bits, a sparse bitmap array. Each bit is sized
@@ -130,19 +132,19 @@ static struct kho_out kho_out = {
 	.finalized = false,
 };
 
-static void *xa_load_or_alloc(struct xarray *xa, unsigned long index, size_t sz)
+static void *xa_load_or_alloc(struct xarray *xa, unsigned long index)
 {
 	void *res = xa_load(xa, index);
 
 	if (res)
 		return res;
 
-	void *elm __free(kfree) = kzalloc(sz, GFP_KERNEL);
+	void *elm __free(kfree) = kzalloc(PAGE_SIZE, GFP_KERNEL);
 
 	if (!elm)
 		return ERR_PTR(-ENOMEM);
 
-	if (WARN_ON(kho_scratch_overlap(virt_to_phys(elm), sz)))
+	if (WARN_ON(kho_scratch_overlap(virt_to_phys(elm), PAGE_SIZE)))
 		return ERR_PTR(-EINVAL);
 
 	res = xa_cmpxchg(xa, index, NULL, elm, GFP_KERNEL);
@@ -222,8 +224,7 @@ static int __kho_preserve_order(struct kho_mem_track *track, unsigned long pfn,
 		}
 	}
 
-	bits = xa_load_or_alloc(&physxa->phys_bits, pfn_high / PRESERVE_BITS,
-				sizeof(*bits));
+	bits = xa_load_or_alloc(&physxa->phys_bits, pfn_high / PRESERVE_BITS);
 	if (IS_ERR(bits))
 		return PTR_ERR(bits);
 
-- 
2.51.0.915.g61a8936c21-goog


