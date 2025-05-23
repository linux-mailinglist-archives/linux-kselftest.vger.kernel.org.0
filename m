Return-Path: <linux-kselftest+bounces-33708-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B7CAC2C3E
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 01:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDDE47B9209
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 23:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEE021FF47;
	Fri, 23 May 2025 23:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="clyElYOL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289652206A4
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 23:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748043049; cv=none; b=QlweXRAm96vm4QdRXx/X1mO3e3lFEX6aERizsyaC9TDXFNFKZusxdR3UXlo/7UFM4SY8be9OoOy6JPPds3A+x2VQ9k1Ryjd7ivBOQ8HFKKYTBQyzV7LTMUS79RGayVDQPPv+Anufr6eWi8UX8H54u5ZiW/IAtk/gC/l0qEy2eGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748043049; c=relaxed/simple;
	bh=ZEeuqzhNqBeR9D3FbDGkg2H0ODgiTIhewgLnEmoimOY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Wpn68pzOOP2sonkuF2Q32aHOxoLVJRkFJ9+7m83bTH/r8OkYumI5TUxRwIA7p7oV73lvRE2mXOoxOpA9/cJO8H8LPHFCijnUw+pnKs83hW0bjGh8znpr+c093naBltNTH8BqpgTWUPtK1nXvX5R3yd3gbRF6Uk/UsQK2F83KMLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=clyElYOL; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-74299055c3dso607281b3a.0
        for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 16:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748043047; x=1748647847; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wF2Vo6L9fSrAm9diEZkgkQAIhN6qflD88Jat6gXXNmE=;
        b=clyElYOLUHnNh/qJ3APYa1NZKJny3HqgVdsQgbq+sjmKU61tSlV8xip09dpy+Ad6qd
         omkuuGivDpO2jlE8fXdKAMf114HzZFwxdounacqQRAtCRdqS+Pw6QbWXfsz2uGIrOwo1
         OK03tCLWNU9sKLf1QxGpUyU3s6IqNJk7cCL7uoAvWTfT9bn/vFJmzzTG+KVSymlRYP1E
         7Tzz+LrUQB71vFxoWtj6RkWZBHItC+/AikJS7KkSrZPoe4XR+9tJYEz78JIWSbDZsQvM
         pTnTRJWWpTE2wKzk8IIejgsy9nOn/pES3PNCOzrTDyqoOAXibdhbhP446jnJfcat2SQL
         4NQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748043047; x=1748647847;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wF2Vo6L9fSrAm9diEZkgkQAIhN6qflD88Jat6gXXNmE=;
        b=ZWhSuyD1aS5Go4F1vmQnxzZcR0TKtE9fLzQFLwIVmLikJ9sssVR5SelIvThoLHskLD
         W7L7qZy1uIjC7Ms5s27z3ZJm0/pX/mI7g8Hxy+8WKPsjzBGilOiw51pz8FjiLMyTSmGI
         bo/ZE4KairWVJX/P1e6PuYGrV5CJch+KbmvnOm08bNnmsZykI2cw2KVdnBpcmUXwshx7
         Gh1lCQxs5Rqos99SB9Tset47vT1ZiqsdyWLRwru3M3t5/m+Aq4LUV981CIC04fojpKVC
         RU056f5E5OP8kB14v6c9xvl86fU54oWj8Bgc677y1pHIWULfPZW8In2kY1eS4XuHVGUy
         mHVQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8w+i9X5Oczrsv/mg3LtIZt0YPEjFerrpZ+VfgsIkbD26ZoG8nfuinbFSp7Fh5Cylond5ExpVC4MQ+aRomz04=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywks0uJWOiB/0k81e91TZE1AdReEGlYyoSfnL7IToPeWXeGgoNu
	fI2R07cQ6HlSX5OaCYSQ0A5xcUNHJNtzM+hUDl+mN5cZJGwXjhLcnXasbH7tEA2Ce8h0GhiIpEL
	DceiMZx96pVE2tA==
X-Google-Smtp-Source: AGHT+IFJGhvgS9TEa69EpvUIwZdW+YAoEC5g1jPnlXymMethxk1xO3kiFqvQaClu2Uw+uRjbzOt+Suk4beT+Cg==
X-Received: from pfjx9.prod.google.com ([2002:aa7:9a49:0:b0:742:fa:9a82])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1ad3:b0:736:457b:9858 with SMTP id d2e1a72fcca58-745fdf414d5mr1895062b3a.10.1748043047309;
 Fri, 23 May 2025 16:30:47 -0700 (PDT)
Date: Fri, 23 May 2025 23:29:57 +0000
In-Reply-To: <20250523233018.1702151-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250523233018.1702151-1-dmatlack@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523233018.1702151-13-dmatlack@google.com>
Subject: [RFC PATCH 12/33] tools headers: Import iosubmit_cmds512()
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	David Matlack <dmatlack@google.com>, Vinod Koul <vkoul@kernel.org>, 
	Fenghua Yu <fenghua.yu@intel.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Adhemerval Zanella <adhemerval.zanella@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Takashi Iwai <tiwai@suse.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, WangYuli <wangyuli@uniontech.com>, 
	Sean Christopherson <seanjc@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Eric Auger <eric.auger@redhat.com>, 
	Josh Hilke <jrhilke@google.com>, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, 
	Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, Vipin Sharma <vipinsh@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"

Import iosubmit_cmds512() from arch/x86/include/asm/io.h into tools/ so
it can be used by VFIO selftests to interact with Intel DSA devices.

Also pull in movdir64b() from arch/x86/include/asm/special_insns.h into
tools/, which is the underlying instruction used by iosubmit_cmds512().

Changes made when importing: None

Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/arch/x86/include/asm/io.h            | 26 +++++++++++++++++++++
 tools/arch/x86/include/asm/special_insns.h | 27 ++++++++++++++++++++++
 2 files changed, 53 insertions(+)
 create mode 100644 tools/arch/x86/include/asm/special_insns.h

diff --git a/tools/arch/x86/include/asm/io.h b/tools/arch/x86/include/asm/io.h
index 4c787a2363de..ecad61a3ea52 100644
--- a/tools/arch/x86/include/asm/io.h
+++ b/tools/arch/x86/include/asm/io.h
@@ -4,6 +4,7 @@
 
 #include <linux/compiler.h>
 #include <linux/types.h>
+#include "special_insns.h"
 
 #define build_mmio_read(name, size, type, reg, barrier) \
 static inline type name(const volatile void __iomem *addr) \
@@ -72,4 +73,29 @@ build_mmio_write(__writeq, "q", u64, "r", )
 
 #include <asm-generic/io.h>
 
+/**
+ * iosubmit_cmds512 - copy data to single MMIO location, in 512-bit units
+ * @dst: destination, in MMIO space (must be 512-bit aligned)
+ * @src: source
+ * @count: number of 512 bits quantities to submit
+ *
+ * Submit data from kernel space to MMIO space, in units of 512 bits at a
+ * time.  Order of access is not guaranteed, nor is a memory barrier
+ * performed afterwards.
+ *
+ * Warning: Do not use this helper unless your driver has checked that the CPU
+ * instruction is supported on the platform.
+ */
+static inline void iosubmit_cmds512(void __iomem *dst, const void *src,
+				    size_t count)
+{
+	const u8 *from = src;
+	const u8 *end = from + count * 64;
+
+	while (from < end) {
+		movdir64b(dst, from);
+		from += 64;
+	}
+}
+
 #endif /* _TOOLS_ASM_X86_IO_H */
diff --git a/tools/arch/x86/include/asm/special_insns.h b/tools/arch/x86/include/asm/special_insns.h
new file mode 100644
index 000000000000..04af42a99c38
--- /dev/null
+++ b/tools/arch/x86/include/asm/special_insns.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _TOOLS_ASM_X86_SPECIAL_INSNS_H
+#define _TOOLS_ASM_X86_SPECIAL_INSNS_H
+
+/* The dst parameter must be 64-bytes aligned */
+static inline void movdir64b(void *dst, const void *src)
+{
+	const struct { char _[64]; } *__src = src;
+	struct { char _[64]; } *__dst = dst;
+
+	/*
+	 * MOVDIR64B %(rdx), rax.
+	 *
+	 * Both __src and __dst must be memory constraints in order to tell the
+	 * compiler that no other memory accesses should be reordered around
+	 * this one.
+	 *
+	 * Also, both must be supplied as lvalues because this tells
+	 * the compiler what the object is (its size) the instruction accesses.
+	 * I.e., not the pointers but what they point to, thus the deref'ing '*'.
+	 */
+	asm volatile(".byte 0x66, 0x0f, 0x38, 0xf8, 0x02"
+		     : "+m" (*__dst)
+		     :  "m" (*__src), "a" (__dst), "d" (__src));
+}
+
+#endif /* _TOOLS_ASM_X86_SPECIAL_INSNS_H */
-- 
2.49.0.1151.ga128411c76-goog


