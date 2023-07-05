Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982AA748300
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jul 2023 13:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjGELjf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Jul 2023 07:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjGELjf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Jul 2023 07:39:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F03172B;
        Wed,  5 Jul 2023 04:39:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04C1661504;
        Wed,  5 Jul 2023 11:39:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9CAC433C8;
        Wed,  5 Jul 2023 11:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688557173;
        bh=ZbcL7/Ws+420j+1VsDqK0BIHNk64SeGaagfrpJQvNdU=;
        h=From:To:Cc:Subject:Date:From;
        b=Mmty4s3lrufZwNUJbmiCj64hkHAdaNMtj0NrKL1xoLIeHV/15A0PRwZ5cpSk8y3Z0
         DeQv/e6LxOjNjfnGKpXI/au6LQHfFGqF4L44oXy3W0OkKpzvlJ6jFa7LSMpm+7LcsP
         /6DOgupRUUJXsl3R4AuugfH+Mz1J+zdndck/Q6UGo/Nxn8/M1IiBRQBtkmTeNPAmU/
         1Sm6UbRVvPU1yEvbv7ez9eiiPmjY1XMg9CtIA7ONv22VXO4O8HThPKzKCDlnWA1l+2
         9Dh0bwIaHEG0r/3BWpDbObUv7Zxsop3rbGRukHQRokz8Q3dcuhYDVlI/rnOOKQrsIE
         qg6SHth7qP4YA==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH bpf-next 0/2] BPF kselftest cross-build/RISC-V fixes
Date:   Wed,  5 Jul 2023 13:39:24 +0200
Message-Id: <20230705113926.751791-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Björn Töpel <bjorn@rivosinc.com>

This series has two minor fixes, found when cross-compiling for the
RISC-V architecture.

Some RISC-V systems do not define HAVE_EFFICIENT_UNALIGNED_ACCESS,
which made some of tests bail out. Fix the failing tests by adding
F_NEEDS_EFFICIENT_UNALIGNED_ACCESS.

...and some RISC-V systems *do* define
HAVE_EFFICIENT_UNALIGNED_ACCESS. In this case the autoconf.h was not
correctly picked up by the build system.


Cheers,
Björn

Björn Töpel (2):
  selftests/bpf: Add F_NEEDS_EFFICIENT_UNALIGNED_ACCESS to some tests
  selftests/bpf: Honor $(O) when figuring out paths

 tools/testing/selftests/bpf/Makefile                  | 4 ++++
 tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c | 1 +
 tools/testing/selftests/bpf/verifier/ctx_skb.c        | 2 ++
 tools/testing/selftests/bpf/verifier/jmp32.c          | 8 ++++++++
 tools/testing/selftests/bpf/verifier/map_kptr.c       | 2 ++
 tools/testing/selftests/bpf/verifier/precise.c        | 2 +-
 6 files changed, 18 insertions(+), 1 deletion(-)


base-commit: a94098d490e17d652770f2309fcb9b46bc4cf864
-- 
2.39.2

