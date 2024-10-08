Return-Path: <linux-kselftest+bounces-19231-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D35994562
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 12:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61EDB1C24BB3
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 10:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F59C198836;
	Tue,  8 Oct 2024 10:29:21 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6151779B1;
	Tue,  8 Oct 2024 10:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728383361; cv=none; b=oMtbhElgEXwWr8hwNnv0QzSWYM7xeZXdzBFmCZArpvxlty5DnSJlVT6+f6KfM69V4V9Fh5ymyQG4gDzZW8VJL8yceB6anGMkv0m/IzdSIL3s6rbW/wbTCbn+WvF7go6EmcTbcwCNmtKDRI6FWuqnH/lPvl8pm13O1V2t44TBDdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728383361; c=relaxed/simple;
	bh=cSxMEZo4dYqlh8/0TzamPzyRZ/MF1/XyyCo33WuItSA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jg2+HnM6YVdo4YsZRAgD4C+AFqG7knppwvpCuDoRHs2wttNFwJoP11ThE3pToLwAFg7X3xuxJaSuTuQ1wHbUGlCFodGAyzANUPx+MqJTlzfXCRRbuUgmAbawSna6J8eQ8BPmdBC1aU7TZRb0K6QiH2oE68eXat8CMBpgG6pOI7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XNC021ryRz6J6rb;
	Tue,  8 Oct 2024 18:28:02 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 6BF411402C6;
	Tue,  8 Oct 2024 18:29:16 +0800 (CST)
Received: from china (10.200.201.82) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 8 Oct
 2024 12:29:10 +0200
From: Gur Stavi <gur.stavi@huawei.com>
To: Gur Stavi <gur.stavi@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
	<shuah@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next v02 0/2] net: af_packet: allow joining a fanout when link is down
Date: Tue, 8 Oct 2024 13:27:57 +0300
Message-ID: <cover.1728382839.git.gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 frapeml500005.china.huawei.com (7.182.85.13)

PACKET socket can retain its fanout membership through link down and up
and leave a fanout while closed regardless of link state.
However, socket was forbidden from joining a fanout while it was not
RUNNING.

This patch allows PACKET socket to join a fanout while not RUNNING.
Selftest psock_fanout is extended to test this scenario.
This is the only test that was performed.

This scenario was identified while studying DPDK pmd_af_packet_drv.
Since sockets are only created during initialization, there is no reason
to fail the initialization if a single link is temporarily down.

I hope it is not considered as breaking user space and that applications
are not designed to expect this failure.


Changes:

V02:
* psock_fanout: use explicit loopback up/down instead of toggle.
* psock_fanout: don't try to restore loopback state on failure.
* Rephrase commit message about "leaving a fanout".

V01: https://lore.kernel.org/netdev/cover.1728303615.git.gur.stavi@huawei.com/

Gur Stavi (2):
  af_packet: allow fanout_add when socket is not RUNNING
  selftests: net/psock_fanout: socket joins fanout when link is down

 net/packet/af_packet.c                     | 10 +++---
 tools/testing/selftests/net/psock_fanout.c | 42 ++++++++++++++++++++--
 2 files changed, 44 insertions(+), 8 deletions(-)


base-commit: f95b4725e796b12e5f347a0d161e1d3843142aa8
-- 
2.45.2


