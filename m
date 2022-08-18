Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207245987FA
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Aug 2022 17:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344051AbiHRPvE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Aug 2022 11:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344438AbiHRPue (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Aug 2022 11:50:34 -0400
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2448B642D8;
        Thu, 18 Aug 2022 08:50:30 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4M7pf238j1z9v7Yh;
        Thu, 18 Aug 2022 23:27:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwAX5hHpWv5iycQwAA--.23244S3;
        Thu, 18 Aug 2022 16:30:13 +0100 (CET)
From:   roberto.sassu@huaweicloud.com
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        corbet@lwn.net, dhowells@redhat.com, jarkko@kernel.org,
        rostedt@goodmis.org, mingo@redhat.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, shuah@kernel.org
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        deso@posteo.net, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v12 01/10] bpf: Allow kfuncs to be used in LSM programs
Date:   Thu, 18 Aug 2022 17:29:20 +0200
Message-Id: <20220818152929.402605-2-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220818152929.402605-1-roberto.sassu@huaweicloud.com>
References: <20220818152929.402605-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwAX5hHpWv5iycQwAA--.23244S3
X-Coremail-Antispam: 1UD129KBjvdXoWruF15tF4kCFWUGF1kZFyxXwb_yoWfXrX_Cw
        4jg3WxArn8CFWIqa10kF4Sqry7Ka45tFn5uwn8KrZ3Jwn8G3yDAw1F9Fy3tFykX3y8Xw43
        tFn3CrZxtr17XjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbDxYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Jr0_Jr4l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r18M2
        8IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK
        021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F
        4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
        Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lw4CEc2x0rVAKj4
        xxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
        Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x
        0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWx
        JVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMI
        IF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxU7-txDUUU
        U
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAIBF1jj34W2AAIsH
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: KP Singh <kpsingh@kernel.org>

In preparation for the addition of new kfuncs, allow kfuncs defined in the
tracing subsystem to be used in LSM programs by mapping the LSM program
type to the TRACING hook.

Signed-off-by: KP Singh <kpsingh@kernel.org>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 kernel/bpf/btf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 903719b89238..e49b3b6d48ad 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7243,6 +7243,7 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
 	case BPF_PROG_TYPE_STRUCT_OPS:
 		return BTF_KFUNC_HOOK_STRUCT_OPS;
 	case BPF_PROG_TYPE_TRACING:
+	case BPF_PROG_TYPE_LSM:
 		return BTF_KFUNC_HOOK_TRACING;
 	case BPF_PROG_TYPE_SYSCALL:
 		return BTF_KFUNC_HOOK_SYSCALL;
-- 
2.25.1

