Return-Path: <linux-kselftest+bounces-31397-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FD2A98966
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 14:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C79F41B66A3D
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 12:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F38216E24;
	Wed, 23 Apr 2025 12:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hADPNT4v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9118FC8DC;
	Wed, 23 Apr 2025 12:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745410470; cv=none; b=InUi0AMcrgGAUU2u7rPfWqd9o3mQWkMY2zXWZvEMkG71EAxy1XJEu8iLGPuxS3OfywrAtvf6vJzFlbZpqN6PR0GHFZHizk0pUU3Xkolq05dn+R1aX8D8le4liYQ/bQXFUE8rYvTAmBWxRvZV7a23FPEwa/cz03wdAEpVx2Rvf10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745410470; c=relaxed/simple;
	bh=xuhutYHLLIi1SPFjf7l0YQ8ICDo1tcppXxRsxZRGtuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=muUzLJUtYqkhR5dZqKx2hAAANSwz/CvZfOm50y6qyM5B6UCAqdX1GLEzk0hO2LRVlF737J5tJvblzN8DeBp9P9Cc6w85ipsTlvD2MP//rr+N9txnh9XcaaGFqoxj2/U+0L4b7GzihCtmqD7KS992q4Igt86xFJAe1s0/76MPens=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hADPNT4v; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-224171d6826so90044925ad.3;
        Wed, 23 Apr 2025 05:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745410468; x=1746015268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yxfWSBbcBV+w5mvjd3mF3cCYygynlfPhD+D65wEeaRM=;
        b=hADPNT4vlJKUqy8xOzbX5m4EHMWpTKsCh6EMNIKhk8bKFVE/bpvXyer8X7ERSpplon
         xzYfGGUNC1YNh9ffyFb+FcLw0sIcDpE9htejE10N4fIvUv0On//wwMrPfTR85f6d6GqP
         T20tZ5BGiK+fKAH4tWuShzd8h9JIgVGoETcYSBr8ijTym+RrRtaQ52sqDphcEp7SjZOO
         wcd/alNDjlwwUw8jt/p1GSvmfZgn0DnPjYLQcw9P4FIWErw53G5eX+prE/8+oqSA3tRf
         gP79eBrJRDFQbr3FAeHHa9Wf15uSM0q3TVWkd1qW00UNcCh3xXPWINMhCYhatbLJi4Xz
         WiGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745410468; x=1746015268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yxfWSBbcBV+w5mvjd3mF3cCYygynlfPhD+D65wEeaRM=;
        b=bQgqt0IpuTc+0bdzhU/c/+aUNyuvDyvTbebtGM42HfhATN3SH0ECPnIrXCB6y1BOlU
         rRa1zVSNPkKHxn0PXMd9cR7PNfEClQCQn6zZNuZB9ttQcuFEc7UQHI/88DwUGk3v0mxG
         qaw1yhlq6hhLmZSQmFeRMnnFEOqwuUkdXhPyc8AaS3XGY/eTKxcfD+tlwX/MuxXB0PiF
         UKlwjbi0Lc8yiU/urTMECQ2Ju6a9BucoB/GOl2gnPXxJ2Pqb2L1qDlWxZT1wcqdNMA3T
         xjMkA4nYo8cHQzHOtx5MaCNr1waFXN7NRslZGylUc0tEBWcBCA27exJybbPgBcRU+K4z
         5kxw==
X-Forwarded-Encrypted: i=1; AJvYcCWl54FmX0R8XnxSZlsqLo9ttwSVNeUZJDHwX8ltbGh4Cnyj+NCo3ctw1hKgOjwKlbTk4FXBFVtk9C5UFRFMl/fI@vger.kernel.org, AJvYcCXUqYUFNmLkeiFvMB79bU9jtmSQmoi10ppgQ9fxNUKrs+oooj3nlb/2gBv1pdaf5mSq44Jyyxcl@vger.kernel.org, AJvYcCXZtjKa6i36L+V8KYMpeNMOyoXnO92XWCGi2AaMfrMQ0ZF9qfWhNJ0MygqK/c5RvH9IYqgSY+PBgSt7kZw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy65+K+TPr5XWwQJ3M79xW+8sXaR4dbuAGKaOy1feVOEqu7TdEh
	H69exsOy/QNQ/c6hnf15SozE+DYcSsn9Y7wgwDZ+8giQ6SvRHX1H
X-Gm-Gg: ASbGncuGKBs9CGN4+m7BA6cSGs3BY3hIo7PnCElhqx0Ql74NEZ9oMylkRgxOhiXR36E
	klx5NSGEvDtCLktLItEn5QVXojAeovnlJVmYjLzSIseB8J7im7hwGVEUmj7gnxjwx7zTB7x9Y2f
	hOfDXPik3cIJEbIch7hDC/EQIEEiA32WxGk/jnqqTtcsem5XIZMBn+gF3EGF820D4kZ9Bxpm10I
	frVj3bv/OKA6HE6mcoTHHHCNnT23r6pk3oBh9S8KVXFqpwxzUEqsPCbAWXvwQwtTsJf2r/7knzA
	JXkaTbh8ZhvcQG6vHblV9NrycZnawnhjEUNTXU4xDT0=
X-Google-Smtp-Source: AGHT+IG90gMxC1OuKnlwsNh2khtVE+pLM40Q9jlq/gmVdarjrJ5bEeT910gwd7Q27ZHisqccConaag==
X-Received: by 2002:a17:902:db0f:b0:215:7421:262 with SMTP id d9443c01a7336-22c5357f020mr310942675ad.12.1745410467819;
        Wed, 23 Apr 2025 05:14:27 -0700 (PDT)
Received: from ubuntu2404.. ([122.231.145.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50bf5528sm102647295ad.100.2025.04.23.05.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 05:14:26 -0700 (PDT)
From: KaFai Wan <mannkafai@gmail.com>
To: alexei.starovoitov@gmail.com,
	martin.lau@linux.dev,
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
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	leon.hwang@linux.dev,
	KaFai Wan <mannkafai@gmail.com>
Subject: [PATCH bpf-next v4 1/2] bpf: Allow access to const void pointer arguments in tracing programs
Date: Wed, 23 Apr 2025 20:13:28 +0800
Message-ID: <20250423121329.3163461-2-mannkafai@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250423121329.3163461-1-mannkafai@gmail.com>
References: <20250423121329.3163461-1-mannkafai@gmail.com>
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
Signed-off-by: KaFai Wan <mannkafai@gmail.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
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


