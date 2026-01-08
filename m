Return-Path: <linux-kselftest+bounces-48569-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2C2D067E7
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 23:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B0D53065DE9
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 22:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664B12E6CDE;
	Thu,  8 Jan 2026 22:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cNh1gNXD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCFF3382CB
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 22:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767913022; cv=none; b=jxlNkPv6NEWVN38wJcQm2+H0lZRyaDdiRBmMTl+ZKvu0thMc1Bz7LVc/bUmHdRYX+bhh2vgXFtEOOXTqya1dRgJ2xHKct/ZLjIeOZGGr5SzpjoFfxmxpJs12U6nsZT+9UUoUT0R6e0Nu0KL1jeKgr2RDZh+yk7tR4V1YZF+/Nk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767913022; c=relaxed/simple;
	bh=J3XoNh2+ursfIFHZ04dZbCicr+2/5qQvrat3UOVe13E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J2lEV8U9PF1ibr55w0EUOZncmLeUUVqpzdkBFXT/2C4/laWj6X30i+qN4vJcIZu7KetS8t/58usll003Tsqg685piJyL7StZNlNgvpJahbhn66hf5ROxZepTvgorJAaOh3U+jwhdehq53Hsh/uf3SJ/XAAdzyZhGxxczmUikGd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cNh1gNXD; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ac39bd5501so2751689eec.0
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jan 2026 14:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767913020; x=1768517820; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dpKXlsbK0t3fSowv1Ag5XF8DahHUNU6JO1yHiv556M0=;
        b=cNh1gNXD6XVz/fZTmCbklLappsSX5mJGfM1fN/NnhQAF4uaYXxQ/N9IiqzDrhR/1t7
         CWEXLkzRfzN3EjM4jh73XANse1tSoq3lGEGZOJ0i5PVz8Nuz8qXVYqA4ljcpeoSJQ4Qz
         m9q1y7HW4WNGohHziRu14KwHOOSPJYBj0zv7VFnpdTu89mMnFM4xCp1aHSOhR01hffFv
         CvkqjJmuh6fFd8g9xdPQq624uTt2VVAFgMiD7i1g47/nXOHWnqLdgD3BOyd1lzsuD/vJ
         NrqrA2YwkMKs2AMsOXmClUoQJNDwNT+5V8uvvYLhEUBSKYsxv0Oy4srGavk0kgU5Qh2i
         GOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767913020; x=1768517820;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dpKXlsbK0t3fSowv1Ag5XF8DahHUNU6JO1yHiv556M0=;
        b=Sdinqjav8DaEDjaZbUaCtItd836SDCar/6ZQgwBOqQCJ/BN5VGjHymrJtIbdloH9lo
         sAbg1mlBGt1NacqLnT04JM6EXWi1jC/G/3MU3sXSy7pEnvXdiF+l6toL6/P/vNs0WtEJ
         YR8rQf0sUhgsVZkTpLxg4FiYX7ea4MAHZQpMIIJJ8Yf8begHAUbuTQPrXHOjTKKe7W4p
         y275zs6CniRPVcCI2npZMYYDJh0tVMhDmEzXLN8pHUVDZZsBZXDzNXt1TnWboegOOXsN
         eDPCAHCOIkKE8C+rAyvZUx4f+3PBf/lA/T7dBKvFwwTHIWauRKqOEIvj3a199VoxpGzI
         MV+A==
X-Forwarded-Encrypted: i=1; AJvYcCXV/X70ZMdE8vvexzE9B25VwdRw6Z1RsnKsP+YMkcjq2KZ5oIHQpgZbB3MsOFKALriF5lfeoFBcwUYzn5dngtk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJaVStbCEfUsu7n/j+BRWdwgMMqK4i9cAvS8Pm8aAORgQFPs5N
	wNV46QFo1VsQZXdPcVHXY+GtYjATbR6CidF2EySYU7OKb0xDU9sw2WVUSyiz7TxupEk1xGq8EiY
	nhXFkd4AGYdfnkA==
X-Google-Smtp-Source: AGHT+IG9bQDjpCq6ehJqqADDNDIcyIIU2S/qsuw+XaSMLcji1Lvxu5teMn1SSSthcF42Rd0wF4s4ZbXQTh9E7w==
X-Received: from dlbuu5.prod.google.com ([2002:a05:7022:7e85:b0:11d:cfec:1ad2])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:2495:b0:11b:9e5e:1a66 with SMTP id a92af1059eb24-121f8b16424mr6507148c88.14.1767913019880;
 Thu, 08 Jan 2026 14:56:59 -0800 (PST)
Date: Thu,  8 Jan 2026 14:55:21 -0800
In-Reply-To: <20260108225523.3268383-1-wusamuel@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260108225523.3268383-1-wusamuel@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260108225523.3268383-5-wusamuel@google.com>
Subject: [PATCH bpf-next v2 4/4] selftests/bpf: Open coded BPF wakeup_sources test
From: Samuel Wu <wusamuel@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Samuel Wu <wusamuel@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This commit introduces a new selftest for the BPF wakeup_source iterator
to verify the functionality of open-coded iteration.

The test adds:
- A new BPF map `test_ws_hash` to track iterated wakeup source names.
- A BPF program `iter_ws_for_each` that iterates over wakeup sources and
  updates the `test_ws_hash` map with the names of found sources.
- A new subtest `subtest_ws_iter_check_open_coded` to trigger the BPF
  program and assert that the expected wakeup sources are marked in the
  map.

Signed-off-by: Samuel Wu <wusamuel@google.com>
---
 .../testing/selftests/bpf/bpf_experimental.h  |  5 ++
 .../bpf/prog_tests/wakeup_source_iter.c       | 42 +++++++++++++++++
 .../selftests/bpf/progs/wakeup_source_iter.c  | 47 +++++++++++++++++++
 3 files changed, 94 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 2cd9165c7348..e532999b91ca 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -598,6 +598,11 @@ extern void bpf_iter_dmabuf_destroy(struct bpf_iter_dmabuf *it) __weak __ksym;
 
 extern int bpf_cgroup_read_xattr(struct cgroup *cgroup, const char *name__str,
 				 struct bpf_dynptr *value_p) __weak __ksym;
+struct bpf_iter_wakeup_source;
+extern int bpf_iter_wakeup_source_new(struct bpf_iter_wakeup_source *it) __weak __ksym;
+extern struct wakeup_source *bpf_iter_wakeup_source_next(
+		struct bpf_iter_wakeup_source *it) __weak __ksym;
+extern void bpf_iter_wakeup_source_destroy(struct bpf_iter_wakeup_source *it) __weak __ksym;
 
 #define PREEMPT_BITS	8
 #define SOFTIRQ_BITS	8
diff --git a/tools/testing/selftests/bpf/prog_tests/wakeup_source_iter.c b/tools/testing/selftests/bpf/prog_tests/wakeup_source_iter.c
index 31729f11585e..7b4d4cb25fd0 100644
--- a/tools/testing/selftests/bpf/prog_tests/wakeup_source_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/wakeup_source_iter.c
@@ -241,9 +241,37 @@ static void subtest_ws_iter_check_no_infinite_reads(
 	close(iter_fd);
 }
 
+static void subtest_ws_iter_check_open_coded(struct wakeup_source_iter *skel,
+					     int map_fd)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	char key[WAKEUP_SOURCE_NAME_LEN] = {0};
+	int err, fd;
+	bool found = false;
+
+	fd = bpf_program__fd(skel->progs.iter_ws_for_each);
+
+	err = bpf_prog_test_run_opts(fd, &topts);
+	if (!ASSERT_OK(err, "test_run_opts err"))
+		return;
+	if (!ASSERT_OK(topts.retval, "test_run_opts retval"))
+		return;
+
+	strncpy(key, test_ws_name, WAKEUP_SOURCE_NAME_LEN - 1);
+
+	if (!ASSERT_OK(bpf_map_lookup_elem(map_fd, key, &found),
+		       "lookup test_ws_name"))
+		return;
+
+	ASSERT_TRUE(found, "found test ws via bpf_for_each");
+}
+
 void test_wakeup_source_iter(void)
 {
 	struct wakeup_source_iter *skel = NULL;
+	int map_fd;
+	const bool found_val = false;
+	char key[WAKEUP_SOURCE_NAME_LEN] = {0};
 
 	if (geteuid() != 0) {
 		fprintf(stderr,
@@ -256,6 +284,17 @@ void test_wakeup_source_iter(void)
 	if (!ASSERT_OK_PTR(skel, "wakeup_source_iter__open_and_load"))
 		return;
 
+	map_fd = bpf_map__fd(skel->maps.test_ws_hash);
+	if (!ASSERT_OK_FD(map_fd, "map_fd"))
+		goto destroy_skel;
+
+	/* Copy test name to key buffer, ensuring it's zero-padded */
+	strncpy(key, test_ws_name, WAKEUP_SOURCE_NAME_LEN - 1);
+
+	if (!ASSERT_OK(bpf_map_update_elem(map_fd, key, &found_val, BPF_ANY),
+		       "insert test_ws_name"))
+		goto destroy_skel;
+
 	if (!ASSERT_OK(setup_test_ws(), "setup_test_ws"))
 		goto destroy;
 
@@ -274,8 +313,11 @@ void test_wakeup_source_iter(void)
 		subtest_ws_iter_check_sleep_times(skel);
 	if (test__start_subtest("no_infinite_reads"))
 		subtest_ws_iter_check_no_infinite_reads(skel);
+	if (test__start_subtest("open_coded"))
+		subtest_ws_iter_check_open_coded(skel, map_fd);
 
 destroy:
 	teardown_test_ws();
+destroy_skel:
 	wakeup_source_iter__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/wakeup_source_iter.c b/tools/testing/selftests/bpf/progs/wakeup_source_iter.c
index 9a377fd28f4e..a95718dadcc7 100644
--- a/tools/testing/selftests/bpf/progs/wakeup_source_iter.c
+++ b/tools/testing/selftests/bpf/progs/wakeup_source_iter.c
@@ -9,6 +9,13 @@
 
 char _license[] SEC("license") = "GPL";
 
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, WAKEUP_SOURCE_NAME_LEN);
+	__type(value, bool);
+	__uint(max_entries, 5);
+} test_ws_hash SEC(".maps");
+
 SEC("iter/wakeup_source")
 int wakeup_source_collector(struct bpf_iter__wakeup_source *ctx)
 {
@@ -68,3 +75,43 @@ int wakeup_source_collector(struct bpf_iter__wakeup_source *ctx)
 		       wakeup_count);
 	return 0;
 }
+
+SEC("syscall")
+int iter_ws_for_each(const void *ctx)
+{
+	struct wakeup_source *ws;
+
+	bpf_for_each(wakeup_source, ws) {
+		char name[WAKEUP_SOURCE_NAME_LEN];
+		const char *pname;
+		bool *found;
+		long len;
+		int i;
+
+		if (bpf_core_read(&pname, sizeof(pname), &ws->name))
+			return 1;
+
+		if (!pname)
+			continue;
+
+		len = bpf_probe_read_kernel_str(name, sizeof(name), pname);
+		if (len < 0)
+			return 1;
+
+		/*
+		 * Clear the remainder of the buffer to ensure a stable key for
+		 * the map lookup.
+		 */
+		bpf_for(i, len, WAKEUP_SOURCE_NAME_LEN)
+			name[i] = 0;
+
+		found = bpf_map_lookup_elem(&test_ws_hash, name);
+		if (found) {
+			bool t = true;
+
+			bpf_map_update_elem(&test_ws_hash, name, &t, BPF_EXIST);
+		}
+	}
+
+	return 0;
+}
-- 
2.52.0.457.g6b5491de43-goog


