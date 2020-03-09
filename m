Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 951BE17D924
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Mar 2020 07:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgCIGAI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Mar 2020 02:00:08 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34340 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgCIGAI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Mar 2020 02:00:08 -0400
Received: by mail-pg1-f196.google.com with SMTP id t3so4216540pgn.1
        for <linux-kselftest@vger.kernel.org>; Sun, 08 Mar 2020 23:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J641+pmCG4P/KzNqvlVegOoARTlmRLCArI/HwOPcSyU=;
        b=M4uq1PcwZF9oBu5Eumvw8Qor++aHOQ8pdQ1wmNCuHNJABIvRpgn4C2+KYGiG5wRd6c
         HDXJ1YaaK1np7U5dObuwPfwt+mK4T2uumKFGMdfoPuxiA0w1ovZWxPH6x4Yj2r81n53c
         lMLwIwzPgU1jwSCIXMMeZMzJYNbxnTS1HS2DfNtLSs2loxnQj6onW1yBkUapxX9MAZjS
         sinUnk9/hUmg5K0Se1EWTYM5GVOeEZtGYhanL02O3yVEcSie2Lpy9X4rHx5ANBnXKVLU
         uH4N032D76VRpuFuTSVx7JBQ4CKY8eFEl5Xj8QA7GPhvcRU+uSkfh76aPuSMkDVzAEtz
         ywtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J641+pmCG4P/KzNqvlVegOoARTlmRLCArI/HwOPcSyU=;
        b=LnvEKr0giy6++e3eukvw2QF/zFnLgo5cyXPaZoUUVuNNkkjxhmQcJHM2j509aVlgSf
         C6lvTOXLsXexis6qrznAxKRxEG70iUR5GSd+wo2xen0y/A4XBXTnY8EBHcbM9TggB/hh
         7V00MbCwK6Z8ZhY+xkIXKPHhWKMm31fMW+CH6Q8CALyLujlVCLqjYus/lHtNm+a06HYI
         ddTTBwgn04Zbr0HlsiE6Pwh4gnNLpxB27L2PpGaEzFctTmixEWp06bbzdSFzw6s62JYu
         Jb95hdhef1tebP1Y2a5oqHFfGqwI49qFNqrOqEorjcGsvIVnvQzb0VFMi/VUqQP+rrbb
         NERQ==
X-Gm-Message-State: ANhLgQ3uzg+wA7dsuGeL9Nx3AvlNNPYW4RYXZIgX2xR8acjaPq4g+NlH
        48WzpJNCbLWO4oyhylXSrRyZYA==
X-Google-Smtp-Source: ADFU+vuQ6KDS1JZLA6PWSQKvf8eTB8YWO9jsqA803PeJGmFrWmcjnQzj9qy6SnlB2i22H92mLzPSkA==
X-Received: by 2002:a62:16d0:: with SMTP id 199mr14848586pfw.238.1583733606460;
        Sun, 08 Mar 2020 23:00:06 -0700 (PDT)
Received: from VincentChen-ThinkPad-T480s.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id nh4sm3033061pjb.39.2020.03.08.23.00.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 08 Mar 2020 23:00:05 -0700 (PDT)
From:   Vincent Chen <vincent.chen@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        mathieu.desnoyers@efficios.com
Cc:     linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        Vincent Chen <vincent.chen@sifive.com>
Subject: [PATCH V2 0/3] riscv: add support for restartable sequence
Date:   Mon,  9 Mar 2020 13:59:49 +0800
Message-Id: <1583733592-22873-1-git-send-email-vincent.chen@sifive.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add RSEQ, restartable sequence, support and related selftest to RISCV.
The Kconfig option HAVE_REGS_AND_STACK_ACCESS_API is also required by
RSEQ because RSEQ will modify the content of pt_regs.sepc through
instruction_pointer_set() during the fixup procedure. In order to select
the config HAVE_REGS_AND_STACK_ACCESS_API, the missing APIs for accessing
pt_regs are also added in this patch set.
  
The relevant RSEQ tests in kselftest require the Binutils patch "RISC-V:
Fix linker problems with TLS copy relocs" to avoid placing
PREINIT_ARRAY and TLS variable of librseq.so at the same address.
https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;a=commit;h=3e7bd7f24146f162565edf878840449f36a8d974
A segmental fault will happen if binutils misses this patch.

Patrick Stählin (1):
  riscv: add required functions to enable HAVE_REGS_AND_STACK_ACCESS_API

Vincent Chen (2):
  riscv: Add support for restartable sequence
  rseq/selftests: Add support for riscv

Changes since v1:
1. Use the correct register name to access pt_regs


 arch/riscv/Kconfig                        |   2 +
 arch/riscv/include/asm/ptrace.h           |  29 +-
 arch/riscv/kernel/entry.S                 |   4 +
 arch/riscv/kernel/ptrace.c                |  99 +++++
 arch/riscv/kernel/signal.c                |   2 +
 tools/testing/selftests/rseq/param_test.c |  23 ++
 tools/testing/selftests/rseq/rseq-riscv.h | 622 ++++++++++++++++++++++++++++++
 tools/testing/selftests/rseq/rseq.h       |   2 +
 8 files changed, 782 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/rseq/rseq-riscv.h

-- 
2.7.4

