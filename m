Return-Path: <linux-kselftest+bounces-33538-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1B4AC173C
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 01:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62B9A1C03F4F
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 23:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74E42C3769;
	Thu, 22 May 2025 23:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fscv/Z91"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135592C2AD8
	for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 23:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747955089; cv=none; b=YpvP8AmU6ejJY8uWAPdZMVXkpIE+7ZmMOho6lPQ0pJCfCGhQDmFGNR2SIjpvI7ur9R8hDoIWEQihY9wdD+B0uLNgz+SBpn/WS38I0Nb7mJbA/kX8uqnKGQ7mZCDBlrKtpT7cCbPndOjKqO9s731xVc6av3BvNYg1UFd/gcnSUhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747955089; c=relaxed/simple;
	bh=ZW9zZoYFdKKg4K1KTjX20jNs4thOcVjX20NnTMkrP6Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q2Z39nHEulM96TLL9EqIkTAmuJdHNHoU+X0xiWIIKGDNlbJCyYRXEQrAr7FIJaCTRiXTUdUGFYS6hz0wsaP0kZIjPRy3UYsvVwAlqCl09EU/dINE3ih2pxyC1ehxeZeE700Cj4zW/pT7xlO2G+O51Hlq9g1QPVjFHJfTCRKvSUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fscv/Z91; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3108d5156e8so3320326a91.1
        for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 16:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747955087; x=1748559887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sjvt2FSndoyzHpiTi00fqP3aNPbtMl1ng2ZPdHNNLQk=;
        b=fscv/Z91lV5zKmpZtBlvn1VbwXF7pJEcTQtQCIEdEFV2Dxz+3AKoIcuuqynVxZ+YYY
         TmH0ipd+/QIxrcaGEmXeeoKBkD7KO5/o+5+1BjhNhsKtR4p1uCTVAcLP0Uozj+hhIM+r
         iUjPTJ9/sefR5Nehwq740udfhLlEmMG5mnwF3hjgN/MJ/yK0naHf6fK1a53EyIa/dD1y
         VhVxs/WIuhpunGhvv7KAkC7sNeImSdATo1JBOgafsk0dvKaYhFuvQq6+SVUEr29POGV6
         Z/HmHIzUW5TbfgrILHQt4rvtLstv6Tx/TO+LrxGeYeE2MCjRewfN3g3YH00bVt/XrMpn
         Ya9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747955087; x=1748559887;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Sjvt2FSndoyzHpiTi00fqP3aNPbtMl1ng2ZPdHNNLQk=;
        b=MYS+LhNQdv2g8mWzzMGl46Efrnao3PbCF+yKEkx+OxUq5XsUSIdPaa7yuZ703zam8x
         vpIS3v/U6FtWdaGbWjoOIrT1RtBMo6FA/pOntbbfPWhaTnMixrrnyJoy4HUqWdi/QIxI
         SdOl05SWyEO1zvlNM3IfWHzMv3WvjbFj7s28L5Hwhgy2Hzdn8gefYpVNLhlaH6XNAXUN
         z/vbUAkzm9vWfEDSQkxfGlQ9UWynDnNvU+1sK9Pcody79SQeBRlxGG7RdSjjRYW54pnY
         LHS9DfqcUsfSosMqbf01DBhETK0T8AHTvJUkqyPB95sF2tXvWBbRkGZGBLmFJNMD4/Ls
         YoAA==
X-Forwarded-Encrypted: i=1; AJvYcCU2xpXpGy4HnNeZ/WAx3M3Jr7x9yS71/pjWHRKYYFJ9H/yBGpG72QKLBndWzcvk4wsrfFM6pjyD/U0H65JFhtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCvw5nXz/gEUbeShlc8fZ4X91e/yK1qD4iiiYkDOao+rpb5xK8
	IsAmHGH2K2nc1Ue1lQnS6x2Y5iTls/Om+2H4JiNSmo563yznbUTTSQh1xf2U8djsTpBhespudBp
	uaI+BzoZSCTwUcpvn7A==
X-Google-Smtp-Source: AGHT+IGmBEEC3D+iQhUBmXN1VONTwNdgdzLmg2mtljqXxgk37nf0oQytjH+Iy15NdK+asUPGlaAXITDgBdNduEE=
X-Received: from pjur12.prod.google.com ([2002:a17:90a:d40c:b0:2ff:4be0:c675])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1e01:b0:30c:540b:99e with SMTP id 98e67ed59e1d1-310e96cbff2mr1317193a91.13.1747955087546;
 Thu, 22 May 2025 16:04:47 -0700 (PDT)
Date: Thu, 22 May 2025 23:04:29 +0000
In-Reply-To: <20250522230429.941193-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250522230429.941193-1-tjmercier@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250522230429.941193-6-tjmercier@google.com>
Subject: [PATCH bpf-next v7 5/5] selftests/bpf: Add test for open coded dmabuf_iter
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
Acked-by: Song Liu <song@kernel.org>
---
 .../testing/selftests/bpf/bpf_experimental.h  |  5 ++
 .../selftests/bpf/prog_tests/dmabuf_iter.c    | 41 ++++++++++++++++
 .../testing/selftests/bpf/progs/dmabuf_iter.c | 48 +++++++++++++++++++
 3 files changed, 94 insertions(+)

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
index dc740bd0e2bd..6c2b0c3dbcd8 100644
--- a/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c
@@ -219,14 +219,52 @@ static void subtest_dmabuf_iter_check_default_iter(st=
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
+	const bool f =3D false;
=20
 	skel =3D dmabuf_iter__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "dmabuf_iter__open_and_load"))
 		return;
=20
+	map_fd =3D bpf_map__fd(skel->maps.testbuf_hash);
+	if (!ASSERT_OK_FD(map_fd, "map_fd"))
+		goto destroy_skel;
+
+	if (!ASSERT_OK(bpf_map_update_elem(map_fd, udmabuf_test_buffer_name, &f, =
BPF_ANY),
+		       "insert udmabuf"))
+		goto destroy_skel;
+	if (!ASSERT_OK(bpf_map_update_elem(map_fd, sysheap_test_buffer_name, &f, =
BPF_ANY),
+		       "insert sysheap buffer"))
+		goto destroy_skel;
+
 	if (!ASSERT_OK(create_test_buffers(), "create_test_buffers"))
 		goto destroy;
=20
@@ -237,8 +275,11 @@ void test_dmabuf_iter(void)
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
index e53d7646d07a..13cdb11fdeb2 100644
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
@@ -51,3 +58,44 @@ int dmabuf_collector(struct bpf_iter__dmabuf *ctx)
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
+		long len;
+		int i;
+
+		if (bpf_core_read(&pname, sizeof(pname), &d->name))
+			return 1;
+
+		/* Buffers are not required to be named */
+		if (!pname)
+			continue;
+
+		len =3D bpf_probe_read_kernel_str(name, sizeof(name), pname);
+		if (len < 0)
+			return 1;
+
+		/*
+		 * The entire name buffer is used as a map key.
+		 * Zeroize any uninitialized trailing bytes after the NUL.
+		 */
+		bpf_for(i, len, DMA_BUF_NAME_LEN)
+			name[i] =3D 0;
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
2.49.0.1151.ga128411c76-goog


