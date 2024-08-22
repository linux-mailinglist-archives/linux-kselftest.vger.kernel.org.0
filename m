Return-Path: <linux-kselftest+bounces-16118-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8BA95BD54
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 19:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18317B22321
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 17:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72271CEAD2;
	Thu, 22 Aug 2024 17:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AZRhz2FT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4327A47A60
	for <linux-kselftest@vger.kernel.org>; Thu, 22 Aug 2024 17:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724347895; cv=none; b=HSNU21zi+nyqKwI8eLCZNeF6qjVuvGYcEuljN0pwbucmHU8lGZcEEKqSpINyjZp+LE6dmW7e1gtOoRMrO/XvXxPl1hMHRgg6CocDyT5UhmErzfugj7LYpe5IKtIaKpw5GiBAm2DpjE5NJizlTx10lyYnVCmwP1A0/PocXj9TFr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724347895; c=relaxed/simple;
	bh=SjFhoCwvPABXmT0ob4IoesfdJHdQ49/eTWzzaUUsCZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jhUld8qjdDrGrfPUWsFa8NRnHsmnyiY8eQgh6GrJJ5uVwXVvHeUi2ab/oBc3PA7KE8maspPw9enoHKbrrkgQ09AewtGQCzLYdfF77b42sYCCDpjZpxCnIgLKyA+vc+n9FIp4Wxd5c6aiyNG6aF66yM3+rSOLMrT5EDt39mqOG+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AZRhz2FT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724347893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CVNpDJyXVCWhuewGfxBVKmPR0aHIcDMgy2nP1xmWxjg=;
	b=AZRhz2FTaNtPIcc8++Q7MeMrXPc7VURYwG3OZiXHnItyMCmGxGZk/3uI0cPvNggegQHZgy
	ppFk+KOS2qPdCP0DngfeAkqMot7MoFirC1rdDyrVTqk5llcW1Yy/WgX7n0NTJ7okdBMPP/
	qHP0SxwgcTDgWoIZH5iiUWKF9MmobNA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-78-1vfKKIvhNp-BJPmNy9ct0w-1; Thu,
 22 Aug 2024 13:31:29 -0400
X-MC-Unique: 1vfKKIvhNp-BJPmNy9ct0w-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7D0C61955F45;
	Thu, 22 Aug 2024 17:31:27 +0000 (UTC)
Received: from sullivan-work.redhat.com (unknown [10.22.64.64])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3D0FC1955DA7;
	Thu, 22 Aug 2024 17:31:25 +0000 (UTC)
From: Ryan Sullivan <rysulliv@redhat.com>
To: live-patching@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	shuah@kernel.org,
	rysulliv@redhat.com
Subject: [PATCH] selftests/livepatch: wait for atomic replace to occur
Date: Thu, 22 Aug 2024 13:31:22 -0400
Message-ID: <20240822173122.14760-1-rysulliv@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On some machines with a large number of CPUs there is a sizable delay
between an atomic replace occurring and when sysfs updates accordingly.
This fix uses 'loop_until' to wait for the atomic replace to unload all
previous livepatches.

Signed-off-by: Ryan Sullivan <rysulliv@redhat.com>
---
 tools/testing/selftests/livepatch/test-livepatch.sh | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/livepatch/test-livepatch.sh b/tools/testing/selftests/livepatch/test-livepatch.sh
index 65c9c058458d..bd13257bfdfe 100755
--- a/tools/testing/selftests/livepatch/test-livepatch.sh
+++ b/tools/testing/selftests/livepatch/test-livepatch.sh
@@ -139,11 +139,8 @@ load_lp $MOD_REPLACE replace=1
 grep 'live patched' /proc/cmdline > /dev/kmsg
 grep 'live patched' /proc/meminfo > /dev/kmsg
 
-mods=(/sys/kernel/livepatch/*)
-nmods=${#mods[@]}
-if [ "$nmods" -ne 1 ]; then
-	die "Expecting only one moduled listed, found $nmods"
-fi
+loop_until 'mods=(/sys/kernel/livepatch/*); nmods=${#mods[@]}; [[ "$nmods" -eq 1 ]]' ||
+        die "Expecting only one moduled listed, found $nmods"
 
 # These modules were disabled by the atomic replace
 for mod in $MOD_LIVEPATCH3 $MOD_LIVEPATCH2 $MOD_LIVEPATCH1; do
-- 
2.44.0


