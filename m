Return-Path: <linux-kselftest+bounces-5757-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9496C86E833
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 19:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 396652887EB
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 18:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362013D3A8;
	Fri,  1 Mar 2024 18:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FsrWLWuy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064E23B785;
	Fri,  1 Mar 2024 18:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709317134; cv=none; b=qRUvFKzXvapsfbTTHm2fkP0fQW/IZf6kY0kG1nTUtwVs5hs6mKb/xxkY9mmVfDMFTi48S2tEWGkR4c8+T00Add/06nppMCri2ZY1oNdFVDGRhTieIRxKCrmn+mgA4UfTO5szcaCob8UBqdJku7pZCktaHQFCmYe3tY0/nGdb/0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709317134; c=relaxed/simple;
	bh=2ulEk82mzCDQTc9Q4xsVEYZBuHiCFEEMnXuV8zumajs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ARUhVQHdXX/GYGntMWvxpWUjXS79zqbfZnRYgiPIrG1p1xm4ZTGolLsWu15BnsETP0aX+Dq/Df6kH9BDh3nORgA/T1okkpieHu1kTb2Vq3IOiBjHrf/5k+yMFj/yrskVSDkV5SUFv4Fh+jHH+npjsxI5gaJhXSg2nuTUSuywimk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FsrWLWuy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAAE1C433B2;
	Fri,  1 Mar 2024 18:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709317133;
	bh=2ulEk82mzCDQTc9Q4xsVEYZBuHiCFEEMnXuV8zumajs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FsrWLWuy1cuhgV57G20jSlnzmFnHHmMhHumQtZjkwGU9rPnyZ76ggu10m6kzzXvbC
	 ShLKiFqfhxvfcQsBU0EoLYngKTlQMP0XfTKec5BVa0yHK6/HWX1LneMcy4x82b9rjQ
	 adhAl4k9TngUFpYc+Y2dWxdNpTgFlWvRAztIoecidmd+/1CyNS3OoHP8EKlA3ROLNv
	 pouvrJj/XCBEbT/FRiSZdAqzoXi/8jizTYi7lxoS4fG2AnczXrKBV1ikN59S8zxdLP
	 Q34BVlC+c1GtZSz2lMKV1fHG77MCiS/H7SIfvYwU7Ci2mUYLlMrxWN3z8SiJpFoUBk
	 gk2hrpfFy+93g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 01 Mar 2024 19:18:31 +0100
Subject: [PATCH net-next 07/15] selftests: mptcp: add userspace pm subflow
 flag
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240301-upstream-net-next-20240301-mptcp-userspace-pm-dump-addr-v1-7-dc30a420b3a0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1420; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=hiJ4UAaexdDdOkDMA90vHJxSvQ7TaHeYuKTyQ9X/yhQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl4hv0hsDs/1Pa/GzXfDIT9DqD+yjEj9kpfYLNs
 1i6ujkWj5uJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeIb9AAKCRD2t4JPQmmg
 c7AoEACJ8g1KYDvlpmYv1fWLTanHLx/uzyfz4MCfgZ2ecgZT1TxBEucPB2HA3z0I9AAMb+yzbvY
 y5lz9tc+OG2BszlB1Os7kqvKuOS5j2oIX0cB9/fIfyewK0BC5dPmw5Dxx8nhKTIP+XJE1hUCHJq
 Jwe2cDcE+XzESyrHwIohfMiQDmFVDXEYRsbors/VLpP22aC7vjJL9GK7CO6q56E8CK3tMdKtEZI
 m5i+OxEx90+Omq1roKrFu6SO/0ERKK2cZ6qJbT4n/LP+X1rYXYcbuXVc9sa+NsUOhhVnOVB4mJt
 QdanLxiu03TGJgirap/YLc+qQ6t+wXydNOQBZJoCUdgUWqSjYxg0i3BpZ/BrPjJvirkI8MfSyin
 +SF1W9fnFgkocAFHKTW7z9sPc/BnvPs+1M0EE1NwaQsg7nzqCpeAdgdkM40LGSUeZP/mPESPSQ8
 MUCu3p2M5XWXA/4CY4nc0IX1ofLaXBYJ4GhOuYAerKTChp9vfXetlGQX0rF87IA6eHGUh/tP30v
 AjVX1UOs4EjisrUMoRk2xLqMnt4HibFIWg/btKys0soDSU0lTT7LSKV6nhAJm/WD96n6C8P/P8+
 DDNb9Pb8bhv6WzJj3mDgjF99ynvncffqpsTUGkjVuaVulxCrvdsE0sTQEx+nSa5eagomAEGvzmB
 1qrZ3N3QZTe8mNQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds the address flag MPTCP_PM_ADDR_FLAG_SUBFLOW in csf() in
pm_nl_ctl.c when subflow is created by a userspace PM.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index 49369c4a5f26..e97856323ec3 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -453,6 +453,7 @@ int csf(int fd, int pm_family, int argc, char *argv[])
 	char data[NLMSG_ALIGN(sizeof(struct nlmsghdr)) +
 		  NLMSG_ALIGN(sizeof(struct genlmsghdr)) +
 		  1024];
+	u_int32_t flags = MPTCP_PM_ADDR_FLAG_SUBFLOW;
 	const char *params[5];
 	struct nlmsghdr *nh;
 	struct rtattr *addr;
@@ -558,6 +559,13 @@ int csf(int fd, int pm_family, int argc, char *argv[])
 			off += NLMSG_ALIGN(rta->rta_len);
 		}
 
+		/* addr flags */
+		rta = (void *)(data + off);
+		rta->rta_type = MPTCP_PM_ADDR_ATTR_FLAGS;
+		rta->rta_len = RTA_LENGTH(4);
+		memcpy(RTA_DATA(rta), &flags, 4);
+		off += NLMSG_ALIGN(rta->rta_len);
+
 		addr->rta_len = off - addr_start;
 	}
 

-- 
2.43.0


