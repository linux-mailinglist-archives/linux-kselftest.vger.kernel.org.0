Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0824B1A01A
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2019 17:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbfEJP0r (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 May 2019 11:26:47 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:58514 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbfEJP0r (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 May 2019 11:26:47 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id A2A7672CCCF;
        Fri, 10 May 2019 18:26:40 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 903CC7CCE09; Fri, 10 May 2019 18:26:40 +0300 (MSK)
Date:   Fri, 10 May 2019 18:26:40 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greentime Hu <greentime@andestech.com>,
        Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        James Hogan <jhogan@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Burton <paul.burton@mips.com>,
        Paul Mackerras <paulus@samba.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Richard Kuo <rkuo@codeaurora.org>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Chen <deanbo422@gmail.com>, linux-api@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        strace-devel@lists.strace.io
Subject: [PATCH v11 0/7] ptrace: add PTRACE_GET_SYSCALL_INFO request
Message-ID: <20190510152640.GA28529@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

[Andrew, could you take this patchset into your tree, please?

Besides the patch for hexagon, all patches in this series have
Acked-by or Reviewed-by tags already.

I have been waiting and pinging the hexagon maintainer since November
without any visible effect.  The last Acked-by from the hexagon maintainer
in linux.git was in October and the last Signed-off-by was in July.  Since
that time not a single change affecting hexagon was able to attract
attention of the hexagon maintainer, so I don't think it's worth waiting
any longer.]

PTRACE_GET_SYSCALL_INFO is a generic ptrace API that lets ptracer obtain
details of the syscall the tracee is blocked in.

There are two reasons for a special syscall-related ptrace request.

Firstly, with the current ptrace API there are cases when ptracer cannot
retrieve necessary information about syscalls.  Some examples include:
* The notorious int-0x80-from-64-bit-task issue.  See [1] for details.
In short, if a 64-bit task performs a syscall through int 0x80, its tracer
has no reliable means to find out that the syscall was, in fact,
a compat syscall, and misidentifies it.
* Syscall-enter-stop and syscall-exit-stop look the same for the tracer.
Common practice is to keep track of the sequence of ptrace-stops in order
not to mix the two syscall-stops up.  But it is not as simple as it looks;
for example, strace had a (just recently fixed) long-standing bug where
attaching strace to a tracee that is performing the execve system call
led to the tracer identifying the following syscall-exit-stop as
syscall-enter-stop, which messed up all the state tracking.
* Since the introduction of commit 84d77d3f06e7e8dea057d10e8ec77ad71f721be3
("ptrace: Don't allow accessing an undumpable mm"), both PTRACE_PEEKDATA
and process_vm_readv become unavailable when the process dumpable flag
is cleared.  On such architectures as ia64 this results in all syscall
arguments being unavailable for the tracer.

Secondly, ptracers also have to support a lot of arch-specific code for
obtaining information about the tracee.  For some architectures, this
requires a ptrace(PTRACE_PEEKUSER, ...) invocation for every syscall
argument and return value.

PTRACE_GET_SYSCALL_INFO returns the following structure:

struct ptrace_syscall_info {
	__u8 op;	/* PTRACE_SYSCALL_INFO_* */
	__u32 arch __attribute__((__aligned__(sizeof(__u32))));
	__u64 instruction_pointer;
	__u64 stack_pointer;
	union {
		struct {
			__u64 nr;
			__u64 args[6];
		} entry;
		struct {
			__s64 rval;
			__u8 is_error;
		} exit;
		struct {
			__u64 nr;
			__u64 args[6];
			__u32 ret_data;
		} seccomp;
	};
};

The structure was chosen according to [2], except for the following
changes:
* seccomp substructure was added as a superset of entry substructure;
* the type of nr field was changed from int to __u64 because syscall
numbers are, as a practical matter, 64 bits;
* stack_pointer field was added along with instruction_pointer field
since it is readily available and can save the tracer from extra
PTRACE_GETREGS/PTRACE_GETREGSET calls;
* arch is always initialized to aid with tracing system calls
* such as execve();
* instruction_pointer and stack_pointer are always initialized
so they could be easily obtained for non-syscall stops;
* a boolean is_error field was added along with rval field, this way
the tracer can more reliably distinguish a return value
from an error value.

strace has been ported to PTRACE_GET_SYSCALL_INFO.
Starting with release 4.26, strace uses PTRACE_GET_SYSCALL_INFO API
as the preferred mechanism of obtaining syscall information.

[1] https://lore.kernel.org/lkml/CA+55aFzcSVmdDj9Lh_gdbz1OzHyEm6ZrGPBDAJnywm2LF_eVyg@mail.gmail.com/
[2] https://lore.kernel.org/lkml/CAObL_7GM0n80N7J_DFw_eQyfLyzq+sf4y2AvsCCV88Tb3AwEHA@mail.gmail.com/

---

Notes:
    v11:
    * Added more Acked-by.
    * Rebased back to mainline as the prerequisite syscall_get_arch patchset
      has already been merged via audit tree.

    v10:
    * Added more Acked-by.

    v9:
    * Rebased to linux-next again due to syscall_get_arguments() signature change.

    v8:
    * Moved syscall_get_arch() specific patches to a separate patchset
      which is now merged into audit/next tree.
    * Rebased to linux-next.
    * Moved ptrace_get_syscall_info code under #ifdef CONFIG_HAVE_ARCH_TRACEHOOK,
      narrowing down the set of architectures supported by this implementation
      back to those 19 that enable CONFIG_HAVE_ARCH_TRACEHOOK because
      I failed to get all syscall_get_*(), instruction_pointer(),
      and user_stack_pointer() functions implemented on some niche
      architectures.  This leaves the following architectures out:
      alpha, h8300, m68k, microblaze, and unicore32.

    v7:
    * Rebased to v5.0-rc1.
    * 5 arch-specific preparatory patches out of 25 have been merged
      into v5.0-rc1 via arch trees.

    v6:
    * Added syscall_get_arguments and syscall_set_arguments wrappers
      to asm-generic/syscall.h, requested by Geert.
    * Changed PTRACE_GET_SYSCALL_INFO return code: do not take trailing paddings
      into account, use the end of the last field of the structure being written.
    * Changed struct ptrace_syscall_info:
      * remove .frame_pointer field, is is not needed and not portable;
      * make .arch field explicitly aligned, remove no longer needed
        padding before .arch field;
      * remove trailing pads, they are no longer needed.

    v5:
    * Merged separate series and patches into the single series.
    * Changed PTRACE_EVENTMSG_SYSCALL_{ENTRY,EXIT} values as requested by Oleg.
    * Changed struct ptrace_syscall_info: generalized instruction_pointer,
      stack_pointer, and frame_pointer fields by moving them from
      ptrace_syscall_info.{entry,seccomp} substructures to ptrace_syscall_info
      and initializing them for all stops.
    * Added PTRACE_SYSCALL_INFO_NONE, set it when not in a syscall stop,
      so e.g. "strace -i" could use PTRACE_SYSCALL_INFO_SECCOMP to obtain
      instruction_pointer when the tracee is in a signal stop.
    * Patched all remaining architectures to provide all necessary
      syscall_get_* functions.
    * Made available for all architectures: do not conditionalize on
      CONFIG_HAVE_ARCH_TRACEHOOK since all syscall_get_* functions
      are implemented on all architectures.
    * Added a test for PTRACE_GET_SYSCALL_INFO to selftests/ptrace.

    v4:
    * Revisited PTRACE_EVENT_SECCOMP support:
      do not introduce task_struct.ptrace_event, use child->last_siginfo->si_code instead.
    * Implemented PTRACE_SYSCALL_INFO_SECCOMP and ptrace_syscall_info.seccomp
      support along with PTRACE_SYSCALL_INFO_{ENTRY,EXIT} and
      ptrace_syscall_info.{entry,exit}.

    v3:
    * Changed struct ptrace_syscall_info.
    * Added PTRACE_EVENT_SECCOMP support by adding ptrace_event to task_struct.
    * Added proper defines for ptrace_syscall_info.op values.
    * Renamed PT_SYSCALL_IS_ENTERING and PT_SYSCALL_IS_EXITING to
      PTRACE_EVENTMSG_SYSCALL_ENTRY and PTRACE_EVENTMSG_SYSCALL_EXIT
      and moved them to uapi.

    v2:
    * Stopped using task->ptrace.
    * Replaced entry_info.is_compat with entry_info.arch, used syscall_get_arch().
    * Used addr argument of sys_ptrace to get expected size of the struct;
      return full size of the struct.

Dmitry V. Levin (6):
  nds32: fix asm/syscall.h # acked
  hexagon: define syscall_get_error() and syscall_get_return_value() # waiting for ack since November
  mips: define syscall_get_error() # acked
  parisc: define syscall_get_error() # acked
  powerpc: define syscall_get_error() # acked
  selftests/ptrace: add a test case for PTRACE_GET_SYSCALL_INFO # acked

Elvira Khabirova (1):
  ptrace: add PTRACE_GET_SYSCALL_INFO request # reviewed

 arch/hexagon/include/asm/syscall.h            |  14 +
 arch/mips/include/asm/syscall.h               |   6 +
 arch/nds32/include/asm/syscall.h              |  27 +-
 arch/parisc/include/asm/syscall.h             |   7 +
 arch/powerpc/include/asm/syscall.h            |  10 +
 include/linux/tracehook.h                     |   9 +-
 include/uapi/linux/ptrace.h                   |  35 +++
 kernel/ptrace.c                               | 101 ++++++-
 tools/testing/selftests/ptrace/.gitignore     |   1 +
 tools/testing/selftests/ptrace/Makefile       |   2 +-
 .../selftests/ptrace/get_syscall_info.c       | 271 ++++++++++++++++++
 11 files changed, 468 insertions(+), 15 deletions(-)
 create mode 100644 tools/testing/selftests/ptrace/get_syscall_info.c

-- 
ldv
