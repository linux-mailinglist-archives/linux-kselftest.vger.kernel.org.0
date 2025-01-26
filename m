Return-Path: <linux-kselftest+bounces-25201-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF57A1CB26
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Jan 2025 16:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B85F6165954
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Jan 2025 15:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C262B216E19;
	Sun, 26 Jan 2025 15:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YsSZEVgo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95048216E11;
	Sun, 26 Jan 2025 15:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903791; cv=none; b=BEAvoMs80IFt5yi7tGSEQGcVt4jcKy/UYKr1Bb+1d7RHE/8rJcMJUmT4oh4odX3NCwUX5u/KtDXGZFqCxfAxmHbV4PTaWAaPNTJAy9PwreAmB01m6gmr8cCVK9deCgMsPvJofK+l8KTU1rU5muIQPCPzRV71G35fGXTsS3mMsL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903791; c=relaxed/simple;
	bh=ziFWZv+l/3BL/VrP9RAmntpbE18Jp94WGFFTvvMVeuU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IMj9R47po1AAIVP07WBokpZbTDQwYfxRjjk1x483w5Cmo+VCpdt3X5YC886K11ITbcDAdBRZQUGiRz3FCXE4nQToOKwgvHetoEuMXDrYlr1D9Lnz0nYxc5yaVhMabyEacvuZE9gP5nCIoaWUrzuj1ScxzMfp1hIS4H6V1cCIAC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YsSZEVgo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB40C4CED3;
	Sun, 26 Jan 2025 15:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903791;
	bh=ziFWZv+l/3BL/VrP9RAmntpbE18Jp94WGFFTvvMVeuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YsSZEVgouD65E3Mezr+NU85tJSP/rjMT96pgJmO6gKxZ/tKxo3MRm6Agx0E2VMY6T
	 hnLYNKuxcomxYjZwMNDkfUo/73ZtuyXYPVmkp9zz5WEHeeCE/cGusRSo7fVLy+EPFZ
	 8JhHAYZiqFk50ZrUCgQv2h/ISLWF83V8y5F7KbOR5IwgHtVq6wGVDA08b+qIZgAc3b
	 pujHrjhBo90rgv702VWmDVBi/0u5tHkqhkdT+cPQjMgXP7HGnaF7XyiVxqi9KXFMEK
	 bF2VlW0QQTV1ijPS9smyF3DVemxfLU8mWlCYFGzmeJzi0NEK8LAal4w+E39/U1P+8E
	 MXMR5ETJ2soQg==
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
Subject: [PATCH AUTOSEL 6.12 28/29] selftests/net/ipsec: Fix Null pointer dereference in rtattr_pack()
Date: Sun, 26 Jan 2025 10:02:09 -0500
Message-Id: <20250126150210.955385-28-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150210.955385-1-sashal@kernel.org>
References: <20250126150210.955385-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.11
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


