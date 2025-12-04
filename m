Return-Path: <linux-kselftest+bounces-46964-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 29507CA2038
	for <lists+linux-kselftest@lfdr.de>; Thu, 04 Dec 2025 01:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 76FDD3004997
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Dec 2025 00:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3664A32;
	Thu,  4 Dec 2025 00:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wHdH588s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95D13FFD
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Dec 2025 00:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764806729; cv=none; b=lOzl0hn/xStUELl/oGP4r+ramLyvVaBcgnm/KnR1cRib5mtoy7p6jZcWCYQJEZJ7ICD8bEGrHIeMRK4Q1YiKiPOFj77ioSKeKsCUWEz5jf443J37hRZjruy8XM9ROQ1795x6MboaQaRU/ZlHCFki5BA1Qq9wMXjroTImn/U65wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764806729; c=relaxed/simple;
	bh=/5/SUf84x79x0zxuYBMGAtCjge8lcuDz6hz4jtqQGQ4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CcnQdY2PkrSTdDyIU4GPmzZ0iaR4YNmtPrkgn2rCgfp7D+LxR8i64M5/7YlgAunwkC+Ac21oECnV6sGPMRstAoffRieFeJI3YiN+MeyUk/awmyed8BJw5NYjjKQi//kYOPoGX7cDlD9SIxVYRvHsq50L0lUfnxJKfklDzfbRlOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wHdH588s; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7b9321b9312so667977b3a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Dec 2025 16:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764806727; x=1765411527; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ntEJ7gGn1a+C6xdaOK38Dw1hgtUSvuAfJEVchxv0EQk=;
        b=wHdH588sUB3ALxFMf+UHldiRgFA4+P223jZj4mLPo6xC5UidV5nHUibVgkoW5LAlV6
         0vS6InmlF/ZchuY3aF2yQFGIVZKImWdljrDH642QCvPSbteI4/4v9+UEb9tbwuki3OtZ
         EOcpkVKlksOVUL2zjjSlRR+3oSY2bM1uxAjz4cvdm9uAl18+ycuU4PmVV83k/6S1JsjE
         UmDBOuor+F3E1czaLE7g6qKIro6XcQiYFqht3TedMQL48a71oPphPXghyCttWaXDdAsM
         zLCXSMtPRZOhMHc8ZFdV3IafjpnxLAL5K3JeVLvA6NpZ67wVGnk7vAo/H8VQjr+dkVMS
         eWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764806727; x=1765411527;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ntEJ7gGn1a+C6xdaOK38Dw1hgtUSvuAfJEVchxv0EQk=;
        b=Ffl9p6xgfzKbITWx8DZLNy1hQNSbBhgMFA4dCX7eiy8B8NgrjrBdtG0H6u1Cf9GCrk
         oiaHO2xtA3sZmTNtze+0XmK0GboKDcSaF6xfMg3YK8aYMyQevcl/N+imYXHb9fUvmoij
         jRF2VWWgOPM9ZR/97nNlS/J4zmSasFZFGt5IZhgC/8xtZzCavttiw/TYPfvTKJKgV9ui
         RQlc1tyLXZ7qXS9i9UgY23tAdmy2GioYbgegv9ai7PoOSkGfhhvyHvemYmUlBzEwW04o
         VbZlA78qx+moBKRe9w+mxp8Dtz1N3tqDYfqMztlaSYGoSQRFs/cJRmgCag0ZoJDwasEj
         UUug==
X-Forwarded-Encrypted: i=1; AJvYcCVWFzfiLoTmAThtJi4qYG19Zg9pLsfwpDLpRQ0xsEs1/ceOkD/bkqX56MUmN3B6koojTNNCp9XtInPN4QsKeoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YztnyWLMRYBwGvQFO+j5bDPDwrvmUhLfKXjcb+nwKVkvdbP0DzI
	FHWyI8KPxebXAvs3bvsxkP67Zg1d6r3d641ZJ+1uBRqDZzJo16D9jaE+6T58cuGw6Dbz9GEMv4c
	jHKllIKjJ5eGrlEF+2w==
X-Google-Smtp-Source: AGHT+IGanVIDs+7Y69ywHMHsNbcI0LEOaWi2CkaERYx1M22ypSftKd5oK/BkZTdgl+fJSBjubibGBoyAYRxfcc8=
X-Received: from pffa10.prod.google.com ([2002:a62:bd0a:0:b0:7dd:8bba:63ab])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4615:b0:7aa:4f1d:c458 with SMTP id d2e1a72fcca58-7e00d236c39mr4941316b3a.19.1764806726792;
 Wed, 03 Dec 2025 16:05:26 -0800 (PST)
Date: Wed,  3 Dec 2025 16:03:48 -0800
In-Reply-To: <20251204000348.1413593-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251204000348.1413593-1-tjmercier@google.com>
X-Mailer: git-send-email 2.52.0.177.g9f829587af-goog
Message-ID: <20251204000348.1413593-2-tjmercier@google.com>
Subject: [PATCH bpf 2/2] selftests/bpf: Add test for truncated dmabuf_iter reads
From: "T.J. Mercier" <tjmercier@google.com>
To: yonghong.song@linux.dev, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	android-mm@google.com
Cc: christian.koenig@amd.com, sumit.semwal@linaro.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, "T.J. Mercier" <tjmercier@google.com>
Content-Type: text/plain; charset="UTF-8"

If many dmabufs are present, reads of the dmabuf iterator can be
truncated at PAGE_SIZE or user buffer size boundaries before the fix in
"selftests/bpf: Add test for open coded dmabuf_iter". Add a test to
confirm truncation does not occur.

Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 .../selftests/bpf/prog_tests/dmabuf_iter.c    | 47 +++++++++++++++++--
 1 file changed, 42 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c b/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c
index 6c2b0c3dbcd8..e442be9dde7e 100644
--- a/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c
@@ -73,12 +73,10 @@ static int create_udmabuf(void)
 	return -1;
 }
 
-static int create_sys_heap_dmabuf(void)
+static int create_sys_heap_dmabuf(size_t bytes)
 {
-	sysheap_test_buffer_size = 20 * getpagesize();
-
 	struct dma_heap_allocation_data data = {
-		.len = sysheap_test_buffer_size,
+		.len = bytes,
 		.fd = 0,
 		.fd_flags = O_RDWR | O_CLOEXEC,
 		.heap_flags = 0,
@@ -110,7 +108,9 @@ static int create_sys_heap_dmabuf(void)
 static int create_test_buffers(void)
 {
 	udmabuf = create_udmabuf();
-	sysheap_dmabuf = create_sys_heap_dmabuf();
+
+	sysheap_test_buffer_size = 20 * getpagesize();
+	sysheap_dmabuf = create_sys_heap_dmabuf(sysheap_test_buffer_size);
 
 	if (udmabuf < 0 || sysheap_dmabuf < 0)
 		return -1;
@@ -219,6 +219,26 @@ static void subtest_dmabuf_iter_check_default_iter(struct dmabuf_iter *skel)
 	close(iter_fd);
 }
 
+static void subtest_dmabuf_iter_check_lots_of_buffers(struct dmabuf_iter *skel)
+{
+	int iter_fd;
+	char buf[1024];
+	size_t total_bytes_read = 0;
+	ssize_t bytes_read;
+
+	iter_fd = bpf_iter_create(bpf_link__fd(skel->links.dmabuf_collector));
+	if (!ASSERT_OK_FD(iter_fd, "iter_create"))
+		return;
+
+	while ((bytes_read = read(iter_fd, buf, sizeof(buf))) > 0)
+		total_bytes_read += bytes_read;
+
+	ASSERT_GT(total_bytes_read, getpagesize(), "total_bytes_read");
+
+	close(iter_fd);
+}
+
+
 static void subtest_dmabuf_iter_check_open_coded(struct dmabuf_iter *skel, int map_fd)
 {
 	LIBBPF_OPTS(bpf_test_run_opts, topts);
@@ -275,6 +295,23 @@ void test_dmabuf_iter(void)
 		subtest_dmabuf_iter_check_no_infinite_reads(skel);
 	if (test__start_subtest("default_iter"))
 		subtest_dmabuf_iter_check_default_iter(skel);
+	if (test__start_subtest("lots_of_buffers")) {
+		size_t NUM_BUFS = 100;
+		int buffers[NUM_BUFS];
+		int i;
+
+		for (i = 0; i < NUM_BUFS; ++i) {
+			buffers[i] = create_sys_heap_dmabuf(getpagesize());
+			if (!ASSERT_OK_FD(buffers[i], "dmabuf_fd"))
+				goto cleanup_bufs;
+		}
+
+		subtest_dmabuf_iter_check_lots_of_buffers(skel);
+
+cleanup_bufs:
+		for (--i; i >= 0; --i)
+			close(buffers[i]);
+	}
 	if (test__start_subtest("open_coded"))
 		subtest_dmabuf_iter_check_open_coded(skel, map_fd);
 
-- 
2.52.0.177.g9f829587af-goog


