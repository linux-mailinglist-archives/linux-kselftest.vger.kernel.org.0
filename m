Return-Path: <linux-kselftest+bounces-21066-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA1E9B58E1
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 01:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30A78B226DD
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 00:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABAE3BBEA;
	Wed, 30 Oct 2024 00:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="ozuRqiER"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2778224EA;
	Wed, 30 Oct 2024 00:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730249959; cv=none; b=bfiHsZwc5qnSQwLFY0/Fiu7VXstBpG4iPBxBeSRyLD1dMBD8WqjZZ/M6iM6FKgztFtpUL9tSEe7yvlFIaFw81Rz2608ErAdpNFM8JdwuXdNQPMIzkz2X8JWJWY6ZSQS8ovHlS5WzAg+T8rQ0+jQ6tVY+eVumCBhir88V9jnJTmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730249959; c=relaxed/simple;
	bh=RoJ7n+TjhNcKsuO6woNC8VhcIJJQ6DD5vUtjBJVxI8E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UvS6WLgEtY1dovApPLtktKZQH8gCaAilIS0gZTPqOtZoB75f5oIbxijEjBtVfu2DMTBEz19bSQ9l2EddZPJXTxnH9CqCR2LnIzRRHTWho9rPe7l8laN2HHELl2yltWCT9SsaeCKCf4w7tAisoG+RSYGT/Oc2Pa5k6JGSa9+7XrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=ozuRqiER; arc=none smtp.client-ip=68.232.139.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1730249957; x=1761785957;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RoJ7n+TjhNcKsuO6woNC8VhcIJJQ6DD5vUtjBJVxI8E=;
  b=ozuRqiERiFgnWpFq28Px/aFMGKoh0laCpj0NQMNVmGOKyq29FI4/TmFC
   TVIGIHbgHigSILK10SYSNvrMgu77k5bnAWRayyIpTmX2kJneja5xXWvCj
   UQr2VMN/cpytUvowS9bjG5yAdPKMUAOzdyX5YEpvXdtHeZ5VQDfS+ggDl
   B7IwWxrAUoOK4T+OJUTR44z9ECkyJ2fSjiizxOsX07eQjZsdbECimY+XC
   Mmsw7ZPpYOKL+05xOeD8560erZG86oGqF5hMVsj87uM4VUGBnL7dMnIBl
   PGNWIJImZv0ZYALHVgOmdsmlCsMIJCAdliEQsOxI7EsR6NqAkECvULjqk
   A==;
X-CSE-ConnectionGUID: RddgNFb7T3un9RBahO60Cw==
X-CSE-MsgGUID: fQLlGvh+QSC02nhDwUFoGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="177651542"
X-IronPort-AV: E=Sophos;i="6.11,243,1725289200"; 
   d="scan'208";a="177651542"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 09:59:07 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
	by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id C346BD7AC5;
	Wed, 30 Oct 2024 09:59:04 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 1295AD7752;
	Wed, 30 Oct 2024 09:59:04 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 941DA40FD2;
	Wed, 30 Oct 2024 09:59:03 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 824A81A000A;
	Wed, 30 Oct 2024 08:59:02 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Cc: shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v3] selftests/net: Fix ./ns-XXXXXX not cleanup
Date: Wed, 30 Oct 2024 08:59:43 +0800
Message-ID: <20241030005943.400225-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28762.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28762.003
X-TMASE-Result: 10--3.130900-10.000000
X-TMASE-MatchedRID: vWLMKRYJCze+AcfZRlRvHuOnF2j8nBWbn5nfR7I2dFNlmPP/XnGELrmK
	lv3K7lvCloSrM+MzMAFzzDRKdSy6S0ihLTCKfRwR0QlBRwJqtSMxXH/dlhvLv3qSbXH7IxjNnQW
	+uT22cMKx+Ars9pBeBepHTO2bRbrYDytg73Zv02bho30+LUTeFzM2xdYG8ZUGzAdJD7JeNMNNsi
	/bk0au/bK0kaZj7gujfG9GIPJoGIEv+0FNnM7lDQPZZctd3P4BF4r8H5YrEqy4GyTmeN+AbEs+k
	B7u1gtLP4C9ZY0+YI6AMuqetGVetsgO3bswsOnS3QfwsVk0UbvqwGfCk7KUs3XZhXZ6NbnUCQ5F
	GnEfMojQwd+BhDrqwZeInGMBNQHmwGYIAnB9alZTUUCEjQHkaVedHQiiJTqfA1WbH/8y4U2/w1e
	UTxu0biHJp2UYVccqxOB8J0pRLhyJxKSZiwBX6QtRTXOqKmFVftwZ3X11IV0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

```
readonly STATS="$(mktemp -p /tmp ns-XXXXXX)"
readonly BASE=`basename $STATS`
```
It could be a mistake to write to $BASE rather than $STATS, where $STATS
is used to save the NSTAT_HISTORY and it will be cleaned up before exit.

Although since we've been creating the wrong file this whole time and
everything worked, it's fine to remove these 2 lines completely

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
Cc: netdev@vger.kernel.org
---
V3:
  Remove these 2 lines rather than fixing the filename

---
Hello,
Cover letter is here.

This patch set aims to make 'git status' clear after 'make' and 'make
run_tests' for kselftests.
---
V2: nothing change

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 tools/testing/selftests/net/veth.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/net/veth.sh b/tools/testing/selftests/net/veth.sh
index 4f1edbafb946..6bb7dfaa30b6 100755
--- a/tools/testing/selftests/net/veth.sh
+++ b/tools/testing/selftests/net/veth.sh
@@ -46,8 +46,6 @@ create_ns() {
 		ip -n $BASE$ns addr add dev veth$ns $BM_NET_V4$ns/24
 		ip -n $BASE$ns addr add dev veth$ns $BM_NET_V6$ns/64 nodad
 	done
-	echo "#kernel" > $BASE
-	chmod go-rw $BASE
 }
 
 __chk_flag() {
-- 
2.44.0


