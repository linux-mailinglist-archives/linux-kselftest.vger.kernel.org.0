Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2117B7DD9
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Oct 2023 13:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242209AbjJDLJ1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Oct 2023 07:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242200AbjJDLJ0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Oct 2023 07:09:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B76A6;
        Wed,  4 Oct 2023 04:09:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D630FC433CA;
        Wed,  4 Oct 2023 11:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696417763;
        bh=WpGCVlyEgOw4b2FaJcUO9+9LMMvSL9a+ezCXN7JxYNk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V5k4ZMhEzkCz2qXAkxEoYJrNjM1+W8E/LToiXc3tpQtiJGUS/7/LCJrOpti+PO+b5
         1emXGUbnb/Aj5AIejFtuvRfYRSBkNYeKFihj0u0vSEZfP4fFbXxqiS50u/vtsn6G4p
         O3QeOz7VFOYQmT2uyv9GmaVJeyI87MHAEcoA6xOrrd70E8/KUYRpKmCxg5sNFlkzEt
         2Yy2ySLGpFJLwu9mUxH2W/4mNqMBwqa3EsRtwAbMEKtwXvhL9+Un6pqgLzIvWPySCP
         7nN+g9/9BAv1R92zn+bWDJT3c59d4bEfN//vHcmgMaWzHIYIOph4TppgWGE78qZRdG
         tGrk4oBUCyBcQ==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Subject: [PATCH bpf 2/3] selftests/bpf: Define SYS_PREFIX for riscv
Date:   Wed,  4 Oct 2023 13:09:04 +0200
Message-Id: <20231004110905.49024-3-bjorn@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231004110905.49024-1-bjorn@kernel.org>
References: <20231004110905.49024-1-bjorn@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Björn Töpel <bjorn@rivosinc.com>

SYS_PREFIX was missing for a RISC-V, which made a couple of kprobe
tests fail.

Add missing SYS_PREFIX for RISC-V.

Fixes: 08d0ce30e0e4 ("riscv: Implement syscall wrappers")
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index 38a57a2e70db..799fff4995d8 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -99,6 +99,9 @@
 #elif defined(__TARGET_ARCH_arm64)
 #define SYSCALL_WRAPPER 1
 #define SYS_PREFIX "__arm64_"
+#elif defined(__TARGET_ARCH_riscv)
+#define SYSCALL_WRAPPER 1
+#define SYS_PREFIX "__riscv_"
 #else
 #define SYSCALL_WRAPPER 0
 #define SYS_PREFIX "__se_"
-- 
2.39.2

