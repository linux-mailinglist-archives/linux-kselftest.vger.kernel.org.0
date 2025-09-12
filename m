Return-Path: <linux-kselftest+bounces-41408-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DD0B554C8
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 18:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3864B5C3E7B
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 16:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F5D320CC7;
	Fri, 12 Sep 2025 16:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ukyTTcYM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E96320CB4;
	Fri, 12 Sep 2025 16:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757695036; cv=none; b=OB9NNhMUt/1LbQqMRTDpCtcQlmS5piT4sUe25xnY3DtiTk2KpCfkwceqbFpzZqa05KDUFz2K3lXEL2ckNKHhItOtmspE4J9sZIzKTiorV54sht+eeYiyZhxVjhOD/58iTNB17mrx4UafoFQk75braMcZUxZy3FoSMH0fq0MWO3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757695036; c=relaxed/simple;
	bh=02RbCJy/0KB0IDkyTE3zAtIENx+JAzvBYgUMKFwaNUk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Osn3kClwehJ8IvtbyrRRowoACacmZSQ+ZoDhVnXOF4peDJAvvaXwPioJU2XZwKDeUfdH98vSFk3CpPnzmpDvgQL0E8vDzYHWlKnjyzSiqr7cq/hZONEPOSy5lKb6OzeNjuwxjoRwY83Q1JE5ATqE6t7gUudnmwYUfwJNLHZH67U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ukyTTcYM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA2EC4CEF9;
	Fri, 12 Sep 2025 16:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757695034;
	bh=02RbCJy/0KB0IDkyTE3zAtIENx+JAzvBYgUMKFwaNUk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ukyTTcYMqmmlKWVXqUMe0WzaVjWhmDOfYYtA93ssoHRHyQw54epQXk6n+nzhDaGtj
	 HwHxv8FGyGmk5rAnpW9geeVrlct8uc84Vo73GRUsuV1TO9YqskRRzjPBlHjOc98v24
	 LgnccMLCkCRl3RpEjTrRVs1yVCQazC/A0LSqLjMXEymre5MVz+6V7TPFGn442xOMbU
	 UK3T4TbGqnkuFWSaVW2uIrwq5Leoqm+6ExG3rijM08SWeO4ytEamef5zuf8i6fMVyE
	 dhUl89U+HcsliAw3Cy9re9E/su2g+g9pmCZ4jsgWs99MQYXshVozngBBAzuMYsZJ+Y
	 8vGe8zTkAzQ+A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 12 Sep 2025 18:36:49 +0200
Subject: [PATCH net-next 3/3] mptcp: pm: netlink: fix if-idx type
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-net-next-mptcp-minor-fixes-6-18-v1-3-99d179b483ad@kernel.org>
References: <20250912-net-next-mptcp-minor-fixes-6-18-v1-0-99d179b483ad@kernel.org>
In-Reply-To: <20250912-net-next-mptcp-minor-fixes-6-18-v1-0-99d179b483ad@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Donald Hunter <donald.hunter@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1280; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=02RbCJy/0KB0IDkyTE3zAtIENx+JAzvBYgUMKFwaNUk=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKO+Oif3qD3/X3luYob1moJvTddKi6Hn/7SYV1ZEPNqj
 du8sv+vOkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACYS5sPwP/FvcN2+3vVNlkJ2
 DmEhjVbCYXLipwsPh1ft0U8VVfvxjOF/satpwcVVc+0MHySIifE/Z/Btm+7upl1/eV/u/sim156
 cAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

As pointed out by Donald, when parsing an entry, the wrong type was set
for the temp value: this value is signed.

There are no real issues here, because the intermediate variable was
only wrong for the sign, not for the size, and the final variable had
the right sign. But this feels wrong, and is confusing, so fixing this
small typo introduced by commit ef0da3b8a2f1 ("mptcp: move address
attribute into mptcp_addr_info").

Reported-by: Donald Hunter <donald.hunter@gmail.com>
Closes: https://lore.kernel.org/m2plc0ui9z.fsf@gmail.com
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 50aaf259959aeaf36e7ab954c6f7957eaf2bc390..2225b1c5b96666cd4121854c967a7f3a79824047 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -113,7 +113,7 @@ int mptcp_pm_parse_entry(struct nlattr *attr, struct genl_info *info,
 		return err;
 
 	if (tb[MPTCP_PM_ADDR_ATTR_IF_IDX]) {
-		u32 val = nla_get_s32(tb[MPTCP_PM_ADDR_ATTR_IF_IDX]);
+		s32 val = nla_get_s32(tb[MPTCP_PM_ADDR_ATTR_IF_IDX]);
 
 		entry->ifindex = val;
 	}

-- 
2.51.0


