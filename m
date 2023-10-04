Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A2C7B7DDB
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Oct 2023 13:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242216AbjJDLJa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Oct 2023 07:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242214AbjJDLJ3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Oct 2023 07:09:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27F6D7;
        Wed,  4 Oct 2023 04:09:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B1A0C433C8;
        Wed,  4 Oct 2023 11:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696417765;
        bh=myfG9KhH8iXXI0iq3rgYVhXBywfTdM/2Q+7Ha1naXhg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DdFm8es+jlF7PkHpEUfqa9RdXiSnnTrCJCr3asGKmQ25q7aDJqGiUuaAa/5qS7L9z
         sGjgLmcD4yf8vCIElGYnJZDBLO2K1qx71Kddj8zXqQkRr4jaTXHdL989/eoMzT3rbV
         3BoQeM5AQxNS/B0ZM4opVnU/OmQG7o+DpGssD0CS5Cf7kWjb/uNoIAas6h/1cmXVzQ
         n2rh5Faki9Te07CC5tTf4S7dHCGVi1adx+VJ5aoZExoImpEwHz3g+m3LECzBWz5a84
         /geVjpyVLCm7CVVLgmm3RPTFIfeYpMb/dF7l+Nc5SCS8n/vaIFapNiuXa2ATVXdeaD
         hmbttxzQ39OeQ==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Subject: [PATCH bpf 3/3] selftests/bpf: Define SYS_NANOSLEEP_KPROBE_NAME for riscv
Date:   Wed,  4 Oct 2023 13:09:05 +0200
Message-Id: <20231004110905.49024-4-bjorn@kernel.org>
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

Add missing sys_nanosleep name for RISC-V, which is used by some tests
(e.g. attach_probe).

Fixes: 08d0ce30e0e4 ("riscv: Implement syscall wrappers")
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 tools/testing/selftests/bpf/test_progs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 77bd492c6024..2f9f6f250f17 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -417,6 +417,8 @@ int get_bpf_max_tramp_links(void);
 #define SYS_NANOSLEEP_KPROBE_NAME "__s390x_sys_nanosleep"
 #elif defined(__aarch64__)
 #define SYS_NANOSLEEP_KPROBE_NAME "__arm64_sys_nanosleep"
+#elif defined(__riscv)
+#define SYS_NANOSLEEP_KPROBE_NAME "__riscv_sys_nanosleep"
 #else
 #define SYS_NANOSLEEP_KPROBE_NAME "sys_nanosleep"
 #endif
-- 
2.39.2

