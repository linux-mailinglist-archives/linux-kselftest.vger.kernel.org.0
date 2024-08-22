Return-Path: <linux-kselftest+bounces-16113-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6ABE95BC0B
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 18:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42F49B21903
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 16:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298651CDA10;
	Thu, 22 Aug 2024 16:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q1haPreO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834A41CDA01
	for <linux-kselftest@vger.kernel.org>; Thu, 22 Aug 2024 16:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724344516; cv=none; b=oEtqB/+bf2V9R+6DLDORuNlvy6oNqHl23VvD4e74kTt23qLw/bbNdFIOqqUFR2+D2F5vj1qFLKonY/6v3vkOUgukGvPDLIW/wgPC0727c6692Oje4DSWkSj7KXYJWUdemurpyEQG9yWvrezOk3/ay7RjKN8URoxcGdipsYv4Ens=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724344516; c=relaxed/simple;
	bh=Lebk5qN72eGWhNem5chnt7+jncvqBTsTYp25kGpywi0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RYzDPeVN7H037wWs04t/tt/rXCS/afn5KV1zn0DufGaYIx4uCNm7DJ0ItgeZa3+uQZuSAl4U4WL4KkMbVziLkYVcShjNWEVQgx+YDcbFiWdC4J5bc9W4oMr/Qi6dMnxSlkyxDIwPvk/y8RRV2l3uWeyZHVmpUnRsyOtJYT7oimM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q1haPreO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724344513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Mz4WO0VMHsLFOra15E3gL77PpNWfgZXNg9SBsXLcZIk=;
	b=Q1haPreOAwmxlCAvEIterQISP5U+pli4LZL9QPz6zRXDBUEMqgqjtc4evOtY7biPj7M4ww
	NRA8twR1XiXfp6q4um3kKYSdCvC7M5qzNtxIblkO1ww0yLGy/mALv+UNRKcw88g92ikmfv
	KQS706J1by+77Pi2L7Zs42U1NE6xq1U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-315-8IlzRdEzPhSlVjwFUYHHuQ-1; Thu,
 22 Aug 2024 12:35:05 -0400
X-MC-Unique: 8IlzRdEzPhSlVjwFUYHHuQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3945B193E8EA;
	Thu, 22 Aug 2024 16:34:46 +0000 (UTC)
Received: from sullivan-work.redhat.com (unknown [10.22.32.213])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C5704300019C;
	Thu, 22 Aug 2024 16:34:43 +0000 (UTC)
From: Ryan Sullivan <rysulliv@redhat.com>
To: live-patching@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	shuah@kernel.org
Subject: [PATCH] selftests/livepatch: wait for atomic replace to occur
Date: Thu, 22 Aug 2024 12:34:39 -0400
Message-ID: <20240822163439.13092-1-rysulliv@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Uses 'loop_until' to wait for the atomic replace to unload all previous
livepatches, as on some machines with a large number of CPUs there is a
sizable delay between the atomic replace ocurring and when sysfs
updates accordingly.

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


