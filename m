Return-Path: <linux-kselftest+bounces-5350-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D0E861768
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 17:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55FBDB293E2
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 16:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671F085954;
	Fri, 23 Feb 2024 16:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJL2laFc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED7D84FAA;
	Fri, 23 Feb 2024 16:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704891; cv=none; b=O38IKOTu8HI5sDoahz9AXu8LSGv5RDGBBekVWn5qIAfPgekZ3PYRlurASFBwv0+hWN6LKVA/XvMOgjo2I347ebQiuJlhVax7zb7Cl8c+1Fo2TDKOQrowYZJUaPXUNu5484zz+oEFdG/uayBx76S5BVPsjn1/uVbbtZGwX9OfcIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704891; c=relaxed/simple;
	bh=yqVpPDEMqq8zK76y9/RmkaivQjX+jkMnWSVK2jv/tQg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eYC5kxbHKrFnRho1b+dbXLOh9X30QRJDJ7GmIzHMMaFywTqsKO+JOy19RIgxSP6VJZaXhpOrZvqsXgZWL9xbSe9PRlXI3aBykzdV+nBCfDSKsLlH91EBCJKoGExEGFr5vn25Qb+MrmnEz1HwUIAEWO42/TC9YBCRQaKBiYIs5H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJL2laFc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121D6C43390;
	Fri, 23 Feb 2024 16:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708704890;
	bh=yqVpPDEMqq8zK76y9/RmkaivQjX+jkMnWSVK2jv/tQg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rJL2laFcQJvQzSBN68I++1KDdpnbpoFHC5tniRy7U/iyPwSTUfKyuDjkPLbaWwq9g
	 uoFzvarctpfa5tXnqekNcM3DBaLIlctwRjN/DIMLtDb+C9zHUTCu8RslzYc+hSNreg
	 wd/gkpLmdTd17H8Ctr/24cr3dD97jEjKqCsD622zxeeWdz500mGPFSR5iEM8KR2CIW
	 l6l0RYDuXCbXlV7oUEljfkFdwqRYMC16TEEDtziNw9VWR4jsVm0W7Wy8aP1Abp6o/z
	 b0tXtARfUvWsqbpR8RCemUfmrOPjxZ2GNO1iDoFIMMZ6WJhS+X6gkXMygS3wCGWLiY
	 kqbTsVNMXxNFg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 23 Feb 2024 17:14:13 +0100
Subject: [PATCH net 03/10] mptcp: avoid printing warning once on client
 side
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-upstream-net-20240223-misc-fixes-v1-3-162e87e48497@kernel.org>
References: <20240223-upstream-net-20240223-misc-fixes-v1-0-162e87e48497@kernel.org>
In-Reply-To: <20240223-upstream-net-20240223-misc-fixes-v1-0-162e87e48497@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Florian Westphal <fw@strlen.de>, 
 Kishen Maloor <kishen.maloor@intel.com>, Shuah Khan <shuah@kernel.org>, 
 Peter Krystad <peter.krystad@linux.intel.com>, 
 Christoph Paasch <cpaasch@apple.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1379; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=yqVpPDEMqq8zK76y9/RmkaivQjX+jkMnWSVK2jv/tQg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl2MRqWg0B1Jjp3HzUvASfzwT2t8eB6Fif+NvbI
 dLqtrIJcsSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZdjEagAKCRD2t4JPQmmg
 c3cZEADmMRbSTC/9CnNeg7emKx2DvjHpspiVlqu2nUM5x6yWnhKyia7OM1BvZMY94o31oWDzYcL
 cd4AeEF/sE3Yz+x0mGM3gEtH/NCuNjXXv6I6el/29kmdx+7CAGscV3k0L75wd3evuzQhVieXNq7
 /EC54fanr/EO154BPDq2FJ8TzR+CaJJMMVIe473/vggq8R/EifQFi/lXBl//HHa5sY0HFZNCkM0
 vwJ+jJxxe2MGtGWXqQqIGuePYBuhbmU+7nR0GgYOUE9G/V4AFi/nx9MOddb7ek9zdEOjgVOXRgC
 pQyMdPZWlOXKEw1kyLnUligfJLPIL0PEyPObI4jWaC0j5efzqy4+NZS+WnULWJyB2QD70Vf0hvI
 TPWqLzhIbrHEqetHNF6k2CGQjD65B7msGkPrK54OX4o7ME8+gfSUALJMimbPTilZ+5zdOuoPIfH
 Kaaak6/VGqIrO0hmAQ1jBTr3YfhIaxxDYwBa/7oo2PwX+sfFSEsHYlzY6rim2JMD/XEUK707fMk
 S+VKFCi7C+5QeTlQjFNfw/FnmL78vvwQUzCWTeCZRIS56qZ8vve2LbKrNd6yhpkCFQ6uxnAt37C
 u2qSDb5BhPV3LbVj19mlq/wFiU056rcf0lBmW94UvoOpclSYgTu83Dqm0dyTSzj6LSvOqOWP97u
 Iwyc5cVo8Syjjag==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

After the 'Fixes' commit mentioned below, the client side might print
the following warning once when a subflow is fully established at the
reception of any valid additional ack:

  MPTCP: bogus mpc option on established client sk

That's a normal situation, and no warning should be printed for that. We
can then skip the check when the label is used.

Fixes: e4a0fa47e816 ("mptcp: corner case locking for rx path fields initialization")
Cc: stable@vger.kernel.org
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index e3e96a49f922..63fc0758c22d 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -981,10 +981,10 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 	if (mp_opt->deny_join_id0)
 		WRITE_ONCE(msk->pm.remote_deny_join_id0, true);
 
-set_fully_established:
 	if (unlikely(!READ_ONCE(msk->pm.server_side)))
 		pr_warn_once("bogus mpc option on established client sk");
 
+set_fully_established:
 	mptcp_data_lock((struct sock *)msk);
 	__mptcp_subflow_fully_established(msk, subflow, mp_opt);
 	mptcp_data_unlock((struct sock *)msk);

-- 
2.43.0


