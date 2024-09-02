Return-Path: <linux-kselftest+bounces-16948-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3162968535
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 12:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28AADB26C9F
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 10:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529FC1D67BE;
	Mon,  2 Sep 2024 10:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E90Fy07o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258EC185924;
	Mon,  2 Sep 2024 10:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725274003; cv=none; b=bCC7AT9Ya76nSFkTUn41duhq7zo/tw1mHjQ44voxcUgP0vdVACDqmf1g6JjZaZxi79B0LGkvKvdHYBc3gKxsYoPh17cDkFcEwAiVpnz3WFWArG244LYyMrB52b2rehPMK3f1JvcGgWp9N4+pSf0woOVJ0PjAXGT4sGmz/I57j/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725274003; c=relaxed/simple;
	bh=FPZ//+LmYrdLiAR8TkZb9j4Bb/TNL62ML2xUN9hVcrg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jfB+El3xfrNyQnqUrDA7c7o+YklCf0v5YkRVCum62o+VBhd/hbQd0dhpFxYDgS076vfMM696XvT+JuBgwaD0+CxLVfwx4GO0DWOKe8Kf/fPz2MYIQo5f7j1CEMVI9MCsTkhx0kDc1P1mYSqvdWH9C8Iioj4vScq66n0ShnyGSNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E90Fy07o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68CADC4CEC8;
	Mon,  2 Sep 2024 10:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725274003;
	bh=FPZ//+LmYrdLiAR8TkZb9j4Bb/TNL62ML2xUN9hVcrg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=E90Fy07oI3giZ6itsts+X/Lg4jy+r/Csnn4eyeHIYYbtupxIEfFOwVJZrjF1kltIA
	 Pm672wG5ZQDyyZyL/dOYOu2CP0HvceCwutQ1hZuxuFdMOgqLdXltNHbYtAfAP72Df/
	 yGZY2I3NrGRdUCzQQRmwFrKuNsHbzBfmPZY/rwLgAINJOttJX4LVbf3es9ryrfFxEr
	 p/FQk3caXnJmWuCJaEC/Imos4zROBYD83HsBdN1jE/cZHOkl7AWlNKXviHwXMhpZOZ
	 D5ZpV1jp+ym4t5582o1zzhadtut55ytCZ+DvWVeiRJyfxiiw7YyjhW3DNHnh9n9N7p
	 dEGSONKyR9hLw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 02 Sep 2024 12:46:02 +0200
Subject: [PATCH net-next 11/11] selftests: mptcp: pm_nl_ctl: remove
 re-definition
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240902-net-next-mptcp-mib-mpjtx-misc-v1-11-d3e0f3773b90@kernel.org>
References: <20240902-net-next-mptcp-mib-mpjtx-misc-v1-0-d3e0f3773b90@kernel.org>
In-Reply-To: <20240902-net-next-mptcp-mib-mpjtx-misc-v1-0-d3e0f3773b90@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1833; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=FPZ//+LmYrdLiAR8TkZb9j4Bb/TNL62ML2xUN9hVcrg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm1ZdudT4wm2R9q0KqWJKArlK5UY9sSC5X+xDmY
 syBGXbNPY6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtWXbgAKCRD2t4JPQmmg
 c0LjD/4p+CcrXWfxEhzJvn1wHTDln+iIlIcL79pFk/T/NPjL8yenuIHRReKA6Vh4xYXNebYntGC
 qM4y9GGTpwIqutQ66M1fO6JuBjMIZuVesguSRhYJlJBfjIu6NsFxbLZncsf6yRcCe5nTNGeE8Tr
 8hNw0X8XXihLSU7EOMck9G7W98zw4UFvgb4xoti8TDGY3r6wjIgHLVH60Pph0PuZODaPlLEj9lB
 /woEJAqf30wCTbcVmXIjg5suVRXlIA2U5yDdGzD/JuhVrIQCV3DQ3ZcTe5VCkH4deyWUt9k5Af4
 V2ZJWtKILHnU6sDMA8bIqLPTySmbqaY6UK9tsJPZhJn6g3H99QlKS0QS0A3y13gJcqcYj2uEjU/
 QXQgEplYa1XSm4z7U7N4oPITm2dUI3PC0lOtAmiS9PRclsiGM5Yie8MSijq8Wpx5UKF+tC8rR0s
 nq6hIimi9cjgCvsnJ5ahbdi6xLr7bFn8Ub0tSidFy9doFuI2eXA0FeDU7j/K3HjYRMohSa/HPDL
 yW2XOEAbIBOARTYDSM0SYHZVcmarDs7qrhJK47xlVP1YgwMX+I6PsTEURysNlFi+GUw5aWr8MiC
 VJsSevC1XKA2DfinfjRzSk/0osmqlaiDzXNM9RiPBnlzwxM4Pm95NG2M/P4oFBtLghOF/PiWGyG
 IIorfhmtkJBdAvQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

'MPTCP_PM_NAME' is defined in 'linux/mptcp_pm.h', included in
'linux/mptcp.h', no need to re-define it.

'MPTCP_PM_EVENTS' is not defined in 'linux/mptcp.h', but
'MPTCP_PM_EV_GRP_NAME' is, with the same value. We can then use the
latter, and drop the other one.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index 7ad5a59adff2..994a556f46c1 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -19,12 +19,6 @@
 
 #include "linux/mptcp.h"
 
-#ifndef MPTCP_PM_NAME
-#define MPTCP_PM_NAME		"mptcp_pm"
-#endif
-#ifndef MPTCP_PM_EVENTS
-#define MPTCP_PM_EVENTS		"mptcp_pm_events"
-#endif
 #ifndef IPPROTO_MPTCP
 #define IPPROTO_MPTCP 262
 #endif
@@ -116,7 +110,7 @@ static int capture_events(int fd, int event_group)
 
 	if (setsockopt(fd, SOL_NETLINK, NETLINK_ADD_MEMBERSHIP,
 		       &event_group, sizeof(event_group)) < 0)
-		error(1, errno, "could not join the " MPTCP_PM_EVENTS " mcast group");
+		error(1, errno, "could not join the " MPTCP_PM_EV_GRP_NAME " mcast group");
 
 	do {
 		FD_ZERO(&rfds);
@@ -288,7 +282,7 @@ static int genl_parse_getfamily(struct nlmsghdr *nlh, int *pm_family,
 					if (grp->rta_type == CTRL_ATTR_MCAST_GRP_ID)
 						*events_mcast_grp = *(__u32 *)RTA_DATA(grp);
 					else if (grp->rta_type == CTRL_ATTR_MCAST_GRP_NAME &&
-						 !strcmp(RTA_DATA(grp), MPTCP_PM_EVENTS))
+						 !strcmp(RTA_DATA(grp), MPTCP_PM_EV_GRP_NAME))
 						got_events_grp = 1;
 
 					grp = RTA_NEXT(grp, grp_len);

-- 
2.45.2


