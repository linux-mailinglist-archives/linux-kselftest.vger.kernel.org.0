Return-Path: <linux-kselftest+bounces-25200-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F676A1CAB8
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Jan 2025 16:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D060418845E4
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Jan 2025 15:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8D1207A0B;
	Sun, 26 Jan 2025 15:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZHxOQGm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECC7207670;
	Sun, 26 Jan 2025 15:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903727; cv=none; b=RMyAdAEjZu3YkmSNPTY8/dLyYQ4xhz3THAVj4AI5A923UMlAhH8QqubYLfKNq0s7xChhJxrCD/wXWHf+lm1sf46w4o3SMvUIlPJ53LJWp4YfFU+RPP2uLDytZkc65cLHQgj0o43y1YOxpMvbx929HuM3Bq9m9ZjI4ZlApqm8CFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903727; c=relaxed/simple;
	bh=ziFWZv+l/3BL/VrP9RAmntpbE18Jp94WGFFTvvMVeuU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ul6HbzSIuJgniP6ovshFJr6hC756/gxi1d4YYlkMEduvUWY9Jt9MeywmzaxNDOSkK5CL76lOF4B2WL48PckWcz3IOXXLXRi7vyOX7IuHxUPsqV/UlD7qXx+DZi3b03T4oFD2STNNimymVJT1+6hq4AEXrzuolQBzVI0N/tOMRMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZHxOQGm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B7BFC4CED3;
	Sun, 26 Jan 2025 15:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903726;
	bh=ziFWZv+l/3BL/VrP9RAmntpbE18Jp94WGFFTvvMVeuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AZHxOQGmvHs9QSfP2+3kiSvGycOZdJ5YUOieSVoiIAIwSjGQH1CjuyEFeCvhsJHr3
	 NiMFcrHQ/fHG7U+Qp2TMfJw8TyjjCby7OhfpdQLDYSP4cEzgJ5rZVMyN20ZqK5cAUN
	 3nsoqp+cfenFsweplhbLNQ4zqWI0Q0Va9mQfgbFRFEe3wtPjAb+CLz90lYGeg8KDzv
	 fN1bdWT4thzSqkuUNauCd6wyeRqpzwXOiHhtm6mhBm2HjQJGuhtBm4XSjeauav/LEI
	 J5Se3cXcdknYVqVu8Zcz/HZE8F3I9Hl/zS8aKQQVkxQRdtFebB3JPsz8AlomdYUtxo
	 VbNj6ThDuynCQ==
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
Subject: [PATCH AUTOSEL 6.13 34/35] selftests/net/ipsec: Fix Null pointer dereference in rtattr_pack()
Date: Sun, 26 Jan 2025 10:00:28 -0500
Message-Id: <20250126150029.953021-34-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150029.953021-1-sashal@kernel.org>
References: <20250126150029.953021-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
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
index be4a30a0d02ae..9b44a091802cb 100644
--- a/tools/testing/selftests/net/ipsec.c
+++ b/tools/testing/selftests/net/ipsec.c
@@ -227,7 +227,8 @@ static int rtattr_pack(struct nlmsghdr *nh, size_t req_sz,
 
 	attr->rta_len = RTA_LENGTH(size);
 	attr->rta_type = rta_type;
-	memcpy(RTA_DATA(attr), payload, size);
+	if (payload)
+		memcpy(RTA_DATA(attr), payload, size);
 
 	return 0;
 }
-- 
2.39.5


