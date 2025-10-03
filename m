Return-Path: <linux-kselftest+bounces-42748-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BA758BB869A
	for <lists+linux-kselftest@lfdr.de>; Sat, 04 Oct 2025 01:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 740914EF2B0
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Oct 2025 23:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBA42DAFC4;
	Fri,  3 Oct 2025 23:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVM/uCJW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842E92DA76B;
	Fri,  3 Oct 2025 23:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759534262; cv=none; b=rFWJIgS02+6K74PKIZFCfJuuAyc9tI0qh2fcr849fYqbz9VJoi3FzdnTdOMHqgZAZLWp0dCw4J2f/17E5T4k7l3pIyg9JsrnVs1MKthWKrnM+/qUsr1OI7nQqqs8AFb4OhnZu68wiXzhOcummfjmZ/s476B9YjrZ9MnNw9Jp/wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759534262; c=relaxed/simple;
	bh=R3DxuhiNyRX35tTE8Un4WwsTvyP61F4k/1SfRqyYt8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sjltjhS6wH09aUxmKLNPG8M97Q/Uv+GaaOiR/yMDNZuqkNbWRZDj1KHyTRmY6HMNct+7bfo7yJo7bniqRvTROYx+/ZCzH5iB+4U/CKXJr2OdcySJZCWOQEeifQ+ZR8zA9J2KxdnnUYODRiOJhA3oL8NJRV/G9AKXWMeUmtjGsPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVM/uCJW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B8AC4CEFF;
	Fri,  3 Oct 2025 23:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759534262;
	bh=R3DxuhiNyRX35tTE8Un4WwsTvyP61F4k/1SfRqyYt8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CVM/uCJWX3UG+7tmpE69Z7FHMEvaiVguaerjC4qZoXwaA6BYYREHN7y3zzjbiA6oj
	 XlKIvjfYsP//7vtuP0UjwJ8YpBb888SqB/6F7uGh3ol5KFv9ZxnESq3U2XAfpbl/4J
	 NQ1Q9AZ8RnNk8nLwFB4F0/8+mQUGS2ysREGRkEc2q+bgfqVwaqRoXp5EMef+r4F0Xb
	 VQjW6y6GP+zigQHVxoJoyfL/qIIQEtWoFKQqMFSYjviVHRD9HteNWcZzEd2SbfVzHL
	 nn8NS36bRfhNhLN+Do5TKNCXI4M/hClPW8pFBasLSmEbKoNryCK5XFeFzITWKaWQHX
	 a9oricwgTsA+w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	bpf@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	joe@dama.to,
	willemb@google.com,
	sdf@fomichev.me,
	almasrymina@google.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net 9/9] selftests: drv-net: pp_alloc_fail: add necessary optoins to config
Date: Fri,  3 Oct 2025 16:30:25 -0700
Message-ID: <20251003233025.1157158-10-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003233025.1157158-1-kuba@kernel.org>
References: <20251003233025.1157158-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add kernel config for error injection as needed by pp_alloc_fail.py

Fixes: 9da271f825e4 ("selftests: drv-net-hw: add test for memory allocation failures with page pool")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: joe@dama.to
CC: willemb@google.com
CC: sdf@fomichev.me
CC: almasrymina@google.com
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/drivers/net/hw/config | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/hw/config b/tools/testing/selftests/drivers/net/hw/config
index e8a06aa1471c..2307aa001be1 100644
--- a/tools/testing/selftests/drivers/net/hw/config
+++ b/tools/testing/selftests/drivers/net/hw/config
@@ -1,3 +1,7 @@
+CONFIG_FAIL_FUNCTION=y
+CONFIG_FAULT_INJECTION=y
+CONFIG_FAULT_INJECTION_DEBUG_FS=y
+CONFIG_FUNCTION_ERROR_INJECTION=y
 CONFIG_IO_URING=y
 CONFIG_IPV6=y
 CONFIG_IPV6_GRE=y
-- 
2.51.0


