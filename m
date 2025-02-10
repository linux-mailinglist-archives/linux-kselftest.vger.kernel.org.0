Return-Path: <linux-kselftest+bounces-26239-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE41A2FA9A
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 21:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F045216844C
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 20:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B357262D04;
	Mon, 10 Feb 2025 20:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Ox1qEj9/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63963262173
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 20:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739219263; cv=none; b=BBAu8Nc9xfE9FD3Ktl2BLwS4DFlvQnH0PDzE0bFmb2KCogpcXGmnPBd9C8SefdGZXT+qLFnM95jQFAjQPFy76///CkDz8/Mfd5UtU7NSRoh3hhR6Eo+03T4xPTTHVkaOpPv4NlpsiDqiQtL116joWxDOmMWOrdvk2niBIzj3jB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739219263; c=relaxed/simple;
	bh=Eua84f2QnuJ0+u1eEfH6+3KRo1p7kHINzNbKNk8bPkI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OiCZzRBEpG9l8z7QlVZ8hVDMSnyH5pvAZ34/hngNlZd+cxhrIZ7Sr4dyUWR/HQLA82I1pI8ooOtPj22qaVVWnpMJStzji0IWhCtenIHnloNijwAOMMou3ns4O6Jmqd7xunfj6iL7GIDDiZCjKSePv0ACI5oaac12eP333OUa0hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Ox1qEj9/; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21f7f03d856so35336555ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 12:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1739219262; x=1739824062; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9LN1OOVFFK55bIQe9Bj7KSCICvDpdODqLxcVYOIQy28=;
        b=Ox1qEj9/ta39TC7S3n4ObyzPvseFq1fDw9iDUqF6RnLr3aqFd8V/97GYnNvKojGVUy
         hJAevFaQJt6+FhtPv+BnEX8rt/OnKHtBOjxUH3XMY8zxC+TAGcBJzqOSAKausEB9+dAC
         lB4xRjZUk5xi4YiIQ40whB+YUGvlyPRviQ3W3wBcBQxWttDR3Jv7vKJqvcNM4+fOiORy
         NoJ5x5qAWIsDJ3GtPTRm01x9H8tsPUuCQ/j6RWuWxqT7008SUWmwSGAwOyae4vwwwy7W
         7terdv657O4kSWVOkfBh8Cq/jZmAbQsPgX4KswzmpA7jAP1lxfnzkHCYCzBHNPDIQnTw
         UaLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739219262; x=1739824062;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9LN1OOVFFK55bIQe9Bj7KSCICvDpdODqLxcVYOIQy28=;
        b=RzGrJoQwDeW+IYj0NdMEMFiTWgjMNLGWZ62+MTvV9K5K+m/PLvUFcbLyKM2ELTTut5
         EikZnfnoxi51HWv8v18XjQ1fW6AO4j+wmoAOIgIYM6dg2Dek/LKOasfMFhQEaZM2zMQR
         T3VVNDAaCgesxYKbg8AuN5Ezf4sL2E/CgTr8Dsd+GSQHnqBzK8jpvkUBeiwOM1cc+jdd
         3e3M8ZJ11FzbXA/jobXgEGY+RA7SE1UY8ruHCnhvc5mohj/b3/PGIU4T3p9ejf4LOytH
         cIhcwxv0PfwbTq0t3wkyHxYNyG/el1HMWj2C38rlVi9zMd5EDor3RLX19jHS+ctKQgSX
         oI5Q==
X-Forwarded-Encrypted: i=1; AJvYcCW1G8tE5g4h+94a5yewtCEc5DRNQ9z68JEb4sT2CgyIzBRuqAz16jxB5BBqNQQW26PF8k6a6xk51K0KyarNggQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfq53NECO0zbeIiQGcJqd9zWNNNKrZoS+mAHIO+BVSFzCnfeox
	t44wH70qeOFAaaIUEJvjWHv1NQE9sxYAg0HfhZbAPXplH5fATqPETQMGJmsk7jg=
X-Gm-Gg: ASbGnctux+tEuyGXwp5tSxi2zyhgnJflAZQtuC80akG/tn5U3NRrfTyFGwV1YeivsBl
	XIAsBm6bl0lRj0Wrn4d+/60YiHnWZBiMubK39ifo1lFPk+HHv2ScJozEUTeUGftdbMuNjw7mCy+
	xUA13OUyDsfHjzw8WEpB5BbWynWJ68nWiJth0swQPHaiXUjxnIwRHJmIOU8XpTDnoqXqDfOYBj3
	Y88EtNGdEzOcPnzsRLEHB+dzHEhtXDrTqNNLE14TdKU8fFiVlRlbbT+uUG2zzkQmMX8MEmrE4ZP
	JWk7dztR+01lW4XJ3vBZIzKOew==
X-Google-Smtp-Source: AGHT+IGvJHthtMMIotmYr/CK0oOoURKWcK3k+qdOAPpSTfBW1H5FZ/zO8d2C9jHOqU/wdcn1U6s6JQ==
X-Received: by 2002:a17:903:2311:b0:21f:3e2d:7d36 with SMTP id d9443c01a7336-21f4e6ceb59mr270827895ad.1.1739219261893;
        Mon, 10 Feb 2025 12:27:41 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3687c187sm83711555ad.168.2025.02.10.12.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 12:27:41 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 10 Feb 2025 12:26:57 -0800
Subject: [PATCH v10 24/27] riscv: create a config for shadow stack and
 landing pad instr support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-v5_user_cfi_series-v10-24-163dcfa31c60@rivosinc.com>
References: <20250210-v5_user_cfi_series-v10-0-163dcfa31c60@rivosinc.com>
In-Reply-To: <20250210-v5_user_cfi_series-v10-0-163dcfa31c60@rivosinc.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>, 
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.14.0

This patch creates a config for shadow stack support and landing pad instr
support. Shadow stack support and landing instr support can be enabled by
selecting `CONFIG_RISCV_USER_CFI`. Selecting `CONFIG_RISCV_USER_CFI` wires
up path to enumerate CPU support and if cpu support exists, kernel will
support cpu assisted user mode cfi.

If CONFIG_RISCV_USER_CFI is selected, select `ARCH_USES_HIGH_VMA_FLAGS`,
`ARCH_HAS_USER_SHADOW_STACK` and DYNAMIC_SIGFRAME for riscv.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/Kconfig | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 7612c52e9b1e..0a2e50f056e8 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -250,6 +250,26 @@ config ARCH_HAS_BROKEN_DWARF5
 	# https://github.com/llvm/llvm-project/commit/7ffabb61a5569444b5ac9322e22e5471cc5e4a77
 	depends on LD_IS_LLD && LLD_VERSION < 180000
 
+config RISCV_USER_CFI
+	def_bool y
+	bool "riscv userspace control flow integrity"
+	depends on 64BIT && $(cc-option,-mabi=lp64 -march=rv64ima_zicfiss)
+	depends on RISCV_ALTERNATIVE
+	select ARCH_HAS_USER_SHADOW_STACK
+	select ARCH_USES_HIGH_VMA_FLAGS
+	select DYNAMIC_SIGFRAME
+	help
+	  Provides CPU assisted control flow integrity to userspace tasks.
+	  Control flow integrity is provided by implementing shadow stack for
+	  backward edge and indirect branch tracking for forward edge in program.
+	  Shadow stack protection is a hardware feature that detects function
+	  return address corruption. This helps mitigate ROP attacks.
+	  Indirect branch tracking enforces that all indirect branches must land
+	  on a landing pad instruction else CPU will fault. This mitigates against
+	  JOP / COP attacks. Applications must be enabled to use it, and old user-
+	  space does not get protection "for free".
+	  default y
+
 config ARCH_MMAP_RND_BITS_MIN
 	default 18 if 64BIT
 	default 8

-- 
2.34.1


