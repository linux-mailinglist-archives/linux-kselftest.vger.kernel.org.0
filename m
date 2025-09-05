Return-Path: <linux-kselftest+bounces-40817-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3112B45302
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 11:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FAB8A008E4
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 09:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372C7288C3B;
	Fri,  5 Sep 2025 09:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fLHupwfb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEE427F18F;
	Fri,  5 Sep 2025 09:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063831; cv=none; b=XKdr0PUhXU04DCMDveO3bDWjr2mADYJUT51f/wptkHAjLXG5Dwh+vm1gvNlH2bbHU1OKc2iSPCYRFaOjivzzAAJxoPh4UM5FXk9ZkpzRnF9fowj8tUT75Er8fIcTcoWr8zKqYmOvGn8lZu0ltYpNEViBEaJAe3DvllZm2neSvN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063831; c=relaxed/simple;
	bh=KSY3m91czW7hUR5rcfgV8N18YncKtBo9HN8ddMK8SE4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Jfterfp0bYaBeWTFyLTn/bw3SLN3wRQIHJD3i16J7iz3AEqjo3crWZED/1CxlLAhkla6s2UlHWfc9wYYovg4DNg9XPtrCSePq4kBsxDUPkQzbF2Jfl8rqcPDqpJZdWfeTssF6t34LDwTuWoOKpCmvRASVXQUOWQdt8OMaoq9XnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fLHupwfb; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Hn
	vGKCDjdY32TtS1Ajpn6Rc0EvA0XXxhpqD6hK+IqKg=; b=fLHupwfbVmi565pmmv
	AJwHER1oKBaA5Pgbt0WCjNiTZadAvzytiyyhc2xWrphQ9Fw/TKOcem9ePCOr9aUF
	M3SrrSERmForldxY/aZj6/IRTMbNQemJFiqEJx6HbOnSJ6FEvDnc6ODrz/ei65wf
	0X5Wr2YE8qrGFBKMsGpYsPF0Q=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDHb36AqrpoKXOAGw--.1903S2;
	Fri, 05 Sep 2025 17:16:50 +0800 (CST)
From: zhouyuhang <zhouyuhang1010@163.com>
To: brauner@kernel.org,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Zhou Yuhang <zhouyuhang@kylinos.cn>
Subject: [PATCH] selftests: pid_namespace: add the missing close()
Date: Fri,  5 Sep 2025 17:16:47 +0800
Message-Id: <20250905091647.1170433-1-zhouyuhang1010@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHb36AqrpoKXOAGw--.1903S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZw4DXFW7CFW8Xw4DGr47CFg_yoW3XrcEv3
	93K3yxJrnxCF92yrn8K3s0gr4rAa1Y9rsxtFyFvw4ayr4xZ3WUGF4qyr1qvFy8WrW5Wrya
	9a1xCry3GFnxXjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8VHq7UUUUU==
X-CM-SenderInfo: 52kr35xxkd0warqriqqrwthudrp/1tbiEQm-Jmi6p3NxggAAs0

From: Zhou Yuhang <zhouyuhang@kylinos.cn>

Add the missing close() in the pid_max_cb() function.

Signed-off-by: Zhou Yuhang <zhouyuhang@kylinos.cn>
---
 tools/testing/selftests/pid_namespace/pid_max.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/pid_namespace/pid_max.c b/tools/testing/selftests/pid_namespace/pid_max.c
index 96f274f0582b..41f8b943bc96 100644
--- a/tools/testing/selftests/pid_namespace/pid_max.c
+++ b/tools/testing/selftests/pid_namespace/pid_max.c
@@ -61,6 +61,7 @@ static int pid_max_cb(void *data)
 	}
 
 	ret = write(fd, "500", sizeof("500") - 1);
+	close(fd);
 	if (ret < 0) {
 		fprintf(stderr, "%m - Failed to write pid_max\n");
 		return -1;
-- 
2.33.0


