Return-Path: <linux-kselftest+bounces-6017-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EDB8742D7
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 23:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 782D1B2145F
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 22:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D2C1CA8D;
	Wed,  6 Mar 2024 22:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gGu/2ds2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4215F1B94D
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Mar 2024 22:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709764690; cv=none; b=gvtAOyF7p+vZkcqeqhyeeGMshYL3yTWcb/pjzFaN0PGQi2I67jXeTnBvkk6qH5TP6PBSB4gKtQ2WD6MU3mgVYvMk7L1q6e/dUdiLJ+fJIHcui3mAAGodbXQj2fKtetGZ7xJISkOpJdX8DOH+LMbW1cvl4HyucPW+p4KyRxluHxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709764690; c=relaxed/simple;
	bh=bChu6j5XyfxlwqKDkEmQzSZQeispuQFA1u1FDbTIYKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ao7YfF/XJw1iBiMPflrk+iDwJYqO7UpNvLFM5tlHybHw3rMCbnkAd4mld7q9JEwGKafb77wbfCwaRVhFcVHjhBInJNqw2NXAqKV2opI+oqV2d1T99iCjn2i/nUU0utfV3pdsLvxBuPAAadUlgCPjfYzrc5+6qW/ErZndN2XSXWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gGu/2ds2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709764688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zDmyGePUUlnnXiKRIxOi1EKt7GfptI6swe//338fxpI=;
	b=gGu/2ds24AOPETDMYgqUUVWb1nO6oPWoP59iGoXWiBuwi07KgMqPmsJv+Plj1ZVgNE+wc1
	zgVW0U2Bafg7Qv97Xu5BbZxj7+9ZakzBK7jE15XMt6hd4iO8rWMGQVTT1zQEaEp6bAMZxE
	KQmOxBujWzUwBnEalv0d57y2ZX7Lu/A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-T2GTcx7CNWKwblB0nSnOpw-1; Wed, 06 Mar 2024 17:38:03 -0500
X-MC-Unique: T2GTcx7CNWKwblB0nSnOpw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4CA50800269;
	Wed,  6 Mar 2024 22:38:03 +0000 (UTC)
Received: from localhost.redhat.com (unknown [10.22.9.120])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BB4D1111D789;
	Wed,  6 Mar 2024 22:38:02 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ben@decadent.org.uk,
	shuah@kernel.org,
	akpm@linux-foundation.org,
	usama.anjum@collabora.com
Subject: [PATCH v2 2/3] selftests/mm: Skip uffd hugetlb tests with insufficient hugepages
Date: Wed,  6 Mar 2024 15:37:13 -0700
Message-ID: <20240306223714.320681-3-npache@redhat.com>
In-Reply-To: <20240306223714.320681-1-npache@redhat.com>
References: <20240306223714.320681-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Now that run_vmtests.sh does not guarantee that the correct hugepage
count is available, add a check inside the userfaultfd hugetlb test to
verify the nr_hugepages count before continuing.

Signed-off-by: Nico Pache <npache@redhat.com>
---
 tools/testing/selftests/mm/uffd-stress.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index 7e83829bbb335..1165446f10883 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -441,6 +441,12 @@ int main(int argc, char **argv)
 	parse_test_type_arg(argv[1]);
 	bytes = atol(argv[2]) * 1024 * 1024;
 
+	if (test_type == TEST_HUGETLB &&
+	   get_free_hugepages() < bytes / page_size) {
+		printf("skip: Skipping userfaultfd... not enough hugepages\n");
+		return KSFT_SKIP;
+	}
+
 	nr_cpus = sysconf(_SC_NPROCESSORS_ONLN);
 
 	nr_pages_per_cpu = bytes / page_size / nr_cpus;
-- 
2.44.0


