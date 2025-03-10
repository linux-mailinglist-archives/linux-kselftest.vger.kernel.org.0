Return-Path: <linux-kselftest+bounces-28641-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A54A59984
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 16:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAF291889F58
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 15:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07222230D2B;
	Mon, 10 Mar 2025 15:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="StQ4A8O7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6FF22E41B
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Mar 2025 15:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741619663; cv=none; b=fQKHwm2SDxuo1oYE5SS/8pTp0fsP0LKsT03erKzQKYhIhRktxefdcxN3kQLisOrae4M0r6cLO+39idR/OJMTR2Udz9dfKd+bKRaHyPKXodAKtSaIX38zTUUOJ79wakVa4PHCHvMvWNsLUIDCzgPjVaWkmLj77IPDySIYqpuLETI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741619663; c=relaxed/simple;
	bh=bnTO4F0S5ychW6vkQ40467dj4QMVwl+AJTO7Dfj0Lpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g6xXoX4ZUWP6vEPU1nvEQy30vFc/02+IVRCbxByvCGUqIeO1wgQ/1yQ3jSFLzivNpZ8Er3SR7VMshooIktEJIzyoIJ+eNWVZQBWLZj558xLkPZb5x5yM2bT9YiIulBlXoZIqk3FS40zOjX5tEqI+Kri3LWmQuNZwR+BhIx3KOAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=StQ4A8O7; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-223fd89d036so85436945ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Mar 2025 08:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741619659; x=1742224459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Ne6qRsQBgMn6Z9TbFB4C5/y3IwlTc1J69dL1IhT4E0=;
        b=StQ4A8O7p0CPx+UAaJH0+xUioxoW+RgH2cW8at9e9HEloGqUVkyAM4Uc3YL2IkIntD
         QL6W7qIs5r9bw4HHkxomN/eFr8J5bckein20oGKhPB98HE/solr3P6lgkmrDjYNmCm4t
         QaR+CJfrfQ2KFOoXsaJ9jiuYol7ya0n+XdyFeBqV5tNmlIEjXIge4Wrz6vKC3zuKoHpz
         c4kbFW4POqOGewfVODs43qg/1pVqvYIReT6fAcHJUfvrS8rB7jF24xQaVA73G7JTcuMo
         lm11HfPvIOt0nuip7hRYlJGh4l7cSSwnvvJcd/c4UPEfNe/wbOkLXR74l+1C+3Hj/QUN
         0hSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741619659; x=1742224459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Ne6qRsQBgMn6Z9TbFB4C5/y3IwlTc1J69dL1IhT4E0=;
        b=whzPop6zzgd3OKcnoSPWKPjNoci8CH77yUyt5f2DpBrONcSCFW2/IESMeFdH/4amYU
         RdBnoOeo/O1dKyp3rWxp+F3O3/xfxmZHggPDJRY5BVVslaswuPyuEbJXu//Cs/30/LTJ
         cxz7W3igvNI9BPHJHLNJQEi9qHzX1p6EY9YFmWuopK2IOkuHXnZmfmRusvnYXCtmK6vn
         y4FeML75jklvLniJREy7HwF2zPrqIYx91+tVinbd+SD/k1w4kmuQl8r2nLJJTWnYMJoF
         VmD+zfjPGLvp1qRDdfiF/haXttvTOFNeC7SUJKiw5Hv2Jvwu831FgEZkyGfiHkktXGfo
         y0Ng==
X-Forwarded-Encrypted: i=1; AJvYcCX54GuU1cUsHmCAbXLphMhoeLp6qLuUKuXU/KzK4b76oVwIMG0OEpGiyWyB98ltCFDhzOke8Zp0FUNNzwun1IM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxewLON8dmo/SdW6gqau1qH+wxQNp5ecfKh1gTOJAHNkFqWVrQ6
	Qu8COffxRuF5fPBDUcb0/aLHwdjASfiVFZnffoelbWOTnw7YLwrVVtk8yQf/Yho=
X-Gm-Gg: ASbGnct2NriXSh4HNHYszpS2rRaf9Icbsy6Sg5R9oaLTPZSmu39XLWVOLcxQgbm2DtQ
	kxWvfxdCJXo2HuqusJJy8iS9pi3tOJpGkkr5ozAItkdyGA3lB2MOrRlt7rJTis78LxgtWcQfoti
	g8GGn5iL4xLNCZOF+bm0LI6/fGZNM6qGBsLBpN0uS+FesJQKg4cwMmfj/DwVyZP14634lnGfHPr
	hOBmU/k0lLmBMqHrz6lK72h5JhVjtxQD0mChcZoJOibe6JrrOGzQhrScwr/b2imBSJ9SZILnZua
	3k+kiYfZYRhAX68p93xjRy0CAcEpNM9+6LBog80SPoNIMw==
X-Google-Smtp-Source: AGHT+IHou97UuMHPx2aRC5ipTZybHeRQW/gREfJF/XOKkR7oov9xPoqimKZKRudGRu1JoJNuk3RSLQ==
X-Received: by 2002:a17:903:2405:b0:220:fe51:1aab with SMTP id d9443c01a7336-22428c05613mr273654235ad.38.1741619659507;
        Mon, 10 Mar 2025 08:14:19 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e99dfsm79230515ad.91.2025.03.10.08.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 08:14:18 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v3 11/17] riscv: misaligned: use get_user() instead of __get_user()
Date: Mon, 10 Mar 2025 16:12:18 +0100
Message-ID: <20250310151229.2365992-12-cleger@rivosinc.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250310151229.2365992-1-cleger@rivosinc.com>
References: <20250310151229.2365992-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Now that we can safely handle user memory accesses while in the
misaligned access handlers, use get_user() instead of __get_user() to
have user memory access checks.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/kernel/traps_misaligned.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index a67a6e709a06..44b9348c80d4 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -269,7 +269,7 @@ static unsigned long get_f32_rs(unsigned long insn, u8 fp_reg_offset,
 	int __ret;					\
 							\
 	if (user_mode(regs)) {				\
-		__ret = __get_user(insn, (type __user *) insn_addr); \
+		__ret = get_user(insn, (type __user *) insn_addr); \
 	} else {					\
 		insn = *(type *)insn_addr;		\
 		__ret = 0;				\
-- 
2.47.2


