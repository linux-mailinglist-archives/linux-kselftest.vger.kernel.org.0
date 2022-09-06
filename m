Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E1D5AF55D
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Sep 2022 22:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiIFUFz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Sep 2022 16:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiIFUFe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Sep 2022 16:05:34 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DAB97B602B;
        Tue,  6 Sep 2022 13:01:10 -0700 (PDT)
Received: from pwmachine.numericable.fr (85-170-34-72.rev.numericable.fr [85.170.34.72])
        by linux.microsoft.com (Postfix) with ESMTPSA id EAFD4204A580;
        Tue,  6 Sep 2022 12:59:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EAFD4204A580
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1662494381;
        bh=N4qKGNRCArorGaqJPvl3arifkj3tGRGaxyc5hkP2FRA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YHDuOBp3oEAQ+LnOL1ippAIf7DJGdmUY1DDeO2SFn6XY2urLU+ZehCkolr/XgcX+t
         v1k3Pkj1O9uk1MP4cRwir7XBkmbkke1JOvRWMhZrHi5sdj3dHN1aM/lcT4XeHqRtrA
         0tiIgnXQqhhkb/ZRVWw839cEBZZVp3aeC5DThNEM=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     bpf@vger.kernel.org
Cc:     Francis Laniel <flaniel@linux.microsoft.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Maxim Mikityanskiy <maximmi@nvidia.com>,
        Geliang Tang <geliang.tang@suse.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [RFC PATCH v2 5/5] for test purpose only: Add toy to play with BPF ring.
Date:   Tue,  6 Sep 2022 21:56:46 +0200
Message-Id: <20220906195656.33021-6-flaniel@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220906195656.33021-1-flaniel@linux.microsoft.com>
References: <20220906195656.33021-1-flaniel@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch should be applied on iovisor/bcc.

Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
---
 ...-only-Add-toy-to-play-with-BPF-ring-.patch | 147 ++++++++++++++++++
 1 file changed, 147 insertions(+)
 create mode 100644 0001-for-test-purpose-only-Add-toy-to-play-with-BPF-ring-.patch

diff --git a/0001-for-test-purpose-only-Add-toy-to-play-with-BPF-ring-.patch b/0001-for-test-purpose-only-Add-toy-to-play-with-BPF-ring-.patch
new file mode 100644
index 000000000000..37d08cc08a88
--- /dev/null
+++ b/0001-for-test-purpose-only-Add-toy-to-play-with-BPF-ring-.patch
@@ -0,0 +1,147 @@
+From e4b95b1f9625f62d0978173973070dce38bd7210 Mon Sep 17 00:00:00 2001
+From: Francis Laniel <flaniel@linux.microsoft.com>
+Date: Tue, 9 Aug 2022 18:18:53 +0200
+Subject: [PATCH] for test purpose only: Add toy to play with BPF ring buffer.
+
+Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
+---
+ libbpf-tools/Makefile  |  1 +
+ libbpf-tools/toy.bpf.c | 29 +++++++++++++++++++
+ libbpf-tools/toy.c     | 65 ++++++++++++++++++++++++++++++++++++++++++
+ libbpf-tools/toy.h     |  4 +++
+ 4 files changed, 99 insertions(+)
+ create mode 100644 libbpf-tools/toy.bpf.c
+ create mode 100644 libbpf-tools/toy.c
+ create mode 100644 libbpf-tools/toy.h
+
+diff --git a/libbpf-tools/Makefile b/libbpf-tools/Makefile
+index 3e40f6e5..0d81d3b7 100644
+--- a/libbpf-tools/Makefile
++++ b/libbpf-tools/Makefile
+@@ -68,6 +68,7 @@ APPS = \
+ 	tcplife \
+ 	tcprtt \
+ 	tcpsynbl \
++	toy \
+ 	vfsstat \
+ 	#
+ 
+diff --git a/libbpf-tools/toy.bpf.c b/libbpf-tools/toy.bpf.c
+new file mode 100644
+index 00000000..3c28a20b
+--- /dev/null
++++ b/libbpf-tools/toy.bpf.c
+@@ -0,0 +1,29 @@
++#include <linux/types.h>
++#include <bpf/bpf_helpers.h>
++#include <linux/bpf.h>
++#include "toy.h"
++
++
++struct {
++	__uint(type, BPF_MAP_TYPE_RINGBUF);
++	__uint(max_entries, 4096);
++	__uint(map_flags, 1U << 13);
++} buffer SEC(".maps");
++
++static __u32 count = 0;
++
++SEC("tracepoint/syscalls/sys_enter_execve")
++int sys_enter_execve(void) {
++	count++;
++	struct event *event = bpf_ringbuf_reserve(&buffer, sizeof(struct event), 0);
++	if (!event) {
++		return 1;
++	}
++
++	event->count = count;
++	bpf_ringbuf_submit(event, 0);
++
++	return 0;
++}
++
++char _license[] SEC("license") = "GPL";
+diff --git a/libbpf-tools/toy.c b/libbpf-tools/toy.c
+new file mode 100644
+index 00000000..4cd8b588
+--- /dev/null
++++ b/libbpf-tools/toy.c
+@@ -0,0 +1,65 @@
++#include <bpf/libbpf.h>
++#include <stdio.h>
++#include <unistd.h>
++#include "toy.h"
++#include "toy.skel.h"
++#include "btf_helpers.h"
++
++
++static int buf_process_sample(void *ctx, void *data, size_t len) {
++	struct event *evt = (struct event *)data;
++
++	printf("%d\n", evt->count);
++
++	return 0;
++}
++
++int main(void) {
++	LIBBPF_OPTS(bpf_object_open_opts, open_opts);
++	int buffer_map_fd = -1;
++	struct toy_bpf *obj;
++	int err;
++
++	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
++
++	err = ensure_core_btf(&open_opts);
++	if (err) {
++		fprintf(stderr, "failed to fetch necessary BTF for CO-RE: %s\n", strerror(-err));
++		return 1;
++	}
++
++	obj = toy_bpf__open_opts(&open_opts);
++	if (!obj) {
++		fprintf(stderr, "failed to open BPF object\n");
++		return 1;
++	}
++
++	err = toy_bpf__load(obj);
++	if (err) {
++		fprintf(stderr, "failed to load BPF object: %d\n", err);
++		return 1;
++	}
++
++	struct ring_buffer *ring_buffer;
++
++	buffer_map_fd = bpf_object__find_map_fd_by_name(obj->obj, "buffer");
++	ring_buffer = ring_buffer__new(buffer_map_fd, buf_process_sample, NULL, NULL);
++
++	if(!ring_buffer) {
++		fprintf(stderr, "failed to create ring buffer\n");
++		return 1;
++	}
++
++	err = toy_bpf__attach(obj);
++	if (err) {
++		fprintf(stderr, "failed to attach BPF programs\n");
++		return 1;
++	}
++
++	for (;;) {
++		ring_buffer__consume(ring_buffer);
++		sleep(1);
++	}
++
++	return 0;
++}
+diff --git a/libbpf-tools/toy.h b/libbpf-tools/toy.h
+new file mode 100644
+index 00000000..ebfedf06
+--- /dev/null
++++ b/libbpf-tools/toy.h
+@@ -0,0 +1,4 @@
++struct event {
++	__u32 count;
++	char filler[4096 / 8 - sizeof(__u32) - 8];
++};
+-- 
+2.25.1
+
-- 
2.25.1

