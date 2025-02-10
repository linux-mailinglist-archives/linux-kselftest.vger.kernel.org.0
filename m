Return-Path: <linux-kselftest+bounces-26250-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D9EA2FC39
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 22:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 824127A1D96
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 21:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFB4250C0B;
	Mon, 10 Feb 2025 21:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Zv2LhLjy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3B42505B0
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 21:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739223373; cv=none; b=GQ9C6BnmRW40wHf39RQustTBtkO1TnkVKmtIXdtHVvHXvRqoT7KmC5R7f6sRsfrWVjdswHZlJjYzOuqQkZ8hDmVwaOz8ZnUqHy7D3lVt/hdnWfW4Xcfb4sO1PF2fyJot5dNaAFiWVIRxGYRxaruYeIwEF+zmmoRCH3RoxO0zOi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739223373; c=relaxed/simple;
	bh=xTCgvoJ3M6PEdl0c4FHPJfLCd4JS4VwrygYqNk3pK44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I8mCBEar1eEtmKpAaca0jvmhamC/2BJKStSvovcDpL0wIpiF8AozHybqCh7+FfcWykT9M/nHrvndF5TKOzsA4vY3q7Lvg2u1A/d3CiyVreuhOQRllwv9uLkN5oHF1yxG+jA/qDm6pi9fIHe7Qy7gFJ+Wc0fK94OXrg6FNNJHwMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Zv2LhLjy; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38dcb97e8a3so2878619f8f.3
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 13:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1739223369; x=1739828169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8KnDLY3kffZnCGFmPEexJUKlO/NVt183lUvBn/SEPO0=;
        b=Zv2LhLjy5DAB037KYpl74pELKR5wTjg5ENN3HT1W+gGDXFx7OCfG7HPhKEf6XSXSPR
         Vfu2bnfs4qylZjpMWp5LOmcReuKpeZlliX1s/+He0EfXpPBCdYPR0VKv/7vlRO73Qtxw
         fUwtiklYFaT6npCYnUeAVubZEwg4ncJjHGfjPT1VcpE+v6kSfSpusxsINFiv47wOEP2v
         vA6VlnsHSw621d9Qy2icftkD843LTtslRnaVJ6bIAzbwOupblO9v5fuwJ44gntnqkqkh
         d8C5K23FshLqMfl/e+RfgCxBHGLtuO89EOcZE5jfsPYEw34TMnev5kH/7+wiCI9cDFHg
         scWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739223369; x=1739828169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8KnDLY3kffZnCGFmPEexJUKlO/NVt183lUvBn/SEPO0=;
        b=eHJueHD+fMH4D6Th0T2tlWulZh4GZ83C2OimH5Y/T8PCDiKXeT+SEwLn5uqLr7za93
         8dits1L5yjhe/xYxWHR6IIWT/NmHrnIcIM8xCtTnZYGi8wy/lFPfBLkLwS13c2o2f1o8
         kMpoFXI5pDZUqf/sWZQg6xq7Dz81ur8UFNS1s/6D6n2UdaRLjqkYVx+JsC421n5PFBGm
         xq1Yztbm2Yn8zdiYZQboCFXkMH5Eg/HMbbo/rOP2gQfesKponB6febzcmtVw0QdFF0LI
         0fSiEW+2xGzIT7gUMNiyGjd51/MgLVoEkhqDACSsxT3wgTPLAOtXodeW8Ct6Tq4MVTZr
         o25g==
X-Forwarded-Encrypted: i=1; AJvYcCXJSl4a3FRCjuYFyTASm+E+831Nk2yBk2SxEg80wRoK8REqr0+2McmGqhOWhfeFSNW+M0rJIa5KH4eYwtgbfHk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl+2/AbqmlbUfpyS8Wim+19XmAEVjFmDa633tJFtidtrkrY8SK
	Tlnvd/MvAm2x9ol4Rr/NkrHFHF6ydFzECAZHqlEpbFLHXAVHAEsdxy7Cn8LkhCs=
X-Gm-Gg: ASbGncvsxCwwItuRFxhafCjMdnwHnIuxaq40lMlRSgDa+5Vf34CQ5vN0F06F+7LLBE9
	AiOBv0TnZVGvWB+f4ASFYSYd1Q6er1TOYJSX9a5IDRaUxVFQWtdh9bebpTN6DL1kQCGa3654Dwe
	e6VkY+J5NGXme6KVZwwsdYy3W5TD7+Nl+s5PaJfFx3hcHK3ZkK97I8BHSFgd+P3HSBvZiw3nmye
	S4HK4B4ySI4xYwUl/aVOsxU1yObqkr6PAdzuUi7WzcOQldvC71jT4XrtfqFxIW9tp3n5QI5oiJm
	GMzWzetJJzqLHyB4
X-Google-Smtp-Source: AGHT+IEE/P9vsQR8DRZBtCxEbVJartmy037BYwcdFf30+Y++Re0XNH996Xl3DeOOL//RGxNKuAEJ9g==
X-Received: by 2002:a05:6000:1562:b0:38d:da11:df3c with SMTP id ffacd0b85a97d-38dda11e134mr7050032f8f.48.1739223368915;
        Mon, 10 Feb 2025 13:36:08 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4394376118esm47541515e9.40.2025.02.10.13.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 13:36:08 -0800 (PST)
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
Subject: [PATCH v2 04/15] riscv: misaligned: use correct CONFIG_ ifdef for misaligned_access_speed
Date: Mon, 10 Feb 2025 22:35:37 +0100
Message-ID: <20250210213549.1867704-5-cleger@rivosinc.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250210213549.1867704-1-cleger@rivosinc.com>
References: <20250210213549.1867704-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

misaligned_access_speed is defined under CONFIG_RISCV_SCALAR_MISALIGNED
but was used under CONFIG_RISCV_PROBE_UNALIGNED_ACCESS. Fix that by
using the correct config option.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/kernel/traps_misaligned.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index eb9157e3af73..57ded7e74dd8 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -362,7 +362,7 @@ static int handle_scalar_misaligned_load(struct pt_regs *regs)
 
 	perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, addr);
 
-#ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
+#ifdef CONFIG_RISCV_SCALAR_MISALIGNED
 	*this_cpu_ptr(&misaligned_access_speed) = RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED;
 #endif
 
-- 
2.47.2


