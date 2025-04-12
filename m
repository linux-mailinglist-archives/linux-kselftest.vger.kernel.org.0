Return-Path: <linux-kselftest+bounces-30640-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4522BA86E47
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Apr 2025 19:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 355FD19E0004
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Apr 2025 17:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7034204C00;
	Sat, 12 Apr 2025 17:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8D1Apsh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3831662E7;
	Sat, 12 Apr 2025 17:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744477604; cv=none; b=OFt3QJBM3OlLBLNivC6rc/hGuYC0X7IKOaEzQGw+nYE2PTf8Se1BvY39YMjoiSnS9lN9NKh2nr7PEh39upWA+mTTYcZ63DNaV60vKUVGwnQRwQmlYQjEEiVFQ9bhCDTxo8fZi8AyDZ8NT/0+VcySZVyXIoeG6GomeUEG/ZBizdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744477604; c=relaxed/simple;
	bh=61FhjjL9N/+hoid5VOAtkBwn/YqBoDRWyTxqGjbrBLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HUtE6Nwxd2NJVLJdapL4eSLk+VEBKtRxGLaqZJ2YZuh4PRyVyzZ0vq63PTvEo8iTrP0JEcdszkowhFGgy+i97DxWI9zVhY6PN+9w0+LsSgcZu+3/9mwhGUJxPYHssxlwaICF+Qw2D+dJhRkO6p8C/T5E2G6zxT4XcheOXIgIX2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8D1Apsh; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-736b98acaadso2757131b3a.1;
        Sat, 12 Apr 2025 10:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744477602; x=1745082402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UPDI1Qzq0cFcLbuE2Nuoihvy2bO7cAOmSG5K/1gvWPU=;
        b=Y8D1ApshqZhMGhUeileh90SIu2WpWGhYX/kMtvbBgs5hEm+D0Yk0I1QSWF71Vg20ky
         xqBpkmF60BiYQaGQH+RHavTq3yVbbqGBKbM0Y+qFTuCb0/fEoLPGrfz0E2f8+dSbQsFo
         h1FySMymF+wwww8g/kTe9uxcMqlAbC6oXkv6sPyWpfOCus/UGiOjB7OdrMoGLW2OOsa0
         kc7PfdxwwfyrOu8izdezZzaQcOkuiGwYw/rCKfWCr6HCEACi5vKdTlxrdJSD/qrfuF6Z
         RWRInfkgbJ/q0LehNP8N0i6EyYdL3q7iDzqXY6y8af/lYKJLcwJcThn5i2rZY5Fq9wuM
         PoiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744477602; x=1745082402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UPDI1Qzq0cFcLbuE2Nuoihvy2bO7cAOmSG5K/1gvWPU=;
        b=Vmh6TDbYRqdBHY9nW2u4sq0XOMvVoMjfvRAHIBKAclUw4MdeoLlRWBgSNcSyy3Zbow
         N289LRVjKq2vkDtcm2JKViFFmz2O8X504qjRM3IgDKfEP1fftEygn9to7jxi+JhDY5Aw
         0FOx2PjozVJmjag2ABwa8dNAPzDgWDDC7+1sJINS9c5H4XoD4uOvjnPP+b8T02HI1yxj
         /z5sittrFo3EE/UdYyWY7XDHT5dDGFzgQjbZENyMOI/FKf7OCY+bMLKCfvo6xSLxXBtF
         6LFxUU/kLDCfGh+0SA9I5LFzZMb/esR4Bf3C/vdS41vr2jZ0Qt1hEwavLR5WlRxuh6g4
         dknw==
X-Forwarded-Encrypted: i=1; AJvYcCUN+K2vdo1R+dBxEYah3dNOEYrDP/gSfD713bi28GuHu5HkvcfWw4qHgS1zVx+92PEk++/ql39WBj+NYk4+6tPr@vger.kernel.org, AJvYcCW/QZ5F3dK1jBFY8RqDBP+vxpuxVs5GKPqZUZLkJyxt2aAJBUFvgYTKUXtDR6rC6qXN/XMTHSHbd5qjoeA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/5zooAehf8hzNR7OZ+afGSn7g7GvjHWGmAK6uu714ivztAiP6
	ExFzqHxZAufCEGfeyAPOdykMgGvZSNZpGVk3T9Ennqs0tmkWActj
X-Gm-Gg: ASbGnctn7Z3ranHzNZLwpUejq4rvUODDch6IbYASvlwpXQigyPG118cuvQPvN1/ZLfQ
	7s57m0c9fs3bXffARhcsD/tltUXGjvf/al7+kjbf5vq+jnrI8qF9nWm6XVYmSk3ROD5PF62J43F
	EVQka5DHr8U0g6Vy7d1Vze14i3nVQ71PXd5R86fmWMrO8JaFgh92HUGYqS7n7O9IYo2fV0j8MoC
	9EXbAzT2JJzK0Sg2jb5wAErG90TD3ChULI8Rv4qoWRxTJXBOz5tAwnfNyUFrwpm82rSETbFudBS
	5HNB+2xfmzoSNnRahtpInX2j37HMDpx9NtvApwpebYDV
X-Google-Smtp-Source: AGHT+IExFXxa3PECkLqo2+aIIqyB11RlHMSbRhk7QCI803PU1uvv+DxCSjai0hlOvsVZkpb79F21Cg==
X-Received: by 2002:a05:6a00:22cd:b0:736:a8db:93bb with SMTP id d2e1a72fcca58-73bd119ea62mr9207103b3a.5.1744477602266;
        Sat, 12 Apr 2025 10:06:42 -0700 (PDT)
Received: from ubuntu2404.. ([125.121.98.110])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd21c20f3sm3610710b3a.39.2025.04.12.10.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 10:06:41 -0700 (PDT)
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
	mykolal@fb.com,
	shuah@kernel.org,
	memxor@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kafai.wan@hotmail.com,
	leon.hwang@linux.dev
Subject: [PATCH bpf-next 1/2] bpf: Allow access to const void pointer arguments in tracing programs
Date: Sun, 13 Apr 2025 01:06:25 +0800
Message-ID: <20250412170626.3638516-2-kafai.wan@hotmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250412170626.3638516-1-kafai.wan@hotmail.com>
References: <20250412170626.3638516-1-kafai.wan@hotmail.com>
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

Adding is_void_ptr to generic void  pointer check.

Cc: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: KaFai Wan <kafai.wan@hotmail.com>
---
 kernel/bpf/btf.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 16ba36f34dfa..e11d3afd0562 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6383,6 +6383,14 @@ struct btf *bpf_prog_get_target_btf(const struct bpf_prog *prog)
 		return prog->aux->attach_btf;
 }
 
+static bool is_void_ptr(struct btf *btf, const struct btf_type *t)
+{
+	/* skip modifiers */
+	t = btf_type_skip_modifiers(btf, t->type, NULL);
+
+	return t->type == 0;
+}
+
 static bool is_int_ptr(struct btf *btf, const struct btf_type *t)
 {
 	/* skip modifiers */
@@ -6776,7 +6784,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		}
 	}
 
-	if (t->type == 0)
+	if (is_void_ptr(btf, t))
 		/* This is a pointer to void.
 		 * It is the same as scalar from the verifier safety pov.
 		 * No further pointer walking is allowed.
-- 
2.43.0


