Return-Path: <linux-kselftest+bounces-48155-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D59C9CF1BE6
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 04:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B0DB3020C62
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 03:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9292320A1D;
	Mon,  5 Jan 2026 03:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="izYHn4iZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DFB31ED6C
	for <linux-kselftest@vger.kernel.org>; Mon,  5 Jan 2026 03:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767584700; cv=none; b=PWsiY2aNA0ZPRYv4kGZOTbQM/Sgl3+FZjnLDaIVSzYlsa5wsq/xrtgS4AvbseoZvMAiZZ9mUmEMQc6ZVH4WX+xU6fBMgaItcGzMKhx7Hm/ve0X9J/lQpjiQHlHpkGXpeGoKYkWFStXN5iX1Mv4lqBpDDgqYsdifllbZySPDMRZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767584700; c=relaxed/simple;
	bh=3f7WUVn73gc9SKewbhvcXuBFyXWc4GBP3OrT2ImPSzU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=csSaFgED5T+sRm6CBX2sr7dnJEG6eOhpvMI8kGDcHQsWklvzl97cKiiQ+M3jzx8OP9j42iQthLiWYEFoJI/tUGBIqoNmeE4v6azquyUmSF7vAxePx1KBWIpevmvf6tqFoXnB0u0K2ssRWg5FKzMrliMM0lPyVx4fC2qVze3328c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=izYHn4iZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767584698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xsJWLlyJIxAzBoXALzeg0UEorQME7drbhemnU8P8irM=;
	b=izYHn4iZ7Jkyks2pnZ2kxFvhubjmxQ2Ugl29L4jcbRJNXms4IUWAwCsI61oZl75zEnLISg
	8tG+KROuBCMU0vY3pJOIzeq4XLuAyT/f23VA6vY4nbGcmRKrRkLZSGLcpsG3L/+4mTIRdI
	/3YgWnq6vfTQ+G1db/H4uAeKM83TLKg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-InEKffccPc6RGclbtO5efg-1; Sun,
 04 Jan 2026 22:44:53 -0500
X-MC-Unique: InEKffccPc6RGclbtO5efg-1
X-Mimecast-MFC-AGG-ID: InEKffccPc6RGclbtO5efg_1767584691
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BC0F51800343;
	Mon,  5 Jan 2026 03:44:51 +0000 (UTC)
Received: from xudu-thinkpadx1carbongen9.nay.csb (unknown [10.66.60.72])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B2A4A180035A;
	Mon,  5 Jan 2026 03:44:47 +0000 (UTC)
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
Subject: [PATCH net-next v3 0/8] selftest: Extend tun/virtio coverage for GSO over UDP tunnel
Date: Mon,  5 Jan 2026 11:44:35 +0800
Message-ID: <cover.1767580224.git.xudu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The primary goal is to add test validation for GSO when operating over
UDP tunnels, a scenario which is not currently covered.

The design strategy is to extend the existing tun/tap testing infrastructure
to support this new use-case, rather than introducing a new or parallel framework.
This allows for better integration and re-use of existing test logic.

---
v2 -> v3:
 - Re-send the patch series becasue Patchwork don't update them

v2: https://lore.kernel.org/all/cover.1767074545.git.xudu@redhat.com/
 - Addresse sporadic failures due to too early send.
 - Refactor environment address assign helper function.
 - Fix incorrect argument passing in build packet functions.

v1: https://lore.kernel.org/netdev/cover.1763345426.git.xudu@redhat.com/

Xu Du (8):
  selftest: tun: Format tun.c existing code
  selftest: tun: Introduce tuntap_helpers.h header for TUN/TAP testing
  selftest: tun: Refactor tun_delete to use tuntap_helpers
  selftest: tap: Refactor tap test to use tuntap_helpers
  selftest: tun: Add helpers for GSO over UDP tunnel
  selftest: tun: Add test for sending gso packet into tun
  selftest: tun: Add test for receiving gso packet from tun
  selftest: tun: Add test data for success and failure paths

 tools/testing/selftests/net/tap.c            | 287 +-----
 tools/testing/selftests/net/tun.c            | 917 ++++++++++++++++++-
 tools/testing/selftests/net/tuntap_helpers.h | 608 ++++++++++++
 3 files changed, 1530 insertions(+), 282 deletions(-)
 create mode 100644 tools/testing/selftests/net/tuntap_helpers.h


base-commit: 7b8e9264f55a9c320f398e337d215e68cca50131
-- 
2.49.0


