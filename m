Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6687B7F11
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Oct 2023 14:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbjJDM1g (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Oct 2023 08:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242351AbjJDM1f (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Oct 2023 08:27:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED63193;
        Wed,  4 Oct 2023 05:27:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E9CBC433C8;
        Wed,  4 Oct 2023 12:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696422451;
        bh=ijfr6HFXllf/luvFREpH5FQI3TulGFgVtkvmLdbFv64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ScLODdL0FrTl5WcI4ZFVzGB/3dhIzfv39c91kHKpMnyUpcbtbtAicWM3hO66nM6Jb
         bVGqwF21qcWd+bm1lueR+jBY8wwIWKYNoYTYcMV5uUX7HMo0X13sbX81fvHZnopNo5
         1Rs4OiEOAF+6PrpMN19sAkF6KeNRClItyAajXK9P4zN5/jtP0FFPT0NH8sVkCsO0IR
         As5LUiW+61xLkD2OZ1LrQPGhaRqCIxEKNQFMrM9rKHv0Zp81Ws7ZX1n+IbeEys5JI1
         MRPxVyJR7R7Nz6m5m+bZ3h1RwL7RYNlZzN2W5NJaI3R9hQmaMf1Ni4HoZgRsQyAp7L
         AZQTBqgRtdMfQ==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH bpf-next 2/3] selftests/bpf: Enable lld usage for RISC-V
Date:   Wed,  4 Oct 2023 14:27:20 +0200
Message-Id: <20231004122721.54525-3-bjorn@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231004122721.54525-1-bjorn@kernel.org>
References: <20231004122721.54525-1-bjorn@kernel.org>
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

RISC-V has proper lld support. Use that, similar to what x86 does, for
urandom_read et al.

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 tools/testing/selftests/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index a9cbb85fa180..098e32c684d5 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -188,7 +188,7 @@ $(OUTPUT)/%:%.c
 	$(Q)$(LINK.c) $^ $(LDLIBS) -o $@
 
 # LLVM's ld.lld doesn't support all the architectures, so use it only on x86
-ifeq ($(SRCARCH),x86)
+ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 riscv))
 LLD := lld
 else
 LLD := ld
-- 
2.39.2

