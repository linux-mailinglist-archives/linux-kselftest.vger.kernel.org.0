Return-Path: <linux-kselftest+bounces-40393-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 602B2B3D904
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 07:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA91F3BB76F
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 05:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D9823D7F0;
	Mon,  1 Sep 2025 05:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="m+Y48VMk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98536145355;
	Mon,  1 Sep 2025 05:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756705631; cv=none; b=Jlv+3QJZpKM3ISYW3ZeHcH4mFotODTvII9rhiFPZlsOBm4HiLwMGhw49sOfMw0czP+zzPUxLrUKaZ/NXQ/Tbdkcl4KyVhODA4t64yuhd1HicZxHxk2AxELEEl69qUEjDjjphYUMr5EUcPktTYowlR2ZsUuMjT2BhzwQFkKu1CoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756705631; c=relaxed/simple;
	bh=p2YwKn1uWr8JFJ6dvzsKi+Ai+re4eghtL2UZZHVDuUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HonDjq6LfhK4hQW/7AFxdAGPNJZR5b++A7IA3z9Y0dFP1BebVIgy1pg1kiIUPV98526byCJ0tyrg5RkVhYIN9D1J7CsbfWv3XFtKrSyo/Rxx1JBk1GbTXLMM0nJhq5/bIEnb/BAGQmLRqpyAhwYOKGMDL/1UZJsTOeSorXJWzNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=m+Y48VMk; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=s4
	nzgbEshNl3izTVy/ttU4qOpJei9HBJMzHxZa30VA4=; b=m+Y48VMkkRPA/KvgfW
	1orPJfBCFmZhkP2+cMW6f4CFXKY75ndJGi/Xls0S9ElSYeTrH9J5GYIbDukK6OnV
	uIBck4Akqgp3NpkWchYWXqya9Q454hPXylv560VHSVV4nrY/FTfqZzjUFghyrWnm
	2HNl7DLigwQ+rjdOlvvSNqVhc=
Received: from thinkpadx13gen2i.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDX98EYM7Vo9LrPFw--.40947S2;
	Mon, 01 Sep 2025 13:46:02 +0800 (CST)
From: Zongmin Zhou <min_halo@163.com>
To: kuba@kernel.org,
	horms@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	Zongmin Zhou <zhouzongmin@kylinos.cn>
Subject: [PATCH v3] selftests: net: avoid memory leak
Date: Mon,  1 Sep 2025 13:45:57 +0800
Message-Id: <20250901054557.32811-1-min_halo@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250829191537.4618f815@kernel.org>
References: <20250829191537.4618f815@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDX98EYM7Vo9LrPFw--.40947S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF4xuw1kCF18Cr48Kw17ZFb_yoW8XryrpF
	WxGw1fKr48Ca17JFs8KrsYgF4Ykws3tF48ur17tr1kAw15Jr9Yqr4fKF48tFnFgrZ2qwnx
	ZF9xu3WY9a18J3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07USiigUUUUU=
X-CM-SenderInfo: pplqsxxdorqiywtou0bp/xtbBzQK7q2i1KxbD7gAAsS

From: Zongmin Zhou <zhouzongmin@kylinos.cn>

The buffer be used without free,fix it to avoid memory leak.

Signed-off-by: Zongmin Zhou <zhouzongmin@kylinos.cn>
---
Changes in v3:
- move freeaddrinfo() to a separate label.
Changes in v2:
- add the label to use instead of directly to use on each case.
---
 tools/testing/selftests/net/cmsg_sender.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/cmsg_sender.c b/tools/testing/selftests/net/cmsg_sender.c
index a825e628aee7..ded9b925865e 100644
--- a/tools/testing/selftests/net/cmsg_sender.c
+++ b/tools/testing/selftests/net/cmsg_sender.c
@@ -491,7 +491,8 @@ int main(int argc, char *argv[])
 	if (err) {
 		fprintf(stderr, "Can't resolve address [%s]:%s\n",
 			opt.host, opt.service);
-		return ERN_SOCK_CREATE;
+		err = ERN_SOCK_CREATE;
+		goto err_free_buff;
 	}
 
 	if (ai->ai_family == AF_INET6 && opt.sock.proto == IPPROTO_ICMP)
@@ -500,8 +501,8 @@ int main(int argc, char *argv[])
 	fd = socket(ai->ai_family, opt.sock.type, opt.sock.proto);
 	if (fd < 0) {
 		fprintf(stderr, "Can't open socket: %s\n", strerror(errno));
-		freeaddrinfo(ai);
-		return ERN_RESOLVE;
+		err = ERN_RESOLVE;
+		goto err_free_info;
 	}
 
 	if (opt.sock.proto == IPPROTO_ICMP) {
@@ -574,6 +575,9 @@ int main(int argc, char *argv[])
 
 err_out:
 	close(fd);
+err_free_info:
 	freeaddrinfo(ai);
+err_free_buff:
+	free(buf);
 	return err;
 }
-- 
2.34.1


