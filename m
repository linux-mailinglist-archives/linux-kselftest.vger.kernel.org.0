Return-Path: <linux-kselftest+bounces-32450-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EACAAA746
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 02:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6D76188406E
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 00:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD6E33521E;
	Mon,  5 May 2025 22:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNwGdJ0K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D031E335213;
	Mon,  5 May 2025 22:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484590; cv=none; b=UGsH7fLHGHhYc/icVhgtepVRV0p4RdkURLI3ZwaCMP1cKQzwQk6AAFOOV4z5akh0uPWIipBILvYS02vkN0hMVKMTMPXyucSOpoFRliZ+/z6yv/pecX0ejH7V7nrFuNVslOvudPID/Cf9M6m6Kz8cDatbinD/ftcEcS3DDN0A4Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484590; c=relaxed/simple;
	bh=zmpFkEnZZLrrF49HUhfJohjoZOt4osMV05kEKXJ/pvM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pa06KHILGmFFd/3r/uGz7/E/35PQ2x8Jj+p73ROCtjcS7fYVovPyGJVTMs6raW8mSKIkJ8K0/35XiieXsdqoWoj5mYFkEYPb/PJtlZrn2g8tcF6JGnFZ1h1PgtbiBEsLJFUN+wTQBBsdE+KHqKYgLh0Lbnzy+2HeNw+ZmqqZcZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNwGdJ0K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E389C4CEE4;
	Mon,  5 May 2025 22:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484590;
	bh=zmpFkEnZZLrrF49HUhfJohjoZOt4osMV05kEKXJ/pvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aNwGdJ0KAPoSxinGpxaUhAVq7z75/cNcKQHEDRwzKgQ7TzDRso5TUnWg6ue0X4lP/
	 72oWsxFfli6cAQdceFw5zLcDTNtyI2ISWSgJiLD7ypUeMV2pTj6bxFO3PrxLLbdy7I
	 UkEVjhbVy5Ninf4+KCy+WwQ//P870u2BmOfyDVhgniuOSFar2coslNCPdkJXSAQxnj
	 eH/icCrOGIpG0oP1AM9vlG+G5WBiYSEnmK3qkPibtY9y4zhSBzUbpT0i1cIEkZO3bG
	 Ql8QRlx73Xw5VYXNTdXeao0gtfqHG4KHzN+OYLDGwNlCd9c8ZE3B2BPTtbwEPxGBCo
	 0hDsY2vECYwkw==
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
Subject: [PATCH AUTOSEL 6.14 551/642] bridge: mdb: Allow replace of a host-joined group
Date: Mon,  5 May 2025 18:12:47 -0400
Message-Id: <20250505221419.2672473-551-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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
index 1a52a0bca086d..7e1ad229e1330 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -1040,7 +1040,7 @@ static int br_mdb_add_group(const struct br_mdb_config *cfg,
 
 	/* host join */
 	if (!port) {
-		if (mp->host_joined) {
+		if (mp->host_joined && !(cfg->nlflags & NLM_F_REPLACE)) {
 			NL_SET_ERR_MSG_MOD(extack, "Group is already joined by host");
 			return -EEXIST;
 		}
diff --git a/tools/testing/selftests/net/forwarding/bridge_mdb.sh b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
index d9d587454d207..8c1597ebc2d38 100755
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


