Return-Path: <linux-kselftest+bounces-20784-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBD19B2396
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 04:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09CF61F21A15
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 03:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47D516A395;
	Mon, 28 Oct 2024 03:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEaL4eT3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F070E161;
	Mon, 28 Oct 2024 03:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730086912; cv=none; b=PpiSH1AA2sM51MuBEyK+22N0wD3EvSzmqadfA8xYerbDglhO7huZQwy6dDSP26+uxenA8nQedP9kOBewRxXbmASyuR9PlF4yWQBTn3pLOx+1Mww8uhDE/H4tygDHuWGXfnRWA+Bi2APmm7EFFjh+DqEmJSbxrCVLOcEPu/MIQUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730086912; c=relaxed/simple;
	bh=0KdL3h9TPkM2JlRYHJJCIpQjO/bIMhVOh2E4rmOp6vI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=WIHbG0mxP1xdLJ7HRVp3GxxoaJkPCBAxHzCvAyP7v/EV6cHhXkgP+HoUAX7tgTLqdzTkF/mmyiUVL+wT/ITGFodYHMXhdouqbZl1TSG+lCu8rW/zzyMuiyE8yn+4X0fhYFpxqul15P3hHvHU8eL/EgH7iaRlnh+fla94QWPLJZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEaL4eT3; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20cd76c513cso33550595ad.3;
        Sun, 27 Oct 2024 20:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730086910; x=1730691710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JDbethT0XQq/2eRWjXORusHC8QdieIAX64J/ApXJme0=;
        b=fEaL4eT3QbGTiOcfxd35c8C9sQmc2skPqenGCh8mt89xRbvW+wkwcz+ixKz90FqL+N
         EE2nB3bUY0HpPlZZVbYrsX+ZMqH9Frqae5OfBzeTKqKHwqjwA2HoTbJRMz3N+CneB3zg
         2vdLl3ryN99CB1tCZYd/iPa0uGDMieG2WPe03ntWcd2TM71zuI9wi+QlBYYliTIHkHUA
         SZuzpgwVytUbUNjB14cCzPou4lg6FKg7iMF0nHkGNqnkjsbwAsX3bXunOmXk6kfOuV7P
         eIR1tBfGHxeM7/1OGKcK56/15T7f6f1oYpgj7mXHPBCQ+bcjaLM1Cqg81rIlAHd7HslA
         8Ymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730086910; x=1730691710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JDbethT0XQq/2eRWjXORusHC8QdieIAX64J/ApXJme0=;
        b=pxsktc99+WlSE3rUVtPKCS3aOl+vNQt2eGyoUZO3KGdnTYYU/ia0pq4mORONaCQ0d0
         OI96SZ8mVpejdK6/B74WemB6gn19GT7OgM9Z5tzt/kgdrPDcx0VopK8w5/eWkg1fIFXw
         tpfwhi3mU9uOw7EC3qYoQlJP3KZeElaKnCMh0s7Am1AoIGPn5JxV4LhRG4Lz7W3cMXr4
         8xuNmahkwBPzxC4re5M4pkjJuELNyN+QpqR73BxrqA03qjbHW65ksR7p/Xq3VDXuo+IT
         D+O0gO5o/WvkCLBQmVX5J4e+5aa9HrU/BqA9zJ9Jmy62lS+e4NjgHVFVT85Qj2pwGIpm
         FZdw==
X-Forwarded-Encrypted: i=1; AJvYcCW7N9YIlUnIVzQtnBdaSqCREqO19Dx79UwVvGuJ+Pr5eXi2PYuSEb0M4iQXpOqWP1pVAdtSJhDpKNnUZ6tmFSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN+NTS/Xh+NdNdVFRNajvnFe25nIHCSOkYMeoBwUrLJU3JK9sz
	gpPOt0vh3caCPSzirpbfFhqMpWtnatg38faRskkUWSfXr6d1SfcQ
X-Google-Smtp-Source: AGHT+IHgnETDz6Ld44mVjoLBQnQ1UPHQH3pfCPUFnb93Gvf6//TB8LHf78LERRpQHXPuH8A4ZLYCkw==
X-Received: by 2002:a17:902:db0b:b0:20f:c225:f288 with SMTP id d9443c01a7336-210c69eabb6mr108284285ad.23.1730086910220;
        Sun, 27 Oct 2024 20:41:50 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc030a05sm41958925ad.229.2024.10.27.20.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 20:41:49 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	mykolal@fb.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH bpf-next] bpf: handle implicit declaration of function gettid in bpf_iter.c
Date: Mon, 28 Oct 2024 11:41:43 +0800
Message-Id: <20241028034143.14675-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

As we can see from the title, when I compiled the selftests/bpf, I
saw the error:
implicit declaration of function ‘gettid’ ; did you mean ‘getgid’? [-Werror=implicit-function-declaration]
  skel->bss->tid = gettid();
                   ^~~~~~
                   getgid

Adding a define to fix it (referring to
tools/perf/tests/shell/coresight/thread_loop/thread_loop.c file.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 tools/testing/selftests/bpf/prog_tests/bpf_iter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
index f0a3a9c18e9e..a105759f3dcf 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -34,6 +34,8 @@
 #include "bpf_iter_ksym.skel.h"
 #include "bpf_iter_sockmap.skel.h"
 
+#define gettid() syscall(SYS_gettid)
+
 static void test_btf_id_or_null(void)
 {
 	struct bpf_iter_test_kern3 *skel;
-- 
2.37.3


