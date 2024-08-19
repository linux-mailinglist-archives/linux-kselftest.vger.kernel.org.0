Return-Path: <linux-kselftest+bounces-15702-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C959574B5
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 21:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50DF2B229F6
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 19:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE351DD3AE;
	Mon, 19 Aug 2024 19:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdZfJZrH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BC71DD3A5;
	Mon, 19 Aug 2024 19:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724096729; cv=none; b=nJWdKsK+EoXDUvtRwoIZcRZ7XF4Nd5IMWV6qNVh7llK2eMHBReHRcdsBiUrAFcNdFt0IxrPHsl4JGRk7UbAWiU5pzJTX3UiXR7tShlYH28dxDIwe9yZ8Tw+t7PY83yvgaHEU7tgAAMNkMKURptD/7VqurwCee52cgMdU9c2qUxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724096729; c=relaxed/simple;
	bh=V0XCDtlKCCwxfOzle3JmIKNgZUrz+8RJB7fWPgB6tHg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QaevPx7BkWz+lhT+enh8pRYbCS548VpbvaOJEMuuB/vXDUvKZOXvzINuK+VPCkvoJ1OfZ8mI4v1ZetHEG/Zvunh/9uyZisLBkQSzbzd9bFgSNRUum2t4vf11V3CKiL6LIb1OJDaEQ6ZEOzb019Irx/FCnzaMxn9OPRlHRPEQoA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PdZfJZrH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1AAAC4AF0E;
	Mon, 19 Aug 2024 19:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724096729;
	bh=V0XCDtlKCCwxfOzle3JmIKNgZUrz+8RJB7fWPgB6tHg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PdZfJZrHw1o1P/n4e1RZgri8ihu0PHaOAhdfaBU3nr75ilLHA5XwNimTk9pwvosCe
	 y+8FMPwyIzXFltKmYDAa3i5Dt72kl1ZdyNcfiq3nRXoDGL1qZPJnmdr1WGC+fAjjbL
	 G6siIx3crMjnPkSwh6I4Vhqs741h/UtVRkN2qWnU5Ngy0S8yFyZ7KxO9BmtpWM0rrO
	 X6P71QbpLN2CJ3GzHzF0cqDFO4r75yl/lDxUJ/4YrFMQQMbTTl0wqh2X7i3aKxY6cG
	 PbiZqjX6P/B1xZhUBT5spfM8BlXijWLhRaJ8MPVUEuHS5IE3+HfDvxKN0P0z0/LJW0
	 hDEMXR38GuZaQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 19 Aug 2024 21:45:19 +0200
Subject: [PATCH net 01/14] mptcp: pm: re-using ID of unused removed
 ADD_ADDR
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-net-mptcp-pm-reusing-id-v1-1-38035d40de5b@kernel.org>
References: <20240819-net-mptcp-pm-reusing-id-v1-0-38035d40de5b@kernel.org>
In-Reply-To: <20240819-net-mptcp-pm-reusing-id-v1-0-38035d40de5b@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1120; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=V0XCDtlKCCwxfOzle3JmIKNgZUrz+8RJB7fWPgB6tHg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmw6DSU6TDvIdePtPMOoc2sdDuk8wQ79rfFTVGI
 YUukJwBZLmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZsOg0gAKCRD2t4JPQmmg
 c/irD/4zKqr7S7Cvi+YcAnh4fnT0MawawQBJd+xByazwa8FSRu4z9UHlCwTUZok9XK86Tu8ml8g
 Ppk9vEvUCZESa4lP1d1gEpKMCH53WrI+iDkjtS47U+4OXox2I16U6gTcKczSEsuH2AyXyU3R9vX
 2i932yV+ZRIVOIIRFNk+KVOFDnQobqwstuvDyjbH3xNCZ8w7Dhqikp409yKLK2liZgSQbpBEFiW
 S7TLKi6/jTslC6gSywpfS7MRj8sLFaZUUdXRBJ65CoCiT9WKO24c1z+qpbNaDRojYpjk0rjDEYe
 jfoNzcZUEJkGM6uCjD0pig2H1sGkf0RYDmt/SmV/yFfp68rFV/x8E5fBl5JyDiWKxMd4upFZmm7
 oRi8NOjc4qwekqMLsNuJEGIg63x6MZQESSAvzRJo73z+DvWJG/tLyRjC51ukukyQh48yEm6UKT+
 b80hQuS9S6Fiaw1R26tdz2w0UDDPl+4cu/cinZOctfMcQbDYqv9cu0Z+MLO0R1LsSuAKHdM0sca
 LinvJo2+Fza6tj9WWKJMdnESQ5LfyGHSZnzG0+ZnpgJ6t0kzRzhl/Gfx/oVveIL0qxehobtpTwO
 ZE0p9Kj2Fal8PMpyvWKOLFjEytBKcDFAhARGmkxUw/brnovhoHjbZ53oBmVpkSQI0kQN+8Ua//n
 iePtWkn751S98oA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

If no subflow is attached to the 'signal' endpoint that is being
removed, the addr ID will not be marked as available again.

Mark the linked ID as available when removing the address entry from the
list to cover this case.

Fixes: b6c08380860b ("mptcp: remove addr and subflow in PM netlink")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 4cae2aa7be5c..26f0329e16bb 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1431,7 +1431,10 @@ static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
 	ret = remove_anno_list_by_saddr(msk, addr);
 	if (ret || force) {
 		spin_lock_bh(&msk->pm.lock);
-		msk->pm.add_addr_signaled -= ret;
+		if (ret) {
+			__set_bit(addr->id, msk->pm.id_avail_bitmap);
+			msk->pm.add_addr_signaled--;
+		}
 		mptcp_pm_remove_addr(msk, &list);
 		spin_unlock_bh(&msk->pm.lock);
 	}

-- 
2.45.2


