Return-Path: <linux-kselftest+bounces-3275-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5144F83368E
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jan 2024 22:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0994D282E17
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jan 2024 21:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E901428C;
	Sat, 20 Jan 2024 21:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="tkkUO3X1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB69714F60;
	Sat, 20 Jan 2024 21:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705787415; cv=none; b=ONFNLdnCFHY3blq2RHYlUptgAmckaEUT25P8oYfQg94Y7sYKUhCs94ets0irJjF8z9qvmBX+JSyP9WPkyrf7BkIyaTx0cFkX6C+7CzQyP5v2TN+6NKPl7dEvIq3G0es4VFn4fdz0WtyTUUBkg80DOzIY6cydQ+BqIj0YD4R+Pjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705787415; c=relaxed/simple;
	bh=a9pi9qCyi/Wbo2s5gPt5UbxvztVeuOA7S5vL/DjBm04=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=f1VoGeH07HHhlHskSmHuoVq5X2Lvla6CKsKVjiG2O15Si3wCbVmb/fGIx2S74jYP4k3ecpXvWizl8GcFi7idszJfveVnOyeitxq75h+FDNwen4mEcfj3AgzVcyPG10MpCRUMPsE9af6VB1Te17aQs2QrOwT6EbB5tUyLEG/u7fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=tkkUO3X1; arc=none smtp.client-ip=203.205.221.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1705787410; bh=wiHZS6ft7NfH/87XosWxG0akHz17+zK84hbyOL+xbfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=tkkUO3X12YqAA6at4NtFba+0ASKEt/e1buGrCZ49fvDwevmnFg4aozaujW4uZqrQf
	 9p/LzQft4WyK9gnsuENQG5R58YR9AYOVASo4oYcexxZQl3A3PjYwBoesdUhKvQy6Gc
	 /raIZ/wH/vB6k4dyk9xiEJhPFTqXx+F8HFTHGVM4=
Received: from cyy-pc.lan ([240e:379:2240:ed00:c92f:86c3:e615:ca18])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id C832D4DD; Sun, 21 Jan 2024 05:50:03 +0800
X-QQ-mid: xmsmtpt1705787408t5oxeyvxb
Message-ID: <tencent_6ADF31EB216F8DAA7C608268DA008EB6B808@qq.com>
X-QQ-XMAILINFO: MUa7vzS8moCUhEfLw/vyx4sgUoBQIP3idQluppaaYziV3yUX8uYoR2EirwDl7R
	 y6qE4vaWFEn5uxFjflYiQ8TUINCgioSfsy9gQhrXXNQmC51UBKKhIbDHdDwsLwviIV5p4sdmbcun
	 saTHYKScF7sDkCM7DSqASJUBmsDe8GN6X+m01eSCsNuqoI0KlrVfHfbv6xpGwDPeDu2BITu9udcJ
	 G04ri04Dfw/gfWaSeyrUsvCzlGo+EiOPx9L1plLGRyJ7NZu7VJabM1TWGLGNEQpcXrRNY5vNd2oj
	 u92FFLOA5riEAFvFJQixJcxj8zCxfkpvCe45k8F2piIjOcHens8A3WAWpSadsTHzHaSjYQy3NUE3
	 uXqvSkqZfm6LTytactOFHwCPZzhf4RmNMx3GR9CienhFl7Wb8J6wD6j+i2PWMYUNaiuikzMZc9qE
	 ex8dNUHc5bz0rAVVWdmYqQBcT2K57tJSv+NgZ6aaqSw803GwiGdJ4uA78iRiF9ggoaicwrGpwbP0
	 k37nREd1kVJJC1GqDarjb1GfLk+KKNDZsjTkYbIJAyGyh9bmneNEY0gkd0EFrtWtNRXuzWM7cyGh
	 BmW8DiDkzQPGBUBizBlGesZBIAR3+jOc8oklmcdhIpskiz6NBejwmqhcflUByoyYU+7YKQWr4yC0
	 U7g8Lvy2egmT/Fi7nuu/Qup6n6vtbzjgos9xrOMCKNzs9dOGomlWy1vFF/RwNAn0UGSDQpA8UdKj
	 IDVxpPms0JmykcH2uDSY0HmvESHh7qi6TwnvRsqWx38TFUal2wXLebe52f1mf5wRwQ2pKGuBzDc3
	 2mLKPyn6uVYw2ftdxx5yJXazQN4k3d9jyta3qR6BI3zh3lkXZZpG2DEJAa0cIxm7iIDeUVGVZQyL
	 OPNpl/t8shZLdc/5FnUQz3uE6y0eivYs0yipJFkxpBw2KEnAUY4MeSeafi0SjWDRBxVF+yFa5SPH
	 RW+/qeYJngV9W13p7qDKgCAygh6UCBys9beE2YE7qh5f6ApmdN4At3Eeh6vPQjG6Yb6tky4RoICb
	 UQ8JGUr/2fB8vGt4WQaU+gLpzfbqjT8NWr6dEy1tayhO7FCmXt
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Yangyu Chen <cyy@cyyself.name>
To: linux-riscv@lists.infradead.org
Cc: Charlie Jenkins <charlie@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Guo Ren <guoren@kernel.org>,
	Andy Chiu <andy.chiu@sifive.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH v2 3/3] Documentation: riscv: correct sv57 kernel behavior
Date: Sun, 21 Jan 2024 05:50:00 +0800
X-OQ-MSGID: <20240120215000.291877-3-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_B2D0435BC011135736262764B511994F4805@qq.com>
References: <tencent_B2D0435BC011135736262764B511994F4805@qq.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The original documentation from the previous patchset[1] treated the hint
address on mmap as the upper bound, since we have already removed this
behavior, this document should be updated. Most of the content is copied
from the corresponding feature in x86_64 with some modifications to align
with the current kernel's behavior on RISC-V.

[1]. https://lore.kernel.org/linux-riscv/20230809232218.849726-1-charlie@rivosinc.com/

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
 Documentation/arch/riscv/vm-layout.rst | 54 ++++++++++++++++----------
 1 file changed, 34 insertions(+), 20 deletions(-)

diff --git a/Documentation/arch/riscv/vm-layout.rst b/Documentation/arch/riscv/vm-layout.rst
index 69ff6da1dbf8..9d84362b9f91 100644
--- a/Documentation/arch/riscv/vm-layout.rst
+++ b/Documentation/arch/riscv/vm-layout.rst
@@ -135,23 +135,37 @@ RISC-V Linux Kernel SV57
   __________________|____________|__________________|_________|____________________________________________________________
 
 
-Userspace VAs
---------------------
-To maintain compatibility with software that relies on the VA space with a
-maximum of 48 bits the kernel will, by default, return virtual addresses to
-userspace from a 48-bit range (sv48). This default behavior is achieved by
-passing 0 into the hint address parameter of mmap. On CPUs with an address space
-smaller than sv48, the CPU maximum supported address space will be the default.
-
-Software can "opt-in" to receiving VAs from another VA space by providing
-a hint address to mmap. A hint address passed to mmap will cause the largest
-address space that fits entirely into the hint to be used, unless there is no
-space left in the address space. If there is no space available in the requested
-address space, an address in the next smallest available address space will be
-returned.
-
-For example, in order to obtain 48-bit VA space, a hint address greater than
-:code:`1 << 47` must be provided. Note that this is 47 due to sv48 userspace
-ending at :code:`1 << 47` and the addresses beyond this are reserved for the
-kernel. Similarly, to obtain 57-bit VA space addresses, a hint address greater
-than or equal to :code:`1 << 56` must be provided.
+User-space and large virtual address space
+==========================================
+On RISC-V, Sv57 paging enables 56-bit userspace virtual address space.
+Not all user space is ready to handle wide addresses. It's known that
+at least some JIT compilers use higher bits in pointers to encode their
+information. It collides with valid pointers with Sv57 paging and leads
+to crashes.
+
+To mitigate this, we are not going to allocate virtual address space
+above 47-bit by default. And on kernel v6.6-v6.7, that is 38-bit by
+default.
+
+But userspace can ask for allocation from full address space by
+specifying hint address (with or without MAP_FIXED) above 47-bits, or
+hint address + size above 47-bits with MAP_FIXED.
+
+If hint address set above 47-bit, but MAP_FIXED is not specified, we try
+to look for unmapped area by specified address. If it's already
+occupied, we look for unmapped area in *full* address space, rather than
+from 47-bit window.
+
+A high hint address would only affect the allocation in question, but not
+any future mmap()s.
+
+Specifying high hint address without MAP_FIXED on older kernel or on
+machine without Sv57 paging support is safe. On kernel v6.6-v6.7, the
+hint will be treated as the upper bound of the address space to search,
+but this was removed in the future version of kernels. On kernel older
+than v6.6 or on machine without Sv57 paging support, the kernel will
+fall back to allocation from the supported address space.
+
+This approach helps to easily make application's memory allocator aware
+about large address space without manually tracking allocated virtual
+address space.
-- 
2.43.0


