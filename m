Return-Path: <linux-kselftest+bounces-14416-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B531A940432
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 04:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DA8B1F21B2C
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 02:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B751110957;
	Tue, 30 Jul 2024 02:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EANiDsCK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F782A1C7;
	Tue, 30 Jul 2024 02:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722305609; cv=none; b=GTpjjKZHt0aqINPRBCcvbssrSgHupqgvAzCwivRLiscgbTDadOShP+fXdmDGGe92MGDAyov2GDFi88f7RdHH9k01B7AU33RoLZDv3Naw9xCrrCTmAi10f+5hON0ncgVzZNrd45iYh0e4SG3Fu3BU2+58X01OBjTdIbpxaB+Dfe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722305609; c=relaxed/simple;
	bh=eT7i2g1f0cqiBayr0fps7NZWteEXD2+sswiVQeadjT0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hY9mMoj7dFanpm71Q+ndxqcxlu63Y4XH//3y6J4m8j8amfvjmRtax0ZGqnl0HenXm7dvibvzYE3si3tGS19ClVKXQpjlThmQUmnCLPdeWR+PEDi5e7sL1rj+68unCJokN+hPp/rfqKq2wRz/YQpeZB2RK+LwdKheR436rXtY50g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EANiDsCK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 644B1C32786;
	Tue, 30 Jul 2024 02:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722305609;
	bh=eT7i2g1f0cqiBayr0fps7NZWteEXD2+sswiVQeadjT0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=EANiDsCKCwN1BcfKnnPKFzk+A4oASxkcYKAW7mzo0rcnO7fDKg3rX6+j8Ssk7PAJn
	 jt695q6tVpueSXIkti40bvOJvDqqnZlPHKP7T2hY0D3yLVmnFJBMkqlmK5ttfv77KE
	 5oPmrOYHorl9B3xGzr1/7g+NMA2F+ZEOYxX9wTNmT3yUdbKJgGos3Zk9kMbGPevo/f
	 pefASRurRmrbcCV9I1wlhy2Wn1mwGyqWpgK/COaze44pBaxCa9awUHtbOW6zPlFeEp
	 E3Umy4PeNh5mMmfuyvlp360uvuEhAVW/fy8lMRGrfcp9S0KfRYF/bdh4w5JcEAnVc5
	 /853aQw/Of0Sw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFF4C3DA61;
	Tue, 30 Jul 2024 02:13:29 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Subject: [PATCH net-next 0/7] net/selftests: TCP-AO selftests updates
Date: Tue, 30 Jul 2024 03:12:14 +0100
Message-Id: <20240730-tcp-ao-selftests-upd-6-12-v1-0-ffd4bf15d638@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP5LqGYC/zWMQQrCMBAAv1L27GKaRAt+RTykycYu6LZkoxRK/
 24UPA7DzAZKhUnh0m1Q6M3KszToDx3EKcidkFNjsMZ6MziDNS4YZlR65EpaFV9LwjP2Fn1ydHJ
 h8NllaP1SKPP6e19BqKLQWuHWzBiUcCxB4vR9/93xGVhg3z+pIXEblQAAAA==
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: Mohammad Nassiri <mnassiri@ciena.com>, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Safonov <0x7f454c46@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722305607; l=4552;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=eT7i2g1f0cqiBayr0fps7NZWteEXD2+sswiVQeadjT0=;
 b=W8S01ZXd8hQdRgKdXK/TejkLDTeSThgq+hIMh9IPKnziRno0w9cYPY4pY4U4byFp3tRMz9+us
 vbc/rEvyDRaCZt6zP49ico7JsdOU5n5ZD0C3GxLy4wd5EmP+04PnIIo
X-Developer-Key: i=0x7f454c46@gmail.com; a=ed25519;
 pk=cFSWovqtkx0HrT5O9jFCEC/Cef4DY8a2FPeqP4THeZQ=
X-Endpoint-Received: by B4 Relay for 0x7f454c46@gmail.com/20240410 with
 auth_id=152
X-Original-From: Dmitry Safonov <0x7f454c46@gmail.com>
Reply-To: 0x7f454c46@gmail.com

First 4 patches are more-or-less cleanups/preparations.

Patch 5 was sent to me/contributed off-list by Mohammad, who wants 32-bit
kernels to run TCP-AO.

Patch 6 is a workaround/fix for slow VMs. Albeit, I can't reproduce
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
Dmitry Safonov (6):
      selftests/net: Clean-up double assignment
      selftests/net: Provide test_snprintf() helper
      selftests/net: Be consistent in kconfig checks
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
 tools/testing/selftests/net/tcp_ao/lib/aolib.h     | 173 ++++++-
 .../testing/selftests/net/tcp_ao/lib/ftrace-tcp.c  | 549 +++++++++++++++++++++
 tools/testing/selftests/net/tcp_ao/lib/ftrace.c    | 466 +++++++++++++++++
 tools/testing/selftests/net/tcp_ao/lib/kconfig.c   |  31 +-
 tools/testing/selftests/net/tcp_ao/lib/setup.c     |  15 +-
 tools/testing/selftests/net/tcp_ao/lib/sock.c      |   1 -
 tools/testing/selftests/net/tcp_ao/lib/utils.c     |  26 +
 tools/testing/selftests/net/tcp_ao/restore.c       |  30 +-
 tools/testing/selftests/net/tcp_ao/rst.c           |   2 +-
 tools/testing/selftests/net/tcp_ao/self-connect.c  |  19 +-
 tools/testing/selftests/net/tcp_ao/seq-ext.c       |  28 +-
 .../selftests/net/tcp_ao/setsockopt-closed.c       |   6 +-
 tools/testing/selftests/net/tcp_ao/unsigned-md5.c  |  35 +-
 20 files changed, 1374 insertions(+), 64 deletions(-)
---
base-commit: 1722389b0d863056d78287a120a1d6cadb8d4f7b
change-id: 20240730-tcp-ao-selftests-upd-6-12-4d3e53a74f3f

Best regards,
-- 
Dmitry Safonov <0x7f454c46@gmail.com>



