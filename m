Return-Path: <linux-kselftest+bounces-47800-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E15CD401D
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Dec 2025 13:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88AE1300D41E
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Dec 2025 12:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA9B28468E;
	Sun, 21 Dec 2025 12:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cI+9ZXDL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733A8221282
	for <linux-kselftest@vger.kernel.org>; Sun, 21 Dec 2025 12:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766320019; cv=none; b=Z8rXv8nwFnpy1HYMuwf4F4ogmJRAgaaVdH+ACC5MNgAN5Rib0KOPH7PNSeMnpolkkze7+iziTV/r2N/4l2lzNk9sC34hKsgSgngFlCZlOI5hYTsYOxYCshZrZXL2mf7kiGOyKB2N+jUmQmNxRp8al24m1t/sDlH9Z9lZJMeoGq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766320019; c=relaxed/simple;
	bh=B4sZdJG1t9EctDBIEt1ugcR+phuCjNoMUoxASwFgC4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lIwqiLoIXuQD38TIE7YSUDU3TMpOjACayDi9KE4pBw3Il46ZKlj88UtB9Ja6Mjod6CIgGbJfaY8XRJGcGQL9wtkfa4z5yTuPO8PMVCBpLBqlZfq/HoMgZ2jNbGg+QvgTVYN+I15I7aQG0Q9L4DlwcHb0aYuRSCaa1oX7uLJF0yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cI+9ZXDL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766320016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q/oaz55RIgwHHbP5HbFfkXnPCuvWreBFUWRc63qZ0WQ=;
	b=cI+9ZXDL4NxJbMWCOV0ORfnBzj6rpBjjwM50NcApDvg1IYbwheGn0pRoAHOD3hgmuGwDtr
	/5eUTEHlkQOT9udmOuyf5sA+LatyIKr38fFfMOyNplkeQTdIhkCLtXFZ8vMNwNPj6F7l0L
	vhGYGg7PiiXYaXzHVR6m4aD0ic5U+Jw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-K90Ry8O3Os-k_MrDsuatRA-1; Sun,
 21 Dec 2025 07:26:53 -0500
X-MC-Unique: K90Ry8O3Os-k_MrDsuatRA-1
X-Mimecast-MFC-AGG-ID: K90Ry8O3Os-k_MrDsuatRA_1766320011
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7DC6D1800358;
	Sun, 21 Dec 2025 12:26:51 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9EFE119560B4;
	Sun, 21 Dec 2025 12:26:47 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: akpm@linux-foundation.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: David Hildenbrand <david@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v3 1/3] selftests/mm/write_to_hugetlbfs: parse -s as size_t
Date: Sun, 21 Dec 2025 20:26:37 +0800
Message-ID: <20251221122639.3168038-2-liwang@redhat.com>
In-Reply-To: <20251221122639.3168038-1-liwang@redhat.com>
References: <20251221122639.3168038-1-liwang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

write_to_hugetlbfs currently parses the -s size argument with atoi()
into an int. This silently accepts malformed input, cannot report overflow,
and can truncate large sizes.

--- Error log ---
 # uname -r
 6.12.0-xxx.el10.aarch64+64k

 # ls /sys/kernel/mm/hugepages/hugepages-*
 hugepages-16777216kB/  hugepages-2048kB/  hugepages-524288kB/

 #./charge_reserved_hugetlb.sh -cgroup-v2
 # -----------------------------------------
 ...
 # nr hugepages = 10
 # writing cgroup limit: 5368709120
 # writing reseravation limit: 5368709120
 ...
 # Writing to this path: /mnt/huge/test
 # Writing this size: -1610612736        <--------

Switch the size variable to size_t and parse -s with sscanf("%zu", ...).
Also print the size using %zu.

This avoids incorrect behavior with large -s values and makes the utility
more robust.

Signed-off-by: Li Wang <liwang@redhat.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>
---
 tools/testing/selftests/mm/write_to_hugetlbfs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/write_to_hugetlbfs.c b/tools/testing/selftests/mm/write_to_hugetlbfs.c
index 34c91f7e6128..ecb5f7619960 100644
--- a/tools/testing/selftests/mm/write_to_hugetlbfs.c
+++ b/tools/testing/selftests/mm/write_to_hugetlbfs.c
@@ -68,7 +68,7 @@ int main(int argc, char **argv)
 	int key = 0;
 	int *ptr = NULL;
 	int c = 0;
-	int size = 0;
+	size_t size = 0;
 	char path[256] = "";
 	enum method method = MAX_METHOD;
 	int want_sleep = 0, private = 0;
@@ -86,7 +86,10 @@ int main(int argc, char **argv)
 	while ((c = getopt(argc, argv, "s:p:m:owlrn")) != -1) {
 		switch (c) {
 		case 's':
-			size = atoi(optarg);
+			if (sscanf(optarg, "%zu", &size) != 1) {
+				perror("Invalid -s.");
+				exit_usage();
+			}
 			break;
 		case 'p':
 			strncpy(path, optarg, sizeof(path) - 1);
@@ -131,7 +134,7 @@ int main(int argc, char **argv)
 	}
 
 	if (size != 0) {
-		printf("Writing this size: %d\n", size);
+		printf("Writing this size: %zu\n", size);
 	} else {
 		errno = EINVAL;
 		perror("size not found");
-- 
2.49.0


