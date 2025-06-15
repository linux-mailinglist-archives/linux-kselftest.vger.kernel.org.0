Return-Path: <linux-kselftest+bounces-35036-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D6CADA3FD
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jun 2025 22:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D4E73A4C73
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jun 2025 20:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225E327FD4C;
	Sun, 15 Jun 2025 20:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WqceX4mh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532CF29A2
	for <linux-kselftest@vger.kernel.org>; Sun, 15 Jun 2025 20:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750021170; cv=none; b=glHj8dZgcephpg9HwfZxnQE+JkFpIVk9l9NinLdp4JYVXlhpJZXW95rJjbtJEDxxgF9zHuVjyH2RdUTaKXMnAcLZDB6nOyYYAwFhhMXbnnEx7JQjIRwD7Jyatr5M6xWL53VzsjlO5ZVD0CCpU9LUig/IlaMlUP/zEKnWJwnwa2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750021170; c=relaxed/simple;
	bh=jfsHcxdTggv0hazxijRnSLu5GIeHewR8twj0CXJpW78=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JnFXaKhXbz9o0ViRHQOhvZb7u/zISbf/qZbgDcTXPYTuoLHTvSQYtUR25U1enlJH16bZ2U2nJH0rVlqnJRHWWuSBJHk46dOVth7oHn/ztxntYj7fFpf4YDq4SGHSqFgLrUxsYQtQM/qrKuH0n84egFb8H+gbFyNZcm/TKgRj2AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WqceX4mh; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-2cca2c52dd9so2289082fac.3
        for <linux-kselftest@vger.kernel.org>; Sun, 15 Jun 2025 13:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750021166; x=1750625966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zbYLLFoA/SRt8FFyswFyeWs4BhwMlEd9eNL++BiVabs=;
        b=WqceX4mhCcLhCGxXmkoXJ/1MFaEKLelVtDuFtNbPRb7Lu44gBTZoWhanj/cIecJyFG
         JhMHgbRZb/5ZmjMaMki+sC/uU9aIKEjdlhBvEYFwg/junqRhNUwKKXx6gSo4bmZpzpob
         7F1WqXfdnxdQa883pR5/TtNUEqb/S7IqwL4/D4iQA9TwdarlqMtMQB1TjZTHPrUQNUVG
         qH9d9mGTwAzW6Uo9br9nOnVI7r5enWk7gvPni/W1ygYrsCVJt38igP+XPJVi5LAvB2hZ
         UHi6F+YEwcAthuuiKDN/mgHpsF2MNKkIsakN0qatQEi8g8XxPz9fvgvfGOMx+gM59f7I
         EH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750021166; x=1750625966;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbYLLFoA/SRt8FFyswFyeWs4BhwMlEd9eNL++BiVabs=;
        b=cUHwPjtrU1l8YF4qEcWhnGFsTv4kzKzClJlZ4Pi30G4wxsD/ASwfHZ13sodWWnyFAD
         Nj6wdq06GkGXxniASdnvktSCyOEFkLomJ58HHhsXU8qtOoEeapfUNKrsXjmtmmLIIC2E
         sgNxUoa1P1pAGys5Nr1SXW+uxSLkx2RVCQxFrUbbpTH7cnVfQen3BYEAdaD3FMt9GZWK
         6BJPgO35M0V8VG8yMCKEa9w/Jxeq4nkMMI6f4hU0rMFdNKtcdd4VanQu7EPEUOROHF27
         TzfGunMTgXVpIXJdiXjooffqsPfM5SNOqQDHAv6jJEoGMDUpvD+laZ9lqdoWE7UHVjxr
         GFbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlfF5F/4OUGUxUTiJbGl0conRHiw6OdRYAeygFXjg5xpkjqnBRSaigeiT4NzBIveiSseTXoC+YEJVKNozJYWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxDM2+AM6/SiR6ykV4BfyVL9XAcg1zgayJfC1YAN9BvnXmnGw0
	y/0ouNy7WGorRz4C1lcJ+ce+b/uUxDmc1wN4vg+BRwD1YN/DgHUrJBSWIAlow7V3o4sS1bP7vii
	SR+1v9IJjsbtrmL63gTt3FZa7iw==
X-Google-Smtp-Source: AGHT+IFnHXrAu/h1LNyQY+k3/2odHzN5ulvZa+gk+CANe5zNsBm7KtkshSbdaGC9Txdfwdo+ax3r7061acpmoE49fQ==
X-Received: from oabxe8.prod.google.com ([2002:a05:6870:ce88:b0:2e9:2323:d48f])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6870:2c85:b0:2ea:73fb:7850 with SMTP id 586e51a60fabf-2eaf0a19316mr4134836fac.24.1750021166541;
 Sun, 15 Jun 2025 13:59:26 -0700 (PDT)
Date: Sun, 15 Jun 2025 20:59:14 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250615205914.835368-1-almasrymina@google.com>
Subject: [PATCH net-next v4] page_pool: import Jesper's page_pool benchmark
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Mina Almasry <almasrymina@google.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@toke.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Jesper Dangaard Brouer <hawk@kernel.org>

We frequently consult with Jesper's out-of-tree page_pool benchmark to
evaluate page_pool changes.

Import the benchmark into the upstream linux kernel tree so that (a)
we're all running the same version, (b) pave the way for shared
improvements, and (c) maybe one day integrate it with nipa, if possible.

Import bench_page_pool_simple from commit 35b1716d0c30 ("Add
page_bench06_walk_all"), from this repository:
https://github.com/netoptimizer/prototype-kernel.git

Changes done during upstreaming:
- Fix checkpatch issues.
- Remove the tasklet logic not needed.
- Move under tools/testing
- Create ksft for the benchmark.
- Changed slightly how the benchmark gets build. Out of tree, time_bench
  is built as an independent .ko. Here it is included in
  bench_page_pool.ko

Steps to run:

```
mkdir -p /tmp/run-pp-bench
make -C ./tools/testing/selftests/net/bench
make -C ./tools/testing/selftests/net/bench install INSTALL_PATH=3D/tmp/run=
-pp-bench
rsync --delete -avz --progress /tmp/run-pp-bench mina@$SERVER:~/
ssh mina@$SERVER << EOF
  cd ~/run-pp-bench && sudo ./test_bench_page_pool.sh
EOF
```

Output:

```
(benchmrk dmesg logs)

Fast path results:
no-softirq-page_pool01 Per elem: 11 cycles(tsc) 4.368 ns

ptr_ring results:
no-softirq-page_pool02 Per elem: 527 cycles(tsc) 195.187 ns

slow path results:
no-softirq-page_pool03 Per elem: 549 cycles(tsc) 203.466 ns
```

Cc: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

Signed-off-by: Mina Almasry <almasrymina@google.com>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>

---

v4: https://lore.kernel.org/netdev/20250614100853.3f2372f2@kernel.org/

- Fix more checkpatch and coccicheck issues (Jakub)

v3:
- Non RFC
- Collect Signed-off-by from Jesper and Acked-by Ilias.
- Move test_bench_page_pool.sh to address nipa complaint.
- Remove `static inline` in .c files to address nipa complaint.

v2:
- Move under tools/selftests (Jakub)
- Create ksft for it.
- Remove the tasklet logic no longer needed (Jesper + Toke)

RFC discussion points:
- Desirable to import it?
- Can the benchmark be imported as-is for an initial version? Or needs
  lots of modifications?
  - Code location. I retained the location in Jesper's tree, but a path
    like net/core/bench/ may make more sense.

---
 tools/testing/selftests/net/bench/Makefile    |   7 +
 .../selftests/net/bench/page_pool/Makefile    |  17 +
 .../bench/page_pool/bench_page_pool_simple.c  | 276 ++++++++++++
 .../net/bench/page_pool/time_bench.c          | 394 ++++++++++++++++++
 .../net/bench/page_pool/time_bench.h          | 238 +++++++++++
 .../net/bench/test_bench_page_pool.sh         |  32 ++
 6 files changed, 964 insertions(+)
 create mode 100644 tools/testing/selftests/net/bench/Makefile
 create mode 100644 tools/testing/selftests/net/bench/page_pool/Makefile
 create mode 100644 tools/testing/selftests/net/bench/page_pool/bench_page_=
pool_simple.c
 create mode 100644 tools/testing/selftests/net/bench/page_pool/time_bench.=
c
 create mode 100644 tools/testing/selftests/net/bench/page_pool/time_bench.=
h
 create mode 100755 tools/testing/selftests/net/bench/test_bench_page_pool.=
sh

diff --git a/tools/testing/selftests/net/bench/Makefile b/tools/testing/sel=
ftests/net/bench/Makefile
new file mode 100644
index 000000000000..2546c45e42f7
--- /dev/null
+++ b/tools/testing/selftests/net/bench/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+
+TEST_GEN_MODS_DIR :=3D page_pool
+
+TEST_PROGS +=3D test_bench_page_pool.sh
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/net/bench/page_pool/Makefile b/tools/t=
esting/selftests/net/bench/page_pool/Makefile
new file mode 100644
index 000000000000..0549a16ba275
--- /dev/null
+++ b/tools/testing/selftests/net/bench/page_pool/Makefile
@@ -0,0 +1,17 @@
+BENCH_PAGE_POOL_SIMPLE_TEST_DIR :=3D $(realpath $(dir $(abspath $(lastword=
 $(MAKEFILE_LIST)))))
+KDIR ?=3D /lib/modules/$(shell uname -r)/build
+
+ifeq ($(V),1)
+Q =3D
+else
+Q =3D @
+endif
+
+obj-m	+=3D bench_page_pool.o
+bench_page_pool-y +=3D bench_page_pool_simple.o time_bench.o
+
+all:
+	+$(Q)make -C $(KDIR) M=3D$(BENCH_PAGE_POOL_SIMPLE_TEST_DIR) modules
+
+clean:
+	+$(Q)make -C $(KDIR) M=3D$(BENCH_PAGE_POOL_SIMPLE_TEST_DIR) clean
diff --git a/tools/testing/selftests/net/bench/page_pool/bench_page_pool_si=
mple.c b/tools/testing/selftests/net/bench/page_pool/bench_page_pool_simple=
.c
new file mode 100644
index 000000000000..f183d5e30dc6
--- /dev/null
+++ b/tools/testing/selftests/net/bench/page_pool/bench_page_pool_simple.c
@@ -0,0 +1,276 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Benchmark module for page_pool.
+ *
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+#include <linux/mutex.h>
+
+#include <linux/version.h>
+#include <net/page_pool/helpers.h>
+
+#include <linux/interrupt.h>
+#include <linux/limits.h>
+
+#include "time_bench.h"
+
+static int verbose =3D 1;
+#define MY_POOL_SIZE 1024
+
+static void _page_pool_put_page(struct page_pool *pool, struct page *page,
+				bool allow_direct)
+{
+	page_pool_put_page(pool, page, -1, allow_direct);
+}
+
+/* Makes tests selectable. Useful for perf-record to analyze a single test=
.
+ * Hint: Bash shells support writing binary number like: $((2#101010)
+ *
+ * # modprobe bench_page_pool_simple run_flags=3D$((2#100))
+ */
+static unsigned long run_flags =3D 0xFFFFFFFF;
+module_param(run_flags, ulong, 0);
+MODULE_PARM_DESC(run_flags, "Limit which bench test that runs");
+
+/* Count the bit number from the enum */
+enum benchmark_bit {
+	bit_run_bench_baseline,
+	bit_run_bench_no_softirq01,
+	bit_run_bench_no_softirq02,
+	bit_run_bench_no_softirq03,
+};
+
+#define bit(b)		(1 << (b))
+#define enabled(b)	((run_flags & (bit(b))))
+
+/* notice time_bench is limited to U32_MAX nr loops */
+static unsigned long loops =3D 10000000;
+module_param(loops, ulong, 0);
+MODULE_PARM_DESC(loops, "Specify loops bench will run");
+
+/* Timing at the nanosec level, we need to know the overhead
+ * introduced by the for loop itself
+ */
+static int time_bench_for_loop(struct time_bench_record *rec, void *data)
+{
+	uint64_t loops_cnt =3D 0;
+	int i;
+
+	time_bench_start(rec);
+	/** Loop to measure **/
+	for (i =3D 0; i < rec->loops; i++) {
+		loops_cnt++;
+		barrier(); /* avoid compiler to optimize this loop */
+	}
+	time_bench_stop(rec, loops_cnt);
+	return loops_cnt;
+}
+
+static int time_bench_atomic_inc(struct time_bench_record *rec, void *data=
)
+{
+	uint64_t loops_cnt =3D 0;
+	atomic_t cnt;
+	int i;
+
+	atomic_set(&cnt, 0);
+
+	time_bench_start(rec);
+	/** Loop to measure **/
+	for (i =3D 0; i < rec->loops; i++) {
+		atomic_inc(&cnt);
+		barrier(); /* avoid compiler to optimize this loop */
+	}
+	loops_cnt =3D atomic_read(&cnt);
+	time_bench_stop(rec, loops_cnt);
+	return loops_cnt;
+}
+
+/* The ptr_ping in page_pool uses a spinlock. We need to know the minimum
+ * overhead of taking+releasing a spinlock, to know the cycles that can be=
 saved
+ * by e.g. amortizing this via bulking.
+ */
+static int time_bench_lock(struct time_bench_record *rec, void *data)
+{
+	uint64_t loops_cnt =3D 0;
+	spinlock_t lock;
+	int i;
+
+	spin_lock_init(&lock);
+
+	time_bench_start(rec);
+	/** Loop to measure **/
+	for (i =3D 0; i < rec->loops; i++) {
+		spin_lock(&lock);
+		loops_cnt++;
+		barrier(); /* avoid compiler to optimize this loop */
+		spin_unlock(&lock);
+	}
+	time_bench_stop(rec, loops_cnt);
+	return loops_cnt;
+}
+
+/* Helper for filling some page's into ptr_ring */
+static void pp_fill_ptr_ring(struct page_pool *pp, int elems)
+{
+	/* GFP_ATOMIC needed when under run softirq */
+	gfp_t gfp_mask =3D GFP_ATOMIC;
+	struct page **array;
+	int i;
+
+	array =3D kcalloc(elems, sizeof(struct page *), gfp_mask);
+
+	for (i =3D 0; i < elems; i++)
+		array[i] =3D page_pool_alloc_pages(pp, gfp_mask);
+	for (i =3D 0; i < elems; i++)
+		_page_pool_put_page(pp, array[i], false);
+
+	kfree(array);
+}
+
+enum test_type { type_fast_path, type_ptr_ring, type_page_allocator };
+
+/* Depends on compile optimizing this function */
+static int time_bench_page_pool(struct time_bench_record *rec, void *data,
+				enum test_type type, const char *func)
+{
+	uint64_t loops_cnt =3D 0;
+	gfp_t gfp_mask =3D GFP_ATOMIC; /* GFP_ATOMIC is not really needed */
+	int i, err;
+
+	struct page_pool *pp;
+	struct page *page;
+
+	struct page_pool_params pp_params =3D {
+		.order =3D 0,
+		.flags =3D 0,
+		.pool_size =3D MY_POOL_SIZE,
+		.nid =3D NUMA_NO_NODE,
+		.dev =3D NULL, /* Only use for DMA mapping */
+		.dma_dir =3D DMA_BIDIRECTIONAL,
+	};
+
+	pp =3D page_pool_create(&pp_params);
+	if (IS_ERR(pp)) {
+		err =3D PTR_ERR(pp);
+		pr_warn("%s: Error(%d) creating page_pool\n", func, err);
+		goto out;
+	}
+	pp_fill_ptr_ring(pp, 64);
+
+	if (in_serving_softirq())
+		pr_warn("%s(): in_serving_softirq fast-path\n", func);
+	else
+		pr_warn("%s(): Cannot use page_pool fast-path\n", func);
+
+	time_bench_start(rec);
+	/** Loop to measure **/
+	for (i =3D 0; i < rec->loops; i++) {
+		/* Common fast-path alloc that depend on in_serving_softirq() */
+		page =3D page_pool_alloc_pages(pp, gfp_mask);
+		if (!page)
+			break;
+		loops_cnt++;
+		barrier(); /* avoid compiler to optimize this loop */
+
+		/* The benchmarks purpose it to test different return paths.
+		 * Compiler should inline optimize other function calls out
+		 */
+		if (type =3D=3D type_fast_path) {
+			/* Fast-path recycling e.g. XDP_DROP use-case */
+			page_pool_recycle_direct(pp, page);
+
+		} else if (type =3D=3D type_ptr_ring) {
+			/* Normal return path */
+			_page_pool_put_page(pp, page, false);
+
+		} else if (type =3D=3D type_page_allocator) {
+			/* Test if not pages are recycled, but instead
+			 * returned back into systems page allocator
+			 */
+			get_page(page); /* cause no-recycling */
+			_page_pool_put_page(pp, page, false);
+			put_page(page);
+		} else {
+			BUILD_BUG();
+		}
+	}
+	time_bench_stop(rec, loops_cnt);
+out:
+	page_pool_destroy(pp);
+	return loops_cnt;
+}
+
+static int time_bench_page_pool01_fast_path(struct time_bench_record *rec,
+					    void *data)
+{
+	return time_bench_page_pool(rec, data, type_fast_path, __func__);
+}
+
+static int time_bench_page_pool02_ptr_ring(struct time_bench_record *rec,
+					   void *data)
+{
+	return time_bench_page_pool(rec, data, type_ptr_ring, __func__);
+}
+
+static int time_bench_page_pool03_slow(struct time_bench_record *rec,
+				       void *data)
+{
+	return time_bench_page_pool(rec, data, type_page_allocator, __func__);
+}
+
+static int run_benchmark_tests(void)
+{
+	uint32_t nr_loops =3D loops;
+
+	/* Baseline tests */
+	if (enabled(bit_run_bench_baseline)) {
+		time_bench_loop(nr_loops * 10, 0, "for_loop", NULL,
+				time_bench_for_loop);
+		time_bench_loop(nr_loops * 10, 0, "atomic_inc", NULL,
+				time_bench_atomic_inc);
+		time_bench_loop(nr_loops, 0, "lock", NULL, time_bench_lock);
+	}
+
+	/* This test cannot activate correct code path, due to no-softirq ctx */
+	if (enabled(bit_run_bench_no_softirq01))
+		time_bench_loop(nr_loops, 0, "no-softirq-page_pool01", NULL,
+				time_bench_page_pool01_fast_path);
+	if (enabled(bit_run_bench_no_softirq02))
+		time_bench_loop(nr_loops, 0, "no-softirq-page_pool02", NULL,
+				time_bench_page_pool02_ptr_ring);
+	if (enabled(bit_run_bench_no_softirq03))
+		time_bench_loop(nr_loops, 0, "no-softirq-page_pool03", NULL,
+				time_bench_page_pool03_slow);
+
+	return 0;
+}
+
+static int __init bench_page_pool_simple_module_init(void)
+{
+	if (verbose)
+		pr_info("Loaded\n");
+
+	if (loops > U32_MAX) {
+		pr_err("Module param loops(%lu) exceeded U32_MAX(%u)\n", loops,
+		       U32_MAX);
+		return -ECHRNG;
+	}
+
+	run_benchmark_tests();
+
+	return 0;
+}
+module_init(bench_page_pool_simple_module_init);
+
+static void __exit bench_page_pool_simple_module_exit(void)
+{
+	if (verbose)
+		pr_info("Unloaded\n");
+}
+module_exit(bench_page_pool_simple_module_exit);
+
+MODULE_DESCRIPTION("Benchmark of page_pool simple cases");
+MODULE_AUTHOR("Jesper Dangaard Brouer <netoptimizer@brouer.com>");
+MODULE_LICENSE("GPL");
diff --git a/tools/testing/selftests/net/bench/page_pool/time_bench.c b/too=
ls/testing/selftests/net/bench/page_pool/time_bench.c
new file mode 100644
index 000000000000..073bb36ec5f2
--- /dev/null
+++ b/tools/testing/selftests/net/bench/page_pool/time_bench.c
@@ -0,0 +1,394 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Benchmarking code execution time inside the kernel
+ *
+ * Copyright (C) 2014, Red Hat, Inc., Jesper Dangaard Brouer
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+#include <linux/time.h>
+
+#include <linux/perf_event.h> /* perf_event_create_kernel_counter() */
+
+/* For concurrency testing */
+#include <linux/completion.h>
+#include <linux/sched.h>
+#include <linux/workqueue.h>
+#include <linux/kthread.h>
+
+#include "time_bench.h"
+
+static int verbose =3D 1;
+
+/** TSC (Time-Stamp Counter) based **
+ * See: linux/time_bench.h
+ *  tsc_start_clock() and tsc_stop_clock()
+ */
+
+/** Wall-clock based **
+ */
+
+/** PMU (Performance Monitor Unit) based **
+ */
+#define PERF_FORMAT                                                       =
     \
+	(PERF_FORMAT_GROUP | PERF_FORMAT_ID | PERF_FORMAT_TOTAL_TIME_ENABLED | \
+	 PERF_FORMAT_TOTAL_TIME_RUNNING)
+
+struct raw_perf_event {
+	uint64_t config; /* event */
+	uint64_t config1; /* umask */
+	struct perf_event *save;
+	char *desc;
+};
+
+/* if HT is enable a maximum of 4 events (5 if one is instructions
+ * retired can be specified, if HT is disabled a maximum of 8 (9 if
+ * one is instructions retired) can be specified.
+ *
+ * From Table 19-1. Architectural Performance Events
+ * Architectures Software Developer=E2=80=99s Manual Volume 3: System Prog=
ramming
+ * Guide
+ */
+struct raw_perf_event perf_events[] =3D {
+	{ 0x3c, 0x00, NULL, "Unhalted CPU Cycles" },
+	{ 0xc0, 0x00, NULL, "Instruction Retired" }
+};
+
+#define NUM_EVTS (ARRAY_SIZE(perf_events))
+
+/* WARNING: PMU config is currently broken!
+ */
+bool time_bench_PMU_config(bool enable)
+{
+	int i;
+	struct perf_event_attr perf_conf;
+	struct perf_event *perf_event;
+	int cpu;
+
+	preempt_disable();
+	cpu =3D smp_processor_id();
+	pr_info("DEBUG: cpu:%d\n", cpu);
+	preempt_enable();
+
+	memset(&perf_conf, 0, sizeof(struct perf_event_attr));
+	perf_conf.type           =3D PERF_TYPE_RAW;
+	perf_conf.size           =3D sizeof(struct perf_event_attr);
+	perf_conf.read_format    =3D PERF_FORMAT;
+	perf_conf.pinned         =3D 1;
+	perf_conf.exclude_user   =3D 1; /* No userspace events */
+	perf_conf.exclude_kernel =3D 0; /* Only kernel events */
+
+	for (i =3D 0; i < NUM_EVTS; i++) {
+		perf_conf.disabled =3D enable;
+		//perf_conf.disabled =3D (i =3D=3D 0) ? 1 : 0;
+		perf_conf.config   =3D perf_events[i].config;
+		perf_conf.config1  =3D perf_events[i].config1;
+		if (verbose)
+			pr_info("%s() enable PMU counter: %s\n",
+				__func__, perf_events[i].desc);
+		perf_event =3D perf_event_create_kernel_counter(&perf_conf, cpu,
+							      NULL /* task */,
+							      NULL /* overflow_handler*/,
+							      NULL /* context */);
+		if (perf_event) {
+			perf_events[i].save =3D perf_event;
+			pr_info("%s():DEBUG perf_event success\n", __func__);
+
+			perf_event_enable(perf_event);
+		} else {
+			pr_info("%s():DEBUG perf_event is NULL\n", __func__);
+		}
+	}
+
+	return true;
+}
+
+/** Generic functions **
+ */
+
+/* Calculate stats, store results in record */
+bool time_bench_calc_stats(struct time_bench_record *rec)
+{
+#define NANOSEC_PER_SEC 1000000000 /* 10^9 */
+	uint64_t ns_per_call_tmp_rem =3D 0;
+	uint32_t ns_per_call_remainder =3D 0;
+	uint64_t pmc_ipc_tmp_rem =3D 0;
+	uint32_t pmc_ipc_remainder =3D 0;
+	uint32_t pmc_ipc_div =3D 0;
+	uint32_t invoked_cnt_precision =3D 0;
+	uint32_t invoked_cnt =3D 0; /* 32-bit due to div_u64_rem() */
+
+	if (rec->flags & TIME_BENCH_LOOP) {
+		if (rec->invoked_cnt < 1000) {
+			pr_err("ERR: need more(>1000) loops(%llu) for timing\n",
+			       rec->invoked_cnt);
+			return false;
+		}
+		if (rec->invoked_cnt > ((1ULL << 32) - 1)) {
+			/* div_u64_rem() can only support div with 32bit*/
+			pr_err("ERR: Invoke cnt(%llu) too big overflow 32bit\n",
+			       rec->invoked_cnt);
+			return false;
+		}
+		invoked_cnt =3D (uint32_t)rec->invoked_cnt;
+	}
+
+	/* TSC (Time-Stamp Counter) records */
+	if (rec->flags & TIME_BENCH_TSC) {
+		rec->tsc_interval =3D rec->tsc_stop - rec->tsc_start;
+		if (rec->tsc_interval =3D=3D 0) {
+			pr_err("ABORT: timing took ZERO TSC time\n");
+			return false;
+		}
+		/* Calculate stats */
+		if (rec->flags & TIME_BENCH_LOOP)
+			rec->tsc_cycles =3D rec->tsc_interval / invoked_cnt;
+		else
+			rec->tsc_cycles =3D rec->tsc_interval;
+	}
+
+	/* Wall-clock time calc */
+	if (rec->flags & TIME_BENCH_WALLCLOCK) {
+		rec->time_start =3D rec->ts_start.tv_nsec +
+				  (NANOSEC_PER_SEC * rec->ts_start.tv_sec);
+		rec->time_stop =3D rec->ts_stop.tv_nsec +
+				 (NANOSEC_PER_SEC * rec->ts_stop.tv_sec);
+		rec->time_interval =3D rec->time_stop - rec->time_start;
+		if (rec->time_interval =3D=3D 0) {
+			pr_err("ABORT: timing took ZERO wallclock time\n");
+			return false;
+		}
+		/* Calculate stats */
+		/*** Division in kernel it tricky ***/
+		/* Orig: time_sec =3D (time_interval / NANOSEC_PER_SEC); */
+		/* remainder only correct because NANOSEC_PER_SEC is 10^9 */
+		rec->time_sec =3D div_u64_rem(rec->time_interval, NANOSEC_PER_SEC,
+					    &rec->time_sec_remainder);
+		//TODO: use existing struct timespec records instead of div?
+
+		if (rec->flags & TIME_BENCH_LOOP) {
+			/*** Division in kernel it tricky ***/
+			/* Orig: ns =3D ((double)time_interval / invoked_cnt); */
+			/* First get quotient */
+			rec->ns_per_call_quotient =3D
+				div_u64_rem(rec->time_interval, invoked_cnt,
+					    &ns_per_call_remainder);
+			/* Now get decimals .xxx precision (incorrect roundup)*/
+			ns_per_call_tmp_rem =3D ns_per_call_remainder;
+			invoked_cnt_precision =3D invoked_cnt / 1000;
+			if (invoked_cnt_precision > 0) {
+				rec->ns_per_call_decimal =3D
+					div_u64_rem(ns_per_call_tmp_rem,
+						    invoked_cnt_precision,
+						    &ns_per_call_remainder);
+			}
+		}
+	}
+
+	/* Performance Monitor Unit (PMU) counters */
+	if (rec->flags & TIME_BENCH_PMU) {
+		//FIXME: Overflow handling???
+		rec->pmc_inst =3D rec->pmc_inst_stop - rec->pmc_inst_start;
+		rec->pmc_clk =3D rec->pmc_clk_stop - rec->pmc_clk_start;
+
+		/* Calc Instruction Per Cycle (IPC) */
+		/* First get quotient */
+		rec->pmc_ipc_quotient =3D div_u64_rem(rec->pmc_inst, rec->pmc_clk,
+						    &pmc_ipc_remainder);
+		/* Now get decimals .xxx precision (incorrect roundup)*/
+		pmc_ipc_tmp_rem =3D pmc_ipc_remainder;
+		pmc_ipc_div =3D rec->pmc_clk / 1000;
+		if (pmc_ipc_div > 0) {
+			rec->pmc_ipc_decimal =3D div_u64_rem(pmc_ipc_tmp_rem,
+							   pmc_ipc_div,
+							   &pmc_ipc_remainder);
+		}
+	}
+
+	return true;
+}
+
+/* Generic function for invoking a loop function and calculating
+ * execution time stats.  The function being called/timed is assumed
+ * to perform a tight loop, and update the timing record struct.
+ */
+bool time_bench_loop(uint32_t loops, int step, char *txt, void *data,
+		     int (*func)(struct time_bench_record *record, void *data))
+{
+	struct time_bench_record rec;
+
+	/* Setup record */
+	memset(&rec, 0, sizeof(rec)); /* zero func might not update all */
+	rec.version_abi =3D 1;
+	rec.loops       =3D loops;
+	rec.step        =3D step;
+	rec.flags       =3D (TIME_BENCH_LOOP | TIME_BENCH_TSC | TIME_BENCH_WALLCL=
OCK);
+
+	/*** Loop function being timed ***/
+	if (!func(&rec, data)) {
+		pr_err("ABORT: function being timed failed\n");
+		return false;
+	}
+
+	if (rec.invoked_cnt < loops)
+		pr_warn("WARNING: Invoke count(%llu) smaller than loops(%d)\n",
+			rec.invoked_cnt, loops);
+
+	/* Calculate stats */
+	time_bench_calc_stats(&rec);
+
+	pr_info("Type:%s Per elem: %llu cycles(tsc) %llu.%03llu ns (step:%d) - (m=
easurement period time:%llu.%09u sec time_interval:%llu) - (invoke count:%l=
lu tsc_interval:%llu)\n",
+		txt, rec.tsc_cycles, rec.ns_per_call_quotient,
+		rec.ns_per_call_decimal, rec.step, rec.time_sec,
+		rec.time_sec_remainder, rec.time_interval, rec.invoked_cnt,
+		rec.tsc_interval);
+	if (rec.flags & TIME_BENCH_PMU)
+		pr_info("Type:%s PMU inst/clock%llu/%llu =3D %llu.%03llu IPC (inst per c=
ycle)\n",
+			txt, rec.pmc_inst, rec.pmc_clk, rec.pmc_ipc_quotient,
+			rec.pmc_ipc_decimal);
+	return true;
+}
+
+/* Function getting invoked by kthread */
+static int invoke_test_on_cpu_func(void *private)
+{
+	struct time_bench_cpu *cpu =3D private;
+	struct time_bench_sync *sync =3D cpu->sync;
+	cpumask_t newmask =3D CPU_MASK_NONE;
+	void *data =3D cpu->data;
+
+	/* Restrict CPU */
+	cpumask_set_cpu(cpu->rec.cpu, &newmask);
+	set_cpus_allowed_ptr(current, &newmask);
+
+	/* Synchronize start of concurrency test */
+	atomic_inc(&sync->nr_tests_running);
+	wait_for_completion(&sync->start_event);
+
+	/* Start benchmark function */
+	if (!cpu->bench_func(&cpu->rec, data)) {
+		pr_err("ERROR: function being timed failed on CPU:%d(%d)\n",
+		       cpu->rec.cpu, smp_processor_id());
+	} else {
+		if (verbose)
+			pr_info("SUCCESS: ran on CPU:%d(%d)\n", cpu->rec.cpu,
+				smp_processor_id());
+	}
+	cpu->did_bench_run =3D true;
+
+	/* End test */
+	atomic_dec(&sync->nr_tests_running);
+	/*  Wait for kthread_stop() telling us to stop */
+	while (!kthread_should_stop()) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule();
+	}
+	__set_current_state(TASK_RUNNING);
+	return 0;
+}
+
+void time_bench_print_stats_cpumask(const char *desc,
+				    struct time_bench_cpu *cpu_tasks,
+				    const struct cpumask *mask)
+{
+	uint64_t average =3D 0;
+	int cpu;
+	int step =3D 0;
+	struct sum {
+		uint64_t tsc_cycles;
+		int records;
+	} sum =3D { 0 };
+
+	/* Get stats */
+	for_each_cpu(cpu, mask) {
+		struct time_bench_cpu *c =3D &cpu_tasks[cpu];
+		struct time_bench_record *rec =3D &c->rec;
+
+		/* Calculate stats */
+		time_bench_calc_stats(rec);
+
+		pr_info("Type:%s CPU(%d) %llu cycles(tsc) %llu.%03llu ns (step:%d) - (me=
asurement period time:%llu.%09u sec time_interval:%llu) - (invoke count:%ll=
u tsc_interval:%llu)\n",
+			desc, cpu, rec->tsc_cycles, rec->ns_per_call_quotient,
+			rec->ns_per_call_decimal, rec->step, rec->time_sec,
+			rec->time_sec_remainder, rec->time_interval,
+			rec->invoked_cnt, rec->tsc_interval);
+
+		/* Collect average */
+		sum.records++;
+		sum.tsc_cycles +=3D rec->tsc_cycles;
+		step =3D rec->step;
+	}
+
+	if (sum.records) /* avoid div-by-zero */
+		average =3D sum.tsc_cycles / sum.records;
+	pr_info("Sum Type:%s Average: %llu cycles(tsc) CPUs:%d step:%d\n", desc,
+		average, sum.records, step);
+}
+
+void time_bench_run_concurrent(uint32_t loops, int step, void *data,
+			       const struct cpumask *mask, /* Support masking outsome CPUs*/
+			       struct time_bench_sync *sync,
+			       struct time_bench_cpu *cpu_tasks,
+			       int (*func)(struct time_bench_record *record, void *data))
+{
+	int cpu, running =3D 0;
+
+	if (verbose) // DEBUG
+		pr_warn("%s() Started on CPU:%d\n", __func__,
+			smp_processor_id());
+
+	/* Reset sync conditions */
+	atomic_set(&sync->nr_tests_running, 0);
+	init_completion(&sync->start_event);
+
+	/* Spawn off jobs on all CPUs */
+	for_each_cpu(cpu, mask) {
+		struct time_bench_cpu *c =3D &cpu_tasks[cpu];
+
+		running++;
+		c->sync =3D sync; /* Send sync variable along */
+		c->data =3D data; /* Send opaque along */
+
+		/* Init benchmark record */
+		memset(&c->rec, 0, sizeof(struct time_bench_record));
+		c->rec.version_abi =3D 1;
+		c->rec.loops       =3D loops;
+		c->rec.step        =3D step;
+		c->rec.flags       =3D (TIME_BENCH_LOOP | TIME_BENCH_TSC |
+				      TIME_BENCH_WALLCLOCK);
+		c->rec.cpu =3D cpu;
+		c->bench_func =3D func;
+		c->task =3D kthread_run(invoke_test_on_cpu_func, c,
+				      "time_bench%d", cpu);
+		if (IS_ERR(c->task)) {
+			pr_err("%s(): Failed to start test func\n", __func__);
+			return; /* Argh, what about cleanup?! */
+		}
+	}
+
+	/* Wait until all processes are running */
+	while (atomic_read(&sync->nr_tests_running) < running) {
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(10);
+	}
+	/* Kick off all CPU concurrently on completion event */
+	complete_all(&sync->start_event);
+
+	/* Wait for CPUs to finish */
+	while (atomic_read(&sync->nr_tests_running)) {
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(10);
+	}
+
+	/* Stop the kthreads */
+	for_each_cpu(cpu, mask) {
+		struct time_bench_cpu *c =3D &cpu_tasks[cpu];
+
+		kthread_stop(c->task);
+	}
+
+	if (verbose) // DEBUG - happens often, finish on another CPU
+		pr_warn("%s() Finished on CPU:%d\n", __func__,
+			smp_processor_id());
+}
diff --git a/tools/testing/selftests/net/bench/page_pool/time_bench.h b/too=
ls/testing/selftests/net/bench/page_pool/time_bench.h
new file mode 100644
index 000000000000..e113fcf341dc
--- /dev/null
+++ b/tools/testing/selftests/net/bench/page_pool/time_bench.h
@@ -0,0 +1,238 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Benchmarking code execution time inside the kernel
+ *
+ * Copyright (C) 2014, Red Hat, Inc., Jesper Dangaard Brouer
+ *  for licensing details see kernel-base/COPYING
+ */
+#ifndef _LINUX_TIME_BENCH_H
+#define _LINUX_TIME_BENCH_H
+
+/* Main structure used for recording a benchmark run */
+struct time_bench_record {
+	uint32_t version_abi;
+	uint32_t loops;		/* Requested loop invocations */
+	uint32_t step;		/* option for e.g. bulk invocations */
+
+	uint32_t flags;		/* Measurements types enabled */
+#define TIME_BENCH_LOOP		BIT(0)
+#define TIME_BENCH_TSC		BIT(1)
+#define TIME_BENCH_WALLCLOCK	BIT(2)
+#define TIME_BENCH_PMU		BIT(3)
+
+	uint32_t cpu; /* Used when embedded in time_bench_cpu */
+
+	/* Records */
+	uint64_t invoked_cnt;	/* Returned actual invocations */
+	uint64_t tsc_start;
+	uint64_t tsc_stop;
+	struct timespec64 ts_start;
+	struct timespec64 ts_stop;
+	/* PMU counters for instruction and cycles
+	 * instructions counter including pipelined instructions
+	 */
+	uint64_t pmc_inst_start;
+	uint64_t pmc_inst_stop;
+	/* CPU unhalted clock counter */
+	uint64_t pmc_clk_start;
+	uint64_t pmc_clk_stop;
+
+	/* Result records */
+	uint64_t tsc_interval;
+	uint64_t time_start, time_stop, time_interval; /* in nanosec */
+	uint64_t pmc_inst, pmc_clk;
+
+	/* Derived result records */
+	uint64_t tsc_cycles; // +decimal?
+	uint64_t ns_per_call_quotient, ns_per_call_decimal;
+	uint64_t time_sec;
+	uint32_t time_sec_remainder;
+	uint64_t pmc_ipc_quotient, pmc_ipc_decimal; /* inst per cycle */
+};
+
+/* For synchronizing parallel CPUs to run concurrently */
+struct time_bench_sync {
+	atomic_t nr_tests_running;
+	struct completion start_event;
+};
+
+/* Keep track of CPUs executing our bench function.
+ *
+ * Embed a time_bench_record for storing info per cpu
+ */
+struct time_bench_cpu {
+	struct time_bench_record rec;
+	struct time_bench_sync *sync; /* back ptr */
+	struct task_struct *task;
+	/* "data" opaque could have been placed in time_bench_sync,
+	 * but to avoid any false sharing, place it per CPU
+	 */
+	void *data;
+	/* Support masking outsome CPUs, mark if it ran */
+	bool did_bench_run;
+	/* int cpu; // note CPU stored in time_bench_record */
+	int (*bench_func)(struct time_bench_record *record, void *data);
+};
+
+/*
+ * Below TSC assembler code is not compatible with other archs, and
+ * can also fail on guests if cpu-flags are not correct.
+ *
+ * The way TSC reading is used, many iterations, does not require as
+ * high accuracy as described below (in Intel Doc #324264).
+ *
+ * Considering changing to use get_cycles() (#include <asm/timex.h>).
+ */
+
+/** TSC (Time-Stamp Counter) based **
+ * Recommend reading, to understand details of reading TSC accurately:
+ *  Intel Doc #324264, "How to Benchmark Code Execution Times on Intel"
+ *
+ * Consider getting exclusive ownership of CPU by using:
+ *   unsigned long flags;
+ *   preempt_disable();
+ *   raw_local_irq_save(flags);
+ *   _your_code_
+ *   raw_local_irq_restore(flags);
+ *   preempt_enable();
+ *
+ * Clobbered registers: "%rax", "%rbx", "%rcx", "%rdx"
+ *  RDTSC only change "%rax" and "%rdx" but
+ *  CPUID clears the high 32-bits of all (rax/rbx/rcx/rdx)
+ */
+static __always_inline uint64_t tsc_start_clock(void)
+{
+	/* See: Intel Doc #324264 */
+	unsigned int hi, lo;
+
+	asm volatile("CPUID\n\t"
+		     "RDTSC\n\t"
+		     "mov %%edx, %0\n\t"
+		     "mov %%eax, %1\n\t"
+		     : "=3Dr"(hi), "=3Dr"(lo)::"%rax", "%rbx", "%rcx", "%rdx");
+	//FIXME: on 32bit use clobbered %eax + %edx
+	return ((uint64_t)lo) | (((uint64_t)hi) << 32);
+}
+
+static __always_inline uint64_t tsc_stop_clock(void)
+{
+	/* See: Intel Doc #324264 */
+	unsigned int hi, lo;
+
+	asm volatile("RDTSCP\n\t"
+		     "mov %%edx, %0\n\t"
+		     "mov %%eax, %1\n\t"
+		     "CPUID\n\t"
+		     : "=3Dr"(hi), "=3Dr"(lo)::"%rax", "%rbx", "%rcx", "%rdx");
+	return ((uint64_t)lo) | (((uint64_t)hi) << 32);
+}
+
+/** Wall-clock based **
+ *
+ * use: getnstimeofday()
+ *  getnstimeofday(&rec->ts_start);
+ *  getnstimeofday(&rec->ts_stop);
+ *
+ * API changed see: Documentation/core-api/timekeeping.rst
+ *  https://www.kernel.org/doc/html/latest/core-api/timekeeping.html#c.get=
nstimeofday
+ *
+ * We should instead use: ktime_get_real_ts64() is a direct
+ *  replacement, but consider using monotonic time (ktime_get_ts64())
+ *  and/or a ktime_t based interface (ktime_get()/ktime_get_real()).
+ */
+
+/** PMU (Performance Monitor Unit) based **
+ *
+ * Needed for calculating: Instructions Per Cycle (IPC)
+ * - The IPC number tell how efficient the CPU pipelining were
+ */
+//lookup: perf_event_create_kernel_counter()
+
+bool time_bench_PMU_config(bool enable);
+
+/* Raw reading via rdpmc() using fixed counters
+ *
+ * From: https://github.com/andikleen/simple-pmu
+ */
+enum {
+	FIXED_SELECT =3D (1U << 30), /* =3D=3D 0x40000000 */
+	FIXED_INST_RETIRED_ANY =3D 0,
+	FIXED_CPU_CLK_UNHALTED_CORE =3D 1,
+	FIXED_CPU_CLK_UNHALTED_REF =3D 2,
+};
+
+static __always_inline unsigned int long long p_rdpmc(unsigned int in)
+{
+	unsigned int d, a;
+
+	asm volatile("rdpmc" : "=3Dd"(d), "=3Da"(a) : "c"(in) : "memory");
+	return ((unsigned long long)d << 32) | a;
+}
+
+/* These PMU counter needs to be enabled, but I don't have the
+ * configure code implemented.  My current hack is running:
+ *  sudo perf stat -e cycles:k -e instructions:k insmod lib/ring_queue_tes=
t.ko
+ */
+/* Reading all pipelined instruction */
+static __always_inline unsigned long long pmc_inst(void)
+{
+	return p_rdpmc(FIXED_SELECT | FIXED_INST_RETIRED_ANY);
+}
+
+/* Reading CPU clock cycles */
+static __always_inline unsigned long long pmc_clk(void)
+{
+	return p_rdpmc(FIXED_SELECT | FIXED_CPU_CLK_UNHALTED_CORE);
+}
+
+/* Raw reading via MSR rdmsr() is likely wrong
+ * FIXME: How can I know which raw MSR registers are conf for what?
+ */
+#define MSR_IA32_PCM0 0x400000C1 /* PERFCTR0 */
+#define MSR_IA32_PCM1 0x400000C2 /* PERFCTR1 */
+#define MSR_IA32_PCM2 0x400000C3
+static inline uint64_t msr_inst(unsigned long long *msr_result)
+{
+	return rdmsrq_safe(MSR_IA32_PCM0, msr_result);
+}
+
+/** Generic functions **
+ */
+bool time_bench_loop(uint32_t loops, int step, char *txt, void *data,
+		     int (*func)(struct time_bench_record *rec, void *data));
+bool time_bench_calc_stats(struct time_bench_record *rec);
+
+void time_bench_run_concurrent(uint32_t loops, int step, void *data,
+			       const struct cpumask *mask, /* Support masking outsome CPUs*/
+			       struct time_bench_sync *sync, struct time_bench_cpu *cpu_tasks,
+			       int (*func)(struct time_bench_record *record, void *data));
+void time_bench_print_stats_cpumask(const char *desc,
+				    struct time_bench_cpu *cpu_tasks,
+				    const struct cpumask *mask);
+
+//FIXME: use rec->flags to select measurement, should be MACRO
+static __always_inline void time_bench_start(struct time_bench_record *rec=
)
+{
+	//getnstimeofday(&rec->ts_start);
+	ktime_get_real_ts64(&rec->ts_start);
+	if (rec->flags & TIME_BENCH_PMU) {
+		rec->pmc_inst_start =3D pmc_inst();
+		rec->pmc_clk_start =3D pmc_clk();
+	}
+	rec->tsc_start =3D tsc_start_clock();
+}
+
+static __always_inline void time_bench_stop(struct time_bench_record *rec,
+					    uint64_t invoked_cnt)
+{
+	rec->tsc_stop =3D tsc_stop_clock();
+	if (rec->flags & TIME_BENCH_PMU) {
+		rec->pmc_inst_stop =3D pmc_inst();
+		rec->pmc_clk_stop =3D pmc_clk();
+	}
+	//getnstimeofday(&rec->ts_stop);
+	ktime_get_real_ts64(&rec->ts_stop);
+	rec->invoked_cnt =3D invoked_cnt;
+}
+
+#endif /* _LINUX_TIME_BENCH_H */
diff --git a/tools/testing/selftests/net/bench/test_bench_page_pool.sh b/to=
ols/testing/selftests/net/bench/test_bench_page_pool.sh
new file mode 100755
index 000000000000..7b8b18cfedce
--- /dev/null
+++ b/tools/testing/selftests/net/bench/test_bench_page_pool.sh
@@ -0,0 +1,32 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+
+set -e
+
+DRIVER=3D"./page_pool/bench_page_pool.ko"
+result=3D""
+
+function run_test()
+{
+	rmmod "bench_page_pool.ko" || true
+	insmod $DRIVER > /dev/null 2>&1
+	result=3D$(dmesg | tail -10)
+	echo "$result"
+
+	echo
+	echo "Fast path results:"
+	echo "${result}" | grep -o -E "no-softirq-page_pool01 Per elem: ([0-9]+) =
cycles\(tsc\) ([0-9]+\.[0-9]+) ns"
+
+	echo
+	echo "ptr_ring results:"
+	echo "${result}" | grep -o -E "no-softirq-page_pool02 Per elem: ([0-9]+) =
cycles\(tsc\) ([0-9]+\.[0-9]+) ns"
+
+	echo
+	echo "slow path results:"
+	echo "${result}" | grep -o -E "no-softirq-page_pool03 Per elem: ([0-9]+) =
cycles\(tsc\) ([0-9]+\.[0-9]+) ns"
+}
+
+run_test
+
+exit 0

base-commit: 8909f5f4ecd551c2299b28e05254b77424c8c7dc
--=20
2.50.0.rc1.591.g9c95f17f64-goog


