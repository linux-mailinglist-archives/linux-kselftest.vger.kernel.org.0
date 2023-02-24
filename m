Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D16D6A1DEC
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Feb 2023 16:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjBXPCV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Feb 2023 10:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjBXPCU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Feb 2023 10:02:20 -0500
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C8A3C79E;
        Fri, 24 Feb 2023 07:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1677250932;
        bh=LA4afhPqupsD7v+QF/v/WvgrLpshZrcgnJ7mYrdvPCY=;
        h=From:To:Cc:Subject:Date;
        b=CyL/ZXbSZFuHTRJVrQlcYyrmYpVaZbwP3ZOMPF+j807EMfTM2ryH08zfEg2WHvOZ7
         gvvoKMI8xFc/vTzGP2NrLoEy+x8pmOpOVD6FJiwAm/7RjCqZh+rijlzWYr4FNQ2tyy
         8Swr4gSX2BRG6odgNeWtqFWaa/DKCMgKvDsIR9IE=
Received: from rtoax.. ([111.199.188.149])
        by newxmesmtplogicsvrszc1-0.qq.com (NewEsmtp) with SMTP
        id 37AC28C; Fri, 24 Feb 2023 23:00:55 +0800
X-QQ-mid: xmsmtpt1677250855t1v5n31m6
Message-ID: <tencent_FC8827062142CF5936974B2A30AF6CA3C408@qq.com>
X-QQ-XMAILINFO: OaoBA5NOFC/jERj4t5+z6sdop7oR02lO5ZckqqdwgX1XuRFNP3eTf8Fp+lqg+f
         yjVrxMa33pgNJ7ZIBverHzbd/hwdvWggezH91axqw3mP33myBT0K3+8UWiVCaiL35OKM6jMjAUjz
         P1JAYSCviK+SYHFpuX1NrQ6tzqL5ScUmX/WyhMFOXsgdZYwJ2WQdFSVffDVE5W0T0njT2BrFkBOh
         P2hB5DE6QVdp+HyPmfyYJCPCollqnbKvMQRy0t7h4a6wLRYODjtUZe4lmwftvhukx8J5nh3pmPZ3
         wujjBlfpxmEj4nJvADeyAOzL0xqZKOnNuaLOOJ543hKe9jQiRLduBwi5eg/nRuN3FDQPN1xd4sVL
         rKnvO0Ae0Ck/dDWqyyoMdiNzLd4vTG1MMPmymtp9FHLDopBA46DGhzkvcYyxtpePFZOT6qCgzCUl
         6jc7E/Du0jqIYHHLLRyPbaz9/RHusbT/hOodhQ4q9nlCmEvTsw8xjhwSC/ZbxQlASbZDVm6WW3ji
         G9pmDoUIxgF4jiClNS/Yxfg1ZegkCjPsL8hcChDwbHwQ4NO9v5nc2s8qurrpTkl3T2laxsAq1jUB
         XKrJmy0u4CKx6crhSpJ3MmHyiH37hTShxTEUSyxf7cXePuDw0Dfd2jSlMT0oaTF1iMR8rVBTNMYG
         wsfFk1TOftHR9/4C6MgrfzQCuA92sRiGVGo4sUav7J2GbGb3L33HT0D6MGi/x+myC81qF4/h5a//
         bVIs2VkoN+a4Wj6GfTsESNRdY64T7BbUMMOjNYXJ6pLBRvOgaRCKhCrBUE8uHQ7BEzEWiCXZAyGh
         Qxrv82uh2+QVfgOMl3lMapy1JyO4Bg0piSHarWxbLo2mRZLH7/MAJ/SV/w499sCsyjktPhYKQQOh
         2dMPuAhvwgv6zP+QN4hI8Xmv8wCKRASIOZPGmjndtFm9JD+yybxWRN6K15yFL9Fa0qYoawVQwpSw
         bYo9yor5tgbc1MGCPwGDQZAOpnBH6vW81JNq3SlYwHivClTPEL7Q==
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
Subject: [PATCH bpf-next] selftests/bpf: Fix compilation errors: assign a value to a constant
Date:   Fri, 24 Feb 2023 23:00:53 +0800
X-OQ-MSGID: <20230224150054.577617-1-rtoax@foxmail.com>
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


