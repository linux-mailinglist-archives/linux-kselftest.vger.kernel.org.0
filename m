Return-Path: <linux-kselftest+bounces-42947-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A850FBCCDD1
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Oct 2025 14:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4BC219E33F6
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Oct 2025 12:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354A8288502;
	Fri, 10 Oct 2025 12:23:55 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA63215077;
	Fri, 10 Oct 2025 12:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760099035; cv=none; b=EHNNnjBVa6ayjQF44CqILmx7A0iVGcAhyGMYEkmhqThd5K2MJaUuoPW+Lqk9JEP3yeEh++S2QMjL5kjqad47k9eDA6TnPFpmtztktT9rOhBRh1RaJqWwTjzqDMRQbNaNcj644Wxp9fGukwyGuEQEIePQ7iaCBbKXCubx+x/v0ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760099035; c=relaxed/simple;
	bh=OWWKf/RfcqcJXFkAF6wIhsxL2svDUszCwwbQkpiQ2Wo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oJ5cj6Q09h7+KmSUoEWzZDPRpdZq7v4Jbl7azevoZ44ALaWpE1kako8i9BybtHDvySi2O9gMjY+Tjs/lVS7/4uSRIP18pE0UbxODb4XDgZA2wwi9UZ1m5Wkxl7ulP4POPYgEUjRqvQ9SUfEgL001006hKDY7GxkPEOkapJAV2y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: Fushuai Wang <wangfushuai@baidu.com>
To: <jpoimboe@kernel.org>, <jikos@kernel.org>, <mbenes@suse.cz>,
	<pmladek@suse.com>, <joe.lawrence@redhat.com>, <shuah@kernel.org>
CC: <live-patching@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Fushuai Wang <wangfushuai@baidu.com>
Subject: [PATCH] selftests: livepatch: use canonical ftrace path
Date: Fri, 10 Oct 2025 20:07:27 +0800
Message-ID: <20251010120727.20631-1-wangfushuai@baidu.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc8.internal.baidu.com (172.31.50.52) To
 bjkjy-exc17.internal.baidu.com (172.31.50.13)
X-FEAS-Client-IP: 172.31.50.13
X-FE-Policy-ID: 52:10:53:SYSTEM

Since v4.1 kernel, a new interface for ftrace called "tracefs" was
introduced, which is usually mounted in /sys/kernel/tracing. Therefore,
tracing files can now be accessed via either the legacy path
/sys/kernel/debug/tracing or the newer path /sys/kernel/tracing.

Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
---
 tools/testing/selftests/livepatch/functions.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
index 46991a029f7c..8ec0cb64ad94 100644
--- a/tools/testing/selftests/livepatch/functions.sh
+++ b/tools/testing/selftests/livepatch/functions.sh
@@ -10,7 +10,11 @@ SYSFS_KERNEL_DIR="/sys/kernel"
 SYSFS_KLP_DIR="$SYSFS_KERNEL_DIR/livepatch"
 SYSFS_DEBUG_DIR="$SYSFS_KERNEL_DIR/debug"
 SYSFS_KPROBES_DIR="$SYSFS_DEBUG_DIR/kprobes"
-SYSFS_TRACING_DIR="$SYSFS_DEBUG_DIR/tracing"
+if [[ -e /sys/kernel/tracing/trace ]]; then
+	SYSFS_TRACING_DIR="$SYSFS_KERNEL_DIR/tracing"
+else
+	SYSFS_TRACING_DIR="$SYSFS_DEBUG_DIR/tracing"
+fi
 
 # Kselftest framework requirement - SKIP code is 4
 ksft_skip=4
-- 
2.36.1


