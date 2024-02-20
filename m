Return-Path: <linux-kselftest+bounces-5070-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC90085C4B8
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 20:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71B21B25ACB
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 19:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5575B14F9ED;
	Tue, 20 Feb 2024 19:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uKEf/j0a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A14514F9E4;
	Tue, 20 Feb 2024 19:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708456973; cv=none; b=owV77To9qknZN9WDySc+QmVrVteKS5Eph0u4LzbFPJYxnWAeRQwG6d+zoH1aI/QU4Xy2Q+RGiDKYofj4uCkMpppb2XpHILgQTSEOUXIZW3JCKDj+4lTvW7k2f6EEmNGfIdbC3yvZEUJ3UOZ8mQBctiugK5PtVOXC85LFV4/cQoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708456973; c=relaxed/simple;
	bh=lOTPndp0IMsasoyW4JuCFzuHcrAfQnrv/Lkla2nksNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DNF7Tna3zyE4/whvt9YlTUaB9xFtFZnqWrxFTypMPgSem4IZlTIe/z0pGTAf5d7o/7WQvPEa6tiY7XuJltGn7aOu1hK3qqv7FCFsduXeOamfXErqlO8uzm1RscII1tinzPossiUb6WyIQSv7F5stVcuMf0nYrJypSxCzPijTp94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uKEf/j0a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BBFFC43143;
	Tue, 20 Feb 2024 19:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708456972;
	bh=lOTPndp0IMsasoyW4JuCFzuHcrAfQnrv/Lkla2nksNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uKEf/j0aeJoxPfj9bSOxbHe+O+B02D2jn5fLRP7aUssAYd6ZijPIeBYKU0rJ8/iQ7
	 +O6v1QcgmigQpGUEldp0Ss1vELEGERn+Lq8HIJTyUu76HNqDPCA76uB9/NUdbMIenr
	 /6YnMqq2lV8xaaeqECAkwdVAP4nxjrtnXv9GkDxLAa8QRvJmi6FIggf8xZQGAUXjfZ
	 zY6IVY2b0EBMOQLoFg7ZcX/w7ZCSgJXSL5+YmAU54A0d2iUWjaRtjNbgdoZw39A+eu
	 sBnjHkxGoz0awabFldSnuxVmsdXnBQlxJB63jerpj+N6PBa1xWnfavGxutY2AzhmFZ
	 zOsltWyUVXE9g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	mic@digikod.net,
	linux-security-module@vger.kernel.org,
	keescook@chromium.org,
	jakub@cloudflare.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 11/11] selftests: ip_local_port_range: use XFAIL instead of SKIP
Date: Tue, 20 Feb 2024 11:22:35 -0800
Message-ID: <20240220192235.2953484-12-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220192235.2953484-1-kuba@kernel.org>
References: <20240220192235.2953484-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SCTP does not support IP_LOCAL_PORT_RANGE and we know it,
so use XFAIL instead of SKIP.

Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/ip_local_port_range.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/ip_local_port_range.c b/tools/testing/selftests/net/ip_local_port_range.c
index 6ebd58869a63..193b82745fd8 100644
--- a/tools/testing/selftests/net/ip_local_port_range.c
+++ b/tools/testing/selftests/net/ip_local_port_range.c
@@ -365,9 +365,6 @@ TEST_F(ip_local_port_range, late_bind)
 	__u32 range;
 	__u16 port;
 
-	if (variant->so_protocol == IPPROTO_SCTP)
-		SKIP(return, "SCTP doesn't support IP_BIND_ADDRESS_NO_PORT");
-
 	fd = socket(variant->so_domain, variant->so_type, 0);
 	ASSERT_GE(fd, 0) TH_LOG("socket failed");
 
@@ -414,6 +411,9 @@ TEST_F(ip_local_port_range, late_bind)
 	ASSERT_TRUE(!err) TH_LOG("close failed");
 }
 
+XFAIL_ADD(ip_local_port_range, ip4_stcp, late_bind);
+XFAIL_ADD(ip_local_port_range, ip6_stcp, late_bind);
+
 TEST_F(ip_local_port_range, get_port_range)
 {
 	__u16 lo, hi;
-- 
2.43.0


