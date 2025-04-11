Return-Path: <linux-kselftest+bounces-30576-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A51A85B30
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 13:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5069A8C3884
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 11:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C2E298CA4;
	Fri, 11 Apr 2025 11:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbKWqXK2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED80C2989B6;
	Fri, 11 Apr 2025 11:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744369521; cv=none; b=Rh9JL5MZzDEuusrRGYmOxWYss/OYU91LcKiM7bpp4eOP32RrJkOrId/rmtsucOYgKdc5sR7wzzUGDlV+zzUl+4nj4w275WcVTHNGTPcyP0rn4CdYQ2F8nvL6k9TyN4mcCEgIUQQEqPmXYtp9BGvPWdmoeJsaTxNITLOmM+QI9uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744369521; c=relaxed/simple;
	bh=Ed73cRHm7tHOkgc9qekoaFLdbmR1sHWKWLgmp0Roygk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iRE2Q9sM6RyS7EnnsWZiG6Kxtdn7OAAbBwX1kndj9kWK9MWKMk51PCtie3Q/e2ODJu2gggztOYFaULes57Xl8nJEg0UrnddMCqgOCJQabVK2L0xYDJurs4Dz5tDX5KgbWjsxgyI2DyPfnyH9m8dC+IeANFLtRkEd7tWy2zokUrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbKWqXK2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38DF3C4CEE2;
	Fri, 11 Apr 2025 11:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744369520;
	bh=Ed73cRHm7tHOkgc9qekoaFLdbmR1sHWKWLgmp0Roygk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jbKWqXK2Jf88GR33cceU3APNpgTWemkDzk5/Rk5uajv7GNV8Fs/OxioFECuIZLm2w
	 32SRl1tRBzsmJnL7vY1+UyF2Iqzy5DStwffSlY81uTwClVxvY5ICVbQH2kWGLPVnrp
	 xYhOqk61hoe5VY9n2AFtDQaMGnCWlWv7etCzYMy0YIbWhrrMu9CF88ySVk1kPuvtRy
	 IbKDPYM2OqWqeOxtEmiNA3+i9rVf7mG1+vbt6DE18KJX0vKrGwpplPD2MgjxCkwmKD
	 Q8sbKHKAzpKloO5/zUFAzgDX4UtvhC5ZbBX/oFBSw72o17TVxT2oIuR3C3xhR2+RyT
	 fz2ZdF2O4BM8w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 11 Apr 2025 13:04:49 +0200
Subject: [PATCH net-next 3/8] mptcp: pm: Return local variable instead of
 freed pointer
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-net-next-mptcp-sched-mib-sft-misc-v1-3-85ac8c6654c3@kernel.org>
References: <20250411-net-next-mptcp-sched-mib-sft-misc-v1-0-85ac8c6654c3@kernel.org>
In-Reply-To: <20250411-net-next-mptcp-sched-mib-sft-misc-v1-0-85ac8c6654c3@kernel.org>
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
 b=owEBbQKS/ZANAwAKAfa3gk9CaaBzAcsmYgBn+Pde3a88nBCNp8v/XVC2zkxcTkahRWLWI54la
 n4AUTVGQkmJAjMEAAEKAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ/j3XgAKCRD2t4JPQmmg
 cxmSEADS+nEvMzEJByTidg+V6dieI4/vT2EoTz1BuCjfdN1TUxoCCXtwQPdKvYzbcPri6dcLLom
 FxFu++SyViYwz9sjc25XDsM/JGpNpSA7ECTIDjqp9LQuE1KnWP2uCzZFqQzqQJS3ehZ39P98gij
 35JhoAmZyZK6d5kd35xt5h9xqVLpY2ZGiY0jE4TBCdyl1dhXQeKt/GgKtvYCnwblqUPkjI+LpJf
 6DlZF111TXIG/gWEfY//5Buh9OhKpTjawmbRaqkHA5Ur98M/vWu33bNEKdH2H88vfXcXxMq6X+4
 p97ave9DpzYg4SPjnXKc9ev6kMATcoCT4y65hKgF9jJ6v2ICNqEji3U0L47shGutLmzlukEFQfr
 j1XIzOiGwqPoqdBAR6o9HP89YphmU3V78qbYaiS2owMq0oX0q2mHEJQwLc7d+cD6JQw9iWKTkpm
 jdVKvZQY8Kb0ayfd8plbEl+bU7cmqlRto1nKzcGNXM07/gMwoq+Jg+YDgDcyLvATb0G0yfITpgC
 5sIJ7vIMw2+XRgM0EqBJwYcOfsqi4Mvl0Mtv8j0odoUumM/3iICvE5jwpPTi0GGnkqt1ax4ttLh
 ZWoNVfEXyRKm/OTVF4I3OF5olEJ3pH8rSvR9kaGj7OV8kOspk61KtsiYdcbgBg/2c8WxHs/9m1B
 iZPlybC5schloIw==
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


