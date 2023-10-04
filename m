Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06427B7DD7
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Oct 2023 13:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbjJDLJY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Oct 2023 07:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242200AbjJDLJX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Oct 2023 07:09:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0A3A1;
        Wed,  4 Oct 2023 04:09:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C585C433C9;
        Wed,  4 Oct 2023 11:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696417760;
        bh=jGyGtT5hAh42qtvFtybeGnz3fQgWG1+/lAX0yi2x8O8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A2+JdAq5zMOxCIhi934DYXVOPUrdLAN0OhjgKkaF8dg3YRTPwRl1F3pfkomGYZgAQ
         EqzxEdPjNQwzhw7+Nz2HIQIEO05y1Ly1RhqO3Rxqh7444Wr7O16K8h/1YGcTL2Q2Pp
         6fYLNDX8mP90Stu3hpAAvpIykIDKAgihGY5cJqAGPXMFIpeLC85BTVWAYhtlwi7EdQ
         oh79sWjywQtALxIeAYreihREuB3lq2vDSgsrxxPK9D/Wc8Ghv0vrupLdrcOOFnjt6T
         WIqTb/NAoYWRS/DxRyb1GSMMvnMWl7y1oYN1zAhM7iHDTSmpAJ2sJM6RwsugbKY1Ft
         vut536vQASvAg==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Subject: [PATCH bpf 1/3] libbpf: Fix syscall access arguments on riscv
Date:   Wed,  4 Oct 2023 13:09:03 +0200
Message-Id: <20231004110905.49024-2-bjorn@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231004110905.49024-1-bjorn@kernel.org>
References: <20231004110905.49024-1-bjorn@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Alexandre Ghiti <alexghiti@rivosinc.com>

Since commit 08d0ce30e0e4 ("riscv: Implement syscall wrappers"), riscv
selects ARCH_HAS_SYSCALL_WRAPPER so let's use the generic implementation
of PT_REGS_SYSCALL_REGS().

Fixes: 08d0ce30e0e4 ("riscv: Implement syscall wrappers")
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 tools/lib/bpf/bpf_tracing.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index 3803479dbe10..1c13f8e88833 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -362,8 +362,6 @@ struct pt_regs___arm64 {
 #define __PT_PARM7_REG a6
 #define __PT_PARM8_REG a7
 
-/* riscv does not select ARCH_HAS_SYSCALL_WRAPPER. */
-#define PT_REGS_SYSCALL_REGS(ctx) ctx
 #define __PT_PARM1_SYSCALL_REG __PT_PARM1_REG
 #define __PT_PARM2_SYSCALL_REG __PT_PARM2_REG
 #define __PT_PARM3_SYSCALL_REG __PT_PARM3_REG
-- 
2.39.2

