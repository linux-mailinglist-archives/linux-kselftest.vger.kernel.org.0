Return-Path: <linux-kselftest+bounces-6491-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5362E886D98
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Mar 2024 14:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E866C1F25927
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Mar 2024 13:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23C15D917;
	Fri, 22 Mar 2024 13:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZnSRT1mu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078C645BFF;
	Fri, 22 Mar 2024 13:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711114570; cv=none; b=dBHOJGUjMz1M6UeG4KNhYe2pybZ2h25C23vTh7oEaBZgpL8JgYZvddF95VFrFUPzYPZHl1KkWRycVxhfxLsorHJ+DYHc+no016wsWYv0n6MENhNOMySswa1fF7pewqkLO2+gFeG8Z/uFwvkV8HtXmD3SwnHIG9lFgYIs8JX1XIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711114570; c=relaxed/simple;
	bh=NfRx8CDuW51pFCmmfqak9U6I8Vq3ncrRG8KMibzqtyk=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=J8lwKG3HCwS0l349Sf/3h6dQWGwWDc68ZogM6w43CKfFdXIOfArd7uHqgN5Oown2ushxrX8d9yyxK5KzAgVcjBBRaN82Zb+NEOYFQXjiyJy00e7ldlEFwC9e+EaPYXD+Sg+PSzRipMj0F0fUv2qtHRq9MhIMSQo3TcaTtwOLGPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZnSRT1mu; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4141156f245so15375785e9.2;
        Fri, 22 Mar 2024 06:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711114567; x=1711719367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=89J9FNeshMeUYJqlt0RIBQEumND/jE9mTsgfiNGVfzM=;
        b=ZnSRT1muO+CTD9/5Se1uZb5k3rGliPlTpSFD5G0CptFPtyLlaLhCMXBpOkqEGy84UI
         foySl81Hy2icfMcvZ2VnN9dhreYgtjGXbleqsOx3ZZrEtNgHTkCIIlG01BKggvxYpSKH
         0yti8l6QKeGA6/H4gXyEP31PU+/9PJj/KtMNpW6Zm7ZTN9zkqsqwmRsL1vggspqq/WRp
         TZk2S0EmU4TirgbfOfSJ3rg4WtgIGnsTFGr/ieho5dKuyMiSjleHwAwriyl6XDuyCJxs
         aPAIKUrRAwDYqXLj1DIJDZyblhpjorUrdjjp/RKAG2HFGJTe0od8JZUAWAM34p5vMj5Z
         ARKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711114567; x=1711719367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=89J9FNeshMeUYJqlt0RIBQEumND/jE9mTsgfiNGVfzM=;
        b=b873NG56EVhxRt8rBebRicaPxLI2o3ckvrjPhTEpr4q5lzETetDP3KkYglAhYaxS5q
         xW7WJHWwWkbJuAnhL/TNiFX7slcLS00SGliG5D8r4lTlBD+wXm+8+zajy4PoCukVioMk
         a/G5Z3APc+OLp/55ZWKp/hg5uf0khNnjUA9HNfuj8Stan4HBi2pHF+9ubHHdArtur7GW
         vNrCGYzWYNHT0+teIi7/InoA+XY7dYo3wi91xSUjvYyj9xx76GTkOKtOSmJqnrHMYi0U
         vcWFhUrgaw91ky4bLHUM9yr3dE5Jzq7pM5paynQ3y4zklH3psrTrIMpXT9hF1DPeSAZJ
         N6Pg==
X-Forwarded-Encrypted: i=1; AJvYcCUTHEMymT0ttaVaazqLLD+QBwNbZ3Qr5Aqye5KJg4yWmU2d4g6ajrrClZPYOGKxyNVPh9NuXE9mP08vMX+xfGV/L8AuaAZFQOgNRPffNLot7PhGHqlLr8HNUociiD+tB1GXk619P77gPbbTlI01AY1whHLL4pPDp+PYR0A93U3dd54s
X-Gm-Message-State: AOJu0Yxe7OU7O5HfuxawmJ00aDoT7m1ZBkwrZQ2CxAUjPGk0U/nJt0+5
	+U1L6bdcvpotpHu287W2h1e2DsAQvQmjYxKS6fhMS6E/OB7PFpsw
X-Google-Smtp-Source: AGHT+IFHWWCIm2FvVfLXD8MAk1Gtxae0467JGCEEHu7Yt9gcY27h73Rs8Nqg9TSXbZJchh4+SyahcQ==
X-Received: by 2002:a05:600c:35d4:b0:414:7db3:5757 with SMTP id r20-20020a05600c35d400b004147db35757mr956306wmq.30.1711114567008;
        Fri, 22 Mar 2024 06:36:07 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id h13-20020a05600c314d00b004146d736fcdsm8397220wmo.36.2024.03.22.06.36.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2024 06:36:06 -0700 (PDT)
From: Puranjay Mohan <puranjay12@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf] selftests/bpf: verifier_arena: fix mmap address for arm64
Date: Fri, 22 Mar 2024 13:35:52 +0000
Message-Id: <20240322133552.70681-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The arena_list selftest uses (1ull << 32) in the mmap address
computation for arm64. Use the same in the verifier_arena selftest.

This makes the selftest pass for arm64 on the CI[1].

[1] https://github.com/kernel-patches/bpf/pull/6622

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 tools/testing/selftests/bpf/progs/verifier_arena.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/testing/selftests/bpf/progs/verifier_arena.c
index 5540b05ff9ee..91818a84e86d 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
@@ -12,7 +12,11 @@ struct {
 	__uint(type, BPF_MAP_TYPE_ARENA);
 	__uint(map_flags, BPF_F_MMAPABLE);
 	__uint(max_entries, 2); /* arena of two pages close to 32-bit boundary*/
-	__ulong(map_extra, (1ull << 44) | (~0u - __PAGE_SIZE * 2 + 1)); /* start of mmap() region */
+#ifdef __TARGET_ARCH_arm64
+        __ulong(map_extra, (1ull << 32) | (~0u - __PAGE_SIZE * 2 + 1)); /* start of mmap() region */
+#else
+        __ulong(map_extra, (1ull << 44) | (~0u - __PAGE_SIZE * 2 + 1)); /* start of mmap() region */
+#endif
 } arena SEC(".maps");
 
 SEC("syscall")
-- 
2.40.1


