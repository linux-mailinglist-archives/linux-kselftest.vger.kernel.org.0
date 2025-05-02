Return-Path: <linux-kselftest+bounces-32144-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC48DAA69BD
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 06:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 843191BC46B7
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 04:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083B419DF66;
	Fri,  2 May 2025 04:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WEn3xYjG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA4A2F2F;
	Fri,  2 May 2025 04:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746159848; cv=none; b=ehgYOXTcznpI4h+kYaUoINtGH4Dg6RDyyEdLmf65jSb/s68LV7WeIraEtlAfEIgVU8YSAP/iNogYIUpHAXmN4Fc3W1wiNpJq9Sv4fIO38yyJw6mxQp+oZZ/dsczNtOt4WsFY/98iZ8aCm9C9PF4dYW7x7MYO+et8I9o2BQrtZM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746159848; c=relaxed/simple;
	bh=xNxMPd9/iT31oaa3P1K08pqMS9oTm3FccWzUvjaDt5k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=arD7CHSuZ8CnHwIHYLwL0O2lL7FXMnBkxzlvXJaqlN7s+MrCbud28aFF6rydVxPcJ25Tz5NUut1kdvcsbbZjUe4AVw9Ev7nNX3I3zOoXLEP8LkMJMIbsSYSp6eqKhjrYxVs/8hNqb3rt/xV64tQ5tp8L68tfHmTaU2Nzn04D/HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WEn3xYjG; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=8InkDp27DC5WPYBCqXZbfAX4HPlXb/a3Sn044Zn5gN0=;
	b=WEn3xYjG4XXTkMCCsLeVm8jVPt80e1PuhxQByP3eIKFdIcTIcy0CcBOQDTaCui
	fCcQ9nGO5h8FNKLsUt064EOCVyFjDr9QS64KSLy5Yrol4MtWvhgKoeG97Axz/Fgk
	ITEXT5jhiBPKoqMnnvbUQRMhZnn6EOdlHPaaqJJbC8Kso=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDn74m1SBRoWmWQDw--.37075S2;
	Fri, 02 May 2025 12:23:18 +0800 (CST)
From: Haiyue Wang <haiyuewa@163.com>
To: netdev@vger.kernel.org
Cc: Haiyue Wang <haiyuewa@163.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	David Wei <dw@davidwei.uk>,
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v1] selftests: iou-zcrx: Clean up build warnings for error format
Date: Fri,  2 May 2025 12:22:20 +0800
Message-ID: <20250502042240.17371-1-haiyuewa@163.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn74m1SBRoWmWQDw--.37075S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw4DKFWDtF13KF47GrWfZrb_yoW8XFy5pa
	s5tw1qkrWrJF17JayDJrWIgFW5Xrs7A3yIkF1UAa4fXrW3AFZ2qF4fKFy0kF9rWrWS93WY
	y3yIkF48AF1UZ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zMWlkUUUUUU=
X-CM-SenderInfo: 5kdl53xhzdqiywtou0bp/1tbiYBBBa2gUQV-PVAAAsj

Clean up two build warnings:

[1]:
iou-zcrx.c: In function ‘process_recvzc’:
iou-zcrx.c:263:37: warning: too many arguments for
  format [-Wformat-extra-args]
  263 |               error(1, 0, "payload mismatch at ", i);
      |                           ^~~~~~~~~~~~~~~~~~~~~~

[2]:
iou-zcrx.c: In function ‘run_client’:
iou-zcrx.c:357:47: warning: format ‘%d’ expects argument of
  type ‘int’, but argument 4 has
  type ‘ssize_t’ {aka ‘long int’} [-Wformat=]
  357 |               error(1, 0, "send(): %d", sent);
      |                                    ~^   ~~~~
      |                                     |   |
      |                                     int ssize_t {aka long int}
      |                                    %ld

Signed-off-by: Haiyue Wang <haiyuewa@163.com>
---
 tools/testing/selftests/drivers/net/hw/iou-zcrx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
index c26b4180eddd..19e1ff45deb4 100644
--- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
+++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
@@ -260,7 +260,7 @@ static void process_recvzc(struct io_uring *ring, struct io_uring_cqe *cqe)
 
 	for (i = 0; i < n; i++) {
 		if (*(data + i) != payload[(received + i)])
-			error(1, 0, "payload mismatch at ", i);
+			error(1, 0, "payload mismatch at %d", i);
 	}
 	received += n;
 
@@ -354,7 +354,7 @@ static void run_client(void)
 		chunk = min_t(ssize_t, cfg_payload_len, to_send);
 		res = send(fd, src, chunk, 0);
 		if (res < 0)
-			error(1, 0, "send(): %d", sent);
+			error(1, 0, "send(): %ld", sent);
 		sent += res;
 		to_send -= res;
 	}
-- 
2.49.0


