Return-Path: <linux-kselftest+bounces-29093-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D65A61EE6
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 22:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93C83189D29D
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 21:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB272135C4;
	Fri, 14 Mar 2025 21:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="AmJYziYU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E973A213227
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Mar 2025 21:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741988416; cv=none; b=Fv11xytmkyHrnQD+43sTP0wM5ffmSI039XmwxdFTCsSYORfMkZHUMem7zkgIUKjOL94IR966UixkhvZP0NBGOanRMFtsCjfTMXwesEYqvPopuRu7oH7GopkQsGtJ7DHQlk0cNdkliJQkpWUciFA1baeuRFtvN7zuIr41xwzWEY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741988416; c=relaxed/simple;
	bh=UvMauEZ7ujgiT53rhoVNtF8wKatfWBS5dd1E01vsJYA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DczQoz1CTSz1nkT6W9kQ4oWlVP3OSWUxzgoPh9HthlWdi+OP40VZGSmines6/FAbYeS/eG3tGu0DXYk8AzKngx9ouxFuYTTW2ZfHXJz8PC5oQdOzO8ZiJsurn97JHqO/3z+PBTF1DlN71dMcYuMkR9biYs8s6Xk0KtTKHMfrkwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=AmJYziYU; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-223594b3c6dso52489145ad.2
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Mar 2025 14:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741988414; x=1742593214; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hU6IAlGSwKWKw5iWDrFBqBdwaJZ69/+Cs7+/DXu3do8=;
        b=AmJYziYUUySw4rnMaaAFZiIBbybv4+yoituPzi7wR8FIF35gpuRBCzFs/lmZ1ShmA2
         vPoXuXOdQhc1WdtWt2flJvrAtS5LwDZgE5FDmPIme/nQCp7To5Xu45qkttI7mwENQLxy
         LPpvRJ3nKb49bhsTltPIM2fvWhNxIA2zcPTqlzRLMlWWvs7NlhuJDvtw0IHHapSQgXPy
         wJgOej53j4R3KCHqaW0BMu1UYtTyNoRTnUiwKt6CRtZr4t1z9cxfyT58MHdXplhhHyJL
         83vj2PltwIcuGd613B4ft0dcmCu5a8PoFFD5FSDpGsM3PKvyLx5xIxvaDFwKK8DrqotD
         hAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741988414; x=1742593214;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hU6IAlGSwKWKw5iWDrFBqBdwaJZ69/+Cs7+/DXu3do8=;
        b=iQ0l2pUG7A3PW06ap0PbgV881XW2nhYQoonZghii2maaid40qFNIunJb6aFNRa4poL
         Lt9opE26BBSHbuPAVJWzAwGOOey9jsxcoN7/dui22YoftgEvuF1Bz7q1CUaJsL2cNPVH
         2jlxfIOSofBUbJsroriSCA7RvTua8D07V/RA7n0uKM1lRksSsb/XdxDuQwoPNvwqEOcZ
         VgM+gq1g/1bKQTLZ5EysIGonzrJqvIavyLFHr3e9GFdv2yUxer5dQhkbXvz0qJgHlEPf
         5qKglpGWpoOE8yOVJ7PDmfQ4n/7Hsw+qgVJ3RpYGQ/C0VI0FmctrJNEGRrqAMS9GANZF
         dhWA==
X-Forwarded-Encrypted: i=1; AJvYcCW0vypQjnjk31pyES1inSlkOm6fgfJ3hB+0ixU2yGQ6SpNMz63lPbY6CiQnE5be+qjiQyMA0w7KA/3K+Qwtrjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCZWw7ExzG8pRaoO4cFnQ4HoOtAxWY/DvSSU+BvzAZKJpsDJXj
	KxeirqsPV7VX4CjLJ8AkXrrrlGKrtEbSG4aZ/2hXjwXO1I5kjBBT6vjJ4Ou2giw=
X-Gm-Gg: ASbGnctIGv2xJSOk53ltnMe7DQJys9rXwlf/OQDfOnblRFcwMx3KtVPkuXQp1PvFfom
	IQjQkPTW7sUMQeBFAlL4+MAzTWfcLWzDM6saUAggnB7lCMjCAgqCphVxKDK6e/Bw4rqRSS5w4WM
	BSZeY0oCVAvOaZNUM/guqdtLCczcwme6LvQ45Af6jGnqjvli+k8GgT3aGMJwbE+nLLoOGJpznkt
	vSXnK0eT8NHedTvZvHDgyYDEpZc78VYDSvFIkbMFasEpFM0AVlHMq05Rg1gzwUelFREYIE/3+Gb
	jSUSNfqlQkGEZ3P52GEOz3OLKE6dxROe3cZrcbQIhzUPtEvPSTDrgLU=
X-Google-Smtp-Source: AGHT+IFf7KDxEVU9NtNTwXHHWwqDPalXGdl70DI+8CNTgQz9PWl/u1/S9R+7SGLAPbVztXvT9lTY2A==
X-Received: by 2002:a17:903:18f:b0:21f:768:cced with SMTP id d9443c01a7336-225e0a1644emr36247295ad.8.1741988414327;
        Fri, 14 Mar 2025 14:40:14 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a6e09sm33368855ad.55.2025.03.14.14.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 14:40:14 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Fri, 14 Mar 2025 14:39:37 -0700
Subject: [PATCH v12 18/28] riscv/kernel: update __show_regs to print shadow
 stack register
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-v5_user_cfi_series-v12-18-e51202b53138@rivosinc.com>
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
In-Reply-To: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
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

Updating __show_regs to print captured shadow stack pointer as well.
On tasks where shadow stack is disabled, it'll simply print 0.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/kernel/process.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 4587201dd81d..6bb53ce72ed5 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -90,8 +90,8 @@ void __show_regs(struct pt_regs *regs)
 		regs->s8, regs->s9, regs->s10);
 	pr_cont(" s11: " REG_FMT " t3 : " REG_FMT " t4 : " REG_FMT "\n",
 		regs->s11, regs->t3, regs->t4);
-	pr_cont(" t5 : " REG_FMT " t6 : " REG_FMT "\n",
-		regs->t5, regs->t6);
+	pr_cont(" t5 : " REG_FMT " t6 : " REG_FMT " ssp : " REG_FMT "\n",
+		regs->t5, regs->t6, get_active_shstk(current));
 
 	pr_cont("status: " REG_FMT " badaddr: " REG_FMT " cause: " REG_FMT "\n",
 		regs->status, regs->badaddr, regs->cause);

-- 
2.34.1


