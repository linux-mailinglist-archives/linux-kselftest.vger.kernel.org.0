Return-Path: <linux-kselftest+bounces-16318-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C2A95F6B4
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 18:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE2811C21D37
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 16:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9098B19755B;
	Mon, 26 Aug 2024 16:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="EDXV1zIg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172FB194C61
	for <linux-kselftest@vger.kernel.org>; Mon, 26 Aug 2024 16:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724690217; cv=none; b=X6W5dJlL8YjrwYA1Lvb3F+0yifwVeHa8dTgJo+lKtPB9s4nr+D4Jesgxq02IuSB4OMIkHej3lGYOf22MdR7hnQ4Bhh6K5fqWbGxmu2DYwnatE/PhnPxahD+HTaypqy4/FVmI6D3CnUX/zsyZFNLLe0+NWv0Tfz3cKUddDJwzg/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724690217; c=relaxed/simple;
	bh=XqOUkInmaOdlhgabGcz+808CcLq83Htv813NZMtziMU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lloalexnLgN1iM+wRPPjc46od14Aa93uAnyxN7o1Ob357e5TikjivzlMFw9ddiJfgjkM4wBxoOjEGoXR5a7o8eiDsdT5JMO+jqXrYmAfCUqR66DvUwIRJEh/guJkeHLe2QZKfswmE+EFshKQbIIVBTR037BuYN6BZENMvd+fGUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=EDXV1zIg; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-70b2421471aso2745968a12.0
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Aug 2024 09:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724690215; x=1725295015; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vwEY/VtoVmU+E8jst/8XYF4V03csuvmXOzOLHGK9FuU=;
        b=EDXV1zIgLnLIsTyJrsVcHikmcEtHV8bs2NTH79BXEQ1s90seWooWTiRyQmUiSgX6aF
         ZEg3/ICvo28IvM4Zu22GejB6g5aGAePAZsUrt/Rd0K9oSjgxgA+kEoyjiahIcSHxhx4j
         GlNJlqOE50WyFM7Ec6z3lAdUFThpECURWChMSzsBPoGVi2xwqBv1+VGNzVjfn6R9ovk7
         JMqA+aH4qYkmshQ/YxyBSZgA1YjOyVQPbdnKQca/WMXEflIVU6G0RKhziPX+TnBkP+0z
         3q3KEAuLAPnrxq9penCTGJF8rdGyLPcqbTGeyTH2ZEL3FvdpdnkcM5QyKEhr1A9ZTdIK
         p3jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724690215; x=1725295015;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vwEY/VtoVmU+E8jst/8XYF4V03csuvmXOzOLHGK9FuU=;
        b=Hn7iHFGcUQtkETfTpcWAyfiLRMRcRgAEg+GF+Xq6HHHCeW0fkFajFGEO8OKP6mHqUu
         LrrwO3uos1D9+/IcRIY0M2vbsLi0grZkDFtZjUKdPOROmyDylHnglpEne1M91pl8s3iZ
         mznUTrrOlCSmLTzvWx7MCXh89rsFJzD6voVXcp58FBh9J6Yi4RF5HfHF+3V3moYo6eEC
         tRpkOswY4lfJm9IOGdD0jrlHzn/Rd33yKzgJjWrqnKaAKZxZ9Fvg76hZ4eUmwjCjeFdC
         DgOfe79v0CsA6YCrXE30oBLmtFGqsQ7SS0BpXnWRIlFjdCO9Wl4hRMElCW0zueqEJkA0
         PA4w==
X-Forwarded-Encrypted: i=1; AJvYcCV20dMzvSTS80hWCjuBqIDDzAj4+bQUVZLNgg19Wt/ZDvY8NY7TiGNpP2gVl2EYDjACdL1Ew91D1q6ug1ExSPA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz0ocvntXCBaCraZQtmJhlyQrCxswEoYj8Qp87nUi1o8Umpx1p
	MMV0AgKEx5y3A1Q4ueoybuvGmtVqL9tdb2re8noXnwWblHyiOSp/6AVZUMAK6to=
X-Google-Smtp-Source: AGHT+IG8QhmkiiyjHn7CNuzuO3cKEPwPnStUmNniRFxIT45XKmbFcpuLujqkeUl+VhROGvvkE85iNg==
X-Received: by 2002:a05:6a21:3401:b0:1c6:a777:4cfa with SMTP id adf61e73a8af0-1cc8b475035mr8486714637.13.1724690215233;
        Mon, 26 Aug 2024 09:36:55 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143434052dsm7174708b3a.217.2024.08.26.09.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 09:36:54 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 26 Aug 2024 09:36:45 -0700
Subject: [PATCH 1/3] Revert "RISC-V: mm: Document mmap changes"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240826-riscv_mmap-v1-1-cd8962afe47f@rivosinc.com>
References: <20240826-riscv_mmap-v1-0-cd8962afe47f@rivosinc.com>
In-Reply-To: <20240826-riscv_mmap-v1-0-cd8962afe47f@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Shuah Khan <shuah@kernel.org>, Yangyu Chen <cyy@cyyself.name>, 
 Levi Zim <rsworktech@outlook.com>, Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>, 
 linux-kselftest@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1682; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=XqOUkInmaOdlhgabGcz+808CcLq83Htv813NZMtziMU=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ9qZ9crHD5wOM37Qun7plPRMb+9NoTsZH2gXqZrrqPotV
 QpY5a7UUcrCIMbBICumyMJzrYG59Y5+2VHRsgkwc1iZQIYwcHEKwEQstzH8lbiy35Wr1fNig5vi
 i2+/j7/w4mc/YXtzUcOKwzUz5Mqf2zP8s8kSC61Yeb3Ztl4vi8N6j4Pw6Rm1q/s5plxPsLT+t/E
 EPwA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

This mmap behavior caused unintended breakages so the behavior has been
changed.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 Documentation/arch/riscv/vm-layout.rst | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/Documentation/arch/riscv/vm-layout.rst b/Documentation/arch/riscv/vm-layout.rst
index 077b968dcc81..eabec99b5852 100644
--- a/Documentation/arch/riscv/vm-layout.rst
+++ b/Documentation/arch/riscv/vm-layout.rst
@@ -134,19 +134,3 @@ RISC-V Linux Kernel SV57
    ffffffff00000000 |  -4     GB | ffffffff7fffffff |    2 GB | modules, BPF
    ffffffff80000000 |  -2     GB | ffffffffffffffff |    2 GB | kernel
   __________________|____________|__________________|_________|____________________________________________________________
-
-
-Userspace VAs
---------------------
-To maintain compatibility with software that relies on the VA space with a
-maximum of 48 bits the kernel will, by default, return virtual addresses to
-userspace from a 48-bit range (sv48). This default behavior is achieved by
-passing 0 into the hint address parameter of mmap. On CPUs with an address space
-smaller than sv48, the CPU maximum supported address space will be the default.
-
-Software can "opt-in" to receiving VAs from another VA space by providing
-a hint address to mmap. When a hint address is passed to mmap, the returned
-address will never use more bits than the hint address. For example, if a hint
-address of `1 << 40` is passed to mmap, a valid returned address will never use
-bits 41 through 63. If no mappable addresses are available in that range, mmap
-will return `MAP_FAILED`.

-- 
2.45.0


