Return-Path: <linux-kselftest+bounces-42540-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB672BA5CE9
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 11:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AD764C6545
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 09:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4292DC796;
	Sat, 27 Sep 2025 09:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UwXKnQc1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6B12D6E60;
	Sat, 27 Sep 2025 09:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758966084; cv=none; b=rG/8hK3J03CtpGMBp+b8jBPnYB+zRcJV3MEdDaK1NHQSng9FN0Oxc2IQvweXRk5MqtjXmceTSab8jLNE+pLvW4hg1NHavJ+zihzsT4LoyISGUT9X1JZ8QyvxSDMfATLAdjJabz047YFGcGzJujL/65/ZfM+tg3+GHtPZsdfgdCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758966084; c=relaxed/simple;
	bh=rKTMd7KxeZgkBmvTha+kogxTXlWFl1nRxlgkXTcuuY8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cDjN/JzZhYExEkdX+qglW62gqh5eRBt65fUQi4/c+sGYm0A9dYp7kWxG8rL+284Iu0qndOOuLkVtFOQeAX4CMnnfYmItL5argUAztdavSOhxdlbF9ga075Qt2NmGVxzAcXO/RZJUnDbSlMn9iZmews3Ne6PJuoxyYb0m2e8xrm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UwXKnQc1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB92C4CEF8;
	Sat, 27 Sep 2025 09:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758966083;
	bh=rKTMd7KxeZgkBmvTha+kogxTXlWFl1nRxlgkXTcuuY8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UwXKnQc1cdo8zQhNeBc3hhv4ZH/doxEGdmgPpQ62maKclLm5Lk1+KyER4V4mNTOXc
	 RZVWmxkc/w76Yb8GByjqb9DhC9Dlx1CBss62HjvF6hP3xwjhMfYZVi81V+UJgZSu7M
	 C+H6DNHFUjTTSu69DafJIQSrJEsNErWPY9ISGhCIfOLGbx86lAIB7MyrfUZEDy7nlY
	 8fap4sRdRdf0Dz8YgNRZupLoUtRurgBSOkgHiy/4OVojGd+c4Qoo9BbMBlodV2iy04
	 yG6Ewp+iFqWZmAacmLY2YEfXa4yWNNjIEG3KhmFVdlwT5Rl4MHJLlPkRA+iUsaBaAx
	 EHbKNZT0cwSDQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 27 Sep 2025 11:40:44 +0200
Subject: [PATCH net-next 8/8] selftests: mptcp: join: validate new laminar
 endp
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250927-net-next-mptcp-rcv-path-imp-v1-8-5da266aa9c1a@kernel.org>
References: <20250927-net-next-mptcp-rcv-path-imp-v1-0-5da266aa9c1a@kernel.org>
In-Reply-To: <20250927-net-next-mptcp-rcv-path-imp-v1-0-5da266aa9c1a@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5241; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=rKTMd7KxeZgkBmvTha+kogxTXlWFl1nRxlgkXTcuuY8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKub1SLq/i7R1av9uEui5LIZb5qJf8mLbjfef6Dpx6zT
 p28QdypjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgImECDEyHNJIyV79957v24k2
 jo8PLLiwXL2Ua8+HdTskBGo11Y2EohgZzrTZxu56JigzYdWF+c9n5jQVJN2YnrHsb1ue1BU/52W
 5rAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are a few sub-tests for mptcp_join.sh, validating the new 'laminar'
endpoint type.

In a setup where subflows created using the routing rules would be
rejected by the listener, and where the latter announces one IP address,
some cases are verified:

- Without any 'laminar' endpoints: no new subflows are created.

- With one 'laminar' endpoint: a second subflow is created.

- With multiple 'laminar' endpoints: 2 IPv4 subflows are created.

- With one 'laminar' endpoint, but the server announcing a second IP
  address, only one subflow is created.

- With one 'laminar' + 'subflow' endpoint, the same endpoint is only
  used once.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 69 +++++++++++++++++++++++++
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c   |  9 ++++
 2 files changed, 78 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index a94b3960ad5e009dbead66b6ff2aa01f70aa3e1f..c90d8e8b95cbb6ba80f79208d1cc844673f2c249 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2320,6 +2320,74 @@ signal_address_tests()
 	fi
 }
 
+laminar_endp_tests()
+{
+	# no laminar endpoints: routing rules are used
+	if reset_with_tcp_filter "without a laminar endpoint" ns1 10.0.2.2 REJECT &&
+	   mptcp_lib_kallsyms_has "mptcp_pm_get_endp_laminar_max$"; then
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 2 2
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+		run_tests $ns1 $ns2 10.0.1.1
+		join_syn_tx=1 \
+			chk_join_nr 0 0 0
+		chk_add_nr 1 1
+	fi
+
+	# laminar endpoints: this endpoint is used
+	if reset_with_tcp_filter "with a laminar endpoint" ns1 10.0.2.2 REJECT &&
+	   mptcp_lib_kallsyms_has "mptcp_pm_get_endp_laminar_max$"; then
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 2 2
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+		pm_nl_add_endpoint $ns2 10.0.3.2 flags laminar
+		run_tests $ns1 $ns2 10.0.1.1
+		chk_join_nr 1 1 1
+		chk_add_nr 1 1
+	fi
+
+	# laminar endpoints: these endpoints are used
+	if reset_with_tcp_filter "with multiple laminar endpoints" ns1 10.0.2.2 REJECT &&
+	   mptcp_lib_kallsyms_has "mptcp_pm_get_endp_laminar_max$"; then
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 2 2
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
+		pm_nl_add_endpoint $ns2 dead:beef:3::2 flags laminar
+		pm_nl_add_endpoint $ns2 10.0.3.2 flags laminar
+		pm_nl_add_endpoint $ns2 10.0.4.2 flags laminar
+		run_tests $ns1 $ns2 10.0.1.1
+		chk_join_nr 2 2 2
+		chk_add_nr 2 2
+	fi
+
+	# laminar endpoints: only one endpoint is used
+	if reset_with_tcp_filter "single laminar endpoint" ns1 10.0.2.2 REJECT &&
+	   mptcp_lib_kallsyms_has "mptcp_pm_get_endp_laminar_max$"; then
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 2 2
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
+		pm_nl_add_endpoint $ns2 10.0.3.2 flags laminar
+		run_tests $ns1 $ns2 10.0.1.1
+		chk_join_nr 1 1 1
+		chk_add_nr 2 2
+	fi
+
+	# laminar endpoints: subflow and laminar flags
+	if reset_with_tcp_filter "sublow + laminar endpoints" ns1 10.0.2.2 REJECT &&
+	   mptcp_lib_kallsyms_has "mptcp_pm_get_endp_laminar_max$"; then
+		pm_nl_set_limits $ns1 0 4
+		pm_nl_set_limits $ns2 2 4
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,laminar
+		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,laminar
+		run_tests $ns1 $ns2 10.0.1.1
+		chk_join_nr 1 1 1
+		chk_add_nr 1 1
+	fi
+}
+
 link_failure_tests()
 {
 	# accept and use add_addr with additional subflows and link loss
@@ -4109,6 +4177,7 @@ all_tests_sorted=(
 	f@subflows_tests
 	e@subflows_error_tests
 	s@signal_address_tests
+	L@laminar_endp_tests
 	l@link_failure_tests
 	t@add_addr_timeout_tests
 	r@remove_tests
diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index d4981b76693bbddca74169437a540ad6294cf1d5..65b374232ff5ac06876dcd621fd2109c4d82cd12 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -830,6 +830,8 @@ int add_addr(int fd, int pm_family, int argc, char *argv[])
 					flags |= MPTCP_PM_ADDR_FLAG_SUBFLOW;
 				else if (!strcmp(tok, "signal"))
 					flags |= MPTCP_PM_ADDR_FLAG_SIGNAL;
+				else if (!strcmp(tok, "laminar"))
+					flags |= MPTCP_PM_ADDR_FLAG_LAMINAR;
 				else if (!strcmp(tok, "backup"))
 					flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
 				else if (!strcmp(tok, "fullmesh"))
@@ -1018,6 +1020,13 @@ static void print_addr(struct rtattr *attrs, int len)
 					printf(",");
 			}
 
+			if (flags & MPTCP_PM_ADDR_FLAG_LAMINAR) {
+				printf("laminar");
+				flags &= ~MPTCP_PM_ADDR_FLAG_LAMINAR;
+				if (flags)
+					printf(",");
+			}
+
 			if (flags & MPTCP_PM_ADDR_FLAG_BACKUP) {
 				printf("backup");
 				flags &= ~MPTCP_PM_ADDR_FLAG_BACKUP;

-- 
2.51.0


