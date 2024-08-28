Return-Path: <linux-kselftest+bounces-16493-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D58961EA9
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 07:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B3061C2101B
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 05:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D7615A853;
	Wed, 28 Aug 2024 05:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Q3l9KkWx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF66F15A4B0
	for <linux-kselftest@vger.kernel.org>; Wed, 28 Aug 2024 05:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724824199; cv=none; b=pPJjYdrwOTxuaL0q8Wo/CDCW6NAC34RIwKhTt1lifSas8Ca9vv6PkSB29FQaQi3qaqvSjEQynrC79EsWp+ZVIaZ0YnBS2ub/Iyu2b41Qrqsp9+OLvDpGcyxxs+FKvvQgrecf3WImaytgH4kKsLCVejUgK7Id1u7LylYOq4rvXLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724824199; c=relaxed/simple;
	bh=mXZWgvc5d3nCYQqiz9PUCvFecQkJ9kp2ZooPsTsZSyA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t8mlkVGRkT63dLRRfbx52dht1PllU0amrT4GXf8vhCn4tsiXvGh7t1EJychA5SuFqrSqAx1ZgRrur5mlumNVgo25EQXdUvZnO6CXCgVTgSk7RarfjaxFSG1uWGNms2wQoSxFxDbBK5dfQBIaYEu8jscrd9OD8I/IIkDYTEMT1p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Q3l9KkWx; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2021c08b95cso2123835ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Aug 2024 22:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724824197; x=1725428997; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YNQglkp2lEnIf2YsbVUEYoAS4AW64pe58tBCUjsMipk=;
        b=Q3l9KkWxuZ+ar/UVTjHJR1sYf6g/+SI1qVdDAdbnFWaZL11g4KozmPS++LP+AdhyPa
         2kZ7DfKWgHSLaTUInrT6PHxWtu9VGwiYFMAVwqAhxBlhuU04lMqTAW2shPkAyWmQgZPH
         0EwXK2sT7fwMKtnNm+eiX+hSekS1XCqxVyuaP4SDPucw6+s8ahCJO9HL/umkd5SQ7hDH
         oA4Zhp9FODaWfW3EKoG7mdGA5HRe/lRnAg6s0lgoBdxS8cZUkdJmLeGNosby9wsW5ZkO
         VK2a5mzDpi63qnY77INw10sSHD4qvCnDB6B1SwYvhQr72Gvlq1wPYYNv1x/D6051zO3X
         Rokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724824197; x=1725428997;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YNQglkp2lEnIf2YsbVUEYoAS4AW64pe58tBCUjsMipk=;
        b=CK2kUtf1nT3yz+4z1c9LnREvyNdyf5+RHthnYEh+cB11ueZXX82xVvpEtbKPhZLVD6
         yMK8zmIxBPUExzARWh2gAcZXG91pIQsG3pfdrlFDKOnfSClKO5M12Z4/BM0xFoGzH8US
         30yDPpvgO76d6P1DjT8NEO0fmnXl9dGAwKys+JnFH9C/kWhSV5KbozFz2T2QSa+lPPHA
         pW82ikoPvYrolXd3GzSFA3eKEjBfw4G2n8HVcwu+JPaoYWtXVFRQPJnfNFGyAzF3ebzS
         Yy2gwzcbJl3D6HsXRYuygJXaeiXnEii346PAemsniL0KzR+kTXez1APd7yGyC4m2DjAX
         TZkA==
X-Forwarded-Encrypted: i=1; AJvYcCUnVWB8Q+cjeo1rFZDe7Tli8khgAtpLW7WNdmk0wMQdpmcSY93LX5yGKstI3sqHHWTasRlninR+Od3xAwPhkB8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywomk2vLb/N4EoQjdYlL8BadGuVccLeIKJGRji4Do/PkNszj8pH
	WoRpR6221lR8b/HKiKBipwrdcPGCdEas3lso8gZAsW0JbabHT3EjKOjF5zEazGc=
X-Google-Smtp-Source: AGHT+IFNvFc3w8ZqIqMUtm2tpVZkKTF+VkfsFh2Ia3nc64cPU9VogTthyuHsPbt4BWtQWf7nibqVyQ==
X-Received: by 2002:a17:903:35d0:b0:1fc:41c0:7a82 with SMTP id d9443c01a7336-204f9912733mr19643175ad.0.1724824196945;
        Tue, 27 Aug 2024 22:49:56 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855df0c4sm92092495ad.157.2024.08.27.22.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 22:49:56 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 27 Aug 2024 22:49:15 -0700
Subject: [PATCH 09/16] loongarch: mm: Support MAP_BELOW_HINT
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240827-patches-below_hint_mmap-v1-9-46ff2eb9022d@rivosinc.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1259; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=mXZWgvc5d3nCYQqiz9PUCvFecQkJ9kp2ZooPsTsZSyA=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ9q5XfFl5t2npeO1W6ydtL9v1qitmfF53Tr5I+FmGy5eX
 hv8Y0JgRykLgxgHg6yYIgvPtQbm1jv6ZUdFyybAzGFlAhnCwMUpABeJZGTYs2fGyX1L7U5s/pDP
 9zI7cOPnH9u8t8ZNYFCaqKg8I9+uk+F/YeihTo3z92Iv3r2a7r74pUGE/VYuj+S6OkvJ82tdPk5
 nAgA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Add support for MAP_BELOW_HINT to mmap by restricting high_limit to addr
when the flag is enabled.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/loongarch/mm/mmap.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/loongarch/mm/mmap.c b/arch/loongarch/mm/mmap.c
index 889030985135..66a5badf849b 100644
--- a/arch/loongarch/mm/mmap.c
+++ b/arch/loongarch/mm/mmap.c
@@ -70,6 +70,13 @@ static unsigned long arch_get_unmapped_area_common(struct file *filp,
 		info.flags = VM_UNMAPPED_AREA_TOPDOWN;
 		info.low_limit = PAGE_SIZE;
 		info.high_limit = mm->mmap_base;
+		if (flags & MAP_BELOW_HINT)
+			/*
+			 * Subtract (STACK_TOP - mm->mmap_base) to get random
+			 * offset defined in mmap_base() in mm/util.c
+			 */
+			info.high_limit = MIN(mm->mmap_base,
+					      (addr + len) - (STACK_TOP - mm->mmap_base))
 		addr = vm_unmapped_area(&info);
 
 		if (!(addr & ~PAGE_MASK))
@@ -84,7 +91,11 @@ static unsigned long arch_get_unmapped_area_common(struct file *filp,
 	}
 
 	info.low_limit = mm->mmap_base;
+
 	info.high_limit = TASK_SIZE;
+	if (flags & MAP_BELOW_HINT)
+		info.high_limit = MIN(info.high_limit, addr + len);
+
 	return vm_unmapped_area(&info);
 }
 

-- 
2.45.0


