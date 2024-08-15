Return-Path: <linux-kselftest+bounces-15452-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A280953CA3
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 23:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B44E3282E3F
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 21:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AE014EC51;
	Thu, 15 Aug 2024 21:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qq/oxXOW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FAA1537A4;
	Thu, 15 Aug 2024 21:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723757569; cv=none; b=jH7VdJJFFoqWNbEAR5yd60y5nVyASoSMzeMi1eY3U9aiUIq3HxR5D5sgS/aefID0wptdAn+pL022Hh3uNtz39FB8T1YgIUd4fSgXlR4iiQCDW7GnXek3Trza30jKzRwMnRGgfalj88vKIwkijljZJ/XirjcyoYRZO6otKv1ADgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723757569; c=relaxed/simple;
	bh=//WNbzYpYU+e2ln5VDiF2W/YrA6HlyMjUvhsSCGFMs8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aabSMyRjZt6twH0e8Nnp/xIcvFlyKH7oDuowj0k+lleUJyhX9mLTcYV9EvzHF8rK2TjwkDIgi2CcT9LvrAyJ2fclTmTQL8U3SDxXm/H2DkbqkHOY2tcYHFsToTiLXAYu9quFM3BC+qwvtMhVPR5kQQnXDpIg93/bv6TZTy8Fkyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qq/oxXOW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3113FC32786;
	Thu, 15 Aug 2024 21:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723757569;
	bh=//WNbzYpYU+e2ln5VDiF2W/YrA6HlyMjUvhsSCGFMs8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=qq/oxXOWavPT3+hbtA09RHmrQOnG36JcVAKYJ2j4qibGGPS9V2o/1iidMpnQXOxAR
	 TKX/u12boEdb9PFovcU7zdF9YucEmdL4TXAH9uNFKeh3XnEpfJR9V1I8WlGMkVVzWS
	 PAlsN+OpYqkpIBLTKmlNRmgMT4kbjJlop/G7Clb39lVT1E40AXztSi2xmVa2MZHlU1
	 YCqaxpWf5QKzhFFs2ijhKdtDbY6y69DVkcV7R8k3p8niX5pqy+4DhphAT5aTa7F1pY
	 XRONg58/Ip2Rolt59N7e1q8CDRmC8iEgAGz0VCr5DT+joDv3knuE1oL1ffED7ebfaz
	 LAfzP3zG9pVxA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A8CC3DA7F;
	Thu, 15 Aug 2024 21:32:49 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Subject: [PATCH net-next v3 0/8] net/selftests: TCP-AO selftests updates
Date: Thu, 15 Aug 2024 22:32:25 +0100
Message-Id: <20240815-tcp-ao-selftests-upd-6-12-v3-0-7bd2e22bb81c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOlzvmYC/43OywrCMBAF0F8pWTuaR5+u/A9xkSYTG6hJSWJRp
 P9uLIiuxOVwuefOg0QMFiPZFw8ScLbRepcPsSmIGqQ7I1idb8IpL2kjKCQ1gfQQcTQJY4pwnTT
 UwDiUWmAlZFMaYUjuTwGNva32kThM4PCWyCknvYwIfZBODS/7ne0u0rpXc7Ax+XBfn5rZ2v9jf
 2ZAwRhd9oZVuhbt4ZzBcav8ZV2d+UdqKf8l8SyJhqquE1XLavYtLcvyBAKYSpk2AQAA
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: Mohammad Nassiri <mnassiri@ciena.com>, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Safonov <0x7f454c46@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723757567; l=5573;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=//WNbzYpYU+e2ln5VDiF2W/YrA6HlyMjUvhsSCGFMs8=;
 b=WcN86bjnC908xnl0YKemHzlj5UiSYYu3NmhGQoaipWYAM06enzSuWaHj7dwzlo3yK+1m5bI+G
 IELW8xMHJTHA1YB4sM/6cczcm/xz5bqZq5h9abfycp/0vQUnZN376St
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
 tools/testing/selftests/net/tcp_ao/lib/aolib.h     | 176 ++++++-
 .../testing/selftests/net/tcp_ao/lib/ftrace-tcp.c  | 549 +++++++++++++++++++++
 tools/testing/selftests/net/tcp_ao/lib/ftrace.c    | 466 +++++++++++++++++
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
 20 files changed, 1376 insertions(+), 67 deletions(-)
---
base-commit: a9c60712d71ff07197b2982899b9db28ed548ded
change-id: 20240730-tcp-ao-selftests-upd-6-12-4d3e53a74f3f

Best regards,
-- 
Dmitry Safonov <0x7f454c46@gmail.com>



