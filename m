Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB087646030
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Dec 2022 18:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiLGR1I (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Dec 2022 12:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiLGR0c (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Dec 2022 12:26:32 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2718561529;
        Wed,  7 Dec 2022 09:26:19 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4NS3t45s8mz9xqcF;
        Thu,  8 Dec 2022 01:19:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwD34m9YzJBjc9DJAA--.62662S8;
        Wed, 07 Dec 2022 18:25:56 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, revest@chromium.org,
        jackmanb@chromium.org, mykolal@fb.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, shuah@kernel.org
Cc:     bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH v2 6/7] selftests/bpf: Prevent positive ret values in test_lsm and verify_pkcs7_sig
Date:   Wed,  7 Dec 2022 18:24:33 +0100
Message-Id: <20221207172434.435893-7-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221207172434.435893-1-roberto.sassu@huaweicloud.com>
References: <20221207172434.435893-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwD34m9YzJBjc9DJAA--.62662S8
X-Coremail-Antispam: 1UD129KBjvJXoW7uFy5Cw1UGrW3ZF13WFykXwb_yoW8ZFyfpF
        yvg3Z0krWSgF13XF17Cws7XF4fKFs7Xa4FyayxXry3Zwn7JryxXr48KrW5Wrn0krWF9r93
        Zay2ga1avr18AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPlb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262
        kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
        6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GF
        v_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvE
        c7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
        AFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZF
        pf9x07j7GYLUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQATBF1jj4ZorQAAsk
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Modify test_lsm and verify_pkcs7_sig to ensure that they don't return
positive values.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 tools/testing/selftests/bpf/progs/lsm.c               |  4 ++++
 .../selftests/bpf/progs/test_verify_pkcs7_sig.c       | 11 +++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/lsm.c b/tools/testing/selftests/bpf/progs/lsm.c
index d8d8af623bc2..42252750d866 100644
--- a/tools/testing/selftests/bpf/progs/lsm.c
+++ b/tools/testing/selftests/bpf/progs/lsm.c
@@ -88,6 +88,10 @@ SEC("lsm/file_mprotect")
 int BPF_PROG(test_int_hook, struct vm_area_struct *vma,
 	     unsigned long reqprot, unsigned long prot, int ret)
 {
+	/* file_mprotect hook must return zero or negative values. */
+	if (ret > 0)
+		ret = -EINVAL;
+
 	if (ret != 0)
 		return ret;
 
diff --git a/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c b/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c
index ce419304ff1f..d3cab4370f29 100644
--- a/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c
+++ b/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c
@@ -42,14 +42,14 @@ struct {
 char _license[] SEC("license") = "GPL";
 
 SEC("lsm.s/bpf")
-int BPF_PROG(bpf, int cmd, union bpf_attr *attr, unsigned int size)
+s64 BPF_PROG(bpf, int cmd, union bpf_attr *attr, unsigned int size)
 {
 	struct bpf_dynptr data_ptr, sig_ptr;
 	struct data *data_val;
 	struct bpf_key *trusted_keyring;
 	__u32 pid;
 	__u64 value;
-	int ret, zero = 0;
+	s64 ret, zero = 0;
 
 	pid = bpf_get_current_pid_tgid() >> 32;
 	if (pid != monitored_pid)
@@ -86,5 +86,12 @@ int BPF_PROG(bpf, int cmd, union bpf_attr *attr, unsigned int size)
 
 	bpf_key_put(trusted_keyring);
 
+	/*
+	 * bpf hook must return zero or negative values, use s64 to propagate
+	 * the bounds to R0.
+	 */
+	if (ret > 0)
+		return -EINVAL;
+
 	return ret;
 }
-- 
2.25.1

