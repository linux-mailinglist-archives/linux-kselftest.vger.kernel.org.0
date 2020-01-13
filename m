Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7981139941
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2020 19:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgAMSrg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Jan 2020 13:47:36 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44186 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgAMSrf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Jan 2020 13:47:35 -0500
Received: by mail-pl1-f196.google.com with SMTP id az3so4143830plb.11
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2020 10:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:subject:cc:to:in-reply-to:references:message-id
         :mime-version:content-transfer-encoding;
        bh=NEb0TNNHy4r1C3MNqV+qCdGg2s3vRQJoPda6bJix6S4=;
        b=wTG3WHErVldLTNEoR787WJ3a6mn9KO37JfaCd1gjxyhnRMdy3u4q8a2StJLyjEtQJ1
         o1eTPE0xB4l9roo9VG+smY2vr3N9nJGRwCBzpok9hEgQdDNQCKraFiP8Fuz06tZ9/jAV
         N2VxjEVE6q58BenVRccjb+7J5MKBbWf3KqZg+lWhWYERjZM0IOJjtwlmVfXNKkHfcexR
         qNJqlOj9YBWcnobEHjnjwzTNGpW7sCBkFoi1vvuT46KffuV+d1kK1Rg/NNynJJacFwq7
         vpzYJ7cS8TFxVqOoWbveGyS7zgcI+3pr6If99CeTPBrZp+6gbj9/cEbwlNUWKhiBTFxa
         Q2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:cc:to:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=NEb0TNNHy4r1C3MNqV+qCdGg2s3vRQJoPda6bJix6S4=;
        b=J1XQBeYguWM5zXMn6SbY2oC/94Z2h8WTGBLBqPQY5kiraop1WaGNDhyhARyke3NnO0
         jSCQBSZXVu8YI4OxAp6537VtO8FDcUDFSFWtG5i2ClL6ALjB3iap82JlBo+TWG0Heb6r
         KeKxlwqikaq7kaJp5LnKOdmqcnMB3qCTHEAIu0ypbHv9X6YxJvrJ+Iyv/VZuP9I2+/JX
         JgMTOlQ58UQmQ8cu55bra90kwEW82oOLIn8DBHs+zTv6WiAnWwFRfS3RHi8gGdaFy37D
         J5SW1JTh+LUJsoY7uVmwuNO1qJo8PFTUW6whDgHy85KhgOXO2feRvayv60y/2in/2e4G
         7kkw==
X-Gm-Message-State: APjAAAWAdr1ePkQDc2On6h3cSSgQmq7yGV87sOFcvM8tYzrlBrdAMJVd
        GxwiUrBXrcbpgqVffDGSHCGF0w==
X-Google-Smtp-Source: APXvYqzQvCl9YiJ5sFuxllkXHGg/T/wdKVwwxe3JFw7IGvGgx+0B/AZKeo8Ckpz46TBqOti4Uzrxhg==
X-Received: by 2002:a17:902:8503:: with SMTP id bj3mr15262553plb.180.1578941250243;
        Mon, 13 Jan 2020 10:47:30 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:7f69:cd98:a2a2:a03d])
        by smtp.gmail.com with ESMTPSA id d1sm14072333pjx.6.2020.01.13.10.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 10:47:29 -0800 (PST)
Date:   Mon, 13 Jan 2020 10:47:29 -0800 (PST)
X-Google-Original-Date: Mon, 13 Jan 2020 10:47:28 PST (-0800)
From:   Palmer Dabbelt <palmerdabbelt@google.com>
X-Google-Original-From: Palmer Dabbelt <palmer@dabbelt.com>
Subject:     Re: [PATCH 0/3] riscv: add support for restartable sequence 
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        mathieu.desnoyers@efficios.com, vincent.chen@sifive.com,
        linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org
To:     vincent.chen@sifive.com
In-Reply-To: <1572919114-3886-1-git-send-email-vincent.chen@sifive.com>
References: <1572919114-3886-1-git-send-email-vincent.chen@sifive.com>
Message-ID: <mhng-b7d41554-17f9-4303-82b7-6d576fc19a9a@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 04 Nov 2019 17:58:31 PST (-0800), vincent.chen@sifive.com wrote:
> Add RSEQ, restartable sequence, support and related selftest to RISCV.
> The Kconfig option HAVE_REGS_AND_STACK_ACCESS_API is also required by
> RSEQ because RSEQ will modify the content of pt_regs.sepc through
> instruction_pointer_set() during the fixup procedure. In order to select
> the config HAVE_REGS_AND_STACK_ACCESS_API, the missing APIs for accessing
> pt_regs are also added in this patch set.
>
> The relevant RSEQ tests in kselftest require the Binutils patch "RISC-V:
> Fix linker problems with TLS copy relocs" to avoid placing
> PREINIT_ARRAY and TLS variable of librseq.so at the same address.
> https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;a=commit;h=3e7bd7f24146f162565edf878840449f36a8d974
> A segmental fault will happen if the Binutils misses this patch.
>
>
>
> Vincent Chen (3):
>   riscv: add required functions to enable HAVE_REGS_AND_STACK_ACCESS_API
>   riscv: Add support for restartable sequence
>   rseq/selftests: Add support for riscv
>
>  arch/riscv/Kconfig                        |   2 +
>  arch/riscv/include/asm/ptrace.h           |  29 +-
>  arch/riscv/kernel/entry.S                 |   4 +
>  arch/riscv/kernel/ptrace.c                |  99 +++++
>  arch/riscv/kernel/signal.c                |   3 +
>  tools/testing/selftests/rseq/param_test.c |  23 ++
>  tools/testing/selftests/rseq/rseq-riscv.h | 622 ++++++++++++++++++++++++++++++
>  tools/testing/selftests/rseq/rseq.h       |   2 +
>  8 files changed, 783 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/rseq/rseq-riscv.h

This, with Paul's updated patch 1, isn't building on my end:

In file included from <command-line>:
arch/riscv/kernel/ptrace.c:137:18: error: ‘struct pt_regs’ has no member named ‘sepc’; did you mean ‘epc’?
  REG_OFFSET_NAME(sepc),
                  ^~~~
././include/linux/compiler_types.h:129:57: note: in definition of macro ‘__compiler_offsetof’
 #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
                                                         ^
arch/riscv/kernel/ptrace.c:133:51: note: in expansion of macro ‘offsetof’
 #define REG_OFFSET_NAME(r) {.name = #r, .offset = offsetof(struct pt_regs, r)}
                                                   ^~~~~~~~
arch/riscv/kernel/ptrace.c:137:2: note: in expansion of macro ‘REG_OFFSET_NAME’
  REG_OFFSET_NAME(sepc),
  ^~~~~~~~~~~~~~~
arch/riscv/kernel/ptrace.c:169:18: error: ‘struct pt_regs’ has no member named ‘sstatus’; did you mean ‘status’?
  REG_OFFSET_NAME(sstatus),
                  ^~~~~~~
././include/linux/compiler_types.h:129:57: note: in definition of macro ‘__compiler_offsetof’
 #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
                                                         ^
arch/riscv/kernel/ptrace.c:133:51: note: in expansion of macro ‘offsetof’
 #define REG_OFFSET_NAME(r) {.name = #r, .offset = offsetof(struct pt_regs, r)}
                                                   ^~~~~~~~
arch/riscv/kernel/ptrace.c:169:2: note: in expansion of macro ‘REG_OFFSET_NAME’
  REG_OFFSET_NAME(sstatus),
  ^~~~~~~~~~~~~~~
arch/riscv/kernel/ptrace.c:170:18: error: ‘struct pt_regs’ has no member named ‘sbadaddr’; did you mean ‘badaddr’?
  REG_OFFSET_NAME(sbadaddr),
                  ^~~~~~~~
././include/linux/compiler_types.h:129:57: note: in definition of macro ‘__compiler_offsetof’
 #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
                                                         ^
arch/riscv/kernel/ptrace.c:133:51: note: in expansion of macro ‘offsetof’
 #define REG_OFFSET_NAME(r) {.name = #r, .offset = offsetof(struct pt_regs, r)}
                                                   ^~~~~~~~
arch/riscv/kernel/ptrace.c:170:2: note: in expansion of macro ‘REG_OFFSET_NAME’
  REG_OFFSET_NAME(sbadaddr),
  ^~~~~~~~~~~~~~~
arch/riscv/kernel/ptrace.c:171:18: error: ‘struct pt_regs’ has no member named ‘scause’; did you mean ‘cause’?
  REG_OFFSET_NAME(scause),
                  ^~~~~~
././include/linux/compiler_types.h:129:57: note: in definition of macro ‘__compiler_offsetof’
 #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
                                                         ^
arch/riscv/kernel/ptrace.c:133:51: note: in expansion of macro ‘offsetof’
 #define REG_OFFSET_NAME(r) {.name = #r, .offset = offsetof(struct pt_regs, r)}
                                                   ^~~~~~~~
arch/riscv/kernel/ptrace.c:171:2: note: in expansion of macro ‘REG_OFFSET_NAME’
  REG_OFFSET_NAME(scause),
