Return-Path: <linux-kselftest+bounces-31798-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EDCA9F7F7
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 20:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 732E17AA95E
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 18:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282F92951C0;
	Mon, 28 Apr 2025 18:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1Dywj3PP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D721C1AAA
	for <linux-kselftest@vger.kernel.org>; Mon, 28 Apr 2025 18:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745863437; cv=none; b=pUwdH5ys94BBaNjFTtWxmYY7ylLhP1rjaXPcJCEeIzX/IMWzAfUsFiQRfp5+pCqXqbCBNiYdUAxbgz4r5ky/a8Tex0HyFbbHwY6uux7HTEbQudOTiYr+pZwgerBR/9CP0x0yZ12jM2eBzThFvuAjg+spPWLhlLsezILNKYXV1sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745863437; c=relaxed/simple;
	bh=/mL7HPcjZJGRPYi0Z91nMrxEdW1H1DRgXdBETT/v/m0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=EWR4KYmjXlLO1oki6nyW6zCWxOHgb7PE3uWRXTtHAQ4w2+7mazsbhq2AN1M+7DAYSLwHx+/bOhNO6guZEN0Mf2BnWwUW0z7JrhPvQDE5KVnG3HHq5K2WvX33CFRKzLqPKrFUuoQSc8q1MTNTusGhPDY6636NbKY8eCPYXIfHNL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1Dywj3PP; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff8119b436so3941219a91.0
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Apr 2025 11:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745863434; x=1746468234; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Jrm6Nx7Z5Mh8oLM61Urr/bTwwYotksqIY3MvIPdnC9o=;
        b=1Dywj3PPfwyS/hAzq50dRSIrzoO563wn66dysDIgProw9tQZgfNC1gYviTTWdtKIvf
         kcxi9ztFBvuQx9QbV2Z+2aRHDkRQP1So6+YGLhY/018YvDJ/qO7OEbXyt2btv3lQUr0Y
         3Vjibv3a11ZGVgC3WzNVb+KVG5qWG75s0XIQ25V2hicJgmW90ly2vvYNLTOlit6Msfy5
         ssORyUNZB84qgGzEws2usWK02pjteobEPvXR6H9WKr+Lbs4FaaSM77auC9gaYfa33n2v
         E8c5imY9gt9CgB8YE5NzegmoBb+lBNbRRnpNnKFabu0CoWwsVAxDHg04luCcPCpP1IY+
         ldTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745863434; x=1746468234;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jrm6Nx7Z5Mh8oLM61Urr/bTwwYotksqIY3MvIPdnC9o=;
        b=pQVRqYTg7ivs6gyglFAXoeq3t23n3y9JC3hxeVPmxBTcHJzVWjPjqiaYIF3f3KLc6Z
         fJbUHb4+onzrx2XdkMhb2TnsycacAfAYlZgk15tCeB9ZlHFpsyoAsKRXgkjFxvCjognE
         h8YDjHmo/pUtIFCde0eMRL3lHUpdPz0NSDXanJjaVZINNetwLEnEmcsfEN7f4csCpdjA
         l0AFcOptd5RVYOXzlSJIY8XIP6GcZZTVy8Gdj8nse5aDo1pD9Wlhyy7dApRbFC0R1Ggd
         ocX2rcX/t2WKBxEy7adbnr7A7q1zRhtccOFtqQzrjrV1MevjLjpAyYR+QRvRZcW+/hLA
         F4zA==
X-Forwarded-Encrypted: i=1; AJvYcCUR4B5DojR9yUNau11c8b2kYczR/XEdWXAaAe71wIu3hIGoxTIa0s8jCilBI974+Qo0smfOBBN3xBHPUY6wvms=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+bEPyPPQXjSL1nb47vooRLbxGpzmHPyLqMrXItF/YXeqxEcBi
	eGM9IsJYgCHsGBStueFyXZzPa+Mdp9Hai0EGNB+9Dyzc6k6HNPQ3WZzjNk+nujyrgfQ7umCSv4g
	P+F2JC2dxg4096A==
X-Google-Smtp-Source: AGHT+IGFy7WG9oO3uBh4Wi8t7O9tAPuPJeA5DbCGTeCTVwRypV0To3vLIJ2Ay+WqLvKrHqdhPZuiAH+PfgHZ0k0=
X-Received: from pjbnt15.prod.google.com ([2002:a17:90b:248f:b0:30a:2020:e2bd])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:554f:b0:2fe:dd2c:f8e7 with SMTP id 98e67ed59e1d1-30a21551e90mr1172926a91.10.1745863433996;
 Mon, 28 Apr 2025 11:03:53 -0700 (PDT)
Date: Mon, 28 Apr 2025 18:02:54 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250428180256.1482899-1-tjmercier@google.com>
Subject: [PATCH] selftests/bpf: Fix kmem_cache iterator draining
From: "T.J. Mercier" <tjmercier@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>
Cc: "T.J. Mercier" <tjmercier@google.com>, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The closing parentheses around the read syscall is misplaced, causing
single byte reads from the iterator instead of buf sized reads. While
the end result is the same, many more read calls than necessary are
performed.

$ tools/testing/selftests/bpf/vmtest.sh  "./test_progs -t kmem_cache_iter"
145/1   kmem_cache_iter/check_task_struct:OK
145/2   kmem_cache_iter/check_slabinfo:OK
145/3   kmem_cache_iter/open_coded_iter:OK
145     kmem_cache_iter:OK
Summary: 1/3 PASSED, 0 SKIPPED, 0 FAILED

Fixes: a496d0cdc84d ("selftests/bpf: Add a test for kmem_cache_iter")
Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c b/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c
index 8e13a3416a21..1de14b111931 100644
--- a/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c
@@ -104,7 +104,7 @@ void test_kmem_cache_iter(void)
 		goto destroy;
 
 	memset(buf, 0, sizeof(buf));
-	while (read(iter_fd, buf, sizeof(buf) > 0)) {
+	while (read(iter_fd, buf, sizeof(buf)) > 0) {
 		/* Read out all contents */
 		printf("%s", buf);
 	}

base-commit: b4432656b36e5cc1d50a1f2dc15357543add530e
-- 
2.49.0.906.g1f30a19c02-goog


