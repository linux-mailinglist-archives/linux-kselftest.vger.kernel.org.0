Return-Path: <linux-kselftest+bounces-19610-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4030299B8AE
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Oct 2024 09:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB40C1F217B3
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Oct 2024 07:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35A412FF9C;
	Sun, 13 Oct 2024 07:17:36 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97616EB5C;
	Sun, 13 Oct 2024 07:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728803856; cv=none; b=WPoxW4/wAVneNr+q/TyT5SIHKX0xjK5JUU5trMNzLsljp+wDByhn59obQsglXaeqnVb2OaVDCjFY/qpXx3kzPBC8LmH5k3yC636Ld8keQv724pU/xSUkzt/JhjkoU9pFSGoRDOFkb64aAJxkPIkuFJiL29DhStj6NM4cOabKmbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728803856; c=relaxed/simple;
	bh=kdrgm5+oTimuFn5EWwwAb1dZk7KNkTyIfP/Mz0ZoFPs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FpXJSh8/SrhsewhlrsbucH3MaaCmy7Yz3eZ9R3TanGht/1XdWeoa3hNHTLxPun9qWPIIZA9FO4AVUIUfOoiCIOea2lVC/yP6+Lqwt1Qz3pOHQQa/f6JHX82sqkpKXxTwb36Qgl9+XghDnJbnT8DQxIIV+0fPOUzU2bKoMkSWw78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XRBQh0llGz6L7B4;
	Sun, 13 Oct 2024 15:13:00 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 6ED8E1408F9;
	Sun, 13 Oct 2024 15:17:25 +0800 (CST)
Received: from china (10.200.201.82) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sun, 13 Oct
 2024 09:17:19 +0200
From: Gur Stavi <gur.stavi@huawei.com>
To: Gur Stavi <gur.stavi@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
	<shuah@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next v04 0/3] net: af_packet: allow joining a fanout when link is down
Date: Sun, 13 Oct 2024 10:15:24 +0300
Message-ID: <cover.1728802323.git.gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 frapeml500005.china.huawei.com (7.182.85.13)

PACKET socket can retain its fanout membership through link down and up
and leave a fanout while closed regardless of link state.
However, socket was forbidden from joining a fanout while it was not
RUNNING.

This scenario was identified while studying DPDK pmd_af_packet_drv.
Since sockets are only created during initialization, there is no reason
to fail the initialization if a single link is temporarily down.

This patch allows PACKET socket to join a fanout while not RUNNING.

Selftest psock_fanout is extended to test this "fanout while link down"
scenario.

Selftest psock_fanout is also extended to test fanout create/join by
socket that did not bind or specified a protocol, which carries an
implicit bind.

This is the only test that was performed.

Changes:

V04:
* Minimized code change.
* Removed test of ifindex. A socket that went through bind "unlisted" race can
  join a fanout.

V03: https://lore.kernel.org/netdev/cover.1728555449.git.gur.stavi@huawei.com
* psock_fanout: add test for joining fanout with unbound socket.
* Test that socket can receive packets before adding it to a fanout match.
  This is kind of replaces the RUNNING test that was removed.
* Initialize po->ifindex in packet_create. To -1 if no protocol is specified
  and add an explicit initialization to 0 if protocol is specified.
* Refactor relevant code in fanout_add within bind_lock, as a sequence of
  if {} else if {}, in order to reduce indentation of nested if statements and
  provide specific error codes.

V02: https://lore.kernel.org/netdev/cover.1728382839.git.gur.stavi@huawei.com
* psock_fanout: use explicit loopback up/down instead of toggle.
* psock_fanout: don't try to restore loopback state on failure.
* Rephrase commit message about "leaving a fanout".

V01: https://lore.kernel.org/netdev/cover.1728303615.git.gur.stavi@huawei.com/

Gur Stavi (3):
  af_packet: allow fanout_add when socket is not RUNNING
  selftests: net/psock_fanout: socket joins fanout when link is down
  selftests: net/psock_fanout: unbound socket fanout

 net/packet/af_packet.c                     |  9 +--
 tools/testing/selftests/net/psock_fanout.c | 78 +++++++++++++++++++++-
 2 files changed, 80 insertions(+), 7 deletions(-)


base-commit: c531f2269a53db5cf64b24baf785ccbcda52970f
-- 
2.45.2


