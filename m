Return-Path: <linux-kselftest+bounces-41382-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9858CB54E82
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 14:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 266303BDE34
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 12:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619E830DD05;
	Fri, 12 Sep 2025 12:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6SQmQEh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D3030CDAF;
	Fri, 12 Sep 2025 12:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757681596; cv=none; b=dMtZ/gZS9/GEb4OvwN2D7IAS1T/gNrXXEWO45ZqoMdSg3/IMpFM8Dc/Ak31n+o1crqURF3S04/Wezv0iZanNexhzWxzu7RGq519/2A/jsJMLfV4NtAzPXSfK/0HnPF+SbUy6D+NMOJ7NMzw/bJQ0Ds1oocv+K1tGYMp9GL0wx4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757681596; c=relaxed/simple;
	bh=uytak4k5ZwFQ8XmiI8MdssXPsqKkEtpvw0SvCwqCmRE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CbeOOXpSlrXOzMLKMibpeJf95Asn26/2BtpgYnAOmatf9lXgMUsjcWUwennMH9mph6QcBlvj4ltl6m33fHM6ybhQWf7XZl2UZSCfbyj4W7qX/6RxcIkMUUphZZXF6PzcN06YNCaiH6q51HNHNzt4qDn6QeCh5fbscwyOlZI35rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6SQmQEh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE8CC4CEF1;
	Fri, 12 Sep 2025 12:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757681595;
	bh=uytak4k5ZwFQ8XmiI8MdssXPsqKkEtpvw0SvCwqCmRE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=i6SQmQEhcjS+ijLAZf/WLPVpXmWUJarwPLEXq4CyaseR6Qn7zzSKI8Oo3SbTNmUHH
	 gyhmPZwxgHbPnkm0rj0H7GdxlM9LcUi/KNP2g2ybcPYySgpAWkeg27/CYmFabJ9cel
	 fWg6Srh6CyFSG5qiLxwhFk74UY5yi58D05vqLen1t6syMiMYZ3Q8bRFONAPbmHCsQ3
	 kXAJ+fCg7HBgVXigczJNp6z5laJXDlEmZWH+qR6gvQuK+UZif9Mm5AzJsWnmTnK6zK
	 vojaCrvh0cTk76QDDsmD0y9Xoubj4Z2K5VmtIEYCpTi45OXQl9+LRzlMapgOBUQ81M
	 YnWpIaMmDq4Xw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 12 Sep 2025 14:52:23 +0200
Subject: [PATCH net 4/5] mptcp: tfo: record 'deny join id0' info
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-net-mptcp-pm-uspace-deny_join_id0-v1-4-40171884ade8@kernel.org>
References: <20250912-net-mptcp-pm-uspace-deny_join_id0-v1-0-40171884ade8@kernel.org>
In-Reply-To: <20250912-net-mptcp-pm-uspace-deny_join_id0-v1-0-40171884ade8@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
 Florian Westphal <fw@strlen.de>, Kishen Maloor <kishen.maloor@intel.com>, 
 Shuah Khan <shuah@kernel.org>, Dmytro Shytyi <dmytro@shytyi.net>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1408; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=uytak4k5ZwFQ8XmiI8MdssXPsqKkEtpvw0SvCwqCmRE=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKOiK+UXLM76VzKU6V/zlN73MKVnocZ9C141BnA4thif
 inLWt+lo5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCJ8/gz/VA++UI6/eEy34WXz
 W7PlMfs/nFT6+uiT1KpDCkZZuu/vRzD8L2h5+fnPhnOcR4/Ir9j+yuLVp+gZ4i57+V4nXItNPcs
 SzAEA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When TFO is used, the check to see if the 'C' flag (deny join id0) was
set was bypassed.

This flag can be set when TFO is used, so the check should also be done
when TFO is used.

Note that the set_fully_established label is also used when a 4th ACK is
received. In this case, deny_join_id0 will not be set.

Fixes: dfc8d0603033 ("mptcp: implement delayed seq generation for passive fastopen")
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 2a8ea28442b271675411d190604073f779bee7fa..1103b3341a70560f563bfb21ca143ce2f2c60321 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -985,13 +985,13 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 		return false;
 	}
 
-	if (mp_opt->deny_join_id0)
-		WRITE_ONCE(msk->pm.remote_deny_join_id0, true);
-
 	if (unlikely(!READ_ONCE(msk->pm.server_side)))
 		pr_warn_once("bogus mpc option on established client sk");
 
 set_fully_established:
+	if (mp_opt->deny_join_id0)
+		WRITE_ONCE(msk->pm.remote_deny_join_id0, true);
+
 	mptcp_data_lock((struct sock *)msk);
 	__mptcp_subflow_fully_established(msk, subflow, mp_opt);
 	mptcp_data_unlock((struct sock *)msk);

-- 
2.51.0


