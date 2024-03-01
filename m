Return-Path: <linux-kselftest+bounces-5758-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B40686E836
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 19:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 589441C235BC
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 18:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369FD3D56F;
	Fri,  1 Mar 2024 18:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9Kra0Z7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0848D3D56D;
	Fri,  1 Mar 2024 18:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709317137; cv=none; b=JWNlJcl9NIyXAWjbOkrgXuU/817RWOsUAwslBRMmMD5yMFDW6kG8JcAW3RM437qdMXx9fAs53/Pwgg3IsPVM4HTJBAz0gpzfFed7j69cniEErDa7jCsKPLp0NF6+Ae8rqhGvSMAoSC3e2BwxmTTgcKJ1PErhD0uhsqREzUbSs2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709317137; c=relaxed/simple;
	bh=FDB8XSQBRdMllqh8m8OoUcSKAfuUGOTWR+NIv4IGlXU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jq7L7NBB1DQYN2SL24IOO9fM7RlWd23uaSMXlqKvkACAOCrQHzmPhoMbIhXZbCVQ2HQILikX3vgflE9RtxR7nGGUFd4Ecc0IXyvPdlh2OXK6bwIBewBsRRy22PGNAdgUsVJOS2qHTGy/WAbUz+eRhEfln7ZRmf/VeDxnLjFombk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9Kra0Z7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B9F2C433C7;
	Fri,  1 Mar 2024 18:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709317136;
	bh=FDB8XSQBRdMllqh8m8OoUcSKAfuUGOTWR+NIv4IGlXU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=U9Kra0Z7icfOVAk9kgesvPnNG0xsN6fm80CiNQyP2NOADqW6J8e3JI1Hx2Qpv6uw6
	 oUUS25H3voVA8B4F4pOyApMZ5250SEhvv49eJps4bJTsCp2jNPpWB0FKTDraYaYNoQ
	 UZTwH9TqW0S2IjlMNoquDXdpwN6vno9LdlWTMcPSxihZQSwvi+d8PtT3YRF7ndhzsD
	 MpoTew/daNzKczIkhGAQIpBTND0zXGuG6n1A2KKEi+gugs0gWbdJGEB0YCdRU2GSYH
	 5+zKq+6iOi8oEEBjCl99j9RW7PgKr9/OzLPe+l3q9o037VQsCS9346eVDx0/URbtM7
	 DhLn+uFT6Qf1w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 01 Mar 2024 19:18:32 +0100
Subject: [PATCH net-next 08/15] selftests: mptcp: add token for dump_addr
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240301-upstream-net-next-20240301-mptcp-userspace-pm-dump-addr-v1-8-dc30a420b3a0@kernel.org>
References: <20240301-upstream-net-next-20240301-mptcp-userspace-pm-dump-addr-v1-0-dc30a420b3a0@kernel.org>
In-Reply-To: <20240301-upstream-net-next-20240301-mptcp-userspace-pm-dump-addr-v1-0-dc30a420b3a0@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1817; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=s/43MOo5FC27LuiPRjpFodaWmdzbPWbgVM+F4CaJLW4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl4hv0xmOFf35y7gvs5KN2utY3oc86QKVhmAHQI
 bK97pq1PauJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeIb9AAKCRD2t4JPQmmg
 c1RpEADF9Swx38ckUj1z0PPfrUI76nHB/BMmj7F7QJowoyqhg0+0QdlZ2nAB2baCgyXF68YSWRN
 +vcSda8n5MOBteGjahXwc3OlGGC83pbWVOnbt7XAa0FV50w6/TMR1YTjmzPTLz6iX6OqpLm6IFp
 Oa4SLS6tyVrzYJkj5q7eHodYipWuR0nw1TyR9VfXQtEkZpe43LxP8EbDQowlkj8lwf7pSTuWIey
 83vS/VaZ0byZ5jKpxmwqBOY8OPKlqkoRPqOqEyGj7iNZl9BXbaBXY/s3WmRC4/iljaKqbHBj/IK
 pJ9ooaSrDrMQf7ctNwBcVKKOS0Gws/GCBBSuJ5OSoqUXPgqVc/JXZvscAVFjbqQhGqPPiluf0Nn
 FhfQ43Uzi0zxs+RKRfzQ1HuW7jPBBCewZHSY7M9lSmN5eE3FMqccK4QT9PBU4nLzS66LbEOsNn/
 l2nyOoS/ZuVUOKGJZdq80TKf9GwPvCqoFcQde7prf4i6ZJdMsF3ct9BKAhU+IMjuQN0Ym7YtFWH
 EwusNbDIZcwQw/1XZDYg537/F/Z4dZkjbCEdB9AE046vvzyALVi08Oy4UpmpwhFO1YGwXzw60IC
 EcafHWT3oNwpi6XJISyXcZ2mvTe/Ex29D34xdOI4lqyF8oFSEn649nCAXzAsyWRJBZsiZk6opOm
 yBzXiblnP9LD1IA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

The command dump_addr() of pm_nl_ctl can be used like this in in-kernel PM:

        pm_nl_ctl dump

This patch adds token argument for it to support userspace PM:

        pm_nl_ctl dump token $token

If 'token $token' is passed to dump_addr(), copy it into the kernel
netlink.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index e97856323ec3..8d7d1b4ed28e 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -1127,8 +1127,16 @@ int dump_addrs(int fd, int pm_family, int argc, char *argv[])
 		  1024];
 	pid_t pid = getpid();
 	struct nlmsghdr *nh;
+	u_int32_t token = 0;
+	struct rtattr *rta;
 	int off = 0;
 
+	if (argc != 2 && argc != 4)
+		syntax(argv);
+
+	if (argc == 4 && !strcmp(argv[2], "token"))
+		token = strtoul(argv[3], NULL, 10);
+
 	memset(data, 0, sizeof(data));
 	nh = (void *)data;
 	off = init_genl_req(data, pm_family, MPTCP_PM_CMD_GET_ADDR,
@@ -1138,6 +1146,15 @@ int dump_addrs(int fd, int pm_family, int argc, char *argv[])
 	nh->nlmsg_pid = pid;
 	nh->nlmsg_len = off;
 
+	/* token */
+	if (token) {
+		rta = (void *)(data + off);
+		rta->rta_type = MPTCP_PM_ATTR_TOKEN;
+		rta->rta_len = RTA_LENGTH(4);
+		memcpy(RTA_DATA(rta), &token, 4);
+		off += NLMSG_ALIGN(rta->rta_len);
+	}
+
 	print_addrs(nh, pm_family, do_nl_req(fd, nh, off, sizeof(data)));
 	return 0;
 }

-- 
2.43.0


