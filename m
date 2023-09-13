Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32CCB79E7E5
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Sep 2023 14:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240415AbjIMM1B (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Sep 2023 08:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240320AbjIMM1A (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Sep 2023 08:27:00 -0400
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6298019AC;
        Wed, 13 Sep 2023 05:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1694608017; x=1726144017;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:reply-to:mime-version:
   content-transfer-encoding;
  bh=N31oCUU7CHkmI4vyS7k5OHuBwDNqQwrdeueOu92um7M=;
  b=ZDQA5bMnR1OzmVVyqQQv3X9SwULIjvfA//mLcN5pIf51AuOXefg3TM9P
   BZFq7GBRO5DfTY1D5baDzMuEdIbseRoJdZ19o017wnhVJWfMzKK6GNOoY
   fcgbJqvwnZRB0ueLEVtxOm8olPu7aTeEc8yCky6fYmrfF2VsYKWXecM5O
   k=;
X-IronPort-AV: E=Sophos;i="6.02,143,1688428800"; 
   d="scan'208";a="356058087"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-96feee09.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 12:26:54 +0000
Received: from EX19D017EUA004.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1a-m6i4x-96feee09.us-east-1.amazon.com (Postfix) with ESMTPS id 4CF2C47E7A;
        Wed, 13 Sep 2023 12:26:49 +0000 (UTC)
Received: from dev-dsk-gerhorst-1c-a6f23d20.eu-west-1.amazon.com
 (10.15.21.113) by EX19D017EUA004.ant.amazon.com (10.252.50.239) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Wed, 13 Sep
 2023 12:26:42 +0000
From:   Luis Gerhorst <gerhorst@amazon.de>
To:     <alexei.starovoitov@gmail.com>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <haoluo@google.com>,
        <john.fastabend@gmail.com>, <jolsa@kernel.org>,
        <kpsingh@kernel.org>, <laoar.shao@gmail.com>,
        <martin.lau@linux.dev>, <sdf@google.com>, <song@kernel.org>,
        <yonghong.song@linux.dev>, <mykolal@fb.com>, <shuah@kernel.org>,
        <gerhorst@amazon.de>, <iii@linux.ibm.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Luis Gerhorst <gerhorst@cs.fau.de>
Subject: [PATCH 1/3] Revert "selftests/bpf: Add selftest for allow_ptr_leaks"
Date:   Wed, 13 Sep 2023 12:25:15 +0000
Message-ID: <20230913122514.89078-1-gerhorst@amazon.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <CAADnVQLid7QvukhnqRoY2VVFi1tCfkPFsMGUUeHDtCgf0SAJCg@mail.gmail.com>
References: <CAADnVQLid7QvukhnqRoY2VVFi1tCfkPFsMGUUeHDtCgf0SAJCg@mail.gmail.com>
Reply-To: <gerhorst@cs.fau.de>
MIME-Version: 1.0
X-Originating-IP: [10.15.21.113]
X-ClientProxiedBy: EX19D040UWA002.ant.amazon.com (10.13.139.113) To
 EX19D017EUA004.ant.amazon.com (10.252.50.239)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This reverts commit 0072e3624b463636c842ad8e261f1dc91deb8c78.

The test tests behavior which can not be permitted because of Spectre
v1. See the following commit

  Revert "bpf: Fix issue in verifying allow_ptr_leaks"

which reverts commit d75e30dddf73449bc2d10bb8e2f1a2c446bc67a2 for a
detailed description of the issue.

Reported-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Luis Gerhorst <gerhorst@amazon.de>
Signed-off-by: Luis Gerhorst <gerhorst@cs.fau.de>
---
 .../testing/selftests/bpf/prog_tests/tc_bpf.c | 36 +------------------
 .../testing/selftests/bpf/progs/test_tc_bpf.c | 13 -------
 2 files changed, 1 insertion(+), 48 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_bpf.c b/tools/testing/selftests/bpf/prog_tests/tc_bpf.c
index 48b55539331e..e873766276d1 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_bpf.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_bpf.c
@@ -3,7 +3,6 @@
 #include <test_progs.h>
 #include <linux/pkt_cls.h>
 
-#include "cap_helpers.h"
 #include "test_tc_bpf.skel.h"
 
 #define LO_IFINDEX 1
@@ -328,7 +327,7 @@ static int test_tc_bpf_api(struct bpf_tc_hook *hook, int fd)
 	return 0;
 }
 
-void tc_bpf_root(void)
+void test_tc_bpf(void)
 {
 	DECLARE_LIBBPF_OPTS(bpf_tc_hook, hook, .ifindex = LO_IFINDEX,
 			    .attach_point = BPF_TC_INGRESS);
@@ -394,36 +393,3 @@ void tc_bpf_root(void)
 	}
 	test_tc_bpf__destroy(skel);
 }
-
-void tc_bpf_non_root(void)
-{
-	struct test_tc_bpf *skel = NULL;
-	__u64 caps = 0;
-	int ret;
-
-	/* In case CAP_BPF and CAP_PERFMON is not set */
-	ret = cap_enable_effective(1ULL << CAP_BPF | 1ULL << CAP_NET_ADMIN, &caps);
-	if (!ASSERT_OK(ret, "set_cap_bpf_cap_net_admin"))
-		return;
-	ret = cap_disable_effective(1ULL << CAP_SYS_ADMIN | 1ULL << CAP_PERFMON, NULL);
-	if (!ASSERT_OK(ret, "disable_cap_sys_admin"))
-		goto restore_cap;
-
-	skel = test_tc_bpf__open_and_load();
-	if (!ASSERT_OK_PTR(skel, "test_tc_bpf__open_and_load"))
-		goto restore_cap;
-
-	test_tc_bpf__destroy(skel);
-
-restore_cap:
-	if (caps)
-		cap_enable_effective(caps, NULL);
-}
-
-void test_tc_bpf(void)
-{
-	if (test__start_subtest("tc_bpf_root"))
-		tc_bpf_root();
-	if (test__start_subtest("tc_bpf_non_root"))
-		tc_bpf_non_root();
-}
diff --git a/tools/testing/selftests/bpf/progs/test_tc_bpf.c b/tools/testing/selftests/bpf/progs/test_tc_bpf.c
index ef7da419632a..d28ca8d1f3d0 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_bpf.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_bpf.c
@@ -2,8 +2,6 @@
 
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
-#include <linux/if_ether.h>
-#include <linux/ip.h>
 
 /* Dummy prog to test TC-BPF API */
 
@@ -12,14 +10,3 @@ int cls(struct __sk_buff *skb)
 {
 	return 0;
 }
-
-/* Prog to verify tc-bpf without cap_sys_admin and cap_perfmon */
-SEC("tcx/ingress")
-int pkt_ptr(struct __sk_buff *skb)
-{
-	struct iphdr *iph = (void *)(long)skb->data + sizeof(struct ethhdr);
-
-	if ((long)(iph + 1) > (long)skb->data_end)
-		return 1;
-	return 0;
-}
-- 
2.40.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



