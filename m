Return-Path: <linux-kselftest+bounces-47754-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A73CD2DF8
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Dec 2025 12:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4ABC3014625
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Dec 2025 11:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BDA2E1730;
	Sat, 20 Dec 2025 11:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b3IHy167"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDA76F2F2
	for <linux-kselftest@vger.kernel.org>; Sat, 20 Dec 2025 11:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766229421; cv=none; b=LFIr24gvjMUEilp5dx4QjjtfsBDX3lGe1+PcJnpofU0Iw/pwmTmpISQGu7tpKbOzWm7PfiIKidwJkSzb720dvGhtLffRm2T9Be6H6IMnqU1Oly/TI4eqZCudcqd84EeFzjKrq9j2ozSwgckaPELbLGZu47Khh3b5S84W1n9k1gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766229421; c=relaxed/simple;
	bh=HRi6jjM24NDP0E3FsnA3XQWOJfQ2bA6tblKILhzyWK8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DhWjadSdsX8gYbwLkc2OiJ+kN8ZP0SIci9XwilegCP33xvJ+QAOnm2xRqrTGZTIitaPux4qDrKDfEu3fBa+EpuowPczjspF0y9f58FkKKFrMr+32A4SjHOIi433KQ7NV6KP+qINpojA7acRiFxzRd58VE1InNw/c+qOab1w92MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b3IHy167; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766229418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Rmi9edjl2rxC9XwkctLUMSZhJN2qqQfsLmWqIRP2Jzc=;
	b=b3IHy167BALOFkJHlNqy8FurZs7Wfp0HgoP9y09vGRk81z623zgvFytmuErTdwUqn1PRfc
	9P4UEAkxmr16BRdIdnQxz0mqZ6CrSEgKRX+W22nKK4tMJbjBw4yd0g/1Td9B4y41oBu6Mb
	N4e1JwF0/DY4KXnmwu+drONkMT6vRTI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-414-CvNoNfvlOYWxsHuC7xC1pg-1; Sat,
 20 Dec 2025 06:16:54 -0500
X-MC-Unique: CvNoNfvlOYWxsHuC7xC1pg-1
X-Mimecast-MFC-AGG-ID: CvNoNfvlOYWxsHuC7xC1pg_1766229413
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CB660195605B;
	Sat, 20 Dec 2025 11:16:52 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7FD09180035A;
	Sat, 20 Dec 2025 11:16:50 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: linux-kselftest@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/3] selftests/mm: hugetlb cgroup charging: robustness fixes
Date: Sat, 20 Dec 2025 19:16:42 +0800
Message-ID: <20251220111645.2246009-1-liwang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

This series fixes a few issues in the hugetlb cgroup charging selftests
(write_to_hugetlbfs.c + charge_reserved_hugetlb.sh) that show up on systems
with large hugepages (e.g. 512MB) and when failures cause the test to wait
indefinitely.

On an aarch64 64k page kernel with 512MB hugepages, the test consistently
fails in write_to_hugetlbfs with ENOMEM and then hangs waiting for the
expected usage values. The root cause is that charge_reserved_hugetlb.sh
mounts hugetlbfs with a fixed size=256M, which is smaller than a single
hugepage, resulting in a mount with size=0 capacity.

In addition, write_to_hugetlbfs previously parsed -s via atoi() into an
int, which can overflow and print negative sizes.

Reproducer / environment:
  - Kernel: 6.12.0-xxx.el10.aarch64+64k
  - Hugepagesize: 524288 kB (512MB)
  - ./charge_reserved_hugetlb.sh -cgroup-v2
  - Observed mount: pagesize=512M,size=0 before this series

After applying the series, the test completes successfully on the above setup.

Li Wang (3):
  selftests/mm/write_to_hugetlbfs: parse -s with strtoull and use size_t
  selftests/mm/charge_reserved_hugetlb.sh: add waits with timeout helper
  selftests/mm/charge_reserved_hugetlb: fix hugetlbfs mount size for
    large hugepages

 .../selftests/mm/charge_reserved_hugetlb.sh   | 49 ++++++++++---------
 .../testing/selftests/mm/write_to_hugetlbfs.c | 19 +++++--
 2 files changed, 43 insertions(+), 25 deletions(-)

-- 
2.49.0


