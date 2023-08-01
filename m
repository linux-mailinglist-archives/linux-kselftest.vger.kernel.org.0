Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3981276AFC2
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 11:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbjHAJuF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 05:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233510AbjHAJtw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 05:49:52 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75575198B;
        Tue,  1 Aug 2023 02:49:13 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RFVfK5Grdz1GDQd;
        Tue,  1 Aug 2023 17:48:09 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 1 Aug
 2023 17:49:09 +0800
From:   Ruan Jinjie <ruanjinjie@huawei.com>
To:     <Ast@kernel.org>, <Daniel@iogearbox.net>, <Andrii@kernel.org>,
        <Martin.lau@linux.dev>, <Song@kernel.org>,
        <Yonghong.song@linux.dev>, <John.fastabend@gmail.com>,
        <Kpsingh@kernel.org>, <Sdf@google.com>, <Haoluo@google.com>,
        <Jolsa@kernel.org>, <Mykolal@fb.com>, <Shuah@kernel.org>,
        <Benjamin.tissoires@redhat.com>, <Asavkov@redhat.com>,
        <Memxor@gmail.com>, <Iii@linux.ibm.com>, <Colin.i.king@gmail.com>,
        <Awkrail01@gmail.com>, <Rdunlap@infradead.org>,
        <Joannelkoong@gmail.com>, <bpf@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH bpf-next v3] selftests/bpf: replace fall through comment by fallthrough pseudo-keyword
Date:   Tue, 1 Aug 2023 17:48:33 +0800
Message-ID: <20230801094833.4146816-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Replace the existing /* fall through */ comments with the
new pseudo-keyword macro fallthrough[1].

[1] https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
v3:
- Update the subject prefix and fix the 'fallthrough' undeclared build error.
---
v2:
- Update the subject and commit message.
---
 tools/testing/selftests/bpf/prog_tests/kfunc_call.c          | 4 ++--
 tools/testing/selftests/bpf/progs/test_cls_redirect.c        | 2 +-
 tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c | 2 +-
 tools/testing/selftests/bpf/test_verifier.c                  | 3 ++-
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
index a543742cd7bd..0fd08172965a 100644
--- a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
+++ b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
@@ -101,7 +101,7 @@ static void verify_success(struct kfunc_test_params *param)
 	case syscall_test:
 		topts.ctx_in = &args;
 		topts.ctx_size_in = sizeof(args);
-		/* fallthrough */
+		fallthrough;
 	case syscall_null_ctx_test:
 		break;
 	case tc_test:
@@ -167,7 +167,7 @@ static void verify_fail(struct kfunc_test_params *param)
 	case syscall_test:
 		topts.ctx_in = &args;
 		topts.ctx_size_in = sizeof(args);
-		/* fallthrough */
+		fallthrough;
 	case syscall_null_ctx_test:
 		break;
 	case tc_test:
diff --git a/tools/testing/selftests/bpf/progs/test_cls_redirect.c b/tools/testing/selftests/bpf/progs/test_cls_redirect.c
index 66b304982245..f97960759558 100644
--- a/tools/testing/selftests/bpf/progs/test_cls_redirect.c
+++ b/tools/testing/selftests/bpf/progs/test_cls_redirect.c
@@ -300,7 +300,7 @@ bool pkt_skip_ipv6_extension_headers(buf_t *pkt,
 		case IPPROTO_FRAGMENT:
 			*is_fragment = true;
 			/* NB: We don't check that hdrlen == 0 as per spec. */
-			/* fallthrough; */
+			fallthrough;
 
 		case IPPROTO_HOPOPTS:
 		case IPPROTO_ROUTING:
diff --git a/tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c b/tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c
index f41c81212ee9..54dbf307c692 100644
--- a/tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c
+++ b/tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c
@@ -204,7 +204,7 @@ static bool pkt_skip_ipv6_extension_headers(struct bpf_dynptr *dynptr, __u64 *of
 		case IPPROTO_FRAGMENT:
 			*is_fragment = true;
 			/* NB: We don't check that hdrlen == 0 as per spec. */
-			/* fallthrough; */
+			fallthrough;
 
 		case IPPROTO_HOPOPTS:
 		case IPPROTO_ROUTING:
diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 31f1c935cd07..8f2e3852c207 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -28,6 +28,7 @@
 #include <linux/bpf.h>
 #include <linux/if_ether.h>
 #include <linux/btf.h>
+#include <linux/compiler.h>
 
 #include <bpf/btf.h>
 #include <bpf/bpf.h>
@@ -1289,7 +1290,7 @@ static int do_prog_test_run(int fd_prog, bool unpriv, uint32_t expected_val,
 				printf("Did not run the program (no permission) ");
 				return 0;
 			}
-			/* fallthrough; */
+			fallthrough;
 		default:
 			printf("FAIL: Unexpected bpf_prog_test_run error (%s) ",
 				strerror(saved_errno));
-- 
2.34.1

