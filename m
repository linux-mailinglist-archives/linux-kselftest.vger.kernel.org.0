Return-Path: <linux-kselftest+bounces-31066-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B53A9211C
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 17:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14A683B2B9E
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 15:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3669925333D;
	Thu, 17 Apr 2025 15:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJMgi2iX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F94513B284;
	Thu, 17 Apr 2025 15:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744902992; cv=none; b=ARHnkyZalQWUdpekk35UPsSZp3CupKEACcUux6pbZ0FbeKKEivQUHZyPNgbgNfRbCLqweMkAe1J0jr8dFAc3I8hfQbFTHbpJqhAoqxXGNTnKkPI33pkadenul8CoRwRMetzUmjeVqi2rAXAHQHZoNDBB31SYS9ZeUWJ5ibST1R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744902992; c=relaxed/simple;
	bh=YjoLdOXsk+ecZN1tCZEEBOPNuxBOsZE10VbXAQQg8t4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gJ4D92iKZVMZYdDTaMRq5La4Ao9nBQC8mZ+4R6O5di+sRhrAeOZQXpbOD+t5m/wfYJI6+lXzAvJh93j8RaMT+VFwc0pWtWMwdlgGLL21IPMbVAcOXGKGmvHBzZ6O8zimzYrArifU0De2w5ChulsiZVfsNnn+PLY09EqptEcSXdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJMgi2iX; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22928d629faso10997465ad.3;
        Thu, 17 Apr 2025 08:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744902990; x=1745507790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkdblfbk98UFF5i+XIHnU73M7BpfbBSis59umaeQ9Rk=;
        b=aJMgi2iX7JHFziBJO/vLphFsw+bq5dyam0wZZGpwliW/85IRHTTM2SIbgePXUtNGuq
         il42ULpTB/fzGi7PAu+IdXy8enKCTm3mAAwfcCr3uMN80wrrBXlBYG8Oe+W8lVSqGSmq
         I2v1pv18BKtJsdtqVwerd56vZh4Uhp1TZcE7MmAMV1Ffph8A38r4+2p7sLPtym7VCH12
         l2SuTBPm620Ry57cWSQBobRnus4YalD3NkkSVFlZ0dTkj/iZNu0O9DQ/sFfSvDik3+Dx
         2s4h0Lf3wdA9qZ+AvSnxFmQWPbt6Udb5csUrss142T/4ITMqQnWGQ2I+Z+qj+EMczE9D
         VmwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744902990; x=1745507790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rkdblfbk98UFF5i+XIHnU73M7BpfbBSis59umaeQ9Rk=;
        b=pBogevHM0dRz8SXLNcx6MXKCFr8jPmkPeIdoAy3SW8hpzr75bmX+spKgQbhF/nw4ch
         gwd3BScTUyxBc2Cf4mrtoLExzklZFWeyOOqtclHztZ3M7UHkg8fDSmFtwlz46q01bxWh
         JvsJxJNhPn/EmgRwTcT4oXu6LK6hrCKZSsQOoYRpt6fVASGwdnIqbU+ZUK/RF4t+BUKp
         sNr8oizw8Sb+DYAxT4BZ5oKrSx7Su49Jacx3QUxqffqBBmOnpMclR0C0m3cJUvpH3hjr
         uS7CLA0X86JkuEk4OqCadQ8bIFIBT5JvtFB4uhyKkCXJ1aCR01Di0hOX/tM8hZ8HR5Fx
         hkuw==
X-Forwarded-Encrypted: i=1; AJvYcCVhvJbx8vSdy484H4UlcVr+1r5ycZtjLzYjstFrQvqSLUPu5AWx8Qb0y3iT7Ib2bhEkbyqJvo+NftlnujwmjUDc@vger.kernel.org, AJvYcCWfESfhtD1APCuawlogz2xFT5ZhElsXL3kDiRH67Bj3XDbeuHWqYx8zdwsyKV71yguidHWgFfJK6bFkS88=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiZdGjwHsgcbxOafqVvHLUazGeJlXXrSyLwscVKSjQxyCcwrn4
	J65qFTT/xSTeAeBAOKBVtFpy/NeUKyy3m/e9bI/0HUUU6mgrxwG9
X-Gm-Gg: ASbGncsaWXc4ygjgdm5Belmq8fAzveEHj+cDUHdw0bQWsQhRVKa0UCtQiYn+/E2I6GZ
	BfvA1AvdZqbI9H14sq6c0nqpnMbw6+QaQSGQc+twaEAvThJeJet+1Do3CxZ/gPgyxYCkvp7/B/O
	C0yPEO807jBqUOCEqgJ0qvQ2puB+d7skX20m3f9YSjak73TOdEcXZhznsIWMJdv93YE48tbJpNq
	W5Ft/LLylbPdnOmo7I/zCLEEU2oXE0APynLW0wjo3QzVctb/5ShwQAh9olouTmf0gZxm2vOqzf1
	lq5nceoFwEA3nY49oqFeq2NPU5pwnPVuDAqO+yJqFCQW
X-Google-Smtp-Source: AGHT+IHd0PRGWmBrH7Qh1zeJojR3yp+7DppiyxJ0iqDbJg/OX4sfvGrbylH83hU9opNqiCqezPzkvw==
X-Received: by 2002:a17:902:d2d0:b0:21f:988d:5758 with SMTP id d9443c01a7336-22c359638f8mr101296385ad.35.1744902989553;
        Thu, 17 Apr 2025 08:16:29 -0700 (PDT)
Received: from ubuntu2404.. ([125.121.98.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50fdb97esm773125ad.219.2025.04.17.08.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 08:16:29 -0700 (PDT)
From: KaFai Wan <mannkafai@gmail.com>
X-Google-Original-From: KaFai Wan <kafai.wan@hotmail.com>
To: martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	memxor@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kafai.wan@hotmail.com,
	leon.hwang@linux.dev
Subject: [PATCH bpf-next v3 1/2] bpf: Allow access to const void pointer arguments in tracing programs
Date: Thu, 17 Apr 2025 23:15:47 +0800
Message-ID: <20250417151548.1276279-2-kafai.wan@hotmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417151548.1276279-1-kafai.wan@hotmail.com>
References: <20250417151548.1276279-1-kafai.wan@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding support to access arguments with const void pointer arguments
in tracing programs.

Currently we allow tracing programs to access void pointers. If we try to
access argument which is pointer to const void like 2nd argument in kfree,
verifier will fail to load the program with;

0: R1=ctx() R10=fp0
; asm volatile ("r2 = *(u64 *)(r1 + 8); ");
0: (79) r2 = *(u64 *)(r1 +8)
func 'kfree' arg1 type UNKNOWN is not a struct

Changing the is_int_ptr to void and generic integer check and renaming
it to is_void_or_int_ptr.

Cc: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: KaFai Wan <kafai.wan@hotmail.com>
---
 kernel/bpf/btf.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 16ba36f34dfa..14cdefc15f0e 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6383,12 +6383,12 @@ struct btf *bpf_prog_get_target_btf(const struct bpf_prog *prog)
 		return prog->aux->attach_btf;
 }
 
-static bool is_int_ptr(struct btf *btf, const struct btf_type *t)
+static bool is_void_or_int_ptr(struct btf *btf, const struct btf_type *t)
 {
 	/* skip modifiers */
 	t = btf_type_skip_modifiers(btf, t->type, NULL);
 
-	return btf_type_is_int(t);
+	return btf_type_is_void(t) || btf_type_is_int(t);
 }
 
 static u32 get_ctx_arg_idx(struct btf *btf, const struct btf_type *func_proto,
@@ -6776,14 +6776,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		}
 	}
 
-	if (t->type == 0)
-		/* This is a pointer to void.
-		 * It is the same as scalar from the verifier safety pov.
-		 * No further pointer walking is allowed.
-		 */
-		return true;
-
-	if (is_int_ptr(btf, t))
+	if (is_void_or_int_ptr(btf, t))
 		return true;
 
 	/* this is a pointer to another type */
-- 
2.43.0


