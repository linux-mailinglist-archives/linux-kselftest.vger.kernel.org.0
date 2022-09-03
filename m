Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C3A5ABE52
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Sep 2022 11:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiICJ52 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 3 Sep 2022 05:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiICJ51 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 3 Sep 2022 05:57:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841915A82A
        for <linux-kselftest@vger.kernel.org>; Sat,  3 Sep 2022 02:57:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C23AB82014
        for <linux-kselftest@vger.kernel.org>; Sat,  3 Sep 2022 09:57:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 474B1C433D7;
        Sat,  3 Sep 2022 09:57:21 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Shuah Khan <shuah@kernel.org>, Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Will Drewry <wad@chromium.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kselftest@vger.kernel.org,
        Huacai Chen <chenhuacai@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: [PATCH 2/2] selftests/seccomp: Add LoongArch selftesting support
Date:   Sat,  3 Sep 2022 17:55:07 +0800
Message-Id: <20220903095507.3425208-2-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220903095507.3425208-1-chenhuacai@loongson.cn>
References: <20220903095507.3425208-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

BPF for LoongArch is supported now, add the selftesting support in
seccomp_bpf.c.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 4ae6c8991307..e1c3b7d8ac39 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -128,6 +128,8 @@ struct seccomp_data {
 #  define __NR_seccomp 277
 # elif defined(__csky__)
 #  define __NR_seccomp 277
+# elif defined(__loongarch__)
+#  define __NR_seccomp 277
 # elif defined(__hppa__)
 #  define __NR_seccomp 338
 # elif defined(__powerpc__)
@@ -1751,6 +1753,10 @@ TEST_F(TRACE_poke, getpid_runs_normally)
 				    NT_ARM_SYSTEM_CALL, &__v));	\
 	} while (0)
 # define SYSCALL_RET(_regs)	(_regs).regs[0]
+#elif defined(__loongarch__)
+# define ARCH_REGS		struct user_pt_regs
+# define SYSCALL_NUM(_regs)	(_regs).regs[11]
+# define SYSCALL_RET(_regs)	(_regs).regs[4]
 #elif defined(__riscv) && __riscv_xlen == 64
 # define ARCH_REGS		struct user_regs_struct
 # define SYSCALL_NUM(_regs)	(_regs).a7
-- 
2.31.1

