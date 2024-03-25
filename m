Return-Path: <linux-kselftest+bounces-6591-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF88488B5A1
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 00:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 088A8BA0798
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 19:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B824776E;
	Mon, 25 Mar 2024 19:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eQnbFjAP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF81D45033
	for <linux-kselftest@vger.kernel.org>; Mon, 25 Mar 2024 19:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711395666; cv=none; b=dRN9qXqU5QlqHv58FgmxLW4l6dm4G9A7J5FKveX6JTYbVg3MMdya6Ne2Q1LPR9K3MZRyNKLhRB0T/jPnicFltDfgHaKOXilO46Y11oup3nGzktA1vNVyqZjiovGcpSZmX6AVKBmokMjA0biCpIX/NR7utyxWZOcbuJfmv4LMDFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711395666; c=relaxed/simple;
	bh=PgpYmWwF+ZKkxz+jpDH8JrvQco+XVEcrWMSMSoX2y8M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BA0tByiEuld4+LwILkkWQYYH1owE3hBO/VQ5SbQ/nhDQoCyXJxyfVAS16q4SdTvm/h24cn4bRKyEnHJhfW+8DLB5bVMt29hiWdS0gkW19meN8LN5lKIuzsn2kX8JSzBK7SiL4BvCSz41Duiv/ufhjeAacUSxx/p4q6xtyUJMHRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eQnbFjAP; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1e0b5e79a57so7750145ad.2
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Mar 2024 12:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711395664; x=1712000464; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cX0Tst/fD3eEaDcxw6zP7p1X7prwnotLNua44hovj0E=;
        b=eQnbFjAPZuE2cDH3+Mh10RyDVE+oRZe9JmkleOhzl4AKdO873iqBqCbow9sIIDfnmF
         SqVr9aCDU6TkiIxOoYstytmbcbqHa+/o3mVvRgB9j/yuf20oUsUGsmj+SSg2cIZG92vk
         i4GFc4w1qcLQcpd6W/hSi6rk/IfHUY9ZcLSg5dmihWqwxDL1Wzl0pLKiS6qzG6nZR/wa
         kNQG3mvQ39KFHwc7XNlu4NYYoh1GVBoO7jk7fO/rBksBemtJiAESs7rfN5PsYjdQ2U2n
         HFbX0T6u1uc1yb/j12WRTfUP/VYr3la7D/LAICXdYCGbQrwrdhqrEuH83/it0Bhvq+tL
         +Gxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711395664; x=1712000464;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cX0Tst/fD3eEaDcxw6zP7p1X7prwnotLNua44hovj0E=;
        b=Z/Y6vhCV/RRHnhkAyhW2DtB3+crwMnKUT9WIioZW4NO3l2UhC1zuQaKQwBnjmXmtA9
         hS9AHu3148H02OgTjbfu62f5I85oSoLCAIma3nOE2IOlSTGU7Qvl6N2p90q4lvYssUGC
         UK1BMbt6urzXMqBCfqlUXdX+7oBMEZTQU05+ynlAW0FB0ICRSoPLAfB6RrXI/PcuTo7o
         QpNu/m5yPBPZX9654zV67nd6lMKssCcAHD51Kmyjd8+1HwmclmBbzBH4fqm+nYBYtxsC
         5xiNBo1dZrqLkMDseIHCY1TngL4cpoyXaCTK5TZ/XfdRZKwUDgs66yVms1AYJjDKceYc
         uhKA==
X-Gm-Message-State: AOJu0Yw2S+EscStkVIz0isrKHQRoY3f8GWPYCS7PLHRJAA2ZX3MFRhm4
	6eu8ndsJk3FW2NjHN36IfuzhqHdyUFT3UZfmFIaNjfZMHsna1LTIsbpf9QfBZ8adgLhgEZ/Qdys
	w3g==
X-Google-Smtp-Source: AGHT+IHu0ZTXU78B+0X+LXpELIc87+D4aJxq4bKR0NhoBZQXd5O+HZEP47xhnKe66UWD9zpspAK+wE700/M=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:d2cf:b0:1de:f18c:ce4 with SMTP id
 n15-20020a170902d2cf00b001def18c0ce4mr662860plc.0.1711395663954; Mon, 25 Mar
 2024 12:41:03 -0700 (PDT)
Date: Mon, 25 Mar 2024 19:40:52 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240325194100.775052-1-edliaw@google.com>
Subject: [PATCH v3] selftests/mm: Fix ARM related issue with fork after pthread_create
From: Edward Liaw <edliaw@google.com>
To: linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Jann Horn <jannh@google.com>
Cc: linux-kselftest@vger.kernel.org, kernel-team@android.com, 
	Edward Liaw <edliaw@google.com>, Lokesh Gidra <lokeshgidra@google.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-mm@kvack.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Following issue was observed while running the uffd-unit-tests selftest
on ARM devices. On x86_64 no issues were detected:

pthread_create followed by fork caused deadlock in certain cases
wherein fork required some work to be completed by the created thread.
Used synchronization to ensure that created thread's start function has
started before invoking fork.

Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
[edliaw: Refactored to use atomic_bool]
Signed-off-by: Edward Liaw <edliaw@google.com>
---

v2: restored accidentally removed uffd_test_case_ops when merging
v3: fixed commit subject to use selftests/mm prefix

 tools/testing/selftests/mm/uffd-common.c     |  3 +++
 tools/testing/selftests/mm/uffd-common.h     |  2 ++
 tools/testing/selftests/mm/uffd-unit-tests.c | 10 ++++++++++
 3 files changed, 15 insertions(+)

diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index b0ac0ec2356d..7ad6ba660c7d 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -18,6 +18,7 @@ bool test_uffdio_wp = true;
 unsigned long long *count_verify;
 uffd_test_ops_t *uffd_test_ops;
 uffd_test_case_ops_t *uffd_test_case_ops;
+atomic_bool ready_for_fork;

 static int uffd_mem_fd_create(off_t mem_size, bool hugetlb)
 {
@@ -518,6 +519,8 @@ void *uffd_poll_thread(void *arg)
 	pollfd[1].fd = pipefd[cpu*2];
 	pollfd[1].events = POLLIN;

+	ready_for_fork = true;
+
 	for (;;) {
 		ret = poll(pollfd, 2, -1);
 		if (ret <= 0) {
diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
index cb055282c89c..cc5629c3d2aa 100644
--- a/tools/testing/selftests/mm/uffd-common.h
+++ b/tools/testing/selftests/mm/uffd-common.h
@@ -32,6 +32,7 @@
 #include <inttypes.h>
 #include <stdint.h>
 #include <sys/random.h>
+#include <stdatomic.h>

 #include "../kselftest.h"
 #include "vm_util.h"
@@ -103,6 +104,7 @@ extern bool map_shared;
 extern bool test_uffdio_wp;
 extern unsigned long long *count_verify;
 extern volatile bool test_uffdio_copy_eexist;
+extern atomic_bool ready_for_fork;

 extern uffd_test_ops_t anon_uffd_test_ops;
 extern uffd_test_ops_t shmem_uffd_test_ops;
diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index 2b9f8cc52639..4a48dc617c6b 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -775,6 +775,8 @@ static void uffd_sigbus_test_common(bool wp)
 	char c;
 	struct uffd_args args = { 0 };

+	ready_for_fork = false;
+
 	fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);

 	if (uffd_register(uffd, area_dst, nr_pages * page_size,
@@ -790,6 +792,9 @@ static void uffd_sigbus_test_common(bool wp)
 	if (pthread_create(&uffd_mon, NULL, uffd_poll_thread, &args))
 		err("uffd_poll_thread create");

+	while (!ready_for_fork)
+		; /* Wait for the poll_thread to start executing before forking */
+
 	pid = fork();
 	if (pid < 0)
 		err("fork");
@@ -829,6 +834,8 @@ static void uffd_events_test_common(bool wp)
 	char c;
 	struct uffd_args args = { 0 };

+	ready_for_fork = false;
+
 	fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
 	if (uffd_register(uffd, area_dst, nr_pages * page_size,
 			  true, wp, false))
@@ -838,6 +845,9 @@ static void uffd_events_test_common(bool wp)
 	if (pthread_create(&uffd_mon, NULL, uffd_poll_thread, &args))
 		err("uffd_poll_thread create");

+	while (!ready_for_fork)
+		; /* Wait for the poll_thread to start executing before forking */
+
 	pid = fork();
 	if (pid < 0)
 		err("fork");
--
2.44.0.396.g6e790dbe36-goog


