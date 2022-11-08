Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2403C621D46
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 20:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiKHTxI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Nov 2022 14:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiKHTxD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Nov 2022 14:53:03 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DA8E17057F;
        Tue,  8 Nov 2022 11:53:00 -0800 (PST)
Received: from pwmachine.numericable.fr (85-170-25-210.rev.numericable.fr [85.170.25.210])
        by linux.microsoft.com (Postfix) with ESMTPSA id E1FAA20B9F80;
        Tue,  8 Nov 2022 11:52:56 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E1FAA20B9F80
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1667937180;
        bh=lfm7BTt/ROEPRbGDPE3vy0AJuoRZ1875JpNL6uMTfxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z6y0+aMF7SVBf0gFi1ICcf5FraX76ZRSz2ubkXhXtcPbw166bRHHw/TGxDIGh3txN
         SAQDO1pwq8hj3/PXrWZn3Uct6WoppsDGUInreNeOK8hBSmRrPvz9wrDBWvS0DhviDY
         94IRSMcmuNH0IJPuoG0eAXnRTi0XMLf+eQc/qjrE=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alban Crequy <alban.crequy@gmail.com>,
        Alban Crequy <albancrequy@microsoft.com>,
        Francis Laniel <flaniel@linux.microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        linux-mm@kvack.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [RFC PATCH v1 2/2] selftests: bpf: add a test when bpf_probe_read_kernel_str() returns EFAULT
Date:   Tue,  8 Nov 2022 20:52:07 +0100
Message-Id: <20221108195211.214025-3-flaniel@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221108195211.214025-1-flaniel@linux.microsoft.com>
References: <20221108195211.214025-1-flaniel@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Alban Crequy <albancrequy@microsoft.com>

This commit tests previous fix of bpf_probe_read_kernel_str().

Signed-off-by: Alban Crequy <albancrequy@microsoft.com>
Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
---
 tools/testing/selftests/bpf/prog_tests/varlen.c | 7 +++++++
 tools/testing/selftests/bpf/progs/test_varlen.c | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/varlen.c b/tools/testing/selftests/bpf/prog_tests/varlen.c
index dd324b4933db..4d7056f8f177 100644
--- a/tools/testing/selftests/bpf/prog_tests/varlen.c
+++ b/tools/testing/selftests/bpf/prog_tests/varlen.c
@@ -63,6 +63,13 @@ void test_varlen(void)
 	CHECK_VAL(data->total4, size1 + size2);
 	CHECK(memcmp(data->payload4, exp_str, size1 + size2), "content_check",
 	      "doesn't match!\n");
+
+	CHECK_VAL(bss->ret_bad_read, -EFAULT);
+	CHECK_VAL(data->payload_bad[0], 0x42);
+	CHECK_VAL(data->payload_bad[1], 0x42);
+	CHECK_VAL(data->payload_bad[2], 0);
+	CHECK_VAL(data->payload_bad[3], 0x42);
+	CHECK_VAL(data->payload_bad[4], 0x42);
 cleanup:
 	test_varlen__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_varlen.c b/tools/testing/selftests/bpf/progs/test_varlen.c
index 3987ff174f1f..20eb7d422c41 100644
--- a/tools/testing/selftests/bpf/progs/test_varlen.c
+++ b/tools/testing/selftests/bpf/progs/test_varlen.c
@@ -19,6 +19,7 @@ __u64 payload1_len1 = 0;
 __u64 payload1_len2 = 0;
 __u64 total1 = 0;
 char payload1[MAX_LEN + MAX_LEN] = {};
+__u64 ret_bad_read = 0;
 
 /* .data */
 int payload2_len1 = -1;
@@ -36,6 +37,8 @@ int payload4_len2 = -1;
 int total4= -1;
 char payload4[MAX_LEN + MAX_LEN] = { 1 };
 
+char payload_bad[5] = { 0x42, 0x42, 0x42, 0x42, 0x42 };
+
 SEC("raw_tp/sys_enter")
 int handler64_unsigned(void *regs)
 {
@@ -61,6 +64,8 @@ int handler64_unsigned(void *regs)
 
 	total1 = payload - (void *)payload1;
 
+	ret_bad_read = bpf_probe_read_kernel_str(payload_bad + 2, 1, (void *) -1);
+
 	return 0;
 }
 
-- 
2.25.1

