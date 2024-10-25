Return-Path: <linux-kselftest+bounces-20601-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3625B9AF70B
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 03:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD4701F22C87
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 01:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E240171E65;
	Fri, 25 Oct 2024 01:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="D1S3Ku6j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254F813635E;
	Fri, 25 Oct 2024 01:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.37.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729820455; cv=none; b=SbGpng6qA20HJImEwTDxQaWp8oCjKxSIw7OWBWRQ8hQIItMJpVUQQ5HXmpEmVN42eljwTOYfPfXB2wCM51gasyzbVm7oEfUi/wnKwU7Z0bk04QRq+8dvte1zhkTJLXUY7Bvx62vXUx3lzWQlxIvgWBB08A4l/JPBvZSwJurxGUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729820455; c=relaxed/simple;
	bh=ae6TCmCFNHLPjh3lVn88hVsBGGUKX7j2CwNOT/CU5Vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TEguw1UBC072d5NBHGDUwv7N0ON2uUl7/bM6pV+aGoe/oQfshcN8Pxq6uYmE5NxpDyLRYpqvU8pHTjjtUG19zFGVQPoqSPNQJXKJPYudvciuBs+3UuFAY6CU0xNj2IFwXF2xeez1YD9ij2Ie30kMr1kkckd1lNrvB1xWvL8jETY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=D1S3Ku6j; arc=none smtp.client-ip=139.138.37.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1729820452; x=1761356452;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ae6TCmCFNHLPjh3lVn88hVsBGGUKX7j2CwNOT/CU5Vk=;
  b=D1S3Ku6jgmS0FTC7T5F/4LEGuoHBt3EkK/QagMY+51Y1bV6jsFXEyOtY
   y2Jj7oazDEOEShgrLdssMq+mdWHonT7gind/RaK4Slc4Zi21r/qYbAMT1
   Gjufl3ndBsRu1vxz35yQUw5dA/I5IMfH5S14yXCPkpUgqhUCSzXj87Pqd
   /olylQY+NbkvbehzDA49QSmj9Y94MiOgHNM+c7Z23Z/Qlni/BscGPg2UF
   DEa5ZhCakUyKWTsQhTc0D8SRqR9n7lE12B/NIL/lX4S84P/+8EDYAYSQL
   i9iCR9AGzEpHEag+z91QaV+7Ff5lQJfMLW/qAD9rN8P7BG3Z3HgXADhps
   w==;
X-CSE-ConnectionGUID: 7/DHaTp1QmOwV+qGRk3qug==
X-CSE-MsgGUID: /tCirz76TRCDnhBRXA7+kQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="156895126"
X-IronPort-AV: E=Sophos;i="6.11,230,1725289200"; 
   d="scan'208";a="156895126"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 10:39:38 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id D28B3C68E1;
	Fri, 25 Oct 2024 10:39:35 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 08A95D3F14;
	Fri, 25 Oct 2024 10:39:35 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 76EE72007955B;
	Fri, 25 Oct 2024 10:39:34 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 6D3501A000B;
	Fri, 25 Oct 2024 09:39:33 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kselftest@vger.kernel.org
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
	coreteam@netfilter.org,
	netdev@vger.kernel.org
Subject: [PATCH for-next 4/7] selftests/net: Add missing gitignore file
Date: Fri, 25 Oct 2024 09:40:07 +0800
Message-ID: <20241025014010.6533-4-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241025014010.6533-1-lizhijian@fujitsu.com>
References: <20241025014010.6533-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28752.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28752.003
X-TMASE-Result: 10--7.130600-10.000000
X-TMASE-MatchedRID: SzbEz7SZt2shiKpapiFQUqoXHZz/dXlxTJDl9FKHbrmwcSh5kytY+Wlr
	rhfytIG3ue7scXXMXXbOw1q4IOi+g+VaI0j/eUAP9Ib/6w+1lWTVBDonH99+VkYUijfAB7a8Sdp
	3nQlC6CvONlqzU5N8Te4nDl0cg6mq0ekSi+00U24ReM8i8p3vgKAyvPZuBdRcACF5TKaad1+CE8
	twEnUQ06GvCFqoKSwTgDLqnrRlXrbIDt27MLDp0t0H8LFZNFG7bkV4e2xSge5ohlAZXykbpgAyO
	Vzm89Qseu6ZNp10bbJxAl0R7Q6QvhyFdNnda6Rv
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
V2:
  split as a separate patch from a small one [0]
  [0] https://lore.kernel.org/linux-kselftest/20241015010817.453539-1-lizhijian@fujitsu.com/
---
 tools/testing/selftests/net/netfilter/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/netfilter/.gitignore b/tools/testing/selftests/net/netfilter/.gitignore
index 0a64d6d0e29a..eef8d5784e94 100644
--- a/tools/testing/selftests/net/netfilter/.gitignore
+++ b/tools/testing/selftests/net/netfilter/.gitignore
@@ -4,3 +4,4 @@ connect_close
 conntrack_dump_flush
 sctp_collision
 nf_queue
+conntrack_reverse_clash
-- 
2.44.0


