Return-Path: <linux-kselftest+bounces-6117-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BB8876CBF
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 23:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC6DE1F226C1
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 22:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554EB5FEF4;
	Fri,  8 Mar 2024 22:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2LC/ApK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209AD24B5B;
	Fri,  8 Mar 2024 22:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709935822; cv=none; b=BkWSJAKtawy4pOIESv2HJaKJga8EfNcy6oFvg45QczyoL3VugyPNcwe4L2PaGxpO/sV5SYDiB2tCNSs1xx5y4DMcS960xdduPSefa7RdAeANotEf9jM0G5VWk5elB+BHgIbaxjvYjEkpVNVweKj0YiJP6n1vVlaqe/GgsmmPsco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709935822; c=relaxed/simple;
	bh=JIxUciwVa8bzLAqmaXJhXCld/T6pcGUs1jfkE0sEc50=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fw+Bd95324GMLaScg2ASkaVb6g2cffU7ZG/+he3+adm+dZoUL2ksidSyxLaQEMzILNddfzn5F1qNHDEuT8zIF8auPGHesV3Z8niqX6QDZXIunf20tZUKkN+n1LmS7t3bJmDiL3UeJSg4WHHTqWtrOQvm/gAJJdComxK9fks0y8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2LC/ApK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 659A2C433F1;
	Fri,  8 Mar 2024 22:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709935821;
	bh=JIxUciwVa8bzLAqmaXJhXCld/T6pcGUs1jfkE0sEc50=;
	h=From:Subject:Date:To:Cc:From;
	b=O2LC/ApKFv3kKthz3zwVJCgCNdJKl7OLmwvoj+dzh/DqaDo2MYDT5FXYcfG/9UKJ8
	 nhfHoKUpBi72GPf8x4JnaASrKFVMYida12XU7Dcy4b8Zd5FRGIfDg68gdMENYhfWki
	 fDS+fMVrrUoLOOJEl56rDM56HdoFmX+CTwLNEmdAWloXCnXyi+rlgnLjLCX5CodM5m
	 Hyc8xpPron+yxKBCgBDn5jmNdbdNrLnyvogS+XYIvv+jfqO9JtgVHDF9dcQ8EgAWcQ
	 1IEpzdrzilkEOQaQipBETCTETrGIPG2LPttfPHFZS3pQo0SqnsOskqUlL6lJnvxPo5
	 Il+PsXFb3crwA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next 00/15] selftests: mptcp: various improvements
Date: Fri, 08 Mar 2024 23:10:07 +0100
Message-Id: <20240308-upstream-net-next-20240308-selftests-mptcp-unification-v1-0-4f42c347b653@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL+M62UC/z2NQQrCQAxFr1KyNjCtUgevIi6GNNGAHYdJKoXSu
 zsIuviLx4f3NjCuygaXboPKbzV95Qb9oQN6pHxn1KkxDGE4hWOIuBTzymnGzN62Ov4v46c4mxv
 OxangklWUkjcljpP050gUZUzQ5KWy6PoNX+Gngtu+fwBxzOGakgAAAA==
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, Geliang Tang <tanggeliang@kylinos.cn>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3328; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=JIxUciwVa8bzLAqmaXJhXCld/T6pcGUs1jfkE0sEc50=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl64zI0uZFA0FjpRYfDGXXfdO0C8/RQ0mFGOuPF
 RSD6na+38WJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeuMyAAKCRD2t4JPQmmg
 c0l+EADsHYXdOhF3YbBxsBXHpP95w2yKVpcJm8ignaylgQorQof1mcRIQ3zfPQsLR6J2Ff/HHMR
 NK6iSS6GzYqCn1EomzxlNjS4gcRjJFjIdiEg3VdmZo687YQHeObw3RnuMzBOdWmESXjer4ENMAo
 TqGq6rgZe0GhE/0vLw5dtToLl+yRGihN9DoysAwB+y8ugSuDNBjfNRqM6CU+sHhRenKZmxiLYqF
 /2Ajs41PMKGJ2c4v8FTw3qtEErF6XRTB3frwBemSahx2N0p/2DE5a5N25TXvTelydVKMzbnUQuo
 sznqsRBjavuf2R2FbUTBRJ9/L2MMmtrHg+I9eFUvHP1hZktBeXbHsYkvPnlQYaGauZspXV4lCxU
 HBYGt116v2JwBuDNJ45iSjSt6s50eSq/pOoGib8WxUwAy1QQaRyZpPSaIL6XUdq3yu1MmRKz+BS
 ehRH0HubI0+39g34MHQT30Gs0R7HUtPdnM9jMgunxmExgrOlpLmqs+ADvH6/jYvXYDavGr4qgjL
 LbIUZB+yf/0e9c9D2Wjwbsgr3FyDR7gCMhpiXKqyoqWK9/CgAvXIsU689M23sRHwyDJthhDNzeE
 8f0uKQQtGWsNhYgu5vTfV2iif0O72j8CPvxfR6CjStFV2onTMmdlR4QsFogkLrpJ4J2qbymrmTp
 ZFTJv5m2EixhbjQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In this series from Geliang, there are various improvements in MPTCP
selftests: sharing code, doing actions the same way, colours, etc.

Patch 1 prints all error messages to stdout: what was done in almost all
other MPTCP selftests. This can be now easily changed later if needed.

Patch 2 makes sure the test counter is continuous in mptcp_connect.sh.

Patch 3 aligns the messages that are printed in mptcp_connect.sh.

Patch 4 prints each test results in mptcp_sockopt.sh, similar to what we
have in the TAP output.

Patch 5 moves the different test counters to a single one in
mptcp_lib.sh, to uniform how it is used.

Patch 6 moves how titles are printed from mptcp_join.sh to the lib, to
be reused in patch 7 by all other MPTCP selftests.

Patch 8 uses the '+=' operator to append strings instead of repeating
twice the variable name: that's shorter, easier to read.

Patch 9 adds colours for the [ OK ], [SKIP], [FAIL] and INFO keywords in
all MPTCP selftests.

Patch 10 to 12 are some preparation patches for patch 13: patch 10
modifies how some 'test_fail' helpers, patch 11 moves a helper from
userspace_pm.sh to the lib, and patch 12 changes where titles are
printed in userspace_pm.sh. Patch 13 moves some duplicated helpers from
mptcp_join.sh and userspace_pm.sh to mptcp_lib.sh.

Patch 14 moves duplicated read-only variables from mptcp_join.sh and
userspace_pm.sh to mptcp_lib.sh as well.

Patch 15 uses explicit variables instead of hard-coded numbers for the
exit status.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Geliang Tang (15):
      selftests: mptcp: print all error messages to stdout
      selftests: mptcp: connect: add dedicated port counter
      selftests: mptcp: connect: fix misaligned output
      selftests: mptcp: sockopt: print every test result
      selftests: mptcp: export TEST_COUNTER variable
      selftests: mptcp: add print_title in mptcp_lib
      selftests: mptcp: print test results with counters
      selftests: mptcp: use += operator to append strings
      selftests: mptcp: print test results with colors
      selftests: mptcp: call test_fail without argument
      selftests: mptcp: extract mptcp_lib_check_expected
      selftests: mptcp: print_test out of verify_listener_events
      selftests: mptcp: add mptcp_lib_verify_listener_events
      selftests: mptcp: declare event macros in mptcp_lib
      selftests: mptcp: use KSFT_SKIP/KSFT_PASS/KSFT_FAIL

 tools/testing/selftests/net/mptcp/diag.sh          |  19 ++-
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 145 +++++++++++----------
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 120 +++++++----------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 113 ++++++++++++++--
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |  53 ++++----
 tools/testing/selftests/net/mptcp/pm_netlink.sh    |  13 +-
 tools/testing/selftests/net/mptcp/simult_flows.sh  |  18 +--
 tools/testing/selftests/net/mptcp/userspace_pm.sh  | 117 +++++------------
 8 files changed, 312 insertions(+), 286 deletions(-)
---
base-commit: 19cfdc0d57696c92523da8eb26c0f3e092400bee
change-id: 20240308-upstream-net-next-20240308-selftests-mptcp-unification-6df178cc8f6a

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


