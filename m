Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE4AEF317
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2019 02:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbfKEB6w (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Nov 2019 20:58:52 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46869 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729597AbfKEB6w (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Nov 2019 20:58:52 -0500
Received: by mail-pg1-f196.google.com with SMTP id f19so12843358pgn.13
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Nov 2019 17:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=yDR8sFGCxzSbjaGfi7fJTFdISWAnA8kL7phBjUnjsmc=;
        b=es4eEqoPagR8E/lry95E2F3gxz83tQk8Mzac/EeG6yQOAJIQfhnJo+hpDlzpy6AaVA
         n422XIto0oJRZyxuCuTLUlQ+bN+L4+tz85XHO9yNMoh6xaA0Tl0nVkTaIkAdjag4Xm/I
         9HBVRLHDDfGXXSd9d2yYw0Em0GA2HIpvMyKNUgYouwWwx6lxnZyBcQXM6Yex2POicfK0
         BRrbGet9w3HDhP/TQ5CWqaX5sl2UhYIbzL8IfQJeidDIqoCcTL+JeA8CUM2Z/ccoBwWd
         4MILq1p+IHi0T80tzyAilhv1wX6C+jlnmj3I+AFi6XMipIZ3UeLfeqAhzi0cMHjv69Rc
         nLpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yDR8sFGCxzSbjaGfi7fJTFdISWAnA8kL7phBjUnjsmc=;
        b=Nh9gKautmCDd0rZL7lySzbGyfBlo1+Z8duC0dBZ1gW7+6CUNyJkLpeYoP4nMKprThM
         1k8woOy/1Ht1AkzZDRNz46SGPGuy/+WHtgVG1TOT8VbcoQlodjWWnUfRKpXzrTAItuch
         y/BGzK1xhbKfscocHCt34wcruUK/JqXNS4CzPWrhCoyfiTPlh52B9tGqjvswemN/KuE+
         FIJoRV7vJ1jtHCRAhS2yEG0NPYASOSwbj21PxjUqecg4XX9erIJgJRhBcdUtkrwgqh4c
         w3SFq9urf33mBsaMX9Z1yO/iYQ+n5sH11p1BbwGN3dMzJZ+i5LPyAda7up+xB+TXqB8i
         5O7Q==
X-Gm-Message-State: APjAAAWTDxrWOGHc8Fd1xXDGndbyrmYpKnGLTKLkAwdVRtarIGSePhnq
        3D/d7zhcbK9qg17lrDhj/LXNvQ==
X-Google-Smtp-Source: APXvYqxY0gl45ufDEtzxOuUDKjdr/YfO4k2ic/wiDE5ZXmwujUNVBcIIGaBSr53zAPGnILDB/9E05w==
X-Received: by 2002:a17:90a:b88f:: with SMTP id o15mr3041825pjr.5.1572919130944;
        Mon, 04 Nov 2019 17:58:50 -0800 (PST)
Received: from localhost.localdomain (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id j6sm16484444pfa.124.2019.11.04.17.58.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Nov 2019 17:58:50 -0800 (PST)
From:   Vincent Chen <vincent.chen@sifive.com>
To:     paul.walmsley@sifive.com, mathieu.desnoyers@efficios.com
Cc:     linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org,
        vincent.chen@sifive.com
Subject: [PATCH 0/3] riscv: add support for restartable sequence 
Date:   Tue,  5 Nov 2019 09:58:31 +0800
Message-Id: <1572919114-3886-1-git-send-email-vincent.chen@sifive.com>
X-Mailer: git-send-email 2.7.4
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
A segmental fault will happen if the Binutils misses this patch.



Vincent Chen (3):
  riscv: add required functions to enable HAVE_REGS_AND_STACK_ACCESS_API
  riscv: Add support for restartable sequence
  rseq/selftests: Add support for riscv

 arch/riscv/Kconfig                        |   2 +
 arch/riscv/include/asm/ptrace.h           |  29 +-
 arch/riscv/kernel/entry.S                 |   4 +
 arch/riscv/kernel/ptrace.c                |  99 +++++
 arch/riscv/kernel/signal.c                |   3 +
 tools/testing/selftests/rseq/param_test.c |  23 ++
 tools/testing/selftests/rseq/rseq-riscv.h | 622 ++++++++++++++++++++++++++++++
 tools/testing/selftests/rseq/rseq.h       |   2 +
 8 files changed, 783 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/rseq/rseq-riscv.h

-- 
2.7.4

