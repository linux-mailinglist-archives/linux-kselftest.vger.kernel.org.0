Return-Path: <linux-kselftest+bounces-41938-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D412B895CC
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 14:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B3973BB7A6
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 12:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4542A3101B0;
	Fri, 19 Sep 2025 12:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkX92YNz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162FF3101A3;
	Fri, 19 Sep 2025 12:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758283769; cv=none; b=pFVlQrGX/ZziYNDlhVWToco+d3W+Mg/pCgUuyYltMAxrsXoi20gFzStGDra66n6mNZLHIjeEbmVYnrUX26jsoHF/ha8TantU7E1EiLhyLjipObn3F+p5xuF9oKyu40JvTTY/ADfYzVjw1W1dQXQgv3JUMZt+gBJD3jB0S0phAdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758283769; c=relaxed/simple;
	bh=oDLvnTwLCa3sWaxsvqNmO3APT6MP7ApIhxWpZvrDDc0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V7S27sS/a4Q04rH7tKXqB1lTGT+jGVVnB6awe/btXO03ZnCqdM4lBWrqsXlpkbXLZAjd9eMG2ogBBqvBEMIW9/CC6VSsUHqRolJtHVAJpAm0fEg4i3+CONwclA8nh9KyViWmfA/HfePX4gQMkCYA000hoHrOxmkLQbKgPklNjZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkX92YNz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36584C4CEF0;
	Fri, 19 Sep 2025 12:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758283768;
	bh=oDLvnTwLCa3sWaxsvqNmO3APT6MP7ApIhxWpZvrDDc0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BkX92YNzz9PAL+XNTyA4VjjI1apiGSWGsmk8LKMpwuxjJ37iFmPNlnZvkonaAF1eG
	 BddS6qFA/M+zr1GJWe3+MpFvZoAD2bSkQZUIY8j3lhEGWJYa5JnZDbHB7sGJ0QOAyQ
	 v9XXF4qxGpLoo1wZRyFFtDRWOFK1P043AYU27aTridoK6rzG5tiov+iMC4qV7mJbml
	 9fLOKlFovqpmFKm0a7l9+ChV28AbpGr0l75+KMunFnkJ2LNEIkFnmAF90jYeTyjzI9
	 RGeqcT+m/zfoATgCJRpEWYkkjW9dhaD/e93wOZY3h5xcY8jWZe204GFnm/jr1LCn/o
	 qKTk6yU986RDQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 19 Sep 2025 14:09:01 +0200
Subject: [PATCH net-next 4/6] selftests: mptcp: pm: get server-side flag
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250919-net-next-mptcp-server-side-flag-v1-4-a97a5d561a8b@kernel.org>
References: <20250919-net-next-mptcp-server-side-flag-v1-0-a97a5d561a8b@kernel.org>
In-Reply-To: <20250919-net-next-mptcp-server-side-flag-v1-0-a97a5d561a8b@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2116; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=oDLvnTwLCa3sWaxsvqNmO3APT6MP7ApIhxWpZvrDDc0=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLOuj83PDWtYa5sR/pEnZcHVe9NmhN95d+7TZJuEspz/
 hse2HB4akcpC4MYF4OsmCKLdFtk/sznVbwlXn4WMHNYmUCGMHBxCsBEtO8x/GYNfs2d3Nd1SDKx
 9yrDo3hBa0WdHXvY8+3vb5He8/Hov0RGhgablAN3lhyyki60OviS4fons745U5dvuSR3sX+CvJD
 7LE4A
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

server-side info linked to the MPTCP connect/established events can now
come from the flags, in addition to the dedicated attribute.

The attribute is now deprecated -- in favour of the new flag, and will
be removed later on.

Print this info only once.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index 93fea3442216c8fef43731a99c1d5710f234b150..d4981b76693bbddca74169437a540ad6294cf1d5 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -2,6 +2,7 @@
 
 #include <errno.h>
 #include <error.h>
+#include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -113,6 +114,8 @@ static int capture_events(int fd, int event_group)
 		error(1, errno, "could not join the " MPTCP_PM_EV_GRP_NAME " mcast group");
 
 	do {
+		bool server_side = false;
+
 		FD_ZERO(&rfds);
 		FD_SET(fd, &rfds);
 		res_len = NLMSG_ALIGN(sizeof(struct nlmsghdr)) +
@@ -187,18 +190,22 @@ static int capture_events(int fd, int event_group)
 				else if (attrs->rta_type == MPTCP_ATTR_ERROR)
 					fprintf(stderr, ",error:%u", *(__u8 *)RTA_DATA(attrs));
 				else if (attrs->rta_type == MPTCP_ATTR_SERVER_SIDE)
-					fprintf(stderr, ",server_side:%u", *(__u8 *)RTA_DATA(attrs));
+					server_side = !!*(__u8 *)RTA_DATA(attrs);
 				else if (attrs->rta_type == MPTCP_ATTR_FLAGS) {
 					__u16 flags = *(__u16 *)RTA_DATA(attrs);
 
 					/* only print when present, easier */
 					if (flags & MPTCP_PM_EV_FLAG_DENY_JOIN_ID0)
 						fprintf(stderr, ",deny_join_id0:1");
+					if (flags & MPTCP_PM_EV_FLAG_SERVER_SIDE)
+						server_side = true;
 				}
 
 				attrs = RTA_NEXT(attrs, msg_len);
 			}
 		}
+		if (server_side)
+			fprintf(stderr, ",server_side:1");
 		fprintf(stderr, "\n");
 	} while (1);
 

-- 
2.51.0


