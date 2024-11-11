Return-Path: <linux-kselftest+bounces-21818-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEA19C4785
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 22:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7708E1F212E0
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 21:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EF01D042E;
	Mon, 11 Nov 2024 20:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="hCZjQ1jy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD39E1CEE96
	for <linux-kselftest@vger.kernel.org>; Mon, 11 Nov 2024 20:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731358491; cv=none; b=S1Avo7jkPovX+dRHsUC37zy9l25Rypy/Q1S2SiZkaGvisns6GJUhELm4a3UFL6RcuCW5mseut2JIPG0qFSM4ySctnD8KS6IZKVJoYxEqMUeMO5TUG03pkE+WZxFpeTz5KGfFLsCQ1PcUklJpWc77xbYaK+LUsi0mOj9n4T/U0T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731358491; c=relaxed/simple;
	bh=N5oBVes6Snom/wnVxJw60zEKeNMyUtaDgBT0D5xbpnQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OIUcIb+KZm/SNCMd53ql/smoCRYi4e+fkUnBC77wYapdp6gNAeJtuDSpizOK5g1Omupnv2ovZMBQfhzIkC8bvqcKnj7lsBH3vKxlEDpFunUtKcUDjtqA8+XVMxMsT8AeZrxnVOpy+HfHRIPT5A3Yc9VvYtQnEUFo2igkcwUZXIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=hCZjQ1jy; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20c714cd9c8so49961025ad.0
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Nov 2024 12:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731358489; x=1731963289; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LCvJScsVwtSSPvsUmMz3Q3/hMnyxUHsF6MHlE4BY4IU=;
        b=hCZjQ1jygwHB7P6fp+ks+KsOIIhGeJ2Vzs94fAx2W/JYjKbYNYJv8C6Q9pf8YGM3Zz
         R7LfU5Zrb27AnQIEDG5PZ80Pd8BTsjYmy2MBB/ACuMntbXMCF+ywWVx3Rvrrgmwc8XZL
         2MxE1ORrRz9+Ij4c1UY1Bdc/jnDn+d8lit6UH8lKk3nI1j2rTtUusstbduIeb9giXArh
         0yuw/ySblkulGFVwNvPN1+6OheiWF03Hn5p7M40bMIWbGF5Q6NAIgfj74LSFycaPn6X3
         hBF65dREWG7UXzkkhAudxVAbKnc5ecoJJSl1HfRbqi5mc1Yc/d5Hfp322v/8KEi9pzgY
         rMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731358489; x=1731963289;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LCvJScsVwtSSPvsUmMz3Q3/hMnyxUHsF6MHlE4BY4IU=;
        b=ItTVNvqZgGC6Ihv0OF1bqg+gE/PPJBi8GOsjXiol52LvHJcWsYXnVeYA3SFtOH6E7g
         2P6dDOW3yBoErk80m/iL2FPzzGc110ftxRIqM5HhLWGDl8ARUOZ8Sju4hYPOsnzuQjxQ
         EN+3hvfOTBd9zzqsa0k1qSd8RR9+kaOefyrRurlSQywW8umf+V4al7LHOVV4MjAUQdyr
         o5ALgwpg4KW2SFtRYUrnhoU7plDqb1odaKCLI6FBilcNCCmDZlI92rYuEhKqX8j6Qn0w
         zcX14AjdGuEukHZunoDsjxjZhmBpazU1rD/WOAKH5aSfSYamtYL4cmIa+LPPPFpJOpMG
         F/Rw==
X-Forwarded-Encrypted: i=1; AJvYcCXVh27ZNUuEioHlbbsCyZKnMe3FoK9cFqKg448+/88MPLjOat+imXWZQNKYDHoygk+qfLiMJZKpe/2zCYWuwGE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz37BGzCNMvjWrTJsxpYr+PkMfKL4tPFxHawkFzL21YGHfGKE90
	o9S4Iak1Lekx0BCweEVbzTW15hED/weVGwZYWhW5n+FuOxE2hXDDqm2dND5VknA=
X-Google-Smtp-Source: AGHT+IHDimCQOVgf3cz6B2MDVaQCn9zqN59aHOrw12G3nQFTvSfb8MPteRYBnMY91dT3qMMvMiS9YQ==
X-Received: by 2002:a17:902:d482:b0:20c:8f78:67be with SMTP id d9443c01a7336-21183e11a8cmr198773145ad.40.1731358489062;
        Mon, 11 Nov 2024 12:54:49 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5fd1534sm9059974a91.42.2024.11.11.12.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 12:54:48 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 11 Nov 2024 12:54:05 -0800
Subject: [PATCH v8 20/29] riscv/kernel: update __show_regs to print shadow
 stack register
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-v5_user_cfi_series-v8-20-dce14aa30207@rivosinc.com>
References: <20241111-v5_user_cfi_series-v8-0-dce14aa30207@rivosinc.com>
In-Reply-To: <20241111-v5_user_cfi_series-v8-0-dce14aa30207@rivosinc.com>
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
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
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
index 226054db6c42..1aeb5c08a3c6 100644
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
2.45.0


