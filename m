Return-Path: <linux-kselftest+bounces-34269-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5A3ACD4D9
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 03:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19481169074
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 01:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB6319047A;
	Wed,  4 Jun 2025 01:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jh5qcR2l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B4C219E0;
	Wed,  4 Jun 2025 01:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749000033; cv=none; b=dhHmaw/roz5vdLX6Zh1Ft0/3Y4QwuN0BjdWOLZuejjQ90n9y+FgMwbkiwqDTB+PAiLINYA86tyiMauXm4txsiPQKImhl+hU/OpjUKC7lb5SsrECvFH4YYoz6mi8sMVlsjDvNWL76nPkn3XgXZ/vJ2RAv7pjwppFpjUUO7lAK0Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749000033; c=relaxed/simple;
	bh=9Wr88ww1c2qvUqQO3vQLgRw9ktiQLfD/UconcIs3b0E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rIj7rGv0Bx/2ZNS/PWvlvy4ZRluZqQti4E9rPIHNcCPYTpboJpfipUj5Aqeyy7L5lDWoAkEQxmHLXWpkZrKUG0MsWoH0Ovyg7/Gb/YQrjC2/QvTojbdIVyuFBf7kBOordJvRpCiUloxuu8rNB/LYminiIGXGZAEwJR+Jhq0y2ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jh5qcR2l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D1EC4CEF1;
	Wed,  4 Jun 2025 01:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749000033;
	bh=9Wr88ww1c2qvUqQO3vQLgRw9ktiQLfD/UconcIs3b0E=;
	h=From:To:Cc:Subject:Date:From;
	b=jh5qcR2lMCyEJyPVAgqNQdWf0PwtDoVMYk7U3YzWp8MSQ+HLhGfa5gouVu/tZzwCL
	 5yIjs2seEVX25ilnl7LpbQxsYc19wlGzegduKbdvBZB/qwL0PAQC6HUiAn+4PWHdZr
	 8AgnxlEZDkXYBKZsyK2HFJdAS5N3/w+uTE1OG6Rnmws9d43si/8+CWP6i/8Kxt3lbX
	 qbvsG5J5vJ9l+ywuyqhBANE97Aw4d2ZiLSrOeNdz7UjA6tx1Lk1ElBx0EETv0phMQl
	 uhrhfLnr3NXgU5Dx4QUdPKzSvQU7g/+RYiL7iVJehM9RlYn39873T3VOrSqYnCRxYC
	 m6xs6nIvn6lUA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	willemb@google.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net] selftests: drv-net: tso: fix the GRE device name
Date: Tue,  3 Jun 2025 18:20:31 -0700
Message-ID: <20250604012031.891242-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The device type for IPv4 GRE is "gre" not "ipgre",
unlike for IPv6 which uses "ip6gre".

Not sure how I missed this when writing the test, perhaps
because all HW I have access to is on an IPv6-only network.

Fixes: 0d0f4174f6c8 ("selftests: drv-net: add a simple TSO test")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: willemb@google.com
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/drivers/net/hw/tso.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/hw/tso.py b/tools/testing/selftests/drivers/net/hw/tso.py
index 150d6db241a0..3370827409aa 100755
--- a/tools/testing/selftests/drivers/net/hw/tso.py
+++ b/tools/testing/selftests/drivers/net/hw/tso.py
@@ -216,7 +216,7 @@ from lib.py import bkg, cmd, defer, ethtool, ip, rand_port, wait_port_listen
             ("",            "6", "tx-tcp6-segmentation",          None),
             ("vxlan",        "", "tx-udp_tnl-segmentation",       ("vxlan",  True,  "id 100 dstport 4789 noudpcsum")),
             ("vxlan_csum",   "", "tx-udp_tnl-csum-segmentation",  ("vxlan",  False, "id 100 dstport 4789 udpcsum")),
-            ("gre",         "4", "tx-gre-segmentation",           ("ipgre",  False,  "")),
+            ("gre",         "4", "tx-gre-segmentation",           ("gre",    False,  "")),
             ("gre",         "6", "tx-gre-segmentation",           ("ip6gre", False,  "")),
         )
 
-- 
2.49.0


