Return-Path: <linux-kselftest+bounces-30646-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CD6A87150
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Apr 2025 11:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7438179137
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Apr 2025 09:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A13F1A314D;
	Sun, 13 Apr 2025 09:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/pgXU/H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D571A3145;
	Sun, 13 Apr 2025 09:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744536904; cv=none; b=a8x5W3mQY7WIYf5qllKfSbUXS09MVKYieCDSr1hZJIYiMLOZ8y3lllrpP4lWeYvie/vDCq/RfVQJQVayaqRsJtT2KM6vgIB2Fn5plfhotw414cLFRkBOStCeExOkSUeW9aHQZwJezyZOjZU9ZpZoTwYsTiBtBD4s3Jbc79CsH7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744536904; c=relaxed/simple;
	bh=Ed73cRHm7tHOkgc9qekoaFLdbmR1sHWKWLgmp0Roygk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FXp/cBrno0/YG65WS0+s1ERoZmtE9//Y4Gt0vci5aboNkgPOlxfZ4y4Ar0tU+I1yM+VaPGNWbFKhRigmTcJqnSleIq8+1pE6Je/L27kEXJTeuKMq4dXhWNMED2JaqBZSm4ElkNK/NKRorVJd+oQNHAB+rI4aerWJnwrDbH24Slg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/pgXU/H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42070C4CEDD;
	Sun, 13 Apr 2025 09:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744536903;
	bh=Ed73cRHm7tHOkgc9qekoaFLdbmR1sHWKWLgmp0Roygk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=D/pgXU/HhKrITYgh/b4NJsAEMrhWZe/rJ4oxqzy4N3eDRB2U2BtPeedsxlhLUbUkN
	 iKsf332AyGTm52Qs65ay3jL02ddjsfMihieeSnvDPVavx2QeziXX0Uy3ej0Qg4fZxi
	 iMfXnVX7N+2+VrR1MrfBJP1d84HnEetkoGLlKWWRgVDqZ9I1kHToZD1XdBTvNAvoNT
	 XTQqM3U+K2hUis60waLXWtS89V8ygF2DV5adllbjqpcZ61gKxB75Fk3oxnmMRlsS5I
	 C1PqYcyXTtmPduapkpERDzCoLEa5BZpkpwpHffDCgWe0TYXyZq9nht7yB+2HvFz5X5
	 t7A91BmOHnmsQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sun, 13 Apr 2025 11:34:34 +0200
Subject: [PATCH net-next v2 3/8] mptcp: pm: Return local variable instead
 of freed pointer
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250413-net-next-mptcp-sched-mib-sft-misc-v2-3-0f83a4350150@kernel.org>
References: <20250413-net-next-mptcp-sched-mib-sft-misc-v2-0-0f83a4350150@kernel.org>
In-Reply-To: <20250413-net-next-mptcp-sched-mib-sft-misc-v2-0-0f83a4350150@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Thorsten Blum <thorsten.blum@linux.dev>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1602; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=jApLlQe9kLWnNYT+J4tjFKFNld+C/W/579HgmrPr8y0=;
 b=owEBbQKS/ZANAwAKAfa3gk9CaaBzAcsmYgBn+4U1vKShTBG77hMueQNozZqbUWL5yvz4Efe+8
 ehBUrIpdYWJAjMEAAEKAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ/uFNQAKCRD2t4JPQmmg
 c9ySD/48hs8A/Y4pTcTMbDzbWisj+eQkRF3kKiheAtuxchaqxLX/7CK2e32MQrmIz6zDNFqs6fL
 JXNhW2z7+kKLGC9Zh909rPumRTK1g+358FMzj9GL0JpCaUWWfAquOjfWVQjZ2RbPM8U+uUMjL6+
 CZd2vNMYhV1BsHno7bCo4egpsmAL+NYkMvz3egU2GMjAbadeuLNqwd/hFkPRrt8yBTAdfCwd2/8
 5tObN7dXvFVeU18tNOTnYkbo9I0hkLa6wIU6q1+GMenpf5JfvKq5gu3oMAEXBQ9E0d4YY8LAw1p
 M+j5lcqpXcV3BMsYDf4gyC3cMvioQbTtY9N1amqiuy9vHijV3Fd2/xeyGPC/h6G5HVopdfG9PsF
 bgR1zbBe6YrHTF/fK2GmneuxFm+K5HSFHktJ+4/VYPerwG5co/xrojEjvPUhYtdJ0dogJner53+
 I0eF2OxEg5sVgqU88XztYO7gtQpjh+LFqY9VLTIjrMRewd4fBCjo4O8P9pKJO9Lo2YUgNwn0rdg
 G9oneVC4k5u3JaaDP8bBvToqMdpwABpEk5nlh/w4Jey0sPAElnRwFmPXvkCe8rjUMgScYeABZAh
 IrF2dR+i89wIaNo8R2w77yiJEpqDchccs707XsLP5kdsyt+tGlU0IU7SqiZ/MC6+Eo8Bq4NxFiG
 FF8mPhg+OvRGIOw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Thorsten Blum <thorsten.blum@linux.dev>

Commit e4c28e3d5c090 ("mptcp: pm: move generic PM helpers to pm.c")
removed an unnecessary if-check, which resulted in returning a freed
pointer.

This still works due to the implicit boolean conversion when returning
the freed pointer from mptcp_remove_anno_list_by_saddr(), but it can be
confusing and potentially error-prone. To improve clarity, add a local
variable to explicitly return a boolean value instead.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
- a previous version has already been sent to Netdev. ChangeLog:
  - Remove the if-check again as suggested by Matthieu Baerts
  - Target net-next, not net (not a fix) and rephrase the commit message
  - Link to this version:
    https://lore.kernel.org/20250325110639.49399-2-thorsten.blum@linux.dev
---
 net/mptcp/pm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 31747f974941fae3f80bfc8313e82c41f92562eb..1306d4dc287b842ebf7efd52d121b096d5cb43e0 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -151,10 +151,13 @@ bool mptcp_remove_anno_list_by_saddr(struct mptcp_sock *msk,
 				     const struct mptcp_addr_info *addr)
 {
 	struct mptcp_pm_add_entry *entry;
+	bool ret;
 
 	entry = mptcp_pm_del_add_timer(msk, addr, false);
+	ret = entry;
 	kfree(entry);
-	return entry;
+
+	return ret;
 }
 
 bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk)

-- 
2.48.1


