Return-Path: <linux-kselftest+bounces-49319-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 252C7D39DF1
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 06:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 072EF302E72C
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 05:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981E5330B34;
	Mon, 19 Jan 2026 05:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ACnnbNu3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F76330662
	for <linux-kselftest@vger.kernel.org>; Mon, 19 Jan 2026 05:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768801230; cv=none; b=jHzT3vHmeiyN5i/JdsWXs7QmBdgBoMy5SwJXxh/rLPRKzOJ/dZotDJ6kS4l0PcUF2wW1ZB8D1SPZyW8VR4DqYvfryk3kVYyDydIPqKpy3IPdfP9oZSwdSKUghKoLxWCSfmmhizzD3PtvnSiSKazuFCHcg+T8Sn5Cz27UupJlB18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768801230; c=relaxed/simple;
	bh=aRvg8HyupMYex2IjKzWsNfztKOVOTe1IMEJugwlYiV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T0pls0B85UQU4mbRTSO2Oem4KOfGv+YJ2nZxZlyJY3wAjMgSrwcNzATmpTyhUdQuKdBhoAKDGTD8bUr81ipFUWWWdEZPrnOwfWNaeUgUCOy+E5iSyVkgWSTmPmLLFMVjSBOtVQtXUi6sPTF1JsdTJ1bPdlVC+Oy8WveFLIrQBVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ACnnbNu3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768801223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IKIXSr04xyb/QtlUWt+UuDlH066b+vLPYHELmTRJF9E=;
	b=ACnnbNu3gC6eBsvdxjBGcZ/n6zvzjkb1bVeak/8r88ci0jrSLpuQqBSzYsyanWtpxfZVLE
	DxeBgzMrl2CD5z3gJXSmzxn4gmmiDCzlyLWRNXuqOc3MqiObKXG2jTDK2GLtZEfMbjIrgu
	1DycZssoYZr7rao446PVLL5Ih0OOLUE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-UFZJK24jMamOT6RmrQDp2g-1; Mon,
 19 Jan 2026 00:40:20 -0500
X-MC-Unique: UFZJK24jMamOT6RmrQDp2g-1
X-Mimecast-MFC-AGG-ID: UFZJK24jMamOT6RmrQDp2g_1768801218
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7AF591956050;
	Mon, 19 Jan 2026 05:40:18 +0000 (UTC)
Received: from xudu-thinkpadx1carbongen9.nay.csb (unknown [10.72.116.28])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9CC6F1800285;
	Mon, 19 Jan 2026 05:40:10 +0000 (UTC)
From: Xu Du <xudu@redhat.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 0/7] selftest: Extend tun/virtio coverage for GSO over UDP tunnel
Date: Mon, 19 Jan 2026 13:39:57 +0800
Message-ID: <cover.1768800198.git.xudu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The design strategy is to extend the existing tun testing infrastructure
to support this new use-case, rather than introducing a new or parallel framework.
This allows for better integration and re-use of existing test logic.

---
v4 -> v5:
 - Refactor the rtnetlink utilities to use YNL.
 - Use Geneve tunnel instead of VXLAN tunnel.
 - Revert tap refactor as YNL lacks macvtap support.

v4: https://lore.kernel.org/netdev/cover.1767597114.git.xudu@redhat.com/
 - Rebase onto the latest net-next tree to resolve merge conflicts.

v3: https://lore.kernel.org/netdev/cover.1767580224.git.xudu@redhat.com/
 - Re-send the patch series becasue Patchwork don't update them.

v2: https://lore.kernel.org/netdev/cover.1767074545.git.xudu@redhat.com/
 - Addresse sporadic failures due to too early send.
 - Refactor environment address assign helper function.
 - Fix incorrect argument passing in build packet functions.

v1: https://lore.kernel.org/netdev/cover.1763345426.git.xudu@redhat.com/

Xu Du (7):
  selftest: tun: Format tun.c existing code
  selftest: tun: Introduce tuntap_helpers.h header for TUN/TAP testing
  selftest: tun: Refactor tun_delete to use tuntap_helpers
  selftest: tun: Add helpers for GSO over UDP tunnel
  selftest: tun: Add test for sending gso packet into tun
  selftest: tun: Add test for receiving gso packet from tun
  selftest: tun: Add test data for success and failure paths

 tools/testing/selftests/net/Makefile         |   7 +-
 tools/testing/selftests/net/tun.c            | 898 ++++++++++++++++++-
 tools/testing/selftests/net/tuntap_helpers.h | 391 ++++++++
 3 files changed, 1257 insertions(+), 39 deletions(-)
 create mode 100644 tools/testing/selftests/net/tuntap_helpers.h


base-commit: c65182ef9df6bb96fd85b56a2bcdd18d64c4d3b5
-- 
2.49.0


