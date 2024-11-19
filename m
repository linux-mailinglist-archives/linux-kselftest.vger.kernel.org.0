Return-Path: <linux-kselftest+bounces-22280-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B23229D2A13
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 16:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2651DB2989E
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 15:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3B31D043C;
	Tue, 19 Nov 2024 15:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FkWFXbrT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DEB1CC89A
	for <linux-kselftest@vger.kernel.org>; Tue, 19 Nov 2024 15:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732030564; cv=none; b=LPJfNI99RXZB4I21Ng3r9ctgnLUUUShXLT1MxgwoX8os+ZC73n+4E6yukzNJuV3ujLtCfu+PfxVnEYd7suyB69JDA+Wt/DdDxgzx4P7hgrhK7yegm7P+SXNpFXKs6g7j0gvhUKAvUYCvL5Zxq/aNuPDcv0XeyEzvy44niwF0PGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732030564; c=relaxed/simple;
	bh=D1rofV3oRhZOTQ+T7fGzUEs+cN2/IbQ6kETzo+bifK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fhjPdoK1PYayUilrARKcucSE272UVv1s6tvOW12oy32AwI22M+AyXNFYqS8GB+/4SUNTW4I1h3gZFwGN34EIGJ1vvz9kxgDosUUhsfUeqdBjrxoGDBh+4AEpBEX7sbiTkvxTUlZF2mklwyTtAK2Vu1NVZcgBspXsXCmu32j3O9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FkWFXbrT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732030561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zH2CMwOdooVj+NeQcv1HMbkRUyiK2yzOQDjTUDSA8M0=;
	b=FkWFXbrT6lUSRmw9nlgCzKRzY6bT9Yp1QbrrmA3+iVjsALnWZ2tFS500A94eZv9HBfSBD4
	dr0FYH7osFOxEmWaE4aoIrOMMR1cVu7T9Of1Jm2l9m9ajnPdY9mCr9/7GdZCZLyUV3Gqkj
	2H6Ud26Pq6oiz+yemspT70ShsG1V7yE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-pDtHmMNBNmO7bfsG9lq97w-1; Tue,
 19 Nov 2024 10:35:59 -0500
X-MC-Unique: pDtHmMNBNmO7bfsG9lq97w-1
X-Mimecast-MFC-AGG-ID: pDtHmMNBNmO7bfsG9lq97w
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F3AC11944DEF;
	Tue, 19 Nov 2024 15:35:50 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.194.94])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1797730001A0;
	Tue, 19 Nov 2024 15:35:33 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	x86@kernel.org,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
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
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Song Liu <song@kernel.org>,
	Julian Pidancet <julian.pidancet@oracle.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Juri Lelli <juri.lelli@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Yair Podemsky <ypodemsk@redhat.com>,
	Daniel Wagner <dwagner@suse.de>,
	Petr Tesarik <ptesarik@suse.com>
Subject: [RFC PATCH v3 00/15] context_tracking,x86: Defer some IPIs until a user->kernel transition
Date: Tue, 19 Nov 2024 16:34:47 +0100
Message-ID: <20241119153502.41361-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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

This is what I've referred to as the "Danger Zone" during my LPC24 talk [4].

There is a non-zero length of code that is executed upon kernel entry before the
deferred operation can be itself executed (i.e. before we start getting into
context_tracking.c proper), i.e.:

  idtentry_func_foo()                <--- we're in the kernel
    irqentry_enter()
      enter_from_user_mode()
	__ct_user_exit()
	    ct_kernel_enter_state()
	      ct_work_flush()        <--- deferred operation is executed here

This means one must take extra care to what can happen in the early entry code,
and that <bad things> cannot happen. For instance, we really don't want to hit
instructions that have been modified by a remote text_poke() while we're on our
way to execute a deferred sync_core(). Patches doing the actual deferral have
more detail on this.

Patches
=======

o Patches 1-3 are standalone cleanups.
o Patches 4-5 add an RCU testing feature.

o Patches 6-8 add a new type of jump label for static keys that will not have
  their IPI be deferred.
o Patch 9 adds objtool verification of static keys vs their text_poke IPI
  deferral
o Patches 10-14 add the actual IPI deferrals

o Patch 15 is a freebie to enable the deferral feature for NO_HZ_IDLE

Patches are also available at:
https://gitlab.com/vschneid/linux.git -b redhat/isolirq/defer/v3

RFC status
==========

Things I'd like to get comments on and/or that are a bit WIPish; they're called
out in the individual changelogs:

o "forceful" jump label naming which I don't particularly like

o objtool usage of 'offset_of(static_key.type)' and JUMP_TYPE_FORCEFUL. I've
  hardcoded them but it could do with being shoved in a kernel header objtool
  can include directly

o The noinstr variant of __flush_tlb_all() doesn't have a paravirt variant, does
  it need one?

  

Testing
=======

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
processes). All tests were done with a duration of 1hr.

v6.12-rc4
# This is the actual IPI count
$ trace-cmd report trace-base.dat | grep callback | awk '{ print $(NF) }' | sort | uniq -c | sort -nr
   1782 callback=generic_smp_call_function_single_interrupt+0x0
     73 callback=0x0

# These are the different CSD's that caused IPIs    
$ trace-cmd report | grep csd_queue | awk '{ print $(NF-1) }' | sort | uniq -c | sort -nr
  22048 func=tlb_remove_table_smp_sync
  16536 func=do_sync_core
   2262 func=do_flush_tlb_all
    182 func=do_kernel_range_flush
    144 func=rcu_exp_handler
     60 func=sched_ttwu_pending

v6.12-rc4 + patches:
# This is the actual IPI count
$ trace-cmd report | grep callback | awk '{ print $(NF) }' | sort | uniq -c | sort -nr
   1168 callback=generic_smp_call_function_single_interrupt+0x0
     74 callback=0x0

# These are the different CSD's that caused IPIs          
$ trace-cmd report | grep csd_queue | awk '{ print $(NF-1) }' | sort | uniq -c | sort -nr
  23686 func=tlb_remove_table_smp_sync
    192 func=rcu_exp_handler
     65 func=sched_ttwu_pending

Interestingly tlb_remove_table_smp_sync() started showing up on this machine,
while it didn't during testing for v2 and it's the same machine. Yair had a
series adressing this [5] which per these results would be worth revisiting.

Acknowledgements
================

Special thanks to:
o Clark Williams for listening to my ramblings about this and throwing ideas my way
o Josh Poimboeuf for his guidance regarding objtool and hinting at the
  .data..ro_after_init section.
o All of the folks who attended various talks about this and provided precious
  feedback.  

Links
=====

[1]: https://lore.kernel.org/all/20210929151723.162004989@infradead.org/
[2]: https://github.com/vianpl/linux.git -b ct-work-defer-wip
[3]: https://youtu.be/0vjE6fjoVVE
[4]: https://lpc.events/event/18/contributions/1889/
[5]: https://lore.kernel.org/lkml/20230620144618.125703-1-ypodemsk@redhat.com/

Revisions
=========

RFCv2 -> RFCv3
+++++++++++

o Rebased onto v6.12-rc7

o Added objtool documentation for the new warning (Josh)
o Added low-size RCU watching counter to TREE04 torture scenario (Paul)
o Added FORCEFUL jump label and static key types
o Added noinstr-compliant helpers for tlb flush deferral

o Overall changelog & comments cleanup


RFCv1 -> RFCv2
++++++++++++++

o Rebased onto v6.5-rc1

o Updated the trace filter patches (Steven)

o Fixed __ro_after_init keys used in modules (Peter)
o Dropped the extra context_tracking atomic, squashed the new bits in the
  existing .state field (Peter, Frederic)
  
o Added an RCU_EXPERT config for the RCU dynticks counter size, and added an
  rcutorture case for a low-size counter (Paul) 

o Fixed flush_tlb_kernel_range_deferrable() definition

Valentin Schneider (15):
  objtool: Make validate_call() recognize indirect calls to pv_ops[]
  objtool: Flesh out warning related to pv_ops[] calls
  sched/clock: Make sched_clock_running __ro_after_init
  rcu: Add a small-width RCU watching counter debug option
  rcutorture: Make TREE04 use CONFIG_RCU_DYNTICKS_TORTURE
  jump_label: Add forceful jump label type
  x86/speculation/mds: Make mds_idle_clear forceful
  sched/clock, x86: Make __sched_clock_stable forceful
  objtool: Warn about non __ro_after_init static key usage in .noinstr
  x86/alternatives: Record text_poke's of JUMP_TYPE_FORCEFUL labels
  context-tracking: Introduce work deferral infrastructure
  context_tracking,x86: Defer kernel text patching IPIs
  context_tracking,x86: Add infrastructure to defer kernel TLBI
  x86/mm, mm/vmalloc: Defer flush_tlb_kernel_range() targeting NOHZ_FULL
    CPUs
  context-tracking: Add a Kconfig to enable IPI deferral for NO_HZ_IDLE

 arch/Kconfig                                  |  9 +++
 arch/x86/Kconfig                              |  1 +
 arch/x86/include/asm/context_tracking_work.h  | 20 +++++++
 arch/x86/include/asm/special_insns.h          |  1 +
 arch/x86/include/asm/text-patching.h          | 13 ++++-
 arch/x86/include/asm/tlbflush.h               | 17 +++++-
 arch/x86/kernel/alternative.c                 | 49 ++++++++++++----
 arch/x86/kernel/cpu/bugs.c                    |  2 +-
 arch/x86/kernel/cpu/common.c                  |  6 +-
 arch/x86/kernel/jump_label.c                  |  7 ++-
 arch/x86/kernel/kprobes/core.c                |  4 +-
 arch/x86/kernel/kprobes/opt.c                 |  4 +-
 arch/x86/kernel/module.c                      |  2 +-
 arch/x86/mm/tlb.c                             | 49 ++++++++++++++--
 include/linux/context_tracking.h              | 21 +++++++
 include/linux/context_tracking_state.h        | 54 ++++++++++++++---
 include/linux/context_tracking_work.h         | 28 +++++++++
 include/linux/jump_label.h                    | 26 ++++++---
 kernel/context_tracking.c                     | 46 ++++++++++++++-
 kernel/rcu/Kconfig.debug                      | 14 +++++
 kernel/sched/clock.c                          |  4 +-
 kernel/time/Kconfig                           | 19 ++++++
 mm/vmalloc.c                                  | 35 +++++++++--
 tools/objtool/Documentation/objtool.txt       | 13 +++++
 tools/objtool/check.c                         | 58 ++++++++++++++++---
 tools/objtool/include/objtool/check.h         |  1 +
 tools/objtool/include/objtool/special.h       |  2 +
 tools/objtool/special.c                       |  3 +
 .../selftests/rcutorture/configs/rcu/TREE04   |  1 +
 29 files changed, 450 insertions(+), 59 deletions(-)
 create mode 100644 arch/x86/include/asm/context_tracking_work.h
 create mode 100644 include/linux/context_tracking_work.h

--
2.43.0


