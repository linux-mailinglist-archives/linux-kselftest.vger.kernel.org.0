Return-Path: <linux-kselftest+bounces-3886-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD305844A5F
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 22:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7959A282727
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 21:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AD139AE3;
	Wed, 31 Jan 2024 21:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHFgd8MI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E313E39ACA;
	Wed, 31 Jan 2024 21:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706737828; cv=none; b=dzm3JNdwsElvnW2z+HuYJ/UkT2wNyJNPndb5T79x6kV65RcLHSSWsAPupp6GLP3VfE/q0X0oxBh4HzbfiXeuv9oDOzfIzzXs09JdtilJg5xkYoy1fHn1hs+MpQRQe1HXTu/rAWk0Nwd3ZRZWK3wtZajxkJH6J+IIfwziLAWPhE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706737828; c=relaxed/simple;
	bh=VA4S5+OXGEre7LcIjG8/DyUIQAvRbZd0CUxocr8qS9s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cjrqCcc8qHf/1F9Qu31YLpeUUY9n05PF20VhKRtdQQWP+thlFZyvU6gSzUPJCLprap7CgFIggei3N7XlNhRc3D+r1UJclUcSY8iPlJZN8J8aVjjYKVdxTlIx/pjvbvJe0zmKe7vASyEHCz77Zgo8lsNPHEf1KU5wRie7AIPzNtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHFgd8MI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4E0C433F1;
	Wed, 31 Jan 2024 21:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706737827;
	bh=VA4S5+OXGEre7LcIjG8/DyUIQAvRbZd0CUxocr8qS9s=;
	h=From:Subject:Date:To:Cc:From;
	b=MHFgd8MIfCmRKwBb9sVyA6Lp5gZtz2QK8L0SkpzL7DpxVzPPCHqqS60vq5t+4yEjK
	 q4SxM/xC7O4wI7Atnr76WTxskuUGOWHm1fq/LWIKKjDCc2N9NWjMJreVkJ+ydC1DJX
	 E/aqVqfJRdCbYRIGdv1m9t1SkVqnZb/r+NKAoem/4EMkCgQoc+wiistnQVdTFN1Fs/
	 IoMPQBZxYKGIMLkPcGtNcqNAaCRuqM995PyyxI/637DuHgyXSGz/P/UNllsj2kCOkX
	 wXTCUrnCReR3m/Rir3D1HjKP/VYbNPIMOsrZKeSWsn0GfacejnZO7NpdOOnW7oGX8k
	 SuWIkM1U+dOrA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 0/9] mptcp: fixes for recent issues reported by CI's
Date: Wed, 31 Jan 2024 22:49:45 +0100
Message-Id: <20240131-upstream-net-20240131-mptcp-ci-issues-v1-0-4c1c11e571ff@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHnAumUC/z2NywqDMBBFf0Vm3YFErY/+inSh8badhTFkYhHEf
 zd00eW5cO45SBEFSo/ioIivqKw+g70V5D6jf4NlzkylKWtjK8tb0BQxLuyR+L8uIbnATlhUNyj
 3c9NN98ZYtDXlrxDxkv3XGSib9DzPC0Aha6V8AAAA
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang.tang@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3030; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=VA4S5+OXGEre7LcIjG8/DyUIQAvRbZd0CUxocr8qS9s=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlusCf5pZ5h12sBggnu3rqTutMrwEJMixZM7Mak
 joQhVGjV0SJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZbrAnwAKCRD2t4JPQmmg
 c3HQD/9D86lvkLEUa+sCkWAGbpXGChRs4bcLbsOBUCZlo6uhsTraKYGWataaPWcHPothtvFs8Tm
 jOd+e3oqBPKzN4laDIsjuaQKGyxicLY00zdvBa8rWR74cccSPcjsp4IeRpJkqy0xk/mUItgd2/I
 Je+zISNODFd6SVb732WQS5/Q+SYgdPY6BypHY9XXV9ZcfExKuj+mo+CSxIWNnR5+gh+aGn8scnr
 E1278aCvLAVSuxvKOgvA3QKdQVLtM5fLC9ubWp6V1LJ9e+rmjqhktmmTp3JZZghqgyNyZsJVzS4
 tE7rVNtJoii78/jidC6zPyf2ek3fqhckkYnqiNDdVWwdVyoXpmJ6itD/yDUfESzzerhkw34AgYc
 x9AfBbheJa+FE6EVfmvnf55Xn+pj4CptiAdBvomTyQGMMvZ4z5McRMbIsycJniMoT4OExODe1f4
 8bg6GxiLtCVBSu22r9h+RynGJAziLjGNQFphkGJXdYeLBnmCDH4AZGaLMDFNZ8pvqaFUNV/tXU+
 RvQBdPRR/v+HDnN/v1+IZmmpbhAtfrumVpkVGoHMDEb2e3dF+8NsNdRuDjjt1cHKTyrDsVUc2dI
 mcF1gWPokwY5rLbIuTr2w5plZ6IbOQlj7rQbE91Dahe9GXz4FPY0OKmWTZqeQHkinSdlRkK5WQx
 Q/X/0he1GSWeDMQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This series of 9 patches fixes issues mostly identified by CI's not
managed by the MPTCP maintainers. Thank you Linero (LKFT) and Netdev
maintainers (NIPA) for running our kunit and selftests tests!

For the first patch, it took a bit of time to identify the root cause.
Some MPTCP Join selftest subtests have been "flaky", mostly in slow
environments. It appears to be due to the use of a TCP-specific helper
on an MPTCP socket. A fix for kernels >= v5.15.

Patches 2 to 4 add missing kernel config to support NetFilter tables
needed for IPTables commands. These kconfigs are usually enabled in
default configurations, but apparently not for all architectures.
Patches 2 and 3 can be backported up to v5.11 and the 4th one up to
v5.19.

Patch 5 increases the time limit for MPTCP selftests. It appears that
many CI's execute tests in a VM without acceleration supports, e.g. QEmu
without KVM. As a result, the tests take longer. Plus, there are more
and more tests. This patch modifies the timeout added in v5.18.

Patch 6 reduces the maximum rate and delay of the different links in
some Simult Flows selftest subtests. The goal is to let slow VMs reach
the maximum speed. The original rate was introduced in v5.11.

Patch 7 lets CI changing the prefix of the subtests titles, to be able
to run the same selftest multiple times with different parameters. With
different titles, tests will be considered as different and not override
previous results as it is the case with some CI envs. Subtests have been
introduced in v6.6.

Patch 8 and 9 make some MPTCP Join selftest subtests quicker by stopping
the transfer when the expected events have been seen. Patch 8 can be
backported up to v6.5.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (8):
      selftests: mptcp: add missing kconfig for NF Filter
      selftests: mptcp: add missing kconfig for NF Filter in v6
      selftests: mptcp: add missing kconfig for NF Mangle
      selftests: mptcp: increase timeout to 30 min
      selftests: mptcp: decrease BW in simult flows
      selftests: mptcp: allow changing subtests prefix
      selftests: mptcp: join: stop transfer when check is done (part 1)
      selftests: mptcp: join: stop transfer when check is done (part 2)

Paolo Abeni (1):
      mptcp: fix data re-injection from stale subflow

 net/mptcp/protocol.c                              |  3 ---
 tools/testing/selftests/net/mptcp/config          |  3 +++
 tools/testing/selftests/net/mptcp/mptcp_join.sh   | 27 +++++++++--------------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh    |  2 +-
 tools/testing/selftests/net/mptcp/settings        |  2 +-
 tools/testing/selftests/net/mptcp/simult_flows.sh |  8 +++----
 6 files changed, 20 insertions(+), 25 deletions(-)
---
base-commit: c9ec85153fea6873c52ed4f5055c87263f1b54f9
change-id: 20240131-upstream-net-20240131-mptcp-ci-issues-9d68b5601e74

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


