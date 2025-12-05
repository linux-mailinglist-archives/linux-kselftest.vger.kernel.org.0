Return-Path: <linux-kselftest+bounces-47202-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 158A7CA9089
	for <lists+linux-kselftest@lfdr.de>; Fri, 05 Dec 2025 20:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B01530FB134
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Dec 2025 19:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD523A1D1B;
	Fri,  5 Dec 2025 18:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQF7vjRU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3B5393DC3;
	Fri,  5 Dec 2025 18:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764960936; cv=none; b=te60ff9eyI+Nt9ofwjuEbYtrvBu6CujziZKHCNsueM89bSM9kw10nPnfPIKWOSISZAjjoguTqs67o/rV9yqVsmUxnvX08xZ6WILqFimhujE9A6vtGqHP9wm+gJbotnIgcee70AwXiux1f+1VxVzXtMX4HhRcopoy+cJ0X28ZRBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764960936; c=relaxed/simple;
	bh=mz6UZ0Fkl3I96HVniQu7TrDz6mQBiwxr06agl69nywY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bAnNUAh3J57kHb0MMw2trQvz4Szg0VitMNrWpethxybW4x7V+Dn5W8o3R0cdg6uxn/hhNKORnACM1WEMWiqhAvY58FrV3OW9HlpboHkucF0tn1Dr+bGPgvcm0PtgKPxvwdMK9XkjcmNd3jYun+zm0PuKse5f717n+MQmgNeuc+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qQF7vjRU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF2CC4CEF1;
	Fri,  5 Dec 2025 18:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764960936;
	bh=mz6UZ0Fkl3I96HVniQu7TrDz6mQBiwxr06agl69nywY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qQF7vjRU90HwN3rcsqQsVihtxyqgt2R7+8rMYAlnE2Qr0t8YGJDs5L2rLl2OkRyXA
	 9h1MOv0irnVxtxzPvrKO5wfZE9APx2wp0yldZIulJCUVLO8ujKqGLykg1qE/sfBeJ1
	 2ILSMDYW7vHiIClfII3HxgovJaiU3gIdGm59uV4nS2eyrci+J/Np/ILGOEQcxKmWhU
	 chkY6MVzfId9Pvd3OxiGYucpMxBY44LLm3ZG+cwd1V8JZqObmWFbcaxF+AQAx31e4R
	 istvjs8zKxlG7VcyYGJcjGPMOiH3wJ4NtVc0WZlvOEf9gpN5NuFRZTcDEIhTw9jr3X
	 4CJmOrd9wbuGQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 05 Dec 2025 19:55:15 +0100
Subject: [PATCH net 2/4] selftests: mptcp: pm: ensure unknown flags are
 ignored
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251205-net-mptcp-misc-fixes-6-19-rc1-v1-2-9e4781a6c1b8@kernel.org>
References: <20251205-net-mptcp-misc-fixes-6-19-rc1-v1-0-9e4781a6c1b8@kernel.org>
In-Reply-To: <20251205-net-mptcp-misc-fixes-6-19-rc1-v1-0-9e4781a6c1b8@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, Dmytro Shytyi <dmytro@shytyi.net>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2648; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=mz6UZ0Fkl3I96HVniQu7TrDz6mQBiwxr06agl69nywY=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKNtebIPhBqrfuzx273o/4Oh++2V4qENZtLBeaviQlae
 NB+HodBRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwETWTWBkmHpVSHH1rNlMc0p9
 5RgdFFeWRjlP59YzjNKfo6EZkmH4leEPv3zstoTb4mx68UWJs1p3vJfxZV80+fINffVn22+KWzb
 zAwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This validates the previous commit: the userspace can set unknown flags
-- the 7th bit is currently unused -- without errors, but only the
supported ones are printed in the endpoints dumps.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 01cacb00b35c ("mptcp: add netlink-based PM")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh |  4 ++++
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c   | 11 +++++++++++
 2 files changed, 15 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index ec6a87588191..123d9d7a0278 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -192,6 +192,10 @@ check "show_endpoints" \
 flush_endpoint
 check "show_endpoints" "" "flush addrs"
 
+add_endpoint 10.0.1.1 flags unknown
+check "show_endpoints" "$(format_endpoints "1,10.0.1.1")" "ignore unknown flags"
+flush_endpoint
+
 set_limits 9 1 2>/dev/null
 check "get_limits" "${default_limits}" "rcv addrs above hard limit"
 
diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index 65b374232ff5..99eecccbf0c8 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -24,6 +24,8 @@
 #define IPPROTO_MPTCP 262
 #endif
 
+#define MPTCP_PM_ADDR_FLAG_UNKNOWN _BITUL(7)
+
 static void syntax(char *argv[])
 {
 	fprintf(stderr, "%s add|ann|rem|csf|dsf|get|set|del|flush|dump|events|listen|accept [<args>]\n", argv[0]);
@@ -836,6 +838,8 @@ int add_addr(int fd, int pm_family, int argc, char *argv[])
 					flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
 				else if (!strcmp(tok, "fullmesh"))
 					flags |= MPTCP_PM_ADDR_FLAG_FULLMESH;
+				else if (!strcmp(tok, "unknown"))
+					flags |= MPTCP_PM_ADDR_FLAG_UNKNOWN;
 				else
 					error(1, errno,
 					      "unknown flag %s", argv[arg]);
@@ -1048,6 +1052,13 @@ static void print_addr(struct rtattr *attrs, int len)
 					printf(",");
 			}
 
+			if (flags & MPTCP_PM_ADDR_FLAG_UNKNOWN) {
+				printf("unknown");
+				flags &= ~MPTCP_PM_ADDR_FLAG_UNKNOWN;
+				if (flags)
+					printf(",");
+			}
+
 			/* bump unknown flags, if any */
 			if (flags)
 				printf("0x%x", flags);

-- 
2.51.0


