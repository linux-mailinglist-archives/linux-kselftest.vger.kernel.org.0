Return-Path: <linux-kselftest+bounces-39899-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEECB35221
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 05:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F017681019
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 03:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390951C5F13;
	Tue, 26 Aug 2025 03:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Wmt6NYM1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A5F111BF;
	Tue, 26 Aug 2025 03:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756178182; cv=none; b=ohmHjzvEWHa1n/jH2vn1/cMQYQ0naOkl66knQ3Wjr2vRToVxcbVaDzR04QITlshQ9zPljQxxVotgUZJYAlAkCoQeLCA4IQNgFfkG+Dw/5+S8c52CKeDhoj/y5psXRETGAch74BMZS+AVVZ/BsCpcQ67IhzdFROAxvJ9cjsodrMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756178182; c=relaxed/simple;
	bh=9zT4hWxS3/93eiB1fYlXIG8klRDOKyVmSADjtbJ/Sog=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Dtooxv1mcL5ioOtPZ1RvjUC7TQWU2Wmx3WhtAOsuGmfvHh8HAHpZrWsqZAgxbyDVIjm45zAOPo7ecWwuav8aMPizHjp5PqjIZnrXnL6Wbc3Xu2dv+SePQ+SplkJuPwn/8euzo7n+CD9DJCQvXK/6bEyuJRj/4Wptk0XC4xjT+xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Wmt6NYM1; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=/u
	/MkC1hJIU5or58FyCsCRK1iVr+/aJ7pfuUQnsJ8uk=; b=Wmt6NYM1HTPl1oKM1r
	edp2Q2YLqFRVYCJL9eFXeVswve1UACtDQl4Ib/uF04MrGjXyuICyuyJFgKddn9Sj
	AZwFAFbJqdHDtrAq+ukeTFgdWkuZ/QEP9HN0NpD4bfaMbE4cgcdELqjn0xi+YjEQ
	48vdC5SuIf/MJnVXGRTtdFLt8=
Received: from thinkpadx13gen2i.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgC3aQveJq1oOSNvAg--.56318S2;
	Tue, 26 Aug 2025 11:15:43 +0800 (CST)
From: Zongmin Zhou <min_halo@163.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zongmin Zhou <zhouzongmin@kylinos.cn>
Subject: [PATCH] selftests: net: avoid memory leak
Date: Tue, 26 Aug 2025 11:15:40 +0800
Message-Id: <20250826031540.28010-1-min_halo@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgC3aQveJq1oOSNvAg--.56318S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFWktF15uF18Cw1fGFy8Zrb_yoWDCFXE9r
	Z2vFZ7Gr4vyF1qk3sFg3s5ur93Ka98Crs7JFnrJa13K34jqay5GFZ7C34kAFn3Wan5ta43
	Z3WfArZ3C3yj9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUj_-P5UUUUU==
X-CM-SenderInfo: pplqsxxdorqiywtou0bp/xtbBzQu1q2itImCIgAAAsX

From: Zongmin Zhou <zhouzongmin@kylinos.cn>

The buffer be used without free,fix it to avoid memory leak.

Signed-off-by: Zongmin Zhou <zhouzongmin@kylinos.cn>
---
 tools/testing/selftests/net/cmsg_sender.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/net/cmsg_sender.c b/tools/testing/selftests/net/cmsg_sender.c
index a825e628aee7..5358aa09ecb9 100644
--- a/tools/testing/selftests/net/cmsg_sender.c
+++ b/tools/testing/selftests/net/cmsg_sender.c
@@ -491,6 +491,7 @@ int main(int argc, char *argv[])
 	if (err) {
 		fprintf(stderr, "Can't resolve address [%s]:%s\n",
 			opt.host, opt.service);
+		free(buf);
 		return ERN_SOCK_CREATE;
 	}
 
@@ -501,6 +502,7 @@ int main(int argc, char *argv[])
 	if (fd < 0) {
 		fprintf(stderr, "Can't open socket: %s\n", strerror(errno));
 		freeaddrinfo(ai);
+		free(buf);
 		return ERN_RESOLVE;
 	}
 
@@ -575,5 +577,6 @@ int main(int argc, char *argv[])
 err_out:
 	close(fd);
 	freeaddrinfo(ai);
+	free(buf);
 	return err;
 }
-- 
2.34.1


