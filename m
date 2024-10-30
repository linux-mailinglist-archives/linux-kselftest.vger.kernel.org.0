Return-Path: <linux-kselftest+bounces-21067-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE0F9B58E5
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 02:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6177E28459C
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 01:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0628C481DD;
	Wed, 30 Oct 2024 01:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="GKfHp9Aj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3852E3C14;
	Wed, 30 Oct 2024 01:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730250046; cv=none; b=RbNOWNfqcjiKVx8615XrDjUszIxYdO+lrzXoGWu3I8II5gXxxfLml2c04jLzyEhtTpyS4XMPOL1hiIHVfWrs9jtNEL0qsH0pkdgU500/OKliW9WgZv1vhJYEiNzKKU4uan+IvOkTadRORDetVWBNJivC6fn6oaaL9IFUwrfrm5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730250046; c=relaxed/simple;
	bh=od59CaTPcXAt5fo3ZaO6rvMZ1g5AHGLeUgTuhqAeGVU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gVSaGCoNCT4dUU7hI0FkOD27Z86aQMVxOt0BZGc+2Dj78TTRWuSM6BqyF/wiI9oGiIEzv8ZqNvdDI3+ssNxxsSSWG5ZViv/uXi4ZPblcrsT9QJAn74RZMyvTluY0YhGhTeAijmi5g1ZPBxBXrydbu1ql6YUPeC24Q4Lh9WEcAlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=GKfHp9Aj; arc=none smtp.client-ip=139.138.36.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1730250045; x=1761786045;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=od59CaTPcXAt5fo3ZaO6rvMZ1g5AHGLeUgTuhqAeGVU=;
  b=GKfHp9AjIz8PZIQt0PT9cdM9dXN1Wqi28z9Qm6n2ilyaBaItpNZiMzK2
   llKMBWWyf03YtaQLnQvuUiqhw7YyS31dn7/CDFXo6HSiijEHSTuPE0OGt
   OpvY9ZeJjrMXhpOofdTbuSaQzZw4iRePqui6rnxQfLEwwe7HS1G4tiksE
   zSvMxK2iDrSkhqUQqqv7VNDQ33HxbVNkel/PW5XyJWsVHTsHhAAImvsc8
   /Ng8DGh9NFFYkbZhFbOsF5qYTB3afABOjRck2+adLiriHp5BKCzLpZHh2
   J+nfJ449O8qhPpx5VXLS3EydjK6siW8RlnfnUmygLL4JS3zWOzhCa/+9x
   A==;
X-CSE-ConnectionGUID: Il4evkucS4KFMvK1w5c3WA==
X-CSE-MsgGUID: Q2HKdES+RmWdjNZp+7dWRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="166793493"
X-IronPort-AV: E=Sophos;i="6.11,243,1725289200"; 
   d="scan'208";a="166793493"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 09:59:32 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id E8E89C68E8;
	Wed, 30 Oct 2024 09:59:29 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 36B5DD5047;
	Wed, 30 Oct 2024 09:59:29 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id CF0D220079562;
	Wed, 30 Oct 2024 09:59:28 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 9D78F1A000A;
	Wed, 30 Oct 2024 08:59:27 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Cc: shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org
Subject: [PATCH v3] selftests/net: Add missing gitignore file
Date: Wed, 30 Oct 2024 09:00:02 +0800
Message-ID: <20241030010002.400238-1-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10--10.200800-10.000000
X-TMASE-MatchedRID: a3KJLn6RIiIhiKpapiFQUqoXHZz/dXlxTJDl9FKHbrmwcSh5kytY+Wlr
	rhfytIG3ue7scXXMXXbOw1q4IOi+g+VaI0j/eUAP9Ib/6w+1lWTVBDonH99+VkYUijfAB7a8Sdp
	3nQlC6CvONlqzU5N8TV5k1j3tRqCQZB7FaQ6KQ99O5y1KmK5bJTZlY6a4lRLZSGcP+0SEjFBAPN
	HJ6d1lGx63ztJ0rJm/nagtny7ZPcQfE8yM4pjsD67rlQMPRoOCxEHRux+uk8h+ICquNi0WJKxPa
	V9/KHBB+Z6nLjaSWHAwVhpxqsrjNJRD0+ifpY+DftwZ3X11IV0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Compiled binary files should be added to .gitignore
'git status' complains:
   Untracked files:
   (use "git add <file>..." to include in what will be committed)
         net/netfilter/conntrack_reverse_clash

Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Jozsef Kadlecsik <kadlec@netfilter.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
Cc: netfilter-devel@vger.kernel.org
Cc: coreteam@netfilter.org
Cc: netdev@vger.kernel.org
---
Hello,
Cover letter is here.

This patch set aims to make 'git status' clear after 'make' and 'make
run_tests' for kselftests.
---
V3:
  sort the files

V2:
  split as a separate patch from a small one [0]
  [0] https://lore.kernel.org/linux-kselftest/20241015010817.453539-1-lizhijian@fujitsu.com/

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 tools/testing/selftests/net/netfilter/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/netfilter/.gitignore b/tools/testing/selftests/net/netfilter/.gitignore
index 0a64d6d0e29a..64c4f8d9aa6c 100644
--- a/tools/testing/selftests/net/netfilter/.gitignore
+++ b/tools/testing/selftests/net/netfilter/.gitignore
@@ -2,5 +2,6 @@
 audit_logread
 connect_close
 conntrack_dump_flush
+conntrack_reverse_clash
 sctp_collision
 nf_queue
-- 
2.44.0


