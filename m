Return-Path: <linux-kselftest+bounces-32871-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BDCAB3F74
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 19:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C19307AF739
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 17:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9D3297B6D;
	Mon, 12 May 2025 17:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fvaPt+ux"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D233F297B61
	for <linux-kselftest@vger.kernel.org>; Mon, 12 May 2025 17:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747071666; cv=none; b=UTuIMxDL8JrnkU/+pUbhTekTahugbKhcC9zrfxErsNP18g/uTxdPqQzgJ4jytWPa8VmiD4YgOyseIT0uPREtR8qVQxlrFSxCPtT8dauM2vZZVp19Y9f7+yZvXNVKxdm/jrMGEl+pdqyslkPvze6UjPinIprYy3nmMq/V2b0Stjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747071666; c=relaxed/simple;
	bh=Sr4ehi8UyKgOInexUUDXX33RjZQR1+mTrCzUsTP3Xjg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h2ceE+/7m97/+RhRBbkLgC/m90d8HzJnLLf++YBG/aqzFWRNgrejG1YRaN8+LTp96sfz/21ZuCcpjOW9LriZfNTf0QDdLw20Q21CxyberpsEx4DmZNdUJ3n457Fe4itMvr3SIjf2ojde/dN0KtvHtw/TMFXFxHRZGWOqiw6gpsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fvaPt+ux; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-74235ee893fso5332655b3a.1
        for <linux-kselftest@vger.kernel.org>; Mon, 12 May 2025 10:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747071664; x=1747676464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sCGxx2XfGsewNgZCW3IbIozmrin1Wu5z7ijIKVfw2+I=;
        b=fvaPt+uxM3zgUeQ5F35YzPtSQtcWC68E/CI8Xig2rtYBIJTZPaHx9RuZeqfLttqdZo
         D/7Rx/0txwTcMtv+hmeO8xAadmpL61qiKZeYlC2VsHmqBmIjpi9MTJ0P02apn2ig8Z82
         vMd8ZNInKBaMM4D/QYH1GAYZzCqFBMt7KAaN8QQGUK8mkj28f3B65ji9fmmnXXaKQiKY
         9/RwM427jZkJOaVq6DP4WGTUJYLquCLRD6RDy00JP5hBiIZdF0CTLsOy7JqQEy3x9VcI
         vT4jJaXXz/lfs/TvnQy4y40vGX5viQ9HfP1nNyGCG1ha3wbccfJ1ln9QVqYU295fYwk5
         WsfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747071664; x=1747676464;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sCGxx2XfGsewNgZCW3IbIozmrin1Wu5z7ijIKVfw2+I=;
        b=kUGMlTypBGKVXoSYBORXtOjokHUlspwcY23/dChUoLCXdga5+w5xEnfY/3M7IQuZXb
         zH5iZ4loo5GUgZVsodHGM3T9nqSmeLUWxL0gVlH4KX92l3HuanveD/N9RFAwwXh8j5fd
         pfJmTeSa2CGQ6yyXfrEzSBDPs0Fgf3eF4ZoDzEil6hg17cuDBoJIbOg+qAtmWjVec9Pd
         afqkFG9LUWJFPwm80K47FywGvvtI2r1JdkyAsBX90Ogv9Q9R9UDk9xaTqfpeegFJNh9j
         wvtAtvAHV1o39yusxHr98XyvsEXmaKWiJfCpLSY+uFhmpvoSkoc6OB+ZQhQ750TepO2p
         Ss6A==
X-Forwarded-Encrypted: i=1; AJvYcCWHsAt8rw8Xu/W5rCSTRFzl535+DOqm4tHMOYC7Rwh0KSNUDmfStz/GjuCyXEn4SGOHlXSzwyFzBL3MrqISueo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsx27DMs5cEg8n1iAuHZLOboidsTG/3FhLbU8ApmPZW/V+Uzlw
	zVHZryGHZT4xxZwF3Jy9lB8A4LCtNwe4JCEo8CeHYnXte0rl256Q9gZQ/Jm42XMCNUOPo+FAd8+
	disI0R5vLcpZEjA==
X-Google-Smtp-Source: AGHT+IFLBGzKFZmsktbIeW8pxhnG9+8Euh8hihVcHszDWEwnIoCPLdtI1rxSOPsP9ipwfFfbMW9NefHkQ4HZoLE=
X-Received: from pfoo10.prod.google.com ([2002:a05:6a00:1a0a:b0:732:20df:303c])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2313:b0:736:692e:129 with SMTP id d2e1a72fcca58-7423c0421e7mr21330789b3a.24.1747071664262;
 Mon, 12 May 2025 10:41:04 -0700 (PDT)
Date: Mon, 12 May 2025 17:40:36 +0000
In-Reply-To: <20250512174036.266796-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250512174036.266796-1-tjmercier@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250512174036.266796-6-tjmercier@google.com>
Subject: [PATCH bpf-next v5 5/5] selftests/bpf: Add test for open coded dmabuf_iter
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
Content-Transfer-Encoding: quoted-printable

Use the same test buffers as the traditional iterator and a new BPF map
to verify the test buffers can be found with the open coded dmabuf
iterator.

Signed-off-by: T.J. Mercier <tjmercier@google.com>
Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
---
 .../testing/selftests/bpf/bpf_experimental.h  |  5 +++
 .../selftests/bpf/prog_tests/dmabuf_iter.c    | 42 +++++++++++++++++--
 .../testing/selftests/bpf/progs/dmabuf_iter.c | 38 +++++++++++++++++
 3 files changed, 82 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing=
/selftests/bpf/bpf_experimental.h
index 6535c8ae3c46..5e512a1d09d1 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -591,4 +591,9 @@ extern int bpf_iter_kmem_cache_new(struct bpf_iter_kmem=
_cache *it) __weak __ksym
 extern struct kmem_cache *bpf_iter_kmem_cache_next(struct bpf_iter_kmem_ca=
che *it) __weak __ksym;
 extern void bpf_iter_kmem_cache_destroy(struct bpf_iter_kmem_cache *it) __=
weak __ksym;
=20
+struct bpf_iter_dmabuf;
+extern int bpf_iter_dmabuf_new(struct bpf_iter_dmabuf *it) __weak __ksym;
+extern struct dma_buf *bpf_iter_dmabuf_next(struct bpf_iter_dmabuf *it) __=
weak __ksym;
+extern void bpf_iter_dmabuf_destroy(struct bpf_iter_dmabuf *it) __weak __k=
sym;
+
 #endif
diff --git a/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c b/tools/t=
esting/selftests/bpf/prog_tests/dmabuf_iter.c
index 8ae18e4d7238..d9606f3361b9 100644
--- a/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c
@@ -106,15 +106,18 @@ static int create_sys_heap_dmabuf(void)
 	return -1;
 }
=20
-static int create_test_buffers(void)
+static int create_test_buffers(int map_fd)
 {
+	bool f =3D false;
+
 	udmabuf =3D create_udmabuf();
 	sysheap_dmabuf =3D create_sys_heap_dmabuf();
=20
 	if (udmabuf < 0 || sysheap_dmabuf < 0)
 		return -1;
=20
-	return 0;
+	return bpf_map_update_elem(map_fd, udmabuf_test_buffer_name, &f, BPF_ANY)=
 ||
+	       bpf_map_update_elem(map_fd, sysheap_test_buffer_name, &f, BPF_ANY)=
;
 }
=20
 static void destroy_test_buffers(void)
@@ -215,15 +218,45 @@ static void subtest_dmabuf_iter_check_default_iter(st=
ruct dmabuf_iter *skel)
 	close(iter_fd);
 }
=20
+static void subtest_dmabuf_iter_check_open_coded(struct dmabuf_iter *skel,=
 int map_fd)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	char key[DMA_BUF_NAME_LEN];
+	int err, fd;
+	bool found;
+
+	/* No need to attach it, just run it directly */
+	fd =3D bpf_program__fd(skel->progs.iter_dmabuf_for_each);
+
+	err =3D bpf_prog_test_run_opts(fd, &topts);
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
 	struct dmabuf_iter *skel =3D NULL;
+	int map_fd;
=20
 	skel =3D dmabuf_iter__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "dmabuf_iter__open_and_load"))
 		return;
=20
-	if (!ASSERT_OK(create_test_buffers(), "create_test_buffers"))
+	map_fd =3D bpf_map__fd(skel->maps.testbuf_hash);
+	if (!ASSERT_OK_FD(map_fd, "map_fd"))
+		goto destroy_skel;
+
+	if (!ASSERT_OK(create_test_buffers(map_fd), "create_test_buffers"))
 		goto destroy;
=20
 	if (!ASSERT_OK(dmabuf_iter__attach(skel), "skel_attach"))
@@ -233,8 +266,11 @@ void test_dmabuf_iter(void)
 		subtest_dmabuf_iter_check_no_infinite_reads(skel);
 	if (test__start_subtest("default_iter"))
 		subtest_dmabuf_iter_check_default_iter(skel);
+	if (test__start_subtest("open_coded"))
+		subtest_dmabuf_iter_check_open_coded(skel, map_fd);
=20
 destroy:
 	destroy_test_buffers();
+destroy_skel:
 	dmabuf_iter__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/dmabuf_iter.c b/tools/testin=
g/selftests/bpf/progs/dmabuf_iter.c
index 900a730a05f6..5f2cc4f3de96 100644
--- a/tools/testing/selftests/bpf/progs/dmabuf_iter.c
+++ b/tools/testing/selftests/bpf/progs/dmabuf_iter.c
@@ -9,6 +9,13 @@
=20
 char _license[] SEC("license") =3D "GPL";
=20
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
+		found =3D bpf_map_lookup_elem(&testbuf_hash, name);
+		if (found) {
+			bool t =3D true;
+
+			bpf_map_update_elem(&testbuf_hash, name, &t, BPF_EXIST);
+		}
+	}
+
+	return 0;
+}
--=20
2.49.0.1045.g170613ef41-goog


