Return-Path: <linux-kselftest+bounces-5764-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5172D86E84A
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 19:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 054831F232A2
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 18:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC206EB4C;
	Fri,  1 Mar 2024 18:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bgu1pkY6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7236374DE;
	Fri,  1 Mar 2024 18:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709317154; cv=none; b=DqkDTcsa15k8SYLTZHfKVHLryjsCN01CmwZskXLTgDoTHjo4CzDwgIevwBQ2rQN+Msth+JcjXm+Goad9lMRIZ15fzkyIowApotodMeGESjrWuESXTBvEwcA52ESFRlxKCOVmjN6hA3hsDVITnRq04cMHwrgwEybSLL1W1zKd8nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709317154; c=relaxed/simple;
	bh=LKKRXAQDeznSeSGZgyri0Elpb067Wit+9V4bsKMplLc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e12ZxbHiBYRqeRCxWzO4dD3yTbBWfltG+Gmfswh0+EjmpVCaVzdyb+hRK6ERtROnO5pOXlFuNhN9PRMbP5/R7bSV+S/OUVZ79dlSX6rdjWEGylHfFm8K0eoiOuMtBBJ3W6LhXkehftDwtDykpyHqbQZ3O3D3/04QRTbs4MbLTJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bgu1pkY6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2BEC433B1;
	Fri,  1 Mar 2024 18:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709317154;
	bh=LKKRXAQDeznSeSGZgyri0Elpb067Wit+9V4bsKMplLc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Bgu1pkY6lZ6lRn2NgOtPV9HYjnrFLWERcd9B5JaN13TVJOA4P5sQZlXgq+Dn98bqL
	 SqkCe0NDTTaxHtKa2FDW9SwT8L0y1UmjbamwsZFmFVp8yIuNXgsvf4FZHBBejorBXS
	 gMaBbDCXCWlPzzG+hZY1wuUgv3fkd5BhI0BK4HnAJzginYpQ7m9kt+wxzZTrsEBLUX
	 aTmK19TABHJ25ScQj1CprwqPBwt/nRwgarcusqceT/X31/0fh1u5AEBqSOgvQH75vh
	 a0nKaCu9isPwO0Vx7hmQIaaf47PEOeHuaelAgTnf5RUhQT1knM0uV6dci2YdKEoe2M
	 vk8go7aXKbLow==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 01 Mar 2024 19:18:38 +0100
Subject: [PATCH net-next 14/15] selftests: mptcp: add token for get_addr
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240301-upstream-net-next-20240301-mptcp-userspace-pm-dump-addr-v1-14-dc30a420b3a0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1985; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=GwkN08kvH5E6tSspi17jY2/Q58omi0RtHA/WgsW19NU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl4hv1MjKGD1qufgkowxU4PO2oA/hN4gMeRs9B2
 8Udijpb8ZWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeIb9QAKCRD2t4JPQmmg
 c334EADiVT85vg+jS9bXT/9r2CIxGWnoWrNijo0prhSnSVYQP53jn82GAfHTh8AZk4/Td4mUaeV
 clzpaBipVM+WcHgjfZXiAkScY0V1JX9Hz7ASobo5ladJRaEWbRThX+6OH5iniTgNSw1Her0QTLU
 4j//8rmlH4YpX2XPm8myBXcYGX8rMZIFpWDWjQIqpNkNKhkPsMry0KFT92T1aZN+OkT4iH9JDg0
 NqPmv+kb66o6gP7wlPHrPvdy0S2qL5G1b604EgsZa4LWJDLUkafYKGa5IJ1Gwo5zF9XLPgUZHsa
 mDpUY/glAFkv/e32DjQQTewUMf/OqH/VGAJV28pqmBNavAiYahEWXJ+4euJIJ9rqS6rnrS6xqhy
 meg6k9pFutraR+vRHUo/LgXugR8k0Fi+TNhMpYDJ2xAu2Xik1HomdDn+C7R7SeDYddysobo2RoQ
 0kg/x45vDtdtaoUhI/zWN1VG/QllWKOyYRsJO1h3FJznZE5/jOASjMX1MV5mi+V9sG3UVjSKQ03
 Zizt/DLxptbpK6YUjMrfS2O1K8mabnpHuEP3vH5s0HZJxm/yNUS/VWKJdm2DPrFp/L6gW7rEAs3
 Mp9sE/nJTX1Sey+31Hg+g+yXWhlIcEu6qhWHKmfA6LfDn+hshGk5RCH9sIJEVhIcNIv6BAgwc3r
 kf3qxV+P5nYviNw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

The command get_addr() of pm_nl_ctl can be used like this in in-kernel PM:

	pm_nl_ctl get $id

This patch adds token argument for it to support userspace PM:

	pm_nl_ctl get $id token $token

If 'token $token' is passed to get_addr(), copy it into the kernel netlink.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index 8d7d1b4ed28e..7426a2cbd4a0 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -1087,6 +1087,7 @@ int get_addr(int fd, int pm_family, int argc, char *argv[])
 		  1024];
 	struct rtattr *rta, *nest;
 	struct nlmsghdr *nh;
+	u_int32_t token = 0;
 	int nest_start;
 	u_int8_t id;
 	int off = 0;
@@ -1097,10 +1098,12 @@ int get_addr(int fd, int pm_family, int argc, char *argv[])
 			    MPTCP_PM_VER);
 
 	/* the only argument is the address id */
-	if (argc != 3)
+	if (argc != 3 && argc != 5)
 		syntax(argv);
 
 	id = atoi(argv[2]);
+	if (argc == 5 && !strcmp(argv[3], "token"))
+		token = strtoul(argv[4], NULL, 10);
 
 	nest_start = off;
 	nest = (void *)(data + off);
@@ -1116,6 +1119,15 @@ int get_addr(int fd, int pm_family, int argc, char *argv[])
 	off += NLMSG_ALIGN(rta->rta_len);
 	nest->rta_len = off - nest_start;
 
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


