Return-Path: <linux-kselftest+bounces-17490-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F99970F4E
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 09:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AB9BB22161
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 07:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88E91B29AB;
	Mon,  9 Sep 2024 07:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VuS5Oi05"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D84D1B2534;
	Mon,  9 Sep 2024 07:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725865727; cv=none; b=b9aefpRR2z22ephdUAsqoqzKBdzVxhpJs5qpy6OeHP2PedS/XgJWfEFonSGykd1v2jdGnE+6UoXZaZSf9drIff2LtrLAME1jPzS7nbXzov99gajd8bxUjUtIdlcejtOOElJyWge9+GAgBKgqO08xpeOCgzQCVGx4FpCRGVp8Xps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725865727; c=relaxed/simple;
	bh=HWWTAYGm0U7wN66xDMQU4gzK4ub4ZAFi3PYLnXmxLWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fmEfXOK9ivWtdk8Qww73pKlcf2hQ+R3WB7wQPXA+LvrFkDCCSiBRkrhFdcXULBGhQBD+nvC3Wj0PkKC8pzWIvgCJpNh4nQC0F9ShXwdFtdWk0Pw2s7pAGxonD2JcKHY3TgQzxdvpFpfaYPtAA+YlcGcPDzfVsrV2n2CQbjzlMYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VuS5Oi05; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42ba9b47f4eso22360095e9.1;
        Mon, 09 Sep 2024 00:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725865724; x=1726470524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BivEb0WMZmwNev7ojy/Ht/ekf32lny20AzsfLsOF+vY=;
        b=VuS5Oi05BCQMEsT2n3rkFqz6TTBayyoHp7fOBC0pql++GVYaj+138+tYgIdSTLtSLT
         /CDK7/KWR2VMLGrvl8E0uxU++EJmV5epotu1q1sdU7M+hjmw8UmKVWy8LZlSh+JmDcV8
         cbB6xe8z7gO09AiWbgDEZ2PtLzfrPXH5l4NgVqpqTxwYs3mkfFp2bWsY9m8x4dDiaOO+
         huJ+b+OpiRUg3qDDI5tI+TPeDO0A894D2e5m0S+Ss4liNeYCwcfRKgcaSOLCSbSLJaRb
         XXgPgDbtHIDaBjk9MoWYRUXxMApcw5L+ICILq9E8gbekbNsCr1uA+pe8gipwtpPsfIcA
         +fgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725865724; x=1726470524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BivEb0WMZmwNev7ojy/Ht/ekf32lny20AzsfLsOF+vY=;
        b=sm1OsYWA8Pwzodle4cjewN4jPLICvY7er5SwuWe6J7cAs+gxx5DrCN/ifDEfMREyER
         IWrJ5J9RerO/KVsI3pNanAURM+gXp1EkHf3LdCywy+vuDGy2aaNX4OJVphZDsdSft0fe
         Rd1FV1StBPm0oo8PLhh+fU7vRLEB84oBu5wGmqae7MqkfniTQI4eaY+pPgGcbH2YKfcf
         cuQvDV3nCHG4EMatdpgc4jw+PF4grFypeZfNSWspBbh+rFANnDGk6tiDXWWFGlsngt0H
         +xA/BIVUj1tm+YBmb1blCpgXU64GDNB69txTEIGZJNFK8pYPAjMm11zrkE/3ujO1poN7
         5ZeA==
X-Forwarded-Encrypted: i=1; AJvYcCUKNjIwtZ5wJ7bU5JiQxfLp1RrmWRB9JIRxbotHUrE92ejeuqiUStMNLIiCJhEorPA/uSvOGS21GS0KezI=@vger.kernel.org, AJvYcCV+XfnzuvG+NTiINEEOnmBL+szhqNx5RejtZtGFrirUVcv2dHwbTbXLKaYSHHyysolnO0BtyCXfphI+fkIx@vger.kernel.org, AJvYcCWuULlhYLuDWghp0UQRMOmCSvbeHVQ1FP9/OquQRZnpGJqdEQ6VoThiANjF9ZFfSY4xHg8xCuIQ/kCo6jl2DmUf@vger.kernel.org, AJvYcCX5JTUpM6ZyJe8Y2Ir4LCPQFZUZmMRdXRpb1JxzDejTeibJqSBBqh2iibyR8ox4s0l20LwWQNH141hS7A==@vger.kernel.org, AJvYcCXUU451jy+cIf50VPyZbK2kvOGBBdvbZ05ZSqSH4OfEpvICoCe6gTUsvUR8LOL1cEm+A9M=@vger.kernel.org, AJvYcCXo3J5KdES89mtfOUe0dpaVnabqhtTurt/ukfgSUCbq3gPRHZnZZJWcroxFVnlEqLpMm8uN0QkbPlY8eoVljQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxiSi1/IRNu8gtfvtV1FtMpZlgrHvakSnLBT9NX5FFq08uJBDOA
	7yac1DguObDQ0xTc7wAsm38OlxUGEihhg7DYyhChvbxj1Xu1akQJEUakNndNam0=
X-Google-Smtp-Source: AGHT+IHr6jnt3r1zP3GHq+t+AZJwdIrHH6hLL5Qy5jAi/UzNGLkV9sIPHS79jlfQirVSgFmx9JKzEA==
X-Received: by 2002:a05:600c:4e94:b0:426:5b17:8458 with SMTP id 5b1f17b1804b1-42c9f6d1d95mr61186805e9.12.1725865724488;
        Mon, 09 Sep 2024 00:08:44 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956d375asm5178754f8f.66.2024.09.09.00.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:08:43 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-crypto@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-fscrypt@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Cc: Uros Bizjak <ubizjak@gmail.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v2 18/19] random: Do not include <linux/prandom.h> in <linux/random.h>
Date: Mon,  9 Sep 2024 09:05:32 +0200
Message-ID: <20240909070742.75425-19-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909070742.75425-1-ubizjak@gmail.com>
References: <20240909070742.75425-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Files that use prandom infrastructure are now converted to
use <linux/prandom.h> header instead of <linux/random.h>.
Remove the legacy inclusion of <linux/prandom.h> from
<linux/random.h>.

This is the "nice cleanup" part, wished in c0842fbc1b18.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Fixes: c0842fbc1b18 ("random32: move the pseudo-random 32-bit definitions to prandom.h")
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 include/linux/random.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/linux/random.h b/include/linux/random.h
index b0a940af4fff..333cecfca93f 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -145,13 +145,6 @@ declare_get_random_var_wait(u64, u32)
 declare_get_random_var_wait(long, unsigned long)
 #undef declare_get_random_var
 
-/*
- * This is designed to be standalone for just prandom
- * users, but for now we include it from <linux/random.h>
- * for legacy reasons.
- */
-#include <linux/prandom.h>
-
 #ifdef CONFIG_SMP
 int random_prepare_cpu(unsigned int cpu);
 int random_online_cpu(unsigned int cpu);
-- 
2.46.0


