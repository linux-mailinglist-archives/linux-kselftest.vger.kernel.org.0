Return-Path: <linux-kselftest+bounces-48156-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5167FCF1C01
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 04:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 613773015174
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 03:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D02320A09;
	Mon,  5 Jan 2026 03:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GfvHkafS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E57F3164BA
	for <linux-kselftest@vger.kernel.org>; Mon,  5 Jan 2026 03:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767584704; cv=none; b=ZsE6j1mx7f25oy3Vuu/crp9h+l6bDd5u80R54CZQXli0f9dwDrgcO6XZYCAjKUy9qxuy3BbPMFmjodTQGKgP2fBEjAxGZCHCiwe8bpUJWXZYSSwvAW5gmVkQ1JSuwGZ/1V5xpwpHDTid60PyYsOGTS5mnZw2y7zyAPZb0OHEKBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767584704; c=relaxed/simple;
	bh=me4c50WXRR8xB8plkzzqIpolCR7qnDaoGIMH+/D8XeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tt5HCZBncLUKxBufolAOJ4I3rZu5dpNDAW4qXYPCJIIys662dXPBcNcg+nE7eu9+1l1psq9ls3wDHdtZyAnRmGvwhAUt2fh0IB52H4NstJNeYgglqPAQjqeCAVNP5HCpsKy9gl85yQDeg5FNwH7JRrF8Vp29U1wUKUI4XZXDbGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GfvHkafS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767584701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PctFfq/i0IRXmLnYYIwYR3vyYfcgXhxwyeKnIEI44lM=;
	b=GfvHkafSFqQ+kE1Tgby7e/Uutyuhn8fUGJZDrj84uWQdySAfOy+9OqqnMdl1SI8l+WMHHD
	njdLxpVHlA+rLDopIBnY0xZQH2yjFTyYXEDivBWuTZJVnWpZQ1BJqKdTsfcMEp5xnVOYKf
	DLRhdUnlx3SxBw6HlSk6Vyfi5N4YB+o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-G1AVutPTNwCZZ6S2VB2w3w-1; Sun,
 04 Jan 2026 22:44:58 -0500
X-MC-Unique: G1AVutPTNwCZZ6S2VB2w3w-1
X-Mimecast-MFC-AGG-ID: G1AVutPTNwCZZ6S2VB2w3w_1767584696
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 84CC018002E4;
	Mon,  5 Jan 2026 03:44:56 +0000 (UTC)
Received: from xudu-thinkpadx1carbongen9.nay.csb (unknown [10.66.60.72])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 83A2D1800367;
	Mon,  5 Jan 2026 03:44:52 +0000 (UTC)
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
Subject: [PATCH net-next v3 1/8] selftest: tun: Format tun.c existing code
Date: Mon,  5 Jan 2026 11:44:36 +0800
Message-ID: <88df7cbb60af5409daca4c94bf6467c6bc138824.1767580224.git.xudu@redhat.com>
In-Reply-To: <cover.1767580224.git.xudu@redhat.com>
References: <cover.1767580224.git.xudu@redhat.com>
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


