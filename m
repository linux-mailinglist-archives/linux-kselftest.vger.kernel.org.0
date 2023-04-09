Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A6E6DBF30
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Apr 2023 10:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjDIIXv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 9 Apr 2023 04:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjDIIXv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 9 Apr 2023 04:23:51 -0400
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15624EF5
        for <linux-kselftest@vger.kernel.org>; Sun,  9 Apr 2023 01:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1681028625;
        bh=1BlGx1afgSOPlmGiINyQ3UClfYQu3kEy3LXJFKQ8+FY=;
        h=From:To:Cc:Subject:Date;
        b=xI5k2sn9e5sDUowze+QyprFDNHSaLVmT4aLeZotttkN3ypi2jLfVrTMex6KHWftqw
         SDcJmwuc780nme8vL74csulMK03ESQhZtLi8y2cgqCoSEbxgUPn+GStvUa7XraX+0s
         QF/CgwqVs7Sj+DkXPG7M94Kud+iQFnUF2KzKxdMc=
Received: from rtoax.. ([111.199.190.121])
        by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
        id 3DB170ED; Sun, 09 Apr 2023 16:15:27 +0800
X-QQ-mid: xmsmtpt1681028127ta0a5h3cn
Message-ID: <tencent_0D62BF818D106C96C26594CAC76BF3281306@qq.com>
X-QQ-XMAILINFO: Mi0NhBPPe/4R2b23CkWNOcjl6/zGeo8g7OI8JOhvvNufzVBxQ0jK6neRCgu1m5
         aBnJqPQx16B8w2KUDIsUycPw/kqP+Zm8ZL4x6kXtwmon0hzTcQ1RI2oAEc0bJ5KdwFRRu+0dlkEo
         txb/5ZSo7AWb7j9O3jgNMMUHK22+83SvlRZ0djb05mP2txPDS/YcGvlr/8aLHEaljN25aUtdBM7t
         ltlZVinkp4vcedUcCPsRfk1aSgYoJtLinSQmLB09/0RKM3ZJYXpuY1XJiXu4DKbtuIYQrqvceal/
         D6MCY8Ir3GLHImrbvdZnzNXtUoQQOpyxlmJM91me/zteJVt8uYnhSsEvYlB8snxXWEZyX1Ijcwbi
         B2EQPW+GWob2hme/A5+2HYyHVXVCrXaFD4thxhY+k/eSUXER5TlLgdKRgaye0ZIoTylhQGho9HRw
         cftPcqzFQRpiM3OBt7trUa5sEnfo5Z/ufymc+uzcyrQgERSY3VOH4E6dSA5cJAMcsQX4M9nUN7Dg
         XOYp6x3evulsK3uhcc1r1zBRyFi/TJjCVENFY6wU3ZCpBWJ3rmCn6erq2IK64FVrrrf7vldwv/r2
         P68uCwlEQGLc/so809fCD3GSh37P0kWIus5dPAIdDMBkVf3UazfwwdotVd2YY5iL5vOFtBxUTfj5
         q4DPpluLl5acQ67ZcG/TahwibDVyiQAKKLb64GDt6iu/JpcBwcmCi7oh5yFOlqlEr8lzz0+ovyhH
         EpHWM7hkewFeoZAeHCc19Vhi47Vm8chNOd43rIz8WBMktSjVG2X62i1Aek8BLnKRtXkUNG1CaANH
         vydtQ5HnxMdHeMFcmD/Q0Cfeuz2FEthh7sB4naa5n3j5TgpKVY5pjuGl2hBQLl1pAGhW38FhAXx5
         vRc5voteBdRR/ZHv3cY7cKi5RQThSTojAOQRFcNJEedX5pwSOK9S/kvWaeMv19hhuElGhyth8+ld
         yZAG19VhsFpNqeYNwc+LzKwzW3szYEmCm8goERRJ2C6UI++iXBQA==
From:   Rong Tao <rtoax@foxmail.com>
To:     ast@kernel.org
Cc:     rongtao@cestc.cn, Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and
        Tools)),
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH bpf-next] selftests/bpf: trace_helpers.c: Fix segfault
Date:   Sun,  9 Apr 2023 16:15:25 +0800
X-OQ-MSGID: <20230409081525.182264-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,
        RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

When the number of symbols is greater than MAX_SYMS (300000), the access
array struct ksym syms[MAX_SYMS] goes out of bounds, which will result in
a segfault.

Resolve this issue by judging the maximum number and exiting the loop, and
increasing the default size appropriately. (6.2.9 = 329839 below)

    $ cat /proc/kallsyms | wc -l
    329839

    GDB debugging:
    $ cd linux/samples/bpf
    $ sudo gdb ./sampleip
    ...
    (gdb) r
    ...
    Program received signal SIGSEGV, Segmentation fault.
    0x00007ffff7e2debf in malloc () from /lib64/libc.so.6
    Missing separate debuginfos, use: dnf debuginfo-install
    elfutils-libelf-0.189-1.fc37.x86_64 glibc-2.36-9.fc37.x86_64
    libzstd-1.5.4-1.fc37.x86_64 zlib-1.2.12-5.fc37.x86_64
    (gdb) bt
    #0  0x00007ffff7e2debf in malloc () from /lib64/libc.so.6
    #1  0x00007ffff7e33f8e in strdup () from /lib64/libc.so.6
    #2  0x0000000000403fb0 in load_kallsyms_refresh() from trace_helpers.c
    #3  0x00000000004038b2 in main ()

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 tools/testing/selftests/bpf/trace_helpers.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index 09a16a77bae4..a9d589c560d2 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -14,7 +14,7 @@
 
 #define DEBUGFS "/sys/kernel/debug/tracing/"
 
-#define MAX_SYMS 300000
+#define MAX_SYMS 400000
 static struct ksym syms[MAX_SYMS];
 static int sym_cnt;
 
@@ -44,7 +44,8 @@ int load_kallsyms_refresh(void)
 			continue;
 		syms[i].addr = (long) addr;
 		syms[i].name = strdup(func);
-		i++;
+		if (++i >= MAX_SYMS)
+			break;
 	}
 	fclose(f);
 	sym_cnt = i;
-- 
2.39.2

