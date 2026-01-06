Return-Path: <linux-kselftest+bounces-48259-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE12CF64FB
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 02:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA3063023D40
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 01:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31183148DF;
	Tue,  6 Jan 2026 01:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YNMafVy9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BF1221721
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 01:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767663336; cv=none; b=gigVyqR/XgfVjamhLe4Cmm3QPloppjRa2dk9/yEyZ3LmVhZtOwtH0GkShUMZSgRjAoBq6Nk5KZ/dFZqreUyKUwLRAkJ7HEKk7zmnGV1disqvzLklJZaT4KnRyRwE2e6IksxDPKcDjftnza4SWGJleUfkPsjd67JwsRccIbOEKtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767663336; c=relaxed/simple;
	bh=k/itBHgcviou2LujUa6hvac8sbX6ppluQKvNt6m48fY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZTNxTWA/0jGtDsRQwukj/6Q10sSreRosMKNJbbUJ/fx3n2Smv1iMNKxZZQnaVxTFPwiIG4tnvTS4yM2CLvuijx277WdHXOOgOBpkF2q94RZaxDWmsOhFPCo/6CHql0UyNH+Yjoz0b85t9hAA3fgBzq1XaRzoMfJKmPKlBV51Tcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YNMafVy9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767663334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LCH/iKzsxatVqnYUN5bNfLq59BRpb4fTjoEeV+RR8tc=;
	b=YNMafVy9fVbURnKaCeyJ2FUprDa3PzzVbv3q4iFQHACIgk5WGk9YBL+MKZ/XS3363ZquPT
	ME+HqUoJlZDG86OR6+ZzYKOmJnUX44mAtWW066hso1nhN5d8jdJ9Pef5W1PKTKoOlWe/+8
	7IhqyDgemGFEFqAX3vCHqNOZKni9DfU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-489-uCvIrjQXPGOEn5nrFldCog-1; Mon,
 05 Jan 2026 20:35:30 -0500
X-MC-Unique: uCvIrjQXPGOEn5nrFldCog-1
X-Mimecast-MFC-AGG-ID: uCvIrjQXPGOEn5nrFldCog_1767663329
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 17D2D195605A;
	Tue,  6 Jan 2026 01:35:29 +0000 (UTC)
Received: from xudu-thinkpadx1carbongen9.nay.csb (unknown [10.66.60.72])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0887F180044F;
	Tue,  6 Jan 2026 01:35:24 +0000 (UTC)
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
Subject: [PATCH net-next v4 0/8] selftest: Extend tun/virtio coverage for GSO over UDP tunnel
Date: Tue,  6 Jan 2026 09:35:13 +0800
Message-ID: <cover.1767597114.git.xudu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The primary goal is to add test validation for GSO when operating over
UDP tunnels, a scenario which is not currently covered.

The design strategy is to extend the existing tun/tap testing infrastructure
to support this new use-case, rather than introducing a new or parallel framework.
This allows for better integration and re-use of existing test logic.

---
v3 -> v4:
 - Rebase onto the latest net-next tree to resolve merge conflicts.

v3: https://lore.kernel.org/netdev/cover.1767580224.git.xudu@redhat.com/
 - Re-send the patch series becasue Patchwork don't update them.

v2: https://lore.kernel.org/netdev/cover.1767074545.git.xudu@redhat.com/
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

 tools/testing/selftests/net/tap.c            | 281 +-----
 tools/testing/selftests/net/tun.c            | 919 ++++++++++++++++++-
 tools/testing/selftests/net/tuntap_helpers.h | 602 ++++++++++++
 3 files changed, 1526 insertions(+), 276 deletions(-)
 create mode 100644 tools/testing/selftests/net/tuntap_helpers.h


base-commit: c303e8b86d9dbd6868f5216272973292f7f3b7f1
-- 
2.49.0


