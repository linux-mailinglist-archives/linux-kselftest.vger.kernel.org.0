Return-Path: <linux-kselftest+bounces-15850-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FCE959BDB
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 14:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45FA4285424
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 12:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5FE18FDC2;
	Wed, 21 Aug 2024 12:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WSrbf4hA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D408916631D
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Aug 2024 12:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724243486; cv=none; b=UbSihV2eg5FrPftjTyEnWcZAntyjWKJF0eCyTwwNFaskigNqXwwxvklgJMJY2g/LAMNQevwzf8Ms/e9JvTmXVXnpgoUBTi6AhN38Xa2/iErfRbDggLm3Q99vwoFXCSP/4xnwouJiTJpHJ2OrXA5QkphZgWi0MqXdGHe5rFzAink=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724243486; c=relaxed/simple;
	bh=ZoUsALWmf9MzmatEp2YvnEjJw8yUdE7sAuAhD31VDW8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VenorO4+NZwkFIGdmRhwvEoBgNhnrZgI6IkcNM8EJRl76wbeFyq6MnBNT/2bcLdr8FEVZLeIydUVNdzDbDSIwS/hB2LpIKiKGSnp3TfK9Ygh/e22fdcihudxo7uU/51nbGYJBP/o7chYpPMc7t6x2O6W5z7Wm+2vonmPnFSWhbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WSrbf4hA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724243483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uTThmUg5wuoJfO3r03jKUAbEQehuHQdGxd4e0MokVn4=;
	b=WSrbf4hA888NAnssJS7pMTvpZMNsBusZdA+XHFJb81g6tVNIGGQFVisurpANxmoaLRoEGa
	89ctaIF2FF3FV0cZg8zK+FGC22aci4Lz/lKqPlSVWVxIdicdFWQdLAikGsKLWaz97YlWyo
	fubh4ndOShkjxftYNhBFM4CdLEP4+9Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-145-TzjHRiQGO-WSsisDXkMm9Q-1; Wed,
 21 Aug 2024 08:31:22 -0400
X-MC-Unique: TzjHRiQGO-WSsisDXkMm9Q-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BF1AA1955BF1;
	Wed, 21 Aug 2024 12:31:20 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.194.120])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2C40E19560AA;
	Wed, 21 Aug 2024 12:31:16 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Mario Casquero <mcasquer@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH v1] selftests/mm: fix charge_reserved_hugetlb.sh test
Date: Wed, 21 Aug 2024 14:31:15 +0200
Message-ID: <20240821123115.2068812-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Currently, running the charge_reserved_hugetlb.sh selftest we can
sometimes observe something like:

  $ ./charge_reserved_hugetlb.sh -cgroup-v2
  ...
  write_result is 0
  After write:
  hugetlb_usage=0
  reserved_usage=10485760
  killing write_to_hugetlbfs
  Received 2.
  Deleting the memory
  Detach failure: Invalid argument
  umount: /mnt/huge: target is busy.

Both cases are issues in the test.

While the unmount error seems to be racy, it will make the test fail:
	$ ./run_vmtests.sh -t hugetlb
	...
	# [FAIL]
	not ok 10 charge_reserved_hugetlb.sh -cgroup-v2 # exit=32

The issue is that we are not waiting for the write_to_hugetlbfs process
to quit. So it might still have a hugetlbfs file open, about which
umount is not happy. Fix that by making "killall" wait for the process
to quit.

The other error ("Detach failure: Invalid argument") does not seem to
result in a test error, but is misleading. Turns out write_to_hugetlbfs.c
unconditionally tries to cleanup using shmdt(), even when we only
mmap()'ed a hugetlb file. Even worse, shmaddr is never even set for the
SHM case. Fix that as well.

With this change it seems to work as expected.

Fixes: 29750f71a9b4 ("hugetlb_cgroup: add hugetlb_cgroup reservation tests")
Reported-by: Mario Casquero <mcasquer@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Mina Almasry <almasrymina@google.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 .../selftests/mm/charge_reserved_hugetlb.sh   |  2 +-
 .../testing/selftests/mm/write_to_hugetlbfs.c | 21 +++++++++++--------
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/mm/charge_reserved_hugetlb.sh b/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
index d680c00d2853a..67df7b47087f0 100755
--- a/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
+++ b/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
@@ -254,7 +254,7 @@ function cleanup_hugetlb_memory() {
   local cgroup="$1"
   if [[ "$(pgrep -f write_to_hugetlbfs)" != "" ]]; then
     echo killing write_to_hugetlbfs
-    killall -2 write_to_hugetlbfs
+    killall -2 --wait write_to_hugetlbfs
     wait_for_hugetlb_memory_to_get_depleted $cgroup
   fi
   set -e
diff --git a/tools/testing/selftests/mm/write_to_hugetlbfs.c b/tools/testing/selftests/mm/write_to_hugetlbfs.c
index 6a2caba19ee1d..1289d311efd70 100644
--- a/tools/testing/selftests/mm/write_to_hugetlbfs.c
+++ b/tools/testing/selftests/mm/write_to_hugetlbfs.c
@@ -28,7 +28,7 @@ enum method {
 
 /* Global variables. */
 static const char *self;
-static char *shmaddr;
+static int *shmaddr;
 static int shmid;
 
 /*
@@ -47,15 +47,17 @@ void sig_handler(int signo)
 {
 	printf("Received %d.\n", signo);
 	if (signo == SIGINT) {
-		printf("Deleting the memory\n");
-		if (shmdt((const void *)shmaddr) != 0) {
-			perror("Detach failure");
+		if (shmaddr) {
+			printf("Deleting the memory\n");
+			if (shmdt((const void *)shmaddr) != 0) {
+				perror("Detach failure");
+				shmctl(shmid, IPC_RMID, NULL);
+				exit(4);
+			}
+
 			shmctl(shmid, IPC_RMID, NULL);
-			exit(4);
+			printf("Done deleting the memory\n");
 		}
-
-		shmctl(shmid, IPC_RMID, NULL);
-		printf("Done deleting the memory\n");
 	}
 	exit(2);
 }
@@ -211,7 +213,8 @@ int main(int argc, char **argv)
 			shmctl(shmid, IPC_RMID, NULL);
 			exit(2);
 		}
-		printf("shmaddr: %p\n", ptr);
+		shmaddr = ptr;
+		printf("shmaddr: %p\n", shmaddr);
 
 		break;
 	default:
-- 
2.46.0


