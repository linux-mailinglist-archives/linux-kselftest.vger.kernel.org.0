Return-Path: <linux-kselftest+bounces-21663-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 246B19C1986
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 10:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 563091C21F07
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 09:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602A01E0E07;
	Fri,  8 Nov 2024 09:51:35 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A40F1DFE3F;
	Fri,  8 Nov 2024 09:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731059495; cv=none; b=mN52w84Pe0Xvh1DlqWL0d+Am5TDd4LjDV8+zuiLFiPUmB8lce/A0VSMVYCzhNund20EC4BR+2IjDs/jG5wCphBNgytWrVHi1lZgwe2qD5PNWslnp8RG2cU9QU8l9+dwQKbb8HF/k/kaKxL3bwdpjWXYl+W8IJr6QJonsGcWtkF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731059495; c=relaxed/simple;
	bh=9cQyIJ1YJFFU3Y5nhSzwbDXYprxwfBeAgUZvfFci0v8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HGNRUJUjbB4FvZDskxGw94Ut7bBCKZiDPsyY9AHuxajWUS1rzGwefQQ/O+SUPGcHq80dTbZ5zklwmBtseuuELDKWSLuYaQJEGAIN9PYefbNTq1vJ1hE4tqxsGuTOhTiA8GzAZKOCTS6NSlJ1NVVOHL5bcrZfAqVNmnUFRqc1o8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee7672ddf1539e-f23b4;
	Fri, 08 Nov 2024 17:51:19 +0800 (CST)
X-RM-TRANSID:2ee7672ddf1539e-f23b4
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee7672ddf0c9dd-9a40f;
	Fri, 08 Nov 2024 17:51:19 +0800 (CST)
X-RM-TRANSID:2ee7672ddf0c9dd-9a40f
From: guanjing <guanjing@cmss.chinamobile.com>
To: pablo@netfilter.org,
	kadlec@netfilter.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org
Cc: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	guanjing <guanjing@cmss.chinamobile.com>
Subject: [PATCH] selftests: netfilter: Fix the bug of missing return values
Date: Fri,  8 Nov 2024 16:13:58 +0800
Message-Id: <20241108081358.184546-1-guanjing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed the bug of some functions were missing return values.

Fixes: eff3c558bb7e ("netfilter: ctnetlink: support filtering by zone")
Signed-off-by: Guan Jing <guanjing@cmss.chinamobile.com>
---
 .../testing/selftests/net/netfilter/conntrack_dump_flush.c  | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/net/netfilter/conntrack_dump_flush.c b/tools/testing/selftests/net/netfilter/conntrack_dump_flush.c
index 254ff03297f0..5f827e10717d 100644
--- a/tools/testing/selftests/net/netfilter/conntrack_dump_flush.c
+++ b/tools/testing/selftests/net/netfilter/conntrack_dump_flush.c
@@ -43,6 +43,8 @@ static int build_cta_tuple_v4(struct nlmsghdr *nlh, int type,
 	mnl_attr_nest_end(nlh, nest_proto);
 
 	mnl_attr_nest_end(nlh, nest);
+
+	return 0;
 }
 
 static int build_cta_tuple_v6(struct nlmsghdr *nlh, int type,
@@ -71,6 +73,8 @@ static int build_cta_tuple_v6(struct nlmsghdr *nlh, int type,
 	mnl_attr_nest_end(nlh, nest_proto);
 
 	mnl_attr_nest_end(nlh, nest);
+
+	return 0;
 }
 
 static int build_cta_proto(struct nlmsghdr *nlh)
@@ -90,6 +94,8 @@ static int build_cta_proto(struct nlmsghdr *nlh)
 	mnl_attr_nest_end(nlh, nest_proto);
 
 	mnl_attr_nest_end(nlh, nest);
+
+	return 0;
 }
 
 static int conntrack_data_insert(struct mnl_socket *sock, struct nlmsghdr *nlh,
-- 
2.33.0




