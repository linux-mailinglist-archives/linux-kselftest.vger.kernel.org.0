Return-Path: <linux-kselftest+bounces-28897-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4285EA5F09B
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 11:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66526171E7A
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 10:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B81B26563E;
	Thu, 13 Mar 2025 10:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5Fu3M+2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEF126462C;
	Thu, 13 Mar 2025 10:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741861340; cv=none; b=tQ6sKywQRxts/pbkJe6Kd/vXSdGmllkQ4vhHSbO8SWjqU3f6ohrX83tAwETkKVoj+6ot8E95DVdN7ACmyjlWyyJafl3/87qwhcErpy6Lcto2LNcfrZH7w9acFqfeWSepIlUAZBS6jQ7acQePy/oSA3CZZrN5Gzci8+r+63EZubo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741861340; c=relaxed/simple;
	bh=iCXqiyNgaUufJYNxltgPY1kZh2aAyu/eXYIN8V+MMqk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S018VDcuC3KXfXG0cpCsVC6Z90yqvmMFSQ1CsEVqBaJXzKGwhcw5mbM4YhPeRRS2C/zmXHHOH0p09ZpAKVtOrSXjOQh7n17Ug5yVeSK3i8f6WwzqRi19w3+8iFFH3+olqdsr4jVpObEyTMfs6bzUF08gMpzyMjEBkwJoYfLHvnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5Fu3M+2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB60C4CEEA;
	Thu, 13 Mar 2025 10:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741861339;
	bh=iCXqiyNgaUufJYNxltgPY1kZh2aAyu/eXYIN8V+MMqk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=G5Fu3M+28HWi3jJfavHCxdiV1kYDvopnJj6S7CfBcA+c7saMxE5zvkoGvBeO52S25
	 QHG0owG46revXunV/CbSdG395tXauJ8U49BMvOxgs1AE3wklOP/uVBL7ifoNE+mMMk
	 77EQYEUyzl+rebvpnBhJIbhe4B2vA5Rf+SOXchv1N9agKrkq6aq6aR2dnrtVn7gr0W
	 9pG8yA/z3tyFsrQnZN5+37Jnwlzn1/4KmJi5zB45Rte7TjYWoNYVlBlGB7XO6KAeLh
	 9f/UtSnDStjvLFXAQ8viZA3EpG5NJ17CoxlOFa6hOVmmF8LpKg6ttlKGu6VR4Ztc3U
	 6tTIaIzgkrrig==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 13 Mar 2025 11:20:54 +0100
Subject: [PATCH net-next 05/12] mptcp: pm: add struct_group in
 mptcp_pm_data
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-net-next-mptcp-pm-ops-intro-v1-5-f4e4a88efc50@kernel.org>
References: <20250313-net-next-mptcp-pm-ops-intro-v1-0-f4e4a88efc50@kernel.org>
In-Reply-To: <20250313-net-next-mptcp-pm-ops-intro-v1-0-f4e4a88efc50@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2239; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=RZVcVWy0Z+SJTFF/HiVwvvq0OGDhr5NaFWk5fqBDblE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBn0rGaxOeGXTUAfKEuYiyC3sR3tDcl/eCK4QAiy
 WFJ9AyljJ+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ9KxmgAKCRD2t4JPQmmg
 c4C0D/9iEZ8nbakxrYbCT2eqZMujSZDyZ+JRtQBZP69joT7rtV3gaqYNclBxrksLRJM9Sld5PFx
 72ygNrlsp9irqVuEFpRs60E939Uy/6b7q7IwBl/ht1HIf7CzaQFWCjv9BnTWBeGfwmA0J0UlsAa
 jb1ZkA4nVo/82vYoHyAbgKtt3kwTIQS2EJH0xtcp+JFFdMb2b/c/yRvrWAUIBY4vyvR61O92KqQ
 C2xsuS8itHMt7/6Puftxzjcn5lyVWwDg8xvJ+ZyYWtuJVGkaWbusY+dW0KY3/RdXyNjt7ODSV/P
 SUwo5nq6omgbPfIU4S5moRQE7UWs9+Ohz/N1aX/LM6ZuvIx5ix/nPFBaSW0ewD41HviYJGz8VNx
 iTsIjRSQ807HvsucUD54bZbCOSV9tklzAS5xVLVSjJikGItEsCTmGbw5EP63zqt/SJyQrc29mb2
 dOpTb6obBchoOk4wEMbQDjtn00RFo77PD93wN7DpQ6LxPg0u9/OL1W3shbKjj+1U48ykF5pQqbd
 iHwU5SpTj/Bn5v0t5lQmY7/0s1GlLSiG7tX7Zn1mZ/rIfde4HZlVv8oATPcyIFYzs9QjdhMAPIL
 A9lqxZUvYkiHkRaB+ddJ/1C0TsUfGQs0FcUhQCwESGForMVvLIbGo+l3lYGiici+nXKMLkRiJaF
 TLh4Imo1oLxaudg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a "struct_group(reset, ...)" in struct mptcp_pm_data to
simplify the reset, and make sure we don't miss any.

Suggested-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c       | 13 +------------
 net/mptcp/protocol.h |  5 +++++
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index af009661477b1743b11221c0d59b53cd89e6e791..85ee999729a1c37f42bb21490d7f68d186e6734f 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -978,10 +978,7 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
 	u8 pm_type = mptcp_get_pm_type(sock_net((struct sock *)msk));
 	struct mptcp_pm_data *pm = &msk->pm;
 
-	pm->add_addr_signaled = 0;
-	pm->add_addr_accepted = 0;
-	pm->local_addr_used = 0;
-	pm->subflows = 0;
+	memset(&pm->reset, 0, sizeof(pm->reset));
 	pm->rm_list_tx.nr = 0;
 	pm->rm_list_rx.nr = 0;
 	WRITE_ONCE(pm->pm_type, pm_type);
@@ -1002,15 +999,7 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
 		WRITE_ONCE(pm->accept_subflow, subflows_allowed);
 
 		bitmap_fill(pm->id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
-	} else {
-		WRITE_ONCE(pm->work_pending, 0);
-		WRITE_ONCE(pm->accept_addr, 0);
-		WRITE_ONCE(pm->accept_subflow, 0);
 	}
-
-	WRITE_ONCE(pm->addr_signal, 0);
-	WRITE_ONCE(pm->remote_deny_join_id0, false);
-	pm->status = 0;
 }
 
 void mptcp_pm_data_init(struct mptcp_sock *msk)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ffb70fe08181815c23629354f78e3bdbe599e703..15e2a03025ecb4cae44ccb700fcbbdd06ab806d1 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -223,6 +223,8 @@ struct mptcp_pm_data {
 
 	spinlock_t	lock;		/*protects the whole PM data */
 
+	struct_group(reset,
+
 	u8		addr_signal;
 	bool		server_side;
 	bool		work_pending;
@@ -235,6 +237,9 @@ struct mptcp_pm_data {
 	u8		pm_type;
 	u8		subflows;
 	u8		status;
+
+	);
+
 	DECLARE_BITMAP(id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 	struct mptcp_rm_list rm_list_tx;
 	struct mptcp_rm_list rm_list_rx;

-- 
2.48.1


