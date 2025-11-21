Return-Path: <linux-kselftest+bounces-46175-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEB1C77363
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 05:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6731F35CBF9
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 04:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EFB2C0278;
	Fri, 21 Nov 2025 04:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6Gn752K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6D513C3F2;
	Fri, 21 Nov 2025 04:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763697790; cv=none; b=gyH8rPWeDZqGBaTKXl5L3weFPWRoXkGd3guO01aOQv21nvVFBeHLf91B34qKOCnG//mKhV2LadDIkCz+t/b2RP0n3CyEIWnF8BI/zVXstntzb05AfB4M9iU5x/N/YR7ooZNoYqGJcSmMFMbSE4hBds5TWBlCdM8TMDE2fLmLWj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763697790; c=relaxed/simple;
	bh=VZRThWGtv2yLg/j/bZQrVjKqW/6A+KxoAz3gO2cPFUI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uiFlCqISrse3OhWOIV55vmAckt6w6tpIXtK156fDFdWeyucjEeviNtM9HW6Jjf74nDaSXrvv/m0+8mc9HJMrPyoY4d2GxUXTW5IFpuLnfAycFD42FKqjslRcVvSl/dnYErzNQQdOdox9CZuho+p4qnY+RjwxOBgY/MshlnCAJ6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6Gn752K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45AA2C4CEF1;
	Fri, 21 Nov 2025 04:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763697788;
	bh=VZRThWGtv2yLg/j/bZQrVjKqW/6A+KxoAz3gO2cPFUI=;
	h=From:To:Cc:Subject:Date:From;
	b=d6Gn752Kk2hv7ethaMnLIC1sI2yLpwZIMTV02n1VoI7fKQIs6DE2H3L7X12k5KaBG
	 02Zte5Klfd5vnE86D+4djlLUNURp/dJjalVFRC3buPtN6RLlvX1Om1n4c90qNYg6pX
	 6uyHZasb9ZHqtqoRiWuDdqXUMgUVXWzj5JSv3WAthUE6b6RldHH0LEnmtbVB0Ucc7o
	 VvR2dnzddOCGXuyMfr1rCDVCN2D6kFWhR8bZyFMj0H4GFoOwewIlFCF72BqILpodyS
	 M6JOp2RpxZ3TbsediQlxuhf67+8/NjT8pq1rjzdJp8HTvpvnTmra2b4t43U9hmmj5F
	 q3O5rQVOlNF1A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemb@google.com,
	petrm@nvidia.com,
	dw@davidwei.uk,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/5] selftests: hw-net: toeplitz: read config from the NIC directly
Date: Thu, 20 Nov 2025 20:02:54 -0800
Message-ID: <20251121040259.3647749-1-kuba@kernel.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

First patch here tries to auto-disable building the iouring sample.
Our CI will still run the iouring test(s), of course, but it looks
like the liburing updates aren't very quick in distroes and having
to hack around it when developing unrelated tests is a bit annoying.

Remaining 4 patches iron out running the Toeplitz hash test against
real NICs. I tested mlx5, bnxt and fbnic, they all pass now.
I switched to using YNL directly in the C code, can't see a reason
to get the info in Python and pass it to C via argv. The old code
likely did this because it predates YNL.

Jakub Kicinski (5):
  selftests: hw-net: auto-disable building the iouring C code
  selftests: hw-net: toeplitz: make sure NICs have pure Toeplitz
    configured
  selftests: hw-net: toeplitz: read the RSS key directly from C
  selftests: hw-net: toeplitz: read indirection table from the device
  selftests: hw-net: toeplitz: give the test up to 4 seconds

 .../testing/selftests/drivers/net/hw/Makefile | 23 ++++++-
 .../selftests/drivers/net/hw/toeplitz.c       | 65 ++++++++++++++++++-
 .../selftests/drivers/net/hw/toeplitz.py      | 28 ++++----
 3 files changed, 98 insertions(+), 18 deletions(-)

-- 
2.51.1


