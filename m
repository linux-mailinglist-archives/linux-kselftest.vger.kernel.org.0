Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE94A77BA62
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Aug 2023 15:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjHNNmr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Aug 2023 09:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjHNNmV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Aug 2023 09:42:21 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E023D106;
        Mon, 14 Aug 2023 06:42:20 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-68843ed67a8so166825b3a.2;
        Mon, 14 Aug 2023 06:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692020540; x=1692625340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lDCAzxWdtY8TWbeLrXdWW1Rai4n5TCJ5494zqu6HPfU=;
        b=Fjxw6gu8bboVjTZ+auStS34IcemdRAKkM+l3uJNXDisu2msNUp+VeFdjl63CoEetEY
         Nr4h1LFqyJcDm2xvSnXF0ptRW5mPdJ3Gdpmh2gsRjyc65E08bIG+BVaG28tdv/t1v/x3
         lOwabI1XL66yLiAu6ZzR/ApmyEWyFYIN01fonPiBsRJF2rJgclPOWP4pep2ANjAkKANq
         8I+MoaxPlX3rFpRQBYtRZ0wOA0Fc1KdeJytDa0UyBWaqLynECIxewWZIAJuayKggHglk
         dDyh4fqEZyjwy1BI9HAZ7u1Ybu+wNl82tS+WOOSTG6gIbJXVwZchk4+bma5M9poAQA3S
         g6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692020540; x=1692625340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lDCAzxWdtY8TWbeLrXdWW1Rai4n5TCJ5494zqu6HPfU=;
        b=Xt3WvWCV/v1QaznAUbyyWnOy8efqNfzJPq0iNc/huPCd65hNJw4ylc7L7bp2AbE1f1
         RxiZIsBBfm3Pg5pNt9Hwzdg71wpieSWNcpeQ1ag31rKyrjuVXT/thIPgeIhkPXcGXFAe
         TR5nkAW9D4+JiuwNWiYfmX9rH/qFgIAQAEKm/WNR626w/ARFuW+0x6atc1w46Z3XEVmR
         M/q1f8cwvYFTH9wGRHjCcDcd5ZU0j+W7O41vv+8JkVi6nFcNTStQ8E3BCh0baZ+rLvy7
         FE65u4MVvTpR35rf2+VKceblA7Ws9KUvMUq02Bisebvr1Apa/9teTSyznOX0Tdoljxgv
         qfNg==
X-Gm-Message-State: AOJu0YzuRHcP/1shtFPYo2SaBzT1vJAHqkozA2Y/Yws6wZkVa2+Nxgg7
        0+rtrB+Fuq/GU97in8QiHqrEAN8MnMY1TRUE
X-Google-Smtp-Source: AGHT+IE9wKPAW8hDDXYgn6NS1woZmMGvp8CdL1oFFe/zjWjyGir6jLu0Ld1BbUDtZFJTbdD3OGS95A==
X-Received: by 2002:a05:6a21:47cb:b0:131:eeba:184b with SMTP id as11-20020a056a2147cb00b00131eeba184bmr11891180pzc.25.1692020539955;
        Mon, 14 Aug 2023 06:42:19 -0700 (PDT)
Received: from localhost.localdomain (bb219-74-209-211.singnet.com.sg. [219.74.209.211])
        by smtp.gmail.com with ESMTPSA id m3-20020a638c03000000b0055c02b8688asm8555583pgd.20.2023.08.14.06.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 06:42:19 -0700 (PDT)
From:   Leon Hwang <hffilwlqm@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, x86@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mykolal@fb.com,
        shuah@kernel.org, davem@davemloft.net, dsahern@kernel.org,
        hffilwlqm@gmail.com, tangyeechou@gmail.com,
        kernel-patches-bot@fb.com, maciej.fijalkowski@intel.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [RFC PATCH bpf-next 0/2] bpf, x64: Fix tailcall infinite loop bug
Date:   Mon, 14 Aug 2023 21:41:45 +0800
Message-ID: <20230814134147.70289-1-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From commit ebf7d1f508a73871 ("bpf, x64: rework pro/epilogue and tailcall
handling in JIT"), the tailcall on x64 works better than before.

From commit e411901c0b775a3a ("bpf: allow for tailcalls in BPF subprograms
for x64 JIT"), tailcall is able to run in BPF subprograms on x64.

From commit 5b92a28aae4dd0f8 ("bpf: Support attaching tracing BPF program
to other BPF programs"), BPF program is able to trace other BPF programs.

How about combining them all together?

1. FENTRY/FEXIT on a BPF subprogram.
2. A tailcall runs in the BPF subprogram.
3. The tailcall calls itself.

As a result, a tailcall infinite loop comes up. And the loop would halt
the machine.

As we know, in tail call context, the tail_call_cnt propagates by stack
and RAX register between BPF subprograms. So do it in FENTRY/FEXIT
trampolines.

How did I discover the bug?

From commit 7f6e4312e15a5c37 ("bpf: Limit caller's stack depth 256 for
subprogs with tailcalls"), the total stack size limits to around 8KiB.
Then, I write some bpf progs to validate the stack consuming, that are
tailcalls running in bpf2bpf and FENTRY/FEXIT tracing on bpf2bpf[1].

At that time, accidently, I made a tailcall loop. And then the loop halted
my VM. Without the loop, the bpf progs would consume over 8KiB stack size.
But the _stack-overflow_ did not halt my VM.

With bpf_printk(), I confirmed that the tailcall count limit did not work
expectedly. Next, read the code and fix it.

Finally, unfortunately, I only fix it on x64 but other arches. As a
result, CI tests failed because this bug hasn't been fixed on s390x.

Some helps are requested.

[1]: https://github.com/Asphaltt/learn-by-example/tree/main/ebpf/tailcall-stackoverflow

Leon Hwang (2):
  bpf, x64: Fix tailcall infinite loop bug
  selftests/bpf: Add testcases for tailcall infinite loop bug fixing

 arch/x86/net/bpf_jit_comp.c                   |  23 ++-
 include/linux/bpf.h                           |   6 +
 kernel/bpf/trampoline.c                       |   5 +-
 kernel/bpf/verifier.c                         |   9 +-
 .../selftests/bpf/prog_tests/tailcalls.c      | 194 +++++++++++++++++-
 .../bpf/progs/tailcall_bpf2bpf_fentry.c       |  18 ++
 .../bpf/progs/tailcall_bpf2bpf_fexit.c        |  18 ++
 7 files changed, 264 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_fentry.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_fexit.c


base-commit: 9930e4af4b509bcf6f060b09b16884f26102d110
-- 
2.41.0

