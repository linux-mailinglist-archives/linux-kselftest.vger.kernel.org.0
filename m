Return-Path: <linux-kselftest+bounces-11386-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F325900822
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 17:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0ECF1F2517A
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 15:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA5219A2AA;
	Fri,  7 Jun 2024 15:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfkX7den"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D981219A29C;
	Fri,  7 Jun 2024 15:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717772541; cv=none; b=dE4WRPqrUcfEIDy4rWKKLdRHqZs0oUHTUuuirBQf8H8q9gZhSGB6IGyWS1+QdfObelW07wR2zR34sYobrOGShIN5f5HDmjTUFW8fx75yVBxstYh/CRh12B7AgbtrPtjUhgdYj/YcqE3cyTF5Cvfev1D7Fqp4u6LNzITXwI0YlTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717772541; c=relaxed/simple;
	bh=PdAmS14wYt04sZq3D7slEkvvAc2hZaFIxiprMU3aay0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GSzbZzOmhxBoK2bzG9oth3b+DpqJYNvu02ScJqee62De3jYMIZwCBSGtDzpW03w7xmJvslI9aQjsFnsH+uhmyGXLYH5XUYnWr7QuKJmKBAPtuzKXdNWAunY+eeeRCf72p8Cbu/vLL/O9Fk8BNA6PqMnn8NBjWlOWOrbYiltf5y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfkX7den; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F52C2BBFC;
	Fri,  7 Jun 2024 15:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717772540;
	bh=PdAmS14wYt04sZq3D7slEkvvAc2hZaFIxiprMU3aay0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MfkX7dennpJE3Sevhj7wlY4f93e5y5wvIFpVCIkqlRtleHIaF95cACiyy815GawXw
	 J2SSYW3PJsmNswfPGLFlTq+Qk+3fJEQtiVOGhg2hHL/PGSq0BeMhs67kwS4NHgTJsD
	 Y4Z22goR8MrgNunpqfg1PM3UhRPJ/bkX6epmqdXgGK6ObAsn4bYz4y4mbkx0CTot5B
	 NrrASQYBCM5cfttvrZkopXdaeZgxov+prB9qS4jyOOx/Z5aL23sDdr5up02S3zGveZ
	 cvDddgSicwH7qkEbbTRm+kUCgCGwbbCJattXXiEGguxv0wzazP7jlV0D92ip0LTYEx
	 1kmFfQ0ptAtag==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 07 Jun 2024 17:01:49 +0200
Subject: [PATCH net 2/4] mptcp: pm: inc RmAddr MIB counter once per RM_ADDR
 ID
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-upstream-net-20240607-misc-fixes-v1-2-1ab9ddfa3d00@kernel.org>
References: <20240607-upstream-net-20240607-misc-fixes-v1-0-1ab9ddfa3d00@kernel.org>
In-Reply-To: <20240607-upstream-net-20240607-misc-fixes-v1-0-1ab9ddfa3d00@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Davide Caratti <dcaratti@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 YonglongLi <liyonglong@chinatelecom.cn>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2693; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=vskkHulrdgn06drgT20DEc3iXN5Qcro4k5QxgWRyi1A=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmYyDyxzSimTQcaOf36yFil4cqcwxMlQ007Ugvr
 dXf8D5lo6uJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZmMg8gAKCRD2t4JPQmmg
 c1pgEAC5ALWisx1OLrpLfqqmswMAcusSPKKm4OhLLhYyC1bJk9XBRZis2CYoXGE3GoT0HUNc6gf
 JMybcBJpJPzL86YY5S/urKrHacXBSQD7HMZups7Wwq9AD8H3Tj+U/7R5bpk4+Gm+pt+P6gJGVF0
 jD5UOF6xWYCC6nPcIiXv3LQnUtuUE8Jxt72WmtQqSnk29Y+Sio6m3IRwRgMeTYXCAGVbAcKt5I5
 TespSw+krbRqrvw4OHPf6pY4WRA4QI9NlV1BGRgg8YAIxGd7Dxw/eMeEKcxsYcquxeB2Teee7Wj
 MOjANIrASiPsndkI4nRPCyTI0ggxB3E1tP8dntMp+r2TUbjzeGC2TCpn2M2c9Z46SlNgsCnai9x
 PH2ZTytIGoiSRgv9AQzOjSXMoDw3zbBgXQzsts6Lf4BgS5akqy2bUm2gk3OMMNd/VUjasPFDBZV
 ncc0yTUV+UdlqZdDSF0+WGRY9jPy6kazJhkgo1N5ehbepJYLV3cwEz26Kl1Mtr8WyRmpMOo+sbV
 7Jc7PyJa+YKdum1xOK5MDTkCIFLmOY6PFmvw1G3zms2zGSNqDiWIKwkPNjAYanm7IIxYvBgVeXN
 GORuYjKmJ72FPAE5G3ZdY1i78Tl0WTZCPWEkZTrunj/bSZ7R58YVeP9k/p53u1TYVazcc/oVqXQ
 ZZ5rgQzuaZZQxuQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: YonglongLi <liyonglong@chinatelecom.cn>

The RmAddr MIB counter is supposed to be incremented once when a valid
RM_ADDR has been received. Before this patch, it could have been
incremented as many times as the number of subflows connected to the
linked address ID, so it could have been 0, 1 or more than 1.

The "RmSubflow" is incremented after a local operation. In this case,
it is normal to tied it with the number of subflows that have been
actually removed.

The "remove invalid addresses" MP Join subtest has been modified to
validate this case. A broadcast IP address is now used instead: the
client will not be able to create a subflow to this address. The
consequence is that when receiving the RM_ADDR with the ID attached to
this broadcast IP address, no subflow linked to this ID will be found.

Fixes: 7a7e52e38a40 ("mptcp: add RM_ADDR related mibs")
Cc: stable@vger.kernel.org
Co-developed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: YonglongLi <liyonglong@chinatelecom.cn>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c                          | 5 ++++-
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 3 ++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 7f53e022e27e..766a8409fa67 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -814,10 +814,13 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 			spin_lock_bh(&msk->pm.lock);
 
 			removed = true;
-			__MPTCP_INC_STATS(sock_net(sk), rm_type);
+			if (rm_type == MPTCP_MIB_RMSUBFLOW)
+				__MPTCP_INC_STATS(sock_net(sk), rm_type);
 		}
 		if (rm_type == MPTCP_MIB_RMSUBFLOW)
 			__set_bit(rm_id ? rm_id : msk->mpc_endpoint_id, msk->pm.id_avail_bitmap);
+		else if (rm_type == MPTCP_MIB_RMADDR)
+			__MPTCP_INC_STATS(sock_net(sk), rm_type);
 		if (!removed)
 			continue;
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 2b66c5fa71eb..aea314d140c9 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2250,7 +2250,8 @@ remove_tests()
 		pm_nl_set_limits $ns1 3 3
 		pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
-		pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
+		# broadcast IP: no packet for this address will be received on ns1
+		pm_nl_add_endpoint $ns1 224.0.0.1 flags signal
 		pm_nl_set_limits $ns2 3 3
 		addr_nr_ns1=-3 speed=10 \
 			run_tests $ns1 $ns2 10.0.1.1

-- 
2.43.0


