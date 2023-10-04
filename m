Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36FD37B7F06
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Oct 2023 14:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242133AbjJDM1a (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Oct 2023 08:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbjJDM1a (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Oct 2023 08:27:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E501F93;
        Wed,  4 Oct 2023 05:27:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75416C433C8;
        Wed,  4 Oct 2023 12:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696422446;
        bh=RkzvF8X+SXDFLfFH4P6mrq7fuBmqThHF3EmjygH38s8=;
        h=From:To:Cc:Subject:Date:From;
        b=tCdbg9GWUdthDNNxMYvE7a+R5KpNE1fdxO3rcSy3ibki5AKOYZ0Lt/gpZ/20g5Mvk
         ytPpLV7Uoxx9ug7IpnI9UHmzf1dbPyMJaPvem9GjgK/Lg5FJavmEJxeNjtntr0Uqm/
         ZflKPumsYQ2Ny/9BxNVQnztfvrAjTsjY+seWYkQy6eyBejCB/rvkTZJAeSzNdEYN6Q
         Lm9LaMzQCEXoIl9vRKZQC+eM9ni2Qsxc52jMxDVyfUnKf7p4JTjMwqgUKg9E+V/ojh
         zFFI6IbCR+wnvjbirjdr5WVioLGtQ8F1zSp1I0Jy+oS2R/2wwjvOAiz3L4l/L1xvE6
         1nLMCm9DXFZKA==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH bpf-next 0/3] selftest/bpf, riscv: Improved cross-building support
Date:   Wed,  4 Oct 2023 14:27:18 +0200
Message-Id: <20231004122721.54525-1-bjorn@kernel.org>
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

Yet another "more cross-building support for RISC-V" series.

An example how to invoke a gen_tar build:

  | make ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- CC=riscv64-linux-gnu-gcc \
  |    HOSTCC=gcc O=/workspace/kbuild FORMAT= \
  |    SKIP_TARGETS="arm64 ia64 powerpc sparc64 x86 sgx" -j $(($(nproc)-1)) \
  |    -C tools/testing/selftests gen_tar


Björn

Björn Töpel (3):
  selftests/bpf: Add cross-build support for urandom_read et al
  selftests/bpf: Enable lld usage for RISC-V
  selftests/bpf: Add uprobe_multi to gen_tar target

 tools/testing/selftests/bpf/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)


base-commit: 2147c8d07e1abc8dfc3433ca18eed5295e230ede
-- 
2.39.2

