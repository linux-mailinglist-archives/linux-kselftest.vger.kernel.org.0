Return-Path: <linux-kselftest+bounces-4826-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3723185728A
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 01:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FED2B24775
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 00:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99193EADD;
	Fri, 16 Feb 2024 00:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSnjsn+k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B600DF58;
	Fri, 16 Feb 2024 00:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708043188; cv=none; b=VzdPZbsYuFT0Spjk+uoUrhI55jjFCn/HYAHO1LyxpzEA7mhgnKCjzt4iGm7Qv3CNvfJuOYNfP2bbxbT5GsTXFDDjGGmtz2AjQLMZD3QUmbZ2+6GKM+BT7gNYAjbmwLLPyscfCuINvjJQvFK3EBdpIHyspiga+U+ZYhLEi0AnImY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708043188; c=relaxed/simple;
	bh=lXyymbj5JxAALmr55E/ta+tS01Gc7jBnpZ55sx8kYpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j8N4qsLjoXLzq3EfFdM8Ma0AP8/FZZyguoqVwaVH8bexzBaR2xS1p5izG/RlvvlabCuCVfHNWtV+eamDFuieVW6uZXBXhnXRy4Ow2wY3g9i51sL/pTYhhQLtKBsP0Ac6llk8JNJ+Q4GesT/UXYW6fzXs2Fsw85lUIiZZt/zrd9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSnjsn+k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE8E9C43390;
	Fri, 16 Feb 2024 00:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708043188;
	bh=lXyymbj5JxAALmr55E/ta+tS01Gc7jBnpZ55sx8kYpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dSnjsn+kZQyKfVfiDcc3RFujWxeuzn1Z+HPrWkyNvIj/sG41SAqP+Sg5Urd44I3em
	 az5CYUbcMUC/1Vy/GG/4GefPwXycIvxq5QFTkYhnm7nuT9xgSaCAlyZFx8nlhGqNPo
	 WvzWW+/b79Ef14QRIcgyotars+Y11kqrwL6xxXeWOCCx4KTRVe2ZKzGLzb+BHAc72l
	 btol6H/xn8n3ZJoIrV1EbzRKf/zjrja1rVG1LmvF4ES6gI+Ta3E6qb3pZDSs1a1cWs
	 VZ6O/xRJWaKR9El+rg1aDY2HnfgBRzpdJpJEcA7W4bWA7U/OOTyeY6cEEP1HQRZuyl
	 CCUVzXhbQ4BWw==
From: Jakub Kicinski <kuba@kernel.org>
To: shuah@kernel.org,
	keescook@chromium.org
Cc: linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	jakub@cloudflare.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 4/4] selftests: ip_local_port_range: use XFAIL instead of SKIP
Date: Thu, 15 Feb 2024 16:26:19 -0800
Message-ID: <20240216002619.1999225-5-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240216002619.1999225-1-kuba@kernel.org>
References: <20240216002619.1999225-1-kuba@kernel.org>
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
 tools/testing/selftests/net/ip_local_port_range.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/ip_local_port_range.c b/tools/testing/selftests/net/ip_local_port_range.c
index 6ebd58869a63..d4f789f524e5 100644
--- a/tools/testing/selftests/net/ip_local_port_range.c
+++ b/tools/testing/selftests/net/ip_local_port_range.c
@@ -366,7 +366,7 @@ TEST_F(ip_local_port_range, late_bind)
 	__u16 port;
 
 	if (variant->so_protocol == IPPROTO_SCTP)
-		SKIP(return, "SCTP doesn't support IP_BIND_ADDRESS_NO_PORT");
+		XFAIL(return, "SCTP doesn't support IP_BIND_ADDRESS_NO_PORT");
 
 	fd = socket(variant->so_domain, variant->so_type, 0);
 	ASSERT_GE(fd, 0) TH_LOG("socket failed");
-- 
2.43.0


