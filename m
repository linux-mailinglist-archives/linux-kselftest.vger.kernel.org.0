Return-Path: <linux-kselftest+bounces-21464-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1A19BD477
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 19:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B57E61F214BA
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 18:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3B11E765A;
	Tue,  5 Nov 2024 18:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c/rFifFY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6C213D52E
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Nov 2024 18:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730831045; cv=none; b=nWXSABuJaZ5mKpgIDCob4SnCtKkkv0AZT/9jZEiiSsC9TpDDnLL3hZMBSw0MzraQcOBUK+8PBy8Ns4QRNxQNAaEWL09bU+Kwif1gS9zeenN0gNZi35EsX2yRCEYJLl3q4i9N8whOyCyFT4oQR3dSUi0PNXwLLGk9V4oTMbWxeFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730831045; c=relaxed/simple;
	bh=ynLH6n5Pr4ZxOzwF0y8pcyk94Ps7SUdfGFPrT6aubWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SI709gAx2eM+irqfZokZoPUqAsgHxg0toIXcKuFH0EzFOAGW9VkQ8hg3M5TKZ2OAAuMsWjug8JKLpMdFlrLd03j8sQltFlIY0aGfG3qCp3jwz0qfpCnRUs7xJ4j6PPmfbztTI5ZpzS81DosJ7Kak0EVh/PUy70BtMHe1zp9K5VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c/rFifFY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730831042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cWzagkOpqON0DTEOaf3JF36NZicTs95TmDUMpi4MDn8=;
	b=c/rFifFYDW4eAxKoX1rycWJda0blm7PHGQ9rW8x1/FTcjC5l8eHSBpjCJwV8zqEA6irncW
	ySnQlrQxPq7t83dKSqAIzosyHqdyUMls0D3YhgDP75InRP2tPf5Z8EPoq1GYFk0QdPgtws
	EOqLOmNQeWLfyyUGHB05SNgHA7qxq3M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-7fI5p4pFNxO5DfYgoercEQ-1; Tue,
 05 Nov 2024 13:24:00 -0500
X-MC-Unique: 7fI5p4pFNxO5DfYgoercEQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D50919772E9;
	Tue,  5 Nov 2024 18:23:59 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.71])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6ACE019560AA;
	Tue,  5 Nov 2024 18:23:56 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 net-next 0/2] ipv6: fix hangup on device removal
Date: Tue,  5 Nov 2024 19:23:49 +0100
Message-ID: <cover.1730828007.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

This addresses the infamous unregister_netdevice splat in net selftests;
the actual fix is carried by the first patch, while the 2nd one
addresses a related problem in the relevant test that was patially
hiding the problem.

Targeting net-next as the issue is quite old and I feel a little lost
in the fib info/nh jungle.
---
v1 -> v2:
 - drop unintended whitespace change in patch 1/2

Paolo Abeni (2):
  ipv6: release nexthop on device removal
  selftests: net: really check for bg process completion

 net/ipv6/route.c                    | 6 +++---
 tools/testing/selftests/net/pmtu.sh | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.45.2


