Return-Path: <linux-kselftest+bounces-19693-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2E799DB15
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 03:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4155A1C210C4
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 01:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF6374068;
	Tue, 15 Oct 2024 01:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="WJRs2hV2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56688DDBB;
	Tue, 15 Oct 2024 01:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728954490; cv=none; b=OJS0wNR8BVpq/TFykbsbTrCdSduWU+5/3LF2SPgt12CYFT8NQxrGGBXcjisc75cVgUTy92PudzMldSm7Rl5LTQEyxSXtR+eBKnuAfFUW4UWHE+IZm9pynU0fObXmsxD5814Pu/4lhuqZdYF2LUBweV5A1KZOIrNAPZvD/RFxVKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728954490; c=relaxed/simple;
	bh=tv5IX+ovqKeWK7u83IH4qp3NmpBqy6RR5KBT2nTwQ/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vs4Vp3oVX0PeMEKS2VUpRaQMV2g+Lig3x+BoKZWVBj+AlnOnRmT11YrUlgvfwspRKgXQySvqrDlRbXToghKBd4FTI3jWFHvnbhjJzAk3MM1sUjmSlb6tFgDI0fwCxgmgLJTJ6l1n6zCYQ0pApijhv2wPQXdrgErwHfWcDVRQeSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=WJRs2hV2; arc=none smtp.client-ip=139.138.61.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1728954488; x=1760490488;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tv5IX+ovqKeWK7u83IH4qp3NmpBqy6RR5KBT2nTwQ/Q=;
  b=WJRs2hV2Ilelj+ULSYGdEjq82Cc1c7F7EPMiPsD8wbzwIfDt8OCDuTra
   uH66+ewzqlSfx3rf43dO4oSAshdG2V5dO2b6HpiNpJESl6Z2d0QTFZwD9
   CNHMVwkRjG5CjghTjCHEWiwBqMEWU9rHSOn/QgHsknx01L0eeYH/UTJ4w
   xeE1M01yGtycaTFz5HMMirB8jXXTMI4eTn9rRxV8Z6wr37WLScpaFGaWr
   qjNAb1doycRwR3OMgAK+Dx9Ns1h5J2v803jLf/zWiLUSGCwXtSgwe6HOr
   aNrF//8Y+amAg3wkJPU48Q/eH3D2xCVqVrHDgX+0LZNuJ55yrvMwVNm/2
   w==;
X-CSE-ConnectionGUID: VsVHaeNjRn684VMovI6MHw==
X-CSE-MsgGUID: emeS+53kQe2Vz2fyyAZyeg==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="164725997"
X-IronPort-AV: E=Sophos;i="6.11,204,1725289200"; 
   d="scan'208";a="164725997"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 10:07:38 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
	by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 7B0D5E852C;
	Tue, 15 Oct 2024 10:07:36 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id AE069D511C;
	Tue, 15 Oct 2024 10:07:35 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 414206BA7F;
	Tue, 15 Oct 2024 10:07:35 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 4F35B1A01E9;
	Tue, 15 Oct 2024 09:07:34 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH 2/3] selftests/net: Fix ./ns-XXXXXX not cleanup
Date: Tue, 15 Oct 2024 09:08:16 +0800
Message-ID: <20241015010817.453539-2-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241015010817.453539-1-lizhijian@fujitsu.com>
References: <20241015010817.453539-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28732.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28732.003
X-TMASE-Result: 10--0.683100-10.000000
X-TMASE-MatchedRID: lbdkQWb+CNa+AcfZRlRvHuOnF2j8nBWbn5nfR7I2dFNlmPP/XnGELrmK
	lv3K7lvCloSrM+MzMAEa/Rm8RmNZp6s4CIwqUsM8rMZ+BqQt2NrBOVz0Jwcxl6vCrG0TnfVUg9x
	e4gtUJtonayl/4MJ4nGMemTaDph9uYPx7yddt9jKeAiCmPx4NwGmRqNBHmBveafSbrzwSjfwqtq
	5d3cxkNXiltRsZXo+3UppxeetCusqmTKwyS/M9OKJ605sIm6Udg2SiYCo8mFfuNSBApl5QIs8Ue
	T0AOb1weaIz6J16T197bWtV+OQFC/4Bx1weaSflFcUQf3Yp/ridO0/GUi4gFb0fOPzpgdcEKeJ/
	HkAZ8Is=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

```
readonly STATS="$(mktemp -p /tmp ns-XXXXXX)"
readonly BASE=`basename $STATS`
```
It would be a mistake to write to $BASE rather than $STATS, where $STATS
is used to save the NSTAT_HISTORY and it will be cleaned up before exit.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
Cc: netdev@vger.kernel.org
---
 tools/testing/selftests/net/veth.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/veth.sh b/tools/testing/selftests/net/veth.sh
index 4f1edbafb946..457312ef135a 100755
--- a/tools/testing/selftests/net/veth.sh
+++ b/tools/testing/selftests/net/veth.sh
@@ -46,8 +46,8 @@ create_ns() {
 		ip -n $BASE$ns addr add dev veth$ns $BM_NET_V4$ns/24
 		ip -n $BASE$ns addr add dev veth$ns $BM_NET_V6$ns/64 nodad
 	done
-	echo "#kernel" > $BASE
-	chmod go-rw $BASE
+	echo "#kernel" > $STATS
+	chmod go-rw $STATS
 }
 
 __chk_flag() {
-- 
2.44.0


