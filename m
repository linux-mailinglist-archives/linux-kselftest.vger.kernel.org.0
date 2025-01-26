Return-Path: <linux-kselftest+bounces-25205-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8CFA1CBE3
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Jan 2025 16:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BA781632B3
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Jan 2025 15:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F8122E41C;
	Sun, 26 Jan 2025 15:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjMH94uU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A0522E411;
	Sun, 26 Jan 2025 15:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903927; cv=none; b=MBKs3kI3SOgg0PWlA+quV2+bOEydDp8BBsYIyupDmldx1PujE//CaJKaPGcMz6EQ1Kub85auUaUKklIryoV3HVBYh914cF6k3+0DC/yEXHxYMoiC3Rid9RqztN1GutScO9B7KkUdNnnsmaGaJm88ZPlTXvAcyt6DtcDkgKPY1rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903927; c=relaxed/simple;
	bh=iTju3sSUX1rtNTtNeyYFYSwXJ3u2XVDJEYpwoJrijy0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qj3HEaQXiE4xIqgdfukb02mnlHFTP1Nk6vHuu4S+698re4DrnT+66Lld0Iqs7N6EG7Xehs2Gm+/sZPG77L+iZmnPkkkzLcgMpC9WovK2dYJPUi8yauFticLHACPUjZpDLQUFQWtofLl8OnvtjOZlNGuOG18ZrYbO88ql6XFzUUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjMH94uU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 933F8C4CED3;
	Sun, 26 Jan 2025 15:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903926;
	bh=iTju3sSUX1rtNTtNeyYFYSwXJ3u2XVDJEYpwoJrijy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AjMH94uUYFhfmbqRdlfFrAgk5BhfC1D8cnl3mBCp922zvanWerXjP75u+D77nXCky
	 HPwJAPDS5NXwIaolGgXh7y9E1kEA6VI7gXXPZ7yXt2ic0uhs7ecHwPTamlXDwbl96H
	 DfqOIe0ac+Mu+imnqTAPSYTcO9VYVACEgFNF0ymQxCdebMkkHxcPJxKKSvlAeWGR5o
	 MTMuWterb42yvz1T31ehGGPrdM04aBS2K2VN9BOWV5KTZ8jahvovai4c3KCaYBFtYQ
	 CFZy++iDhMFwwpr++eLd4SQAIbtXegJ+UY78Gj+1mr7r9t7GXT6TpCIOc6eL359N7N
	 XFKQjsnr/UVLA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Liu Ye <liuye@kylinos.cn>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	steffen.klassert@secunet.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 12/12] selftests/net/ipsec: Fix Null pointer dereference in rtattr_pack()
Date: Sun, 26 Jan 2025 10:05:00 -0500
Message-Id: <20250126150500.959521-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150500.959521-1-sashal@kernel.org>
References: <20250126150500.959521-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.233
Content-Transfer-Encoding: 8bit

From: Liu Ye <liuye@kylinos.cn>

[ Upstream commit 3a0b7fa095212b51ed63892540c4f249991a2d74 ]

Address Null pointer dereference / undefined behavior in rtattr_pack
(note that size is 0 in the bad case).

Flagged by cppcheck as:
    tools/testing/selftests/net/ipsec.c:230:25: warning: Possible null pointer
    dereference: payload [nullPointer]
    memcpy(RTA_DATA(attr), payload, size);
                           ^
    tools/testing/selftests/net/ipsec.c:1618:54: note: Calling function 'rtattr_pack',
    4th argument 'NULL' value is 0
    if (rtattr_pack(&req.nh, sizeof(req), XFRMA_IF_ID, NULL, 0)) {
                                                       ^
    tools/testing/selftests/net/ipsec.c:230:25: note: Null pointer dereference
    memcpy(RTA_DATA(attr), payload, size);
                           ^
Signed-off-by: Liu Ye <liuye@kylinos.cn>

Link: https://patch.msgid.link/20250116013037.29470-1-liuye@kylinos.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/ipsec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/ipsec.c b/tools/testing/selftests/net/ipsec.c
index 03b048b668315..38f0de299605a 100644
--- a/tools/testing/selftests/net/ipsec.c
+++ b/tools/testing/selftests/net/ipsec.c
@@ -189,7 +189,8 @@ static int rtattr_pack(struct nlmsghdr *nh, size_t req_sz,
 
 	attr->rta_len = RTA_LENGTH(size);
 	attr->rta_type = rta_type;
-	memcpy(RTA_DATA(attr), payload, size);
+	if (payload)
+		memcpy(RTA_DATA(attr), payload, size);
 
 	return 0;
 }
-- 
2.39.5


