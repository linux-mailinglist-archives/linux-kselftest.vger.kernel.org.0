Return-Path: <linux-kselftest+bounces-3946-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4993584602F
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 19:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F20671F215F2
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 18:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C481D8405F;
	Thu,  1 Feb 2024 18:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UmmCZq9B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D163984FC1
	for <linux-kselftest@vger.kernel.org>; Thu,  1 Feb 2024 18:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706812991; cv=none; b=il1KREOVyCqkZerDSOvlIjXvd86WghbJmbyktJ/GthPSDWy2XfMFEZLYQDpfbtMqv7M3y5eFmc5EJuqUfi8Ug1/MsdCq9eUhVt+JIBVR0ln2M9YRmlevPfAfLocJHoEJ9a/+luJFftXiwOjThEDLSsLrYguu2qsdGmmUjx1fcVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706812991; c=relaxed/simple;
	bh=A0kUvoGb0OtSQU56bsyHEBHsyPo2vwh+WWfhGMHWp5o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X9ALys9gQdIXaseljZXavvy9HybwISrGnOvZEy0JZpz6CQJx/1ouNUw+Yptkq0svs/XViHG4ba4YQ+W+lbgT9vQOFtFZZNLMxFMU7AmuZh45v/kPz3L8GXJh+k7fk436GGMgWTJ0z9UjrXfqc8DafV6WCPZZgCHDmRRyxfxFqOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UmmCZq9B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706812988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=x5skD/vsBetlhdKUNyht9SukofC1uOZqd1aNaBd09FE=;
	b=UmmCZq9B/j/u6Rm2Ss0zwpahz63i9+tDBy4cUXsQ8Bkdj6RCibZtuNtwnWUmwuwcljqddA
	mi55YrFUUYDlFbNt6vms8Pkofk62yZanQxo1pEh9Ash8ui7HrOlpzirwPfIHW0YMij12Id
	leKQN7ShqFeWHcklXbIi8VJo5nobVus=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-137-08sdnL9JNLSwPbpHTofyGw-1; Thu,
 01 Feb 2024 13:43:06 -0500
X-MC-Unique: 08sdnL9JNLSwPbpHTofyGw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 90B101C29EA1;
	Thu,  1 Feb 2024 18:43:05 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.214])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5F4CA111FA;
	Thu,  1 Feb 2024 18:43:03 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Florian Westphal <fw@strlen.de>,
	David Ahern <dsahern@gmail.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 net 0/4] selftests: net: more fixes
Date: Thu,  1 Feb 2024 19:42:37 +0100
Message-ID: <cover.1706812005.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Another small bunch of fixes, addressing issues outlined by the
netdev CI.

The first 2 patches are just rebased.

The following 2 are new fixes, for even more problems that surfaced
meanwhile.

Paolo Abeni (4):
  selftests: net: cut more slack for gro fwd tests.
  selftests: net: fix setup_ns usage in rtnetlink.sh
  selftests: net: fix tcp listener handling in pmtu.sh
  selftests: net: avoid just another constant wait

 tools/testing/selftests/net/pmtu.sh           | 23 ++++++++++++++-----
 tools/testing/selftests/net/rtnetlink.sh      |  6 ++---
 tools/testing/selftests/net/udpgro_fwd.sh     | 14 +++++++++--
 tools/testing/selftests/net/udpgso_bench_rx.c |  2 +-
 4 files changed, 32 insertions(+), 13 deletions(-)

-- 
2.43.0


