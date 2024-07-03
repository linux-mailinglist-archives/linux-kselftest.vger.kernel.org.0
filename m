Return-Path: <linux-kselftest+bounces-13141-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0599268B4
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 20:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1C471C2431A
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 18:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2D1191F6D;
	Wed,  3 Jul 2024 18:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njRdy4Yj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A917B187570;
	Wed,  3 Jul 2024 18:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720033102; cv=none; b=prjKePaHqyrJLLLq5zTHxJzKM7WC0eJv54iKwGKLb4uDLeBbNRM++rnZvJtQ3sg8mbXAECPGFgUfHqupjdjMg0JlpWRqrD9euHxpq7MfwS+RK28OiuEYKG1A2Invfm33vqk6+DKnh0IE2nCSX0CcwMzT+oCtHOshvm/TroM7qc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720033102; c=relaxed/simple;
	bh=VoE1ILimCqHk/YEb77HzYZmafHMCPkpjf277zBCgqn4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aRZPt7TvIzsbt+e043hAmBJRf2w6ZryIut/K1dOxWUy8Lck0aonMfr5gUkAOFnlC778sylAleEkWIPMLKicFXdZt1iMQFvitVoLwtH5qu/JrKr3NIOm8Kao5eoMgDWYuYTYhAJ68wtQ0lB5V+n9RT49yN0tnnS0+2xXshF4GYyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=njRdy4Yj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302A2C4AF0A;
	Wed,  3 Jul 2024 18:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720033102;
	bh=VoE1ILimCqHk/YEb77HzYZmafHMCPkpjf277zBCgqn4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=njRdy4YjVI9U+jv7lJefsam78iojDnr0G80PZ2qjWXnSSyQUur7KMnLJpRu+gwgDx
	 TTErMXS61l6+2dndZBdvph8UMXNKH3IIWYecF9AN32Fj8GeRuzj211lO4rrrNf7554
	 COp3mNM0DIce+ZZEcpasFtakCc9CY4adM0fn2qnYakyrZQhiK9AaRCWeEDqf33+REB
	 0W3qweQUKLIr/b/W2istHXjTkpKRnv+OOT2rsZ3d6SZKIAsgV+tMcYmBD2jykZYcUd
	 TgJdzAVhepdGDhs/v+GELmPfSvpz4HXAt3XjQ8BnC8acltc1VvwITzi4ELkkALJmFq
	 WJdOo72sj4SSw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 03 Jul 2024 20:57:33 +0200
Subject: [PATCH bpf-next v3 2/3] selftests/bpf: Add mptcp pm_nl_ctl link
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-upstream-bpf-next-20240506-mptcp-subflow-test-v3-2-ebdc2d494049@kernel.org>
References: <20240703-upstream-bpf-next-20240506-mptcp-subflow-test-v3-0-ebdc2d494049@kernel.org>
In-Reply-To: <20240703-upstream-bpf-next-20240506-mptcp-subflow-test-v3-0-ebdc2d494049@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <tanggeliang@kylinos.cn>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2481; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=DrossgVs4wFMMCErNvKxWMQ2m+UYYVayQgbZBaY+EqY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmhZ89PjoNh4U76dfEkvQVWWraM1scfYPvEllIG
 12Gw2KLEOqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZoWfPQAKCRD2t4JPQmmg
 c26RD/9JDCtmw3uszrPvUgqQNbBiZk1dkLb4j4Mm4R6u2oK5aGjx2NjiU0zvN8Me2Yhblq9pdG7
 dpmL2dr+kUuZt9go/aauQV0TOhx9UaL0GXGkj4sALZLyjctLYZRAuvjGJ7YIkebv68ApzHaQsp1
 UPZSY4YKtX9QCajnETOsCkeoyFWHmY9UOZlhjJowVuulv6LpnuRZQoMEqGouKnH9BvAQ+uDhwRG
 4iF4VvgRl1RYJcCfJvwDnlRIsnOmlZNUjmXDFIwb3hpy8b5AxBdgJS7FGB+uFBWzxBNZKZJGMN3
 2PzkLeua01nUFjULDRe+aK13NIwmUoJRmeKigkTQtubOEmu//22rBwFsivszzJjWSGloFrt3PFm
 vnMdAV2wOdJm7N6lT/cWwAs2YdSM3+PzXBXRI7PV2uMcgnH9kFJU9NQISNvD5oIPap4fDY4gLnM
 9rkSE+ai+6ptPWK+AE191jxfaLpmxf4XCEgfiWZz1/+JjLUAlezcK6Wx1wb7cfVvI4zrVeVl+7k
 7EK56UDFC1qbiXmXo3ZdVCKFurtXQAtLMpEkixTgaCnY6srvCYm4Lv1dQroS/nzmyGX/rEqE66z
 0VJr8kKLPkRxodcRFF/NWiEkhLslto9NA63ueavi/xkIid81JxGz95bKMUuPF5dgxIM5oEDSUSm
 aKeN6HDlYY+hN0Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a symlink to MPTCP's pm_nl_ctl tool into bpf selftests,
and updates Makefile to compile it.

This is useful to run MPTCP BPF selftests on systems with an old version
of IPRoute2. This tool can be used as an alternative to 'ip mptcp'.

MAINTAINERS needs to be updated since a new file is added in a non
covered place.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 MAINTAINERS                                   | 1 +
 tools/testing/selftests/bpf/Makefile          | 3 ++-
 tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cd3277a98cfe..4ea5db496698 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15756,6 +15756,7 @@ F:	include/trace/events/mptcp.h
 F:	include/uapi/linux/mptcp*.h
 F:	net/mptcp/
 F:	tools/testing/selftests/bpf/*/*mptcp*.c
+F:	tools/testing/selftests/bpf/*mptcp*.c
 F:	tools/testing/selftests/net/mptcp/
 
 NETWORKING [TCP]
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index e0b3887b3d2d..204269d0b5b8 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -144,7 +144,7 @@ TEST_GEN_PROGS_EXTENDED = test_skb_cgroup_id_user \
 	flow_dissector_load test_flow_dissector test_tcp_check_syncookie_user \
 	test_lirc_mode2_user xdping test_cpp runqslower bench bpf_testmod.ko \
 	xskxceiver xdp_redirect_multi xdp_synproxy veristat xdp_hw_metadata \
-	xdp_features bpf_test_no_cfi.ko
+	xdp_features bpf_test_no_cfi.ko mptcp_pm_nl_ctl
 
 TEST_GEN_FILES += liburandom_read.so urandom_read sign-file uprobe_multi
 
@@ -645,6 +645,7 @@ TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko	\
 		       $(OUTPUT)/xdp_synproxy				\
 		       $(OUTPUT)/sign-file				\
 		       $(OUTPUT)/uprobe_multi				\
+		       $(OUTPUT)/mptcp_pm_nl_ctl			\
 		       ima_setup.sh 					\
 		       verify_sig_setup.sh				\
 		       $(wildcard progs/btf_dump_test_case_*.c)		\
diff --git a/tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c b/tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c
new file mode 120000
index 000000000000..5a08c255b278
--- /dev/null
+++ b/tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c
@@ -0,0 +1 @@
+../net/mptcp/pm_nl_ctl.c
\ No newline at end of file

-- 
2.45.2


