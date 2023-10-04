Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0EB27B7DD0
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Oct 2023 13:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbjJDLJW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Oct 2023 07:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbjJDLJV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Oct 2023 07:09:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321B5A6;
        Wed,  4 Oct 2023 04:09:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6769C433C8;
        Wed,  4 Oct 2023 11:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696417757;
        bh=cIK310loNJ2BR+OPVmSjuH3dT9aW28cXGyvHv5GQJRE=;
        h=From:To:Cc:Subject:Date:From;
        b=muwOzbM7de19wBjNPm7pS7dN1UXW5jDvXiLqXtvzchKcHh0MWe/X2SJBDFaNpEBvn
         kVMxYvRRRgFvMWDy7+y/0WAds3A8G/wTXLEJUl5JwrjoXoYauzn6OPDf8FToABW7QY
         1VT4MZbaYqzFwyM4XHz9gaUOQlt9bDFBinO1bpeN01cu3vA90N7/MuCrzrVOe25Bg1
         AqM/9ZU4iCK9KlnreyzpwIYryhNSoY7Ik9irx7HpWG9Nlzk4BL/crso/RNm7CMXTJ3
         alCfUILE+coHx5L51sKHdCJerv7xXTTn9O8jrlmxX2zntD2wI+HXOJw80AuWf0RhMP
         5GWhkKhFuBhyQ==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Subject: [PATCH bpf 0/3] libbpf/selftests syscall wrapper fixes for RISC-V
Date:   Wed,  4 Oct 2023 13:09:02 +0200
Message-Id: <20231004110905.49024-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.39.2
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

Commit 08d0ce30e0e4 ("riscv: Implement syscall wrappers") introduced
some regressions in libbpf, and the kselftests BPF suite, which are
fixed with these three patches.

Note that there's an outstanding fix [1] for ftrace syscall tracing
which is also a fallout from the commit above.


Björn

[1] https://lore.kernel.org/linux-riscv/20231003182407.32198-1-alexghiti@rivosinc.com/

Alexandre Ghiti (1):
  libbpf: Fix syscall access arguments on riscv

Björn Töpel (2):
  selftests/bpf: Define SYS_PREFIX for riscv
  selftests/bpf: Define SYS_NANOSLEEP_KPROBE_NAME for riscv

 tools/lib/bpf/bpf_tracing.h                  | 2 --
 tools/testing/selftests/bpf/progs/bpf_misc.h | 3 +++
 tools/testing/selftests/bpf/test_progs.h     | 2 ++
 3 files changed, 5 insertions(+), 2 deletions(-)


base-commit: 9077fc228f09c9f975c498c55f5d2e882cd0da59
-- 
2.39.2

