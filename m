Return-Path: <linux-kselftest+bounces-32470-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 878D7AAB6FA
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 08:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 267714C7515
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 05:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623D823D2A1;
	Tue,  6 May 2025 00:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nl5716WV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964DF22D9F8;
	Mon,  5 May 2025 23:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486323; cv=none; b=FE8D9v97vb5pgX/wWnXWgNB/+gvk89uw7pl2FX6Q3SCCFR6pHtjTlHlM8uSSFmgWiu8vwNC12SJ5BfTCQ6ZOSYcqT+b7uDOpxErWvSCE7r41CsK4JnCBRzJ7zWt9jqxeeL6r7zX8WfcrWdg0cok0pVqoDHKAGS7Knj2V/SYq4w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486323; c=relaxed/simple;
	bh=pLsPsfht90VZB3Si4meBRTHexekqw5MmVmkOeEYazCY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pqfvbY+BtOeGDzC9vQ0O5cKodbqLyZgsBIV4nET7Y7wOm6udrRl7hdN5I4IuFWIZOfXRU9OqCqzmAsAABeh5r+VSByMumL8KHZt5EEtZJj4M7/DlhLla9KGdwSCI7raMHhK0VKscOh3TxfeDGi6a+o4i01SSDXws1HCkdGMd7yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nl5716WV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F5F9C4CEE4;
	Mon,  5 May 2025 23:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486323;
	bh=pLsPsfht90VZB3Si4meBRTHexekqw5MmVmkOeEYazCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nl5716WVmlerxyhtXG650G49LsZ9eny6NcMHTKOBUfIXDLYiWCGtz8FlWv9xagmjx
	 wLsNXVK2W+YKfMBku28tUPsvWxdl0VyalZWpjFtsnPHBgE3FerfL6j3GrDZLQXvyUb
	 pfWcvixxr0VqlL+LPdRUSW1mxjks6CyWWehzc5iPSaKIaBlvdDZAejvK7VTAKftp1z
	 Xhxt1TGpUpwQLjP9P0tdChc+fbvp6kdOUHs95IMotpR+oZQPtUJakuK3NHEZF8IGaZ
	 vqkCjErL0ATd7+ND/8fRhp92K0lbnKOUzibUJTvBs4dCDdu6WZWhon5SGZ27eynWw4
	 C3g/W25oLZGQw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Petr Machata <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 259/294] bridge: mdb: Allow replace of a host-joined group
Date: Mon,  5 May 2025 18:55:59 -0400
Message-Id: <20250505225634.2688578-259-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Petr Machata <petrm@nvidia.com>

[ Upstream commit d9e9f6d7b7d0c520bb87f19d2cbc57aeeb2091d5 ]

Attempts to replace an MDB group membership of the host itself are
currently bounced:

 # ip link add name br up type bridge vlan_filtering 1
 # bridge mdb replace dev br port br grp 239.0.0.1 vid 2
 # bridge mdb replace dev br port br grp 239.0.0.1 vid 2
 Error: bridge: Group is already joined by host.

A similar operation done on a member port would succeed. Ignore the check
for replacement of host group memberships as well.

The bit of code that this enables is br_multicast_host_join(), which, for
already-joined groups only refreshes the MC group expiration timer, which
is desirable; and a userspace notification, also desirable.

Change a selftest that exercises this code path from expecting a rejection
to expecting a pass. The rest of MDB selftests pass without modification.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Link: https://patch.msgid.link/e5c5188b9787ae806609e7ca3aa2a0a501b9b5c4.1738685648.git.petrm@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bridge/br_mdb.c                                  | 2 +-
 tools/testing/selftests/net/forwarding/bridge_mdb.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 7305f5f8215ca..96bea0c8408fe 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -1030,7 +1030,7 @@ static int br_mdb_add_group(const struct br_mdb_config *cfg,
 
 	/* host join */
 	if (!port) {
-		if (mp->host_joined) {
+		if (mp->host_joined && !(cfg->nlflags & NLM_F_REPLACE)) {
 			NL_SET_ERR_MSG_MOD(extack, "Group is already joined by host");
 			return -EEXIST;
 		}
diff --git a/tools/testing/selftests/net/forwarding/bridge_mdb.sh b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
index a3678dfe5848a..c151374ddf040 100755
--- a/tools/testing/selftests/net/forwarding/bridge_mdb.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
@@ -149,7 +149,7 @@ cfg_test_host_common()
 	check_err $? "Failed to add $name host entry"
 
 	bridge mdb replace dev br0 port br0 grp $grp $state vid 10 &> /dev/null
-	check_fail $? "Managed to replace $name host entry"
+	check_err $? "Failed to replace $name host entry"
 
 	bridge mdb del dev br0 port br0 grp $grp $state vid 10
 	bridge mdb get dev br0 grp $grp vid 10 &> /dev/null
-- 
2.39.5


