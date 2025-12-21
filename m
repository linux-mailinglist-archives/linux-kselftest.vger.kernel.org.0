Return-Path: <linux-kselftest+bounces-47799-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 51845CD4017
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Dec 2025 13:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 36E09300647A
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Dec 2025 12:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3CB28468E;
	Sun, 21 Dec 2025 12:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D1oisUgH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65D2277035
	for <linux-kselftest@vger.kernel.org>; Sun, 21 Dec 2025 12:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766320017; cv=none; b=qNPYRd4OTiEN0GoBcnCft8lOSWVw2e9ystLB6dVEYfbgBly0NGEtvBvTizXHTE0hCukHUgSCvTiRf+/E0uMLq3bkI016HnpVclVUBR9UqYTQYOm/7V0dtuJ29QZqD1S1qnbWAnJMmByVkCebR6aLyFex0SSn+JVdSoDMDfS1Z4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766320017; c=relaxed/simple;
	bh=yEaoKw66qN9NsIxBN+HvU6x1mhh4PRbcMoN1eowIHyc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Ea91vnM9VSpO0I1Ol/OyI+AWjC1qqq4b2q2WbHCq8++FBMcCkylCsj/JW0U974Bi/NFIbcbfthTMD86IudA6TwgA/nUzx1TVwx/C5OyWpJdmUIGcHj162x/txkXSZ7og+miRPnqyNhB5rQcHzKQwhceb2gByePEF5RJ20tsEbeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D1oisUgH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766320014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wR6RJvO5q829q98KcHX2afv2FHKgdC2z2h5jm0IRqMc=;
	b=D1oisUgHRe1Avh2qPVV/NRIETTlmIgSzuCQzwnTnpxNdlXW0S7KU2tpucnIN+md1PJBkae
	X8AO/4vMAJhDE4L7Wj7bTZ1TNIzEVz2GVYRqcuI83itoJU9tpegf32+eZ9/BfS9H1ivoFf
	9FtaQucjGyZdqug8YK9tX6tHzgFoLVE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-s3nKjBC4P-a7eJnzjnbJqQ-1; Sun,
 21 Dec 2025 07:26:48 -0500
X-MC-Unique: s3nKjBC4P-a7eJnzjnbJqQ-1
X-Mimecast-MFC-AGG-ID: s3nKjBC4P-a7eJnzjnbJqQ_1766320007
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F11461956080;
	Sun, 21 Dec 2025 12:26:46 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD36D19560B4;
	Sun, 21 Dec 2025 12:26:44 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: akpm@linux-foundation.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3 0/3] selftests/mm: hugetlb cgroup charging: robustness fixes
Date: Sun, 21 Dec 2025 20:26:36 +0800
Message-ID: <20251221122639.3168038-1-liwang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Changes in v3:
  - 1/3: no changes.
  - 2/3: reorder with 3/3, and drop the 'size=' mount args.
  - 3/3: add $path check, improve varible declaration, sleep 1s for 60 tryies.

Changes in v2:
  - 1/3: Parse -s using sscanf("%zu", ...) instead of strtoull().
  - 2/3: Fix typo in charge_reserved_hugetlb.sh ("reseravation" -> "reservation").
  - 3/3: No changes.

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
  selftests/mm/write_to_hugetlbfs: parse -s as size_t
  selftests/mm/charge_reserved_hugetlb: drop mount size for hugetlbfs
  selftests/mm/charge_reserved_hugetlb.sh: add waits with timeout helper

 .../selftests/mm/charge_reserved_hugetlb.sh   | 55 +++++++++++--------
 .../testing/selftests/mm/write_to_hugetlbfs.c |  9 ++-
 2 files changed, 38 insertions(+), 26 deletions(-)

-- 
2.49.0


