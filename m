Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFB2646034
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Dec 2022 18:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiLGR1S (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Dec 2022 12:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiLGR0q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Dec 2022 12:26:46 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC80A6D7C6;
        Wed,  7 Dec 2022 09:26:29 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4NS3tK3Vcyz9xHdQ;
        Thu,  8 Dec 2022 01:19:21 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwD34m9YzJBjc9DJAA--.62662S9;
        Wed, 07 Dec 2022 18:26:06 +0100 (CET)
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
Subject: [RFC][PATCH v2 7/7] selftests/bpf: Change return value in test_libbpf_get_fd_by_id_opts.c
Date:   Wed,  7 Dec 2022 18:24:34 +0100
Message-Id: <20221207172434.435893-8-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221207172434.435893-1-roberto.sassu@huaweicloud.com>
References: <20221207172434.435893-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwD34m9YzJBjc9DJAA--.62662S9
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw15Ar4xtry3Cr17uFWUCFg_yoW8ArW5pF
        WrXw1YkFZYgr1xu3W7JFWDGFySkFyxZayUXFW8JryDZr18XF4DJr18KF1Yqr98Gr4vgwsa
        vr4xKrWYkr18CaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgATBF1jj4JqpAAAso
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

In the no_alu32 version, the eBPF assembly looks like:

       0:	b7 00 00 00 00 00 00 00	r0 = 0
       1:	79 12 00 00 00 00 00 00	r2 = *(u64 *)(r1 + 0)
       2:	18 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00	r3 = 0 ll
       4:	5d 32 04 00 00 00 00 00	if r2 != r3 goto +4 <LBB0_2>
       5:	79 10 08 00 00 00 00 00	r0 = *(u64 *)(r1 + 8)
       6:	67 00 00 00 3e 00 00 00	r0 <<= 62
       7:	c7 00 00 00 3f 00 00 00	r0 s>>= 63
       8:	57 00 00 00 f3 ff ff ff	r0 &= -13

Unfortunately, ANDing of negative numbers is not yet supported in the
verifier. As a consequence, current bounds are lost in the AND operation,
resulting in estimating a positive return value, even if there isn't.

For now, return -EPERM instead of -EACCES, to remove the AND operation and
let the verifier know that the return value is legitimate (negative or
zero).

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 .../selftests/bpf/progs/test_libbpf_get_fd_by_id_opts.c    | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/test_libbpf_get_fd_by_id_opts.c b/tools/testing/selftests/bpf/progs/test_libbpf_get_fd_by_id_opts.c
index f5ac5f3e8919..a143dbbd5573 100644
--- a/tools/testing/selftests/bpf/progs/test_libbpf_get_fd_by_id_opts.c
+++ b/tools/testing/selftests/bpf/progs/test_libbpf_get_fd_by_id_opts.c
@@ -29,8 +29,13 @@ int BPF_PROG(check_access, struct bpf_map *map, fmode_t fmode)
 	if (map != (struct bpf_map *)&data_input)
 		return 0;
 
+	/*
+	 * Prefer -EPERM to -EACCES to avoid ANDing negative numbers in the
+	 * no_alu32 version, which results in the current register bounds to
+	 * be lost.
+	 */
 	if (fmode & FMODE_WRITE)
-		return -EACCES;
+		return -EPERM;
 
 	return 0;
 }
-- 
2.25.1

