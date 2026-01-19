Return-Path: <linux-kselftest+bounces-49320-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0381FD39DE3
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 06:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 861DC3009C13
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 05:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD8D330B01;
	Mon, 19 Jan 2026 05:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GNGA5xyF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBFA330662
	for <linux-kselftest@vger.kernel.org>; Mon, 19 Jan 2026 05:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768801237; cv=none; b=t79exe+QvH2zp3gIS6jo28a6jWeTbz8x4Imup2DOiMPo66i8b1BX+5CSBD4bCH+5q6UMQCDq6MRRr/JEMgoe6KP6ySau1ZMR/q6cyje3ksqeVXOdbMYCAH5FUUEu7Ye/pSpbod9qk+5SH/OKE4dChQgmUZ9ChZYy1fGDLkdD/TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768801237; c=relaxed/simple;
	bh=me4c50WXRR8xB8plkzzqIpolCR7qnDaoGIMH+/D8XeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L74B17k7D2gSkuWZuPx/7tDhEA4vXuuadwoOLTyV+W61CklyfXCUmRQdLGpR3LYKlkCz496ovNi7Bzdo3KU19TW6jbrJKPY2xrcYgAEQaNZkMb9bfovapK8PdbKDvMCFNa+ZGh3Au07eWhqYKNXCxExPOI6P/WFIyWnBslCvHFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GNGA5xyF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768801235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PctFfq/i0IRXmLnYYIwYR3vyYfcgXhxwyeKnIEI44lM=;
	b=GNGA5xyF3poao+P4ySUZr2EOzHbHIX8nSENVBHbW2kYoVTOMSgdHhlrGEmjh4hJj8gY7Al
	Uw6Uj8aI9tLD/gmErSfliVZ8fmwZVXxajolx04sYgerFE4/d6ibDG7dIOKZd2dDreuqVOl
	U0UsqaPJqnhDlqqCmj6CmaZsXrZ7jpw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-xABdwAj9MZCCFoBHMrhdsA-1; Mon,
 19 Jan 2026 00:40:31 -0500
X-MC-Unique: xABdwAj9MZCCFoBHMrhdsA-1
X-Mimecast-MFC-AGG-ID: xABdwAj9MZCCFoBHMrhdsA_1768801230
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E1F591800473;
	Mon, 19 Jan 2026 05:40:29 +0000 (UTC)
Received: from xudu-thinkpadx1carbongen9.nay.csb (unknown [10.72.116.28])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0969B18004D8;
	Mon, 19 Jan 2026 05:40:18 +0000 (UTC)
From: Xu Du <xudu@redhat.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 1/7] selftest: tun: Format tun.c existing code
Date: Mon, 19 Jan 2026 13:39:58 +0800
Message-ID: <0d83416b59dcd5f2f8cdae6a1ca744cc4f3a7ccc.1768800198.git.xudu@redhat.com>
In-Reply-To: <cover.1768800198.git.xudu@redhat.com>
References: <cover.1768800198.git.xudu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

In preparation for adding new tests for GSO over UDP tunnels,
apply consistently the kernel style to the existing code.

Signed-off-by: Xu Du <xudu@redhat.com>
---
 tools/testing/selftests/net/tun.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
index 0efc67b0357a..128b0a5327d4 100644
--- a/tools/testing/selftests/net/tun.c
+++ b/tools/testing/selftests/net/tun.c
@@ -25,7 +25,7 @@ static int tun_attach(int fd, char *dev)
 	strcpy(ifr.ifr_name, dev);
 	ifr.ifr_flags = IFF_ATTACH_QUEUE;
 
-	return ioctl(fd, TUNSETQUEUE, (void *) &ifr);
+	return ioctl(fd, TUNSETQUEUE, (void *)&ifr);
 }
 
 static int tun_detach(int fd, char *dev)
@@ -36,7 +36,7 @@ static int tun_detach(int fd, char *dev)
 	strcpy(ifr.ifr_name, dev);
 	ifr.ifr_flags = IFF_DETACH_QUEUE;
 
-	return ioctl(fd, TUNSETQUEUE, (void *) &ifr);
+	return ioctl(fd, TUNSETQUEUE, (void *)&ifr);
 }
 
 static int tun_alloc(char *dev)
@@ -54,7 +54,7 @@ static int tun_alloc(char *dev)
 	strcpy(ifr.ifr_name, dev);
 	ifr.ifr_flags = IFF_TAP | IFF_NAPI | IFF_MULTI_QUEUE;
 
-	err = ioctl(fd, TUNSETIFF, (void *) &ifr);
+	err = ioctl(fd, TUNSETIFF, (void *)&ifr);
 	if (err < 0) {
 		fprintf(stderr, "can't TUNSETIFF: %s\n", strerror(errno));
 		close(fd);
@@ -67,9 +67,9 @@ static int tun_alloc(char *dev)
 static int tun_delete(char *dev)
 {
 	struct {
-		struct nlmsghdr  nh;
+		struct nlmsghdr nh;
 		struct ifinfomsg ifm;
-		unsigned char    data[64];
+		unsigned char data[64];
 	} req;
 	struct rtattr *rta;
 	int ret, rtnl;
@@ -127,31 +127,36 @@ FIXTURE_TEARDOWN(tun)
 		close(self->fd2);
 }
 
-TEST_F(tun, delete_detach_close) {
+TEST_F(tun, delete_detach_close)
+{
 	EXPECT_EQ(tun_delete(self->ifname), 0);
 	EXPECT_EQ(tun_detach(self->fd, self->ifname), -1);
 	EXPECT_EQ(errno, 22);
 }
 
-TEST_F(tun, detach_delete_close) {
+TEST_F(tun, detach_delete_close)
+{
 	EXPECT_EQ(tun_detach(self->fd, self->ifname), 0);
 	EXPECT_EQ(tun_delete(self->ifname), 0);
 }
 
-TEST_F(tun, detach_close_delete) {
+TEST_F(tun, detach_close_delete)
+{
 	EXPECT_EQ(tun_detach(self->fd, self->ifname), 0);
 	close(self->fd);
 	self->fd = -1;
 	EXPECT_EQ(tun_delete(self->ifname), 0);
 }
 
-TEST_F(tun, reattach_delete_close) {
+TEST_F(tun, reattach_delete_close)
+{
 	EXPECT_EQ(tun_detach(self->fd, self->ifname), 0);
 	EXPECT_EQ(tun_attach(self->fd, self->ifname), 0);
 	EXPECT_EQ(tun_delete(self->ifname), 0);
 }
 
-TEST_F(tun, reattach_close_delete) {
+TEST_F(tun, reattach_close_delete)
+{
 	EXPECT_EQ(tun_detach(self->fd, self->ifname), 0);
 	EXPECT_EQ(tun_attach(self->fd, self->ifname), 0);
 	close(self->fd);
-- 
2.49.0


