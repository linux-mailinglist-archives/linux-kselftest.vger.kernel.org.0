Return-Path: <linux-kselftest+bounces-15711-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F8A9574DA
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 21:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96A741C23178
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 19:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7751E7A40;
	Mon, 19 Aug 2024 19:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0ciMDys"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4801E7A38;
	Mon, 19 Aug 2024 19:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724096758; cv=none; b=mL+wPOMytjZEGLjeEmQl4H22TRbpybeTrx73TOmYBwaXE2KbhJ7gxMrkHKHHIvOYe0cScdRd1982nEphIAicJYtYcnyjcH80VBXVcqltWizUrGM1hEWklljljNizi2jbxoCYxQnwoLGeVvWhKIauBmzrn1iACS9NXjxDRWri7F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724096758; c=relaxed/simple;
	bh=yEteMQbd0AFftgasQN6K+OTvQe0Z4B72FbeaZORBvFs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qcB7n5Qmn0+CifMr7Y/yzPgndx38ViDKHrvGJT3FFzx0fLqyAglBDXRY9KNddemi3boQhSSsldzrpM27ZObCUIjfi8HfWplDyvSZoP05I1lES1FU+VXv6PsfRWIlBsNef3BERs6ylz9QmEXMaOQ7WJI6sMCkPw1N9BNJ8lKSV6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0ciMDys; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F646C32782;
	Mon, 19 Aug 2024 19:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724096757;
	bh=yEteMQbd0AFftgasQN6K+OTvQe0Z4B72FbeaZORBvFs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=J0ciMDysvbQR+a9+M0I3wM6Ispdo+Q0v63FrVK8oMaq4/TdXD9kNVgLaATlpdeaBZ
	 Z6aA/T4MTS+jPTPEECmNQqfuZtNh25IXWBWKOvS12vypoO80wJkuFfa7sggS8jOJEe
	 /MdYpPVpHNOU7qviOUk6mpyogZZnJNL9Ic1uKPs4wH94sUjJ/I1YFHb95jX473FHFX
	 5BT0rj5HCItzGbipQKmXicg9/qFbsk9+NDqGrmAVnMoxNYKj1sJk0M2wXB4n7ghD83
	 1BX9kuqWelXyl3+bTAmSWFSf9Y5oUp5u52MYCKfWbe73S149qSJX2EX/zcs+F1wjYY
	 tz7WEKt1nVpAg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 19 Aug 2024 21:45:28 +0200
Subject: [PATCH net 10/14] mptcp: pm: check add_addr_accept_max before
 accepting new ADD_ADDR
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-net-mptcp-pm-reusing-id-v1-10-38035d40de5b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1005; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=yEteMQbd0AFftgasQN6K+OTvQe0Z4B72FbeaZORBvFs=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmw6DT3vD+a7kz9eBUW+PvukII7bPCcvqXbqucv
 aiQofBA7UOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZsOg0wAKCRD2t4JPQmmg
 c8D2D/0RJTdJj4k3esNFhAJ5q1nUr1TXXiUfTkUHg7oeCS7ThtU9UYH6plGDRR2xUjm8TY75P6A
 OdlTeov0s/8/ZUgzpSNBJlk57OOQZHdlSbX1Ct8X/UrRi4krkAX+0EVdmkRpkUx2JKfJs35waaO
 97vQCkFxE7cN6QKWp3whhtw7JI8xxhcomUf05E66XhD8JsurexqAHNPF72Q+dQKbc6y9H86yw3m
 LME9LUlDQyW1xFjGm9dvyJ/rC7Hb5Qlzqxv/EU3nqxWMq401US3qxPyAldHOE7oNXuKLfjcnMyu
 JESokLsM56arDGiS+mDr3GweCqbXy5nnmCQwLpsXtRbkFCB7fivgQYcywu9hJy1EYRjgu5n/+0i
 5ABrvr2/epMUIg1Rk0MmDepeDcFScitphdfYJ4y1MLPE6wQf4uimTj3SDz353AZM6F1XEI/QCJd
 nUmK4BwaK+Bz/YHdgH3rRt1tq9+a5JnkvmeOEqBVYKKOBZmlySEWh6fdnOQkKcxaoaDjYy/ssGw
 D7ssZOPI39kxyjly1WeZ8GBdrFe9Q867JmEszn6LesaQBEQkK9ofAKZdLf6x80+iPHp8qLKnESJ
 mqaOwA4O7a3zSa/ytZfgy3OPPdRS/EbSBsK1hC25ZXNGK/3mkYZsT5NCThtKxY4RZM5U9CpCTMI
 IXkEAPTeMSGXrlA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The limits might have changed in between, it is best to check them
before accepting new ADD_ADDR.

Fixes: d0876b2284cf ("mptcp: add the incoming RM_ADDR support")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 882781571c7b..28a9a3726146 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -848,8 +848,8 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 			/* Note: if the subflow has been closed before, this
 			 * add_addr_accepted counter will not be decremented.
 			 */
-			msk->pm.add_addr_accepted--;
-			WRITE_ONCE(msk->pm.accept_addr, true);
+			if (--msk->pm.add_addr_accepted < mptcp_pm_get_add_addr_accept_max(msk))
+				WRITE_ONCE(msk->pm.accept_addr, true);
 		}
 	}
 }

-- 
2.45.2


