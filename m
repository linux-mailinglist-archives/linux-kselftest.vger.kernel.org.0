Return-Path: <linux-kselftest+bounces-16498-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E02BE961ED5
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 07:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AFFCB2350E
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 05:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2DC15CD77;
	Wed, 28 Aug 2024 05:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="lTANVF6G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCD515C158
	for <linux-kselftest@vger.kernel.org>; Wed, 28 Aug 2024 05:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724824216; cv=none; b=Wj3H8Xk5I0SxsTb7BisvL1GfmPrOmYBXh4+EXJKdsmSC3KHfGUpWa9cqkBIwdD5UP9cy5x/B5UFONOogMjvWfNU9/9RSksPA9h0a8Wzbj7CxiPXFcYHW5Mi1PDvQqfyBCO+p98XdIdOfCjUS9ivhPI+7e1M+By86gA97YYr1YtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724824216; c=relaxed/simple;
	bh=RSW/tCXIl3OqIq1wugK/BMhqzVxC+hGCJaNgaxgxyH4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=REevhrA9R6HFSIcGMfOCd3anUdbAJZ4wL1NBt7TrKmGho0BNOs+l9YpzJuOQkOEQTpFkHpJqAUPl8cGqgjtYLJEKmw/ig7xfII2hSj++sslGezAPqmK3LiGQsYyFeo2U2VUhksPU7AOgIhdJxz1aWLcoDzozwoetO8uQfyHZPzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=lTANVF6G; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2025031eb60so55565555ad.3
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Aug 2024 22:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724824214; x=1725429014; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=74ih38qyFApS59Oo5hAHcKEdd4ieUrnz9WHar/pXDMA=;
        b=lTANVF6Gx2bYjS/KtY3gGTNop8eWVgc76TD+L+Ti344dFQoh1l97ok5aAgfQWnPHTw
         mSXyfdOJy4/X7mMFAbVmk5/FRZ6Cz/IuXklPryGGzYKliQqyV9l/JCb38RBrMZ3+6XMi
         6TF/vXvgtOD9sixcXhGdIrhJBYsdbn7CwHq5GvX3P/p7Sw6kwCL2UyL9Kkmij0PE9wgN
         sB/P96sRNjeimw56tUyO0iO6owkSJvc9ib9/tGInOdeoKh5h4Abe/4+Hz6iXFY+6/Aqv
         hLTeE+LIKeSFBtN43m5K+KJ8nZnwgFvpQzFjKFfjgVcyJvPQxXRTL5wBmWaz+VlZS3xB
         Judw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724824214; x=1725429014;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=74ih38qyFApS59Oo5hAHcKEdd4ieUrnz9WHar/pXDMA=;
        b=lYWWYZ4aQe1UkIQNiTB/tO4tt61zCLiESH76KNFrMGtH4TJh54GFwxcpCRzFeZOCke
         IykwpH5Uiv5lbFTOmzibzYwr/GjKtA1kXj88nZxhoE0gpPaYT/yUvgKR0orFoXDJsChZ
         ME3xEM3IUcm7UYm0d6Q1rvZpmm6EfzDvL6fH0CHEEKMPvGdgRfZjYQJhlg2yXSj+j/am
         X3++7/Yq6V3MxeX6TqdnqS3FHXsWkqa7xkvvkIehKfJZBtYdiLUVnOiAEHGs6teIqGv5
         QwoqOT7Ler8ACNXV85DYItMkHkviXVUqV6PIP9X2ZcW0HZIfX8WzYVbmEWse50vT7kFf
         wKWw==
X-Forwarded-Encrypted: i=1; AJvYcCWth6WaZ5AI5AxVLQmvlRK6K+QQvCcYgc1EMEgJGIEUl3vK5H/OpYjqWkDXTpM7MSZnu76/MCZjHKR6MeSqjIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJRMxMl4Fz/LiE+ZPe0deXj6CYx7DwNCPdeCDf1dlmpiYVof1e
	7J6RbwPJig8fjIJ8K5eCufHjKdCpB/ecG0FGNDo1BPxY/R3Zu3CLZd/QbM3MIfA=
X-Google-Smtp-Source: AGHT+IHaxH8ov/UqUPxBA8x0bmmHbs3R6mKOF+WDurSlvopgHqFjxqmjotSQ0dAp9h1od2RsPmTDOA==
X-Received: by 2002:a17:902:e852:b0:200:ac2c:6785 with SMTP id d9443c01a7336-2039e44cbcdmr164066655ad.3.1724824213959;
        Tue, 27 Aug 2024 22:50:13 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855df0c4sm92092495ad.157.2024.08.27.22.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 22:50:13 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 27 Aug 2024 22:49:20 -0700
Subject: [PATCH 14/16] sh: mm: Support MAP_BELOW_HINT
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240827-patches-below_hint_mmap-v1-14-46ff2eb9022d@rivosinc.com>
References: <20240827-patches-below_hint_mmap-v1-0-46ff2eb9022d@rivosinc.com>
In-Reply-To: <20240827-patches-below_hint_mmap-v1-0-46ff2eb9022d@rivosinc.com>
To: Arnd Bergmann <arnd@arndb.de>, Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Russell King <linux@armlinux.org.uk>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Shuah Khan <shuah@kernel.org>, 
 Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
 linux-mm@kvack.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
 linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1729; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=RSW/tCXIl3OqIq1wugK/BMhqzVxC+hGCJaNgaxgxyH4=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ9q5XYlVP75VR006aZFn+70kVT1K4PGO6plPeD6ttY1Ib
 fZuvX6uo5SFQYyDQVZMkYXnWgNz6x39sqOiZRNg5rAygQxh4OIUgInsXsrw34+bSWfTiYerug+W
 bJm2uPHhi6ei0zVPGCvcutghUP70ggcjQ8uKDy93HJCN5MpSDQ5Y9+eF9/TONIm5nufepW33SA2
 /wgMA
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Add support for MAP_BELOW_HINT to mmap by restricting high_limit to addr
when the flag is enabled.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/sh/mm/mmap.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/sh/mm/mmap.c b/arch/sh/mm/mmap.c
index bee329d4149a..867f6598b7d0 100644
--- a/arch/sh/mm/mmap.c
+++ b/arch/sh/mm/mmap.c
@@ -91,6 +91,8 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	info.length = len;
 	info.low_limit = TASK_UNMAPPED_BASE;
 	info.high_limit = TASK_SIZE;
+	if (flags & MAP_BELOW_HINT)
+		info.high_limit = MIN(info.high_limit, addr + len);
 	info.align_mask = do_colour_align ? (PAGE_MASK & shm_align_mask) : 0;
 	info.align_offset = pgoff << PAGE_SHIFT;
 	return vm_unmapped_area(&info);
@@ -141,6 +143,12 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	info.length = len;
 	info.low_limit = PAGE_SIZE;
 	info.high_limit = mm->mmap_base;
+	if (flags & MAP_BELOW_HINT)
+		/*
+		 * Subtract (STACK_TOP - mm->mmap_base) to get random
+		 * offset defined in mmap_base() in mm/util.c
+		 */
+		info.high_limit = MIN(info.high_limit, (addr + len) - (STACK_TOP - mm->mmap_base));
 	info.align_mask = do_colour_align ? (PAGE_MASK & shm_align_mask) : 0;
 	info.align_offset = pgoff << PAGE_SHIFT;
 	addr = vm_unmapped_area(&info);
@@ -156,6 +164,8 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 		info.flags = 0;
 		info.low_limit = TASK_UNMAPPED_BASE;
 		info.high_limit = TASK_SIZE;
+		if (flags & MAP_BELOW_HINT)
+			info.high_limit = MIN(info.high_limit, addr + len);
 		addr = vm_unmapped_area(&info);
 	}
 

-- 
2.45.0


