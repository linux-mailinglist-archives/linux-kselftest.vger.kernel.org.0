Return-Path: <linux-kselftest+bounces-32211-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40464AA78DF
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 19:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B94331C04926
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 17:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF943265608;
	Fri,  2 May 2025 17:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mgMH1XMC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9709326156E;
	Fri,  2 May 2025 17:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746208447; cv=none; b=LglPAjC4NnO8RC9OxUT0L8VahT539LC4W/YOM+Soyp6lMMO947ErRGZJWygaSQUdah+YqHheymwpvaDZKpdNv98vUI60h8XhAMb/96YXYHCgu5xC+o9Kbjw7M9OXm7Z8+YX76jhCeS2C0tA2aZnmz8CjTjgo9MSVP0CjXfPPDmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746208447; c=relaxed/simple;
	bh=hePHbVanD/Qw8nmeoKE942pxIMTBlEDYcl2/QM1nNgw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iHu0Ibfg4Zo0BvuHZ/Iz/xGBXcfG7/nxmw823bz/ZRHnGOD1SJJynYruBcKOq5FevvC8dmCr44onlNRoHCPBsCITzVISH0MAv9nqWTk44jVBDqasWBeQuw+fqhC7DONa+s523+zMeEF+ypVDMTfd81bAr76fkd91TME3bA2mA/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mgMH1XMC; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=QLqkgEezk574VjARrudTaygkXXsebma6evZNIZRrqPU=;
	b=mgMH1XMCk9w/pj09yc7XKp3lSxugVw/UaPO6gp9Qctkamjbr2RmqI1IKhwpKc7
	qK9N8PwW3gf2/weJJRqjVOSSn0LuO1lBbi/rsOww3ElqBefOZeAoDR5eYNNglrVm
	gciya0x4HqxLNJifnwEOjauwjOnQnK36GY9UMYTh3IePI=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDHWWRNBhVoolSMEA--.14240S2;
	Sat, 03 May 2025 01:52:14 +0800 (CST)
From: Haiyue Wang <haiyuewa@163.com>
To: netdev@vger.kernel.org
Cc: Haiyue Wang <haiyuewa@163.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	David Wei <dw@davidwei.uk>,
	Jens Axboe <axboe@kernel.dk>,
	Simon Horman <horms@kernel.org>,
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v2] selftests: iou-zcrx: Clean up build warnings for error format
Date: Sat,  3 May 2025 01:50:25 +0800
Message-ID: <20250502175136.1122-1-haiyuewa@163.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHWWRNBhVoolSMEA--.14240S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFy5Ww17uFy3Ar18KF1UAwb_yoW8CF1kpa
	4ktw1qkrWrJF17GayUGrWfKFWUXrsFy3yIkr1UAa4aqFW3AFWvqrWfKFy0kFyDWrWS93WY
	yrZFkF45AF1jv3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zMWlkUUUUUU=
X-CM-SenderInfo: 5kdl53xhzdqiywtou0bp/1tbiYBNBa2gU-ku4OgAAsS

Clean up two build warnings:

[1]

iou-zcrx.c: In function ‘process_recvzc’:
iou-zcrx.c:263:37: warning: too many arguments for format [-Wformat-extra-args]
  263 |                         error(1, 0, "payload mismatch at ", i);
      |                                     ^~~~~~~~~~~~~~~~~~~~~~

[2] Use "%zd" for ssize_t type as better

iou-zcrx.c: In function ‘run_client’:
iou-zcrx.c:357:47: warning: format ‘%d’ expects argument of type ‘int’, but argument 4 has type ‘ssize_t’ {aka ‘long int’} [-Wformat=]
  357 |                         error(1, 0, "send(): %d", sent);
      |                                              ~^   ~~~~
      |                                               |   |
      |                                               int ssize_t {aka long int}
      |                                              %ld

Signed-off-by: Haiyue Wang <haiyuewa@163.com>
---
v2:
  - Dont't wrap the build warning message to make scripts/checkpatch.pl happy,
    keep it as for readability.
  - Change the format for ssize_t from "%ld" to "%zd" as Simon suggested.
  - Change the target to net-next tree.
v1: https://lore.kernel.org/netdev/20250502042240.17371-1-haiyuewa@163.com/
---
 tools/testing/selftests/drivers/net/hw/iou-zcrx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
index 8aa426014c87..62456df947bc 100644
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
+			error(1, 0, "send(): %zd", sent);
 		sent += res;
 		to_send -= res;
 	}
-- 
2.49.0


