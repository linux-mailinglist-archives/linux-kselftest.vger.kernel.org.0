Return-Path: <linux-kselftest+bounces-4562-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4338534FF
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 16:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCDD41C230D2
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 15:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C8F5F54F;
	Tue, 13 Feb 2024 15:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="doRIfSNo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1ED15F494;
	Tue, 13 Feb 2024 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707839061; cv=none; b=Z4PZQQnDDfyjVW0LGKt45pozGD+mZ5f9u0hqSmly22YmfBJ32h/dRMjSit6AmqfB1QWbffMUyMROXT5DW+5OEvtoYXL0UOe4JMtaSOHrxEI46vtjHvazW7WkDgwK1F1x9Jxdmru4FMH0Ojr0ExF/6+RY5cG/tp7BpgO+LcnazgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707839061; c=relaxed/simple;
	bh=xW5A2I/k9RP8EcmefPFdWvTRd4kQer+/1FTXxQHibCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lYVYn9jMKdKNv2GudyC8hcsZw3U9DzpWpzbVuBjTuYx+XT5ypbLgc9z4sQYbKBkOZbkGeTY/ebE6c38ijGNhfaa1NBPFgUCk+v0sNO246n85BpJv3uT4cjCF651eNDfeOQruU7CVeDxCH4Q30GYUmBo4D3PgjM1v1v0Gu0BPw/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=doRIfSNo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B60C41613;
	Tue, 13 Feb 2024 15:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707839060;
	bh=xW5A2I/k9RP8EcmefPFdWvTRd4kQer+/1FTXxQHibCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=doRIfSNoAPlXgJeaV9hMpFBAbZJXlFxu+iGQRV3f68fUtQ73DfVhL8NnKlL02ZsXB
	 3ohYzE/WPqsRgXOIVtCg64ZmQbzTPEWL9oDEji7OkJWzWmr50b66BeoyA4ytln560c
	 XVrEjXxhbPHK1jncPCa/AvSZ1MnJw7qlooW8gy0j/bvBe0jWpP+HdGfke10noS9QIh
	 jQX9yhrTtxq9eLk2iQF2SgtMV4TSoyloqEnIM5f6qGURrk8pK+tBEy6TdorzsLMLdd
	 IL3EQBO01s+IVzEQoIR/tGGRvJC/pqRQwHkp2MNT5DxkJTM3aTaPOyE6d/DffGcuM0
	 i/uKr+SIWMZ5Q==
From: Jakub Kicinski <kuba@kernel.org>
To: shuah@kernel.org,
	keescook@chromium.org
Cc: linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	jakub@cloudflare.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 4/4] selftests: ip_local_port_range: use XFAIL instead of SKIP
Date: Tue, 13 Feb 2024 07:44:16 -0800
Message-ID: <20240213154416.422739-5-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213154416.422739-1-kuba@kernel.org>
References: <20240213154416.422739-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SCTP does not support IP_LOCAL_PORT_RANGE and we know it,
so use XFAIL instead of SKIP.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/ip_local_port_range.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/ip_local_port_range.c b/tools/testing/selftests/net/ip_local_port_range.c
index 0f217a1cc837..c1d3f001c240 100644
--- a/tools/testing/selftests/net/ip_local_port_range.c
+++ b/tools/testing/selftests/net/ip_local_port_range.c
@@ -362,7 +362,7 @@ TEST_F(ip_local_port_range, late_bind)
 	__u16 port;
 
 	if (variant->so_protocol == IPPROTO_SCTP)
-		SKIP(return, "SCTP doesn't support IP_BIND_ADDRESS_NO_PORT");
+		XFAIL(return, "SCTP doesn't support IP_BIND_ADDRESS_NO_PORT");
 
 	fd = socket(variant->so_domain, variant->so_type, 0);
 	ASSERT_GE(fd, 0) TH_LOG("socket failed");
-- 
2.43.0


