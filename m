Return-Path: <linux-kselftest+bounces-47755-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F1ECCCD2DFB
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Dec 2025 12:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 677F53001639
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Dec 2025 11:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084A02D7DDC;
	Sat, 20 Dec 2025 11:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dHHdmXQP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508262D7DC6
	for <linux-kselftest@vger.kernel.org>; Sat, 20 Dec 2025 11:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766229431; cv=none; b=IDNUvtJleAGYsMKAKeOkI8NTwfIGFNgDXLG0wftLRpeqS2yv8HoZ4KcywvrrlFCUL0QsQ8tq0MpwngxbeQEjPIX+CtUnrGxw8llWdq7AfIImp8rGz2Fgg2EPhCCIe+7vq6e9vcTh4rPLgTWtIrvOqCv/DsGwPWyQkQYkDeYd51Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766229431; c=relaxed/simple;
	bh=Ts67dJpg2LQC8V4h7uuHU8YNl9jQ58mTDjPFn9Yicvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TEGlanU7qBD9tfowJZlsZYFhOlhCD+pB1qtNMCxXOd3p72yokeTyZBvAonpGZYdTzu6pBzzMQnu5GXhW+LXigtYbDUv79604Hx/8XFuerlrl6Q8aczKLue1MO8svQoLehYTekfpT52C3SFenkUX4UgPmiTwLy1E4Nu3WLxDLXU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dHHdmXQP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766229429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C5kBTxWJa2eNeFiRt+EFDa1P9P2/qpjVXOHl0w8hecE=;
	b=dHHdmXQPwI5hbOBqxR+MbQkdgG+CE4+KjgB1ii4gM/CgGlvfepbfhV/OdZUVZoI//grlPQ
	84WdVpvAMfBdsBCUGDrwhimWgdIqO5k7IlCXNjbXQrH8W7ndtFA1LeKdm0fzCmXcX0qfuf
	tTQ8mB+ktv7ckP0cOjphjZPrACRycrw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-532-CzDuxXM-PSOh1jjNwt91Iw-1; Sat,
 20 Dec 2025 06:17:03 -0500
X-MC-Unique: CzDuxXM-PSOh1jjNwt91Iw-1
X-Mimecast-MFC-AGG-ID: CzDuxXM-PSOh1jjNwt91Iw_1766229422
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DDA891800358;
	Sat, 20 Dec 2025 11:17:01 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 81BB1180066C;
	Sat, 20 Dec 2025 11:16:53 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: linux-kselftest@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: David Hildenbrand <david@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 1/3] selftests/mm/write_to_hugetlbfs: parse -s with strtoull and use size_t
Date: Sat, 20 Dec 2025 19:16:43 +0800
Message-ID: <20251220111645.2246009-2-liwang@redhat.com>
In-Reply-To: <20251220111645.2246009-1-liwang@redhat.com>
References: <20251220111645.2246009-1-liwang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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

Switch size to size_t and parse -s using strtoull() with proper validation.
Also print the size using %zu.

This makes the test utility more robust and avoids undefined/incorrect
behavior with large or invalid -s values.

Signed-off-by: Li Wang <liwang@redhat.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Waiman Long <longman@redhat.com>
---
 .../testing/selftests/mm/write_to_hugetlbfs.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/write_to_hugetlbfs.c b/tools/testing/selftests/mm/write_to_hugetlbfs.c
index 34c91f7e6128..61f34b35dc27 100644
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
@@ -86,7 +86,20 @@ int main(int argc, char **argv)
 	while ((c = getopt(argc, argv, "s:p:m:owlrn")) != -1) {
 		switch (c) {
 		case 's':
-			size = atoi(optarg);
+			errno = 0;
+			char *end = NULL;
+			unsigned long long tmp = strtoull(optarg, &end, 10);
+			if (errno || end == optarg || *end != '\0') {
+				errno = EINVAL;
+				perror("Invalid -s size");
+				exit_usage();
+			}
+			if (tmp == 0) {
+				errno = EINVAL;
+				perror("size not found");
+				exit_usage();
+			}
+			size = (size_t)tmp;
 			break;
 		case 'p':
 			strncpy(path, optarg, sizeof(path) - 1);
@@ -131,7 +144,7 @@ int main(int argc, char **argv)
 	}
 
 	if (size != 0) {
-		printf("Writing this size: %d\n", size);
+		printf("Writing this size: %zu\n", size);
 	} else {
 		errno = EINVAL;
 		perror("size not found");
-- 
2.49.0


