Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16DB749EE0
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jul 2023 16:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbjGFOWr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Jul 2023 10:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbjGFOWq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Jul 2023 10:22:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72751BEF;
        Thu,  6 Jul 2023 07:22:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A7BE61947;
        Thu,  6 Jul 2023 14:22:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DABA8C433C7;
        Thu,  6 Jul 2023 14:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688653361;
        bh=yDBvfndKjEgluCr2OUU13EcTyPrXy62c+4pPDGslyiY=;
        h=From:To:Cc:Subject:Date:From;
        b=bVdRnuRcCDjTajpAmfb2BDudaol6XjWyAkkYusojS0frgOPH84s2OiotXP4VEMHtU
         f00LjcxBzHOEyuV8GbiXKPQOmuWhQUI9nxHCq2NED/ZiWuhUWS0B5B2yjno/GDzhG2
         WIhJ9ZNtEY8HWKwmmSm+PG6c6uVYH6dyhGb5KEES2rmTckIvHfmKOti13bo1TNvnCY
         YVMOI9SW5anRK411UTtH9/OtepjdrYbd0z/+VndSD4cpmVQ627FM/tp1MCt7qm1Z+M
         JiSlsgpyICuoWWee8mNKya19IlCXrGZIq7jtuXfqsfcMINVUbea/wWboybEZG1SKp2
         giredYerJAi6A==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] selftests/bpf: Bump and validate MAX_SYMS
Date:   Thu,  6 Jul 2023 16:22:28 +0200
Message-Id: <20230706142228.1128452-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Björn Töpel <bjorn@rivosinc.com>

BPF tests that load /proc/kallsyms, e.g. bpf_cookie, will perform a
buffer overrun if the number of syms on the system is larger than
MAX_SYMS.

Bump the MAX_SYMS to 400000, and add a runtime check that bails out if
the maximum is reached.

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 tools/testing/selftests/bpf/trace_helpers.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index 9b070cdf44ac..f83d9f65c65b 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -18,7 +18,7 @@
 #define TRACEFS_PIPE	"/sys/kernel/tracing/trace_pipe"
 #define DEBUGFS_PIPE	"/sys/kernel/debug/tracing/trace_pipe"
 
-#define MAX_SYMS 300000
+#define MAX_SYMS 400000
 static struct ksym syms[MAX_SYMS];
 static int sym_cnt;
 
@@ -46,6 +46,9 @@ int load_kallsyms_refresh(void)
 			break;
 		if (!addr)
 			continue;
+		if (i >= MAX_SYMS)
+			return -EFBIG;
+
 		syms[i].addr = (long) addr;
 		syms[i].name = strdup(func);
 		i++;

base-commit: fd283ab196a867f8f65f36913e0fadd031fcb823
-- 
2.39.2

