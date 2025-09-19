Return-Path: <linux-kselftest+bounces-41937-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 577FAB895BA
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 14:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8621B7BBB00
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 12:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CC230FC27;
	Fri, 19 Sep 2025 12:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMaw+ETt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F8D30FC1E;
	Fri, 19 Sep 2025 12:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758283766; cv=none; b=bEeQMwq5Sqp/ehomt+fnbXck7xscpCbKZODnVIoa7z4bukdpAbHZQ+5jMG4VG300eaZckuBcHhqzCmKBWoql05q5uwC+HRIxRrbCzVfalFytJRn8f6J+IQv3sUxY/fF+oSyrygpWjRy3W73J58CNttlnTnTWP1eFdkD6jYs/NQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758283766; c=relaxed/simple;
	bh=cOC4ACMpttzSGbbpqXDXgZXuredZmIIfxtg1D195peM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g0VXyfhOnSoS9OhjmuVisUlQQMC8TkkkrT2DCcehQqkeeWpegiXLUJXcxRwNxk9UolaxgFLM+XHrUJ4oY8am3SVjMG4Kl9AncfwjpbzxAGrXenLSw6AsOUtWZDRLipVy4jh9jbw/8mMSYklmaKKlkIw758a2Du96XwZ34miEKro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uMaw+ETt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F61CC4CEF5;
	Fri, 19 Sep 2025 12:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758283765;
	bh=cOC4ACMpttzSGbbpqXDXgZXuredZmIIfxtg1D195peM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uMaw+ETtuJjs1h8NTkI3IXd4fhEEF36P6+nTqthhJPuwebZeibMmFn6OJmOEXMEUr
	 1iQ5STMFigTNZ6DJlStynH4+uQBGc3FjKgGXTzEWQ88doWww/zCKrPmvOSz/AyT9KM
	 RhiB3rbTPJc8DQxqWcJY58Dox3Yzz+smgZq8WfWDPhCGiCAIMxFbc9P7baVmWPkdse
	 NBOEDIZkoz/EXNinEPcyHVC4sIs4Z2+YV8P8ZMbHrbifOwpulAAMflWQTNUV+dR/en
	 AWkbBa9WoRQYKA9lmzoW7xMwUlpLgJ7kKTViycDINKY7AY+GlVcQ+/JnsCuaEkZFme
	 kCJ2+TYlKGueA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 19 Sep 2025 14:09:00 +0200
Subject: [PATCH net-next 3/6] mptcp: pm: netlink: deprecate server-side
 attribute
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250919-net-next-mptcp-server-side-flag-v1-3-a97a5d561a8b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1461; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=cOC4ACMpttzSGbbpqXDXgZXuredZmIIfxtg1D195peM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLOuj/bu8ulS+PjkvrWzOCVVX+sFBeJHlATnmJtpvJ0v
 233+sWfO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACZyay7DT8aTT64b7J/6Y7fq
 vySz21kP07cuqjpw88ztyTODFP3mJTxh+CuX17RKr9dw9RZZifqGt/Uxbhzqt7huPbLi9X8i/W/
 ZOgYA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Now that such info is in the 'flags' attribute, it is time to deprecate
the dedicated 'server-side' attribute.

It will be removed in a few versions.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 Documentation/netlink/specs/mptcp_pm.yaml | 1 +
 net/mptcp/pm_netlink.c                    | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/mptcp_pm.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
index fc47a2931014c0304efd3215cc24485ea22e1ede..ba30a40b9dbf2d2d4f25cc07b309ea560712f65e 100644
--- a/Documentation/netlink/specs/mptcp_pm.yaml
+++ b/Documentation/netlink/specs/mptcp_pm.yaml
@@ -266,6 +266,7 @@ attribute-sets:
       -
         name: server-side
         type: u8
+        doc: "Deprecated: use 'flags'"
 
 operations:
   list:
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index aa0c73faaa6acad3fd66ea0942726ecd4d0abcc0..d5b383870f79956ce5e10bf384695621604f3ce9 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -416,7 +416,7 @@ static int mptcp_event_created(struct sk_buff *skb,
 	if (READ_ONCE(msk->pm.server_side)) {
 		flags |= MPTCP_PM_EV_FLAG_SERVER_SIDE;
 
-		/* only set when it is the server side */
+		/* Deprecated, and only set when it is the server side */
 		if (nla_put_u8(skb, MPTCP_ATTR_SERVER_SIDE, 1))
 			return -EMSGSIZE;
 	}

-- 
2.51.0


