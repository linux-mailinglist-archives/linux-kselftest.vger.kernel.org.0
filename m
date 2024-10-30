Return-Path: <linux-kselftest+bounces-21048-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2B59B57C4
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 00:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EAC61C227E6
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 23:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8232144BE;
	Tue, 29 Oct 2024 23:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="r/qks1xg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793AF2141DB
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 23:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730245519; cv=none; b=naeaEes4Xii4f29NeB/A8L1A1gAg+XzQ1whH1ph+0AZnEKZIDzOkxsvlrG9XPwCZJniYGRqFL3PWcShD1EGHjOWbNg1v/XCvM7yxMcrrxu32E79857hWtCIqeTQqP430oTF+hvAvFOF2UFl0yin8L8DDyKxfKL+axfA7hJyuKQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730245519; c=relaxed/simple;
	bh=irlPZPuvDESaAkxSDQUpy7Wu0rWugzx4vBMYWZCPDyE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mYEPGTvObQqOSwVQUmXIoxacXFAc+30Vdzq52CRF/7TOW7Dn7yOfOAoYvN67wh1O/EV9MzZD8+UEQkRQ+0Hsru+/aqeThNU3jhLsm9zCI7fQp5Ig0Kn5TuPTEKWtMc8C1/3r6A4pZmlwn0P8ysnMvZETC1s2b1DJQlAxkPJlZck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=r/qks1xg; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7ea12e0dc7aso4318138a12.3
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 16:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1730245516; x=1730850316; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2F6Yb7wvkADRBV85CoJaexMx2ZeCvBhuuEpWc4ZWwJ8=;
        b=r/qks1xgTmiRtv8OOg9IuPQSAouCou93Imkkpz4sWiz2Jt6CZwvDpnM72TNptN5+cr
         FPVqyPpgJ6xFhlG9RmXtG/NOpld7MMGlek2h78nDD1s/zbL5bIqcbtVhW4edfwLqXf9Y
         h/WrluyWHoIgpQe4w+XZ+ZzE6WbiIqpJaxryWLs5/HVyOBRxE8MaSJ8nfwhFlTiOeKCX
         JJtvA2BfctAYIalzYN7RBx4FdM5cQZdLEFU+EUMHESloREA5GtDbHR8yKVL8mDZCsXoF
         6ZE+27icoaA0XFWNJSK65PvYKvOYnBqfGRN+hbm45YwY26iUaJfxpqnVEOcHikQ1xqJb
         HrBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730245516; x=1730850316;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2F6Yb7wvkADRBV85CoJaexMx2ZeCvBhuuEpWc4ZWwJ8=;
        b=amVDm8GK51e4xCEzexlRvqA2xXv/T3XZb/AD5FhxeRpcIdBXrALjEQlEM3lKuBeRDZ
         XT8/g9iWzu5rU65q8ozQLVKwz5SwjNxMyYTtTrgk3DwPOuvAspAexUxiQ1oFI4+sR10P
         AnIpyiKVF1bwMFdCrDf/tgEE6NbbrM2Sij7aRKl9r2DckSA/8XUOcRqrnr0cxy7Eddux
         GWQbWNW+++bY+U0vtuVlymjePjEejljgHNhg5rL9Zs8flJpcSPX6Pvzxk+zfZqQJBBUs
         Td0TKyqi5QdOda6DdBSfWl1EYBc3HXNtGsHmfPfbUz+m9uP90uLJUi3Tkqe5WnU+VUGy
         eevQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwklmzjSJJPlmw7zXltImuEkoYwKzehvjqgJQxk+BKwPa43Y5N3nhyh3cTMYrB5ugfz2dJ8yVQHymHQ0+xF0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrkHLFPXJ7QxBAclbIByjJ5PD2TAP189MZjzVOBjr4TaZv47zH
	10LeWqNzLIF5pBdT59xg7bn+Q8xortS0p8Pcd2d2YTQV28CrV+5+Ix8fL54pNOQ=
X-Google-Smtp-Source: AGHT+IFymY57Q4keJ+3CC+aQlV02UPkTqGn3YIXKiyS+cNgyPpergOLYnge8dObsMTdwpbmiiUHDiw==
X-Received: by 2002:a05:6a21:3a85:b0:1d4:fc66:30e8 with SMTP id adf61e73a8af0-1d9a83a6524mr18658257637.10.1730245515950;
        Tue, 29 Oct 2024 16:45:15 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057921863sm8157643b3a.33.2024.10.29.16.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 16:45:15 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 29 Oct 2024 16:44:23 -0700
Subject: [PATCH v7 23/32] riscv/kernel: update __show_regs to print shadow
 stack register
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-v5_user_cfi_series-v7-23-2727ce9936cb@rivosinc.com>
References: <20241029-v5_user_cfi_series-v7-0-2727ce9936cb@rivosinc.com>
In-Reply-To: <20241029-v5_user_cfi_series-v7-0-2727ce9936cb@rivosinc.com>
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
index 013bc3805afd..6eb4b8e0f07e 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -89,8 +89,8 @@ void __show_regs(struct pt_regs *regs)
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


