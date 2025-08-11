Return-Path: <linux-kselftest+bounces-38726-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90101B21900
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 01:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F4DE461C31
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 23:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44738240611;
	Mon, 11 Aug 2025 23:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYIrVjIh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EED423D2A0;
	Mon, 11 Aug 2025 23:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754954027; cv=none; b=gp00L4Wh3o++q+fu5DpiR4Hf9FnxMo6QZ1scIZCidj929L3JG1QExyNOA3yjZiadMGhheMZOVU4C2fbQK5/P1IxutZ3SkNlGDYavMcVOil/3CaJ5tbgV1vPwgQx1OjHEH+c9iYZJVrAexvjnzkuTm+WLyaSrW2SCR3+PGG0UZm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754954027; c=relaxed/simple;
	bh=TrQhrAtyxZJnFeF9pM8dQZLENr7NZu5VAQ0OWcoOdoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hvEfjYbGlO/Br8Nko453+GsHF6EKIn6tb7KaHOkVqIbAV4mO6o4E117YvPbQsf3cHQJ7ZLYSq65gdV0hX6ufDdvl/QFC20bHiw1xECBlhgcCjUAweO5rY94h8IyRoUZQU5fEfYzX5vuW425rM4sj+9SCmw0M1W+vuzNJ7flHK9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MYIrVjIh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5931CC4CEF6;
	Mon, 11 Aug 2025 23:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754954026;
	bh=TrQhrAtyxZJnFeF9pM8dQZLENr7NZu5VAQ0OWcoOdoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MYIrVjIhtTpZOAgVIrInA34D9RhJZ+t31QhRxzArg7zb8vH2wi+hn78/giOcMkj1i
	 IDZHkY4ONrxwPOQHgk9gLHnz5n1ZA3pcIRWj4Sw9iOEHpECR2y3wisFk7ezjwluY8k
	 x/n0ou/tRgkjrygykZ2vmDrECUyHSdGYPTKbGnIf8g9OTZL681bQ4ga4kEy2n0TnFD
	 j78WnvbgkTpZeHTyi7CGPi+I1T0Ig+uliXjBUP4yKGrQ9vqJ7xOhUXvP656NqCVI1O
	 ZNkt/slHPW6jbUbNWQa44zlRP496odn1PqSjoM4B4X+etzStNx/U2G3xOy4zbv3PBB
	 RhcJjtJYlK7Bw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	sdf@fomichev.me,
	almasrymina@google.com,
	noren@nvidia.com,
	linux-kselftest@vger.kernel.org,
	ap420073@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/5] selftests: drv-net: add configs for zerocopy Rx
Date: Mon, 11 Aug 2025 16:13:30 -0700
Message-ID: <20250811231334.561137-2-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250811231334.561137-1-kuba@kernel.org>
References: <20250811231334.561137-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Looks like neither IO_URING nor UDMABUF are enabled even tho
iou-zcrx.py and devmem.py (respectively) need those.
IO_URING gets enabled by default but UDMABUF is missing.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/hw/config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/hw/config b/tools/testing/selftests/drivers/net/hw/config
index 88ae719e6f8f..e8a06aa1471c 100644
--- a/tools/testing/selftests/drivers/net/hw/config
+++ b/tools/testing/selftests/drivers/net/hw/config
@@ -1,5 +1,7 @@
+CONFIG_IO_URING=y
 CONFIG_IPV6=y
 CONFIG_IPV6_GRE=y
 CONFIG_NET_IPGRE=y
 CONFIG_NET_IPGRE_DEMUX=y
+CONFIG_UDMABUF=y
 CONFIG_VXLAN=y
-- 
2.50.1


