Return-Path: <linux-kselftest+bounces-40143-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A8DB393C7
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 08:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E3EB683FCF
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 06:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F5A2192E3;
	Thu, 28 Aug 2025 06:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="erz+CSgk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F7B17B425
	for <linux-kselftest@vger.kernel.org>; Thu, 28 Aug 2025 06:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756362699; cv=none; b=B3xVIoJEnnU1ivuRgMuLgdXWFOoTOQ0J/Yl8ghmYAaaGXX4MgsA64oN9h7zZO7WR7EgtnI7rue1FMK4kILCooHvjC5q3zmMyYsxM5Ai9GoXfhnclMxCrAKKqO2ZZ4Gttm722KR0SGMIjZTUQ7TEH0eM1hVCWZMcdHjfs1Lc4UA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756362699; c=relaxed/simple;
	bh=ANHxGhy+ZSuur2poAq8Vxc1SrXLCCO2XIDNhknGS4V8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=L9w4IdxlX+iGhgYodDqVvjx+nTUcd9Jd1Xz/5tr/U4lzwi382uIrWox/MofEij5bHs6gynhyAGgYd4OneeAm1TpRMj8yGkcs+XHnFm03abvjEAKqiUY1wRHg9c0g4BVMXjHZlexNSmRhxniLncsobkdFnVuOCb4cQLZrI7L+At4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chibar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=erz+CSgk; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chibar.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-327b5e7f2f6so294282a91.2
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Aug 2025 23:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756362697; x=1756967497; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HMg/BC9oAsYTzDI+a5JjXGvbJEi4LQczNwcvtLB7ByA=;
        b=erz+CSgkxhCnmiMtUI6V96kpOmn/RNHETvRemRfox6tup5PHJjfICYvUumHklnbZ37
         G5BXGF0qeaGiTaJkT5wuY7ftsHYveUMwaZDqWRSbQzSsfHXF8EppBBDN/ooRCfxyyJkE
         9DELc8rngXjjJoVlhwe6ZEjEJpyQHnRr6Y+YoePYSYI9eZ1OlI8mtTzMzkuwq9Le9Unq
         B+aHlVEC2emC4kbkopUx9ESgvmD9tDrkJakVZug1onv6jtQvEIuaUKPpa9CmMuWBFSbh
         DpgAHHC4h859SKUsUW7Xb02KrJSo2HCb2Q1ffwGKsdcRu49DTBIEof6+IAXHr6WP3LwN
         p5vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756362697; x=1756967497;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HMg/BC9oAsYTzDI+a5JjXGvbJEi4LQczNwcvtLB7ByA=;
        b=reXfWygF/HnK8YWubN9prclWr8aBd5LGa1duE8htw0rqzWiI6bbzogUjCCY4ltziUr
         LW/At3u4up/jQm82ugYu4zhBy1Fb6H/vnL93Jc8Zm4v0Dcw6YG5s8tUqrUuvUTTtKFHi
         qb0dT4aCTAcOYT+ax4BktGH5gudgi1o4O9jAY/fwWfK9hdOhLXZliiBhSA4xZmX5stSW
         fGKc9IdEsGJK4AzmeODabtIJ19wNMvTOt/zyJ1U5JccpxNnySvD1jHZ7qjvW9s7MjrIL
         8nSLqg9vqJVFETIHeRC7nRM3bBEbNYWhmOqUxRa8uAtllxyJXU6BMtknbpi+yyPVIx1i
         2nCg==
X-Gm-Message-State: AOJu0YzvWr+i+9780wggbqcxuZ4vguzyU9t4Ec7GaNsjzRbx49CwgzKo
	dJX1/Jz4j4wi4XRIZgbKZWTLmbj7fR38tns4Oe5N9adH67QP4lWl6lBMU2P2FVCzk2O8QQMrqnC
	oH/188Q==
X-Google-Smtp-Source: AGHT+IE/EP0ILWPtqbvtx21X0Ppa8Lh/HbAIxDIfE2gxlTGjbtl34ZSuGtNPFUqR3wh+Du71T6QoFDnEJZc=
X-Received: from pjbpl7.prod.google.com ([2002:a17:90b:2687:b0:321:6924:af9a])
 (user=chibar job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c08:b0:327:b42b:f711
 with SMTP id 98e67ed59e1d1-327b42bf8ffmr913444a91.9.1756362697466; Wed, 27
 Aug 2025 23:31:37 -0700 (PDT)
Date: Thu, 28 Aug 2025 06:26:36 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828062636.445748-1-chibar@google.com>
Subject: [PATCH] selftests/seccomp: Change the syscall used in KILL_THREAD
 test to getppid
From: Ryuichiro Chiba <chibar@google.com>
To: Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ryuichiro Chiba <chibar@google.com>
Content-Type: text/plain; charset="UTF-8"

pthread_create provided by the bionic libc uses getpid internally.
Therefore using getpid as the filter target may cause the test to fail.
This hasn't been a problem because bionic caches the pid and doesn't
call the actual syscall. However we are planning to stop the pid
caching and it will cause the test failure.

This patch changes to use getppid instead in the test.

Signed-off-by: Ryuichiro Chiba <chibar@google.com>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index fc4910d35342..5505d134d1a6 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -798,7 +798,7 @@ void *kill_thread(void *data)
 	bool die = (bool)data;
 
 	if (die) {
-		syscall(__NR_getpid);
+		syscall(__NR_getppid);
 		return (void *)SIBLING_EXIT_FAILURE;
 	}
 
@@ -817,11 +817,11 @@ void kill_thread_or_group(struct __test_metadata *_metadata,
 {
 	pthread_t thread;
 	void *status;
-	/* Kill only when calling __NR_getpid. */
+	/* Kill only when calling __NR_getppid. */
 	struct sock_filter filter_thread[] = {
 		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
 			offsetof(struct seccomp_data, nr)),
-		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_getpid, 0, 1),
+		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_getppid, 0, 1),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_KILL_THREAD),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
 	};
@@ -833,7 +833,7 @@ void kill_thread_or_group(struct __test_metadata *_metadata,
 	struct sock_filter filter_process[] = {
 		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
 			offsetof(struct seccomp_data, nr)),
-		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_getpid, 0, 1),
+		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_getppid, 0, 1),
 		BPF_STMT(BPF_RET|BPF_K, kill),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
 	};
-- 
2.51.0.268.g9569e192d0-goog


