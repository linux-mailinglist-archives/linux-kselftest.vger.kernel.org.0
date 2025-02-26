Return-Path: <linux-kselftest+bounces-27568-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E51E3A455A2
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 07:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D1E0177C31
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 06:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB6D267F5A;
	Wed, 26 Feb 2025 06:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="I9sdic8D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA6F267B8E
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2025 06:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740551548; cv=none; b=MfUUG/HZ/dPQM45rvr4QBWlNnuiMoumxoXfPFYXh5WVqgrV/M7oMB3lU1b8T6mFBneI97SPTxIwbmrJK4w8zuQVZibkP53GjHN5rXevMPm7dATD3aw3yvBVYyp3jyon2lhwKIW5zd+e+MpTkr4kP8b76aRH+8OgriN+VkxEmol0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740551548; c=relaxed/simple;
	bh=6A+KzqvEXADqQRFxfflnjdJnKHnamJmScDSK6m9touM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tVNVgfSVDUxe8OA0oZdy+n8uA98IvY/uQAx5EPWhOtQZn9en/mwRPkxEz7bF+R2PGVfrhESfuLY74cjBo665Gt/mHei+Ddegt1hnCtmxzkaqM6HirLpOhDUSbA0qP8RIHXAzqS1rNuFeDeIp1MD0JXwSA3wDco4bRIDV9zmAZTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=I9sdic8D; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220d39a5627so98487775ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Feb 2025 22:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740551546; x=1741156346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bLyDt49U/qvQrnUcu83brJz3XFH8EzOsk0B+VADLLKM=;
        b=I9sdic8DvQaA+ur5tIZjSHBAtWVFMY0lJrbu2EEGMxGkgrG7J6EtEK+N6GU4SV52+r
         Q4Ce7jP/Utk5l1Bpfagyc1W9/GAfL0k4nmnY9kRiVrm8NIuj4khH9ygZO3BnzSNKSzp/
         EESJ7bwGDgz8yFihIUfjn6Ok0mJjtHf463yH30n4cdP0C5nbwZMtNULyB4ZXzgbEMs4S
         /QZsqfCEvGKp8J4+k3ulw01qenQ9sdbSbU0YqqieXZ07ozMOzD/AqFNJKnqI03Cvy45O
         Sfr9FWPomBecz51A7KIxJNtoxDOFiS9ZQP0gjhglW+Wx2q0rV6o363f0DSf/F3UCWfqe
         k13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740551546; x=1741156346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bLyDt49U/qvQrnUcu83brJz3XFH8EzOsk0B+VADLLKM=;
        b=mMGW2I0cLN15vlaK41Ggg0LEnNzHDJ5VPgGAdt+gfn359mslCH8t9TzT2gbcGOUlOI
         lYtsNcj8GHCzpjXoGOxjduTJw4y0NFroNevhk07r8FczqsBpj6b/PdX9G9EEQZ2c4Rrd
         ZeQ8WsC89I5Y/ekeR1ePsAsDKSl9lYNuGHdANzZQBo79iQ+6E+uPldHq29Tu0+2knet9
         78BQnXYB7uQCCzGl4V8Ukaaq5OPLJU21ObyHXdyeFPWq5UwfsR3zE+T5fDh6UfyczMUa
         LSHOHQb01ks5Z1U1CGKUXu+LVWe5aWGPZD/nxKMYrOraJgu6lP7ehQcfnk8y9XThVqBm
         s+tQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5rtbMOgeTofDjIG+0eOqs0getzUunb4CmvvKTkoLmykh7KBCkhoP8f7m5U1yKvKdfH/Yuel/VYejIYqxfRQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YygaBWl5wgUrw2IgPBZl+U31KILkqIXdYI3AvXLF05DVdGD2fpn
	aI0SQ4+Z+w7rC15wsWme1y5WCjR6XNaMZEJLDadsbBjZPMfa001v/yIVotC2XnQ=
X-Gm-Gg: ASbGncsYFSmsCtc6zGz8k7XaMnZQ3pKzcC9DwTnIoQ7uICgMneLgoOuTQHSJx4/lZ93
	9IgNTPoDwQQczs7FS8OQEegkZB2nJ+i95C2bK1fHtnCXvKLYOeTREg+S1cWfB90X2JCu+IVswug
	Pgk3K0c0RMoZbr5O4JYHyCr89XavWaK44B25PTEGRooYZDEhytt5J+w+goTH2cKOVzKw+jCzcpy
	YlatA2t0khHktN3HL+x3EBPe/8JFY6Ztfs+ac3sPw1ht4I8/Pt2cl00wOcb0eL1G2r7rRM2vbuC
	eS/0WKLcYcqJbWc6NcYltGbxhQNSX522lCDyPKhINEWbQ27YTc8U+cpGDofk
X-Google-Smtp-Source: AGHT+IFFs8SZ5lPd2kWTT1U7ETWzPeSTog8WGxZry4kav5NnRHKIbt7T9I/ZeIxsd70AumwEzTSVFg==
X-Received: by 2002:a17:902:d48d:b0:21f:136a:a374 with SMTP id d9443c01a7336-221a0025a63mr347304555ad.43.1740551546420;
        Tue, 25 Feb 2025 22:32:26 -0800 (PST)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe8284f152sm682599a91.46.2025.02.25.22.32.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Feb 2025 22:32:26 -0800 (PST)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: ajones@ventanamicro.com,
	alexghiti@rivosinc.com,
	andybnac@gmail.com,
	aou@eecs.berkeley.edu,
	charlie@rivosinc.com,
	cleger@rivosinc.com,
	conor.dooley@microchip.com,
	conor@kernel.org,
	corbet@lwn.net,
	cuiyunhui@bytedance.com,
	evan@rivosinc.com,
	jesse@rivosinc.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	samuel.holland@sifive.com,
	shuah@kernel.org
Subject: [PATCH v7 1/3] RISC-V: Enable cbo.clean/flush in usermode
Date: Wed, 26 Feb 2025 14:32:04 +0800
Message-Id: <20250226063206.71216-2-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250226063206.71216-1-cuiyunhui@bytedance.com>
References: <20250226063206.71216-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enabling cbo.clean and cbo.flush in user mode makes it more
convenient to manage the cache state and achieve better performance.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/kernel/cpufeature.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 40ac72e407b6..a8b726d0dab8 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -32,6 +32,7 @@
 #define NUM_ALPHA_EXTS ('z' - 'a' + 1)
 
 static bool any_cpu_has_zicboz;
+static bool any_cpu_has_zicbom;
 
 unsigned long elf_hwcap __read_mostly;
 
@@ -91,6 +92,8 @@ static int riscv_ext_zicbom_validate(const struct riscv_isa_ext_data *data,
 		pr_err("Zicbom disabled as cbom-block-size present, but is not a power-of-2\n");
 		return -EINVAL;
 	}
+
+	any_cpu_has_zicbom = true;
 	return 0;
 }
 
@@ -1001,6 +1004,11 @@ void __init riscv_user_isa_enable(void)
 		current->thread.envcfg |= ENVCFG_CBZE;
 	else if (any_cpu_has_zicboz)
 		pr_warn("Zicboz disabled as it is unavailable on some harts\n");
+
+	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_ZICBOM))
+		current->thread.envcfg |= ENVCFG_CBCFE;
+	else if (any_cpu_has_zicbom)
+		pr_warn("Zicbom disabled as it is unavailable on some harts\n");
 }
 
 #ifdef CONFIG_RISCV_ALTERNATIVE
-- 
2.39.2


