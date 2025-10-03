Return-Path: <linux-kselftest+bounces-42739-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D31BB7501
	for <lists+linux-kselftest@lfdr.de>; Fri, 03 Oct 2025 17:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A839E480823
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Oct 2025 15:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6492857CD;
	Fri,  3 Oct 2025 15:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uScpE9gw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C5928507C;
	Fri,  3 Oct 2025 15:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759505068; cv=none; b=BqHGfwULOcobtX1m1GkWM+Lr5hLZ80yFpnIqrAb23xnXyTkWw33p+oBFJh3eXjKXOgSmG9bXtFtIJfWtVTayFwX1PMEp/fpBb2oohgNkeKUThc99AbWw+loK6X2qAmp62VKu/TDb7d+lVKLM1K+XAC1PMzcvKi6tXt/nRThDJTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759505068; c=relaxed/simple;
	bh=DQbc540c3F4b2scI1GiUAhd/lmG2n6h9j6Q7f/kL6PA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PF/aSVtIx95bm4U8p8jeB0LRXFJXaM3Bze7fgs4+JX+DOecaUUPnYlDx/tCfryYEWXM1RhmJEllVcDQ2Aj7TABPD4U/xIJKTGAmnJKZo2V+HyTWHYLIaDKNmXsXlydgZpiPR+ZGaLSYoJjyQIt/qH/AkRIkVekaDNckMHQ01l+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uScpE9gw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08774C4CEF5;
	Fri,  3 Oct 2025 15:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759505067;
	bh=DQbc540c3F4b2scI1GiUAhd/lmG2n6h9j6Q7f/kL6PA=;
	h=From:Date:Subject:To:Cc:From;
	b=uScpE9gwKBXzfsOqJsm8nsTLuyY8dsZmu4CVbMgtH7C3okBfq1cziyx+eSwvIfGU0
	 DjYjQF8St5imJ7he/JHa1lANjODwgVgnyiimp9BC9HfVZ+99bD8xLq+CaxXYhHSnI/
	 e7AJg0YNd1EDn8rwhRLpyPRHYWwnup4Sg8sXdBIKMBbACWlz+lb1XtHdIwmf+UamFE
	 7Nk6XFlkxVGXcbL/km/QdRNVGiRQz9RxUGqprrTede8gGP6x5iw1d5ZpPmb1D4QzCV
	 uuZ2wrLr6fazv7XN8GUph1QAHMc0YfGxBBjqa8GwmYt54C/yaXOOFQa05igBKZLEti
	 2ISx/BcmVFI/Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 03 Oct 2025 17:24:17 +0200
Subject: [PATCH bpf] selftests/bpf: fix implicit-function-declaration
 errors
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251003-bpf-sft-fix-build-err-6-18-v1-1-2a71170861ef@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKDq32gC/x2MwQqDQAwFf0Vy7oPsahfpr5QeVs3WgFjJtqUg/
 nuDx4GZ2amKqVS6NTuZfLXqa3UIl4bGOa9PgU7OFDleA3OLYSuo5Y2iPwwfXSaIGRJCj5S7kdt
 YUs+ZfLCZuHXO7+QdPY7jD0VWMm9xAAAA
X-Change-ID: 20251003-bpf-sft-fix-build-err-6-18-6a4c032f680a
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6355; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=DQbc540c3F4b2scI1GiUAhd/lmG2n6h9j6Q7f/kL6PA=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLuv1oe9TQgbcvhc1tWTA27r1zjXS04JeVS00qtaYw2O
 30ZPNXaO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACayP5rhv9Pj04ERzaufnPq+
 xW/FnIyQ1U41sRqdAnVvfyxlivh4lY2RYbFWa0DUrrCz/70U1vnunjk3sm2BUU32XUUGv5XvPgS
 XswMA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When trying to build the latest BPF selftests, with a debug kernel
config, Pahole 1.30 and CLang 20.1.8 (and GCC 15.2), I got these errors:

  progs/dynptr_success.c:579:9: error: call to undeclared function 'bpf_dynptr_slice'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    579 |         data = bpf_dynptr_slice(&ptr, 0, NULL, 1);
        |                ^
  progs/dynptr_success.c:579:9: note: did you mean 'bpf_dynptr_size'?
  .virtme/build-debug-btf//tools/include/vmlinux.h:120280:14: note: 'bpf_dynptr_size' declared here
   120280 | extern __u32 bpf_dynptr_size(const struct bpf_dynptr *p) __weak __ksym;
          |              ^
  progs/dynptr_success.c:579:7: error: incompatible integer to pointer conversion assigning to '__u64 *' (aka 'unsigned long long *') from 'int' [-Wint-conversion]
    579 |         data = bpf_dynptr_slice(&ptr, 0, NULL, 1);
        |              ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  progs/dynptr_success.c:596:9: error: call to undeclared function 'bpf_dynptr_slice'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    596 |         data = bpf_dynptr_slice(&ptr, 0, NULL, 10);
        |                ^
  progs/dynptr_success.c:596:7: error: incompatible integer to pointer conversion assigning to 'char *' from 'int' [-Wint-conversion]
    596 |         data = bpf_dynptr_slice(&ptr, 0, NULL, 10);
        |              ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

I don't have these errors without the debug kernel config from
kernel/configs/debug.config. With the debug kernel, bpf_dynptr_slice()
is not declared in vmlinux.h. It is declared there without debug.config.

The fix is similar to what is done in dynptr_fail.c which is also using
bpf_dynptr_slice(): bpf_kfuncs.h is now included.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - This patch looks wrong, I guess bpf_dynptr_slice() should be in
   vmlinux.h even with a "debug" kernel, but it is not:
   $ grep -cw bpf_dynptr_slice .virtme/build-debug-btf/tools/include/vmlinux.h
   0
   $ grep -w bpf_dynptr_slice .virtme/build-btf/tools/include/vmlinux.h
   extern void *bpf_dynptr_slice(...) __weak __ksym;
 - This is on top of bpf/master: commit 63d2247e2e37, tag bpf-fixes.
 - I only see this error when using kernel/configs/debug.config.
 - Because this has not been spot by the BPF CI, I wonder if I'm
   building the BPF selftests properly... Here is what I did:
   $ virtme-configkernel --arch x86_64 --defconfig \
     --custom tools/testing/selftests/net/mptcp/config \
     --custom kernel/configs/debug.config \
     --custom tools/testing/selftests/bpf/config \
     O=${PWD}/.virtme/build-debug-btf
   $ ./scripts/config --file ${PWD}/.virtme/build-debug-btf/.config \
     -e NET_NS_REFCNT_TRACKER -d SLUB_DEBUG_ON \
     -d DEBUG_KMEMLEAK_AUTO_SCAN -e PANIC_ON_OOPS \
     -e SOFTLOCKUP_DETECTOR -e BOOTPARAM_SOFTLOCKUP_PANIC \
     -e HARDLOCKUP_DETECTOR -e BOOTPARAM_HUNG_TASK_PANIC \
     -e DETECT_HUNG_TASK -e BOOTPARAM_HUNG_TASK_PANIC -e DEBUG_INFO \
     -e DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT -e GDB_SCRIPTS \
     -e DEBUG_INFO_DWARF4 -e DEBUG_INFO_COMPRESSED \
     -e DEBUG_INFO_COMPRESSED_ZLIB -e DEBUG_INFO_BTF_MODULES \
     -e MODULE_ALLOW_BTF_MISMATCH -d IA32_EMULATION -e DYNAMIC_DEBUG \
     --set-val CONSOLE_LOGLEVEL_DEFAULT 8 -e FTRACE -e FUNCTION_TRACER \
     -e DYNAMIC_FTRACE -e FTRACE_SYSCALLS -e HIST_TRIGGERS -e DEBUG_NET \
     -m KUNIT -e KUNIT_DEBUGFS -d KUNIT_ALL_TESTS -m MPTCP_KUNIT_TEST \
     -e BPF_JIT -e BPF_SYSCALL -e TUN -e CRYPTO_USER_API_HASH \
     -e CRYPTO_SHA1 -e NET_SCH_TBF -e BRIDGE -d RETPOLINE -d PCCARD \
     -d MACINTOSH_DRIVERS -d SOUND -d USB_SUPPORT -d NEW_LEDS -d SCSI \
     -d SURFACE_PLATFORMS -d DRM -d FB -d ATA -d MISC_FILESYSTEMS
     # sorry, long list used by the MPTCP CI to accelerate builds, etc.
   $ make O=${PWD}/.virtme/build-debug-btf olddefconfig
   $ make O=${PWD}/.virtme/build-debug-btf -j$(nproc) -l$(nproc)
   $ make O=${PWD}/.virtme/build-debug-btf headers_install \
     INSTALL_HDR_PATH=${PWD}/.virtme/headers
   $ make O=${PWD}/.virtme/build-debug-btf \
     KHDR_INCLUDES=-I${PWD}/.virtme/headers/includes \
     -C tools/testing/selftests/bpf
 - The errors I got should be reproducible using:
   $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
     -e INPUT_EXTRA_ENV=INPUT_RUN_TESTS_ONLY=bpftest_all \
     --pull always mptcp/mptcp-upstream-virtme-docker:latest \
     auto-btf-debug
 - These issues were originally spot by our MPTCP CI:
   https://github.com/multipath-tcp/mptcp_net-next/actions/runs/18222911614/job/51886811332
 - No errors without kernel/configs/debug.config on the CI and on my side
 - This CI got different issues, and I had to declare more kfuncs there:
   https://github.com/multipath-tcp/mptcp_net-next/commit/4435d4da9f4f
   but this CI is currently on top of 'net', with Jiri's patches from
   https://lore.kernel.org/20251001122223.170830-1-jolsa@kernel.org
 - The builds have been done from a clean build directory each time.
 - Do you think the issue is on my side? Dependences? How the selftests
   are built? I didn't change the way the BPF selftests are built for a
   while. I had other issues with pahole 1.29, but fixed with 1.30.
 - Feel free to discard this patch for a better solution (if any).
 - I don't know which Fixes tag adding, but I doubt this patch is valid.
---
 tools/testing/selftests/bpf/progs/dynptr_success.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/testing/selftests/bpf/progs/dynptr_success.c
index 127dea342e5a67dda33e0a39e84d135206d2f3f1..60daf5ce8eb283d8c8bf2d7853eda6313df4fa87 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_success.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -6,6 +6,7 @@
 #include <stdbool.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
+#include "bpf_kfuncs.h"
 #include "bpf_misc.h"
 #include "errno.h"
 

---
base-commit: 63d2247e2e37d9c589a0a26aa4e684f736a45e29
change-id: 20251003-bpf-sft-fix-build-err-6-18-6a4c032f680a

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


