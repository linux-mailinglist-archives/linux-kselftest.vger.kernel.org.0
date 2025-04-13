Return-Path: <linux-kselftest+bounces-30647-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D495AA87152
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Apr 2025 11:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B7F0189872C
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Apr 2025 09:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F7E1A5B89;
	Sun, 13 Apr 2025 09:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5Y53d1q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E618C19D8A8;
	Sun, 13 Apr 2025 09:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744536908; cv=none; b=NbbMUtak5qaqlSpcVo3D6JQlayhy+V4AyXb2eLWWdDqkj7jPmoi0GLboywY4aVwXHpSqiQ5ZSxLAVJhyAGwq8xxB+y3+gSNgOR1ocvO7Xh85ZQ8cu3EsttZHFHb0/sUKj/Zq2jMuRya7bjdBrsA9j6ntpAdmBLsRn3q4lWahSCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744536908; c=relaxed/simple;
	bh=Imic4Np5tJY+bphTiQqz1yPd67V0pf5uLabqu+4kVRM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kr+ApSEvqlJbf7VT/pG1lr0+yUuUTut0Z2JIF2y+dp7IFG9dC9dHJ88B+CATZ6SdMlx8VKjUlf+FmOZv8gR9GlwwXfPLfXweMEtl70ldW+bkmfpnkHjmyHBFSlIj+0I+XdC+0qvTIxPx43WJU3PD807BfvPnwtnDtP46TkJivDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5Y53d1q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2529BC4CEE7;
	Sun, 13 Apr 2025 09:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744536906;
	bh=Imic4Np5tJY+bphTiQqz1yPd67V0pf5uLabqu+4kVRM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=N5Y53d1q4OUXS7WeDybiROQ9g44BpQ4JYZX6EpC1iAfUgYEbByFPAA11dAxpYXqMd
	 J4+rAX4IYRIYLXi7trmxVBEapExx0A/I5YwPP5GdzTRfFitpzGZ9YpoV6inO0p7mWh
	 DeWZe4JX5oLVPijXqDv9iElM7uFJQE59zJ8c8jVvm0lE+hrIzps/mHWqLTtOvhpW66
	 iJn96b3N2QXfV1Y/+DoBdGFYEkE3+gKf6MVCTvvCnACeou+c5WwMfxJeKN2Hc7bUY4
	 Qm3DF6kaX93jlaTvGUAS1JbeMAmApdGmu1IXNliyKdU7cE8WvIDE8fr0RFT7H0OmUn
	 6+RNuvvdV/1lA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sun, 13 Apr 2025 11:34:35 +0200
Subject: [PATCH net-next v2 4/8] mptcp: pass right struct to
 subflow_hmac_valid
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250413-net-next-mptcp-sched-mib-sft-misc-v2-4-0f83a4350150@kernel.org>
References: <20250413-net-next-mptcp-sched-mib-sft-misc-v2-0-0f83a4350150@kernel.org>
In-Reply-To: <20250413-net-next-mptcp-sched-mib-sft-misc-v2-0-0f83a4350150@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1758; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Imic4Np5tJY+bphTiQqz1yPd67V0pf5uLabqu+4kVRM=;
 b=owEBbQKS/ZANAwAKAfa3gk9CaaBzAcsmYgBn+4U22Iee+2Z67moYYPWVeyV3N2g77bjBp224+
 CRlIjOkZayJAjMEAAEKAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ/uFNgAKCRD2t4JPQmmg
 c1IoEADMv4wUU7V5HBt7IYHt1jj4FsrXHtGT95chqIwDU/1RBu+BZdywgHK7tybyZAErl77Im0c
 Ft+BjZh9Ve4v9thfPIsSyytThctz5TAhSQDsXRO2s91oU7ZEtR8ckba/yk2lepr0mTJwyl2booj
 mAcLswk5X4Q3mMb7EuURgeAvCGAfSVU36fvn8cE7N9dw8M1Zd6QgwuRzMP0TaJjZG8w/GIHZMjJ
 ggO3i6vqzNJ8rc2NKMZqRxKw9hgTRF88NRl4Q7NaPNGBybHko4gcqDZo8yw4f1N27zaqiUrAABr
 dyfO4l+aFBkbZGhnf5BxJXToUHjsxnyV3uv5DrIUfCi0xm4HgoBAatKuKBJ5Ry5wmIWdVQQpIw0
 pioG+vj/1eDx8BvqIThBh1x9NsxIlkbe1E5+HlJ8ZLtljnZElJclb65YyqkSDkbH5En14IJbdUh
 IY3bewG6tSbmDZvb+0nECh/fX0bV2DDXWObmLHkACaw9683Qo2o1h68O/LyaR+yz6piNFVu1dKI
 /4pkyTmvHcDpsJcAa1uS0y5KmMJVJloNUcEfmbQ0r+IpLZmrh6MKCDI/gxvEeMJo+qYdxZO3kBa
 kasVvAppvMPKdRvtGbsBwbicXUUvLH+/1PwY97eXUg9zSAhco502gWakvYXb+Xc9OH767KGfkPl
 /oPRQLxc1uBOfRQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

subflow_hmac_valid() needs to access the MPTCP socket and the subflow
request, but not the request sock that is passed in argument.

Instead, the subflow request can be directly passed to avoid getting it
via an additional cast.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/subflow.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 24c2de1891bdf31dfe04ef2077113563aad0e666..e7951786a97c91190c7341d2c586a1f4acc05ed5 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -745,15 +745,11 @@ struct request_sock *mptcp_subflow_reqsk_alloc(const struct request_sock_ops *op
 EXPORT_SYMBOL(mptcp_subflow_reqsk_alloc);
 
 /* validate hmac received in third ACK */
-static bool subflow_hmac_valid(const struct request_sock *req,
+static bool subflow_hmac_valid(const struct mptcp_subflow_request_sock *subflow_req,
 			       const struct mptcp_options_received *mp_opt)
 {
-	const struct mptcp_subflow_request_sock *subflow_req;
+	struct mptcp_sock *msk = subflow_req->msk;
 	u8 hmac[SHA256_DIGEST_SIZE];
-	struct mptcp_sock *msk;
-
-	subflow_req = mptcp_subflow_rsk(req);
-	msk = subflow_req->msk;
 
 	subflow_generate_hmac(READ_ONCE(msk->remote_key),
 			      READ_ONCE(msk->local_key),
@@ -899,7 +895,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 				goto dispose_child;
 			}
 
-			if (!subflow_hmac_valid(req, &mp_opt)) {
+			if (!subflow_hmac_valid(subflow_req, &mp_opt)) {
 				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKMAC);
 				subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
 				goto dispose_child;

-- 
2.48.1


