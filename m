Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89AF975B441
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 18:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjGTQcl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 12:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjGTQci (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 12:32:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7031985
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jul 2023 09:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689870705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=itPzsUWzfa/0r+cdUWVW66YAXwbafCm93m3nlhq1CyM=;
        b=ecaKSYpepi+8t59FPze02b7OuwrAeK0EwY41Z4HxJITytbhHnc8PyroNK5Qj4VU+7NA934
        grjO7rDaXrywz3ig2dgUn3ONoqQvcBWKviWJkyY35QYqwmYoF3Rqs7HtjfU6hL0dpEA+Ly
        Cxs9utJ0NjrmOxH8xYG1FvaaurHYPLA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-668-S2s6ay7gNwe_HYPF87xsVQ-1; Thu, 20 Jul 2023 12:31:44 -0400
X-MC-Unique: S2s6ay7gNwe_HYPF87xsVQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3CF61101A54E;
        Thu, 20 Jul 2023 16:31:40 +0000 (UTC)
Received: from vschneid.remote.csb (unknown [10.42.28.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B00840C206F;
        Thu, 20 Jul 2023 16:31:29 +0000 (UTC)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org, x86@kernel.org, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Nadav Amit <namit@vmware.com>,
        Dan Carpenter <error27@gmail.com>,
        Chuang Wang <nashuiliang@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Petr Mladek <pmladek@suse.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, Song Liu <song@kernel.org>,
        Julian Pidancet <julian.pidancet@oracle.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Yair Podemsky <ypodemsk@redhat.com>
Subject: [RFC PATCH v2 00/20] context_tracking,x86: Defer some IPIs until a user->kernel transition
Date:   Thu, 20 Jul 2023 17:30:36 +0100
Message-Id: <20230720163056.2564824-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Context
=======

We've observed within Red Hat that isolated, NOHZ_FULL CPUs running a
pure-userspace application get regularly interrupted by IPIs sent from
housekeeping CPUs. Those IPIs are caused by activity on the housekeeping CPUs
leading to various on_each_cpu() calls, e.g.:

  64359.052209596    NetworkManager       0    1405     smp_call_function_many_cond (cpu=0, func=do_kernel_range_flush)
    smp_call_function_many_cond+0x1
    smp_call_function+0x39
    on_each_cpu+0x2a
    flush_tlb_kernel_range+0x7b
    __purge_vmap_area_lazy+0x70
    _vm_unmap_aliases.part.42+0xdf
    change_page_attr_set_clr+0x16a
    set_memory_ro+0x26
    bpf_int_jit_compile+0x2f9
    bpf_prog_select_runtime+0xc6
    bpf_prepare_filter+0x523
    sk_attach_filter+0x13
    sock_setsockopt+0x92c
    __sys_setsockopt+0x16a
    __x64_sys_setsockopt+0x20
    do_syscall_64+0x87
    entry_SYSCALL_64_after_hwframe+0x65

The heart of this series is the thought that while we cannot remove NOHZ_FULL
CPUs from the list of CPUs targeted by these IPIs, they may not have to execute
the callbacks immediately. Anything that only affects kernelspace can wait
until the next user->kernel transition, providing it can be executed "early
enough" in the entry code.

The original implementation is from Peter [1]. Nicolas then added kernel TLB
invalidation deferral to that [2], and I picked it up from there.

Deferral approach
=================

Storing each and every callback, like a secondary call_single_queue turned out
to be a no-go: the whole point of deferral is to keep NOHZ_FULL CPUs in
userspace for as long as possible - no signal of any form would be sent when
deferring an IPI. This means that any form of queuing for deferred callbacks
would end up as a convoluted memory leak.

Deferred IPIs must thus be coalesced, which this series achieves by assigning
IPIs a "type" and having a mapping of IPI type to callback, leveraged upon
kernel entry.

What about IPIs whose callback take a parameter, you may ask?

Peter suggested during OSPM23 [3] that since on_each_cpu() targets
housekeeping CPUs *and* isolated CPUs, isolated CPUs can access either global or
housekeeping-CPU-local state to "reconstruct" the data that would have been sent
via the IPI.

This series does not affect any IPI callback that requires an argument, but the
approach would remain the same (one coalescable callback executed on kernel
entry).

Kernel entry vs execution of the deferred operation
===================================================

There is a non-zero length of code that is executed upon kernel entry before the
deferred operation can be itself executed (i.e. before we start getting into
context_tracking.c proper).

This means one must take extra care to what can happen in the early entry code,
and that <bad things> cannot happen. For instance, we really don't want to hit
instructions that have been modified by a remote text_poke() while we're on our
way to execute a deferred sync_core().

Patches
=======

o Patches 1-9 have been submitted separately and are included for the sake of
  testing 

o Patches 10-14 focus on having objtool detect problematic static key usage in
  early entry
  
o Patch 15 adds the infrastructure for IPI deferral.
o Patches 16-17 add some RCU testing infrastructure
o Patch 18 adds text_poke() IPI deferral.

o Patches 19-20 add vunmap() flush_tlb_kernel_range() IPI deferral

  These ones I'm a lot less confident about, mostly due to lacking
  instrumentation/verification.
  
  The actual deferred callback is also incomplete as it's not properly noinstr:
    vmlinux.o: warning: objtool: __flush_tlb_all_noinstr+0x19: call to native_write_cr4() leaves .noinstr.text section
  and it doesn't support PARAVIRT - it's going to need a pv_ops.mmu entry, but I
  have *no idea* what a sane implementation would be for Xen so I haven't
  touched that yet.

Patches are also available at:

https://gitlab.com/vschneid/linux.git -b redhat/isolirq/defer/v2

Testing
=======

Note: this is a different machine than used for v1, because that machine decided
to act difficult.

Xeon E5-2699 system with SMToff, NOHZ_FULL, isolated CPUs.
RHEL9 userspace.

Workload is using rteval (kernel compilation + hackbench) on housekeeping CPUs
and a dummy stay-in-userspace loop on the isolated CPUs. The main invocation is:

$ trace-cmd record -e "csd_queue_cpu" -f "cpu & CPUS{$ISOL_CPUS}" \
 	           -e "ipi_send_cpumask" -f "cpumask & CPUS{$ISOL_CPUS}" \
	           -e "ipi_send_cpu"     -f "cpu & CPUS{$ISOL_CPUS}" \
		   rteval --onlyload --loads-cpulist=$HK_CPUS \
		   --hackbench-runlowmem=True --duration=$DURATION

This only records IPIs sent to isolated CPUs, so any event there is interference
(with a bit of fuzz at the start/end of the workload when spawning the
processes). All tests were done with a duration of 30 minutes.

v6.5-rc1 (+ cpumask filtering patches):
# This is the actual IPI count
$ trace-cmd report | grep callback | awk '{ print $(NF) }' | sort | uniq -c | sort -nr
    338 callback=generic_smp_call_function_single_interrupt+0x0

# These are the different CSD's that caused IPIs    
$ trace-cmd report | grep csd_queue | awk '{ print $(NF-1) }' | sort | uniq -c | sort -nr
   9207 func=do_flush_tlb_all
   1116 func=do_sync_core
     62 func=do_kernel_range_flush
      3 func=nohz_full_kick_func

v6.5-rc1 + patches:
# This is the actual IPI count
$ trace-cmd report | grep callback | awk '{ print $(NF) }' | sort | uniq -c | sort -nr
      2 callback=generic_smp_call_function_single_interrupt+0x0

# These are the different CSD's that caused IPIs          
$ trace-cmd report | grep csd_queue | awk '{ print $(NF-1) }' | sort | uniq -c | sort -nr
      2 func=nohz_full_kick_func

The incriminating IPIs are all gone, but note that on the machine I used to test
v1 there were still some do_flush_tlb_all() IPIs caused by
pcpu_balance_workfn(), since only vmalloc is affected by the deferral
mechanism.


Acknowledgements
================

Special thanks to:
o Clark Williams for listening to my ramblings about this and throwing ideas my way
o Josh Poimboeuf for his guidance regarding objtool and hinting at the
  .data..ro_after_init section.

Links
=====

[1]: https://lore.kernel.org/all/20210929151723.162004989@infradead.org/
[2]: https://github.com/vianpl/linux.git -b ct-work-defer-wip
[3]: https://youtu.be/0vjE6fjoVVE

Revisions
=========

RFCv1 -> RFCv2
++++++++++++++

o Rebased onto v6.5-rc1

o Updated the trace filter patches (Steven)

o Fixed __ro_after_init keys used in modules (Peter)
o Dropped the extra context_tracking atomic, squashed the new bits in the
  existing .state field (Peter, Frederic)
  
o Added an RCU_EXPERT config for the RCU dynticks counter size, and added an
  rcutorture case for a low-size counter (Paul)

  The new TREE11 case with a 2-bit dynticks counter seems to pass when ran
  against this series.

o Fixed flush_tlb_kernel_range_deferrable() definition

Peter Zijlstra (1):
  jump_label,module: Don't alloc static_key_mod for __ro_after_init keys

Valentin Schneider (19):
  tracing/filters: Dynamically allocate filter_pred.regex
  tracing/filters: Enable filtering a cpumask field by another cpumask
  tracing/filters: Enable filtering a scalar field by a cpumask
  tracing/filters: Enable filtering the CPU common field by a cpumask
  tracing/filters: Optimise cpumask vs cpumask filtering when user mask
    is a single CPU
  tracing/filters: Optimise scalar vs cpumask filtering when the user
    mask is a single CPU
  tracing/filters: Optimise CPU vs cpumask filtering when the user mask
    is a single CPU
  tracing/filters: Further optimise scalar vs cpumask comparison
  tracing/filters: Document cpumask filtering
  objtool: Flesh out warning related to pv_ops[] calls
  objtool: Warn about non __ro_after_init static key usage in .noinstr
  context_tracking: Make context_tracking_key __ro_after_init
  x86/kvm: Make kvm_async_pf_enabled __ro_after_init
  context-tracking: Introduce work deferral infrastructure
  rcu: Make RCU dynticks counter size configurable
  rcutorture: Add a test config to torture test low RCU_DYNTICKS width
  context_tracking,x86: Defer kernel text patching IPIs
  context_tracking,x86: Add infrastructure to defer kernel TLBI
  x86/mm, mm/vmalloc: Defer flush_tlb_kernel_range() targeting NOHZ_FULL
    CPUs

 Documentation/trace/events.rst                |  14 +
 arch/Kconfig                                  |   9 +
 arch/x86/Kconfig                              |   1 +
 arch/x86/include/asm/context_tracking_work.h  |  20 ++
 arch/x86/include/asm/text-patching.h          |   1 +
 arch/x86/include/asm/tlbflush.h               |   2 +
 arch/x86/kernel/alternative.c                 |  24 +-
 arch/x86/kernel/kprobes/core.c                |   4 +-
 arch/x86/kernel/kprobes/opt.c                 |   4 +-
 arch/x86/kernel/kvm.c                         |   2 +-
 arch/x86/kernel/module.c                      |   2 +-
 arch/x86/mm/tlb.c                             |  40 ++-
 include/asm-generic/sections.h                |   5 +
 include/linux/context_tracking.h              |  26 ++
 include/linux/context_tracking_state.h        |  65 +++-
 include/linux/context_tracking_work.h         |  28 ++
 include/linux/jump_label.h                    |   1 +
 include/linux/trace_events.h                  |   1 +
 init/main.c                                   |   1 +
 kernel/context_tracking.c                     |  53 ++-
 kernel/jump_label.c                           |  49 +++
 kernel/rcu/Kconfig                            |  33 ++
 kernel/time/Kconfig                           |   5 +
 kernel/trace/trace_events_filter.c            | 302 ++++++++++++++++--
 mm/vmalloc.c                                  |  19 +-
 tools/objtool/check.c                         |  22 +-
 tools/objtool/include/objtool/check.h         |   1 +
 tools/objtool/include/objtool/special.h       |   2 +
 tools/objtool/special.c                       |   3 +
 .../selftests/rcutorture/configs/rcu/TREE11   |  19 ++
 .../rcutorture/configs/rcu/TREE11.boot        |   1 +
 31 files changed, 695 insertions(+), 64 deletions(-)
 create mode 100644 arch/x86/include/asm/context_tracking_work.h
 create mode 100644 include/linux/context_tracking_work.h
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TREE11
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TREE11.boot

--
2.31.1

