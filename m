Return-Path: <linux-kselftest+bounces-7702-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7E98A148E
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 14:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 522B21C22805
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 12:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19DF14F9E2;
	Thu, 11 Apr 2024 12:24:54 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8556D14C58E;
	Thu, 11 Apr 2024 12:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712838294; cv=none; b=Oah5AM9iBkOJkUjieSLbtuA40KTCoeiRUBxdrt+EG/y0Hb1Y9ix2bNllurLR5Sxs8uTQcdsI+aQ1+/fW5yDfQTBg7e53BFSSgxVUUCINXvs2qq1TkVigS6f91OI7xlMNTWDc5/xecmncxANXR3u6MtqfmdU2e1t+3KHC4OeqmPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712838294; c=relaxed/simple;
	bh=7wRPyiijTTGAood9GVZT6zaerpy6Jchgb4iGjZRVSao=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oGiN2UT8SKh3qaTgqmGKfj4Yw5n9Hs1wS3hzo2IpJAhlTKFw4yOqXMvML7OGIZTjy68h/s2ufoRsKfvhe7TusQ/MTIKPfhEpyR2i8IX9lVt4zOvcGnBEPi4N1zUuhBdBKk9sgIdMgJO0bLUDm7eWt5NxirJf/geGch+TPv21Mbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VFf5h1h4Cz4f3kjW;
	Thu, 11 Apr 2024 20:24:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1BE6D1A0568;
	Thu, 11 Apr 2024 20:24:47 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP4 (Coremail) with SMTP id gCh0CgA3h2mJ1hdmZ5R_Jw--.23051S13;
	Thu, 11 Apr 2024 20:24:46 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Brendan Jackman <jackmanb@chromium.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Khadija Kamran <kamrankhadijadj@gmail.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	John Johansen <john.johansen@canonical.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf-next v3 11/11] selftests/bpf: Add verifier tests for bpf lsm
Date: Thu, 11 Apr 2024 20:27:52 +0800
Message-Id: <20240411122752.2873562-12-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240411122752.2873562-1-xukuohai@huaweicloud.com>
References: <20240411122752.2873562-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA3h2mJ1hdmZ5R_Jw--.23051S13
X-Coremail-Antispam: 1UD129KBjvJXoW3JFy8ZryxZF13Gry3Jry3XFb_yoW7Ar45pr
	97K3s7uF9Yyr9Igr1xCFWUuFyfGFs2qryrXF4Fvr15AF4xJrnrGrZ7Ww1UXrn3Jan3uwn0
	va12yay3ur1UA3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAI
	cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2js
	IEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUFgAwUUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

Add verifier tests to check bpf lsm return values and disabled hooks.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   3 +-
 .../selftests/bpf/progs/verifier_lsm.c        | 155 ++++++++++++++++++
 2 files changed, 157 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_lsm.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index c4f9f306646e..07398846085c 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -84,6 +84,7 @@
 #include "verifier_xadd.skel.h"
 #include "verifier_xdp.skel.h"
 #include "verifier_xdp_direct_packet_access.skel.h"
+#include "verifier_lsm.skel.h"
 
 #define MAX_ENTRIES 11
 
@@ -196,8 +197,8 @@ void test_verifier_value_illegal_alu(void)    { RUN(verifier_value_illegal_alu);
 void test_verifier_value_or_null(void)        { RUN(verifier_value_or_null); }
 void test_verifier_var_off(void)              { RUN(verifier_var_off); }
 void test_verifier_xadd(void)                 { RUN(verifier_xadd); }
-void test_verifier_xdp(void)                  { RUN(verifier_xdp); }
 void test_verifier_xdp_direct_packet_access(void) { RUN(verifier_xdp_direct_packet_access); }
+void test_verifier_lsm(void)                  { RUN(verifier_lsm); }
 
 static int init_test_val_map(struct bpf_object *obj, char *map_name)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_lsm.c b/tools/testing/selftests/bpf/progs/verifier_lsm.c
new file mode 100644
index 000000000000..005f28eebf71
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_lsm.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+SEC("lsm/file_alloc_security")
+__description("lsm bpf prog exit with valid return code. test 1")
+__success
+__naked int return_code_vaild_test1(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("lsm/file_alloc_security")
+__description("lsm bpf prog exit with valid return code. test 2")
+__success
+__naked int return_code_vaild_test2(void)
+{
+	asm volatile ("					\
+	r0 = -4095;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("lsm/file_alloc_security")
+__description("lsm bpf prog exit with valid return code. test 3")
+__success
+__naked int return_code_vaild_test3(void)
+{
+	asm volatile ("                                 \
+	call %[bpf_get_prandom_u32];                    \
+	r0 <<= 63;                                      \
+	r0 s>>= 63;                                     \
+	r0 &= -13;                                      \
+	exit;                                           \
+	"      :
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("lsm/vm_enough_memory")
+__description("lsm bpf prog exit with valid return code. test 4")
+__success
+__naked int return_code_vaild_test4(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("lsm/vm_enough_memory")
+__description("lsm bpf prog exit with valid return code. test 5")
+__success
+__naked int return_code_vaild_test5(void)
+{
+	asm volatile ("					\
+	r0 = -4096;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("lsm/vm_enough_memory")
+__description("lsm bpf prog exit with valid return code. test 6")
+__success
+__naked int return_code_vaild_test6(void)
+{
+	asm volatile ("					\
+	r0 = 4096;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("lsm/file_free_security")
+__description("lsm bpf prog exit with valid return code. test 7")
+__success
+__naked void return_code_vaild_test7(void)
+{
+	asm volatile ("					\
+	r0 = -4096;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("lsm/file_free_security")
+__description("lsm bpf prog exit with valid return code. test 8")
+__success
+__naked void return_code_vaild_test8(void)
+{
+	asm volatile ("					\
+	r0 = 4096;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("lsm/file_alloc_security")
+__description("lsm bpf prog exit with invalid return code. test 1")
+__failure __msg("R0 has smin=1 smax=1 should have been in [-4095, 0]")
+__naked int return_code_invalid_test1(void)
+{
+	asm volatile ("					\
+	r0 = 1;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("lsm/file_alloc_security")
+__description("lsm bpf prog exit with invalid return code. test 2")
+__failure __msg("R0 has smin=-4096 smax=-4096 should have been in [-4095, 0]")
+__naked int return_code_invalid_test2(void)
+{
+	asm volatile ("					\
+	r0 = -4096;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("lsm/getprocattr")
+__description("lsm disabled hook: getprocattr")
+__failure __msg("points to disabled bpf lsm hook")
+__naked int disabled_hook_test1(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("lsm/setprocattr")
+__description("lsm disabled hook: setprocattr")
+__failure __msg("points to disabled bpf lsm hook")
+__naked int disabled_hook_test2(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("lsm/ismaclabel")
+__description("lsm disabled hook: ismaclabel")
+__failure __msg("points to disabled bpf lsm hook")
+__naked int disabled_hook_test3(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.30.2


