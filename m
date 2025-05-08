Return-Path: <linux-kselftest+bounces-32675-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 645DAAB0298
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 20:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CED4F4A789B
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 18:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5FE288C17;
	Thu,  8 May 2025 18:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UYVgPpRE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B95288532
	for <linux-kselftest@vger.kernel.org>; Thu,  8 May 2025 18:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746728460; cv=none; b=ip8OlmYT6b/XPoNEnPwODBGUpJ4dV5e2HwmhZjuqo/t/jw2CJ5EN2F6wMVP84n3q4TOkknMTE/190AswCO7fxres97SZAECRlfVQBmpH8kSoRsru1BBqdy99RibXnyuPt/o+Rty3LR6QJliowjO3o5cxkGRz3wa8YAf1M94uXzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746728460; c=relaxed/simple;
	bh=sbI4h/f9x/llo5E+x2+7s/k7ALuWrVVduehlNoKaXq4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S1dW7WTVqarV+7PKfHHPdb/XmuAGl0HG57u3gAgMd4ks/vskLIURnonegpGinfQgbZdaVdIFlHkNnlOPfAQ0FoCmcuyUhr8CIV3RFGvbjk+pDKOVvPP4K2+d8usyvQAag6zI+1lqn/6Gx7W5X4bVsql6GJfXZdUtWtkljD2hP24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UYVgPpRE; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b0e0c573531so852262a12.3
        for <linux-kselftest@vger.kernel.org>; Thu, 08 May 2025 11:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746728459; x=1747333259; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xwIypK5vgpXyk6FLaHSI0wGc7MjNUvnJWQjPoxqkKIA=;
        b=UYVgPpRE7B3tCbphnZU+MflG/kAO9k4H377uE6v0jwMe6MkGSQArPe5P9W4MrLL/AX
         c/TiGiuqMse2AV4GT8hwdbcmURv+fy34AmAgQHU+jTz4F2V4Yrk/14MUKozK0s0MnjHl
         aZnVNT/y4LI/SxOOmsUkAazdN5pzkS2hAaQtX5wKZZ6JpejCRuKRJ6rdyfKlMcrrnaLZ
         TEYPbaZceJ1z8PrAijt5oZYxcIF1gqPx45OgLWkL9Mk6Yfe1aoDuoceTCrooj5loc8dh
         Wsas2VScSWaoGGQJmWMITCkldjE22hJrjBkbrJD4Dds8jQC1ERtmpOWilh4Ob951Xdho
         SLkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746728459; x=1747333259;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xwIypK5vgpXyk6FLaHSI0wGc7MjNUvnJWQjPoxqkKIA=;
        b=UjSBf+642rWVuh95IqnhuiBsRsrHj+gcWLCf71S9B7bkATNVcrx/JzT67vI4SYqU5G
         Lw8uZm63CROEW0hSogc5ln0KvVXk3UoRYOvGFuAgIOW/tdCWHUhxMSco2W7w8WMXQ/t8
         PERLMqYFQB8gaK+A5bOJGVKHwajHGwbHQaOZb2rP/PB16/DiKW6MdG8bfk2OKc3n1pww
         RgvTcvEipKRKfJ9bVM+9FHzGowEpbXLzD/KGASbBYKFj0HclMeLdruoOijeiyjQfzdPW
         itdbR0xgVN3/2qInzvpvHNiKw9WckZXHUAI7G/jPuOnKGMSl3FWi4bhtx3P0WBVy2rQu
         fv4g==
X-Forwarded-Encrypted: i=1; AJvYcCUIPtCPHBkubuKuHKBte2gDHS/WM9AU8XTYCR84LVr3byCY8AOi1qtaRoJrMvEKUW4UtrA2bgwrV6/L4Ntu4aw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhCHnPdfJtj0TfyW1vEIjfT1gl3bVNPm65mw2ej0QDDZztcjw2
	LcNYlGNJgn23n0qeOp1sR3Tn1FMjaZ65bVXotthoujtKr4InkRayI4IfeQXWdiexDJ3lBHtHvjq
	XJLqX//YMsT1s8A==
X-Google-Smtp-Source: AGHT+IGvJN4Vf2zfwtQtEd6XAvfzgu0CadIvXXytUhhkeOpqjgTD22SYjtYy4WpZC8iuj5HW0VjxdaEkwL11DBo=
X-Received: from pjf8.prod.google.com ([2002:a17:90b:3f08:b0:30a:8830:9f6b])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2d06:b0:2ee:edae:780 with SMTP id 98e67ed59e1d1-30c3d2e2e67mr883580a91.15.1746728458769;
 Thu, 08 May 2025 11:20:58 -0700 (PDT)
Date: Thu,  8 May 2025 18:20:24 +0000
In-Reply-To: <20250508182025.2961555-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250508182025.2961555-1-tjmercier@google.com>
X-Mailer: git-send-email 2.49.0.1015.ga840276032-goog
Message-ID: <20250508182025.2961555-6-tjmercier@google.com>
Subject: [PATCH bpf-next v4 5/5] selftests/bpf: Add test for open coded dmabuf_iter
From: "T.J. Mercier" <tjmercier@google.com>
To: sumit.semwal@linaro.org, christian.koenig@amd.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	skhan@linuxfoundation.org, alexei.starovoitov@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, android-mm@google.com, 
	simona@ffwll.ch, eddyz87@gmail.com, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org, song@kernel.org, 
	"T.J. Mercier" <tjmercier@google.com>
Content-Type: text/plain; charset="UTF-8"

Use the same test buffers as the traditional iterator and a new BPF map
to verify the test buffers can be found with the open coded dmabuf
iterator.

Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 .../testing/selftests/bpf/bpf_experimental.h  |  5 ++
 .../selftests/bpf/prog_tests/dmabuf_iter.c    | 52 +++++++++++++++----
 .../testing/selftests/bpf/progs/dmabuf_iter.c | 38 ++++++++++++++
 3 files changed, 86 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 6535c8ae3c46..5e512a1d09d1 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -591,4 +591,9 @@ extern int bpf_iter_kmem_cache_new(struct bpf_iter_kmem_cache *it) __weak __ksym
 extern struct kmem_cache *bpf_iter_kmem_cache_next(struct bpf_iter_kmem_cache *it) __weak __ksym;
 extern void bpf_iter_kmem_cache_destroy(struct bpf_iter_kmem_cache *it) __weak __ksym;
 
+struct bpf_iter_dmabuf;
+extern int bpf_iter_dmabuf_new(struct bpf_iter_dmabuf *it) __weak __ksym;
+extern struct dma_buf *bpf_iter_dmabuf_next(struct bpf_iter_dmabuf *it) __weak __ksym;
+extern void bpf_iter_dmabuf_destroy(struct bpf_iter_dmabuf *it) __weak __ksym;
+
 #endif
diff --git a/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c b/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c
index 35745f4ce0f8..c8230a080ef3 100644
--- a/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c
@@ -26,10 +26,11 @@ static int sysheap_dmabuf;
 static const char sysheap_test_buffer_name[DMA_BUF_NAME_LEN] = "sysheap_test_buffer_for_iter";
 static size_t sysheap_test_buffer_size;
 
-static int create_udmabuf(void)
+static int create_udmabuf(int map_fd)
 {
 	struct udmabuf_create create;
 	int dev_udmabuf;
+	bool f = false;
 
 	udmabuf_test_buffer_size = 10 * getpagesize();
 
@@ -63,10 +64,10 @@ static int create_udmabuf(void)
 	if (!ASSERT_OK(ioctl(udmabuf, DMA_BUF_SET_NAME_B, udmabuf_test_buffer_name), "name"))
 		return 1;
 
-	return 0;
+	return bpf_map_update_elem(map_fd, udmabuf_test_buffer_name, &f, BPF_ANY);
 }
 
-static int create_sys_heap_dmabuf(void)
+static int create_sys_heap_dmabuf(int map_fd)
 {
 	sysheap_test_buffer_size = 20 * getpagesize();
 
@@ -77,6 +78,7 @@ static int create_sys_heap_dmabuf(void)
 		.heap_flags = 0,
 	};
 	int heap_fd, ret;
+	bool f = false;
 
 	if (!ASSERT_LE(sizeof(sysheap_test_buffer_name), DMA_BUF_NAME_LEN, "NAMETOOLONG"))
 		return 1;
@@ -95,18 +97,18 @@ static int create_sys_heap_dmabuf(void)
 	if (!ASSERT_OK(ioctl(sysheap_dmabuf, DMA_BUF_SET_NAME_B, sysheap_test_buffer_name), "name"))
 		return 1;
 
-	return 0;
+	return bpf_map_update_elem(map_fd, sysheap_test_buffer_name, &f, BPF_ANY);
 }
 
-static int create_test_buffers(void)
+static int create_test_buffers(int map_fd)
 {
 	int ret;
 
-	ret = create_udmabuf();
+	ret = create_udmabuf(map_fd);
 	if (ret)
 		return ret;
 
-	return create_sys_heap_dmabuf();
+	return create_sys_heap_dmabuf(map_fd);
 }
 
 static void destroy_test_buffers(void)
@@ -187,17 +189,46 @@ static void subtest_dmabuf_iter_check_default_iter(struct dmabuf_iter *skel)
 	close(iter_fd);
 }
 
+static void subtest_dmabuf_iter_check_open_coded(struct dmabuf_iter *skel, int map_fd)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	char key[DMA_BUF_NAME_LEN];
+	int err, fd;
+	bool found;
+
+	/* No need to attach it, just run it directly */
+	fd = bpf_program__fd(skel->progs.iter_dmabuf_for_each);
+
+	err = bpf_prog_test_run_opts(fd, &topts);
+	if (!ASSERT_OK(err, "test_run_opts err"))
+		return;
+	if (!ASSERT_OK(topts.retval, "test_run_opts retval"))
+		return;
+
+	if (!ASSERT_OK(bpf_map_get_next_key(map_fd, NULL, key), "get next key"))
+		return;
+
+	do {
+		ASSERT_OK(bpf_map_lookup_elem(map_fd, key, &found), "lookup");
+		ASSERT_TRUE(found, "found test buffer");
+	} while (bpf_map_get_next_key(map_fd, key, key));
+}
+
 void test_dmabuf_iter(void)
 {
 	struct dmabuf_iter *skel = NULL;
+	int iter_fd, map_fd;
 	char buf[256];
-	int iter_fd;
 
 	skel = dmabuf_iter__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "dmabuf_iter__open_and_load"))
 		return;
 
-	if (!ASSERT_OK(create_test_buffers(), "create_buffers"))
+	map_fd = bpf_map__fd(skel->maps.testbuf_hash);
+	if (!ASSERT_OK_FD(map_fd, "map_fd"))
+		goto destroy_skel;
+
+	if (!ASSERT_OK(create_test_buffers(map_fd), "create_buffers"))
 		goto destroy;
 
 	if (!ASSERT_OK(dmabuf_iter__attach(skel), "skel_attach"))
@@ -215,10 +246,13 @@ void test_dmabuf_iter(void)
 
 	if (test__start_subtest("default_iter"))
 		subtest_dmabuf_iter_check_default_iter(skel);
+	if (test__start_subtest("open_coded"))
+		subtest_dmabuf_iter_check_open_coded(skel, map_fd);
 
 	close(iter_fd);
 
 destroy:
 	destroy_test_buffers();
+destroy_skel:
 	dmabuf_iter__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/dmabuf_iter.c b/tools/testing/selftests/bpf/progs/dmabuf_iter.c
index d654b4f64cfa..cfdcf4b1c636 100644
--- a/tools/testing/selftests/bpf/progs/dmabuf_iter.c
+++ b/tools/testing/selftests/bpf/progs/dmabuf_iter.c
@@ -9,6 +9,13 @@
 
 char _license[] SEC("license") = "GPL";
 
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, DMA_BUF_NAME_LEN);
+	__type(value, bool);
+	__uint(max_entries, 5);
+} testbuf_hash SEC(".maps");
+
 /*
  * Fields output by this iterator are delimited by newlines. Convert any
  * newlines in user-provided printed strings to spaces.
@@ -51,3 +58,34 @@ int dmabuf_collector(struct bpf_iter__dmabuf *ctx)
 	BPF_SEQ_PRINTF(seq, "%lu\n%llu\n%s\n%s\n", inode, size, name, exporter);
 	return 0;
 }
+
+SEC("syscall")
+int iter_dmabuf_for_each(const void *ctx)
+{
+	struct dma_buf *d;
+
+	bpf_for_each(dmabuf, d) {
+		char name[DMA_BUF_NAME_LEN];
+		const char *pname;
+		bool *found;
+
+		if (bpf_core_read(&pname, sizeof(pname), &d->name))
+			return 1;
+
+		/* Buffers are not required to be named */
+		if (!pname)
+			continue;
+
+		if (bpf_probe_read_kernel(name, sizeof(name), pname))
+			return 1;
+
+		found = bpf_map_lookup_elem(&testbuf_hash, name);
+		if (found) {
+			bool t = true;
+
+			bpf_map_update_elem(&testbuf_hash, name, &t, BPF_EXIST);
+		}
+	}
+
+	return 0;
+}
-- 
2.49.0.1015.ga840276032-goog


