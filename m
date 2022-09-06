Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D1C5AF57E
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Sep 2022 22:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbiIFUKi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Sep 2022 16:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbiIFUKO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Sep 2022 16:10:14 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 010781083;
        Tue,  6 Sep 2022 13:05:13 -0700 (PDT)
Received: from pwmachine.numericable.fr (85-170-34-72.rev.numericable.fr [85.170.34.72])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9EE5D2049BAF;
        Tue,  6 Sep 2022 12:58:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9EE5D2049BAF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1662494321;
        bh=5lDK7It259RN4ymtCiet+4wq5JdclQetrfA0fw0WV64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n4pfBsr8YWPyT8jTqgIQ0DuqftZrl5YeBbvTauX+bmGr6Oi5Og9mJq+BFVDiKjYRZ
         +28qWwbzGIlpkEiLF16UdzsP9MLefcnk+gN0iBPjiPS68hMTZENletySVI9taNLRSI
         zMDXto3nHyBx3sfB03NjnyOBkFLegNVD8mPIMfA8=
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
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [RFC PATCH v2 2/5] selftests: Add BPF overwritable ring buffer self tests.
Date:   Tue,  6 Sep 2022 21:56:43 +0200
Message-Id: <20220906195656.33021-3-flaniel@linux.microsoft.com>
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

Add tests to confirm behavior of overwritable BPF ring buffer, particularly the
oldest data being overwritten by newest ones.

Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
---
 tools/testing/selftests/bpf/Makefile          |   5 +-
 .../bpf/prog_tests/ringbuf_overwritable.c     | 158 ++++++++++++++++++
 .../bpf/progs/test_ringbuf_overwritable.c     |  61 +++++++
 3 files changed, 222 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ringbuf_overwritable.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_ringbuf_overwritable.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 8d59ec7f4c2d..96e95dcfc982 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -351,8 +351,9 @@ LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
 		test_usdt.skel.h
 
 LSKELS := kfunc_call_test.c fentry_test.c fexit_test.c fexit_sleep.c \
-	test_ringbuf.c atomics.c trace_printk.c trace_vprintk.c \
-	map_ptr_kern.c core_kern.c core_kern_overflow.c
+	test_ringbuf.c test_ringbuf_overwritable.c atomics.c \
+	trace_printk.c trace_vprintk.c map_ptr_kern.c \
+	core_kern.c core_kern_overflow.c
 # Generate both light skeleton and libbpf skeleton for these
 LSKELS_EXTRA := test_ksyms_module.c test_ksyms_weak.c kfunc_call_test_subprog.c
 SKEL_BLACKLIST += $$(LSKELS)
diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf_overwritable.c b/tools/testing/selftests/bpf/prog_tests/ringbuf_overwritable.c
new file mode 100644
index 000000000000..b5ec1e62f761
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/ringbuf_overwritable.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <linux/compiler.h>
+#include <asm/barrier.h>
+#include <test_progs.h>
+#include <sys/mman.h>
+#include <sys/epoll.h>
+#include <time.h>
+#include <sched.h>
+#include <signal.h>
+#include <pthread.h>
+#include <sys/sysinfo.h>
+#include <linux/perf_event.h>
+#include <linux/ring_buffer.h>
+#include "test_ringbuf_overwritable.lskel.h"
+
+struct sample {
+	int count;
+	/*
+	 * filler size will be computed to have 8 samples in a 4096 bytes long
+	 * buffer.
+	 */
+	char filler[4096 / 8 - sizeof(int) - 8];
+};
+
+struct ring {
+	ring_buffer_sample_fn sample_cb;
+	__u8 overwritable: 1,
+	     __reserved:   7;
+	void *ctx;
+	void *data;
+	unsigned long *consumer_pos;
+	unsigned long *producer_pos;
+	unsigned long mask;
+	int map_fd;
+};
+
+struct ring_buffer {
+	struct epoll_event *events;
+	struct ring *rings;
+	size_t page_size;
+	int epoll_fd;
+	int ring_cnt;
+};
+
+static int duration;
+static struct test_ringbuf_overwritable_lskel *skel;
+
+void test_ringbuf_overwritable(void)
+{
+	const size_t rec_sz = BPF_RINGBUF_HDR_SZ + sizeof(struct sample);
+	int page_size = getpagesize();
+	int sample_cnt = 0, sample_read = 0;
+	unsigned long mask = page_size - 1;
+	struct ring_buffer *ringbuf;
+	int err, *len_ptr, len;
+	struct sample *sample;
+	long read_pos;
+	void *data_ptr;
+
+	skel = test_ringbuf_overwritable_lskel__open();
+	if (CHECK(!skel, "skel_open", "skeleton open failed\n"))
+		return;
+
+	skel->maps.ringbuf.max_entries = page_size;
+
+	err = test_ringbuf_overwritable_lskel__load(skel);
+	if (CHECK(err != 0, "skel_load", "skeleton load failed\n"))
+		goto cleanup;
+
+	/* only trigger BPF program for current process */
+	skel->bss->pid = getpid();
+
+	ringbuf = ring_buffer__new(skel->maps.ringbuf.map_fd, NULL, NULL, NULL);
+	if (CHECK(!ringbuf, "ringbuf_create", "failed to create ringbuf\n"))
+		goto cleanup;
+
+	/* There is only one ring in this ringbuf. */
+	data_ptr = ringbuf->rings[0].data;
+
+	err = test_ringbuf_overwritable_lskel__attach(skel);
+	if (CHECK(err, "skel_attach", "skeleton attachment failed: %d\n", err))
+		goto cleanup;
+
+	/* Trigger one sample. */
+	syscall(__NR_getpgid);
+	sample_cnt++;
+
+	CHECK(skel->bss->avail_data != -EINVAL,
+	      "err_avail_size", "exp %d, got %ld\n",
+	      -EINVAL, skel->bss->avail_data);
+	CHECK(skel->bss->ring_size != page_size,
+	      "err_ring_size", "exp %ld, got %ld\n",
+	      (long)page_size, skel->bss->ring_size);
+	CHECK(skel->bss->cons_pos != -EINVAL,
+	      "err_cons_pos", "exp %d, got %ld\n",
+	      -EINVAL, skel->bss->cons_pos);
+	CHECK(skel->bss->prod_pos != sample_cnt * -rec_sz,
+	      "err_prod_pos", "exp %ld, got %ld\n",
+	      sample_cnt * -rec_sz, skel->bss->prod_pos);
+
+	len_ptr = data_ptr + (skel->bss->prod_pos & mask);
+	len = smp_load_acquire(len_ptr);
+
+	CHECK(len != sizeof(struct sample),
+	      "err_sample_len", "exp %ld, got %d\n",
+	      sizeof(struct sample), len);
+
+	sample = (void *)len_ptr + BPF_RINGBUF_HDR_SZ;
+
+	CHECK(sample->count != sample_cnt,
+	      "err_sample_cnt", "exp %d, got %d",
+	      sample_cnt, sample->count);
+
+	/* Trigger many samples, so we overwrite data */
+	for (int i = 0; i < 16; i++) {
+		syscall(__NR_getpgid);
+		sample_cnt++;
+	}
+
+	CHECK(skel->bss->avail_data != -EINVAL,
+	      "err_avail_size", "exp %d, got %ld\n",
+	      -EINVAL, skel->bss->avail_data);
+	CHECK(skel->bss->ring_size != page_size,
+	      "err_ring_size", "exp %ld, got %ld\n",
+	      (long)page_size, skel->bss->ring_size);
+	CHECK(skel->bss->cons_pos != -EINVAL,
+	      "err_cons_pos", "exp %d, got %ld\n",
+	      -EINVAL, skel->bss->cons_pos);
+	CHECK(skel->bss->prod_pos != sample_cnt * -rec_sz,
+	      "err_prod_pos", "exp %ld, got %ld\n",
+	      sample_cnt * -rec_sz, skel->bss->prod_pos);
+
+	read_pos = skel->bss->prod_pos;
+	sample_read = 0;
+	while (read_pos - skel->bss->prod_pos < mask) {
+		len_ptr = data_ptr + (read_pos & mask);
+		len = smp_load_acquire(len_ptr);
+
+		sample = (void *)len_ptr + BPF_RINGBUF_HDR_SZ;
+
+		CHECK(sample->count != sample_cnt - sample_read,
+		      "err_sample_cnt", "exp %d, got %d",
+		      sample_cnt - sample_read, sample->count);
+
+		sample_read++;
+		read_pos += round_up(len + BPF_RINGBUF_HDR_SZ, 8);
+	}
+
+	CHECK(sample_read != page_size / rec_sz,
+	      "err_sample_read", "exp %ld, got %d",
+	      page_size / rec_sz, sample_read);
+
+	test_ringbuf_overwritable_lskel__detach(skel);
+cleanup:
+	ring_buffer__free(ringbuf);
+	test_ringbuf_overwritable_lskel__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf_overwritable.c b/tools/testing/selftests/bpf/progs/test_ringbuf_overwritable.c
new file mode 100644
index 000000000000..e28be35059b7
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_ringbuf_overwritable.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2020 Facebook
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct sample {
+	int count;
+	/*
+	 * filler size will be computed to have 8 samples in a 4096 bytes long
+	 * buffer.
+	 */
+	char filler[4096 / 8 - sizeof(int) - BPF_RINGBUF_HDR_SZ];
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(map_flags, BFP_F_RB_OVERWRITABLE);
+} ringbuf SEC(".maps");
+
+/* inputs */
+int pid = 0;
+
+/* outputs */
+long avail_data = 0;
+long ring_size = 0;
+long cons_pos = 0;
+long prod_pos = 0;
+
+static int count;
+
+SEC("fentry/" SYS_PREFIX "sys_getpgid")
+int test_ringbuf_overwritable(void *ctx)
+{
+	int cur_pid = bpf_get_current_pid_tgid() >> 32;
+	struct sample *sample;
+
+	if (cur_pid != pid)
+		return 0;
+
+	sample = bpf_ringbuf_reserve(&ringbuf, sizeof(*sample), 0);
+	if (!sample)
+		return 0;
+
+	__sync_fetch_and_add(&count, 1);
+	sample->count = count;
+
+	bpf_printk("count: %d\n", count);
+
+	bpf_ringbuf_submit(sample, 0);
+
+	avail_data = bpf_ringbuf_query(&ringbuf, BPF_RB_AVAIL_DATA);
+	ring_size = bpf_ringbuf_query(&ringbuf, BPF_RB_RING_SIZE);
+	cons_pos = bpf_ringbuf_query(&ringbuf, BPF_RB_CONS_POS);
+	prod_pos = bpf_ringbuf_query(&ringbuf, BPF_RB_PROD_POS);
+
+	return 0;
+}
-- 
2.25.1

