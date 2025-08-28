Return-Path: <linux-kselftest+bounces-40135-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BEDB39166
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 04:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1807F682ADF
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 02:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274C12236EE;
	Thu, 28 Aug 2025 02:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pZfbwDAf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5530E6FC5;
	Thu, 28 Aug 2025 02:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756346564; cv=none; b=cHc8ZTMInJAb9mCelQHnQwAM3N3Iro+FhsQ95ckwrc9u96VS1vNPcZeqReQHgmkogHTkBnHYdt3cU5EDVvWEL8PmPUwTQQxNk8tqj0x8vZn2jVyLQ3cH/KBj5v5wTp+cm3JZvw3vyFqfe3QivYz4xJbaVGGktzPDFsP5swx7fLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756346564; c=relaxed/simple;
	bh=K+BvfHQ6GZvUzePGxTv1JATYJz5TFKaeSY5EJziNkPA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bG5L8G2j5MUYbtg3zzDzNFrOIjQsJEZ1qgsgxvszHGTqPhTY+Xfw9iJqDKpqrxIakTNavUrSew1xlg2wr+/hM/47oPmNLDCjnMj7MIsGe5mdZh23lAUBxQRPVL0TkmpHNyqR2s6PATCaxvtkE+lbLY1tlCMba5iliVZPqDaab0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pZfbwDAf; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=HH
	aZaXSsQmUrUGFer1hYYAyBe53nx4+hk+JxbYQnGQo=; b=pZfbwDAf1uOSgD9kOs
	7uXZ3whjN5RsCu1xC9aCWzHtd9dNqLONgWKQrFD+Ds/wtQmfWOfJJTqlP2PsWJF+
	Ypgs2Z8E0O88yQB0yMaq9agOUGPbXmrZMoAVsmthciVIj5PuhIcJUu8f1U9gs+2D
	VBEc/72aKY2HVkM3/g6EIFg68=
Received: from thinkpadx13gen2i.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDHXVakuK9o58F6EQ--.39153S2;
	Thu, 28 Aug 2025 10:02:13 +0800 (CST)
From: Zongmin Zhou <min_halo@163.com>
To: horms@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	Zongmin Zhou <zhouzongmin@kylinos.cn>
Subject: [PATCH v2] selftests: net: avoid memory leak
Date: Thu, 28 Aug 2025 10:02:10 +0800
Message-Id: <20250828020210.25475-1-min_halo@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250827161230.GB10519@horms.kernel.org>
References: <20250827161230.GB10519@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHXVakuK9o58F6EQ--.39153S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr4xXFW3trWrXrWrArW8JFb_yoW8Gr15pa
	yI9w1fKr48Ka17JFs8trsYgF4YkwsayF409F17Jrn5Awn8Jr9Yqr4fKF45KF12grZ2qwnx
	ZF9xuF1Y9an5J3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U6CJdUUUUU=
X-CM-SenderInfo: pplqsxxdorqiywtou0bp/xtbBzRe3q2ivtepWZAAAss

From: Zongmin Zhou <zhouzongmin@kylinos.cn>

The buffer be used without free,fix it to avoid memory leak.

Signed-off-by: Zongmin Zhou <zhouzongmin@kylinos.cn>
---
Changes in v2:
- add the label to use instead of directly to use on each case.
---
 tools/testing/selftests/net/cmsg_sender.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/cmsg_sender.c b/tools/testing/selftests/net/cmsg_sender.c
index a825e628aee7..71984e0a44e2 100644
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
@@ -501,7 +502,8 @@ int main(int argc, char *argv[])
 	if (fd < 0) {
 		fprintf(stderr, "Can't open socket: %s\n", strerror(errno));
 		freeaddrinfo(ai);
-		return ERN_RESOLVE;
+		err = ERN_RESOLVE;
+		goto err_free_buff;
 	}
 
 	if (opt.sock.proto == IPPROTO_ICMP) {
@@ -575,5 +577,7 @@ int main(int argc, char *argv[])
 err_out:
 	close(fd);
 	freeaddrinfo(ai);
+err_free_buff:
+	free(buf);
 	return err;
 }
-- 
2.34.1


