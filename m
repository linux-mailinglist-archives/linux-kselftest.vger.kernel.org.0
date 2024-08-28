Return-Path: <linux-kselftest+bounces-16488-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B26961E87
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 07:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32F371F24F1C
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 05:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01961581F2;
	Wed, 28 Aug 2024 05:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="R9/uZ/W8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA52157490
	for <linux-kselftest@vger.kernel.org>; Wed, 28 Aug 2024 05:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724824183; cv=none; b=kmZGIBBLuJRzQpwV+6iNr1JnRj4N3O62y79ix7z1qi3YEiX6Df+ymwgi9tTl1ZIH619nqC/5Hf1eaOGK24hrauVWdqPDe/wkn3Ej7NPiu2iBWYn91cn4TCyjM52XSyBpRbGz6pt2EtgUlTuyofnMmpCckVNsbAfKajAsJVM1m74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724824183; c=relaxed/simple;
	bh=+G9/grHdHxL6H0Lnh65S6ISh5epJb2mrAov/AP0hs9c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tT1sw7TF5cf4j7Muz/1PAfQAfppUIw0dVmw1VTQDcL3ulvMzenRliAYiYZTzp9Vi/lklVAV5UvV+eCB2KRilqoVfo54uOdEm3GpjI2+Tk3keFnZAw6c7TK+vLIOZYYvbzDvXkiKeh+oCSBqUa8eb5LRVV3tPDfTScex/JxJyrAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=R9/uZ/W8; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7bb75419123so4031728a12.3
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Aug 2024 22:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724824180; x=1725428980; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g+f5iieqZfHqFwlVhHOpYZvOeyZcJe//7AT/XT4juc0=;
        b=R9/uZ/W8exlYwbda5G8/WoU4tYtwc8WFo/HO3pozbVVvRLjRwD+C/ar84lYkt+HV7Q
         ENGtsOF4irdelOGheysi2XRDk5RcnoEmQE5tf/OjFpYdEtUhb5ddC8cJop20O4HV9jzO
         nQxx75phs57HxxeuES4EXEFsSAn0L0O/+zxskhBYv81W9qvpapPv0MHXDItTcb9lU13p
         zxG5h9tfoYieggttCbQWjJckRXPCGtAGMBWqIpbnM6Gn8qcfK+ompzyMtOs1PxUlJtO9
         RqMpmNRr1HirP6qb2Pu1F7Cg8DfBn/Xwym/wI0hAP2yaE5AmWgiw1cArBq419afvp9XO
         LGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724824180; x=1725428980;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g+f5iieqZfHqFwlVhHOpYZvOeyZcJe//7AT/XT4juc0=;
        b=jPxnjO7UKPZBDRfNo+YQr6iIx7V0SwecueTjBJ69623ZSbCcyGqv/SJFG3UfrmNQqZ
         c9Km3lNI2/6W2PqLfMdT5ydKM27aLgvg2RbwVdVVPiAGPmhau5uN4Pq7undMorrVTURv
         H+R/qC5tx0ZKkzGH7jPVaIOhixlvDu20fbFeLyjNzQdtvzFjyGqLDDpgo+3sDQMSNoDT
         nesYZFOopUj/zw5x7qs50dYXi2AjoOQVHrFq6sD3/nn3PKJl/sYNe5xlCB/0iBn2Z2qJ
         a2dUCvo8khSUxPVLPbnd2DG/xi41VxYAnM5X4e0MlIoBSth0wYZ7+0NaRfNw9Qi3jQ7U
         Crvw==
X-Forwarded-Encrypted: i=1; AJvYcCWCwaaGY7NPR+BdBDcIrNPjZqBAwOB1M7atpOkcE012IPZd/pHt3gWm0ssnQqdRxoG9AFaz5M6FDCBa3+QrOh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YweuZNQ02dwzK6W7XQwP4p2dJAbzXnkAH3Ne/ad6PxBDi7aG2na
	p+bWJ3ikWb5B2UhywoJdFRE5/jdx16ALoOb2b8RNsfjReiGK4yxpf0795syH2Gk=
X-Google-Smtp-Source: AGHT+IGKYEbmAbccdwLglj8Rtz7Ncms8BNc+Vjhrih2XUvI/cV2bfefpghFryVXCiPvCQUUiKdRNjQ==
X-Received: by 2002:a05:6a21:3401:b0:1c6:a777:4cfa with SMTP id adf61e73a8af0-1cc8b475035mr13030363637.13.1724824179851;
        Tue, 27 Aug 2024 22:49:39 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855df0c4sm92092495ad.157.2024.08.27.22.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 22:49:39 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 27 Aug 2024 22:49:10 -0700
Subject: [PATCH 04/16] mm: Add generic MAP_BELOW_HINT
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240827-patches-below_hint_mmap-v1-4-46ff2eb9022d@rivosinc.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2165; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=+G9/grHdHxL6H0Lnh65S6ISh5epJb2mrAov/AP0hs9c=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ9q5XXGZXkeVtgeold2b3dqjkt+vEXMu6H6oc1bJNYtbJ
 3aetlzTUcrCIMbBICumyMJzrYG59Y5+2VHRsgkwc1iZQIYwcHEKwERWFTEyNKap9S5rOHHkFBPT
 SkUp8yq1Cd/4ljyftDBFnmW663I5b4Z/RluSpK/6drw7JD8vOuPN75znwc73OQp/v/2R9GK2Tfl
 mPgA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Make the generic implementation of arch_get_mmap_base() and
arch_get_mmap_end() support MAP_BELOW_HINT.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 include/linux/sched/mm.h | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 265b43855d0b..c350bb5ac0a2 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -9,6 +9,7 @@
 #include <linux/gfp.h>
 #include <linux/sync_core.h>
 #include <linux/sched/coredump.h>
+#include <uapi/asm/mman.h>
 
 /*
  * Routines for handling mm_structs
@@ -170,11 +171,40 @@ static inline void mm_update_next_owner(struct mm_struct *mm)
 
 #ifdef CONFIG_MMU
 #ifndef arch_get_mmap_end
-#define arch_get_mmap_end(addr, len, flags)	(TASK_SIZE)
+#define arch_get_mmap_end(addr, len, flags)							\
+({												\
+	unsigned long mmap_end;									\
+	typeof(flags) _flags = (flags);								\
+	typeof(addr) _addr = (addr);								\
+	typeof(len) _len = (len);								\
+	mmap_end = TASK_SIZE;									\
+	if (_flags & MAP_BELOW_HINT && _addr != 0)						\
+		mmap_end = MIN(mmap_end, _addr + _len);						\
+	mmap_end;										\
+})
 #endif
 
 #ifndef arch_get_mmap_base
-#define arch_get_mmap_base(addr, len, base, flags) (base)
+/*
+ * rnd_gap is defined to be (STACK_TOP - _base) due to the definition of
+ * mmap_base in mm/util.c
+ *
+ * Assumes ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT, which all architectures that
+ * implement generic mmap use
+ */
+#define arch_get_mmap_base(addr, len, base, flags)						\
+({												\
+	unsigned long mmap_base;								\
+	typeof(flags) _flags = (flags);								\
+	typeof(addr) _addr = (addr);								\
+	typeof(base) _base = (base);								\
+	typeof(len) _len = (len);								\
+	unsigned long rnd_gap = STACK_TOP - _base;						\
+	mmap_base = _base;									\
+	if (_flags & MAP_BELOW_HINT && _addr != 0)						\
+		mmap_base = MIN(mmap_base, (_addr + _len) - rnd_gap);				\
+	mmap_base;										\
+})
 #endif
 
 extern void arch_pick_mmap_layout(struct mm_struct *mm,

-- 
2.45.0


