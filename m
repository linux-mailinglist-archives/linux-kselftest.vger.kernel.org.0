Return-Path: <linux-kselftest+bounces-7327-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 779B289AA2E
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Apr 2024 11:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 634281C21182
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Apr 2024 09:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D894D133;
	Sat,  6 Apr 2024 09:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="A4hClA6S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733B33BBE5
	for <linux-kselftest@vger.kernel.org>; Sat,  6 Apr 2024 09:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712395239; cv=none; b=TsKlYf66hpQ7M3QyRVC5EbRx22jufv8BhHpIY6lpY9i1DlJkGHiuEYftFjAulVymLzKTsBDFM8pqvOeoI+2m2NibxBvsdEAL8EGaPMB/PXfNiOZ81mvTaHx6IHmypshdN97o9gSoieTrYJWYa97BoDCAgP8V2S24YscJ4BS5O4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712395239; c=relaxed/simple;
	bh=WxyORd5UGrvrhH3ovdgj29XhigFycIY9JFgRu0PCY/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UfmQ6FmzeAWwDWjJ/u8CZxgw0cCOMe0V+sIgnH8aAbqnadfMSF46K9kkaaALZtO0UAdDvLP+Uf0tXRiVyyDrMXwuc08pnwivLMLscpDMPoTVMPmO8Mqj0SZsDqseWFkxTBZU4xEuKPab0hD32yjXVSeOCTZBx8ZQrY6vCRDq/zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=A4hClA6S; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EF9393FE64
	for <linux-kselftest@vger.kernel.org>; Sat,  6 Apr 2024 09:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1712395223;
	bh=OGumsLBWYsNiBqaQkxgfB4Yj3V+oiBGI9bnDO7L7IE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=A4hClA6SGTtBjYX62dfXWjb2uNURMfD/S1PHiJaT7PkqrPUpCoF9nr2cwn+E1bZw0
	 E0gCxbsa0GKldzg93PMTZhMjv1xQbm8aTsYn0nbJKtC55XK4ZQjM57IVA6RIwx65FL
	 XV6h6qocR4gQZk6UwFL8S2SD8uNhEtyL6UJEHU9Ud8g4GKSnUo8rwFXF7VieBalPWQ
	 5LCP8d/XhSsOS7s/2t0duYxP86cmn6hpvIdK+bHZiJ0pc0D8UCJYx3O/s8VIdQHbbB
	 ELVC5EB7eBWcYiV+ljm+9V9vxVoSFUjVaVUD00Pb9BFQMAOlka9pF9nbMu7Vtbjqqj
	 bByxtAyLCRo8w==
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4147f17da12so14516785e9.0
        for <linux-kselftest@vger.kernel.org>; Sat, 06 Apr 2024 02:20:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712395218; x=1713000018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OGumsLBWYsNiBqaQkxgfB4Yj3V+oiBGI9bnDO7L7IE8=;
        b=bkgJIrJa3zfUOEyeedGw+yNTqhOsag1AC351E5nYA+PkOnxH7Pw+PO6g9Vxg+Sylen
         9pdWFjw/KsC77FPUcnxXx0ExUcXMETA7wy+TPGjJ6RZYkgXw25DRLqDZJrHVrR8s8idK
         QlKN6T/7X6C6pHpX9DFVEo5vtNlISOcCJ7//V0V3P823t4JAK14lFaNLQHMOwB9WKZBj
         Ej9UFxrinZBa3O4h5hfK4l0/Xcou9byCfafu12kmgPLjOWIH66SCkjec6d9xYPhRhhzv
         3bVAhRIDPxyNmc8eH79iktSXcKJ+rJ5UWtatOjoGdsvn/93sV5E/kDyu4wYKR2DoWNWB
         rqfw==
X-Forwarded-Encrypted: i=1; AJvYcCU+RUyjOC5vVxaRdYhVWEbg76olJvNjTHNGWLzTBI+aUGUrT8+WAuvbA88ZMVt+KzcljX6zdx5RqzFZSNwHukMZ/9/6KXPfSKvH7xbpMYsw
X-Gm-Message-State: AOJu0YyjA1Xw+FfORQeZXG4BBYCttSkpgOiXytWZ6MO5ZlX1oV4kkjCd
	gLMd7PMBJ+LxlIZKaPXaSH8nk9UKbKg596QC+dohdx6jK88AC39AuUn6wCWIG6NTyLjo/gWp1ep
	r5HRcFfqRzXYfRtdWb7Pv1KEb9JyNCdlDw7UTBF/JThSTkCFJ7+TN4Mf2O9ZN3at2hn/EkWI/6N
	u+f2PhVw==
X-Received: by 2002:a05:600c:4e8c:b0:415:6728:a584 with SMTP id f12-20020a05600c4e8c00b004156728a584mr2494536wmq.25.1712395217755;
        Sat, 06 Apr 2024 02:20:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNXztDhLsiKAKWeuFLp95WeOaSFimKeT6ittgqyCRbNIAyGvgIZJkAN7068+uWqmdKvBO5fg==
X-Received: by 2002:a05:600c:4e8c:b0:415:6728:a584 with SMTP id f12-20020a05600c4e8c00b004156728a584mr2494512wmq.25.1712395217054;
        Sat, 06 Apr 2024 02:20:17 -0700 (PDT)
Received: from gpd.station (net-2-39-142-110.cust.vodafonedsl.it. [2.39.142.110])
        by smtp.gmail.com with ESMTPSA id l23-20020a7bc457000000b00414924f307csm5779993wmi.26.2024.04.06.02.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 02:20:16 -0700 (PDT)
From: Andrea Righi <andrea.righi@canonical.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	David Vernet <void@manifault.com>,
	Tejun Heo <tj@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/4] libbpf: Add ring__consume_n / ring_buffer__consume_n
Date: Sat,  6 Apr 2024 11:15:43 +0200
Message-ID: <20240406092005.92399-4-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240406092005.92399-1-andrea.righi@canonical.com>
References: <20240406092005.92399-1-andrea.righi@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new API to consume items from a ring buffer, limited to a
specified amount, and return to the caller the actual number of items
consumed.

Link: https://lore.kernel.org/lkml/20240310154726.734289-1-andrea.righi@canonical.com/T
Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 tools/lib/bpf/libbpf.h   | 12 ++++++++++++
 tools/lib/bpf/libbpf.map |  3 +++
 tools/lib/bpf/ringbuf.c  | 38 +++++++++++++++++++++++++++++++++++---
 3 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index f88ab50c0229..4f775a6dcaa0 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1293,6 +1293,7 @@ LIBBPF_API int ring_buffer__add(struct ring_buffer *rb, int map_fd,
 				ring_buffer_sample_fn sample_cb, void *ctx);
 LIBBPF_API int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms);
 LIBBPF_API int ring_buffer__consume(struct ring_buffer *rb);
+LIBBPF_API int ring_buffer__consume_n(struct ring_buffer *rb, size_t n);
 LIBBPF_API int ring_buffer__epoll_fd(const struct ring_buffer *rb);
 
 /**
@@ -1367,6 +1368,17 @@ LIBBPF_API int ring__map_fd(const struct ring *r);
  */
 LIBBPF_API int ring__consume(struct ring *r);
 
+/**
+ * @brief **ring__consume_n()** consumes up to a requested amount of items from
+ * a ringbuffer without event polling.
+ *
+ * @param r A ringbuffer object.
+ * @param n Maximum amount of items to consume.
+ * @return The number of items consumed, or a negative number if any of the
+ * callbacks return an error.
+ */
+LIBBPF_API int ring__consume_n(struct ring *r, size_t n);
+
 struct user_ring_buffer_opts {
 	size_t sz; /* size of this struct, for forward/backward compatibility */
 };
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 5dd81a7b96b5..23d82bba021a 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -418,4 +418,7 @@ LIBBPF_1.4.0 {
 } LIBBPF_1.3.0;
 
 LIBBPF_1.5.0 {
+	global:
+		ring__consume_n;
+		ring_buffer__consume_n;
 } LIBBPF_1.4.0;
diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index 2c4031168413..19cd34883011 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -277,6 +277,33 @@ static int64_t ringbuf_process_ring(struct ring *r, size_t n)
 	return cnt;
 }
 
+/* Consume available ring buffer(s) data without event polling, up to n
+ * records.
+ *
+ * Returns number of records consumed across all registered ring buffers (or
+ * n, whichever is less), or negative number if any of the callbacks return
+ * error.
+ */
+int ring_buffer__consume_n(struct ring_buffer *rb, size_t n)
+{
+	int64_t err, res = 0;
+	int i;
+
+	for (i = 0; i < rb->ring_cnt; i++) {
+		struct ring *ring = rb->rings[i];
+
+		err = ringbuf_process_ring(ring, n);
+		if (err < 0)
+			return libbpf_err(err);
+		res += err;
+		n -= err;
+
+		if (n == 0)
+			break;
+	}
+	return res;
+}
+
 /* Consume available ring buffer(s) data without event polling.
  * Returns number of records consumed across all registered ring buffers (or
  * INT_MAX, whichever is less), or negative number if any of the callbacks
@@ -378,17 +405,22 @@ int ring__map_fd(const struct ring *r)
 	return r->map_fd;
 }
 
-int ring__consume(struct ring *r)
+int ring__consume_n(struct ring *r, size_t n)
 {
-	int64_t res;
+	int res;
 
-	res = ringbuf_process_ring(r, INT_MAX);
+	res = ringbuf_process_ring(r, n);
 	if (res < 0)
 		return libbpf_err(res);
 
 	return res > INT_MAX ? INT_MAX : res;
 }
 
+int ring__consume(struct ring *r)
+{
+	return ring__consume_n(r, INT_MAX);
+}
+
 static void user_ringbuf_unmap_ring(struct user_ring_buffer *rb)
 {
 	if (rb->consumer_pos) {
-- 
2.43.0


