Return-Path: <linux-kselftest+bounces-26018-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D380BA2CB7C
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 19:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF14D7A696F
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 18:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D673B1B85D1;
	Fri,  7 Feb 2025 18:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KOnuMl4p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3981A5B9C;
	Fri,  7 Feb 2025 18:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738953083; cv=none; b=M+HJYYnLxsFfw2OncdXSow3o0AsyNvLiEiIRWhuD+0woRCGi2e7iWiAc8p/QktJT13TM8YHNNvILyOii1ojPucsU4H0OXsJoOFNaizh7c9c6s/nWZ2tooHv5BL0Zq9y9AgF7lUyHSnrYZ9g9cDJsRRQDmL7y3aSHmsFFwqJm8Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738953083; c=relaxed/simple;
	bh=dR7ir7Ml+bcZNbYU28vHuXh2+qgJTlIteiW5GfHeke4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TUzR/n+887IBZBpna5RuZRIFefpoMoCuDht3JwY0WHVWef84N+VuOH+dfax6HN9g/Og5AailqFf4G11LDyoHlWACX58lRaoBcaiv5ixPWt8hncYFbWGCu6STOoHkiPfOyjVUcnwbQ+R5YCAPi3gG5DW+rmhEbtKXYNOWqnklliw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KOnuMl4p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB4DC4CEDF;
	Fri,  7 Feb 2025 18:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738953083;
	bh=dR7ir7Ml+bcZNbYU28vHuXh2+qgJTlIteiW5GfHeke4=;
	h=From:To:Cc:Subject:Date:From;
	b=KOnuMl4pTfd/x0g7I6MnUYzOxE7cE/rCVGxxlfyAJLmc1tQQLxzpGiEYw/pqPPlLW
	 5W+hbLO+J1tWojrBix+GGdw7VgjccvWWSluRO5oZyIJTdKkfEYUSpBqfXckW6VXy9+
	 Nxm29n4nyky3oERnWCTSenuO0A6T5OiulKeKY80COrqtn+pqUojyfg+M+snTHSjAz3
	 hvIpFRC4eLMrbBbeUkCyMIUboaQ0OW2V4HH++yTYpdW8eBk2srQ+/g0JaEzHU1IbTL
	 ixq+dAZ4pBNTIsSE69y6ugDdD27PlaOsIXAQqZhmv6K7FMMpBAp5Vb2Iy+aBVmP/z1
	 uROjZrk/iPY7g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	almasrymina@google.com,
	sdf@fomichev.me,
	jdamato@fastly.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next] selftests: drv-net: remove an unnecessary libmnl include
Date: Fri,  7 Feb 2025 10:31:19 -0800
Message-ID: <20250207183119.1721424-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ncdevmem doesn't need libmnl, remove the unnecessary include.

Since YNL doesn't depend on libmnl either, any more, it's actually
possible to build selftests without having libmnl installed.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: almasrymina@google.com
CC: sdf@fomichev.me
CC: jdamato@fastly.com
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/drivers/net/hw/ncdevmem.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
index 19a6969643f4..2bf14ac2b8c6 100644
--- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
+++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
@@ -50,7 +50,6 @@
 #include <linux/memfd.h>
 #include <linux/dma-buf.h>
 #include <linux/udmabuf.h>
-#include <libmnl/libmnl.h>
 #include <linux/types.h>
 #include <linux/netlink.h>
 #include <linux/genetlink.h>
-- 
2.48.1


