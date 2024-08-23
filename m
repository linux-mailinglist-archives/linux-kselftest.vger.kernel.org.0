Return-Path: <linux-kselftest+bounces-16191-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B50A395D8FE
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Aug 2024 00:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED1A7B21445
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 22:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BFA1C8706;
	Fri, 23 Aug 2024 22:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lgzenTY5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E568B1925A9;
	Fri, 23 Aug 2024 22:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724450719; cv=none; b=G8tUdn2YzNIdunywRuf/Fx1I8VMDJiDsOKAAk3VAlv6RfC57f1jFjTzRHhGhNPZUCWRCNatz5n4wMUJAV6CfxVpx41csiiepWl5iJWdvZlqyqLCgKWBFB9tMRmBceiFR8uafMPlg3cpxlI3rgZ+HYXyHDmxonVGvMAPoiXiVGJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724450719; c=relaxed/simple;
	bh=00/hRY2St6smjH+qPVtGASwckV3jdDCNNYiKkVoISUk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ewSxwxE+olYaTTQN8l6d+QvIkMXsuWXIBjA1UdpdLJYkUwF03j8LbNVMrT5UFS/IXN0vIDlpR/qrWO5Gf76bKpCtiOiCll+OBT0UmeHLsrJjrxmdZ/OY0z9cAcGXByfIv6VCFSRm0GMRWjqQG/3xfv5P3fVqLZsjrjRQD5SJ6QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lgzenTY5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7CBB4C32786;
	Fri, 23 Aug 2024 22:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724450718;
	bh=00/hRY2St6smjH+qPVtGASwckV3jdDCNNYiKkVoISUk=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=lgzenTY5Du/X1qW5MrIiT4w3AtGh+a/ACeaT5ClSAthaAoxdd8EgfsGvmrwLiYq3x
	 wgaX8RVG0908drMVMNextDq999fiEF3nhiAM2pL5FcJ9KU3UrFsSeV/JOawYqOY3M5
	 4EYw3QS61g0VBjlTPyFY/7MxbhvaFM8XEuAI+aZOyxLR7B0sVcvcYhFTzHzVF04XMY
	 0Y3RlNWs8Lkl+gHdwFCNApuPUcKXpRyqkoXRw+mj3jiMYiIxEGCK6wXMb59akcleLZ
	 69O7Wt/0P6oIzxTWED1laQYx0JjuP+D6b4ArofFEqgmvR1Q4s4nlU+tES0NiXTpvk4
	 xymKEk+RejlMA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3F5C5321E;
	Fri, 23 Aug 2024 22:05:18 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Subject: [PATCH net-next v4 0/8] net/selftests: TCP-AO selftests updates
Date: Fri, 23 Aug 2024 23:04:50 +0100
Message-Id: <20240823-tcp-ao-selftests-upd-6-12-v4-0-05623636fe8c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIIHyWYC/43Oy27CMBAF0F9BXjNgj50HXfU/UBd+jIklcCLbR
 FQo/46JVBV1gbocXd1z584ypUCZfWzuLNEcchhjPdR2w+yg44kguHoz5Kh4JzkUO4EeIdPZF8o
 lw3Vy0IJAUE5SI3WnvPSs9qdEPtxW+8giFYh0K+yrJkZnApN0tMPT/sn2Fx3iszmEXMb0vT41i
 7X/j/1ZAAfvnTJeNK6V/eepguedHS/r6oy/Us/xnYRVkh23h4NsetGKv5J8kUTzTpJV6oxDQjS
 mF/ZVWpblARSPz9iAAQAA
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: Mohammad Nassiri <mnassiri@ciena.com>, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Safonov <0x7f454c46@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724450716; l=6128;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=00/hRY2St6smjH+qPVtGASwckV3jdDCNNYiKkVoISUk=;
 b=LLdsbvwe7QMcV2qL4+slz/DajRlCb/NNbHH5+us/V6Hsf+ppwqS7RmHLVH++3C01rlMXNshLm
 6NQYPo+IfQuBHCSn4LW0MzS/rs7ulah/k3CzPoFEk9OJ2GS8xlzRbfK
X-Developer-Key: i=0x7f454c46@gmail.com; a=ed25519;
 pk=cFSWovqtkx0HrT5O9jFCEC/Cef4DY8a2FPeqP4THeZQ=
X-Endpoint-Received: by B4 Relay for 0x7f454c46@gmail.com/20240410 with
 auth_id=152
X-Original-From: Dmitry Safonov <0x7f454c46@gmail.com>
Reply-To: 0x7f454c46@gmail.com

First 3 patches are more-or-less cleanups/preparations.

Patches 4/5 are fixes for netns file descriptors leaks/open.

Patch 6 was sent to me/contributed off-list by Mohammad, who wants 32-bit
kernels to run TCP-AO.

Patch 7 is a workaround/fix for slow VMs. Albeit, I can't reproduce
the issue, but I hope it will fix netdev flakes for connect-deny-*
tests.

And the biggest change is adding TCP-AO tracepoints to selftests.
I think it's a good addition by the following reasons:
- The related tracepoints are now tested;
- It allows tcp-ao selftests to raise expectations on the kernel
  behavior - up from the syscalls exit statuses + net counters.
- Provides tracepoints usage samples.

As tracepoints are not a stable ABI, any kernel changes done to them
will be reflected to the selftests, which also will allow users
to see how to change their code. It's quite better than parsing dmesg
(what BGP was doing pre-tracepoints, ugh).

Somewhat arguably, the code parses trace_pipe, rather than uses
libtraceevent (which any sane user should do). The reason behind that is
the same as for rt-netlink macros instead of libmnl: I'm trying
to minimize the library dependencies of the selftests. And the
performance of formatting text in kernel and parsing it again in a test
is not critical.

Current output sample:
> ok 73 Trace events matched expectations: 13 tcp_hash_md5_required[2] tcp_hash_md5_unexpected[4] tcp_hash_ao_required[3] tcp_ao_key_not_found[4]

Previously, tracepoints selftests were part of kernel tcp tracepoints
submission [1], but since then the code was quite changed:
- Now generic tracing setup is in lib/ftrace.c, separate from
  lib/ftrace-tcp.c which utilizes TCP trace points. This separation
  allows future selftests to trace non-TCP events, i.e. to find out
  an skb's drop reason, which was useful in the creation of TCP-CLOSE
  stress-test (not in this patch set, but used in attempt to reproduce
  the issue from [2]).
- Another change is that in the previous submission the trace events
  where used only to detect unexpected TCP-AO/TCP-MD5 events. In this
  version the selftests will fail if an expected trace event didn't
  appear.
  Let's see how reliable this is on the netdev bot - it obviously passes
  on my testing, but potentially may require a temporary XFAIL patch
  if it misbehaves on a slow VM.

[1] https://lore.kernel.org/lkml/20240224-tcp-ao-tracepoints-v1-0-15f31b7f30a7@arista.com/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=33700a0c9b56

Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
---
In v4 mostly worked on non-appearing events on netdev test VM.
- Set up x86 VM with the config from netdev & run stress-ng didn't
  reproduce the isssue.
- Spread more error messages if tracing pthread fails to start
- Added conditional wait for tracer thread, just before destruction, in
  case it didn't had a time slice to run and parse trace events.
- Addressed some of checkpatch.pl --strict warnings (with
  nits from Simon Horman)
- Link to v3: https://lore.kernel.org/r/20240815-tcp-ao-selftests-upd-6-12-v3-0-7bd2e22bb81c@gmail.com

Changes in v3:
- Corrected the selftests printing of tcp header flags, parsed from
  trace points
- Fixed an issue with VRF kconfig checks (and tests)
- Made check for unexpected trace events XFAIL, yet looking into the
  reason behind the fail
- Link to v2: https://lore.kernel.org/r/20240802-tcp-ao-selftests-upd-6-12-v2-0-370c99358161@gmail.com

Changes in v2:
- Fixed two issues with parsing TCP-AO events: the socket state and TCP
  segment flags. Hopefully, won't fail on netdev.
- Reword patch 1 & 2 messages to be more informative and at some degree
  formal (Paolo)
- Since commit e33a02ed6a4f ("selftests: Add printf attribute to
  kselftest prints") it's possible to use __printf instead of "raw" gcc
  attribute - switch using that, as checkpatch suggests.
- Link to v1: https://lore.kernel.org/r/20240730-tcp-ao-selftests-upd-6-12-v1-0-ffd4bf15d638@gmail.com

---
Dmitry Safonov (7):
      selftests/net: Clean-up double assignment
      selftests/net: Provide test_snprintf() helper
      selftests/net: Be consistent in kconfig checks
      selftests/net: Open /proc/thread-self in open_netns()
      selftests/net: Don't forget to close nsfd after switch_save_ns()
      selftests/net: Synchronize client/server before counters checks
      selftests/net: Add trace events matching to tcp_ao

Mohammad Nassiri (1):
      selftests/tcp_ao: Fix printing format for uint64_t

 tools/testing/selftests/net/tcp_ao/Makefile        |   3 +-
 tools/testing/selftests/net/tcp_ao/bench-lookups.c |   2 +-
 tools/testing/selftests/net/tcp_ao/config          |   1 +
 tools/testing/selftests/net/tcp_ao/connect-deny.c  |  25 +-
 tools/testing/selftests/net/tcp_ao/connect.c       |   6 +-
 tools/testing/selftests/net/tcp_ao/icmps-discard.c |   2 +-
 .../testing/selftests/net/tcp_ao/key-management.c  |  18 +-
 tools/testing/selftests/net/tcp_ao/lib/aolib.h     | 178 ++++++-
 .../testing/selftests/net/tcp_ao/lib/ftrace-tcp.c  | 559 +++++++++++++++++++++
 tools/testing/selftests/net/tcp_ao/lib/ftrace.c    | 543 ++++++++++++++++++++
 tools/testing/selftests/net/tcp_ao/lib/kconfig.c   |  31 +-
 tools/testing/selftests/net/tcp_ao/lib/setup.c     |  17 +-
 tools/testing/selftests/net/tcp_ao/lib/sock.c      |   1 -
 tools/testing/selftests/net/tcp_ao/lib/utils.c     |  26 +
 tools/testing/selftests/net/tcp_ao/restore.c       |  30 +-
 tools/testing/selftests/net/tcp_ao/rst.c           |   2 +-
 tools/testing/selftests/net/tcp_ao/self-connect.c  |  19 +-
 tools/testing/selftests/net/tcp_ao/seq-ext.c       |  28 +-
 .../selftests/net/tcp_ao/setsockopt-closed.c       |   6 +-
 tools/testing/selftests/net/tcp_ao/unsigned-md5.c  |  35 +-
 20 files changed, 1465 insertions(+), 67 deletions(-)
---
base-commit: f9db28bb09f46087580f2a8da54bb0aab59a8024
change-id: 20240730-tcp-ao-selftests-upd-6-12-4d3e53a74f3f

Best regards,
-- 
Dmitry Safonov <0x7f454c46@gmail.com>



