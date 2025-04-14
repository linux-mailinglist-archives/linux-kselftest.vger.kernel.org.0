Return-Path: <linux-kselftest+bounces-30674-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7913BA8807E
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 14:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B1173AE079
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 12:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFF82BF3D7;
	Mon, 14 Apr 2025 12:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="1NE6LcXk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6255D2BEC5B
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 12:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744634161; cv=none; b=XWxgqOi56MoUnoBirC6bM5AuAfSElqZqjqCQYhi0lvNoULUTGVr8UeTDQWmGyA8aY7ikOzEj5CE6no9iP741UwM+YV4KVwqMYybzgFKaf27k3p4x/F8LjhypAxzgiI1vdTyuzNRlpvBpUPJnnBfSnYPxnTLJDtfVOEdRmHycQGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744634161; c=relaxed/simple;
	bh=AyXNAWI0/0gE40uumDJpJdOVMNYZDU5mvwjK3PbJnn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CHAc7eSLhv4NpWucmCqQiYGlM4XFf1SNeEZTkYo7neOsvPotETm2bhoxoHehnvpNp7W2NY5U7PLOt+KsG7UFazCUjri3ISrpn7R60EsCAjmRV5SLxrhmlfKhsh+RLTbbsdnR5TKvUFBbq5ErgNs4gpAhGwcmVK+h1RXrjuSzoLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=1NE6LcXk; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-391342fc1f6so3534514f8f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 05:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1744634158; x=1745238958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SBLPFCAF2kFHPFPqsZ7gzO7W+qircTgsDB5v3GeiCmE=;
        b=1NE6LcXkxxL3S9zlYHYBm6sE5ZWJeVpWp8+WfofbB9p758pe/xMtCdBWNKt/vL3yOK
         yMgETPtgpEHdp7oczCcBkrDtypy0wH9nEA09AC2uw2S09sEXSM7SY0VAQU//0AxtrplG
         3gZfRS6gwe8drMBzXNT1C6R9B7145R1R2IIJL+/dw7Lhfied7nS8prTNLB/yKUDSkDvs
         ZdHQEsIL9/4kARghdNYzYddQXufdwOHAsRzncWimALGUyhv9DBkiYa0v6DMtoZQsnjXM
         QXD3OIHplCfzB0nZKJuipFMAvKZFMo0XcAsIKgL2NnQEr/Y5A00kwC1bytGFgl2fBdRR
         kihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744634158; x=1745238958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SBLPFCAF2kFHPFPqsZ7gzO7W+qircTgsDB5v3GeiCmE=;
        b=trhgukiGsDwzCyyXYv0XHj4XsCIi0MuRWuUyoYEDme2FVAuJ0a+afS67moBidpCmu2
         IkWtSymHDy5riKilLryPtFfDajZUNlM26fb+HwYGStOuLRRN4vQwAuDvSUkHAsxwW2g/
         21egh/s+G7BeiL+WA6DHeevCEPqz68izTwo8MVFm2BkHwrAYZcHW2eEG8kFZY9k2wuJr
         PD3eJwmbqe34BkD7EA7RQPxcojGjbR8Ke3clxxcKGIeyIh74Ih0HJdAGnryZ+2w4EjLH
         alY54PUWiq3BnUXDbAXOFQmfYlN6BnW2pUrm4XbGkrFaj8wxscJ6kMNad1574bSjkstj
         JUgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjd/5Mua9TWyF1bzQ/ux0m2jyra1fhqoPp1wxE+lnffg5lDlQa5qmzELEczlTky/TpGDyIdTWPXtJ/Va3O0b0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy/urpoZ/TbMb0kh/D9sEZzAWfEiu2J+QwsNJzvbVcvIjMjBvJ
	7k/URmwA5l/2zCseZPVDasjbTJ9hav36iU6zv2RHjHlPDuwmsGydWYHIfDFzGeA=
X-Gm-Gg: ASbGncvCnyXqby0v+bMyzIAGbWUWdI8I8UGs8wKqVehehB7tsX/3SK0HAhkZ/YG7Pya
	AtTpWfGFD4NjUK4aBy9X6DjgoxScwxc5JoDBU85XKjKN32FuIdj0c0rHyVOPGUyiLxUnSHqPIKL
	geWYKrfglJbuaX1evnVdIC+fvUyquEdZDbN01RDvQrIc+ax6MLcbv8aniKDowX359fqnDoyIxDb
	SOkEDlc5hkF3pPHby1uqyUS+Rh+tHSRUmHUTyEqk/ULgMwHRrjsl3S6Dr9Cp1mDHaSVtJy41xgF
	aTtqyTeATE36s9JyXG/95o/TvA4YyfnRyK4FOUDn5kK9hnwCcW5j
X-Google-Smtp-Source: AGHT+IE7ESI9/ydkjbVeedcglNd5VgE6W7NzmKgufSbnzN+RWnm218oxoJgC0K2N8RXVX/uDv+F3kg==
X-Received: by 2002:a5d:5847:0:b0:391:1218:d5f7 with SMTP id ffacd0b85a97d-39eaaebebd2mr10756640f8f.40.1744634157684;
        Mon, 14 Apr 2025 05:35:57 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae9780a0sm11003166f8f.50.2025.04.14.05.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 05:35:57 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list),
	linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Shuah Khan <shuah@kernel.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH 4/5] Documentation/sysctl: add riscv to unaligned-trap supported archs
Date: Mon, 14 Apr 2025 14:34:44 +0200
Message-ID: <20250414123543.1615478-5-cleger@rivosinc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250414123543.1615478-1-cleger@rivosinc.com>
References: <20250414123543.1615478-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

riscv supports the "unaligned-trap" sysctl variable, add it to the list
of supported architectures.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 Documentation/admin-guide/sysctl/kernel.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index dd49a89a62d3..a38e91c4d92c 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1595,8 +1595,8 @@ unaligned-trap
 
 On architectures where unaligned accesses cause traps, and where this
 feature is supported (``CONFIG_SYSCTL_ARCH_UNALIGN_ALLOW``; currently,
-``arc``, ``parisc`` and ``loongarch``), controls whether unaligned traps
-are caught and emulated (instead of failing).
+``arc``, ``parisc``, ``loongarch`` and ``riscv``), controls whether unaligned
+traps are caught and emulated (instead of failing).
 
 = ========================================================
 0 Do not emulate unaligned accesses.
-- 
2.49.0


