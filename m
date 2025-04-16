Return-Path: <linux-kselftest+bounces-30958-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 046F1A90889
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 18:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E89E188E7ED
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 16:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C44820D4E0;
	Wed, 16 Apr 2025 16:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="niqvAge2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FF420101D;
	Wed, 16 Apr 2025 16:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744820300; cv=none; b=uuJLKIvmZfOW3vW/0PmvIvX+JEEs1QGdy3gC1ZMcJwAPyHCPpbiWIiTWCxovWE7xIyBzSx9LtvOus9IYwu77JDE3XgdPJb6BGUtB/+Sv7P2i+CZwxCWSU9GwrND013Q+cg8iA+sQvKtT7G6ACpk/LFEnL4LGitnkU93RDag9ZtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744820300; c=relaxed/simple;
	bh=HuLZrpnUgvXs7rZMYabg/72CmDC5K9GCaw0aX6ByIGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j8t28fS0snfqcjCLRO18ujE8LORIkK1v06rOAVSi3g6SnKiCmiR8Z30qqo5hruh+cYpCdSENuCHA/wSlF1fPuAdK/JQjkFkieL8014aEv2rUlILX62qwmzH2R66xxBtt0B1m1TGtOXHQqUHg0/YhPo8xahJVPxujrLKSHvbzZ4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=niqvAge2; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-73c17c770a7so2618781b3a.2;
        Wed, 16 Apr 2025 09:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744820295; x=1745425095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jgiDHVmmQd1nbsGItRp15DFOu1EGiF+eEwcSvxaedAA=;
        b=niqvAge2tLu33hsMpjsnmp6aUBBbVr/PHJ9VJn4nQ6SYVpSOlW+uD0beO+g7hL9Ksy
         SuTTr/jD/hv6IWY3IvRneafqTVQfw1fJ04uXVj8kGpZe1lnq3+YdTTh59EgGbCzWWo+q
         SPx8vBboTGnrJOzYjkkv5tYMLKQcWmyYIXFIjIJVILJlzCCnEzWloZexIY/eH0oszqWu
         +z+RS0l2Bj3KsqRugEqc7haVwkVVkVkTiOcE+jjEguNl43AUM2g6F/UP2YZzdn5cOs7y
         DwrNscvOdvSY193qywTJikUEXrq6eAqSkDjabdAkvH73725556YpJ7pJDABP+ykHPTKf
         Os5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744820295; x=1745425095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jgiDHVmmQd1nbsGItRp15DFOu1EGiF+eEwcSvxaedAA=;
        b=kqWqt/y7gN2PNTUSzzFVZFxBbaaXmTn2ccOh53ITU75tjqIrt+XPF+ohUcYbFTBoj/
         lWeI5sjXrVMKP7wVjLeKCPxU8puakM2FE0xcWCKsG+HSshQupSnXL71YR1JzCICHTYyi
         eoM1pqmD3ZQdPlN7II8P9mNTsclXNG/vnI6C3axXbnwU5oLxrux1KJpgCPIMDIEMKhGT
         TtslR9yG+XUT8sFiimtFAbGTENIhp5rmS118DgBcW4+4OwxRpDwZbKm+2SuMsSfuperB
         hWdMYeIXPi++vruunqgZDzkmlUBKhrEJ50rDp3tQZAeBVdX2Dwp59rJ/Hsnb6ejlMNkm
         yr6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUNMQ7PL/ZvO8+gaBriJEJ3sjCSnkUqKQsFz+nxz2euq4EuE4xzqBvCcuOir3sjFs5w9cbsda8vcEg1t9c=@vger.kernel.org, AJvYcCUgXkWyNk76cerFqwaBFaZiQG0xaYajLvPt+ueMaGg2UA5Pw0SJX1YbJeIky33SABJS1yBgHJSPSQYz+GhsWa48@vger.kernel.org
X-Gm-Message-State: AOJu0YyqSWSjqCA/Zg8RKLPddKQnGmgN+YNtJ59Oh+LZ8hTyhS1fWewr
	PsA5lpPbMsxajfOapJvMFGTxUSJ+BcetopaoaJlGLpmKK4+DwOC4
X-Gm-Gg: ASbGncuHvt2JAgs+cqxkV3qt6b7uZEyqGzkIQ2ze/dH4yHs4I5JNjE7rq7wIy/MANfg
	IEVs6uxerIXg3LHiXIViuNfAgE7dHBl5ZRRzb0rGe6l4dIxDMIIEWidkx4JNBvufcYppJ9kQmY+
	WHTfvtJdKT13uc2d6QBuz02aM5fqSJf+Hwbkq1Q+Mr/0iqeYGj5qypKXGtWZ/5IiUFtJ4s0eQq8
	0p4Bqy0qYOI3Wcid1Zan+Or0AM7gV7CbdZVgkNrY0z/gSmalIaQlDmiNBe4Yts9FNDUEo6Eh6lS
	iwXd3J1iBSegms3YHyQY72NFAroQUOofMmQsyPOQgXn3
X-Google-Smtp-Source: AGHT+IE/pAJvHoT/3ZKsQdWlPYWYybAWk5mIvjnu/4etFKIz6ljqCQUvWvsFr9h68+iqIoh1zdYaWg==
X-Received: by 2002:aa7:888d:0:b0:736:baa0:2acd with SMTP id d2e1a72fcca58-73c267f1bebmr3569476b3a.20.1744820294757;
        Wed, 16 Apr 2025 09:18:14 -0700 (PDT)
Received: from ubuntu2404.. ([125.121.98.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd230e355sm10921939b3a.139.2025.04.16.09.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 09:18:14 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 1/2] bpf: Allow access to const void pointer arguments in tracing programs
Date: Thu, 17 Apr 2025 00:17:55 +0800
Message-ID: <20250416161756.1079178-2-kafai.wan@hotmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250416161756.1079178-1-kafai.wan@hotmail.com>
References: <20250416161756.1079178-1-kafai.wan@hotmail.com>
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
 kernel/bpf/btf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 16ba36f34dfa..0b1724453b75 100644
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
@@ -6783,7 +6783,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		 */
 		return true;
 
-	if (is_int_ptr(btf, t))
+	if (is_void_or_int_ptr(btf, t))
 		return true;
 
 	/* this is a pointer to another type */
-- 
2.43.0


