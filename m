Return-Path: <linux-kselftest+bounces-39868-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D317B349AF
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 20:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67EC61B22C47
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 18:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50313090DE;
	Mon, 25 Aug 2025 18:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ojo8UC9t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCDC307AFB;
	Mon, 25 Aug 2025 18:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756145096; cv=none; b=KFaqTDTq1udhC5OBDAo7iDB3QWs10ixsumdfM+soCv7MztBezbEY2wX0Nm97u3LsK7dlKZB/JC0+QqNFoZ3c8lMUXdYMMX1C6hpxt5esy5PuMMPO2nWwsyKBcp2WRzpvpxXjQQUDN+TTAcKIOpkkL0miOzcjWBTa8xJH7/F+4Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756145096; c=relaxed/simple;
	bh=7hdRmnsvdkOBsOCx7E35ibIL2L+x1Gfqx+yXlc6W4fM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XNc8B6PVC9qkte4657/zrKchqY6x+1ayvI9miu8ndRqRKyPOPDeGh9h6UCb+pnD+60jl/7Zw+6Se35wze/N9RY+PuKPH1TZ27V+VjtYiiGFQNrYv7takDskHpImXyXxKI04XToVeX0UJUUk7d10R/+Y5KKFxZNb+mhZp8El8qgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ojo8UC9t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFFE0C4CEED;
	Mon, 25 Aug 2025 18:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756145096;
	bh=7hdRmnsvdkOBsOCx7E35ibIL2L+x1Gfqx+yXlc6W4fM=;
	h=From:To:Cc:Subject:Date:From;
	b=Ojo8UC9tH4gTgN3kmzWcOIXYnLqwXBgs0rlDEnekqGomInM0Nv7WQfI4hOxodu6tv
	 0tj6okwYmFhuKzU128JDU4qHuvs4r3l2e3hIchA1DwWns1o0J2yZoZCBRWCKjHGkHO
	 Hdbvhf1ec0FMht/e7U7MtHGEghJ2mpkhjjPSowUh1jm7pfPkYbcafcy2k3DZnISqXj
	 GcNdvPp/4Xys5hoXAc55wBn2zA+Xl2iJ1k+XrxZwJA1A7f+ANC08N8ZvnnqbyrvwQh
	 EgHKfE7K02uZ2Ox2esFRLelX5JyM5lpCfncYhcYDZ0+KkUCHg1AnjYb3RTcCuWyDrA
	 C/u4mtibP5YdQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	almasrymina@google.com,
	sdf@fomichev.me,
	joe@dama.to,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 0/5] selftests: drv-net: ncdevmem: fix error paths
Date: Mon, 25 Aug 2025 11:04:42 -0700
Message-ID: <20250825180447.2252977-1-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make ncdevmem clean up after itself. While at it make sure it sets
HDS threshold to 0 automatically.

v2: rework patch 4 into separate patches 4 and 5
v1: https://lore.kernel.org/20250822200052.1675613-1-kuba@kernel.org

Jakub Kicinski (5):
  selftests: drv-net: ncdevmem: remove use of error()
  selftests: drv-net: ncdevmem: save IDs of flow rules we added
  selftests: drv-net: ncdevmem: restore old channel config
  selftests: drv-net: ncdevmem: restore original HDS setting before
    exiting
  selftests: drv-net: ncdevmem: explicitly set HDS threshold to 0

 .../selftests/drivers/net/hw/ncdevmem.c       | 796 +++++++++++++-----
 1 file changed, 588 insertions(+), 208 deletions(-)

-- 
2.51.0


