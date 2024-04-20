Return-Path: <linux-kselftest+bounces-8521-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DF68AB8CC
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 04:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 005FF1C20952
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 02:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61D1C8C7;
	Sat, 20 Apr 2024 02:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FaCW9NOP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADABAAD51;
	Sat, 20 Apr 2024 02:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713580558; cv=none; b=pHJy3VedT5E7l6WUEI9e7pv2ok0xGkb1LjRq0LjzEP4AYpiYck02dtT2gGXSr3tGdn0WKhcPGjY+jDwHimzec0FqieWzldYHmFimnv7zI7Q2jY8TdfTT0wOb5hHuSHETcrwV2qEkyPRDmew0DIpq339oW43mzTuzbdGpfGgKFd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713580558; c=relaxed/simple;
	bh=momb5cFYBoc1k0B9mFw2kRYFezIu6vVQ4eyYyoV9SDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PqmjN21iF5hF4VcnIdnKG2V8zy4g3bGpfFJq1Ir9kbSPIHX3t110/7jy4ZM5j2lKLnF8WAEYMFfgzmhp4SRkr5bBLDdYm3nwRPvRkE8nFutOZjAzCpXnk17pUQLw1CoWRCJ9Dnf/jaiZCideL5mXK/W9r4w2oYGcPWEwZ5M/0Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FaCW9NOP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE524C4AF0C;
	Sat, 20 Apr 2024 02:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713580558;
	bh=momb5cFYBoc1k0B9mFw2kRYFezIu6vVQ4eyYyoV9SDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FaCW9NOP+GRCbqd88Iv1zrEUApoIrjyhhuCg1cNelLZag9mKLEMp9PxL0x8Yi0d9D
	 CqzjFj1mfVXzncTnCr4sDBd/u2h7hK+r5greGjIABnIYYTsBXg2AVAa3PdwoXknXvz
	 z5+UGwHzM6sfwYGrtqodwVdwPIdLaQ5uTQYgGbgfKxZg4VcBsWwQR+8JguC1DaiCF9
	 8xIMm67afqGiUQnTxp9e6AQBGmI6VoRnbqSD8BDxInCg7gIcziVMHu7OUOewoZDOpT
	 SLtO905KqOPuXh0U4RYyAYrnlW155NU4kq5Ok9Nmmca3ZrA7x7aHI3T5I5BtMwwVaN
	 xsnkIOtM9bq2w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	sdf@google.com,
	amritha.nambiar@intel.com,
	linux-kselftest@vger.kernel.org,
	dsahern@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/4] netlink: support all extack types in dumps
Date: Fri, 19 Apr 2024 19:35:41 -0700
Message-ID: <20240420023543.3300306-4-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240420023543.3300306-1-kuba@kernel.org>
References: <20240420023543.3300306-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Note that when this commit message refers to netlink dump
it only means the actual dumping part, the parsing / dump
start is handled by the same code as "doit".

Commit 4a19edb60d02 ("netlink: Pass extack to dump handlers")
added support for returning extack messages from dump handlers,
but left out other extack info, e.g. bad attribute.

This used to be fine because until YNL we had little practical
use for the machine readable attributes, and only messages were
used in practice.

YNL flips the preference 180 degrees, it's now much more useful
to point to a bad attr with NL_SET_BAD_ATTR() than type
an English message saying "attribute XYZ is $reason-why-bad".

Support all of extack. The fact that extack only gets added if
it fits remains unaddressed.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/netlink/af_netlink.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index c5bb09597831..fa9c090cf629 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -2198,7 +2198,7 @@ netlink_ack_tlv_len(struct netlink_sock *nlk, int err,
 
 static void
 netlink_ack_tlv_fill(struct sk_buff *in_skb, struct sk_buff *skb,
-		     struct nlmsghdr *nlh, int err,
+		     const struct nlmsghdr *nlh, int err,
 		     const struct netlink_ext_ack *extack)
 {
 	if (extack->_msg)
@@ -2214,7 +2214,7 @@ netlink_ack_tlv_fill(struct sk_buff *in_skb, struct sk_buff *skb,
 	    !WARN_ON((u8 *)extack->bad_attr < in_skb->data ||
 		     (u8 *)extack->bad_attr >= in_skb->data + in_skb->len))
 		WARN_ON(nla_put_u32(skb, NLMSGERR_ATTR_OFFS,
-				    (u8 *)extack->bad_attr - (u8 *)nlh));
+				    (u8 *)extack->bad_attr - (const u8 *)nlh));
 	if (extack->policy)
 		netlink_policy_dump_write_attr(skb, extack->policy,
 					       NLMSGERR_ATTR_POLICY);
@@ -2225,7 +2225,7 @@ netlink_ack_tlv_fill(struct sk_buff *in_skb, struct sk_buff *skb,
 	    !WARN_ON((u8 *)extack->miss_nest < in_skb->data ||
 		     (u8 *)extack->miss_nest > in_skb->data + in_skb->len))
 		WARN_ON(nla_put_u32(skb, NLMSGERR_ATTR_MISS_NEST,
-				    (u8 *)extack->miss_nest - (u8 *)nlh));
+				    (u8 *)extack->miss_nest - (const u8 *)nlh));
 }
 
 /*
@@ -2238,6 +2238,7 @@ static int netlink_dump_done(struct netlink_sock *nlk, struct sk_buff *skb,
 			     struct netlink_ext_ack *extack)
 {
 	struct nlmsghdr *nlh;
+	size_t extack_len;
 
 	nlh = nlmsg_put_answer(skb, cb, NLMSG_DONE, sizeof(nlk->dump_done_errno),
 			       NLM_F_MULTI | cb->answer_flags);
@@ -2247,10 +2248,14 @@ static int netlink_dump_done(struct netlink_sock *nlk, struct sk_buff *skb,
 	nl_dump_check_consistent(cb, nlh);
 	memcpy(nlmsg_data(nlh), &nlk->dump_done_errno, sizeof(nlk->dump_done_errno));
 
-	if (extack->_msg && test_bit(NETLINK_F_EXT_ACK, &nlk->flags)) {
+	extack_len = netlink_ack_tlv_len(nlk, nlk->dump_done_errno, extack);
+	if (extack_len) {
 		nlh->nlmsg_flags |= NLM_F_ACK_TLVS;
-		if (!nla_put_string(skb, NLMSGERR_ATTR_MSG, extack->_msg))
+		if (skb_tailroom(skb) >= extack_len) {
+			netlink_ack_tlv_fill(cb->skb, skb, cb->nlh,
+					     nlk->dump_done_errno, extack);
 			nlmsg_end(skb, nlh);
+		}
 	}
 
 	return 0;
-- 
2.44.0


