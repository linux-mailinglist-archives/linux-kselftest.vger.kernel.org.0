Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDE6348B50
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Mar 2021 09:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhCYIPI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 25 Mar 2021 04:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhCYIOs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 25 Mar 2021 04:14:48 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1032C061761
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Mar 2021 01:14:47 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id j7so1350051wrd.1
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Mar 2021 01:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OJh6Qrqk5/XT39gDll+pnHq9fpQbzFStOmpgSVUT43U=;
        b=pJJ6zz9w+fj1Mjy+EY0kVEdF9/kLSJVboCEuFpPiO5m4PxWjLlHGm4+3hLz1IgB2Tv
         W0KuI0RM0r5Tg5jXzAtSe55S8+FaG0VBxdlrufkHMIdYPJFWcE9Fh91P33EPZeZeMQU6
         2WWKLwunjsdXwsMeyI+WxZe5bP+B12un9a5cOPsSbrdJWi9XNd6OMVa4turd5GcmavsQ
         BIMSykn+hzgYX/tihEYrKXmd/sH7G5xrPPEQW8r3d0fWmGZzivY1AOaohVBgh99s2bNk
         RYmWeSzbfiAIneoLpT+zGUT2pMSvLkA278+FZNanqz4uhW/aVFeW3uFOqly5p7jufOne
         PigA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OJh6Qrqk5/XT39gDll+pnHq9fpQbzFStOmpgSVUT43U=;
        b=ePR5GWaBtTWHKvY9Zg3qHxKuQvp/xMcwvT+/xwwZ8JFyh+htpmkiMwTrdtEWO4t9IO
         B0glP7+KKRiver9EsSOLBhMUmVkKcMNzPIMa15AdjT1IXQbKEXmZPpL88vcpIpwD7rph
         9gyORNU7APJx4OzN/Q1Z69uCL9acpvwsGXUalP749++dgHUjjnyL8Xdv2c2D1spE5vdg
         KtDec5j7Ma5oiLkvRerfqUeKYp8vsmMGpc3NC8GdhpgodE1WtALcejDxiTyy/Jrbi4BD
         v6BakTl6ZqBuciUX3cvnrQaKxqoJG0UrBaMbFBC3ezlftbf5f/wLFk1POS2gIU2HYojZ
         GaXA==
X-Gm-Message-State: AOAM532lBNpYZ4DaOu49YNmFSNupTTWvZMC+nZLzwPiDGDx6Txx3wVBU
        fH+1QHiUTWqvXVYP9zOsMdrtIg==
X-Google-Smtp-Source: ABdhPJzgyaRJffk/fV2dIdRXYI3rlYwKNEeN5cyw0vllapoUdK7EPGKGZbDJTqY8SNMSHY/2uUKRLw==
X-Received: by 2002:a5d:4b0e:: with SMTP id v14mr6914126wrq.61.1616660086259;
        Thu, 25 Mar 2021 01:14:46 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:248e:270b:f7ab:435d])
        by smtp.gmail.com with ESMTPSA id r10sm5713418wmh.45.2021.03.25.01.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 01:14:45 -0700 (PDT)
Date:   Thu, 25 Mar 2021 09:14:39 +0100
From:   Marco Elver <elver@google.com>
To:     peterz@infradead.org, alexander.shishkin@linux.intel.com,
        acme@kernel.org, mingo@redhat.com, jolsa@redhat.com,
        mark.rutland@arm.com, namhyung@kernel.org, tglx@linutronix.de
Cc:     glider@google.com, viro@zeniv.linux.org.uk, arnd@arndb.de,
        christian@brauner.io, dvyukov@google.com, jannh@google.com,
        axboe@kernel.dk, mascasa@google.com, pcc@google.com,
        irogers@google.com, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 06/11] perf: Add support for SIGTRAP on perf events
Message-ID: <YFxGb+QHEumZB6G8@elver.google.com>
References: <20210324112503.623833-1-elver@google.com>
 <20210324112503.623833-7-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324112503.623833-7-elver@google.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 24, 2021 at 12:24PM +0100, Marco Elver wrote:
[...]
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index b6434697c516..1e4c949bf75f 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6391,6 +6391,17 @@ void perf_event_wakeup(struct perf_event *event)
>  	}
>  }
>  
> +static void perf_sigtrap(struct perf_event *event)
> +{
> +	struct kernel_siginfo info;
> +

I think we need to add something like this here:

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4b82788fbaab..4fcd6b45ce66 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6395,6 +6395,13 @@ static void perf_sigtrap(struct perf_event *event)
 {
 	struct kernel_siginfo info;
 
+	/*
+	 * This irq_work can race with an exiting task; bail out if sighand has
+	 * already been released in release_task().
+	 */
+	if (!current->sighand)
+		return;
+
 	clear_siginfo(&info);
 	info.si_signo = SIGTRAP;
 	info.si_code = TRAP_PERF;


Because syzkaller was able to produce this:

| general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN
| KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
| CPU: 0 PID: 28393 Comm: kworker/u9:4 Not tainted 5.12.0-rc4+ #5
| Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
| RIP: 0010:__lock_acquire+0x87/0x5e60 kernel/locking/lockdep.c:4770
| Code: 84 c0 48 89 7c 24 78 0f 85 10 26 00 00 83 3d 53 64 59 0c 00 0f 84 84 41 00 00 83 3d 72 8a 01 0b 00 74 32 48 89 f8 48 c1 e8 03 <80> 3c 30 00 74 19 48 8b 7c 24 78 e8 79 8b 60 00 48 8b 7c 24 78 48
| RSP: 0018:ffffc90000007c00 EFLAGS: 00010006
| RAX: 0000000000000003 RBX: ffff888048058000 RCX: 0000000000000000
| RDX: 0000000000000000 RSI: dffffc0000000000 RDI: 0000000000000018
| RBP: ffffc90000007da8 R08: 0000000000000001 R09: 0000000000000001
| R10: fffffbfff1b6b27e R11: 0000000000000000 R12: 0000000000000001
| R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000001
| FS:  0000000000000000(0000) GS:ffff88802ce00000(0000) knlGS:0000000000000000
| CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
| CR2: 0000000000970004 CR3: 0000000040d91000 CR4: 0000000000750ef0
| DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
| DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
| PKRU: 55555554
| Call Trace:
|  <IRQ>
|  lock_acquire+0x126/0x650 kernel/locking/lockdep.c:5510
|  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
|  _raw_spin_lock_irqsave+0x73/0xa0 kernel/locking/spinlock.c:159
|  force_sig_info_to_task+0x65/0x3f0 kernel/signal.c:1322
|  perf_sigtrap kernel/events/core.c:6418 [inline]
|  perf_pending_event_disable kernel/events/core.c:6433 [inline]
|  perf_pending_event+0x46f/0x620 kernel/events/core.c:6475
|  irq_work_single kernel/irq_work.c:153 [inline]
|  irq_work_run_list kernel/irq_work.c:175 [inline]
|  irq_work_run+0x1da/0x640 kernel/irq_work.c:184
|  __sysvec_irq_work+0x62/0x70 arch/x86/kernel/irq_work.c:22
|  sysvec_irq_work+0x8c/0xb0 arch/x86/kernel/irq_work.c:17
|  </IRQ>
|  asm_sysvec_irq_work+0x12/0x20 arch/x86/include/asm/idtentry.h:658
| RIP: 0010:__raw_write_unlock_irq include/linux/rwlock_api_smp.h:268 [inline]
| RIP: 0010:_raw_write_unlock_irq+0x25/0x40 kernel/locking/spinlock.c:343
| Code: aa fd ff 66 90 53 48 89 fb 48 83 c7 18 48 8b 74 24 08 e8 3e 34 04 f8 48 89 df e8 a6 1a 06 f8 e8 21 85 26 f8 fb bf 01 00 00 00 <e8> 56 19 fa f7 65 8b 05 77 65 a9 76 85 c0 74 02 5b c3 e8 2b c1 a7
| RSP: 0018:ffffc9000202fd68 EFLAGS: 00000286
| RAX: 2a7870700b93e400 RBX: ffffffff8c40a040 RCX: ffffffff8ff9cb03
| RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000001
| RBP: ffff888047b24790 R08: ffffffff817f0f50 R09: fffffbfff1b6b27e
| R10: fffffbfff1b6b27e R11: 0000000000000000 R12: ffff888048058000
| R13: dffffc0000000000 R14: ffff888047b24701 R15: ffff888048058000
|  release_task+0x10bf/0x1360 kernel/exit.c:220
|  exit_notify kernel/exit.c:699 [inline]
|  do_exit+0x19b0/0x2290 kernel/exit.c:845
|  call_usermodehelper_exec_async+0x39c/0x3a0 kernel/umh.c:123
|  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294


> +	clear_siginfo(&info);
> +	info.si_signo = SIGTRAP;
> +	info.si_code = TRAP_PERF;
> +	info.si_errno = event->attr.type;
> +	force_sig_info(&info);
> +}
> +
>  static void perf_pending_event_disable(struct perf_event *event)
>  {
>  	int cpu = READ_ONCE(event->pending_disable);
> @@ -6400,6 +6411,13 @@ static void perf_pending_event_disable(struct perf_event *event)
>  
>  	if (cpu == smp_processor_id()) {
>  		WRITE_ONCE(event->pending_disable, -1);
> +
> +		if (event->attr.sigtrap) {
> +			atomic_set(&event->event_limit, 1); /* rearm event */
> +			perf_sigtrap(event);
> +			return;
> +		}
> +
>  		perf_event_disable_local(event);
>  		return;
>  	}
[...] 
