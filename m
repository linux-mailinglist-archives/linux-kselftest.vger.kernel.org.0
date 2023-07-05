Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A95F748305
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jul 2023 13:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbjGELjn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Jul 2023 07:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjGELjk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Jul 2023 07:39:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AB01730;
        Wed,  5 Jul 2023 04:39:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA16E61511;
        Wed,  5 Jul 2023 11:39:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4C3EC43391;
        Wed,  5 Jul 2023 11:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688557179;
        bh=urR3yZnDusvfwXBBOCw/IKT8fxfFq0fp8eLiyLD/Gk8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mjrzNsnkwMA7QUoyv8VZHYooJ9qpesUo3fpr7hiB/TVnxsZHH9BhWMCKLK8at5QwS
         V9hMGMNDTEq3nNEQ6c3DCl83x7CH/qRoAk5UNVLg8DQffuNqmHl4AlteM2DLsljmQs
         5VuXlXM9uZxiblRRVomfvkyWZuEcaquye35Zfui17JLeLC9AHJlbSvfgq+DCac65GS
         WvKfzA2uUlTbXQQcpTnKOsXLKWF3MNPpFWtQjerp92230pbjBn3bPavNHUlXYCM8w8
         NK92ORPQi9wQqzp90yshBg7i4NS7GpOFowqCsYqGQZxY08HdzQbNHiWnCGo50L1MAJ
         o/vqbVggKlsVA==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH bpf-next 2/2] selftests/bpf: Honor $(O) when figuring out paths
Date:   Wed,  5 Jul 2023 13:39:26 +0200
Message-Id: <20230705113926.751791-3-bjorn@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230705113926.751791-1-bjorn@kernel.org>
References: <20230705113926.751791-1-bjorn@kernel.org>
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

When building the kselftests out-of-tree, e.g.
  | make ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- \
  |   O=/tmp/kselftest headers
  | make ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- \
  |  O=/tmp/kselftest HOSTCC=gcc FORMAT= \
  |  SKIP_TARGETS="arm64 ia64 powerpc sparc64 x86 sgx" \
  |  -C tools/testing/selftests gen_tar

the kselftest build would not pick up the correct GENDIR path, and
therefore not including autoconf.h.

Correct that by taking $(O) into consideration when figuring out the
GENDIR path.

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 tools/testing/selftests/bpf/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index ad6b585e0d7c..daccc1b8573a 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -12,7 +12,11 @@ BPFDIR := $(LIBDIR)/bpf
 TOOLSINCDIR := $(TOOLSDIR)/include
 BPFTOOLDIR := $(TOOLSDIR)/bpf/bpftool
 APIDIR := $(TOOLSINCDIR)/uapi
+ifneq ($(O),)
+GENDIR := $(O)/include/generated
+else
 GENDIR := $(abspath ../../../../include/generated)
+endif
 GENHDR := $(GENDIR)/autoconf.h
 HOSTPKG_CONFIG := pkg-config
 
-- 
2.39.2

