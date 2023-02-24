Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9856A1E5C
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Feb 2023 16:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjBXPS4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Feb 2023 10:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjBXPSy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Feb 2023 10:18:54 -0500
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61EA682BF;
        Fri, 24 Feb 2023 07:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1677251925;
        bh=2DxjrJyKKTqbJ2x4ZMA0QnmzjpPwL2ed1Fn0QoMGueQ=;
        h=From:To:Cc:Subject:Date;
        b=w23xj9HzMuNVIKIvBoWVHYhq2h2pvg+N7/TxZBN1lihdjFWLx/UPmj7KpuUizXLuM
         ciUnxU3WgKrrcdkjE1EvlL+IVlSkzKe2QrYQsYEvbuPlL+2yzgI14mjU85NZWEYbyX
         2vuS1lCBby/upGErpEnVNJ461Mr7hW9Nelzey9oY=
Received: from rtoax.. ([111.199.188.149])
        by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
        id 28421E7C; Fri, 24 Feb 2023 23:10:04 +0800
X-QQ-mid: xmsmtpt1677251404tc788u33m
Message-ID: <tencent_CB281722B3C1BD504C16CDE586CACC2BE706@qq.com>
X-QQ-XMAILINFO: MaJhvnnz6ISsTeBvp4SdkfRgmLru8HT4dYD59XQa9InsFMrFkQCik7T6o584SR
         HrxnPWpBq7Q4iIIr6E+ZL3rBbfKFwE2UQu6L/bC+A1IQa4nFwqlwuHLS25Dto0/BycZ0upk449pR
         j9GB8EbSD1y/+T1VQceIjHmoPYBQgg3xK96JnaGLHErglPV2/uSD5Mhw5VmUJQlHsp3pfl9NNQ6X
         zAtzONR7dKRExHozzjUYfcAAOxetFZ0wxrAqzxVFmOZAxetpsNuPmQAv6N2R7zsHIOpz/BJo+heK
         w2+xrA9088q9tg63I8eYAHObwonvgWNNax6RlWKjcDHsLXrjY03gY32y29+auQpP0YWhYR6JDZ0K
         84rNRW/AhPleRO4uW/xrIdGOcHFpbZnd8BZmQEtkES/cjY24KhAwvS9T8zSxV2e6IhOkju4Mh8Ia
         iNDyz2VlE37TOjD0VdbU9U52HJbxNux6oA4YHY8cxjfRTtJoH5r2msar7L+W4fAy0HHYwGT+b9fO
         V8GKnjlhIxJmJwdE4nyQJRnVJGERijCSTedQWIX31EnCxG1VTBtoACMSjH5Xgzj5Ctt2zfpdqiTK
         NpWbj7in1ChjsHKdwmB1L5kwKp9t0n+USxbRPN78rfLTqs8bqKN8qSgwYsSPHPHYCo7PXwB1nhs4
         IP4hm04ujclsHRDTeVmVbj+CvLiOYtWJLVm7CtuHp8/tI0YX0AcM3RqkrjKeDbaZvDM/x6RnWxLK
         T5Qz95OvNAr0Hsn4XL/gN1sLPJwkzZzKQ9NFcxa0lmmjBhypZN4/FOOwLE6kVfionaD899bMX4Cs
         e7psJpvwIFVcFRLixdh5u/gmcw5Kb96+U7Gr0foDW/wC68X2DdMkKes616m5qAQzwmz6DwIwgdks
         lhF8/LimktzrJbWUsMX3DxqaTfyGH71uhghgX+Ofl3eNMtpkuq/VkLpZByVyr1y2lYYNHhLEELDP
         JSAZWWuEENoa9HTY175BDWnH9NHSueUvggdhVxjhWHdoppjAA3ZgC5tUlgnZkUjHOyPr3vG07BSn
         UUXrTTIVMm1FS3Yf3w
From:   Rong Tao <rtoax@foxmail.com>
To:     ast@kernel.org
Cc:     Rong Tao <rongtao@cestc.cn>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and
        Tools)),
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH bpf-next v2] selftests/bpf: Fix compilation errors: assign a value to a constant
Date:   Fri, 24 Feb 2023 23:10:02 +0800
X-OQ-MSGID: <20230224151002.579037-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

commit bc292ab00f6c("mm: introduce vma->vm_flags wrapper functions")
turns the vm_flags into a const variable.

Added bpf_find_vma test in commit f108662b27c9("selftests/bpf: Add tests
for bpf_find_vma") to assign values to variables that declare const in
find_vma_fail1.c programs, which is an error to the compiler and does not
test BPF verifiers. It is better to replace 'const vm_flags_t vm_flags'
with 'unsigned long vm_start' for testing.

    $ make -C tools/testing/selftests/bpf/ -j8
    ...
    progs/find_vma_fail1.c:16:16: error: cannot assign to non-static data
    member 'vm_flags' with const-qualified type 'const vm_flags_t' (aka
    'const unsigned long')
            vma->vm_flags |= 0x55;
            ~~~~~~~~~~~~~ ^
    ../tools/testing/selftests/bpf/tools/include/vmlinux.h:1898:20:
    note: non-static data member 'vm_flags' declared const here
                    const vm_flags_t vm_flags;
                    ~~~~~~~~~~~`~~~~~~^~~~~~~~

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
v2: Add more useful commit information
v1: https://lore.kernel.org/lkml/tencent_FC8827062142CF5936974B2A30AF6CA3C408@qq.com/
---
 tools/testing/selftests/bpf/progs/find_vma_fail1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/find_vma_fail1.c b/tools/testing/selftests/bpf/progs/find_vma_fail1.c
index b3b326b8e2d1..47d5dedff554 100644
--- a/tools/testing/selftests/bpf/progs/find_vma_fail1.c
+++ b/tools/testing/selftests/bpf/progs/find_vma_fail1.c
@@ -13,7 +13,7 @@ static long write_vma(struct task_struct *task, struct vm_area_struct *vma,
 		      struct callback_ctx *data)
 {
 	/* writing to vma, which is illegal */
-	vma->vm_flags |= 0x55;
+	vma->vm_start = 0xffffffffff600000;
 
 	return 0;
 }
-- 
2.39.2

