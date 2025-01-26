Return-Path: <linux-kselftest+bounces-25202-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9B5A1CB66
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Jan 2025 16:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 618CD1638F9
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Jan 2025 15:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E46B22256B;
	Sun, 26 Jan 2025 15:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/slfIvC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FB8222565;
	Sun, 26 Jan 2025 15:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903833; cv=none; b=i0odETiK7s958XXVN1yvU4SnH7oadYdca3PyqvlUdK2cOaTg6w4cJ92yo4UVVl3D/VMJp3Yf4dJpMXxVEFXPxUpqkA4kG4XYSVRsFXHikFOQCQsZtpLzUcr+oH50+nnHRJBPZEJdC/iMxyA8NGxOx9q5PBmHM+kZWKJAHNsgJPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903833; c=relaxed/simple;
	bh=ziFWZv+l/3BL/VrP9RAmntpbE18Jp94WGFFTvvMVeuU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EE7yCRBxuxS0u/UaDyb1YqVtxx8o1YpXRXXudV3hRZdL2SS1WUhtQ7v4M7i4+p0Ve4LwHOp9CEHFNWe2zdIGL5xbn1mhdOuAHDJ8Gsem+l4BTp3BjQr63rIwamMWci38vSVQRC9zL2rcsCENc5a9Cr6l2c4wBY3my40NHM1xJws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/slfIvC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18F9C4CEE2;
	Sun, 26 Jan 2025 15:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903833;
	bh=ziFWZv+l/3BL/VrP9RAmntpbE18Jp94WGFFTvvMVeuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P/slfIvColtx4CADSsxuBm8dnAyYzYTbQFYSgQg3hM3DG4Dk4w+srBFjy1eUykQB5
	 vq6XCzKbv337ReFmSqin9++HX/st2Giwnc0rGC9C61yG6RIq6tvGdQhhLiJZRR6s07
	 stdGe+VOUJN2ohboPEzEZd8UCXin1n8dONWRCPtG8VZcaE1TZj9LqrE32XsOzGzF7I
	 dqKp/tDdVet9AX5MCbwqmzzkwKViwL/0ADXLkFRTf2OYMPy8FVRul0VH1O28igGuq6
	 lMGmXkSM9rK8T+YxlqBweLy4dZmviwS1ODt0vLGwxgmbFTcjcsLAvxdRJFCGIjZNYZ
	 hDLncLyYTo6yg==
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
Subject: [PATCH AUTOSEL 6.6 19/19] selftests/net/ipsec: Fix Null pointer dereference in rtattr_pack()
Date: Sun, 26 Jan 2025 10:03:14 -0500
Message-Id: <20250126150315.956795-19-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150315.956795-1-sashal@kernel.org>
References: <20250126150315.956795-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.74
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


