Return-Path: <linux-kselftest+bounces-3455-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B19B83AB7C
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 15:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8675B28F92
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 14:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867357A71F;
	Wed, 24 Jan 2024 14:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DSINa5t3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BC677629
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Jan 2024 14:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706105723; cv=none; b=uy3kEbXw1uZcni+fpOIQRg+3eXS90XowFfRyYV/+3jE3mygwBbCw3xSYJ4ZNlHHdyDx2prdokeqhRlqqXhLbd5Ncu7yznMwQ/OGtjALPnryDOpdZV7+Je33s269GqLtGF5jszEE2G97xmOxNy2Z5h1biWI/dNdBBwr3iYHhDVS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706105723; c=relaxed/simple;
	bh=0UEj8Oof/abgmDFcrUPI79i5BHVw6bCbAYsJDPU2SAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TzUPkqRG/KEx9pFl7G/j+oid6gEtKoAE03917PvVgA0IILyr2s2ujdKBspL9DEaM9FIz9JrmZQvALPuHSacx/dZZnMBSbRzbHVnYwCiemeitUz7KHNKG7Eiq1LUTBU1y6e9/kPJ2/1n7eo1drW6ql45lez/C9a+tjF0lTDDvorU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DSINa5t3; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a310409589aso117266266b.3
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Jan 2024 06:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706105720; x=1706710520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kinIyrY0DiVL9FjvsbU90IrpJuAQN+qhOmTSZHZdLpE=;
        b=DSINa5t3MmDC8b2fbZ/xUX2D2ctlZnXEZf1qMjsrZPQmF1Chq0+fBQPztuxKmSTYzl
         jlPVPKICQBJThTEyqE2APseDp/9idHUSrfvC07LuCyJBJjNKn0IGMxMI28Yj8SeY2nv4
         AARfcbe6g+zH5MSAffVrD+5g1KUsNjIJapezxudwGujChqw2I/2Bqh8eAjQ5AYpUwN7H
         omJgIPvIBfEnsicWt5Fi5lxfRnFxcoob5lHp/7dy9sm8LGlKyjA9WZNahRGK3oZ44CX2
         QFI59jvPophJ2WO7t3tF5okxVF1PMcgk3D8bUIrkJ+I+4mctPB3p8Ig1iRCVwRtx3Cv8
         9u3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706105720; x=1706710520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kinIyrY0DiVL9FjvsbU90IrpJuAQN+qhOmTSZHZdLpE=;
        b=Uzb0Cx0BMwJNjY5JpiuIQ+ovmj5m7u6LnTI6kDPrMFXFNTFOYENs00i7AcJQmYX34N
         7xdHfQHVL83zs/uO3Ret5t/JsggilG8uxTCxrQ/3p7F/xwSnNOFate0kPO29xe9U1tbd
         80EAcBWNEk8YIHHKtJlCV3fuJStevfFuGS7BYxbodH4rStEkg+8/WVjrZb693Pd6AE9K
         DczMaBw4z2759R/6gKkvKhePDU1TroWBTeUQ/LESR0oJChrCFNAfFzrVDDticC61taSo
         a2wqZfDTfdyV36nxI5LcQrwlo1Cj27ebrrla8rrn1bJaOAzdnix+CXF04Qx1UN57jgxF
         ReAA==
X-Gm-Message-State: AOJu0YxjsWfD82i85g6DMkT90hxyHb1fAws2ag8fFRWFTwfThSMaWaoF
	TpFY4GJLCv+9zJ3SJqfp4AdlMTf0A92tANxt4u4F53aJksCIiRgqspOJZEELe5k=
X-Google-Smtp-Source: AGHT+IF4+LUhP0g/9YJ7YhuuFE5ZYZEhnJFlqdsUbpxgT5uNDQ/9YEAlGlL6+jOgnpmMApQnrgCtdA==
X-Received: by 2002:a17:907:30cd:b0:a30:de41:2c with SMTP id vl13-20020a17090730cd00b00a30de41002cmr447163ejb.161.1706105720026;
        Wed, 24 Jan 2024 06:15:20 -0800 (PST)
Received: from ttritton.c.googlers.com.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id vu3-20020a170907a64300b00a2d7f63dd71sm12399097ejc.29.2024.01.24.06.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 06:15:19 -0800 (PST)
From: Terry Tritton <terry.tritton@linaro.org>
To: keescook@chromium.org,
	luto@amacapital.net,
	wad@chromium.org,
	shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	bettyzhou@google.com,
	Terry Tritton <terry.tritton@linaro.org>
Subject: [PATCH 2/3] selftests/seccomp: Change the syscall used in KILL_THREAD test
Date: Wed, 24 Jan 2024 14:13:56 +0000
Message-ID: <20240124141357.1243457-3-terry.tritton@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240124141357.1243457-1-terry.tritton@linaro.org>
References: <20240124141357.1243457-1-terry.tritton@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Bionic version of pthread_create used on Android calls the prctl
function to give the stack and thread local storage a useful name. This
will cause the KILL_THREAD test to fail as it will kill the thread as
soon as it is created.

change the test to use getpid instead of prctl.

Signed-off-by: Terry Tritton <terry.tritton@linaro.org>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 5e705674b706..da11b95b8872 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -784,7 +784,7 @@ void *kill_thread(void *data)
 	bool die = (bool)data;
 
 	if (die) {
-		prctl(PR_GET_SECCOMP, 0, 0, 0, 0);
+		syscall(__NR_getpid);
 		return (void *)SIBLING_EXIT_FAILURE;
 	}
 
@@ -803,11 +803,11 @@ void kill_thread_or_group(struct __test_metadata *_metadata,
 {
 	pthread_t thread;
 	void *status;
-	/* Kill only when calling __NR_prctl. */
+	/* Kill only when calling __NR_getpid. */
 	struct sock_filter filter_thread[] = {
 		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
 			offsetof(struct seccomp_data, nr)),
-		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_prctl, 0, 1),
+		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_getpid, 0, 1),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_KILL_THREAD),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
 	};
@@ -819,7 +819,7 @@ void kill_thread_or_group(struct __test_metadata *_metadata,
 	struct sock_filter filter_process[] = {
 		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
 			offsetof(struct seccomp_data, nr)),
-		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_prctl, 0, 1),
+		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_getpid, 0, 1),
 		BPF_STMT(BPF_RET|BPF_K, kill),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
 	};
-- 
2.43.0.429.g432eaa2c6b-goog


