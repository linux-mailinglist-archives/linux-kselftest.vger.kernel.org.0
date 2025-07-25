Return-Path: <linux-kselftest+bounces-37981-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9639AB11A78
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 11:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF57D1C26408
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 09:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7661F263C8E;
	Fri, 25 Jul 2025 09:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="dJA0i6wW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02E925C6F1;
	Fri, 25 Jul 2025 09:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753434265; cv=none; b=saKkiuEaF/lY/FwzcS2ilLANLCXShQrVGLDp4BjpP1gorn9Qz1uFF152Ar3ENqsPVQm743SDyGIZNqivH+NGqoQhHrRqUjMrNFP5xrRLLy59kFqZ+PCgRhL93tQY2qRJQ+PGtRFZqM/c2qFapNNZOtZIPLG3GuDuM8ug08hJvvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753434265; c=relaxed/simple;
	bh=2vK5BT3n45WPMmhVShfBIpOHAZmNBa8oQfQIWwgnDnc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BpmoTByySA2/CXaU64jrrlR5RWceHgy4eBnXJKsoHyLH2H1swnCVYlf6rXZ0IImE6WABllIvaN0S6PSi49TSjsOIZfELQF7t2GloPOYbqKFc0dN4Wr9h+dlim1vQ2zkPlPcfGRD3uTJ4KHAPxavO5MNZIjzGSy1jU6OWzVKdOZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=dJA0i6wW; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753434260; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=eN//XrOgIiMJ4cJ4q9KM3KZ8hQkRIaBCYzaIEi6dQ70=;
	b=dJA0i6wWw8EnYIG6vMOI8UgTIjA3xvq+VnqUfSdhJD0DE35Ul3B9E48lmZSyQXgM1EPUyIBagrjaEcEN83rAkSNUGNgJtidrK/0o2c53s44Kxh7LX+tppWtd4Gz1EXT8FBHQNvrEGVltuWjPqyO+LFAB3VkcQqIJHJbkB1Cjq9A=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WjxEkD9_1753434254 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 25 Jul 2025 17:04:19 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: tj@kernel.org
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	shuah@kernel.org,
	sched-ext@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] selftests/sched_ext: Remove duplicate sched.h header
Date: Fri, 25 Jul 2025 17:04:12 +0800
Message-ID: <20250725090412.2040782-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

./tools/testing/selftests/sched_ext/hotplug.c: sched.h is included more than once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=22941
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 tools/testing/selftests/sched_ext/hotplug.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/sched_ext/hotplug.c b/tools/testing/selftests/sched_ext/hotplug.c
index 1c9ceb661c43..0cfbb111a2d0 100644
--- a/tools/testing/selftests/sched_ext/hotplug.c
+++ b/tools/testing/selftests/sched_ext/hotplug.c
@@ -6,7 +6,6 @@
 #include <bpf/bpf.h>
 #include <sched.h>
 #include <scx/common.h>
-#include <sched.h>
 #include <sys/wait.h>
 #include <unistd.h>
 
-- 
2.43.5


