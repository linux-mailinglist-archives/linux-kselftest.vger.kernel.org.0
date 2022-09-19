Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2931B5BCEB7
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Sep 2022 16:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiISO2v (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Sep 2022 10:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiISO2s (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Sep 2022 10:28:48 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572B326555;
        Mon, 19 Sep 2022 07:28:43 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4MWRj93TCkz9v7gQ;
        Mon, 19 Sep 2022 22:22:53 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwD3cl1vfChjLSJdAA--.62071S2;
        Mon, 19 Sep 2022 15:28:13 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     roberto.sassu@huaweicloud.com
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, deso@posteo.net, dhowells@redhat.com,
        haoluo@google.com, jarkko@kernel.org, jmorris@namei.org,
        joannelkoong@gmail.com, john.fastabend@gmail.com, jolsa@kernel.org,
        keyrings@vger.kernel.org, kpsingh@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, mingo@redhat.com, mykolal@fb.com,
        paul@paul-moore.com, roberto.sassu@huawei.com, rostedt@goodmis.org,
        sdf@google.com, serge@hallyn.com, shuah@kernel.org,
        song@kernel.org, yhs@fb.com
Subject: [PATCH v18 02/13] btf: Export bpf_dynptr definition
Date:   Mon, 19 Sep 2022 16:27:54 +0200
Message-Id: <20220919142754.626564-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <64e8ef59363bcd0f314d4e1eb7483f4dd2b7dbcf.camel@huaweicloud.com>
References: <64e8ef59363bcd0f314d4e1eb7483f4dd2b7dbcf.camel@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwD3cl1vfChjLSJdAA--.62071S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw47JF4UCFy5JFyxurWUCFg_yoW8Zr1rpa
        1rG39Fyr4vqFyI9w1UAr4093ySyw4kX347CFyvv3yYvrsIqFyqvF4jkr43Wr95trWDWFWY
        kF4agr4Yva4UZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9a14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJV
        WxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
        0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
        zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
        4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_
        WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJr
        UvcSsGvfC2KfnxnUUI43ZEXa7VUUbAw7UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAABF1jj4M4lgADsa
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

eBPF dynamic pointers is a new feature recently added to upstream. It binds
together a pointer to a memory area and its size. The internal kernel
structure bpf_dynptr_kern is not accessible by eBPF programs in user space.
They instead see bpf_dynptr, which is then translated to the internal
kernel structure by the eBPF verifier.

The problem is that it is not possible to include at the same time the uapi
include linux/bpf.h and the vmlinux BTF vmlinux.h, as they both contain the
definition of some structures/enums. The compiler complains saying that the
structures/enums are redefined.

As bpf_dynptr is defined in the uapi include linux/bpf.h, this makes it
impossible to include vmlinux.h. However, in some cases, e.g. when using
kfuncs, vmlinux.h has to be included. The only option until now was to
include vmlinux.h and add the definition of bpf_dynptr directly in the eBPF
program source code from linux/bpf.h.

Solve the problem by using the same approach as for bpf_timer (which also
follows the same scheme with the _kern suffix for the internal kernel
structure).

Add the following line in one of the dynamic pointer helpers,
bpf_dynptr_from_mem():

BTF_TYPE_EMIT(struct bpf_dynptr);

Cc: stable@vger.kernel.org
Cc: Joanne Koong <joannelkoong@gmail.com>
Fixes: 97e03f521050c ("bpf: Add verifier support for dynptrs")
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 kernel/bpf/helpers.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 41aeaf3862ec..7ce1f583b929 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1446,6 +1446,8 @@ BPF_CALL_4(bpf_dynptr_from_mem, void *, data, u32, size, u64, flags, struct bpf_
 {
 	int err;
 
+	BTF_TYPE_EMIT(struct bpf_dynptr);
+
 	err = bpf_dynptr_check_size(size);
 	if (err)
 		goto error;
-- 
2.25.1

