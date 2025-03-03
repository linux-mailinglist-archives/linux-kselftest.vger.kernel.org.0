Return-Path: <linux-kselftest+bounces-28036-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66848A4C08F
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 13:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E19313AACBD
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 12:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE28620E6E3;
	Mon,  3 Mar 2025 12:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IYXKli66"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F7D20E332
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Mar 2025 12:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741005830; cv=none; b=hZoyNrncIE/tiKnxIqyQ37tSbO35BR3yLZmPRkxZH0Yiu9m2RapbgTCzzIhS8n19W+XlEpLbYWSumnoCVZ70Apq+z5OJq5+0sdT5XKlec+fgqqJCACD+Q4sQ1dNka9SZmtUDesMwy3aAie1L9HAOjf3o/CNsIfufkvaPjxeXWlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741005830; c=relaxed/simple;
	bh=R/UbvFQKhkE48f7V8KwpGE3Rvfnp+1NUFq5fmOTIqUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sCRjYqVDSTfxMY6IUIzCWXKNLcdhjM0sHlAFbPcvU8LygiwOqEekZMPg0L6VrulpYKxBl8ALlKxTQRCUF4HovmHdrJHHnStJ4j0TQ0OhBdf42UgPFMVQlIRmAC9O3l3icLJbXIP5RWxhQ+XXkf4Asa4ZS4bP9ussIXkvkMGg2c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IYXKli66; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741005827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NJxJXtg79V4txmYV9tJrHZcZ/bDrEyIKMG5SvuG1GoQ=;
	b=IYXKli66hLiyy/0qBX45tpXlft5ZkDz9tYLkh7UvzDq5pGtgUspXYA4G0YU8w2yzx7y3lk
	xsseYVHWJLooiP9611KjhMZ8GUBcoPwxSghi8OHiCJaK1l9joJ5AqHpaNjrf1/mwc8pKRn
	jOXp2+1M+9gMyBSM6V11WE1rhN3lav8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-0WjyWbN-PU2fv6HMQHDRQg-1; Mon,
 03 Mar 2025 07:43:44 -0500
X-MC-Unique: 0WjyWbN-PU2fv6HMQHDRQg-1
X-Mimecast-MFC-AGG-ID: 0WjyWbN-PU2fv6HMQHDRQg_1741005823
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4DE40190ECCB;
	Mon,  3 Mar 2025 12:43:43 +0000 (UTC)
Received: from localhost (unknown [10.72.120.23])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ED7961956094;
	Mon,  3 Mar 2025 12:43:41 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 01/11] selftests: ublk: make ublk_stop_io_daemon() more reliable
Date: Mon,  3 Mar 2025 20:43:11 +0800
Message-ID: <20250303124324.3563605-2-ming.lei@redhat.com>
In-Reply-To: <20250303124324.3563605-1-ming.lei@redhat.com>
References: <20250303124324.3563605-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Improve ublk_stop_io_daemon() in the following ways:

- don't wait if ->ublksrv_pid becomes -1, which means that the disk
has been stopped

- don't wait if ublk char device doesn't exist any more, so we can
avoid to rely on inoitfy for wait until the char device is closed

And this way may reduce time of delete command a lot.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/kublk.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index b65bdaf7e281..2072d880fdc4 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -691,13 +691,14 @@ static int ublk_start_daemon(const struct dev_ctx *ctx, struct ublk_dev *dev)
 	return ret;
 }
 
-static int wait_ublk_dev(char *dev_name, int evt_mask, unsigned timeout)
+static int wait_ublk_dev(const char *path, int evt_mask, unsigned timeout)
 {
 #define EV_SIZE (sizeof(struct inotify_event))
 #define EV_BUF_LEN (128 * (EV_SIZE + 16))
 	struct pollfd pfd;
 	int fd, wd;
 	int ret = -EINVAL;
+	const char *dev_name = basename(path);
 
 	fd = inotify_init();
 	if (fd < 0) {
@@ -761,18 +762,23 @@ static int ublk_stop_io_daemon(const struct ublk_dev *dev)
 	char ublkc[64];
 	int ret = 0;
 
+	if (daemon_pid < 0)
+		return 0;
+
 	/* daemon may be dead already */
 	if (kill(daemon_pid, 0) < 0)
 		goto wait;
 
-	/*
-	 * Wait until ublk char device is closed, when our daemon is shutdown
-	 */
-	snprintf(ublkc, sizeof(ublkc), "%s%d", "ublkc", dev_id);
-	ret = wait_ublk_dev(ublkc, IN_CLOSE_WRITE, 10);
-	/* double check and inotify may not be 100% reliable */
+	snprintf(ublkc, sizeof(ublkc), "/dev/%s%d", "ublkc", dev_id);
+
+	/* ublk char device may be gone already */
+	if (access(ublkc, F_OK) != 0)
+		goto wait;
+
+	/* Wait until ublk char device is closed, when the daemon is shutdown */
+	ret = wait_ublk_dev(ublkc, IN_CLOSE, 10);
+	/* double check and since it may be closed before starting inotify */
 	if (ret == -ETIMEDOUT)
-		/* the daemon doesn't exist now if kill(0) fails */
 		ret = kill(daemon_pid, 0) < 0;
 wait:
 	waitpid(daemon_pid, NULL, 0);
@@ -910,8 +916,6 @@ static int __cmd_dev_del(struct dev_ctx *ctx)
 				__func__, dev->dev_info.ublksrv_pid, number, ret);
 	ublk_ctrl_del_dev(dev);
 fail:
-	if (ret >= 0)
-		ret = ublk_ctrl_get_info(dev);
 	ublk_ctrl_deinit(dev);
 
 	return (ret >= 0) ? 0 : ret;
-- 
2.47.0


