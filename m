Return-Path: <linux-kselftest+bounces-20128-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2939A3AD8
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 12:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 627641C20DB6
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 10:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE976201009;
	Fri, 18 Oct 2024 10:06:15 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA06200CB1;
	Fri, 18 Oct 2024 10:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729245975; cv=none; b=k2baaYHB+TjSnV6gBL0IKHLsBjR5BiLRghoWAfd/68mDs3dYOcodrxN2McbeURMklGxLIu7tzFjqh60OPw2K/gYhuMtQEhb0kJk5JYa3cE0m4ohcg+oG4+V11a+tArjTWL+zupFOzr6iILF74uvtSRWfa01vDD4+OLytXJv8Xjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729245975; c=relaxed/simple;
	bh=3iXNkN+muYWd12s6ZYLKS7emj/P3LYE6I00jYi0PHow=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Dz3fqn0Hd1RfwbxIJyRecc2qbClOuizhTnD1HObe8/e8dZ+Qlt9HyRq0+eBSaseYRZ0VGneltQilWjE8EnT+OMHKYYe+B1Cg0YIPZp/nfnLdAHWs8w1a0PEIj+j95qkoyA8x5LuRf1BHx8Mj9rjMFtDrZtOkwfVq22+RUoVnC64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee16712330afd5-118e4;
	Fri, 18 Oct 2024 18:06:02 +0800 (CST)
X-RM-TRANSID:2ee16712330afd5-118e4
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain.localdomain (unknown[10.55.1.69])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee46712330915d-b9138;
	Fri, 18 Oct 2024 18:06:02 +0800 (CST)
X-RM-TRANSID:2ee46712330915d-b9138
From: Liu Jing <liujing@cmss.chinamobile.com>
To: pablo@netfilter.org
Cc: kadlec@netfilter.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liu Jing <liujing@cmss.chinamobile.com>
Subject: [PATCH] selftests: netfilter: remove unused rplnlh parameter
Date: Thu, 17 Oct 2024 15:25:34 +0800
Message-Id: <20241017072534.127519-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rplnlh parameter is not used in many functions, so delete it.

Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>
---
 tools/testing/selftests/net/netfilter/conntrack_dump_flush.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/netfilter/conntrack_dump_flush.c b/tools/testing/selftests/net/netfilter/conntrack_dump_flush.c
index bd9317bf5ada..e03ddc60b5d4 100644
--- a/tools/testing/selftests/net/netfilter/conntrack_dump_flush.c
+++ b/tools/testing/selftests/net/netfilter/conntrack_dump_flush.c
@@ -96,7 +96,6 @@ static int conntrack_data_insert(struct mnl_socket *sock, struct nlmsghdr *nlh,
 				 uint16_t zone)
 {
 	char buf[MNL_SOCKET_BUFFER_SIZE];
-	struct nlmsghdr *rplnlh;
 	unsigned int portid;
 	int err, ret;
 
@@ -212,7 +211,7 @@ static int count_entries(const struct nlmsghdr *nlh, void *data)
 static int conntracK_count_zone(struct mnl_socket *sock, uint16_t zone)
 {
 	char buf[MNL_SOCKET_BUFFER_SIZE];
-	struct nlmsghdr *nlh, *rplnlh;
+	struct nlmsghdr *nlh;
 	struct nfgenmsg *nfh;
 	struct nlattr *nest;
 	unsigned int portid;
@@ -259,7 +258,7 @@ static int conntracK_count_zone(struct mnl_socket *sock, uint16_t zone)
 static int conntrack_flush_zone(struct mnl_socket *sock, uint16_t zone)
 {
 	char buf[MNL_SOCKET_BUFFER_SIZE];
-	struct nlmsghdr *nlh, *rplnlh;
+	struct nlmsghdr *nlh;
 	struct nfgenmsg *nfh;
 	struct nlattr *nest;
 	unsigned int portid;
-- 
2.27.0




