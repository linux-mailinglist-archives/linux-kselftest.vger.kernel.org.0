Return-Path: <linux-kselftest+bounces-16581-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDD7963027
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 20:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD3201F21D88
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 18:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B491A7AEE;
	Wed, 28 Aug 2024 18:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QnCOdsV0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0CE1A76D8
	for <linux-kselftest@vger.kernel.org>; Wed, 28 Aug 2024 18:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724870284; cv=none; b=iowIPeHMIgOFChHgMUoWVOauMjFq8DOv4B53l06ZM6t8y+4Z1AotyG5SeUAht1mjSXbgG25TnuCuWN+f1AsBHTu/voG9PojR5PBcYb83SD8m6rT62sDx0AdddW2JCybreXC39NFl2Vonx48HBZUcF2qore/i7+CWs5vCZNEReGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724870284; c=relaxed/simple;
	bh=iGHBiqnU2UH+BOQlSsspdgIqzjrSWwoUANYOqMkeYTc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M04qD/XY9sESQKHhnWK+B9mOnMMU6FxHvL/Qfw93Xip1g/cbU0YoqMQJYhGg3+3uWPQOjs1okxyJKKwp+fY9/doPu8wja3jLvZMIVu7y5xDJHC/WW0/SB63X53D7OcQD/ZblIgF4sB59Eq0UEHQpmfAuK7xPhWja1hdKc3Y2r+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QnCOdsV0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724870282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VG3hNlxTKzDo9TN+veLdg1lBcMc/GXQVTwzLq53GUhY=;
	b=QnCOdsV0EevOhJxqzJXDYzvhwMagYjes+gqEp7/6ycCDtenU2TLs9PSqmkk3NsXlhlk6qL
	oz+M72iAtFKh4yQ4Lu+qeAqthaHdPEQ0yl+rjRtn4CpXmrgHclqmuwnhFQCxl1lqpS8vAB
	H3z0Ild04p0v4sjU7nPfMoDfR7CJgP0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-379-zMsJo2RhP3KFH3A_ISH_MA-1; Wed,
 28 Aug 2024 14:37:58 -0400
X-MC-Unique: zMsJo2RhP3KFH3A_ISH_MA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 709A51955D4A;
	Wed, 28 Aug 2024 18:37:57 +0000 (UTC)
Received: from jmaloy-thinkpadp16vgen1.rmtcaqc.csb (unknown [10.22.8.17])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1A9CA19560A3;
	Wed, 28 Aug 2024 18:37:53 +0000 (UTC)
From: jmaloy@redhat.com
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	davem@davemloft.net
Cc: kuba@kernel.org,
	passt-dev@passt.top,
	jmaloy@redhat.com,
	sbrivio@redhat.com,
	lvivier@redhat.com,
	dgibson@redhat.com,
	eric.dumazet@gmail.com,
	edumazet@google.com
Subject: [net-next, v3 0/2] Adding SO_PEEK_OFF for TCPv6
Date: Wed, 28 Aug 2024 14:37:50 -0400
Message-ID: <20240828183752.660267-1-jmaloy@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

From: Jon Maloy <jmaloy@redhat.com>

Adding SO_PEEK_OFF for TCPv6 and selftest for both TCPv4 and TCPv6

Jon Maloy (2):
  tcp: add SO_PEEK_OFF socket option tor TCPv6
  selftests: add selftest for tcp SO_PEEK_OFF support

 net/ipv6/af_inet6.c                           |   1 +
 tools/testing/selftests/net/Makefile          |   1 +
 tools/testing/selftests/net/tcp_so_peek_off.c | 183 ++++++++++++++++++
 3 files changed, 185 insertions(+)
 create mode 100644 tools/testing/selftests/net/tcp_so_peek_off.c

-- 
2.45.2


